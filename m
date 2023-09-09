Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7179960D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbjIIDXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIIDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:23:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59261FE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:23:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F9BC433D9;
        Sat,  9 Sep 2023 03:23:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qeoZY-000YeN-2Y;
        Fri, 08 Sep 2023 23:23:48 -0400
Message-ID: <20230909032348.600908517@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Sep 2023 23:16:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 03/15] tracefs/eventfs: Use dput to free the toplevel events directory
References: <20230909031615.047488015@goodmis.org>
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

This issue triggered the following KASAN report:

 ==================================================================
 BUG: KASAN: slab-use-after-free in eventfs_root_lookup+0x88/0x1b0
 Read of size 8 at addr ffff888120130ca0 by task ftracetest/1201

 CPU: 4 PID: 1201 Comm: ftracetest Not tainted 6.5.0-test-10737-g469e0a8194e7 #13
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x57/0x90
  print_report+0xcf/0x670
  ? __pfx_ring_buffer_record_off+0x10/0x10
  ? _raw_spin_lock_irqsave+0x2b/0x70
  ? __virt_addr_valid+0xd9/0x160
  kasan_report+0xd4/0x110
  ? eventfs_root_lookup+0x88/0x1b0
  ? eventfs_root_lookup+0x88/0x1b0
  eventfs_root_lookup+0x88/0x1b0
  ? eventfs_root_lookup+0x33/0x1b0
  __lookup_slow+0x194/0x2a0
  ? __pfx___lookup_slow+0x10/0x10
  ? down_read+0x11c/0x330
  walk_component+0x166/0x220
  link_path_walk.part.0.constprop.0+0x3a3/0x5a0
  ? seqcount_lockdep_reader_access+0x82/0x90
  ? __pfx_link_path_walk.part.0.constprop.0+0x10/0x10
  path_openat+0x143/0x11f0
  ? __lock_acquire+0xa1a/0x3220
  ? __pfx_path_openat+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  do_filp_open+0x166/0x290
  ? __pfx_do_filp_open+0x10/0x10
  ? lock_is_held_type+0xce/0x120
  ? preempt_count_sub+0xb7/0x100
  ? _raw_spin_unlock+0x29/0x50
  ? alloc_fd+0x1a0/0x320
  do_sys_openat2+0x126/0x160
  ? rcu_is_watching+0x34/0x60
  ? __pfx_do_sys_openat2+0x10/0x10
  ? __might_resched+0x2cf/0x3b0
  ? __fget_light+0xdf/0x100
  __x64_sys_openat+0xcd/0x140
  ? __pfx___x64_sys_openat+0x10/0x10
  ? syscall_enter_from_user_mode+0x22/0x90
  ? lockdep_hardirqs_on+0x7d/0x100
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 RIP: 0033:0x7f1dceef5e51
 Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 9a 27 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
 RSP: 002b:00007fff2cddf380 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
 RAX: ffffffffffffffda RBX: 0000000000000241 RCX: 00007f1dceef5e51
 RDX: 0000000000000241 RSI: 000055d7520677d0 RDI: 00000000ffffff9c
 RBP: 000055d7520677d0 R08: 000000000000001e R09: 0000000000000001
 R10: 00000000000001b6 R11: 0000000000000202 R12: 0000000000000000
 R13: 0000000000000003 R14: 000055d752035678 R15: 000055d752067788
  </TASK>

 Allocated by task 1200:
  kasan_save_stack+0x2f/0x50
  kasan_set_track+0x21/0x30
  __kasan_kmalloc+0x8b/0x90
  eventfs_create_events_dir+0x54/0x220
  create_event_toplevel_files+0x42/0x130
  event_trace_add_tracer+0x33/0x180
  trace_array_create_dir+0x52/0xf0
  trace_array_create+0x361/0x410
  instance_mkdir+0x6b/0xb0
  tracefs_syscall_mkdir+0x57/0x80
  vfs_mkdir+0x275/0x380
  do_mkdirat+0x1da/0x210
  __x64_sys_mkdir+0x74/0xa0
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

 Freed by task 1251:
  kasan_save_stack+0x2f/0x50
  kasan_set_track+0x21/0x30
  kasan_save_free_info+0x27/0x40
  __kasan_slab_free+0x106/0x180
  __kmem_cache_free+0x149/0x2e0
  event_trace_del_tracer+0xcb/0x120
  __remove_instance+0x16a/0x340
  instance_rmdir+0x77/0xa0
  tracefs_syscall_rmdir+0x77/0xc0
  vfs_rmdir+0xed/0x2d0
  do_rmdir+0x235/0x280
  __x64_sys_rmdir+0x5f/0x90
  do_syscall_64+0x3b/0xc0
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

 The buggy address belongs to the object at ffff888120130ca0
  which belongs to the cache kmalloc-16 of size 16
 The buggy address is located 0 bytes inside of
  freed 16-byte region [ffff888120130ca0, ffff888120130cb0)

 The buggy address belongs to the physical page:
 page:000000004dbddbb0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x120130
 flags: 0x17ffffc0000800(slab|node=0|zone=2|lastcpupid=0x1fffff)
 page_type: 0xffffffff()
 raw: 0017ffffc0000800 ffff8881000423c0 dead000000000122 0000000000000000
 raw: 0000000000000000 0000000000800080 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff888120130b80: 00 00 fc fc 00 05 fc fc 00 00 fc fc 00 02 fc fc
  ffff888120130c00: 00 07 fc fc 00 00 fc fc 00 00 fc fc fa fb fc fc
 >ffff888120130c80: 00 00 fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
                                ^
  ffff888120130d00: 00 00 fc fc 00 00 fc fc 00 00 fc fc fa fb fc fc
  ffff888120130d80: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ==================================================================

Link: https://lkml.kernel.org/r/20230907024803.250873643@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: Ajay Kaher <akaher@vmware.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 5bdcd5f5331a2 eventfs: ("Implement removal of meta data from eventfs")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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
