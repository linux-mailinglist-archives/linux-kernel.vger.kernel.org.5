Return-Path: <linux-kernel+bounces-15698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60160823079
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B83283AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4281A73F;
	Wed,  3 Jan 2024 15:24:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F61A726;
	Wed,  3 Jan 2024 15:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DEDC433C8;
	Wed,  3 Jan 2024 15:24:50 +0000 (UTC)
Date: Wed, 3 Jan 2024 10:25:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
Message-ID: <20240103102553.17a19cea@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs creates dynamically allocated dentries and inodes. Using the
dcache_readdir() logic for its own directory lookups requires hiding the
cursor of the dcache logic and playing games to allow the dcache_readdir()
to still have access to the cursor while the eventfs saved what it created
and what it needs to release.

Instead, just have eventfs have its own iterate_shared callback function
that will fill in the dent entries. This simplifies the code quite a bit.

Also, remove the "lookup" parameter to the create_file/dir_dentry() and
always have it return a dentry that has its ref count incremented, and
have the caller call the dput. This simplifies that code as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 237 +++++++++++++--------------------------
 1 file changed, 78 insertions(+), 159 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f0677ea0ec24..53d34a4b5a2b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -52,9 +52,7 @@ enum {
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
-static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
-static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
-static int eventfs_release(struct inode *inode, struct file *file);
+static int eventfs_iterate(struct file *file, struct dir_context *ctx);
 
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
@@ -148,11 +146,9 @@ static const struct inode_operations eventfs_file_inode_operations = {
 };
 
 static const struct file_operations eventfs_file_operations = {
-	.open		= dcache_dir_open_wrapper,
 	.read		= generic_read_dir,
-	.iterate_shared	= dcache_readdir_wrapper,
+	.iterate_shared	= eventfs_iterate,
 	.llseek		= generic_file_llseek,
-	.release	= eventfs_release,
 };
 
 /* Return the evenfs_inode of the "events" directory */
@@ -390,16 +386,14 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
- * @lookup: If called by the lookup routine, in which case, dput() the created dentry.
  *
  * Create a dentry for a file of an eventfs_inode @ei and place it into the
- * address located at @e_dentry. If the @e_dentry already has a dentry, then
- * just do a dget() on it and return. Otherwise create the dentry and attach it.
+ * address located at @e_dentry.
  */
 static struct dentry *
 create_file_dentry(struct eventfs_inode *ei, int idx,
 		   struct dentry *parent, const char *name, umode_t mode, void *data,
-		   const struct file_operations *fops, bool lookup)
+		   const struct file_operations *fops)
 {
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
@@ -414,9 +408,7 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	}
 	/* If the e_dentry already has a dentry, use it */
 	if (*e_dentry) {
-		/* lookup does not need to up the ref count */
-		if (!lookup)
-			dget(*e_dentry);
+		dget(*e_dentry);
 		mutex_unlock(&eventfs_mutex);
 		return *e_dentry;
 	}
@@ -441,13 +433,12 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * way to being freed, don't return it. If e_dentry is NULL
 		 * it means it was already freed.
 		 */
-		if (ei->is_freed)
+		if (ei->is_freed) {
 			dentry = NULL;
-		else
+		} else {
 			dentry = *e_dentry;
-		/* The lookup does not need to up the dentry refcount */
-		if (dentry && !lookup)
 			dget(dentry);
+		}
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
 	}
@@ -465,9 +456,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (lookup)
-		dput(dentry);
-
 	return dentry;
 }
 
@@ -500,13 +488,12 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
  * @pei: The eventfs_inode parent of ei.
  * @ei: The eventfs_inode to create the directory for
  * @parent: The dentry of the parent of this directory
- * @lookup: True if this is called by the lookup code
  *
  * This creates and attaches a directory dentry to the eventfs_inode @ei.
  */
 static struct dentry *
 create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
-		  struct dentry *parent, bool lookup)
+		  struct dentry *parent)
 {
 	struct dentry *dentry = NULL;
 
@@ -520,9 +507,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	if (ei->dentry) {
 		/* If the dentry already has a dentry, use it */
 		dentry = ei->dentry;
-		/* lookup does not need to up the ref count */
-		if (!lookup)
-			dget(dentry);
+		dget(dentry);
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
 	}
@@ -542,7 +527,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * way to being freed.
 		 */
 		dentry = ei->dentry;
-		if (dentry && !lookup)
+		if (dentry)
 			dget(dentry);
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
@@ -562,9 +547,6 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (lookup)
-		dput(dentry);
-
 	return dentry;
 }
 
@@ -589,8 +571,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct eventfs_inode *ei;
 	struct dentry *ei_dentry = NULL;
 	struct dentry *ret = NULL;
+	struct dentry *d;
 	const char *name = dentry->d_name.name;
-	bool created = false;
 	umode_t mode;
 	void *data;
 	int idx;
@@ -626,13 +608,10 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		ret = simple_lookup(dir, dentry, flags);
 		if (IS_ERR(ret))
 			goto out;
-		create_dir_dentry(ei, ei_child, ei_dentry, true);
-		created = true;
-		break;
-	}
-
-	if (created)
+		d = create_dir_dentry(ei, ei_child, ei_dentry);
+		dput(d);
 		goto out;
+	}
 
 	for (i = 0; i < ei->nr_entries; i++) {
 		entry = &ei->entries[i];
@@ -650,8 +629,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			ret = simple_lookup(dir, dentry, flags);
 			if (IS_ERR(ret))
 				goto out;
-			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
-					   fops, true);
+			d = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
+			dput(d);
 			break;
 		}
 	}
@@ -660,127 +639,82 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	return ret;
 }
 
