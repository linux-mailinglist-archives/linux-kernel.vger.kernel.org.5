Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296C81247D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442940AbjLNBVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjLNBVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:21:37 -0500
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7BBD62;
        Wed, 13 Dec 2023 17:21:10 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SrDzh0kCQz1Q6Pg;
        Thu, 14 Dec 2023 09:20:00 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
        by mail.maildlp.com (Postfix) with ESMTPS id 749E018001A;
        Thu, 14 Dec 2023 09:21:08 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 09:21:08 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <yeweihua4@huawei.com>, <zhengyejian1@huawei.com>
Subject: [PATCH v3] tracing: Fix uaf issue when open the hist or hist_debug file
Date:   Thu, 14 Dec 2023 09:21:53 +0800
Message-ID: <20231214012153.676155-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213080127.6ef26247@gandalf.local.home>
References: <20231213080127.6ef26247@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN report following issue. The root cause is when opening 'hist'
file of an instance and accessing 'trace_event_file' in hist_show(),
but 'trace_event_file' has been freed due to the instance being removed.
'hist_debug' file has the same problem. To fix it, call
tracing_{open,release}_file_tr() in file_operations callback to have
the ref count and avoid 'trace_event_file' being freed.

  BUG: KASAN: slab-use-after-free in hist_show+0x11e0/0x1278
  Read of size 8 at addr ffff242541e336b8 by task head/190

  CPU: 4 PID: 190 Comm: head Not tainted 6.7.0-rc5-g26aff849438c #133
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x98/0xf8
   show_stack+0x1c/0x30
   dump_stack_lvl+0x44/0x58
   print_report+0xf0/0x5a0
   kasan_report+0x80/0xc0
   __asan_report_load8_noabort+0x1c/0x28
   hist_show+0x11e0/0x1278
   seq_read_iter+0x344/0xd78
   seq_read+0x128/0x1c0
   vfs_read+0x198/0x6c8
   ksys_read+0xf4/0x1e0
   __arm64_sys_read+0x70/0xa8
   invoke_syscall+0x70/0x260
   el0_svc_common.constprop.0+0xb0/0x280
   do_el0_svc+0x44/0x60
   el0_svc+0x34/0x68
   el0t_64_sync_handler+0xb8/0xc0
   el0t_64_sync+0x168/0x170

  Allocated by task 188:
   kasan_save_stack+0x28/0x50
   kasan_set_track+0x28/0x38
   kasan_save_alloc_info+0x20/0x30
   __kasan_slab_alloc+0x6c/0x80
   kmem_cache_alloc+0x15c/0x4a8
   trace_create_new_event+0x84/0x348
   __trace_add_new_event+0x18/0x88
   event_trace_add_tracer+0xc4/0x1a0
   trace_array_create_dir+0x6c/0x100
   trace_array_create+0x2e8/0x568
   instance_mkdir+0x48/0x80
   tracefs_syscall_mkdir+0x90/0xe8
   vfs_mkdir+0x3c4/0x610
   do_mkdirat+0x144/0x200
   __arm64_sys_mkdirat+0x8c/0xc0
   invoke_syscall+0x70/0x260
   el0_svc_common.constprop.0+0xb0/0x280
   do_el0_svc+0x44/0x60
   el0_svc+0x34/0x68
   el0t_64_sync_handler+0xb8/0xc0
   el0t_64_sync+0x168/0x170

  Freed by task 191:
   kasan_save_stack+0x28/0x50
   kasan_set_track+0x28/0x38
   kasan_save_free_info+0x34/0x58
   __kasan_slab_free+0xe4/0x158
   kmem_cache_free+0x19c/0x508
   event_file_put+0xa0/0x120
   remove_event_file_dir+0x180/0x320
   event_trace_del_tracer+0xb0/0x180
   __remove_instance+0x224/0x508
   instance_rmdir+0x44/0x78
   tracefs_syscall_rmdir+0xbc/0x140
   vfs_rmdir+0x1cc/0x4c8
   do_rmdir+0x220/0x2b8
   __arm64_sys_unlinkat+0xc0/0x100
   invoke_syscall+0x70/0x260
   el0_svc_common.constprop.0+0xb0/0x280
   do_el0_svc+0x44/0x60
   el0_svc+0x34/0x68
   el0t_64_sync_handler+0xb8/0xc0
   el0t_64_sync+0x168/0x170

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c             |  6 ++++++
 kernel/trace/trace.h             |  1 +
 kernel/trace/trace_events_hist.c | 12 ++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

v3:
  - As suggested by Steve, put the tracing_single_release_file_tr() into
    trace.c as a non static function, put the prototype in trace.h.
    Link: https://lore.kernel.org/all/20231213080127.6ef26247@gandalf.local.home/

v2:
  - Introduce tracing_single_release_file_tr() to add the missing call for
    single_release() as suggested by Steve;
    Link: https://lore.kernel.org/all/20231212113546.6a51d359@gandalf.local.home/
  - Slightly modify the commit message and comments.
  - Link: https://lore.kernel.org/all/20231213015138.281888-1-zhengyejian1@huawei.com/

v1:
  Link: https://lore.kernel.org/all/20231212113317.4159890-1-zhengyejian1@huawei.com/

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fbcd3bafb93e..fc1b2ada98a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4964,6 +4964,12 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
+{
+	tracing_release_file_tr(inode, filp);
+	return single_release(inode, filp);
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b7f4ea25a194..0489e72c8169 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -617,6 +617,7 @@ int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
+int tracing_single_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1abc07fba1b9..5ecf3c8bde20 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5623,10 +5623,12 @@ static int event_hist_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	/* Clear private_data to avoid warning in single_open() */
+	file->private_data = NULL;
 	return single_open(file, hist_show, file);
 }
 
@@ -5634,7 +5636,7 @@ const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = tracing_single_release_file_tr,
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
@@ -5900,10 +5902,12 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	/* Clear private_data to avoid warning in single_open() */
+	file->private_data = NULL;
 	return single_open(file, hist_debug_show, file);
 }
 
@@ -5911,7 +5915,7 @@ const struct file_operations event_hist_debug_fops = {
 	.open = event_hist_debug_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = tracing_single_release_file_tr,
 };
 #endif
 
-- 
2.25.1

