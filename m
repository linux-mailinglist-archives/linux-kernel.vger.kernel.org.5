Return-Path: <linux-kernel+bounces-54895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339384B4ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FFF1C24032
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30713B28E;
	Tue,  6 Feb 2024 12:09:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3B136986;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221361; cv=none; b=YUQscIpj1iFd6tpLoYmeQ22iusLVcY/3/8F/YfUIpySS9ohTHHgk0egi2ErkUuZemc5ROtr+j8tO/lF8ZF2IpwmJp0/49tSzW5443Qcf6MuctvZf6c2YGAR6v6PkaJ5IPFQFs3jXX7Laze4fYe2T1/hVaofZXPOqKbjNLM910OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221361; c=relaxed/simple;
	bh=LPHCUC+XOE6a+rTOOpSZFitJzU53rMUz6survkIA3Ss=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rMYNjOFtnbwAPJtTe6pfzzAklTRJG066nU5uTpcigs1s0CmvMFKmMpcnnc2F3FodAEu5pcxVu4TVJZDCO8BfLL91GpJVmgRpudXmirOXYE19hZcG3rmoLE8d3yCtKifT8HEz9pH5CFMWvn/mkNxXOITKu9LRW8rfZJdC0TBxexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1F5C43601;
	Tue,  6 Feb 2024 12:09:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGr-00000006bAq-2Y1s;
	Tue, 06 Feb 2024 07:09:49 -0500
Message-ID: <20240206120949.464245650@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <akaher@vmware.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [v6.6][PATCH 19/57] eventfs: Save ownership and mode
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that inodes and dentries are created on the fly, they are also
reclaimed on memory pressure. Since the ownership and file mode are saved
in the inode, if they are freed, any changes to the ownership and mode
will be lost.

To counter this, if the user changes the permissions or ownership, save
them, and when creating the inodes again, restore those changes.

Link: https://lkml.kernel.org/r/20231101172649.691841445@goodmis.org

Cc: stable@vger.kernel.org
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 28e12c09f5aa081b2d13d1340e3610070b6c624d)
---
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
2.43.0



