Return-Path: <linux-kernel+bounces-54880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D45484B4BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25791F29225
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56264135A46;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007A1350EC;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221359; cv=none; b=qzf4uDzs2Gf9YlG5w8O66NMyJXGlZFOIeIcnlTGgK0FAo9g35LhrMGSQsvEMxc6efP5NcGc5lI4820T9X1TBQgoIycu7UbQNxeV3q1FKqSps4PiK4WkDehVXGc3CDXGXs32631dTvxBxO18u7WrKB4pncpElNOfzheUpXcWGq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221359; c=relaxed/simple;
	bh=PSi5n8hXvrxTnOnndtW7rBtA25suX6bR1nY9wf/5kJE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EDjz0WdkmZMMWKDCN1U0vWptSuQ57uJ18Oo15gn8GB6AsoGWTHnJtLoCWLnEfJP3NmFCf2jpSYfWvtlQ5N2Tf0on+L1FL19sXuNKRdj4kS9hFSoqoYjZdHa1pRvKIrahBNV9BRpq2oxCkoeDk0Fye0IxrfuHGpqaEsExzxSwN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC62C43399;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGp-00000006b3r-1NvX;
	Tue, 06 Feb 2024 07:09:47 -0500
Message-ID: <20240206120947.186364236@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 05/57] Revert "eventfs: Save ownership and mode"
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

This reverts commit 9aaee3eebc91dd9ccebf6b6bc8a5f59d04ef718b.

