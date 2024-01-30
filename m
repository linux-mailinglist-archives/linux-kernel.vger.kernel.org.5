Return-Path: <linux-kernel+bounces-44979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64658429EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B331C212F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9A1292C9;
	Tue, 30 Jan 2024 16:49:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80460128382;
	Tue, 30 Jan 2024 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633377; cv=none; b=UiiGxceqnwGF3nzv18etui3/6irTsKkw6hv96hPwWbMGDRylL37i0dShDw6jh6JkkNAwfyGVEG88O6y5ZVY0MiycKnZ9sqMRSfV8eK/qoMCzbYxoaac6s7L4PnuGFoREh8FMTCF8chJtRSAC3YiSBZOtOA5sIrdAmbnGIuwroZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633377; c=relaxed/simple;
	bh=oDQFVuazwccw0VobvtJ3B79vpCwY8c8I+xjm3GLltnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KholdVGWrUTg7vTfNMWzwARU8Mud/SKqhkiPOQlikGhoJTvUuq70fjxtC52x8DOm3qM7MK4cBy0pJf/gxsnYwtXP6j3eI3RQe9rWzXzxTlvNfXgDX8FML14btydloDDIx+TvQz6jBIfjyfmzoHC5EdEE9Kbw7FKuPE+wXzlR2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41D6C43399;
	Tue, 30 Jan 2024 16:49:35 +0000 (UTC)
Date: Tue, 30 Jan 2024 11:49:47 -0500
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
Message-ID: <20240130114947.5bc856b0@gandalf.local.home>
In-Reply-To: <20240130093942.56206ff1@gandalf.local.home>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
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
	<CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
	<CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
	<20240130093942.56206ff1@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 09:39:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I may try something that will still let me get rid of the ei->dentry.

This appears to work, but like always, I may have missed something. I need
to add debugging (printks) to make sure the that I don't leave any dangling
dentries around (dget without a dput).

Here's what I did:

- Removed the ei->dentry that you loved so much

- Removed the ei->d_children that you shared as much love for.

- Removed SRCU. All accesses are under the eventfs_mutex
  I need to add comments that the callbacks need to be aware of this.
  Currently, the callbacks do not take any other locks. I may comment
  that they should never take a lock.

- Added the kref that you recommended

- Created a eventfs_root_inode that has the structure of:

  struct eventfs_root_inode {
       struct eventfs_inode    ei;
       struct dentry           *root_dentry;
  };

  The "events" directory is the only directory that allocates this.
  It is required that its ei->is_events is set, and no other ei has that
  set. This will hold the only non-dynamic dentry.

- I added "parent" to the eventfs_inode that points to the parent
  eventfs_inode.

- On removal, I got rid of the SRCU callback and the work queue.
  Instead, I find the dentry of the current eventfs_inode that is being
  deleted by walking the ei->parent until I find the events inode that has
  a dentry. I then use that to do a lookup walking back down to the
  eventfs_inode I want to delete. This gives me the dentry that I can call
  d_invalidate() on.

This all works with light testing. I'm sure I did something wrong, but
hopefully this is more inline to what you are looking for.

This patch is on top of your last patch series.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ad11063bdd53..49d4630d5d70 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -24,17 +24,24 @@
 #include <linux/delay.h>
 #include "internal.h"
 
-/*
- * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
- * to the ei->dentry must be done under this mutex and after checking
- * if ei->is_freed is not set. When ei->is_freed is set, the dentry
- * is on its way to being freed after the last dput() is made on it.
- */
+/* eventfs_mutex protects ei->is_freed and the ei->ref counting. */
 static DEFINE_MUTEX(eventfs_mutex);
 
 /* Choose something "unique" ;-) */
 #define EVENTFS_FILE_INODE_INO		0x12c4e37
 
+/* Used only by the "events" directory */
+struct eventfs_root_inode {
+	struct eventfs_inode	ei;
+	struct dentry		*root_dentry;
+};
+
+static struct eventfs_root_inode *get_root_inode(struct eventfs_inode *ei)
+{
+	WARN_ON_ONCE(!ei->is_events);
+	return container_of(ei, struct eventfs_inode, ei);
+}
+
 /* Just try to make something consistent and unique */
 static int eventfs_dir_ino(struct eventfs_inode *ei)
 {
@@ -44,14 +51,6 @@ static int eventfs_dir_ino(struct eventfs_inode *ei)
 	return ei->ino;
 }
 
