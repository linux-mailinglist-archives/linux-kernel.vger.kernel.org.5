Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586C7DD861
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376270AbjJaWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346800AbjJaWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:34:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DCF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 15:34:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C6CC433CC;
        Tue, 31 Oct 2023 22:34:21 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qxxJU-00EPhz-1i;
        Tue, 31 Oct 2023 18:34:20 -0400
Message-ID: <20231031223420.347714541@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 31 Oct 2023 18:33:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH v5 3/7] eventfs: Test for ei->is_freed when accessing ei->dentry
References: <20231031223326.794680978@goodmis.org>
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

The eventfs_inode (ei) is protected by SRCU, but the ei->dentry is not. It
is protected by the eventfs_mutex. Anytime the eventfs_mutex is released,
and access to the ei->dentry needs to be done, it should first check if
ei->is_freed is set under the eventfs_mutex. If it is, then the ei->dentry
is invalid and must not be used. The ei->dentry must only be accessed
under the eventfs_mutex and after checking if ei->is_freed is set.

When the ei is being freed, it will (under the eventfs_mutex) set is_freed
and at the same time move the dentry to a free list to be cleared after
the eventfs_mutex is released. This means that any access to the
ei->dentry must check first if ei->is_freed is set, because if it is, then
the dentry is on its way to be freed.

Also add comments to describe this better.

Link: https://lore.kernel.org/all/CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com/
Link: https://lore.kernel.org/all/CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com/

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lkml.kernel.org/r/20231031193428.347017769@goodmis.org

- Rebased to this series

 fs/tracefs/event_inode.c | 45 ++++++++++++++++++++++++++++++++++------
 fs/tracefs/internal.h    |  3 ++-
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0331d9bd568b..b28f240bbb6d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -24,7 +24,20 @@
 #include <linux/delay.h>
 #include "internal.h"
 
+/*
+ * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
+ * to the ei->dentry must be done under this mutex and after checking
+ * if ei->is_freed is not set. The ei->dentry is released under the
+ * mutex at the same time ei->is_freed is set. If ei->is_freed is set
+ * then the ei->dentry is invalid.
+ */
 static DEFINE_MUTEX(eventfs_mutex);
+
+/*
+ * The eventfs_inode (ei) itself is protected by SRCU. It is released from
+ * its parent's list and will have is_freed set (under eventfs_mutex).
+ * After the SRCU grace period is over, the ei may be freed.
+ */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
 static struct dentry *eventfs_root_lookup(struct inode *dir,
@@ -239,6 +252,10 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 	bool invalidate = false;
 
 	mutex_lock(&eventfs_mutex);
+	if (ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
 	/* If the e_dentry already has a dentry, use it */
 	if (*e_dentry) {
 		/* lookup does not need to up the ref count */
@@ -312,6 +329,8 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 
+	lockdep_assert_held(&eventfs_mutex);
+
 	/* srcu lock already held */
 	/* fill parent-child relation */
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
@@ -325,6 +344,7 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
 
 /**
  * create_dir_dentry - Create a directory dentry for the eventfs_inode
+ * @pei: The eventfs_inode parent of ei.
  * @ei: The eventfs_inode to create the directory for
  * @parent: The dentry of the parent of this directory
  * @lookup: True if this is called by the lookup code
@@ -332,12 +352,17 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
  * This creates and attaches a directory dentry to the eventfs_inode @ei.
  */
 static struct dentry *
-create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
+create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
+		  struct dentry *parent, bool lookup)
 {
 	bool invalidate = false;
 	struct dentry *dentry = NULL;
 
 	mutex_lock(&eventfs_mutex);
+	if (pei->is_freed || ei->is_freed) {
+		mutex_unlock(&eventfs_mutex);
+		return NULL;
+	}
 	if (ei->dentry) {
 		/* If the dentry already has a dentry, use it */
 		dentry = ei->dentry;
@@ -440,7 +465,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	 */
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
-	if (ei)
+	if (ei && !ei->is_freed)
 		ei_dentry = READ_ONCE(ei->dentry);
 	mutex_unlock(&eventfs_mutex);
 
@@ -454,7 +479,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
-		create_dir_dentry(ei_child, ei_dentry, true);
+		create_dir_dentry(ei, ei_child, ei_dentry, true);
 		created = true;
 		break;
 	}
@@ -588,7 +613,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		d = create_dir_dentry(ei_child, parent, false);
+		d = create_dir_dentry(ei, ei_child, parent, false);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
 			if (ret < 0)
@@ -705,12 +730,20 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	ei->nr_entries = size;
 	ei->data = data;
 	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
 
 	mutex_lock(&eventfs_mutex);
-	list_add_tail(&ei->list, &parent->children);
-	ei->d_parent = parent->dentry;
+	if (!parent->is_freed) {
+		list_add_tail(&ei->list, &parent->children);
+		ei->d_parent = parent->dentry;
+	}
 	mutex_unlock(&eventfs_mutex);
 
+	/* Was the parent freed? */
+	if (list_empty(&ei->list)) {
+		free_ei(ei);
+		ei = NULL;
+	}
 	return ei;
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index c7d88aaa949f..5a98e87dd3d1 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -24,6 +24,7 @@ struct tracefs_inode {
  * @d_children: The array of dentries to represent the files when created
  * @data:	The private data to pass to the callbacks
  * @is_freed:	Flag set if the eventfs is on its way to be freed
+ *                Note if is_freed is set, then dentry is corrupted.
  * @nr_entries: The number of items in @entries
  */
 struct eventfs_inode {
@@ -31,7 +32,7 @@ struct eventfs_inode {
 	const struct eventfs_entry	*entries;
 	const char			*name;
 	struct list_head		children;
-	struct dentry			*dentry;
+	struct dentry			*dentry; /* Check is_freed to access */
 	struct dentry			*d_parent;
 	struct dentry			**d_children;
 	void				*data;
-- 
2.42.0
