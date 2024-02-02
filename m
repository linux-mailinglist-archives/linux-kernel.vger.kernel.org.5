Return-Path: <linux-kernel+bounces-50632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21856847BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57ABF1F25544
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697483A10;
	Fri,  2 Feb 2024 22:04:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7C7765D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911468; cv=none; b=CDo+QimMIx+/qxNprIl2OgyBXTuFR8ZXVnVJBIqD9KjmdYnOLqx5AkvmEaRLNqDFHewoEppcjmFP8kdw3ux0YUyif7RxzZSwLZE/EYPhenagQO+XfiO8D0BVGzm8K9NSmr7X08VF8dhxsbMgf0e4Ibr0uyDyqqDxknchqxcXkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911468; c=relaxed/simple;
	bh=GtFzWtwATd2GJ91dm86ZW/I2+4bq2fgstM6aeS5+sCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=k2k+Iy754BPBBLTsF5lcQVt6M8ap2NQu6m5/m/0LrT7s3H09CHIot857Yp0FrhYbl3UuBZGzRZ6QXGb0oSywSmsL5zI2BkIFSpf/J4byfCMVVroXYUUXJZeF+sLLiMBcoxySgoBd6iLaWx775eCzM5fzNNt/kIgcBX1egdjjAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23906C433C7;
	Fri,  2 Feb 2024 22:04:27 +0000 (UTC)
Date: Fri, 2 Feb 2024 17:04:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>, Vincent Donnefort
 <vdonnefort@google.com>
Subject: [GIT PULL] tracing/eventfs: Fixes for 6.8
Message-ID: <20240202170446.005f8b01@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Tracing and eventfs fixes for v6.8:

- Fix the return code for ring_buffer_poll_wait()
  It was returing a -EINVAL instead of EPOLLERR.

- Zero out the tracefs_inode so that all fields are initialized.
  The ti->private could have had stale data, but instead of
  just initializing it to NULL, clear out the entire structure
  when it is allocated.

- Fix a crash in timerlat
  The hrtimer was initialized at read and not open, but is
  canceled at close. If the file was opened and never read
  the close will pass a NULL pointer to hrtime_cancel().

- Rewrite of eventfs.
  Linus wrote a patch series to remove the dentry references in the
  eventfs_inode and to use ref counting and more of proper VFS
  interfaces to make it work.

- Add warning to put_ei() if ei is not set to free. That means
  something is about to free it when it shouldn't.

- Restructure the eventfs_inode to make it more compact, and remove
  the unused llist field.

- Remove the fsnotify*() funtions for when the inodes were being created
  in the lookup code. It doesn't make sense to notify about creation
  just because something is being looked up.

- The inode hard link count was not accurate. It was being updated
  when a file was looked up. The inodes of directories were updating
  their parent inode hard link count every time the inode was created.
  That means if memory reclaim cleaned a stale directory inode and
  the inode was lookup up again, it would increment the parent inode
  again as well. Al Viro said to just have all eventfs directories
  have a hard link count of 1. That tells user space not to trust it.


Please pull the latest trace-v6.8-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8-rc2

Tag SHA1: e80590234dfed2854bbab2689a0ae38626e8f7d6
Head SHA1: ca185770db914869ff9fe773bac5e0e5e4165b83


Daniel Bristot de Oliveira (1):
      tracing/timerlat: Move hrtimer_init to timerlat_fd open()

Linus Torvalds (6):
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused d_parent pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts

Steven Rostedt (Google) (5):
      tracefs: Zero out the tracefs_inode when allocating it
      eventfs: Warn if an eventfs_inode is freed without is_freed being set
      eventfs: Restructure eventfs_inode structure to be more condensed
      eventfs: Remove fsnotify*() functions from lookup()
      eventfs: Keep all directory links at 1

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

----
 fs/tracefs/event_inode.c     | 568 ++++++++++++-------------------------------
 fs/tracefs/inode.c           | 102 ++------
 fs/tracefs/internal.h        |  43 ++--
 kernel/trace/ring_buffer.c   |   2 +-
 kernel/trace/trace_osnoise.c |   6 +-
 5 files changed, 195 insertions(+), 526 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 1c3dd0ad4660..110e8a272189 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -62,6 +62,46 @@ enum {
 
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
+
+	WARN_ON_ONCE(!ei->is_freed);
+
+	kfree(ei->entry_attrs);
+	kfree_const(ei->name);
+	kfree_rcu(ei, rcu);
+}
+
+static inline void put_ei(struct eventfs_inode *ei)
+{
+	if (ei)
+		kref_put(&ei->kref, release_ei);
+}
+
+static inline void free_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		ei->is_freed = 1;
+		put_ei(ei);
+	}
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
@@ -156,33 +196,30 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return ret;
 }
 