-/*
- * The eventfs_inode (ei) itself is protected by SRCU. It is released from
- * its parent's list and will have is_freed set (under eventfs_mutex).
- * After the SRCU grace period is over and the last dput() is called
- * the ei is freed.
- */
-DEFINE_STATIC_SRCU(eventfs_srcu);
-
 /* Mode is unsigned short, use the upper bits for flags */
 enum {
 	EVENTFS_SAVE_MODE	= BIT(16),
@@ -360,7 +359,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	ti->private = ei;
 
 	dentry->d_fsdata = ei;
-        ei->dentry = dentry;	// Remove me!
+	kref_get(&ei->kref);
 
 	inc_nlink(inode);
 	d_add(dentry, inode);
@@ -371,10 +370,30 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 static void free_ei(struct eventfs_inode *ei)
 {
+	struct eventfs_root_inode *rei;
+
 	kfree_const(ei->name);
-	kfree(ei->d_children);
 	kfree(ei->entry_attrs);
-	kfree(ei);
+
+	if (ei->is_events) {
+		rei = get_root_inode(ei);
+		kfree(rei);
+	} else {
+		kfree(ei);
+	}
+}
+
+static void kref_ei_release(struct kref *kref)
+{
+	struct eventfs_inode *ei = container_of(kref, struct eventfs_inode, kref);
+	WARN_ON_ONCE(!ei->is_freed);
+	free_ei(ei);
+}
+
+
+static void eventfs_inode_put(struct eventfs_inode *ei)
+{
+	kref_put(&ei->kref, kref_ei_release);
 }
 
 /**
@@ -387,7 +406,6 @@ static void free_ei(struct eventfs_inode *ei)
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
-	int i;
 
 	mutex_lock(&eventfs_mutex);
 
@@ -395,20 +413,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 	if (!ei)
 		goto out;
 
-	/* This could belong to one of the files of the ei */
-	if (ei->dentry != dentry) {
-		for (i = 0; i < ei->nr_entries; i++) {
-			if (ei->d_children[i] == dentry)
-				break;
-		}
-		if (WARN_ON_ONCE(i == ei->nr_entries))
-			goto out;
-		ei->d_children[i] = NULL;
-	} else if (ei->is_freed) {
-		free_ei(ei);
-	} else {
-		ei->dentry = NULL;
-	}
+	eventfs_inode_put(ei);
 
 	dentry->d_fsdata = NULL;
  out:
@@ -435,16 +440,14 @@ lookup_file_dentry(struct dentry *dentry,
 		   const struct file_operations *fops)
 {
 	struct eventfs_attr *attr = NULL;
-	struct dentry **e_dentry = &ei->d_children[idx];
 
 	if (ei->entry_attrs)
 		attr = &ei->entry_attrs[idx];
 
 	dentry->d_fsdata = ei;		// NOTE: ei of _parent_
+	kref_get(&ei->kref);
 	lookup_file(dentry, mode, attr, data, fops);
 
-	*e_dentry = dentry;	// Remove me
-
 	return dentry;
 }
 
@@ -465,6 +468,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
+	struct dentry *result = NULL;
 	const char *name = dentry->d_name.name;
 
 	ti = get_tracefs(dir);
@@ -505,11 +509,10 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 
  enoent:
 	/* Nothing found? */
-	d_add(dentry, NULL);
-
+	result = ERR_PTR(-ENOENT);
  out:
 	mutex_unlock(&eventfs_mutex);
-	return NULL;
+	return result;
 }
 
 /*
@@ -525,7 +528,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	struct eventfs_inode *ei;
 	const char *name;
 	umode_t mode;
-	int idx;
 	int ret = -EINVAL;
 	int ino;
 	int i, r, c;
@@ -539,15 +541,9 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 
 	c = ctx->pos - 2;
 
-	idx = srcu_read_lock(&eventfs_srcu);
-
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
 	if (ei && ei->is_freed)
-		ei = NULL;
-	mutex_unlock(&eventfs_mutex);
-
-	if (!ei)
 		goto out;
 
 	/*
@@ -563,14 +559,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		entry = &ei->entries[i];
 		name = entry->name;
 
-		mutex_lock(&eventfs_mutex);
 		/* If ei->is_freed then just bail here, nothing more to do */
 		if (ei->is_freed) {
 			mutex_unlock(&eventfs_mutex);
 			goto out;
 		}
 		r = entry->callback(name, &mode, &cdata, &fops);
-		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
 
