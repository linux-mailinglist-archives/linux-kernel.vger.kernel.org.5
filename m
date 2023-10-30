Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518D7DBD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjJ3QEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjJ3QEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:04:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB910C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:04:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCADDC433C8;
        Mon, 30 Oct 2023 16:04:34 +0000 (UTC)
Date:   Mon, 30 Oct 2023 12:04:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2] eventfs: Save ownership and mode
Message-ID: <20231030120433.390fac5e@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that inodes and dentries are created on the fly, they are also
reclaimed on memory pressure. Since the ownership and file mode are saved
in the inode, if they are freed, any changes to the ownership and mode
will be lost.

To counter this, if the user changes the permissions or ownership, save
them, and when creating the inodes again, restore those changes.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20231029182345.0803e6c2@rorschach.local.home/

  - Fixed kerneldoc reported by https://lore.kernel.org/all/202310301225.vJemUpaL-lkp@intel.com/

 fs/tracefs/event_inode.c | 148 +++++++++++++++++++++++++++++++++++----
 fs/tracefs/internal.h    |  15 ++++
 2 files changed, 150 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 45bddce7c747..7ad7496bd597 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -33,6 +33,15 @@
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
+/* Mode is unsigned short, use the upper bits for flags */
+enum {
+	EVENTFS_SAVE_MODE	= BIT(16),
+	EVENTFS_SAVE_UID	= BIT(17),
+	EVENTFS_SAVE_GID	= BIT(18),
+};
+
+#define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
+
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
@@ -47,8 +56,89 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
 static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
 static int eventfs_release(struct inode *inode, struct file *file);
 
+static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
+{
+	unsigned int ia_valid = iattr->ia_valid;
+
+	if (ia_valid & ATTR_MODE) {
+		attr->mode = (attr->mode & ~EVENTFS_MODE_MASK) |
+			(iattr->ia_mode & EVENTFS_MODE_MASK) |
+			EVENTFS_SAVE_MODE;
+	}
+	if (ia_valid & ATTR_UID) {
+		attr->mode |= EVENTFS_SAVE_UID;
+		attr->uid = iattr->ia_uid;
+	}
+	if (ia_valid & ATTR_GID) {
+		attr->mode |= EVENTFS_SAVE_GID;
+		attr->gid = iattr->ia_gid;
+	}
+}
+
+static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    struct iattr *iattr)
+{
+	const struct eventfs_entry *entry;
+	struct eventfs_inode *ei;
+	const char *name;
+	int ret;
+
+	mutex_lock(&eventfs_mutex);
+	ei = dentry->d_fsdata;
+	/* The LSB is set when the eventfs_inode is being freed */
+	if (((unsigned long)ei & 1UL) || ei->is_freed) {
+		/* Do not allow changes if the event is about to be removed. */
+		mutex_unlock(&eventfs_mutex);
+		return -ENODEV;
+	}
+
+	/* Preallocate the children mode array if necessary */
+	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
+		if (!ei->entry_attrs) {
+			ei->entry_attrs = kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
+						  GFP_KERNEL);
+			if (!ei->entry_attrs) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+	}
+
+	ret = simple_setattr(idmap, dentry, iattr);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If this is a dir, then update the ei cache, only the file
+	 * mode is saved in the ei->m_children, and the ownership is
+	 * determined by the parent directory.
+	 */
+	if (dentry->d_inode->i_mode & S_IFDIR) {
+		update_attr(&ei->attr, iattr);
+
+	} else {
+		name = dentry->d_name.name;
+
+		for (int i = 0; i < ei->nr_entries; i++) {
+			entry = &ei->entries[i];
+			if (strcmp(name, entry->name) == 0) {
+				update_attr(&ei->entry_attrs[i], iattr);
+				break;
+			}
+		}
+	}
+ out:
+	mutex_unlock(&eventfs_mutex);
+	return ret;
+}
+
 static const struct inode_operations eventfs_root_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