-struct dentry_list {
-	void			*cursor;
-	struct dentry		**dentries;
-};
-
-/**
- * eventfs_release - called to release eventfs file/dir
- * @inode: inode to be released
- * @file: file to be released (not used)
- */
-static int eventfs_release(struct inode *inode, struct file *file)
-{
-	struct tracefs_inode *ti;
-	struct dentry_list *dlist = file->private_data;
-	void *cursor;
-	int i;
-
-	ti = get_tracefs(inode);
-	if (!(ti->flags & TRACEFS_EVENT_INODE))
-		return -EINVAL;
-
-	if (WARN_ON_ONCE(!dlist))
-		return -EINVAL;
-
-	for (i = 0; dlist->dentries && dlist->dentries[i]; i++) {
-		dput(dlist->dentries[i]);
-	}
-
-	cursor = dlist->cursor;
-	kfree(dlist->dentries);
-	kfree(dlist);
-	file->private_data = cursor;
-	return dcache_dir_close(inode, file);
-}
-
-static int add_dentries(struct dentry ***dentries, struct dentry *d, int cnt)
-{
-	struct dentry **tmp;
-
-	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_NOFS);
-	if (!tmp)
-		return -1;
-	tmp[cnt] = d;
-	tmp[cnt + 1] = NULL;
-	*dentries = tmp;
-	return 0;
-}
-
-/**
- * dcache_dir_open_wrapper - eventfs open wrapper
- * @inode: not used
- * @file: dir to be opened (to create it's children)
- *
- * Used to dynamic create file/dir with-in @file, all the
- * file/dir will be created. If already created then references
- * will be increased
+/*
+ * Walk the children of a eventfs_inode to fill in getdents().
  */
-static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 {
 	const struct file_operations *fops;
+	struct inode *f_inode = file_inode(file);
 	const struct eventfs_entry *entry;
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry_list *dlist;
-	struct dentry **dentries = NULL;
-	struct dentry *parent = file_dentry(file);
-	struct dentry *d;
-	struct inode *f_inode = file_inode(file);
-	const char *name = parent->d_name.name;
+	struct dentry *ei_dentry = NULL;
+	struct dentry *dentry;
+	const char *name;
 	umode_t mode;
-	void *data;
-	int cnt = 0;
 	int idx;
-	int ret;
-	int i;
-	int r;
+	int ret = -EINVAL;
+	int ino;
+	int i, r, c;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
 
 	ti = get_tracefs(f_inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(file->private_data))
-		return -EINVAL;
+	c = ctx->pos - 2;
 
 	idx = srcu_read_lock(&eventfs_srcu);
 
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
+	if (ei && !ei->is_freed)
+		ei_dentry = READ_ONCE(ei->dentry);
 	mutex_unlock(&eventfs_mutex);
 
-	if (!ei) {
-		srcu_read_unlock(&eventfs_srcu, idx);
-		return -EINVAL;
-	}
-
-
-	data = ei->data;
+	if (!ei || !ei_dentry)
+		goto out;
 
-	dlist = kmalloc(sizeof(*dlist), GFP_KERNEL);
-	if (!dlist) {
-		srcu_read_unlock(&eventfs_srcu, idx);
-		return -ENOMEM;
-	}
+	ret = 0;
 
-	inode_lock(parent->d_inode);
+	/*
+	 * Need to create the dentries and inodes to have a consistent
+	 * inode number.
+	 */
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		d = create_dir_dentry(ei, ei_child, parent, false);
-		if (d) {
-			ret = add_dentries(&dentries, d, cnt);
-			if (ret < 0)
-				break;
-			cnt++;
+
+		if (ei_child->is_freed)
+			continue;
+
+		name = ei_child->name;
+
+		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
+		if (!dentry)
+			goto out;
+		ino = dentry->d_inode->i_ino;
+		dput(dentry);
+
+		if (c > 0) {
+			c--;
+			continue;
 		}
+
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
+			goto out;
+		ctx->pos++;
 	}
 
 	for (i = 0; i < ei->nr_entries; i++) {
-		void *cdata = data;
+		void *cdata = ei->data;
+
 		entry = &ei->entries[i];
 		name = entry->name;
+
 		mutex_lock(&eventfs_mutex);
 		/* If ei->is_freed, then the event itself may be too */
 		if (!ei->is_freed)
@@ -790,41 +724,26 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
-		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
-		if (d) {
-			ret = add_dentries(&dentries, d, cnt);
-			if (ret < 0)
-				break;
-			cnt++;
+
+		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
+		if (!dentry)
+			goto out;
+		ino = dentry->d_inode->i_ino;
+		dput(dentry);
+
+		if (c > 0) {
+			c--;
+			continue;
 		}
+
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
+			goto out;
+		ctx->pos++;
 	}
-	inode_unlock(parent->d_inode);
+	ret = 1;
+ out:
 	srcu_read_unlock(&eventfs_srcu, idx);
-	ret = dcache_dir_open(inode, file);
-
-	/*
-	 * dcache_dir_open() sets file->private_data to a dentry cursor.
-	 * Need to save that but also save all the dentries that were
-	 * opened by this function.
-	 */
-	dlist->cursor = file->private_data;
-	dlist->dentries = dentries;
-	file->private_data = dlist;
-	return ret;
-}
-
-/*
- * This just sets the file->private_data back to the cursor and back.
- */
-static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
-{
-	struct dentry_list *dlist = file->private_data;
-	int ret;
 
-	file->private_data = dlist->cursor;
-	ret = dcache_readdir(file, ctx);
-	dlist->cursor = file->private_data;
-	file->private_data = dlist;
 	return ret;
 }
 
-- 
2.42.0


