Return-Path: <linux-kernel+bounces-45302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0679842E45
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B751281C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C471B48;
	Tue, 30 Jan 2024 20:55:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1887E5B1F6;
	Tue, 30 Jan 2024 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648139; cv=none; b=MJ/CRJIE4IDgjmxoIj5US7piidrG4bnfkJT9cDjsdC2NsVabhtMUtdRM/oaht5cB2twpRmZSHaca7YFs6vEBAwup1HoFlG9GO16rdNzkmVdk8OZDhX3l4vv/0NNp9iUX8Ly0+Et9diol31V+CbgbD/s2WyiQiSI6WiE5+6ZeIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648139; c=relaxed/simple;
	bh=HxYKHoYi8jbrtfFbIjWPfldYQ7Hbb74CixrX76m43b0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI1fjMbwclm0x+oFga+QrdT7AJlyraXPz4vCG5hsH3Pi3AmIywAKQ19M43tz7FKcD0KKZ6xiafTB+ZLQeeouqWfCc6K3+Qx4fOoo47SYJfZ71t/tVAfURr7fl95GZfuhjZx/9Mo7jvdl5Mup8kCe8VCRArFZYKD6xCMmPjf6gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE75C433C7;
	Tue, 30 Jan 2024 20:55:38 +0000 (UTC)
Date: Tue, 30 Jan 2024 15:55:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240130155550.4881d558@gandalf.local.home>
In-Reply-To: <20240130190355.11486-5-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:03:54 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> -static void free_ei(struct eventfs_inode *ei)
> +static inline struct eventfs_inode *alloc_ei(const char *name)
>  {
> -	kfree_const(ei->name);
> -	kfree(ei->d_children);
> -	kfree(ei->entry_attrs);
> -	kfree(ei);
> +	int namesize = strlen(name) + 1;
> +	struct eventfs_inode *ei = kzalloc(sizeof(*ei) + namesize, GFP_KERNEL);
> +
> +	if (ei) {
> +		memcpy((char *)ei->name, name, namesize);
> +		kref_init(&ei->kref);
> +	}

I'm going to be putting back the ei->name pointer as the above actually
adds more memory usage. The reason being is that all static trace events
(not kprobes or other dynamic events) are created with the TRACE_EVENT()
macro that points to a constant name. Passing in a const to kstrdup_const()
checks if the name passed in is a constant or not. If it is, it doesn't
allocate the name and just passes back the pointer.

Removing the pointer to "name" removed 8 bytes on 64 bit machines from the
eventfs_inode structure, but added strlen(name)+1 bytes to it, where the
majority of trace event names are greater than 8 bytes, and are constant
strings.

Another reason for converting back to the way it was is I have moving the
ei allocation to a slab on my TODO list.

-- Steve



> +	return ei;
>  }
>  


> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 8f38740bfb5b..72db3bdc4dfb 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -34,8 +34,7 @@ struct eventfs_attr {
>   * @entries:	the array of entries representing the files in the directory
>   * @name:	the name of the directory to create
>   * @children:	link list into the child eventfs_inode
> - * @dentry:     the dentry of the directory
> - * @d_children: The array of dentries to represent the files when created
> + * @events_dir: the dentry of the events directory
>   * @entry_attrs: Saved mode and ownership of the @d_children
>   * @attr:	Saved mode and ownership of eventfs_inode itself
>   * @data:	The private data to pass to the callbacks
> @@ -44,12 +43,11 @@ struct eventfs_attr {
>   * @nr_entries: The number of items in @entries
>   */
>  struct eventfs_inode {
> +	struct kref			kref;
>  	struct list_head		list;
>  	const struct eventfs_entry	*entries;
> -	const char			*name;
>  	struct list_head		children;
> -	struct dentry			*dentry; /* Check is_freed to access */
> -	struct dentry			**d_children;
> +	struct dentry			*events_dir;
>  	struct eventfs_attr		*entry_attrs;
>  	struct eventfs_attr		attr;
>  	void				*data;
> @@ -66,6 +64,7 @@ struct eventfs_inode {
>  		struct llist_node	llist;
>  		struct rcu_head		rcu;
>  	};
> +	const char name[];
>  };
>  
>  static inline struct tracefs_inode *get_tracefs(const struct inode *inode)


