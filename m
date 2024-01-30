Return-Path: <linux-kernel+bounces-45158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05815842C49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6550EB24DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA71762F6;
	Tue, 30 Jan 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z15KhCVN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E35762E2;
	Tue, 30 Jan 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641462; cv=none; b=IAcFrRiRoVNfGwHcxDh5hIbpHmQp1gqQjLfKneDV5kKxb6N7h2DpDEGyl1O6tT4hRDhikTazw6rmBaoA6frEoQXsykLePFf9xpjgwGPT65IsZp2bRGPXhm8nhPVdafr11PDqvK1bN+h37oZLXHP93bJuhJe899/86+G7zWohGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641462; c=relaxed/simple;
	bh=/AduH2y6UR3zLY3u5BVwfhnp623uLwZq8kEsuen1JbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lblda4/+g39q/XdKV4yxU1ujovzf+X4PpkUhxnJEcuKY5IZxf5ZnWtef9Nh0eWHeh4VvjdfYf0+BKGudd4J4yVO2H1JcKYO/5Z/pyhHQFm3KHLBSAxY2OwKWh/eoR65rg7i0gOCDpdgOP2BJLhOfRa7FcAmw4NOSLO/julT+6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z15KhCVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2EEC433F1;
	Tue, 30 Jan 2024 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706641462;
	bh=/AduH2y6UR3zLY3u5BVwfhnp623uLwZq8kEsuen1JbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z15KhCVNcKxl05ai2J3k0CNNcgWmCkmvkUx1/1GwEjWVWQokGXRR/FmgQGd0ou9g0
	 MyLSscd3Ld0SC4H4UfVrdg5zdIye4qGr/g/L3a6O5SqV8dS6mPC+DxKLwbJyIZibHm
	 tQoupqGzDFg6+U/Bsyewhcb+wS7spUA+2I6pTSvQ=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
Date: Tue, 30 Jan 2024 11:03:54 -0800
Message-ID: <20240130190355.11486-5-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.43.0.5.g38fb137bdb
In-Reply-To: <20240130190355.11486-1-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eventfs inode had pointers to dentries (and child dentries) without
actually holding a refcount on said pointer.  That is fundamentally
broken, and while eventfs tried to then maintain coherence with dentries
going away by hooking into the '.d_iput' callback, that doesn't actually
work since it's not ordered wrt lookups.

There were two reasonms why eventfs tried to keep a pointer to a dentry:

 - the creation of a 'events' directory would actually have a stable
   dentry pointer that it created with tracefs_start_creating().

   And it needed that dentry when tearing it all down again in
   eventfs_remove_events_dir().

   This use is actually ok, because the special top-level events
   directory dentries are actually stable, not just a temporary cache of
   the eventfs data structures.

 - the 'eventfs_inode' (aka ei) needs to stay around as long as there
   are dentries that refer to it.

   It then used these dentry pointers as a replacement for doing
   reference counting: it would try to make sure that there was only
   ever one dentry associated with an event_inode, and keep a child
   dentry array around to see which dentries might still refer to the
   parent ei.

This gets rid of the invalid dentry pointer use, and renames the one
valid case to a different name to make it clear that it's not just any
random dentry.

