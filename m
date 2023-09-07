Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED05797E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjIGV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIGV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:58:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D21BC1;
        Thu,  7 Sep 2023 14:58:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DF3C433C8;
        Thu,  7 Sep 2023 21:58:43 +0000 (UTC)
Date:   Thu, 7 Sep 2023 17:58:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] tracefs/eventfs: Free top level files on removal
Message-ID: <20230907175859.6fedbaa2@gandalf.local.home>
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

When an instance is removed, the top level files of the eventfs directory
are not cleaned up. Call the eventfs_remove() on each of the entries to
free them.

This was found via kmemleak:

unreferenced object 0xffff8881047c1280 (size 96):
  comm "mkdir", pid 924, jiffies 4294906489 (age 2013.077s)
  hex dump (first 32 bytes):
    18 31 ed 03 81 88 ff ff 00 31 09 24 81 88 ff ff  .1.......1.$....
    00 00 00 00 00 00 00 00 98 19 7c 04 81 88 ff ff  ..........|.....
  backtrace:
    [<000000000fa46b4d>] kmalloc_trace+0x2a/0xa0
    [<00000000e729cd0c>] eventfs_prepare_ef.constprop.0+0x3a/0x160
    [<000000009032e6a8>] eventfs_add_events_file+0xa0/0x160
    [<00000000fe968442>] create_event_toplevel_files+0x6f/0x130
    [<00000000e364d173>] event_trace_add_tracer+0x14/0x140
    [<00000000411840fa>] trace_array_create_dir+0x52/0xf0
    [<00000000967804fa>] trace_array_create+0x208/0x370
    [<00000000da505565>] instance_mkdir+0x6b/0xb0
    [<00000000dc1215af>] tracefs_syscall_mkdir+0x5b/0x90
    [<00000000a8aca289>] vfs_mkdir+0x272/0x380
    [<000000007709b242>] do_mkdirat+0xfc/0x1d0
    [<00000000c0b6d219>] __x64_sys_mkdir+0x78/0xa0
    [<0000000097b5dd4b>] do_syscall_64+0x3f/0x90
    [<00000000a3f00cfa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
unreferenced object 0xffff888103ed3118 (size 8):
  comm "mkdir", pid 924, jiffies 4294906489 (age 2013.077s)
  hex dump (first 8 bytes):
    65 6e 61 62 6c 65 00 00                          enable..
  backtrace:
    [<0000000010f75127>] __kmalloc_node_track_caller+0x51/0x160
    [<000000004b3eca91>] kstrdup+0x34/0x60
    [<0000000050074d7a>] eventfs_prepare_ef.constprop.0+0x53/0x160
    [<000000009032e6a8>] eventfs_add_events_file+0xa0/0x160
    [<00000000fe968442>] create_event_toplevel_files+0x6f/0x130
    [<00000000e364d173>] event_trace_add_tracer+0x14/0x140
    [<00000000411840fa>] trace_array_create_dir+0x52/0xf0
    [<00000000967804fa>] trace_array_create+0x208/0x370
    [<00000000da505565>] instance_mkdir+0x6b/0xb0
    [<00000000dc1215af>] tracefs_syscall_mkdir+0x5b/0x90
    [<00000000a8aca289>] vfs_mkdir+0x272/0x380
    [<000000007709b242>] do_mkdirat+0xfc/0x1d0
    [<00000000c0b6d219>] __x64_sys_mkdir+0x78/0xa0
    [<0000000097b5dd4b>] do_syscall_64+0x3f/0x90
    [<00000000a3f00cfa>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 5bdcd5f5331a2 eventfs: ("Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

This is on top of:

   https://lore.kernel.org/linux-trace-kernel/20230907024710.866917011@goodmis.org/

 fs/tracefs/event_inode.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 609ccb5b7cfc..f168aca45458 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -195,17 +195,39 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
 	struct tracefs_inode *ti_parent;
 	struct eventfs_inode *ei;
-	struct eventfs_file *ef;
-
-	mutex_lock(&eventfs_mutex);
+	struct eventfs_file *ef, *tmp;
 
 	/* The top level events directory may be freed by this */
 	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
+		LIST_HEAD(ef_del_list);
+
+		mutex_lock(&eventfs_mutex);
+
 		ei = ti->private;
+
+		/* Record all the top level files */
+		list_for_each_entry_srcu(ef, &ei->e_top_files, list,
+					 lockdep_is_held(&eventfs_mutex)) {
+			list_add_tail(&ef->del_list, &ef_del_list);
+		}
+
+		/* Nothing should access this, but just in case! */
+		ti->private = NULL;
+
+		mutex_unlock(&eventfs_mutex);
+
+		/* Now safely free the top level files and their children */
+		list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
+			list_del(&ef->del_list);
+			eventfs_remove(ef);
+		}
+
 		kfree(ei);
-		goto out;
+		return;
 	}
 
+	mutex_lock(&eventfs_mutex);
+
 	ti_parent = get_tracefs(dentry->d_parent->d_inode);
 	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
 		goto out;
-- 
2.40.1

