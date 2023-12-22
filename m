Return-Path: <linux-kernel+bounces-9271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E888D81C333
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659481F25491
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107AD10EA;
	Fri, 22 Dec 2023 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVJUKGDk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559533C7;
	Fri, 22 Dec 2023 02:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87B4C433C8;
	Fri, 22 Dec 2023 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703213615;
	bh=dWNX7MFomMQplvm3VeZFHQT+MP0m2AD4yNjXG8FPkgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dVJUKGDkzYye4/IX352Zyd6kuISH2bBA65RpUjCMGPTmHJZZYS+zxxZSdVX+Yx+WS
	 jmdg6YL5pFwtQS+cKM8/qry5WloriYdQjRtG0HQC9i/CsvnoX/AIHBfEv74z+Ggyix
	 kE3LCa/2DM1HqCPHOCnIklDy+k8neesOOwwCcAuaOWURlnz6Pg3Bj6g8Q8uAh/+0jY
	 RMs+j5dsCw45zT8B6kWyAMcuaPVd5Q4O2f1xWsYG4No5VHtkAIyBl+fLOrXupMmX+e
	 fRZjMjthcMaDB1hX/IO6bKtMBOiDSKSybIu677AsyLg4ttYOREONNqJl7C4jxOqfiR
	 GxdgkM/b4cqmw==
Date: Fri, 22 Dec 2023 11:53:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Dongliang Cui <cuidongliang390@gmail.com>,
 Hongyu Jin <hongyu.jin@unisoc.com>
Subject: Re: [PATCH v2] eventfs: Fix file and directory uid and gid
 ownership
