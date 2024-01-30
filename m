Return-Path: <linux-kernel+bounces-45156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10121842C41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3C1F267E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719E762C3;
	Tue, 30 Jan 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p0VAlaMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E369E0B;
	Tue, 30 Jan 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641459; cv=none; b=p9I9kj/Nfhd4pANEJrMmOCcfjY/kmSCzKdsDpnc1AJPzhyC8aq5SpPhUA6P9/+aMNVUTUnoXNfv/+ES6/n+zFJUiXDKNfqBb98/bkbcjZak3c+U/BFa5IEqBM51xMYqhBX9SBNNmnZgJ16usC2uEjitrr/utRJTbY1WR2TduN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641459; c=relaxed/simple;
	bh=LbesOErzRPHz1hwSxWlEynNIaeMRVBOlM3K2fcN2MmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRsSRwMXv9sok7me7ITc17X8ilUx3993x+7T6rv/nk5wFccb7ATSU1Jpxh9bI2i5khRQBUeZLS+5Mps08sGLPtNsX/9WwiOogPHT/UmcuLP6UuLkuUiQz1v53X8LQ8J0dDhn4hTPsOpkArTLXhCYf9a5/niEDsbK8sjiooK+3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p0VAlaMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C73C43394;
	Tue, 30 Jan 2024 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706641459;
	bh=LbesOErzRPHz1hwSxWlEynNIaeMRVBOlM3K2fcN2MmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0VAlaMziE9y3oNPr5/epHXp2SUJ4/Qn6OAxtYA15ci5BQxHZjIhI8Sd4LLbXa2An
	 CiZwEdqTxZpDaWJ3AusoDGwuy4ehpWT1WiYW7RIdWA4Ewqk9zLzWsNXNHonK4G+riv
	 LFaQ75c+qky16C1qS9AzYDpJKmtNkGz7WFhKR+1c=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/6] tracefs: dentry lookup crapectomy
Date: Tue, 30 Jan 2024 11:03:52 -0800
Message-ID: <20240130190355.11486-3-torvalds@linux-foundation.org>
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

The dentry lookup for eventfs files was very broken, and had lots of
signs of the old situation where the filesystem names were all created
statically in the dentry tree, rather than being looked up dynamically
based on the eventfs data structures.

You could see it in the naming - how it claimed to "create" dentries
rather than just look up the dentries that were given it.

You could see it in various nonsensical and very incorrect operations,
like using "simple_lookup()" on the dentries that were passed in, which
only results in those dentries becoming negative dentries.  Which meant
that any other lookup would possibly return ENOENT if it saw that
negative dentry before the data rwas then later filled in.

You could see it in the immesnse amount of nonsensical code that didn't
actually just do lookups.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/tracefs/event_inode.c | 275 ++++++++-------------------------------
 1 file changed, 52 insertions(+), 223 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index c0d977e6c0f2..ad11063bdd53 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -230,7 +230,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 
-	mutex_lock(&eventfs_mutex);
 	do {
 		// The parent is stable because we do not do renames
 		dentry = dentry->d_parent;
@@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		}
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
-	mutex_unlock(&eventfs_mutex);
 
 	update_top_events_attr(ei, dentry->d_sb);
 
@@ -280,11 +278,10 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 }
 
 /**
- * create_file - create a file in the tracefs filesystem
- * @name: the name of the file to create.
+ * lookup_file - look up a file in the tracefs filesystem
+ * @dentry: the dentry to look up
  * @mode: the permission that the file should have.
  * @attr: saved attributes changed by user
- * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
  *
@@ -292,13 +289,13 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
  * directory. The inode.i_private pointer will point to @data in the open()
  * call.
  */
