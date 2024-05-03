Return-Path: <linux-kernel+bounces-168391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3558BB7E4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6979A1F24011
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C355B82D6C;
	Fri,  3 May 2024 23:07:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F932D05E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777650; cv=none; b=B420C2NaOgizz3T+mDtT4b/sU2LAc181h7BRvyIxILRm4mo/C2YQnDUnVVQ81asJJD7AFGvTgx/nMpVkKShkYZoeyG28y0FROoC4uTfrRp+oBSF/7XYELAb86Mx24CXoRq6cfGt8gE5JjPp0uLTTgl8yl6E+3/ausZOB7G36pRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777650; c=relaxed/simple;
	bh=Crx1zISvsOy/hTu1BgKV7kCy0bduh7/uC1nZAJjdCi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mveRm8VPNzTQLTyWSvOf8nVXaDAySeRBxxsfnUa3up5aQQUzK6QAzcD2saP3ey6MuqPpe2NTAkII79Ubg2cHsPLyHsiApro4v7xlU6fmWSSHdPdu+0usSevkqY6VdBCMMQlu5mq1YkUTr2kuIhO7VwEwCuHMdZlKVIU6lbczqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7655BC116B1;
	Fri,  3 May 2024 23:07:29 +0000 (UTC)
Date: Fri, 3 May 2024 19:07:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [GIT PULL] tracing/tracefs: Fixes for v6.9
Message-ID: <20240503190728.7510af9a@gandalf.local.home>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing and tracefs fixes for v6.9

- Minor fix for user_events interface
  The ABI of creating a user event states that the fields
  are separated by semicolons, and spaces should be ignored.
  But the parsing expected at least one space to be there (which was incorrect).
  Fix the reading of the string to handle fields separated by
  semicolons but no space between them.

- Add test to user event selftests for no spaces between fields.

- Fix RCU callback of freeing an eventfs_inode.
  The freeing of the eventfs_inode from the kref going to zero
  freed the contents of the eventfs_inode and then used kfree_rcu()
  to free the inode itself. But the contents should also be protected
  by RCU. Switch to a call_rcu() that calls a function to free all
  of the eventfs_inode after the RCU synchronization.

- The tracing subsystem maps its own descriptor to a file represented by
  eventfs. The freeing of this descriptor needs to know when the
  last reference of an eventfs_inode is released, but currently
  there is no interface for that. Add a "release" callback to
  the eventfs_inode entry array that allows for freeing of data
  that can be referenced by the eventfs_inode being opened.
  Then increment the ref counter for this descriptor when the
  eventfs_inode file is created, and decrement/free it when the
  last reference to the eventfs_inode is released and the file
  is removed. This prevents races between freeing the descriptor
  and the opening of the eventfs file.

- Fix the permission processing of eventfs.
  The change to make the permissions of eventfs default to the mount
  point but keep track of when changes were made had a side effect
  that could cause security concerns. When the tracefs is remounted
  with a given gid or uid, all the files within it should inherit
  that gid or uid. But if the admin had changed the permission of
  some file within the tracefs file system, it would not get updated
  by the remount. This caused the kselftest of file permissions
  to fail the second time it is run. The first time, all changes
  would look fine, but the second time, because the changes were
  "saved", the remount did not reset them.

  Create a link list of all existing tracefs inodes, and clear the
  saved flags on them on a remount if the remount changes the
  corresponding gid or uid fields.

  This also simplifies the code by removing the distinction between the
  toplevel eventfs and an instance eventfs. They should both act the
  same. They were different because of a misconception due to the
  remount not resetting the flags. Now that remount resets all the
  files and directories to default to the root node if a uid/gid is
  specified, it makes the logic simpler to implement.


Please pull the latest trace-v6.9-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.9-rc6

Tag SHA1: acfeeacb6a9cc524e4f78bf40cd3e6d3f37e7041
Head SHA1: a235af3b93a7e2a7dc4b0d56551ba20bc44b3f49


Beau Belgrave (2):
      tracing/user_events: Fix non-spaced field matching
      selftests/user_events: Add non-spacing separator check

Steven Rostedt (Google) (7):
      eventfs/tracing: Add callback for release of an eventfs_inode
      eventfs: Free all of the eventfs_inode after RCU
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Do not treat events directory different than other directories
      eventfs: Have "events" directory get permissions from its parent

