Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451ED796F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbjIGCrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjIGCrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:47:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C644019A6;
        Wed,  6 Sep 2023 19:47:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C7C433CB;
        Thu,  7 Sep 2023 02:47:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qe53r-000BHq-1P;
        Wed, 06 Sep 2023 22:48:03 -0400
Message-ID: <20230907024803.250873643@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Sep 2023 22:47:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel events directory
References: <20230907024710.866917011@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Currently when rmdir on an instance is done, eventfs_remove_events_dir()
is called and it does a dput on the dentry and then frees the
eventfs_inode that represents the events directory.

But there's no protection against a reader reading the top level events
directory at the same time and we can get a use after free error. Instead,
use the dput() associated to the dentry to also free the eventfs_inode
associated to the events directory, as that will get called when the last
reference to the directory is released.

Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 5bdcd5f5331a2 eventfs: ("Implement removal of meta data from eventfs")
Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230905183332.628d7cc0@gandalf.local.home
 - Removed left over "ei" variable (kernel test robot)

 fs/tracefs/event_inode.c | 17 ++++++++++++-----
 fs/tracefs/inode.c       |  2 +-
 fs/tracefs/internal.h    |  5 +++--
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fa1a1679a886..609ccb5b7cfc 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -185,17 +185,27 @@ static struct dentry *create_dir(const char *name, struct dentry *parent, void *
 
 /**
  * eventfs_set_ef_status_free - set the ef->status to free
+ * @ti: the tracefs_inode of the dentry
  * @dentry: dentry who's status to be freed
  *
  * eventfs_set_ef_status_free will be called if no more
  * references remain
  */
-void eventfs_set_ef_status_free(struct dentry *dentry)
+void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
 	struct tracefs_inode *ti_parent;
+	struct eventfs_inode *ei;
 	struct eventfs_file *ef;
 
 	mutex_lock(&eventfs_mutex);
+
+	/* The top level events directory may be freed by this */
+	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
+		ei = ti->private;
+		kfree(ei);
+		goto out;
+	}
+
 	ti_parent = get_tracefs(dentry->d_parent->d_inode);
 	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
 		goto out;
@@ -510,7 +520,7 @@ struct dentry *eventfs_create_events_dir(const char *name,
 	INIT_LIST_HEAD(&ei->e_top_files);
 
 	ti = get_tracefs(inode);
-	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
 	ti->private = ei;
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -806,7 +816,6 @@ void eventfs_remove(struct eventfs_file *ef)
 void eventfs_remove_events_dir(struct dentry *dentry)
 {
 	struct tracefs_inode *ti;
-	struct eventfs_inode *ei;
 
 	if (!dentry || !dentry->d_inode)
 		return;
@@ -815,8 +824,6 @@ void eventfs_remove_events_dir(struct dentry *dentry)
 	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
 		return;
 
-	ei = ti->private;
 	d_invalidate(dentry);
 	dput(dentry);
-	kfree(ei);
 }
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 3b8dd938b1c8..891653ba9cf3 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -385,7 +385,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
 
 	ti = get_tracefs(inode);
 	if (ti && ti->flags & TRACEFS_EVENT_INODE)
-		eventfs_set_ef_status_free(dentry);
+		eventfs_set_ef_status_free(ti, dentry);
 	iput(inode);
 }
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 69c2b1d87c46..4f2e49e2197b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -3,7 +3,8 @@
 #define _TRACEFS_INTERNAL_H
 
 enum {
-	TRACEFS_EVENT_INODE     = BIT(1),
+	TRACEFS_EVENT_INODE		= BIT(1),
+	TRACEFS_EVENT_TOP_INODE		= BIT(2),
 };
 
 struct tracefs_inode {
@@ -24,6 +25,6 @@ struct inode *tracefs_get_inode(struct super_block *sb);
 struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
 struct dentry *eventfs_failed_creating(struct dentry *dentry);
 struct dentry *eventfs_end_creating(struct dentry *dentry);
-void eventfs_set_ef_status_free(struct dentry *dentry);
+void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.40.1
