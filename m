Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDD76A4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGaXRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjGaXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFD19F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4667B61368
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2277EC433C7;
        Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8R-003fPJ-0J;
        Mon, 31 Jul 2023 19:17:07 -0400
Message-ID: <20230731231706.909732489@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 10/15] eventfs: Implement eventfs file add functions
References: <20230731231634.031452225@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Kaher <akaher@vmware.com>

Add the following functions to add files to evenfs:

eventfs_add_events_file() to add the data needed to create a specific file
located at the top level events directory. The dentry/inode will be
created when the events directory is scanned.

eventfs_add_file() to add the data needed for files within the directories
below the top level events directory. The dentry/inode of the file will be
created when the directory that the file is in is scanned.

Link: https://lkml.kernel.org/r/1690568452-46553-6-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 86 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  8 ++++
 2 files changed, 94 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 8f334b122e46..9e4843be9dc9 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -209,3 +209,89 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
+
+/**
+ * eventfs_add_events_file - add the data needed to create a file for later reference
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This function is used to add the information needed to create a
+ * dentry/inode within the top level events directory. The file created
+ * will have the @mode permissions. The @data will be used to fill the
+ * inode.i_private when the open() call is done. The dentry and inodes are
+ * all created when they are referenced, and removed when they are no
+ * longer referenced.
+ */
+int eventfs_add_events_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (!parent->d_inode)
+		return -EINVAL;
+
+	ti = get_tracefs(parent->d_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: parent eventfs_file for this file.
+ * @data: something that the caller will want to get to later on.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This function is used to add the information needed to create a
+ * file within a subdirectory of the events directory. The file created
+ * will have the @mode permissions. The @data will be used to fill the
+ * inode.i_private when the open() call is done. The dentry and inodes are
+ * all created when they are referenced, and removed when they are no
+ * longer referenced.
+ */
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent,
+		     void *data,
+		     const struct file_operations *fop)
+{
+	struct eventfs_file *ef;
+
+	if (!ef_parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 432e5e6f7901..54c9cbd0389b 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -32,6 +32,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent);
 
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent, void *data,
+		     const struct file_operations *fops);
+
+int eventfs_add_events_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fops);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.40.1
