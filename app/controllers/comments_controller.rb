class CommentsController < ApplicationController
  before_action :set_link, only: [:edit, :destroy, :update, :create]
  before_action :set_comment, only: [:edit, :destroy, :update]
  before_action :authorize_user_by_comment, only: [:edit, :destroy, :update]
  def edit
  end

  def destroy
    @comment.destroy
    redirect_to link_comments_path(link_id: @comment.link_id)
  end

  def update
    @comment.update(comment_params)
    redirect_to link_comments_path(link_id: @comment.link_id)
  end

  def create
    @comment = current_user.comments.create!(comment_params)
    redirect_to link_path(@link.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :link_id, :user_id)
  end

  def set_link
    @link = Link.find(params[:link_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user_by_comment
    redirect_to(root_path, notice: "You have to be logged in to do that!" ) unless @comment.user == current_user
  end
end
