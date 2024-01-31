Return-Path: <linux-kernel+bounces-46745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB223844382
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5088E1F2221A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A312A165;
	Wed, 31 Jan 2024 15:58:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD312A148;
	Wed, 31 Jan 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716715; cv=none; b=EIlAA7nYVP1vg6trI+zVYxuKYJQi85BId9I5JMU3Nh0n3dV2h6Wvg9eNUckaovjFC66edmyakV2F1iQc1Mf0sglL9TiVHLwL5kAXdU0mTeGeW39t8NVoRcc3vDgiY3U3zQxAoUkyfhKiENlUCwd5Nilw2JfMlZSudtHIKvP0/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716715; c=relaxed/simple;
	bh=J1obrCIF5WLnpH/9mE8Li546TKWFySyL+UdQR2Lti8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmeWJXi3dDhz7QaAq2eK2kmRBPRQPNDGuod/U5FFvzTbnj6EyVqx1GqpjnXr3XJA0yxFD39rAijjZJnCY+EGuv3C+OF6evK0OCHAjEEWDCEuR409py+ecnJEfQEJageYGgpduYF4jYR9ho71I1YQd0r43cKqQ120E3WMANDTP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F52C433F1;
	Wed, 31 Jan 2024 15:58:33 +0000 (UTC)
Date: Wed, 31 Jan 2024 10:58:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240131105847.3e9afcb8@gandalf.local.home>
In-Reply-To: <CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<20240130132319.022817e8@gandalf.local.home>
	<CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
	<20240130143734.31b9b3f1@gandalf.local.home>
	<CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 11:54:56 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> If you do run the full tracefs tests on the whole series, and there
> are no other major problems, I'll happily take it all for 6.8. And
> yes, even mark it for stable. I think the other bugs are much harder
> to hit, but I do think they exist. And code deletion is always good.
> 
> So give it the full test attention, and *if* it all still looks good
> and there are no new subtle issues that crop up, let's just put this
> saga behind us asap.

BTW, I ran my full test suite on your patches with the below updates and it
all passed. Note, I did not run the "bisectable" portion of my test. That
is, the part that runs tests on each patch in the series. Because I know
that fails. I just ran the tests on the last applied patch.

I can break up and clean up the patches so that they are bisectable, and if
that passes the bisectable portion of my tests, I can still send them to
you for 6.8. I think this does fix a lot of hidden bugs, and would like all
this to go back to 6.6 when the eventfs was first introduced.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index acdc797bd9c0..31cbe38739fa 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -74,7 +74,8 @@ static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
 	kfree(ei->entry_attrs);
-	kfree(ei);
+	kfree_const(ei->name);
+	kfree_rcu(ei, rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
@@ -348,8 +349,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 	inode->i_ino = EVENTFS_FILE_INODE_INO;
 
 	ti = get_tracefs(inode);
-	ti->flags = TRACEFS_EVENT_INODE;
-	ti->private = NULL;			// Directories have 'ei', files not
+	ti->flags |= TRACEFS_EVENT_INODE;
 
 	// Files have their parent's ei as their fsdata
 	dentry->d_fsdata = get_ei(parent_ei);
@@ -388,7 +388,8 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	inode->i_ino = eventfs_dir_ino(ei);
 
 	ti = get_tracefs(inode);
-	ti->flags = TRACEFS_EVENT_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE;
+	/* Only directories have ti->private set to an ei, not files */
 	ti->private = ei;
 
 	dentry->d_fsdata = get_ei(ei);
@@ -402,17 +403,20 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 static inline struct eventfs_inode *alloc_ei(const char *name)
 {
-	int namesize = strlen(name) + 1;
-	struct eventfs_inode *ei = kzalloc(sizeof(*ei) + namesize, GFP_KERNEL);
+	struct eventfs_inode *ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 
-	if (ei) {
-		memcpy((char *)ei->name, name, namesize);
-		kref_init(&ei->kref);
+	if (!ei)
+		return NULL;
+
+	ei->name = kstrdup_const(name, GFP_KERNEL);
+	if (!ei->name) {
+		kfree(ei);
+		return NULL;
 	}
+	kref_init(&ei->kref);
 	return ei;
 }
 
-
 /**
  * eventfs_d_release - dentry is going away
  * @dentry: dentry which has the reference to remove.
@@ -750,7 +754,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	INIT_LIST_HEAD(&ei->list);
 
 	ti = get_tracefs(inode);
-	ti->flags = TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -847,5 +851,6 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	 * sticks around while the other ei->dentry are created
 	 * and destroyed dynamically.
 	 */
+	d_invalidate(dentry);
 	dput(dentry);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 64122787e5d0..cf90ea86baf8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -38,8 +38,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	if (!ti)
 		return NULL;
 
-	ti->flags = 0;
-
 	return &ti->vfs_inode;
 }
 
@@ -506,75 +504,6 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
-/**
- * eventfs_start_creating - start the process of creating a dentry
- * @name: Name of the file created for the dentry
- * @parent: The parent dentry where this dentry will be created
- *
- * This is a simple helper function for the dynamically created eventfs
- * files. When the directory of the eventfs files are accessed, their
- * dentries are created on the fly. This function is used to start that
- * process.
- */
-struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
-{
-	struct dentry *dentry;
-	int error;
-
-	/* Must always have a parent. */
-	if (WARN_ON_ONCE(!parent))
-		return ERR_PTR(-EINVAL);
-
-	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
-			      &tracefs_mount_count);
-	if (error)
-		return ERR_PTR(error);
-
-	if (unlikely(IS_DEADDIR(parent->d_inode)))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_one_len(name, parent, strlen(name));
-
-	if (!IS_ERR(dentry) && dentry->d_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry))
-		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-
-	return dentry;
-}
-
-/**
- * eventfs_failed_creating - clean up a failed eventfs dentry creation
- * @dentry: The dentry to clean up
- *
- * If after calling eventfs_start_creating(), a failure is detected, the
- * resources created by eventfs_start_creating() needs to be cleaned up. In
- * that case, this function should be called to perform that clean up.
- */
-struct dentry *eventfs_failed_creating(struct dentry *dentry)
-{
-	dput(dentry);
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-	return NULL;
-}
-
-/**
- * eventfs_end_creating - Finish the process of creating a eventfs dentry
- * @dentry: The dentry that has successfully been created.
- *
- * This function is currently just a place holder to match
- * eventfs_start_creating(). In case any synchronization needs to be added,
- * this function will be used to implement that without having to modify
- * the callers of eventfs_start_creating().
- */
-struct dentry *eventfs_end_creating(struct dentry *dentry)
-{
-	return dentry;
-}
-
 /* Find the inode that this will use for default */
 static struct inode *instance_inode(struct dentry *parent, struct inode *inode)
 {
@@ -788,6 +717,7 @@ static void init_once(void *foo)
 {
 	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
 
+	memset(ti, 0, sizeof(*ti));
 	inode_init_once(&ti->vfs_inode);
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index d4194466b643..ca1ccc86986f 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -46,6 +46,7 @@ struct eventfs_inode {
 	struct kref			kref;
 	struct list_head		list;
 	const struct eventfs_entry	*entries;
+	const char			*name;
 	struct list_head		children;
 	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
@@ -64,7 +65,6 @@ struct eventfs_inode {
 		struct llist_node	llist;
 		struct rcu_head		rcu;
 	};
-	const char name[];
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
@@ -76,9 +76,6 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
-struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
-struct dentry *eventfs_failed_creating(struct dentry *dentry);
-struct dentry *eventfs_end_creating(struct dentry *dentry);
 
 void eventfs_d_release(struct dentry *dentry);
 