Message-Id: <20231222115331.3c01acf361e789f00bb66030@kernel.org>
In-Reply-To: <20231221190757.7eddbca9@gandalf.local.home>
References: <20231221190757.7eddbca9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 19:07:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> It was reported that when mounting the tracefs file system with a gid
> other than root, the ownership did not carry down to the eventfs directory
> due to the dynamic nature of it.
> 
> A fix was done to solve this, but it had two issues.
> 
> (a) if the attr passed into update_inode_attr() was NULL, it didn't do
>     anything. This is true for files that have not had a chown or chgrp
>     done to itself or any of its sibling files, as the attr is allocated
>     for all children when any one needs it.
> 
>  # umount /sys/kernel/tracing
>  # mount -o rw,seclabel,relatime,gid=1000 -t tracefs nodev /mnt
> 
>  # ls -ld /mnt/events/sched
> drwxr-xr-x 28 root rostedt 0 Dec 21 13:12 /mnt/events/sched/
> 
>  # ls -ld /mnt/events/sched/sched_switch
> drwxr-xr-x 2 root rostedt 0 Dec 21 13:12 /mnt/events/sched/sched_switch/
> 
> But when checking the files:
> 
>  # ls -l /mnt/events/sched/sched_switch
> total 0
> -rw-r----- 1 root root 0 Dec 21 13:12 enable
> -rw-r----- 1 root root 0 Dec 21 13:12 filter
> -r--r----- 1 root root 0 Dec 21 13:12 format
> -r--r----- 1 root root 0 Dec 21 13:12 hist
> -r--r----- 1 root root 0 Dec 21 13:12 id
> -rw-r----- 1 root root 0 Dec 21 13:12 trigger
> 
> (b) When the attr does not denote the UID or GID, it defaulted to using
>     the parent uid or gid. This is incorrect as changing the parent
>     uid or gid will automatically change all its children.
> 
>  # chgrp tracing /mnt/events/timer
> 
>  # ls -ld /mnt/events/timer
> drwxr-xr-x 2 root tracing 0 Dec 21 14:34 /mnt/events/timer
> 
>  # ls -l /mnt/events/timer
> total 0
> -rw-r----- 1 root root    0 Dec 21 14:35 enable
> -rw-r----- 1 root root    0 Dec 21 14:35 filter
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 hrtimer_cancel
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 hrtimer_expire_entry
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 hrtimer_expire_exit
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 hrtimer_init
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 hrtimer_start
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 itimer_expire
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 itimer_state
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 tick_stop
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 timer_cancel
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 timer_expire_entry
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 timer_expire_exit
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 timer_init
> drwxr-xr-x 2 root tracing 0 Dec 21 14:35 timer_start
> 
> At first it was thought that this could be easily fixed by just making the
> default ownership of the superblock when it was mounted. But this does not
> handle the case of:
> 
>  # chgrp tracing instances
>  # mkdir instances/foo
> 
> If the superblock was used, then the group ownership would be that of what
> it was when it was mounted, when it should instead be "tracing".
> 
> Instead, set a flag for the top level eventfs directory ("events") to flag
> which eventfs_inode belongs to it.
> 
> Since the "events" directory's dentry and inode are never freed, it does
> not need to use its attr field to restore its mode and ownership. Use the
> this eventfs_inode's attr as the default ownership for all the files and
> directories underneath it.
> 
> When the events eventfs_inode is created, it sets its ownership to its
> parent uid and gid. As the events directory is created at boot up before
> it gets mounted, this will always be uid=0 and gid=0. If it's created via
> an instance, then it will take the ownership of the instance directory.
> 
> When the file system is mounted, it will update all the gids if one is
> specified. This will have a callback to update the events evenfs_inode's
> default entries.
> 
> When a file or directory is created under the events directory, it will
> walk the ei->dentry parents until it finds the evenfs_inode that belongs
> to the events directory to retrieve the default uid and gid values.
> 
> Link: https://lore.kernel.org/all/CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com/
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: stable@vger.kernel.org
> Fixes: 0dfc852b6fe3 ("eventfs: Have event files and directories default to parent uid and gid")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231221173812.51fe6113@gandalf.local.home
> 
> - While writing kselftests to test ownership, I found a bug. The remount
>   option allows for an update of the gid. If it is specified, then all
>   dentries are traversed in tracefs and eventfs and the gid is updated.
> 
>   The bug is that a eventfs that does not have a dentry, but had its gid
>   updated, the old gid is still stored, and when the dentry is created, it
>   will use the stored gid.
> 
>   Instead, check all eventfs_inodes that do not have a dentry, and traverse
>   its children to make sure their gids are updated as well.
> 
>  fs/tracefs/event_inode.c | 105 +++++++++++++++++++++++++++++++++++----
>  fs/tracefs/inode.c       |   6 +++
>  fs/tracefs/internal.h    |   2 +
>  3 files changed, 103 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 2ccc849a5bda..6e005a83114f 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -113,7 +113,14 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	 * determined by the parent directory.
>  	 */
>  	if (dentry->d_inode->i_mode & S_IFDIR) {
> -		update_attr(&ei->attr, iattr);
> +		/*
> +		 * The events directory dentry is never freed, unless its
> +		 * part of an instance that is deleted. It's attr is the
> +		 * default for its child files and directories.
> +		 * Do not update it. It's not used for its own mode or ownership
> +		 */
> +		if (!ei->is_events)
> +			update_attr(&ei->attr, iattr);
>  
>  	} else {
>  		name = dentry->d_name.name;
> @@ -148,28 +155,93 @@ static const struct file_operations eventfs_file_operations = {
>  	.release	= eventfs_release,
>  };
>  
> +/* Return the evenfs_inode of the "events" directory */
> +static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
> +{
> +	struct eventfs_inode *ei;
> +
> +	mutex_lock(&eventfs_mutex);
> +	do {
> +		/* The parent always has an ei, except for events itself */
> +		ei = dentry->d_parent->d_fsdata;
> +
> +		/*
> +		 * If the ei is being freed, the ownership of the children
> +		 * doesn't matter.
> +		 */
> +		if (ei->is_freed) {
> +			ei = NULL;
> +			break;
> +		}
> +
> +		dentry = ei->dentry;
> +	} while (!ei->is_events);
> +	mutex_unlock(&eventfs_mutex);
> +
> +	return ei;
> +}
> +
>  static void update_inode_attr(struct dentry *dentry, struct inode *inode,
>  			      struct eventfs_attr *attr, umode_t mode)
>  {
> -	if (!attr) {
> -		inode->i_mode = mode;
> +	struct eventfs_inode *events_ei = eventfs_find_events(dentry);
> +
> +	if (!events_ei)
> +		return;
> +
> +	inode->i_mode = mode;
> +	inode->i_uid = events_ei->attr.uid;
> +	inode->i_gid = events_ei->attr.gid;
> +
> +	if (!attr)
>  		return;
> -	}
>  
>  	if (attr->mode & EVENTFS_SAVE_MODE)
>  		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
> -	else
> -		inode->i_mode = mode;
>  
>  	if (attr->mode & EVENTFS_SAVE_UID)
>  		inode->i_uid = attr->uid;
> -	else
> -		inode->i_uid = d_inode(dentry->d_parent)->i_uid;
>  
>  	if (attr->mode & EVENTFS_SAVE_GID)
>  		inode->i_gid = attr->gid;
> -	else
> -		inode->i_gid = d_inode(dentry->d_parent)->i_gid;
> +}
> +
> +static void update_gid(struct eventfs_inode *ei, kgid_t gid, int level)
> +{
> +	struct eventfs_inode *ei_child;
> +
> +	/* at most we have events/system/event */
> +	if (WARN_ON_ONCE(level > 3))
> +		return;
> +
> +	ei->attr.gid = gid;
> +
> +	if (ei->entry_attrs) {
> +		for (int i = 0; i < ei->nr_entries; i++) {
> +			ei->entry_attrs[i].gid = gid;
> +		}
> +	}
> +
> +	/*
> +	 * Only eventfs_inode with dentries are updated, make sure
> +	 * all eventfs_inodes are updated. If one of the children
> +	 * do not have a dentry, this function must traverse it.
> +	 */
> +	list_for_each_entry_srcu(ei_child, &ei->children, list,
> +				 srcu_read_lock_held(&eventfs_srcu)) {
> +		if (!ei_child->dentry)
> +			update_gid(ei_child, gid, level + 1);
> +	}
> +}
> +
> +void eventfs_update_gid(struct dentry *dentry, kgid_t gid)
> +{
> +	struct eventfs_inode *ei = dentry->d_fsdata;
> +	int idx;
> +
> +	idx = srcu_read_lock(&eventfs_srcu);
> +	update_gid(ei, gid, 0);
> +	srcu_read_unlock(&eventfs_srcu, idx);
>  }
>  
>  /**
> @@ -860,6 +932,8 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	struct eventfs_inode *ei;
>  	struct tracefs_inode *ti;
>  	struct inode *inode;
> +	kuid_t uid;
> +	kgid_t gid;
>  
>  	if (security_locked_down(LOCKDOWN_TRACEFS))
>  		return NULL;
> @@ -884,11 +958,20 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	ei->dentry = dentry;
>  	ei->entries = entries;
>  	ei->nr_entries = size;
> +	ei->is_events = 1;
>  	ei->data = data;
>  	ei->name = kstrdup_const(name, GFP_KERNEL);
>  	if (!ei->name)
>  		goto fail;
>  
> +	/* Save the ownership of this directory */
> +	uid = d_inode(dentry->d_parent)->i_uid;
> +	gid = d_inode(dentry->d_parent)->i_gid;
> +
> +	/* This is used as the default ownership of the files and directories */
> +	ei->attr.uid = uid;
> +	ei->attr.gid = gid;
> +
>  	INIT_LIST_HEAD(&ei->children);
>  	INIT_LIST_HEAD(&ei->list);
>  
> @@ -897,6 +980,8 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	ti->private = ei;
>  
>  	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	inode->i_uid = uid;
> +	inode->i_gid = gid;
>  	inode->i_op = &eventfs_root_dir_inode_operations;
>  	inode->i_fop = &eventfs_file_operations;
>  
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index ae648deed019..62524b20964e 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -210,6 +210,7 @@ static void set_gid(struct dentry *parent, kgid_t gid)
>  	next = this_parent->d_subdirs.next;
>  resume:
>  	while (next != &this_parent->d_subdirs) {
> +		struct tracefs_inode *ti;
>  		struct list_head *tmp = next;
>  		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
>  		next = tmp->next;
> @@ -218,6 +219,11 @@ static void set_gid(struct dentry *parent, kgid_t gid)
>  
>  		change_gid(dentry, gid);
>  
> +		/* If this is the events directory, update that too */
> +		ti = get_tracefs(dentry->d_inode);
> +		if (ti && (ti->flags & TRACEFS_EVENT_INODE))
> +			eventfs_update_gid(dentry, gid);
> +
>  		if (!list_empty(&dentry->d_subdirs)) {
>  			spin_unlock(&this_parent->d_lock);
>  			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index ccee18ca66c7..899e447778ac 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -62,6 +62,7 @@ struct eventfs_inode {
>  		struct rcu_head		rcu;
>  	};
>  	unsigned int			is_freed:1;
> +	unsigned int			is_events:1;
>  	unsigned int			nr_entries:31;
>  };
>  
> @@ -77,6 +78,7 @@ struct inode *tracefs_get_inode(struct super_block *sb);
>  struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
>  struct dentry *eventfs_failed_creating(struct dentry *dentry);
>  struct dentry *eventfs_end_creating(struct dentry *dentry);
> +void eventfs_update_gid(struct dentry *dentry, kgid_t gid);
>  void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
>  
>  #endif /* _TRACEFS_INTERNAL_H */
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