The eventfs was not designed properly and may have some hidden bugs in it.
Linus rewrote it properly and I trust his version more than this one. Revert
the backported patches for 6.6 and re-apply all the changes to make it
equivalent to Linus's version.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 107 ++++++---------------------------------
 1 file changed, 16 insertions(+), 91 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6a3f7502310c..a64d8fa39e54 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -40,8 +40,6 @@ struct eventfs_inode {
  * @data:	something that the caller will want to get to later on
  * @is_freed:	Flag set if the eventfs is on its way to be freed
  * @mode:	the permission that the file or directory should have
- * @uid:	saved uid if changed
- * @gid:	saved gid if changed
  */
 struct eventfs_file {
 	const char			*name;
@@ -63,22 +61,11 @@ struct eventfs_file {
 	void				*data;
 	unsigned int			is_freed:1;
 	unsigned int			mode:31;
-	kuid_t				uid;
-	kgid_t				gid;
 };
 
 static DEFINE_MUTEX(eventfs_mutex);
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
-/* Mode is unsigned short, use the upper bits for flags */
-enum {
-	EVENTFS_SAVE_MODE	= BIT(16),
-	EVENTFS_SAVE_UID	= BIT(17),
-	EVENTFS_SAVE_GID	= BIT(18),
-};
-
-#define EVENTFS_MODE_MASK	(EVENTFS_SAVE_MODE - 1)
-
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
@@ -86,54 +73,8 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
 static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
 static int eventfs_release(struct inode *inode, struct file *file);
 
-static void update_attr(struct eventfs_file *ef, struct iattr *iattr)
-{
-	unsigned int ia_valid = iattr->ia_valid;
-
-	if (ia_valid & ATTR_MODE) {
-		ef->mode = (ef->mode & ~EVENTFS_MODE_MASK) |
-			(iattr->ia_mode & EVENTFS_MODE_MASK) |
-			EVENTFS_SAVE_MODE;
-	}
-	if (ia_valid & ATTR_UID) {
-		ef->mode |= EVENTFS_SAVE_UID;
-		ef->uid = iattr->ia_uid;
-	}
-	if (ia_valid & ATTR_GID) {
-		ef->mode |= EVENTFS_SAVE_GID;
-		ef->gid = iattr->ia_gid;
-	}
-}
-
-static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
-			     struct iattr *iattr)
-{
-	struct eventfs_file *ef;
-	int ret;
-
-	mutex_lock(&eventfs_mutex);
-	ef = dentry->d_fsdata;
-	/* The LSB is set when the eventfs_inode is being freed */
-	if (((unsigned long)ef & 1UL) || ef->is_freed) {
-		/* Do not allow changes if the event is about to be removed. */
-		mutex_unlock(&eventfs_mutex);
-		return -ENODEV;
-	}
-
-	ret = simple_setattr(idmap, dentry, iattr);
-	if (!ret)
-		update_attr(ef, iattr);
-	mutex_unlock(&eventfs_mutex);
-	return ret;
-}
-
 static const struct inode_operations eventfs_root_dir_inode_operations = {
 	.lookup		= eventfs_root_lookup,
-	.setattr	= eventfs_set_attr,
-};
-
-static const struct inode_operations eventfs_file_inode_operations = {
-	.setattr	= eventfs_set_attr,
 };
 
 static const struct file_operations eventfs_file_operations = {
@@ -144,20 +85,10 @@ static const struct file_operations eventfs_file_operations = {
 	.release	= eventfs_release,
 };
 
-static void update_inode_attr(struct inode *inode, struct eventfs_file *ef)
-{
-	inode->i_mode = ef->mode & EVENTFS_MODE_MASK;
-
-	if (ef->mode & EVENTFS_SAVE_UID)
-		inode->i_uid = ef->uid;
-
-	if (ef->mode & EVENTFS_SAVE_GID)
-		inode->i_gid = ef->gid;
-}
-
 /**
  * create_file - create a file in the tracefs filesystem
- * @ef: the eventfs_file
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
  * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
@@ -173,7 +104,7 @@ static void update_inode_attr(struct inode *inode, struct eventfs_file *ef)
  * If tracefs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-static struct dentry *create_file(struct eventfs_file *ef,
+static struct dentry *create_file(const char *name, umode_t mode,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
@@ -181,13 +112,13 @@ static struct dentry *create_file(struct eventfs_file *ef,
 	struct dentry *dentry;
 	struct inode *inode;
 
-	if (!(ef->mode & S_IFMT))
-		ef->mode |= S_IFREG;
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
 
-	if (WARN_ON_ONCE(!S_ISREG(ef->mode)))
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
 
-	dentry = eventfs_start_creating(ef->name, parent);
+	dentry = eventfs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return dentry;
@@ -196,10 +127,7 @@ static struct dentry *create_file(struct eventfs_file *ef,
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
 
-	/* If the user updated the directory's attributes, use them */
-	update_inode_attr(inode, ef);
-
-	inode->i_op = &eventfs_file_inode_operations;
+	inode->i_mode = mode;
 	inode->i_fop = fop;
 	inode->i_private = data;
 
@@ -212,7 +140,7 @@ static struct dentry *create_file(struct eventfs_file *ef,
 
 /**
  * create_dir - create a dir in the tracefs filesystem
- * @ei: the eventfs_inode that represents the directory to create
+ * @name: the name of the file to create.
  * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  *
@@ -227,14 +155,13 @@ static struct dentry *create_file(struct eventfs_file *ef,
  * If tracefs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-static struct dentry *create_dir(struct eventfs_file *ef,
-				 struct dentry *parent, void *data)
+static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
 {
 	struct tracefs_inode *ti;
 	struct dentry *dentry;
 	struct inode *inode;
 
-	dentry = eventfs_start_creating(ef->name, parent);
+	dentry = eventfs_start_creating(name, parent);
 	if (IS_ERR(dentry))
 		return dentry;
 
@@ -242,8 +169,7 @@ static struct dentry *create_dir(struct eventfs_file *ef,
 	if (unlikely(!inode))
 		return eventfs_failed_creating(dentry);
 
-	update_inode_attr(inode, ef);
-
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 	inode->i_private = data;
@@ -380,9 +306,10 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 		inode_lock(parent->d_inode);
 
 	if (ef->ei)
-		dentry = create_dir(ef, parent, ef->data);
+		dentry = create_dir(ef->name, parent, ef->data);
 	else
-		dentry = create_file(ef, parent, ef->data, ef->fop);
+		dentry = create_file(ef->name, ef->mode, parent,
+				     ef->data, ef->fop);
 
 	if (!lookup)
 		inode_unlock(parent->d_inode);
@@ -548,7 +475,6 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		if (d) {
 			struct dentry **tmp;
 
-
 			tmp = krealloc(dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
 			if (!tmp)
 				break;
@@ -623,14 +549,13 @@ static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
 			return ERR_PTR(-ENOMEM);
 		}
 		INIT_LIST_HEAD(&ef->ei->e_top_files);
-		ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	} else {
 		ef->ei = NULL;
-		ef->mode = mode;
 	}
 
 	ef->iop = iop;
 	ef->fop = fop;
+	ef->mode = mode;
 	ef->data = data;
 	return ef;
 }
-- 
2.43.0



