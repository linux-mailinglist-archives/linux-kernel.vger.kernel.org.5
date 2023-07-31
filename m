Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D0076A4B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGaXRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGaXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E11170D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02A096134F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D2BC433CC;
        Mon, 31 Jul 2023 23:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8Q-003fNd-1X;
        Mon, 31 Jul 2023 19:17:06 -0400
Message-ID: <20230731231706.293833513@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [for-next][PATCH 07/15] eventfs: Implement tracefs_inode_cache
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

Create a kmem cache of tracefs_inodes. To be more efficient, as there are
lots of tracefs inodes, create its own cache. This also allows to see how
many tracefs inodes have been created.

Add helper functions:
tracefs_alloc_inode()
tracefs_free_inode()
get_tracefs()

Link: https://lkml.kernel.org/r/1690568452-46553-3-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c    | 39 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/internal.h | 15 +++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 fs/tracefs/internal.h

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a724..2508944cc4d8 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,13 +21,33 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include "internal.h"
 
 #define TRACEFS_DEFAULT_MODE	0700
+static struct kmem_cache *tracefs_inode_cachep __ro_after_init;
 
 static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static struct inode *tracefs_alloc_inode(struct super_block *sb)
+{
+	struct tracefs_inode *ti;
+
+	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	if (!ti)
+		return NULL;
+
+	ti->flags = 0;
+
+	return &ti->vfs_inode;
+}
+
+static void tracefs_free_inode(struct inode *inode)
+{
+	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -346,6 +366,9 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 static const struct super_operations tracefs_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.drop_inode     = generic_delete_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
@@ -628,10 +651,26 @@ bool tracefs_initialized(void)
 	return tracefs_registered;
 }
 
+static void init_once(void *foo)
+{
+	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
+
+	inode_init_once(&ti->vfs_inode);
+}
+
 static int __init tracefs_init(void)
 {
 	int retval;
 
+	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
+						 sizeof(struct tracefs_inode),
+						 0, (SLAB_RECLAIM_ACCOUNT|
+						     SLAB_MEM_SPREAD|
+						     SLAB_ACCOUNT),
+						 init_once);
+	if (!tracefs_inode_cachep)
+		return -ENOMEM;
+
 	retval = sysfs_create_mount_point(kernel_kobj, "tracing");
 	if (retval)
 		return -EINVAL;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
new file mode 100644
index 000000000000..954ea005632b
--- /dev/null
+++ b/fs/tracefs/internal.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TRACEFS_INTERNAL_H
+#define _TRACEFS_INTERNAL_H
+
+struct tracefs_inode {
+	unsigned long           flags;
+	void                    *private;
+	struct inode            vfs_inode;
+};
+
+static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
+{
+	return container_of(inode, struct tracefs_inode, vfs_inode);
+}
+#endif /* _TRACEFS_INTERNAL_H */
-- 
2.40.1