@@ -583,8 +577,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	/* Subtract the skipped entries above */
 	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
 
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
+	list_for_each_entry(ei_child, &ei->children, list) {
 
 		if (c > 0) {
 			c--;
@@ -605,7 +598,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	}
 	ret = 1;
  out:
-	srcu_read_unlock(&eventfs_srcu, idx);
+	mutex_unlock(&eventfs_mutex);
 
 	return ret;
 
@@ -669,25 +662,17 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (size) {
-		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
-		if (!ei->d_children) {
-			kfree_const(ei->name);
-			kfree(ei);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
 	ei->entries = entries;
 	ei->nr_entries = size;
 	ei->data = data;
 	INIT_LIST_HEAD(&ei->children);
 	INIT_LIST_HEAD(&ei->list);
+	kref_init(&ei->kref);
 
 	mutex_lock(&eventfs_mutex);
 	if (!parent->is_freed) {
 		list_add_tail(&ei->list, &parent->children);
-		ei->d_parent = parent->dentry;
+		ei->parent = parent;
 	}
 	mutex_unlock(&eventfs_mutex);
 
@@ -716,6 +701,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 						int size, void *data)
 {
 	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_root_inode *rei;
 	struct eventfs_inode *ei;
 	struct tracefs_inode *ti;
 	struct inode *inode;
@@ -728,24 +714,21 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
-	if (!ei)
+	rei = kzalloc(sizeof(*rei), GFP_KERNEL);
+	if (!rei)
 		goto fail_ei;
 
+	ei = &rei->ei;
+	ei->is_events = 1;
+
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
 		goto fail;
 
-	if (size) {
-		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
-		if (!ei->d_children)
-			goto fail;
-	}
+	rei->root_dentry = dentry;
 
-	ei->dentry = dentry;
 	ei->entries = entries;
 	ei->nr_entries = size;
-	ei->is_events = 1;
 	ei->data = data;
 	ei->name = kstrdup_const(name, GFP_KERNEL);
 	if (!ei->name)
@@ -781,6 +764,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	inode->i_fop = &eventfs_file_operations;
 
 	dentry->d_fsdata = ei;
+	kref_init(&ei->kref);
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
@@ -792,83 +776,24 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	kfree(ei->d_children);
-	kfree(ei);
+	kfree(rei);
  fail_ei:
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
 
-static LLIST_HEAD(free_list);
-
-static void eventfs_workfn(struct work_struct *work)
-{
-        struct eventfs_inode *ei, *tmp;
-        struct llist_node *llnode;
-
-	llnode = llist_del_all(&free_list);
-        llist_for_each_entry_safe(ei, tmp, llnode, llist) {
-		/* This dput() matches the dget() from unhook_dentry() */
-		for (int i = 0; i < ei->nr_entries; i++) {
-			if (ei->d_children[i])
-				dput(ei->d_children[i]);
-		}
-		/* This should only get here if it had a dentry */
-		if (!WARN_ON_ONCE(!ei->dentry))
-			dput(ei->dentry);
-        }
-}
-
-static DECLARE_WORK(eventfs_work, eventfs_workfn);
-
-static void free_rcu_ei(struct rcu_head *head)
-{
-	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
-
-	if (ei->dentry) {
-		/* Do not free the ei until all references of dentry are gone */
-		if (llist_add(&ei->llist, &free_list))
-			queue_work(system_unbound_wq, &eventfs_work);
-		return;
-	}
-
-	/* If the ei doesn't have a dentry, neither should its children */
-	for (int i = 0; i < ei->nr_entries; i++) {
-		WARN_ON_ONCE(ei->d_children[i]);
-	}
-
-	free_ei(ei);
-}
-
-static void unhook_dentry(struct dentry *dentry)
-{
-	if (!dentry)
-		return;
-	/*
-	 * Need to add a reference to the dentry that is expected by
-	 * simple_recursive_removal(), which will include a dput().
-	 */
-	dget(dentry);
-
-	/*
-	 * Also add a reference for the dput() in eventfs_workfn().
-	 * That is required as that dput() will free the ei after
-	 * the SRCU grace period is over.
-	 */
-	dget(dentry);
-}
-
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
+ * @head: List head to add the ei's to remove
  * @level: prevent recursion from going more than 3 levels deep.
  *
  * This function recursively removes eventfs_inodes which
  * contains info of files and/or directories.
  */
-static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
+static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head, int level)
 {
-	struct eventfs_inode *ei_child;
+	struct eventfs_inode *ei_child, *tmp;
 
 	if (!ei)
 		return;
@@ -883,28 +808,67 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 		return;
 
 	/* search for nested folders or files */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 lockdep_is_held(&eventfs_mutex)) {
-		/* Children only have dentry if parent does */
-		WARN_ON_ONCE(ei_child->dentry && !ei->dentry);
-		eventfs_remove_rec(ei_child, level + 1);
+	list_for_each_entry_safe(ei_child, tmp, &ei->children, list) {
+		eventfs_remove_rec(ei_child, head, level + 1);
 	}
 
-
 	ei->is_freed = 1;
 
-	for (int i = 0; i < ei->nr_entries; i++) {
-		if (ei->d_children[i]) {
-			/* Children only have dentry if parent does */
-			WARN_ON_ONCE(!ei->dentry);
-			unhook_dentry(ei->d_children[i]);
-		}
+	list_del(&ei->list);
+	list_add(&ei->list, head);
+}
+
+static struct dentry *find_ei_dentry(struct eventfs_inode *ei, int level)
+{
+	struct dentry *d_parent;
+	struct dentry *dentry;
+	const char *name = ei->name;
+
+	/*
+	 * Check recursion depth. It should never be greater than 2;
+	 * 0 - events/
+	 * 1 - events/group/
+	 * 2 - events/group/event/
+	 */
+	if (WARN_ON_ONCE(level > 2))
+		return NULL;
+
+	/* Only the events directory has a dentry we can use */
+	if (ei->parent->is_events) {
+		struct eventfs_root_inode *rei;
+
+		rei = get_root_inode(ei);
+		d_parent = rei->root_dentry;
+		dget(d_parent);
+	} else {
+		d_parent = find_ei_dentry(ei->parent, level + 1);
+		if (!d_parent)
+			return NULL;
 	}
 
-	unhook_dentry(ei->dentry);
+	inode_lock(d_inode(d_parent));
+	dentry = lookup_one_len(name, d_parent, strlen(name));
+	inode_unlock(d_inode(d_parent));
+	dput(d_parent);
+
+	if (IS_ERR(dentry))
+		dentry = NULL;
+	return dentry;
+}
+
+static void remove_dir(struct eventfs_inode *ei)
+{
+	struct eventfs_inode *tmp;
+	LIST_HEAD(head);
 
-	list_del_rcu(&ei->list);
-	call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
+	mutex_lock(&eventfs_mutex);
+	eventfs_remove_rec(ei, &head, 0);
+	mutex_unlock(&eventfs_mutex);
+
+	list_for_each_entry_safe(ei, tmp, &head, list) {
+		list_del(&ei->list);
+		eventfs_inode_put(ei);
+	}
 }
 
 /**
@@ -920,17 +884,14 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 	if (!ei)
 		return;
 
-	mutex_lock(&eventfs_mutex);
-	dentry = ei->dentry;
-	eventfs_remove_rec(ei, 0);
-	mutex_unlock(&eventfs_mutex);
+	dentry = find_ei_dentry(ei, 0);
 
-	/*
-	 * If any of the ei children has a dentry, then the ei itself
-	 * must have a dentry.
-	 */
-	if (dentry)
-		simple_recursive_removal(dentry, NULL);
+	remove_dir(ei);
+
+	if (dentry) {
+		d_invalidate(dentry);
+		dput(dentry);
+	}
 }
 
 /**
@@ -941,10 +902,13 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
  */
 void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
+	struct eventfs_root_inode *rei;
 	struct dentry *dentry;
 
-	dentry = ei->dentry;
-	eventfs_remove_dir(ei);
+	rei = get_root_inode(ei);
+	dentry = rei->root_dentry;
+
+	remove_dir(ei);
 
 	/*
 	 * Matches the dget() done by tracefs_start_creating()
@@ -953,5 +917,8 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	 * sticks around while the other ei->dentry are created
 	 * and destroyed dynamically.
 	 */
+	simple_recursive_removal(dentry, NULL);
+
+	eventfs_inode_put(ei);
 	dput(dentry);
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 91c2bf0b91d9..2af78fd95c93 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -34,9 +34,7 @@ struct eventfs_attr {
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
  * @children:	link list into the child eventfs_inode
- * @dentry:     the dentry of the directory
  * @d_parent:   pointer to the parent's dentry
- * @d_children: The array of dentries to represent the files when created
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
@@ -49,12 +47,11 @@ struct eventfs_inode {
 	const struct eventfs_entry	*entries;
 	const char			*name;
 	struct list_head		children;
-	struct dentry			*dentry; /* Check is_freed to access */
-	struct dentry			*d_parent;
-	struct dentry			**d_children;
+	struct eventfs_inode		*parent;
 	struct eventfs_attr		*entry_attrs;
 	struct eventfs_attr		attr;
 	void				*data;
+	struct kref			kref;
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
 	unsigned int			nr_entries:30;