+	.setattr	= eventfs_set_attr,
+};
+
+static const struct inode_operations eventfs_file_inode_operations = {
+	.setattr	= eventfs_set_attr,
 };
 
 static const struct file_operations eventfs_file_operations = {
@@ -59,10 +149,30 @@ static const struct file_operations eventfs_file_operations = {
 	.release	= eventfs_release,
 };
 
+static void update_inode_attr(struct inode *inode, struct eventfs_attr *attr, umode_t mode)
+{
+	if (!attr) {
+		inode->i_mode = mode;
+		return;
+	}
+
+	if (attr->mode & EVENTFS_SAVE_MODE)
+		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
+	else
+		inode->i_mode = mode;
+
+	if (attr->mode & EVENTFS_SAVE_UID)
+		inode->i_uid = attr->uid;
+
+	if (attr->mode & EVENTFS_SAVE_GID)
+		inode->i_gid = attr->gid;
+}
+
 /**
  * create_file - create a file in the tracefs filesystem
  * @name: the name of the file to create.
  * @mode: the permission that the file should have.
+ * @attr: saved attributes changed by user
  * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
@@ -72,6 +182,7 @@ static const struct file_operations eventfs_file_operations = {
  * call.
  */
 static struct dentry *create_file(const char *name, umode_t mode,
+				  struct eventfs_attr *attr,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
@@ -95,7 +206,10 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
 
-	inode->i_mode = mode;
+	/* If the user updated the directory's attributes, use them */
+	update_inode_attr(inode, attr, mode);
+
+	inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
 	inode->i_private = data;
 
@@ -108,19 +222,19 @@ static struct dentry *create_file(const char *name, umode_t mode,
 
 /**
  * create_dir - create a dir in the tracefs filesystem
- * @name: the name of the file to create.
+ * @ei: the eventfs_inode that represents the directory to create
  * @parent: parent dentry for this file.
  *
  * This function will create a dentry for a directory represented by
  * a eventfs_inode.
  */
-static struct dentry *create_dir(const char *name, struct dentry *parent)
+static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
 	struct inode *inode;
 
-	dentry = eventfs_start_creating(name, parent);
+	dentry = eventfs_start_creating(ei->name, parent);
 	if (IS_ERR(dentry))
 		return dentry;
 
@@ -128,7 +242,9 @@ static struct dentry *create_dir(const char *name, struct dentry *parent)
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
 
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	/* If the user updated the directory's attributes, use them */
+	update_inode_attr(inode, &ei->attr, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
+
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
@@ -226,7 +342,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 /**
  * create_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
- * @e_dentry: a pointer to the d_children[] of the @ei
+ * @idx: the index into the d_children[] of the @ei
  * @parent: The parent dentry of the created file.
  * @name: The name of the file to create
  * @mode: The mode of the file.
@@ -239,11 +355,13 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
  * just do a dget() on it and return. Otherwise create the dentry and attach it.
  */
 static struct dentry *
-create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
+create_file_dentry(struct eventfs_inode *ei, int idx,
 		   struct dentry *parent, const char *name, umode_t mode, void *data,
 		   const struct file_operations *fops, bool lookup)
 {
+	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
+	struct eventfs_attr *attr = NULL;
 	bool invalidate = false;
 
 	mutex_lock(&eventfs_mutex);
@@ -259,13 +377,18 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 		mutex_unlock(&eventfs_mutex);
 		return *e_dentry;
 	}
+
+	/* ei->entry_attrs are protected by SRCU */
+	if (ei->entry_attrs)
+		attr = &ei->entry_attrs[idx];
+
 	mutex_unlock(&eventfs_mutex);
 
 	/* The lookup already has the parent->d_inode locked */
 	if (!lookup)
 		inode_lock(parent->d_inode);
 
-	dentry = create_file(name, mode, parent, data, fops);
+	dentry = create_file(name, mode, attr, parent, data, fops);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
@@ -373,7 +496,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	if (!lookup)
 		inode_lock(parent->d_inode);
 
-	dentry = create_dir(ei->name, parent);
+	dentry = create_dir(ei, parent);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
@@ -490,8 +613,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
-			create_file_dentry(ei, &ei->d_children[i],
-					   ei_dentry, name, mode, cdata,
+			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
 		}
@@ -624,8 +746,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		r = entry->callback(name, &mode, &cdata, &fops);
 		if (r <= 0)
 			continue;
-		d = create_file_dentry(ei, &ei->d_children[i],
-				       parent, name, mode, cdata, fops, false);
+		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
 			if (ret < 0)
@@ -666,6 +787,7 @@ static void free_ei(struct eventfs_inode *ei)
 {
 	kfree_const(ei->name);
 	kfree(ei->d_children);
+	kfree(ei->entry_attrs);
 	kfree(ei);
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 21a1fa682b74..3d519455477d 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -13,6 +13,18 @@ struct tracefs_inode {
 	struct inode            vfs_inode;
 };
 
+/*
+ * struct eventfs_attr - cache the mode and ownership of a eventfs entry
+ * @mode:	saved mode plus flags of what is saved
+ * @uid:	saved uid if changed
+ * @gid:	saved gid if changed
+ */
+struct eventfs_attr {
+	int				mode;
+	kuid_t				uid;
+	kgid_t				gid;
+};
+
 /*
  * struct eventfs_inode - hold the properties of the eventfs directories.
  * @list:	link list into the parent directory
@@ -22,6 +34,7 @@ struct tracefs_inode {
  * @dentry:     the dentry of the directory
  * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
+ * @entry_attrs: Saved mode and ownership of the children
  * @data:	The private data to pass to the callbacks
  * @nr_entries: The number of items in @entries
  */
@@ -33,7 +46,9 @@ struct eventfs_inode {
 	struct dentry			*dentry; /* Check is_freed to access */
 	struct dentry			*d_parent;
 	struct dentry			**d_children;
+	struct eventfs_attr		*entry_attrs;
 	void				*data;
+	struct eventfs_attr		attr;
 	/*
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_inode to delete
-- 
2.42.0