----
 fs/tracefs/event_inode.c                          | 148 ++++++++++++++--------
 fs/tracefs/inode.c                                |  92 +++++++++++++-
 fs/tracefs/internal.h                             |  14 +-
 include/linux/tracefs.h                           |   3 +
 kernel/trace/trace_events.c                       |  12 ++
 kernel/trace/trace_events_user.c                  |  76 ++++++++++-
 tools/testing/selftests/user_events/ftrace_test.c |   8 ++
 7 files changed, 293 insertions(+), 60 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 894c6ca1e500..a878cea70f4c 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -37,6 +37,7 @@ static DEFINE_MUTEX(eventfs_mutex);
 
 struct eventfs_root_inode {
 	struct eventfs_inode		ei;
+	struct inode			*parent_inode;
 	struct dentry			*events_dir;
 };
 
@@ -68,11 +69,25 @@ enum {
 	EVENTFS_SAVE_MODE	= BIT(16),
 	EVENTFS_SAVE_UID	= BIT(17),
 	EVENTFS_SAVE_GID	= BIT(18),
-	EVENTFS_TOPLEVEL	= BIT(19),
 };
 
 #define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
 
+static void free_ei_rcu(struct rcu_head *rcu)
+{
+	struct eventfs_inode *ei = container_of(rcu, struct eventfs_inode, rcu);
+	struct eventfs_root_inode *rei;
+
+	kfree(ei->entry_attrs);
+	kfree_const(ei->name);
+	if (ei->is_events) {
+		rei = get_root_inode(ei);
+		kfree(rei);
+	} else {
+		kfree(ei);
+	}
+}
+
 /*
  * eventfs_inode reference count management.
  *
@@ -84,18 +99,17 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
-	struct eventfs_root_inode *rei;
+	const struct eventfs_entry *entry;
 
 	WARN_ON_ONCE(!ei->is_freed);
 
-	kfree(ei->entry_attrs);
-	kfree_const(ei->name);
-	if (ei->is_events) {
-		rei = get_root_inode(ei);
-		kfree_rcu(rei, ei.rcu);
-	} else {
-		kfree_rcu(ei, rcu);
+	for (int i = 0; i < ei->nr_entries; i++) {
+		entry = &ei->entries[i];
+		if (entry->release)
+			entry->release(entry->name, ei->data);
 	}
+
+	call_rcu(&ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
@@ -112,6 +126,18 @@ static inline void free_ei(struct eventfs_inode *ei)
 	}
 }
 
+/*
+ * Called when creation of an ei fails, do not call release() functions.
+ */
+static inline void cleanup_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		/* Set nr_entries to 0 to prevent release() function being called */
+		ei->nr_entries = 0;
+		free_ei(ei);
+	}
+}
+
 static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 {
 	if (ei)
@@ -181,21 +207,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	 * determined by the parent directory.
 	 */
 	if (dentry->d_inode->i_mode & S_IFDIR) {
-		/*
-		 * The events directory dentry is never freed, unless its
-		 * part of an instance that is deleted. It's attr is the
-		 * default for its child files and directories.
-		 * Do not update it. It's not used for its own mode or ownership.
-		 */
-		if (ei->is_events) {
-			/* But it still needs to know if it was modified */
-			if (iattr->ia_valid & ATTR_UID)
-				ei->attr.mode |= EVENTFS_SAVE_UID;
-			if (iattr->ia_valid & ATTR_GID)
-				ei->attr.mode |= EVENTFS_SAVE_GID;
-		} else {
-			update_attr(&ei->attr, iattr);
-		}
+		update_attr(&ei->attr, iattr);
 
 	} else {
 		name = dentry->d_name.name;
@@ -213,18 +225,25 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-static void update_top_events_attr(struct eventfs_inode *ei, struct super_block *sb)
+static void update_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
-	struct inode *root;
+	struct eventfs_root_inode *rei;
+	struct inode *parent;
 
-	/* Only update if the "events" was on the top level */
-	if (!ei || !(ei->attr.mode & EVENTFS_TOPLEVEL))
-		return;
+	rei = get_root_inode(ei);
 
-	/* Get the tracefs root inode. */
-	root = d_inode(sb->s_root);
-	ei->attr.uid = root->i_uid;
-	ei->attr.gid = root->i_gid;
+	/* Use the parent inode permissions unless root set its permissions */
+	parent = rei->parent_inode;
+
+	if (rei->ei.attr.mode & EVENTFS_SAVE_UID)
+		ei->attr.uid = rei->ei.attr.uid;
+	else
+		ei->attr.uid = parent->i_uid;
+
+	if (rei->ei.attr.mode & EVENTFS_SAVE_GID)
+		ei->attr.gid = rei->ei.attr.gid;
+	else
+		ei->attr.gid = parent->i_gid;
 }
 
 static void set_top_events_ownership(struct inode *inode)
@@ -233,10 +252,10 @@ static void set_top_events_ownership(struct inode *inode)
 	struct eventfs_inode *ei = ti->private;
 
 	/* The top events directory doesn't get automatically updated */
-	if (!ei || !ei->is_events || !(ei->attr.mode & EVENTFS_TOPLEVEL))
+	if (!ei || !ei->is_events)
 		return;
 
-	update_top_events_attr(ei, inode->i_sb);
+	update_events_attr(ei, inode->i_sb);
 
 	if (!(ei->attr.mode & EVENTFS_SAVE_UID))
 		inode->i_uid = ei->attr.uid;
@@ -265,7 +284,7 @@ static int eventfs_permission(struct mnt_idmap *idmap,
 	return generic_permission(idmap, inode, mask);
 }
 
-static const struct inode_operations eventfs_root_dir_inode_operations = {
+static const struct inode_operations eventfs_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
 	.setattr	= eventfs_set_attr,
 	.getattr	= eventfs_get_attr,
@@ -282,6 +301,35 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+/*
+ * On a remount of tracefs, if UID or GID options are set, then
+ * the mount point inode permissions should be used.
+ * Reset the saved permission flags appropriately.
+ */
+void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
+{
+	struct eventfs_inode *ei = ti->private;
+
+	if (!ei)
+		return;
+
+	if (update_uid)
+		ei->attr.mode &= ~EVENTFS_SAVE_UID;
+
+	if (update_gid)
+		ei->attr.mode &= ~EVENTFS_SAVE_GID;
+
+	if (!ei->entry_attrs)
+		return;
+
+	for (int i = 0; i < ei->nr_entries; i++) {
+		if (update_uid)
+			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_UID;
+		if (update_gid)
+			ei->entry_attrs[i].mode &= ~EVENTFS_SAVE_GID;
+	}
+}
+
 /* Return the evenfs_inode of the "events" directory */
 static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
@@ -304,7 +352,7 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 
-	update_top_events_attr(ei, dentry->d_sb);
+	update_events_attr(ei, dentry->d_sb);
 
 	return ei;
 }
@@ -410,7 +458,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	update_inode_attr(dentry, inode, &ei->attr,
 			  S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 
-	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	/* All directories will have the same inode number */
@@ -734,7 +782,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		free_ei(ei);
+		cleanup_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -781,6 +829,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	// Note: we have a ref to the dentry from tracefs_start_creating()
 	rei = get_root_inode(ei);
 	rei->events_dir = dentry;
+	rei->parent_inode = d_inode(dentry->d_sb->s_root);
 
 	ei->entries = entries;
 	ei->nr_entries = size;
@@ -790,29 +839,26 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	uid = d_inode(dentry->d_parent)->i_uid;
 	gid = d_inode(dentry->d_parent)->i_gid;
 
-	/*
-	 * If the events directory is of the top instance, then parent
-	 * is NULL. Set the attr.mode to reflect this and its permissions will
-	 * default to the tracefs root dentry.
-	 */
-	if (!parent)
-		ei->attr.mode = EVENTFS_TOPLEVEL;
-
-	/* This is used as the default ownership of the files and directories */
 	ei->attr.uid = uid;
 	ei->attr.gid = gid;
 
+	/*
+	 * When the "events" directory is created, it takes on the
+	 * permissions of its parent. But can be reset on remount.
+	 */
+	ei->attr.mode |= EVENTFS_SAVE_UID | EVENTFS_SAVE_GID;
+
 	INIT_LIST_HEAD(&ei->children);
 	INIT_LIST_HEAD(&ei->list);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_op = &eventfs_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
 	dentry->d_fsdata = get_ei(ei);
@@ -835,7 +881,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	free_ei(ei);
+	cleanup_ei(ei);
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5545e6bf7d26..417c840e6403 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -30,20 +30,47 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+/*
+ * Keep track of all tracefs_inodes in order to update their
+ * flags if necessary on a remount.
+ */
+static DEFINE_SPINLOCK(tracefs_inode_lock);
+static LIST_HEAD(tracefs_inodes);
+
 static struct inode *tracefs_alloc_inode(struct super_block *sb)
 {
 	struct tracefs_inode *ti;
+	unsigned long flags;
 
 	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
 	if (!ti)
 		return NULL;
 
+	spin_lock_irqsave(&tracefs_inode_lock, flags);
+	list_add_rcu(&ti->list, &tracefs_inodes);
+	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
+
 	return &ti->vfs_inode;
 }
 
+static void tracefs_free_inode_rcu(struct rcu_head *rcu)
+{
+	struct tracefs_inode *ti;
+
+	ti = container_of(rcu, struct tracefs_inode, rcu);
+	kmem_cache_free(tracefs_inode_cachep, ti);
+}
+
 static void tracefs_free_inode(struct inode *inode)
 {
-	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+	struct tracefs_inode *ti = get_tracefs(inode);
+	unsigned long flags;
+
+	spin_lock_irqsave(&tracefs_inode_lock, flags);
+	list_del_rcu(&ti->list);
+	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
+
+	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
 }
 
 static ssize_t default_read_file(struct file *file, char __user *buf,
@@ -153,16 +180,39 @@ static void set_tracefs_inode_owner(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
 	struct inode *root_inode = ti->private;
+	kuid_t uid;
+	kgid_t gid;
+
+	uid = root_inode->i_uid;
+	gid = root_inode->i_gid;
+
+	/*
+	 * If the root is not the mount point, then check the root's
+	 * permissions. If it was never set, then default to the
+	 * mount point.
+	 */
+	if (root_inode != d_inode(root_inode->i_sb->s_root)) {
+		struct tracefs_inode *rti;
+
+		rti = get_tracefs(root_inode);
+		root_inode = d_inode(root_inode->i_sb->s_root);
+
+		if (!(rti->flags & TRACEFS_UID_PERM_SET))
+			uid = root_inode->i_uid;
+
+		if (!(rti->flags & TRACEFS_GID_PERM_SET))
+			gid = root_inode->i_gid;
+	}
 
 	/*
 	 * If this inode has never been referenced, then update
 	 * the permissions to the superblock.
 	 */
 	if (!(ti->flags & TRACEFS_UID_PERM_SET))
-		inode->i_uid = root_inode->i_uid;
+		inode->i_uid = uid;
 
 	if (!(ti->flags & TRACEFS_GID_PERM_SET))
-		inode->i_gid = root_inode->i_gid;
+		inode->i_gid = gid;
 }
 
 static int tracefs_permission(struct mnt_idmap *idmap,
@@ -313,6 +363,8 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 	struct inode *inode = d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts = &fsi->mount_opts;
+	struct tracefs_inode *ti;
+	bool update_uid, update_gid;
 	umode_t tmp_mode;
 
 	/*
@@ -332,6 +384,25 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	if (!remount || opts->opts & BIT(Opt_gid))
 		inode->i_gid = opts->gid;
 
+	if (remount && (opts->opts & BIT(Opt_uid) || opts->opts & BIT(Opt_gid))) {
+
+		update_uid = opts->opts & BIT(Opt_uid);
+		update_gid = opts->opts & BIT(Opt_gid);
+
+		rcu_read_lock();
+		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
+			if (update_uid)
+				ti->flags &= ~TRACEFS_UID_PERM_SET;
+
+			if (update_gid)
+				ti->flags &= ~TRACEFS_GID_PERM_SET;
+
+			if (ti->flags & TRACEFS_EVENT_INODE)
+				eventfs_remount(ti, update_uid, update_gid);
+		}
+		rcu_read_unlock();
+	}
+
 	return 0;
 }
 
@@ -398,7 +469,22 @@ static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return !(ei && ei->is_freed);
 }
 
+static void tracefs_d_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	/*
+	 * This inode is being freed and cannot be used for
+	 * eventfs. Clear the flag so that it doesn't call into
+	 * eventfs during the remount flag updates. The eventfs_inode
+	 * gets freed after an RCU cycle, so the content will still
+	 * be safe if the iteration is going on now.
+	 */
+	ti->flags &= ~TRACEFS_EVENT_INODE;
+}
+
 static const struct dentry_operations tracefs_dentry_operations = {
+	.d_iput = tracefs_d_iput,
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
 };
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 15c26f9aaad4..f704d8348357 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -4,15 +4,18 @@
 
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
-	TRACEFS_EVENT_TOP_INODE		= BIT(2),
-	TRACEFS_GID_PERM_SET		= BIT(3),
-	TRACEFS_UID_PERM_SET		= BIT(4),
-	TRACEFS_INSTANCE_INODE		= BIT(5),
+	TRACEFS_GID_PERM_SET		= BIT(2),
+	TRACEFS_UID_PERM_SET		= BIT(3),
+	TRACEFS_INSTANCE_INODE		= BIT(4),
 };
 
 struct tracefs_inode {
-	struct inode            vfs_inode;
+	union {
+		struct inode            vfs_inode;
+		struct rcu_head		rcu;
+	};
 	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
+	struct list_head	list;
 	unsigned long           flags;
 	void                    *private;
 };
@@ -73,6 +76,7 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7a5fe17b6bf9..d03f74658716 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -62,6 +62,8 @@ struct eventfs_file;
 typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 				const struct file_operations **fops);
 
+typedef void (*eventfs_release)(const char *name, void *data);
+
 /**
  * struct eventfs_entry - dynamically created eventfs file call back handler
  * @name:	Then name of the dynamic file in an eventfs directory
@@ -72,6 +74,7 @@ typedef int (*eventfs_callback)(const char *name, umode_t *mode, void **data,
 struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
+	eventfs_release			release;
 };
 
 struct eventfs_inode;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 52f75c36bbca..6ef29eba90ce 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2552,6 +2552,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+/* The file is incremented on creation and freeing the enable file decrements it */
+static void event_release(const char *name, void *data)
+{
+	struct trace_event_file *file = data;
+
+	event_file_put(file);
+}
+
 static int
 event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 {
@@ -2566,6 +2574,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "enable",
 			.callback	= event_callback,
+			.release	= event_release,
 		},
 		{
 			.name		= "filter",
@@ -2634,6 +2643,9 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		return ret;
 	}
 
+	/* Gets decremented on freeing of the "enable" file */
+	event_file_get(file);
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..82b191f33a28 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1989,6 +1989,80 @@ static int user_event_set_tp_name(struct user_event *user)
 	return 0;
 }
 