-static void update_top_events_attr(struct eventfs_inode *ei, struct dentry *dentry)
+static void update_top_events_attr(struct eventfs_inode *ei, struct super_block *sb)
 {
-	struct inode *inode;
+	struct inode *root;
 
 	/* Only update if the "events" was on the top level */
 	if (!ei || !(ei->attr.mode & EVENTFS_TOPLEVEL))
 		return;
 
 	/* Get the tracefs root inode. */
-	inode = d_inode(dentry->d_sb->s_root);
-	ei->attr.uid = inode->i_uid;
-	ei->attr.gid = inode->i_gid;
+	root = d_inode(sb->s_root);
+	ei->attr.uid = root->i_uid;
+	ei->attr.gid = root->i_gid;
 }
 
 static void set_top_events_ownership(struct inode *inode)
 {
 	struct tracefs_inode *ti = get_tracefs(inode);
 	struct eventfs_inode *ei = ti->private;
-	struct dentry *dentry;
 
 	/* The top events directory doesn't get automatically updated */
 	if (!ei || !ei->is_events || !(ei->attr.mode & EVENTFS_TOPLEVEL))
 		return;
 
-	dentry = ei->dentry;
-
-	update_top_events_attr(ei, dentry);
+	update_top_events_attr(ei, inode->i_sb);
 
 	if (!(ei->attr.mode & EVENTFS_SAVE_UID))
 		inode->i_uid = ei->attr.uid;
@@ -233,10 +270,11 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 
-	mutex_lock(&eventfs_mutex);
 	do {
-		/* The parent always has an ei, except for events itself */
-		ei = dentry->d_parent->d_fsdata;
+		// The parent is stable because we do not do renames
+		dentry = dentry->d_parent;
+		// ... and directories always have d_fsdata
+		ei = dentry->d_fsdata;
 
 		/*
 		 * If the ei is being freed, the ownership of the children
@@ -246,12 +284,10 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 			ei = NULL;
 			break;
 		}
-
-		dentry = ei->dentry;
+		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
-	mutex_unlock(&eventfs_mutex);
 
-	update_top_events_attr(ei, dentry);
+	update_top_events_attr(ei, dentry->d_sb);
 
 	return ei;
 }
@@ -282,11 +318,10 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
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
@@ -294,30 +329,25 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
  * directory. The inode.i_private pointer will point to @data in the open()
  * call.
  */
-static struct dentry *create_file(const char *name, umode_t mode,
+static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
+				  struct dentry *dentry,
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
 		mode |= S_IFREG;
 
 	if (WARN_ON_ONCE(!S_ISREG(mode)))
-		return NULL;
-
-	WARN_ON_ONCE(!parent);
-	dentry = eventfs_start_creating(name, parent);
-
-	if (IS_ERR(dentry))
-		return dentry;
+		return ERR_PTR(-EIO);
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return eventfs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 
 	/* If the user updated the directory's attributes, use them */
 	update_inode_attr(dentry, inode, attr, mode);
@@ -331,32 +361,31 @@ static struct dentry *create_file(const char *name, umode_t mode,
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
-	d_instantiate(dentry, inode);
-	fsnotify_create(dentry->d_parent->d_inode, dentry);
-	return eventfs_end_creating(dentry);
+
+	// Files have their parent's ei as their fsdata
+	dentry->d_fsdata = get_ei(parent_ei);
+
+	d_add(dentry, inode);
+	return NULL;
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
-		return eventfs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 
 	/* If the user updated the directory's attributes, use them */
 	update_inode_attr(dentry, inode, &ei->attr,
@@ -370,64 +399,46 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
+	/* Only directories have ti->private set to an ei, not files */
+	ti->private = ei;
 
-	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	inc_nlink(dentry->d_parent->d_inode);
-	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-	return eventfs_end_creating(dentry);
+	dentry->d_fsdata = get_ei(ei);
+
+	d_add(dentry, inode);
+	return NULL;
 }
 
-static void free_ei(struct eventfs_inode *ei)
+static inline struct eventfs_inode *alloc_ei(const char *name)
 {
-	kfree_const(ei->name);
-	kfree(ei->d_children);
-	kfree(ei->entry_attrs);
-	kfree(ei);
+	struct eventfs_inode *ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+
+	if (!ei)
+		return NULL;
+
+	ei->name = kstrdup_const(name, GFP_KERNEL);
+	if (!ei->name) {
+		kfree(ei);
+		return NULL;
+	}
+	kref_init(&ei->kref);
+	return ei;
 }
 
 /**
- * eventfs_set_ei_status_free - remove the dentry reference from an eventfs_inode
- * @ti: the tracefs_inode of the dentry
+ * eventfs_d_release - dentry is going away
  * @dentry: dentry which has the reference to remove.
  *
  * Remove the association between a dentry from an eventfs_inode.
  */
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
+void eventfs_d_release(struct dentry *dentry)
 {
-	struct eventfs_inode *ei;
-	int i;
-
-	mutex_lock(&eventfs_mutex);
-
-	ei = dentry->d_fsdata;
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
-	}
-
-	dentry->d_fsdata = NULL;
- out:
-	mutex_unlock(&eventfs_mutex);
+	put_ei(dentry->d_fsdata);
 }
 
 /**
- * create_file_dentry - create a dentry for a file of an eventfs_inode
+ * lookup_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
- * @idx: the index into the d_children[] of the @ei
+ * @idx: the index into the entry_attrs[] of the @ei
  * @parent: The parent dentry of the created file.
  * @name: The name of the file to create
  * @mode: The mode of the file.
@@ -438,163 +449,17 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
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
-	struct dentry **e_dentry = &ei->d_children[idx];
-	struct dentry *dentry;
-
-	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
 
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
-
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
-	struct tracefs_inode *ti;
-
-	lockdep_assert_held(&eventfs_mutex);
-
-	/* srcu lock already held */
-	/* fill parent-child relation */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
-		ei_child->d_parent = ei->dentry;
-	}
-
-	ti = get_tracefs(ei->dentry->d_inode);
-	ti->private = ei;
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
-
-	return dentry;
+	return lookup_file(ei, dentry, mode, attr, data, fops);
 }
 
 /**
@@ -611,79 +476,50 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
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
+	struct dentry *result = NULL;
 
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
+	ei = ti->private;
+	if (!ei || ei->is_freed)
 		goto out;
 
-	data = ei->data;
-
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
+	list_for_each_entry(ei_child, &ei->children, list) {
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
-		ret = simple_lookup(dir, dentry, flags);
-		if (IS_ERR(ret))
+		if (ei_child->is_freed)
 			goto out;
-		d = create_dir_dentry(ei, ei_child, ei_dentry);
-		dput(d);
+		result = lookup_dir_entry(dentry, ei, ei_child);
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
+			goto out;
+
+		result = lookup_file_dentry(dentry, ei, i, mode, data, fops);
+		goto out;
 	}
  out:
-	srcu_read_unlock(&eventfs_srcu, idx);
-	return ret;
+	mutex_unlock(&eventfs_mutex);
+	return result;
 }
 
 /*
@@ -833,25 +669,10 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
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
@@ -859,10 +680,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	INIT_LIST_HEAD(&ei->list);
 
 	mutex_lock(&eventfs_mutex);
-	if (!parent->is_freed) {
+	if (!parent->is_freed)
 		list_add_tail(&ei->list, &parent->children);
-		ei->d_parent = parent->dentry;
-	}
 	mutex_unlock(&eventfs_mutex);
 
 	/* Was the parent freed? */
@@ -902,28 +721,20 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
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
@@ -954,11 +765,19 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
-	dentry->d_fsdata = ei;
+	dentry->d_fsdata = get_ei(ei);
 
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
+	/*
+	 * Keep all eventfs directories with i_nlink == 1.
+	 * Due to the dynamic nature of the dentry creations and not
+	 * wanting to add a pointer to the parent eventfs_inode in the
+	 * eventfs_inode structure, keeping the i_nlink in sync with the
+	 * number of directories would cause too much complexity for
+	 * something not worth much. Keeping directory links at 1
+	 * tells userspace not to trust the link number.
+	 */
 	d_instantiate(dentry, inode);
+	/* The dentry of the "events" parent does keep track though */
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
@@ -966,72 +785,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ei;
 
  fail:
-	kfree(ei->d_children);
-	kfree(ei);
- fail_ei:
+	free_ei(ei);
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
@@ -1044,8 +802,6 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 {
 	struct eventfs_inode *ei_child;
 
-	if (!ei)
-		return;
 	/*
 	 * Check recursion depth. It should never be greater than 3:
 	 * 0 - events/
@@ -1057,28 +813,11 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
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
 
-	ei->is_freed = 1;
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
+	free_ei(ei);
 }
 
 /**
@@ -1089,22 +828,12 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
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
@@ -1117,7 +846,11 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
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
@@ -1127,5 +860,6 @@ void eventfs_remove_events_dir(struct eventfs_inode *ei)
 	 * sticks around while the other ei->dentry are created
 	 * and destroyed dynamically.
 	 */
+	d_invalidate(dentry);
 	dput(dentry);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..d65ffad4c327 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -38,8 +38,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	if (!ti)
 		return NULL;
 
-	ti->flags = 0;
-
 	return &ti->vfs_inode;
 }
 
@@ -379,21 +377,30 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
-static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
+/*
+ * It would be cleaner if eventfs had its own dentry ops.
+ *
+ * Note that d_revalidate is called potentially under RCU,
+ * so it can't take the eventfs mutex etc. It's fine - if
+ * we open a file just as it's marked dead, things will
+ * still work just fine, and just see the old stale case.
+ */
+static void tracefs_d_release(struct dentry *dentry)
 {
-	struct tracefs_inode *ti;
+	if (dentry->d_fsdata)
+		eventfs_d_release(dentry);
+}
 
-	if (!dentry || !inode)
-		return;
+static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct eventfs_inode *ei = dentry->d_fsdata;
 
-	ti = get_tracefs(inode);
-	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ei_status_free(ti, dentry);
-	iput(inode);
+	return !(ei && ei->is_freed);
 }
 
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_dentry_iput,
+	.d_revalidate = tracefs_d_revalidate,
+	.d_release = tracefs_d_release,
 };
 
 static int trace_fill_super(struct super_block *sb, void *data, int silent)