-static struct dentry *create_file(const char *name, umode_t mode,
+static struct dentry *lookup_file(struct dentry *dentry,
+				  umode_t mode,
 				  struct eventfs_attr *attr,
-				  struct dentry *parent, void *data,
+				  void *data,
 				  const struct file_operations *fop)
 {
 	struct tracefs_inode *ti;
-	struct dentry *dentry;
 	struct inode *inode;
 
 	if (!(mode & S_IFMT))
@@ -307,12 +304,6 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
 
-	WARN_ON_ONCE(!parent);
-	dentry = eventfs_start_creating(name, parent);
-
-	if (IS_ERR(dentry))
-		return dentry;
-
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
@@ -331,29 +322,25 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	ti->flags = TRACEFS_EVENT_INODE;
 	ti->private = NULL;			// Directories have 'ei', files not
 
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return eventfs_end_creating(dentry);
 };
 
 /**
- * create_dir - create a dir in the tracefs filesystem
+ * lookup_dir_entry - look up a dir in the tracefs filesystem
+ * @dentry: the directory to look up
  * @ei: the eventfs_inode that represents the directory to create
- * @parent: parent dentry for this file.
  *
- * This function will create a dentry for a directory represented by
+ * This function will look up a dentry for a directory represented by
  * a eventfs_inode.
  */
-static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent)
+static struct dentry *lookup_dir_entry(struct dentry *dentry,
+	struct eventfs_inode *pei, struct eventfs_inode *ei)
 {
 	struct tracefs_inode *ti;
-	struct dentry *dentry;
 	struct inode *inode;
 
-	dentry = eventfs_start_creating(ei->name, parent);
-	if (IS_ERR(dentry))
-		return dentry;
-
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
@@ -372,8 +359,11 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	ti->flags = TRACEFS_EVENT_INODE;
 	ti->private = ei;
 
+	dentry->d_fsdata = ei;
+        ei->dentry = dentry;	// Remove me!
+
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	return eventfs_end_creating(dentry);
@@ -426,7 +416,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 }
 
 /**
- * create_file_dentry - create a dentry for a file of an eventfs_inode
+ * lookup_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
  * @idx: the index into the d_children[] of the @ei
  * @parent: The parent dentry of the created file.
@@ -439,157 +429,21 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
  * address located at @e_dentry.
  */
 static struct dentry *
-create_file_dentry(struct eventfs_inode *ei, int idx,
-		   struct dentry *parent, const char *name, umode_t mode, void *data,
+lookup_file_dentry(struct dentry *dentry,
+		   struct eventfs_inode *ei, int idx,
+		   umode_t mode, void *data,
 		   const struct file_operations *fops)
 {
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
-	struct dentry *dentry;
 
-	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
-
-	mutex_lock(&eventfs_mutex);
-	if (ei->is_freed) {
-		mutex_unlock(&eventfs_mutex);
-		return NULL;
-	}
-	/* If the e_dentry already has a dentry, use it */
-	if (*e_dentry) {
-		dget(*e_dentry);
-		mutex_unlock(&eventfs_mutex);
-		return *e_dentry;
-	}
-
-	/* ei->entry_attrs are protected by SRCU */
 	if (ei->entry_attrs)
 		attr = &ei->entry_attrs[idx];
 
-	mutex_unlock(&eventfs_mutex);
+	dentry->d_fsdata = ei;		// NOTE: ei of _parent_
+	lookup_file(dentry, mode, attr, data, fops);
 
-	dentry = create_file(name, mode, attr, parent, data, fops);
-
-	mutex_lock(&eventfs_mutex);
-
-	if (IS_ERR_OR_NULL(dentry)) {
-		/*
-		 * When the mutex was released, something else could have
-		 * created the dentry for this e_dentry. In which case
-		 * use that one.
-		 *
-		 * If ei->is_freed is set, the e_dentry is currently on its
-		 * way to being freed, don't return it. If e_dentry is NULL
-		 * it means it was already freed.
-		 */
-		if (ei->is_freed) {
-			dentry = NULL;
-		} else {
-			dentry = *e_dentry;
-			dget(dentry);
-		}
-		mutex_unlock(&eventfs_mutex);
-		return dentry;
-	}
-
-	if (!*e_dentry && !ei->is_freed) {
-		*e_dentry = dentry;
-		dentry->d_fsdata = ei;
-	} else {
-		/*
-		 * Should never happen unless we get here due to being freed.
-		 * Otherwise it means two dentries exist with the same name.
-		 */
-		WARN_ON_ONCE(!ei->is_freed);
-		dentry = NULL;
-	}
-	mutex_unlock(&eventfs_mutex);
-
-	return dentry;
-}
-
-/**
- * eventfs_post_create_dir - post create dir routine
- * @ei: eventfs_inode of recently created dir
- *
- * Map the meta-data of files within an eventfs dir to their parent dentry
- */
-static void eventfs_post_create_dir(struct eventfs_inode *ei)
-{
-	struct eventfs_inode *ei_child;
-
-	lockdep_assert_held(&eventfs_mutex);
-
-	/* srcu lock already held */
-	/* fill parent-child relation */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
-		ei_child->d_parent = ei->dentry;
-	}
-}
-
-/**
- * create_dir_dentry - Create a directory dentry for the eventfs_inode
- * @pei: The eventfs_inode parent of ei.
- * @ei: The eventfs_inode to create the directory for
- * @parent: The dentry of the parent of this directory
- *
- * This creates and attaches a directory dentry to the eventfs_inode @ei.
- */
-static struct dentry *
-create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
-		  struct dentry *parent)
-{
-	struct dentry *dentry = NULL;
-
-	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
-
-	mutex_lock(&eventfs_mutex);
-	if (pei->is_freed || ei->is_freed) {
-		mutex_unlock(&eventfs_mutex);
-		return NULL;
-	}
-	if (ei->dentry) {
-		/* If the eventfs_inode already has a dentry, use it */
-		dentry = ei->dentry;
-		dget(dentry);
-		mutex_unlock(&eventfs_mutex);
-		return dentry;
-	}
-	mutex_unlock(&eventfs_mutex);
-
-	dentry = create_dir(ei, parent);
-
-	mutex_lock(&eventfs_mutex);
-
-	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
-		/*
-		 * When the mutex was released, something else could have
-		 * created the dentry for this e_dentry. In which case
-		 * use that one.
-		 *
-		 * If ei->is_freed is set, the e_dentry is currently on its
-		 * way to being freed.
-		 */
-		dentry = ei->dentry;
-		if (dentry)
-			dget(dentry);
-		mutex_unlock(&eventfs_mutex);
-		return dentry;
-	}
-
-	if (!ei->dentry && !ei->is_freed) {
-		ei->dentry = dentry;
-		eventfs_post_create_dir(ei);
-		dentry->d_fsdata = ei;
-	} else {
-		/*
-		 * Should never happen unless we get here due to being freed.
-		 * Otherwise it means two dentries exist with the same name.
-		 */
-		WARN_ON_ONCE(!ei->is_freed);
-		dentry = NULL;
-	}
-	mutex_unlock(&eventfs_mutex);
+	*e_dentry = dentry;	// Remove me
 
 	return dentry;
 }
