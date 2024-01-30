Return-Path: <linux-kernel+bounces-45218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C10842D41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029E71C23AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35747B3FF;
	Tue, 30 Jan 2024 19:47:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C246995A;
	Tue, 30 Jan 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644071; cv=none; b=bOObqZuOYRv1uC73wvt2xMm7BUHjyooko4wZAUyx7TOQxb3Fw8Veuinx+y2EbWP7g30b5ZBF+U8fQlpazs3c+VXX0fWWk5KKwchB5T/AiNgTgalnqy9+7ZdssgbQaVMeSnnuQOj5ACeB7SnZCgLfo4PSy0L+5Bu2aLsZP7m3biU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644071; c=relaxed/simple;
	bh=uYbyyB7NSUD16AjQe1k8YkbUUi3q1rSgnjzzrQ6Kg8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOnr2C90nxT/VZS5jY7cucv0wpQFNKOOyNe/gcijT2kekA6QS9UWZeIcGUrVMB31T4qW3TR546krHuL4m3HC6Hyb/jrk4QCW4xH+i4fLBGMR4qkfL7Zo9DapBuYCNdqgV/+eV0bxxD+Oifdtiyg/bW2kSWNisMh54hBQ8ABeEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EE9C433C7;
	Tue, 30 Jan 2024 19:47:50 +0000 (UTC)
Date: Tue, 30 Jan 2024 14:48:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] eventfsfs: initialize the tracefs inode properly
Message-ID: <20240130144802.6e1a8cf8@gandalf.local.home>
In-Reply-To: <20240130190355.11486-2-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-2-torvalds@linux-foundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:03:51 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The tracefs-specific fields in the inode were not initialized before the
> inode was exposed to others through the dentry with 'd_instantiate()'.
> 
> And the ->flags file was initialized incorrectly with a '|=', when the
> old value was stale.  It should have just been a straight assignment.

The ti is allocated from fs/tracefs/inode.c that has:

static struct inode *tracefs_alloc_inode(struct super_block *sb)
{
	struct tracefs_inode *ti;

	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
	if (!ti)
		return NULL;

	ti->flags = 0;

	return &ti->vfs_inode;
}

Shouldn't that make it valid?

Granted, the eventfs inodes don't have any of the tracefs inode flags set.
But I purposely made he ti->flags initialized to zero.

Is this update really necessary?

Or do I need to make sure that the iput() clears it?

The flags are used by tracefs, so I want to know if there's not a bug there.

-- Steve


> 
> Move the field initializations up to before the d_instantiate, and fix
> the use of uninitialized data.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  fs/tracefs/event_inode.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 2d128bedd654..c0d977e6c0f2 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -328,7 +328,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  	inode->i_ino = EVENTFS_FILE_INODE_INO;
>  
>  	ti = get_tracefs(inode);
> -	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->flags = TRACEFS_EVENT_INODE;
> +	ti->private = NULL;			// Directories have 'ei', files not
> +
>  	d_instantiate(dentry, inode);
>  	fsnotify_create(dentry->d_parent->d_inode, dentry);
>  	return eventfs_end_creating(dentry);
> @@ -367,7 +369,8 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
>  	inode->i_ino = eventfs_dir_ino(ei);
>  
>  	ti = get_tracefs(inode);
> -	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->flags = TRACEFS_EVENT_INODE;
> +	ti->private = ei;
>  
>  	inc_nlink(inode);
>  	d_instantiate(dentry, inode);
> @@ -513,7 +516,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
>  static void eventfs_post_create_dir(struct eventfs_inode *ei)
>  {
>  	struct eventfs_inode *ei_child;
> -	struct tracefs_inode *ti;
>  
>  	lockdep_assert_held(&eventfs_mutex);
>  
> @@ -523,9 +525,6 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>  				 srcu_read_lock_held(&eventfs_srcu)) {
>  		ei_child->d_parent = ei->dentry;
>  	}
> -
> -	ti = get_tracefs(ei->dentry->d_inode);
> -	ti->private = ei;
>  }
>  
>  /**
> @@ -943,7 +942,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	INIT_LIST_HEAD(&ei->list);
>  
>  	ti = get_tracefs(inode);
> -	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
> +	ti->flags = TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
>  	ti->private = ei;
>  
>  	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;


