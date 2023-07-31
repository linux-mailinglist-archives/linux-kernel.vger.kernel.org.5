Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CA76A4B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjGaXRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjGaXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E12E46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D9F61366
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5874C433C9;
        Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8Q-003fOk-2r;
        Mon, 31 Jul 2023 19:17:06 -0400
Message-ID: <20230731231706.704342866@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 09/15] eventfs: Implement eventfs dir creation functions
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

Add eventfs_file structure which will hold the properties of the eventfs
files and directories.

Add following functions to create the directories in eventfs:

eventfs_create_events_dir() will create the top level "events" directory
within the tracefs file system.

eventfs_add_subsystem_dir() creates an eventfs_file descriptor with the
given name of the subsystem.

eventfs_add_dir() creates an eventfs_file descriptor with the given name of
the directory and attached to a eventfs_file of a subsystem.

Add tracefs_inode structure to hold the inodes, flags and pointers to
private data used by eventfs.

Link: https://lkml.kernel.org/r/1690568452-46553-5-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/Makefile      |   1 +
 fs/tracefs/event_inode.c | 211 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h    |   4 +
 include/linux/tracefs.h  |  11 ++
 4 files changed, 227 insertions(+)
 create mode 100644 fs/tracefs/event_inode.c

diff --git a/fs/tracefs/Makefile b/fs/tracefs/Makefile
index 7c35a282b484..73c56da8e284 100644
--- a/fs/tracefs/Makefile
+++ b/fs/tracefs/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 tracefs-objs	:= inode.o
+tracefs-objs	+= event_inode.o
 
 obj-$(CONFIG_TRACING)	+= tracefs.o
 
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
new file mode 100644
index 000000000000..8f334b122e46
--- /dev/null
+++ b/fs/tracefs/event_inode.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  event_inode.c - part of tracefs, a pseudo file system for activating tracing
+ *
+ *  Copyright (C) 2020-23 VMware Inc, author: Steven Rostedt (VMware) <rostedt@goodmis.org>
+ *  Copyright (C) 2020-23 VMware Inc, author: Ajay Kaher <akaher@vmware.com>
+ *
+ *  eventfs is used to dynamically create inodes and dentries based on the
+ *  meta data provided by the tracing system.
+ *
+ *  eventfs stores the meta-data of files/dirs and holds off on creating
+ *  inodes/dentries of the files. When accessed, the eventfs will create the
+ *  inodes/dentries in a just-in-time (JIT) manner. The eventfs will clean up
+ *  and delete the inodes/dentries when they are no longer referenced.
+ */
+#include <linux/fsnotify.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/workqueue.h>
+#include <linux/security.h>
+#include <linux/tracefs.h>
+#include <linux/kref.h>
+#include <linux/delay.h>
+#include "internal.h"
+
+struct eventfs_inode {
+	struct list_head	e_top_files;
+};
+
+/**
+ * struct eventfs_file - hold the properties of the eventfs files and
+ *                       directories.
+ * @name:	the name of the file or directory to create
+ * @list:	file or directory to be added to parent directory
+ * @ei:		list of files and directories within directory
+ * @fop:	file_operations for file or directory
+ * @iop:	inode_operations for file or directory
+ * @data:	something that the caller will want to get to later on
+ * @mode:	the permission that the file or directory should have
+ */
+struct eventfs_file {
+	const char			*name;
+	struct list_head		list;
+	struct eventfs_inode		*ei;
+	const struct file_operations	*fop;
+	const struct inode_operations	*iop;
+	void				*data;
+	umode_t				mode;
+};
+
+static DEFINE_MUTEX(eventfs_mutex);
+
+static const struct inode_operations eventfs_root_dir_inode_operations = {
+};
+
+static const struct file_operations eventfs_file_operations = {
+};
+
+/**
+ * eventfs_prepare_ef - helper function to prepare eventfs_file
+ * @name: the name of the file/directory to create.
+ * @mode: the permission that the file should have.
+ * @fop: struct file_operations that should be used for this file/directory.
+ * @iop: struct inode_operations that should be used for this file/directory.
+ * @data: something that the caller will want to get to later on. The
+ *        inode.i_private pointer will point to this value on the open() call.
+ *
+ * This function allocates and fills the eventfs_file structure.
+ */
+static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
+					const struct file_operations *fop,
+					const struct inode_operations *iop,
+					void *data)
+{
+	struct eventfs_file *ef;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return ERR_PTR(-ENOMEM);
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (S_ISDIR(mode)) {
+		ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
+		if (!ef->ei) {
+			kfree(ef->name);
+			kfree(ef);
+			return ERR_PTR(-ENOMEM);
+		}
+		INIT_LIST_HEAD(&ef->ei->e_top_files);
+	} else {
+		ef->ei = NULL;
+	}
+
+	ef->iop = iop;
+	ef->fop = fop;
+	ef->mode = mode;
+	ef->data = data;
+	return ef;
+}
+
+/**
+ * eventfs_create_events_dir - create the trace event structure
+ * @name: the name of the directory to create.
+ * @parent: parent dentry for this file.  This should be a directory dentry
+ *          if set.  If this parameter is NULL, then the directory will be
+ *          created in the root of the tracefs filesystem.
+ *
+ * This function creates the top of the trace event directory.
+ */
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent)
+{
+	struct dentry *dentry = tracefs_start_creating(name, parent);
+	struct eventfs_inode *ei;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
+	if (!ei)
+		return ERR_PTR(-ENOMEM);
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode)) {
+		kfree(ei);
+		tracefs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&ei->e_top_files);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
+	inode->i_op = &eventfs_root_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return tracefs_end_creating(dentry);
+}
+
+/**
+ * eventfs_add_subsystem_dir - add eventfs subsystem_dir to list to create later
+ * @name: the name of the file to create.
+ * @parent: parent dentry for this dir.
+ *
+ * This function adds eventfs subsystem dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_inode *ei_parent;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	ti_parent = get_tracefs(parent->d_inode);
+	ei_parent = ti_parent->private;
+
+	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
+	if (IS_ERR(ef))
+		return ef;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei_parent->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return ef;
+}
+
+/**
+ * eventfs_add_dir - add eventfs dir to list to create later
+ * @name: the name of the file to create.
+ * @ef_parent: parent eventfs_file for this dir.
+ *
+ * This function adds eventfs dir to list.
+ * And all these dirs are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return ERR_PTR(-EINVAL);
+
+	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
+	if (IS_ERR(ef))
+		return ef;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return ef;
+}
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 7dfb7ebc1c3f..f0fd565d59ec 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,6 +2,10 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
 
+enum {
+	TRACEFS_EVENT_INODE     = BIT(1),
+};
+
 struct tracefs_inode {
 	unsigned long           flags;
 	void                    *private;
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 99912445974c..432e5e6f7901 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -21,6 +21,17 @@ struct file_operations;
 
 #ifdef CONFIG_TRACING
 
+struct eventfs_file;
+
+struct dentry *eventfs_create_events_dir(const char *name,
+					 struct dentry *parent);
+
+struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
+					       struct dentry *parent);
+
+struct eventfs_file *eventfs_add_dir(const char *name,
+				     struct eventfs_file *ef_parent);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.40.1