@@ -608,79 +462,54 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags)
 {
-	const struct file_operations *fops;
-	const struct eventfs_entry *entry;
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry *ei_dentry = NULL;
-	struct dentry *ret = NULL;
-	struct dentry *d;
 	const char *name = dentry->d_name.name;
-	umode_t mode;
-	void *data;
-	int idx;
-	int i;
-	int r;
 
 	ti = get_tracefs(dir);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
-		return NULL;
+		return ERR_PTR(-EIO);
 
-	/* Grab srcu to prevent the ei from going away */
-	idx = srcu_read_lock(&eventfs_srcu);
-
-	/*
-	 * Grab the eventfs_mutex to consistent value from ti->private.
-	 * This s
-	 */
 	mutex_lock(&eventfs_mutex);
-	ei = READ_ONCE(ti->private);
-	if (ei && !ei->is_freed)
-		ei_dentry = READ_ONCE(ei->dentry);
-	mutex_unlock(&eventfs_mutex);
 
-	if (!ei || !ei_dentry)
-		goto out;
+	ei = ti->private;
+	if (!ei || ei->is_freed)
+		goto enoent;
 
-	data = ei->data;
-
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
+	list_for_each_entry(ei_child, &ei->children, list) {
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
-		ret = simple_lookup(dir, dentry, flags);
-		if (IS_ERR(ret))
-			goto out;
-		d = create_dir_dentry(ei, ei_child, ei_dentry);
-		dput(d);
+		if (ei_child->is_freed)
+			goto enoent;
+		lookup_dir_entry(dentry, ei, ei_child);
 		goto out;
 	}
 
-	for (i = 0; i < ei->nr_entries; i++) {
-		entry = &ei->entries[i];
-		if (strcmp(name, entry->name) == 0) {
-			void *cdata = data;
-			mutex_lock(&eventfs_mutex);
-			/* If ei->is_freed, then the event itself may be too */
-			if (!ei->is_freed)
-				r = entry->callback(name, &mode, &cdata, &fops);
-			else
-				r = -1;
-			mutex_unlock(&eventfs_mutex);
-			if (r <= 0)
-				continue;
-			ret = simple_lookup(dir, dentry, flags);
-			if (IS_ERR(ret))
-				goto out;
-			d = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
-			dput(d);
-			break;
-		}
+	for (int i = 0; i < ei->nr_entries; i++) {
+		void *data;
+		umode_t mode;
+		const struct file_operations *fops;
+		const struct eventfs_entry *entry = &ei->entries[i];
+
+		if (strcmp(name, entry->name) != 0)
+			continue;
+
+		data = ei->data;
+		if (entry->callback(name, &mode, &data, &fops) <= 0)
+			goto enoent;
+
+		lookup_file_dentry(dentry, ei, i, mode, data, fops);
+		goto out;
 	}
+
+ enoent:
+	/* Nothing found? */
+	d_add(dentry, NULL);
+
  out:
-	srcu_read_unlock(&eventfs_srcu, idx);
-	return ret;
+	mutex_unlock(&eventfs_mutex);
+	return NULL;
 }
 
 /*
-- 
2.43.0.5.g38fb137bdb