+/*
+ * Counts how many ';' without a trailing space are in the args.
+ */
+static int count_semis_no_space(char *args)
+{
+	int count = 0;
+
+	while ((args = strchr(args, ';'))) {
+		args++;
+
+		if (!isspace(*args))
+			count++;
+	}
+
+	return count;
+}
+
+/*
+ * Copies the arguments while ensuring all ';' have a trailing space.
+ */
+static char *insert_space_after_semis(char *args, int count)
+{
+	char *fixed, *pos;
+	int len;
+
+	len = strlen(args) + count;
+	fixed = kmalloc(len + 1, GFP_KERNEL);
+
+	if (!fixed)
+		return NULL;
+
+	pos = fixed;
+
+	/* Insert a space after ';' if there is no trailing space. */
+	while (*args) {
+		*pos = *args++;
+
+		if (*pos++ == ';' && !isspace(*args))
+			*pos++ = ' ';
+	}
+
+	*pos = '\0';
+
+	return fixed;
+}
+
+static char **user_event_argv_split(char *args, int *argc)
+{
+	char **split;
+	char *fixed;
+	int count;
+
+	/* Count how many ';' without a trailing space */
+	count = count_semis_no_space(args);
+
+	/* No fixup is required */
+	if (!count)
+		return argv_split(GFP_KERNEL, args, argc);
+
+	/* We must fixup 'field;field' to 'field; field' */
+	fixed = insert_space_after_semis(args, count);
+
+	if (!fixed)
+		return NULL;
+
+	/* We do a normal split afterwards */
+	split = argv_split(GFP_KERNEL, fixed, argc);
+
+	/* We can free since argv_split makes a copy */
+	kfree(fixed);
+
+	return split;
+}
+
 /*
  * Parses the event name, arguments and flags then registers if successful.
  * The name buffer lifetime is owned by this method for success cases only.
@@ -2012,7 +2086,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 		return -EPERM;
 
 	if (args) {
-		argv = argv_split(GFP_KERNEL, args, &argc);
+		argv = user_event_argv_split(args, &argc);
 
 		if (!argv)
 			return -ENOMEM;
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index dcd7509fe2e0..0bb46793dcd4 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -261,6 +261,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Register without separator spacing should still match */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+
 	/* Multiple registers to same name but different args should fail */
 	reg.enable_bit = 29;
 	reg.name_args = (__u64)"__test_event u32 field1;";
@@ -288,6 +294,8 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 	unreg.disable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
+	unreg.disable_bit = 29;
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
 	/* Delete should have been auto-done after close and unregister */
 	close(self->data_fd);

