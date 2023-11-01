Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AAE7DE550
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbjKAR1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344441AbjKAR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:26:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3110F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:26:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2744C43391;
        Wed,  1 Nov 2023 17:26:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qyEzR-00EZtl-2r;
        Wed, 01 Nov 2023 13:26:49 -0400
Message-ID: <20231101172649.691841445@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Nov 2023 13:25:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v6 4/8] eventfs: Save ownership and mode
References: <20231101172541.971928390@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that inodes and dentries are created on the fly, they are also
reclaimed on memory pressure. Since the ownership and file mode are saved
in the inode, if they are freed, any changes to the ownership and mode
will be lost.

To counter this, if the user changes the permissions or ownership, save
them, and when creating the inodes again, restore those changes.

Cc: Ajay Kaher <akaher@vmware.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lkml.kernel.org/r/20231031223420.568912586@goodmis.org

- Resynced to this patch series

 fs/tracefs/event_inode.c | 148 +++++++++++++++++++++++++++++++++++----
 fs/tracefs/internal.h    |  16 +++++
 2 files changed, 151 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index e9625732c52d..93d08e552483 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -40,6 +40,15 @@ static DEFINE_MUTEX(eventfs_mutex);
  */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
+/* Mode is unsigned short, use the upper bits for flags */
+enum {
+	EVENTFS_SAVE_MODE	= BIT(16),
+	EVENTFS_SAVE_UID	= BIT(17),
+	EVENTFS_SAVE_GID	= BIT(18),
+};
+
+#define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
+
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
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
 
@@ -146,6 +262,7 @@ static void free_ei(struct eventfs_inode *ei)
 {
 	kfree_const(ei->name);
 	kfree(ei->d_children);
+	kfree(ei->entry_attrs);
 	kfree(ei);
 }
 
@@ -231,7 +348,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 /**
  * create_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
- * @e_dentry: a pointer to the d_children[] of the @ei
+ * @idx: the index into the d_children[] of the @ei
  * @parent: The parent dentry of the created file.
  * @name: The name of the file to create
  * @mode: The mode of the file.
@@ -244,10 +361,12 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
  * just do a dget() on it and return. Otherwise create the dentry and attach it.
  */
 static struct dentry *
-create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
+create_file_dentry(struct eventfs_inode *ei, int idx,
 		   struct dentry *parent, const char *name, umode_t mode, void *data,
 		   const struct file_operations *fops, bool lookup)
 {
+	struct eventfs_attr *attr = NULL;
+	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
 	bool invalidate = false;
 
@@ -264,13 +383,18 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
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
@@ -378,7 +502,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	if (!lookup)
 		inode_lock(parent->d_inode);
 
-	dentry = create_dir(ei->name, parent);
+	dentry = create_dir(ei, parent);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
@@ -495,8 +619,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
-			create_file_dentry(ei, &ei->d_children[i],
-					   ei_dentry, name, mode, cdata,
+			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
 		}
@@ -629,8 +752,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		r = entry->callback(name, &mode, &cdata, &fops);
 		if (r <= 0)
 			continue;
-		d = create_file_dentry(ei, &ei->d_children[i],
-				       parent, name, mode, cdata, fops, false);
+		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
 			if (ret < 0)
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 5a98e87dd3d1..5f60bcd69289 100644
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
@@ -22,6 +34,8 @@ struct tracefs_inode {
  * @dentry:     the dentry of the directory
  * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
+ * @entry_attrs: Saved mode and ownership of the @d_children
+ * @attr:	Saved mode and ownership of eventfs_inode itself
  * @data:	The private data to pass to the callbacks
  * @is_freed:	Flag set if the eventfs is on its way to be freed
  *                Note if is_freed is set, then dentry is corrupted.
@@ -35,6 +49,8 @@ struct eventfs_inode {
 	struct dentry			*dentry; /* Check is_freed to access */
 	struct dentry			*d_parent;
 	struct dentry			**d_children;
+	struct eventfs_attr		*entry_attrs;
+	struct eventfs_attr		attr;
 	void				*data;
 	/*
 	 * Union - used for deletion
-- 
2.42.0