The magic child dentry array that is kind of a "reverse reference list"
is simply replaced by having child dentries take a ref to the ei.  As
does the directory dentries.  That makes the broken use case go away.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/tracefs/event_inode.c | 245 ++++++++++++---------------------------
 fs/tracefs/internal.h    |   9 +-
 2 files changed, 80 insertions(+), 174 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1d0102bfd7da..a37db0dac302 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -62,6 +62,34 @@ enum {
 
 #define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
 
+/*
+ * eventfs_inode reference count management.
+ *
+ * NOTE! We count only references from dentries, in the
+ * form 'dentry->d_fsdata'. There are also references from
+ * directory inodes ('ti->private'), but the dentry reference
+ * count is always a superset of the inode reference count.
+ */
+static void release_ei(struct kref *ref)
+{
+	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+	kfree(ei->entry_attrs);
+	kfree(ei);
+}
+
+static inline void put_ei(struct eventfs_inode *ei)
+{
+	if (ei)
+		kref_put(&ei->kref, release_ei);
+}
+
+static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
+{
+	if (ei)
+		kref_get(&ei->kref);
+	return ei;
+}
+
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
@@ -289,7 +317,8 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
  * directory. The inode.i_private pointer will point to @data in the open()
  * call.
  */
-static struct dentry *lookup_file(struct dentry *dentry,
+static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
+				  struct dentry *dentry,
 				  umode_t mode,
 				  struct eventfs_attr *attr,
 				  void *data,
@@ -302,11 +331,11 @@ static struct dentry *lookup_file(struct dentry *dentry,
 		mode |= S_IFREG;
 
 	if (WARN_ON_ONCE(!S_ISREG(mode)))
-		return NULL;
+		return ERR_PTR(-EIO);
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return eventfs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 
 	/* If the user updated the directory's attributes, use them */
 	update_inode_attr(dentry, inode, attr, mode);
@@ -322,9 +351,12 @@ static struct dentry *lookup_file(struct dentry *dentry,
 	ti->flags = TRACEFS_EVENT_INODE;
 	ti->private = NULL;			// Directories have 'ei', files not
 
+	// Files have their parent's ei as their fsdata
+	dentry->d_fsdata = get_ei(parent_ei);
+
 	d_add(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
-	return eventfs_end_creating(dentry);
+	return NULL;
 };
 
 /**
@@ -343,7 +375,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return eventfs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 
 	/* If the user updated the directory's attributes, use them */
 	update_inode_attr(dentry, inode, &ei->attr,
@@ -359,24 +391,28 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	ti->flags = TRACEFS_EVENT_INODE;
 	ti->private = ei;
 
-	dentry->d_fsdata = ei;
-        ei->dentry = dentry;	// Remove me!
+	dentry->d_fsdata = get_ei(ei);
 
 	inc_nlink(inode);
 	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-	return eventfs_end_creating(dentry);
+	return NULL;
 }
 
-static void free_ei(struct eventfs_inode *ei)
+static inline struct eventfs_inode *alloc_ei(const char *name)
 {
-	kfree_const(ei->name);
-	kfree(ei->d_children);
-	kfree(ei->entry_attrs);
-	kfree(ei);
+	int namesize = strlen(name) + 1;
+	struct eventfs_inode *ei = kzalloc(sizeof(*ei) + namesize, GFP_KERNEL);
+
+	if (ei) {
+		memcpy((char *)ei->name, name, namesize);
+		kref_init(&ei->kref);
+	}
+	return ei;
 }
 
+
 /**
  * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
  * @ti: the tracefs_inode of the dentry
@@ -387,38 +423,20 @@ static void free_ei(struct eventfs_inode *ei)
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
-	int i;
 
 	mutex_lock(&eventfs_mutex);
-
 	ei = dentry->d_fsdata;
-	if (!ei)
-		goto out;
-
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
+	if (ei) {
+		dentry->d_fsdata = NULL;
+		put_ei(ei);
 	}
-
-	dentry->d_fsdata = NULL;
- out:
 	mutex_unlock(&eventfs_mutex);
 }
 
 /**
  * lookup_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
- * @idx: the index into the d_children[] of the @ei
+ * @idx: the index into the entry_attrs[] of the @ei
  * @parent: The parent dentry of the created file.
  * @name: The name of the file to create
  * @mode: The mode of the file.
@@ -435,17 +453,11 @@ lookup_file_dentry(struct dentry *dentry,
 		   const struct file_operations *fops)
 {
 	struct eventfs_attr *attr = NULL;
-	struct dentry **e_dentry = &ei->d_children[idx];
 
 	if (ei->entry_attrs)
 		attr = &ei->entry_attrs[idx];
 
-	dentry->d_fsdata = ei;		// NOTE: ei of _parent_
-	lookup_file(dentry, mode, attr, data, fops);
-
-	*e_dentry = dentry;	// Remove me
-
-	return dentry;
+	return lookup_file(ei, dentry, mode, attr, data, fops);
 }
 
 /**
@@ -466,6 +478,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
 	const char *name = dentry->d_name.name;
+	struct dentry *result;
 
 	ti = get_tracefs(dir);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
@@ -482,7 +495,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			continue;
 		if (ei_child->is_freed)
 			goto enoent;
-		lookup_dir_entry(dentry, ei, ei_child);
+		result = lookup_dir_entry(dentry, ei, ei_child);
 		goto out;
 	}
 
@@ -499,17 +512,18 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (entry->callback(name, &mode, &data, &fops) <= 0)
 			goto enoent;
 
-		lookup_file_dentry(dentry, ei, i, mode, data, fops);
+		result = lookup_file_dentry(dentry, ei, i, mode, data, fops);
 		goto out;
 	}
 
  enoent:
 	/* Nothing found? */
 	d_add(dentry, NULL);
+	result = NULL;
 
  out:
 	mutex_unlock(&eventfs_mutex);
-	return NULL;
+	return result;
 }
 
 /*
@@ -659,25 +673,10 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	if (!parent)
 		return ERR_PTR(-EINVAL);
 
-	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	ei = alloc_ei(name);
 	if (!ei)
 		return ERR_PTR(-ENOMEM);
 
-	ei->name = kstrdup_const(name, GFP_KERNEL);
-	if (!ei->name) {
-		kfree(ei);
-		return ERR_PTR(-ENOMEM);
-	}
-
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
@@ -691,7 +690,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		free_ei(ei);
+		put_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -726,28 +725,20 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 
-	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	ei = alloc_ei(name);
 	if (!ei)
-		goto fail_ei;
+		goto fail;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
 		goto fail;
 
-	if (size) {
-		ei->d_children = kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
-		if (!ei->d_children)
-			goto fail;
-	}
-
-	ei->dentry = dentry;
+	// Note: we have a ref to the dentry from tracefs_start_creating()
+	ei->events_dir = dentry;
 	ei->entries = entries;
 	ei->nr_entries = size;
 	ei->is_events = 1;
 	ei->data = data;
-	ei->name = kstrdup_const(name, GFP_KERNEL);
-	if (!ei->name)
-		goto fail;
 
 	/* Save the ownership of this directory */
 	uid = d_inode(dentry->d_parent)->i_uid;
@@ -778,7 +769,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
-	dentry->d_fsdata = ei;
+	dentry->d_fsdata = get_ei(ei);
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
@@ -790,72 +781,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	kfree(ei->d_children);
-	kfree(ei);
- fail_ei:
+	put_ei(ei);
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
@@ -868,8 +798,6 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 {
 	struct eventfs_inode *ei_child;
 
-	if (!ei)
-		return;
 	/*
 	 * Check recursion depth. It should never be greater than 3:
 	 * 0 - events/
@@ -881,28 +809,12 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 		return;
 
 	/* search for nested folders or files */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 lockdep_is_held(&eventfs_mutex)) {
-		/* Children only have dentry if parent does */
-		WARN_ON_ONCE(ei_child->dentry && !ei->dentry);
+	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
-	}
-
 
 	ei->is_freed = 1;
-
-	for (int i = 0; i < ei->nr_entries; i++) {
-		if (ei->d_children[i]) {
-			/* Children only have dentry if parent does */
-			WARN_ON_ONCE(!ei->dentry);
-			unhook_dentry(ei->d_children[i]);
-		}
-	}
-
-	unhook_dentry(ei->dentry);
-
-	list_del_rcu(&ei->list);
-	call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
+	list_del(&ei->list);
+	put_ei(ei);
 }
 
 /**
@@ -913,22 +825,12 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
  */
 void eventfs_remove_dir(struct eventfs_inode *ei)
 {
-	struct dentry *dentry;
-
 	if (!ei)
 		return;
 
 	mutex_lock(&eventfs_mutex);
-	dentry = ei->dentry;
 	eventfs_remove_rec(ei, 0);
 	mutex_unlock(&eventfs_mutex);
-
-	/*
-	 * If any of the ei children has a dentry, then the ei itself
-	 * must have a dentry.
-	 */
-	if (dentry)
-		simple_recursive_removal(dentry, NULL);
 }
 
 /**
@@ -941,7 +843,11 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 {
 	struct dentry *dentry;
 
-	dentry = ei->dentry;
+	dentry = ei->events_dir;
+	if (!dentry)
+		return;
+
+	ei->events_dir = NULL;
 	eventfs_remove_dir(ei);
 
 	/*
@@ -951,5 +857,6 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	 * sticks around while the other ei->dentry are created
 	 * and destroyed dynamically.
 	 */
+	simple_recursive_removal(dentry, NULL);
 	dput(dentry);
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 8f38740bfb5b..72db3bdc4dfb 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -34,8 +34,7 @@ struct eventfs_attr {
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
  * @children:	link list into the child eventfs_inode
- * @dentry:     the dentry of the directory
- * @d_children: The array of dentries to represent the files when created
+ * @events_dir: the dentry of the events directory
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
@@ -44,12 +43,11 @@ struct eventfs_attr {
  * @nr_entries: The number of items in @entries
  */
 struct eventfs_inode {
+	struct kref			kref;
 	struct list_head		list;
 	const struct eventfs_entry	*entries;
-	const char			*name;
 	struct list_head		children;
-	struct dentry			*dentry; /* Check is_freed to access */
-	struct dentry			**d_children;
+	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
 	struct eventfs_attr		attr;
 	void				*data;
@@ -66,6 +64,7 @@ struct eventfs_inode {
 		struct llist_node	llist;
 		struct rcu_head		rcu;
 	};
+	const char name[];
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.43.0.5.g38fb137bdb


