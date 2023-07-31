Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3513176A4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGaXSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjGaXRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B5172A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F1261363
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A26C433CA;
        Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8R-003fQR-1f;
        Mon, 31 Jul 2023 19:17:07 -0400
Message-ID: <20230731231707.328710408@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [for-next][PATCH 12/15] eventfs: Implement functions to create files and dirs when accessed
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

Add create_file() and create_dir() functions to create the files and
directories respectively when they are accessed. The functions will be
called from the lookup operation of the inode_operations or from the open
function of file_operations.

Link: https://lkml.kernel.org/r/1690568452-46553-8-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 61 +++++++++++++++++++++++++++++++--
 fs/tracefs/inode.c       | 74 ++++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h    |  3 ++
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 24d645c61029..5240bd2c81e7 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -101,7 +101,34 @@ static struct dentry *create_file(const char *name, umode_t mode,
 				  struct dentry *parent, void *data,
 				  const struct file_operations *fop)
 {
-	return NULL;
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return NULL;
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	d_instantiate(dentry, inode);
+	fsnotify_create(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
 };
 
 /**
@@ -123,7 +150,31 @@ static struct dentry *create_file(const char *name, umode_t mode,
  */
 static struct dentry *create_dir(const char *name, struct dentry *parent, void *data)
 {
-	return NULL;
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = eventfs_start_creating(name, parent);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
 }
 
 /**
@@ -234,6 +285,12 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 	} else {
 		/* A race here, should try again (unless freed) */
 		invalidate = true;
+
+		/*
+		 * Should never happen unless we get here due to being freed.
+		 * Otherwise it means two dentries exist with the same name.
+		 */
+		WARN_ON_ONCE(!ef->is_freed);
 	}
 	mutex_unlock(&eventfs_mutex);
 	if (invalidate)
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 4acc4b4dfd22..d9273066f25f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -474,6 +474,80 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * eventfs_start_creating - start the process of creating a dentry
+ * @name: Name of the file created for the dentry
+ * @parent: The parent dentry where this dentry will be created
+ *
+ * This is a simple helper function for the dynamically created eventfs
+ * files. When the directory of the eventfs files are accessed, their
+ * dentries are created on the fly. This function is used to start that
+ * process.
+ */
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	int error;
+
+	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
+			      &tracefs_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	/*
+	 * If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = tracefs_mount->mnt_root;
+
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
+
+	if (!IS_ERR(dentry) && dentry->d_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+	}
+
+	if (IS_ERR(dentry))
+		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+
+	return dentry;
+}
+
+/**
+ * eventfs_failed_creating - clean up a failed eventfs dentry creation
+ * @dentry: The dentry to clean up
+ *
+ * If after calling eventfs_start_creating(), a failure is detected, the
+ * resources created by eventfs_start_creating() needs to be cleaned up. In
+ * that case, this function should be called to perform that clean up.
+ */
+struct dentry *eventfs_failed_creating(struct dentry *dentry)
+{
+	dput(dentry);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return NULL;
+}
+
+/**
+ * eventfs_end_creating - Finish the process of creating a eventfs dentry
+ * @dentry: The dentry that has successfully been created.
+ *
+ * This function is currently just a place holder to match
+ * eventfs_start_creating(). In case any synchronization needs to be added,
+ * this function will be used to implement that without having to modify
+ * the callers of eventfs_start_creating().
+ */
+struct dentry *eventfs_end_creating(struct dentry *dentry)
+{
+	return dentry;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 9bfad9d95a4a..69c2b1d87c46 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -21,6 +21,9 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
+struct dentry *eventfs_failed_creating(struct dentry *dentry);
+struct dentry *eventfs_end_creating(struct dentry *dentry);
 void eventfs_set_ef_status_free(struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.40.1