@@ -497,75 +504,6 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
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
@@ -779,7 +717,11 @@ static void init_once(void *foo)
 {
 	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
 
+	/* inode_init_once() calls memset() on the vfs_inode portion */
 	inode_init_once(&ti->vfs_inode);
+
+	/* Zero out the rest */
+	memset_after(ti, 0, vfs_inode);
 }
 
 static int __init tracefs_init(void)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 91c2bf0b91d9..beb3dcd0e434 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -11,9 +11,10 @@ enum {
 };
 
 struct tracefs_inode {
+	struct inode            vfs_inode;
+	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
 	unsigned long           flags;
 	void                    *private;
-	struct inode            vfs_inode;
 };
 
 /*
@@ -31,43 +32,37 @@ struct eventfs_attr {
 /*
  * struct eventfs_inode - hold the properties of the eventfs directories.
  * @list:	link list into the parent directory
+ * @rcu:	Union with @list for freeing
+ * @children:	link list into the child eventfs_inode
  * @entries:	the array of entries representing the files in the directory
  * @name:	the name of the directory to create
- * @children:	link list into the child eventfs_inode
- * @dentry:     the dentry of the directory
- * @d_parent:   pointer to the parent's dentry
- * @d_children: The array of dentries to represent the files when created
+ * @events_dir: the dentry of the events directory
  * @entry_attrs: Saved mode and ownership of the @d_children
- * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
+ * @attr:	Saved mode and ownership of eventfs_inode itself
  * @is_freed:	Flag set if the eventfs is on its way to be freed
  *                Note if is_freed is set, then dentry is corrupted.
+ * @is_events:	Flag set for only the top level "events" directory
  * @nr_entries: The number of items in @entries
+ * @ino:	The saved inode number
  */
 struct eventfs_inode {
-	struct list_head		list;
+	union {
+		struct list_head	list;
+		struct rcu_head		rcu;
+	};
+	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
-	struct list_head		children;
-	struct dentry			*dentry; /* Check is_freed to access */
-	struct dentry			*d_parent;
-	struct dentry			**d_children;
+	struct dentry			*events_dir;
 	struct eventfs_attr		*entry_attrs;
-	struct eventfs_attr		attr;
 	void				*data;
+	struct eventfs_attr		attr;
+	struct kref			kref;
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
 	unsigned int			nr_entries:30;
 	unsigned int			ino;
-	/*
-	 * Union - used for deletion
-	 * @llist:	for calling dput() if needed after RCU
-	 * @rcu:	eventfs_inode to delete in RCU
-	 */
-	union {
-		struct llist_node	llist;
-		struct rcu_head		rcu;
-	};
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
@@ -79,9 +74,7 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
-struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
-struct dentry *eventfs_failed_creating(struct dentry *dentry);
-struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
+
+void eventfs_d_release(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 13aaf5e85b81..fd4bfe3ecf01 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -944,7 +944,7 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -EINVAL;
+			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
 		work = &cpu_buffer->irq_work;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..a8e28f9b9271 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2444,6 +2444,9 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	tlat = this_cpu_tmr_var();
 	tlat->count = 0;
 
+	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+	tlat->timer.function = timerlat_irq;
+
 	migrate_enable();
 	return 0;
 };
@@ -2526,9 +2529,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		tlat->tracing_thread = false;
 		tlat->kthread = current;
 
-		hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-		tlat->timer.function = timerlat_irq;
-
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
 

