Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8076A4B7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGaXSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjGaXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5B1BD9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02EFF61367
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599C4C433C9;
        Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8R-003fPs-0z;
        Mon, 31 Jul 2023 19:17:07 -0400
Message-ID: <20230731231707.117214250@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [for-next][PATCH 11/15] eventfs: Implement eventfs lookup, read, open functions
References: <20230731231634.031452225@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Kaher <akaher@vmware.com>

Add the inode_operations, file_operations, and helper functions to eventfs:
dcache_dir_open_wrapper()
eventfs_root_lookup()
eventfs_release()
eventfs_set_ef_status_free()
eventfs_post_create_dir()

The inode_operations and file_operations functions will be called from the
VFS layer.

create_file() and create_dir() are added as stub functions and will be
filled in later.

Link: https://lkml.kernel.org/r/1690568452-46553-7-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 304 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h    |   2 +
 2 files changed, 306 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9e4843be9dc9..24d645c61029 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -31,6 +31,8 @@ struct eventfs_inode {
  * struct eventfs_file - hold the properties of the eventfs files and
  *                       directories.
  * @name:	the name of the file or directory to create
+ * @d_parent:   holds parent's dentry
+ * @dentry:     once accessed holds dentry
  * @list:	file or directory to be added to parent directory
  * @ei:		list of files and directories within directory
  * @fop:	file_operations for file or directory
@@ -40,22 +42,320 @@ struct eventfs_inode {
  */
 struct eventfs_file {
 	const char			*name;
+	struct dentry			*d_parent;
+	struct dentry			*dentry;
 	struct list_head		list;
 	struct eventfs_inode		*ei;
 	const struct file_operations	*fop;
 	const struct inode_operations	*iop;
+	union {
+		struct list_head	del_list; /* list of eventfs_file to delete */
+		struct rcu_head		rcu; /* eventfs_file to delete */
+		unsigned long		is_freed; /* Freed if one of the above is set */
+	};
 	void				*data;
 	umode_t				mode;
 };
 
 static DEFINE_MUTEX(eventfs_mutex);
+DEFINE_STATIC_SRCU(eventfs_srcu);
+
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags);
+static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
+static int eventfs_release(struct inode *inode, struct file *file);
 
 static const struct inode_operations eventfs_root_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup,
 };
 
 static const struct file_operations eventfs_file_operations = {
+	.open		= dcache_dir_open_wrapper,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= generic_file_llseek,
+	.release	= eventfs_release,
+};
+
+/**
+ * create_file - create a file in the tracefs filesystem
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This is the basic "create a file" function for tracefs.  It allows for a
+ * wide range of flexibility in creating a file.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+static struct dentry *create_file(const char *name, umode_t mode,
+				  struct dentry *parent, void *data,
+				  const struct file_operations *fop)
+{
+	return NULL;
 };
 
+/**
+ * create_dir - create a dir in the tracefs filesystem
+ * @name: the name of the file to create.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ *
+ * This is the basic "create a dir" function for eventfs.  It allows for a
+ * wide range of flexibility in creating a dir.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
+{
+	return NULL;
+}
+
+/**
+ * eventfs_set_ef_status_free - set the ef->status to free
+ * @dentry: dentry who's status to be freed
+ *
+ * eventfs_set_ef_status_free will be called if no more
+ * references remain
+ */
+void eventfs_set_ef_status_free(struct dentry *dentry)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_file *ef;
+
+	mutex_lock(&eventfs_mutex);
+	ti_parent = get_tracefs(dentry->d_parent->d_inode);
+	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
+		goto out;
+
+	ef = dentry->d_fsdata;
+	if (!ef)
+		goto out;
+
+	dentry->d_fsdata = NULL;
+	ef->dentry = NULL;
+out:
+	mutex_unlock(&eventfs_mutex);
+}
+
+/**
+ * eventfs_post_create_dir - post create dir routine
+ * @ef: eventfs_file of recently created dir
+ *
+ * Map the meta-data of files within an eventfs dir to their parent dentry
+ */
+static void eventfs_post_create_dir(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child;
+	struct tracefs_inode *ti;
+
+	/* srcu lock already held */
+	/* fill parent-child relation */
+	list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		ef_child->d_parent = ef->dentry;
+	}
+
+	ti = get_tracefs(ef->dentry->d_inode);
+	ti->private = ef->ei;
+}
+
+/**
+ * create_dentry - helper function to create dentry
+ * @ef: eventfs_file of file or directory to create
+ * @parent: parent dentry
+ * @lookup: true if called from lookup routine
+ *
+ * Used to create a dentry for file/dir, executes post dentry creation routine
+ */
+static struct dentry *
+create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
+{
+	bool invalidate = false;
+	struct dentry *dentry;
+
+	mutex_lock(&eventfs_mutex);
+	if (ef->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
+	if (ef->dentry) {
+		dentry = ef->dentry;
+		/* On dir open, up the ref count */
+		if (!lookup)
+			dget(dentry);
+		mutex_unlock(&eventfs_mutex);
+		return dentry;
+	}
+	mutex_unlock(&eventfs_mutex);
+
+	if (!lookup)
+		inode_lock(parent->d_inode);
+
+	if (ef->ei)
+		dentry = create_dir(ef->name, parent, ef->data);
+	else
+		dentry = create_file(ef->name, ef->mode, parent,
+				     ef->data, ef->fop);
+
+	if (!lookup)
+		inode_unlock(parent->d_inode);
+
+	mutex_lock(&eventfs_mutex);
+	if (IS_ERR_OR_NULL(dentry)) {
+		/* If the ef was already updated get it */
+		dentry = ef->dentry;
+		if (dentry && !lookup)
+			dget(dentry);
+		mutex_unlock(&eventfs_mutex);
+		return dentry;
+	}
+
+	if (!ef->dentry && !ef->is_freed) {
+		ef->dentry = dentry;
+		if (ef->ei)
+			eventfs_post_create_dir(ef);
+		dentry->d_fsdata = ef;
+	} else {
+		/* A race here, should try again (unless freed) */
+		invalidate = true;
+	}
+	mutex_unlock(&eventfs_mutex);
+	if (invalidate)
+		d_invalidate(dentry);
+
+	if (lookup || invalidate)
+		dput(dentry);
+
+	return invalidate ? NULL : dentry;
+}
+
+static bool match_event_file(struct eventfs_file *ef, const char *name)
+{
+	bool ret;
+
+	mutex_lock(&eventfs_mutex);
+	ret = !ef->is_freed && strcmp(ef->name, name) == 0;
+	mutex_unlock(&eventfs_mutex);
+
+	return ret;
+}
+
+/**
+ * eventfs_root_lookup - lookup routine to create file/dir
+ * @dir: in which a lookup is being done
+ * @dentry: file/dir dentry
+ * @flags: to pass as flags parameter to simple lookup
+ *
+ * Used to create a dynamic file/dir within @dir. Use the eventfs_inode
+ * list of meta data to find the information needed to create the file/dir.
+ */
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *ret = NULL;
+	int idx;
+
+	ti = get_tracefs(dir);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return NULL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		if (!match_event_file(ef, dentry->d_name.name))
+			continue;
+		ret = simple_lookup(dir, dentry, flags);
+		create_dentry(ef, ef->d_parent, true);
+		break;
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return ret;
+}
+
+/**
+ * eventfs_release - called to release eventfs file/dir
+ * @inode: inode to be released
+ * @file: file to be released (not used)
+ */
+static int eventfs_release(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *dentry;
+	int idx;
+
+	ti = get_tracefs(inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+				 srcu_read_lock_held(&eventfs_srcu)) {
+		mutex_lock(&eventfs_mutex);
+		dentry = ef->dentry;
+		mutex_unlock(&eventfs_mutex);
+		if (dentry)
+			dput(dentry);
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return dcache_dir_close(inode, file);
+}
+
+/**
+ * dcache_dir_open_wrapper - eventfs open wrapper
+ * @inode: not used
+ * @file: dir to be opened (to create its child)
+ *
+ * Used to dynamically create the file/dir within @file. @file is really a
+ * directory and all the files/dirs of the children within @file will be
+ * created. If any of the files/dirs have already been created, their
+ * reference count will be incremented.
+ */
+static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *dentry = file_dentry(file);
+	struct inode *f_inode = file_inode(file);
+	int idx;
+
+	ti = get_tracefs(f_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	idx = srcu_read_lock(&eventfs_srcu);
+	list_for_each_entry_rcu(ef, &ei->e_top_files, list) {
+		create_dentry(ef, dentry, false);
+	}
+	srcu_read_unlock(&eventfs_srcu, idx);
+	return dcache_dir_open(inode, file);
+}
+
 /**
  * eventfs_prepare_ef - helper function to prepare eventfs_file
  * @name: the name of the file/directory to create.
@@ -179,6 +479,7 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	ef->d_parent = parent;
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
@@ -206,6 +507,7 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
@@ -254,6 +556,7 @@ int eventfs_add_events_file(const char *name, umode_t mode,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ei->e_top_files);
+	ef->d_parent = parent;
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
@@ -292,6 +595,7 @@ int eventfs_add_file(const char *name, umode_t mode,
 
 	mutex_lock(&eventfs_mutex);
 	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index f0fd565d59ec..9bfad9d95a4a 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -21,4 +21,6 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
+void eventfs_set_ef_status_free(struct dentry *dentry);
+
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.40.1
