class PostsController < ApplicationController

  http_basic_authenticate_with name: 'wes', password: 'password',
  except: [:index, :show]
  before_action :find_post, only: [:edit, :update, :show, :delete]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Successfully created post!"
      redirect_to @post
    else
      flash[:alert] = "Error creating new post!"
      render 'new'
    end
  end


  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to @post
    else
      flash[:alert] = "Error updating post!"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to '/posts'
    else
      flash[:alert] = "Error updating post!"
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end

