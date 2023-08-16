Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380A777D9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbjHPFoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjHPFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:44:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF494;
        Tue, 15 Aug 2023 22:44:23 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQcRx1k2NztRyT;
        Wed, 16 Aug 2023 13:40:45 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 13:44:21 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <zhengyejian1@huawei.com>
CC:     <fweisbec@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>
Subject: [PATCH v2] tracing: Fix memleak due to race between current_tracer and trace
Date:   Wed, 16 Aug 2023 13:43:57 +0800
Message-ID: <20230816054357.1188339-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8c853c0c-84f0-c8be-3020-561db6f87081@huawei.com>
References: <8c853c0c-84f0-c8be-3020-561db6f87081@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak report a leak in graph_trace_open():

  unreferenced object 0xffff0040b95f4a00 (size 128):
    comm "cat", pid 204981, jiffies 4301155872 (age 99771.964s)
    hex dump (first 32 bytes):
      e0 05 e7 b4 ab 7d 00 00 0b 00 01 00 00 00 00 00 .....}..........
      f4 00 01 10 00 a0 ff ff 00 00 00 00 65 00 10 00 ............e...
    backtrace:
      [<000000005db27c8b>] kmem_cache_alloc_trace+0x348/0x5f0
      [<000000007df90faa>] graph_trace_open+0xb0/0x344
      [<00000000737524cd>] __tracing_open+0x450/0xb10
      [<0000000098043327>] tracing_open+0x1a0/0x2a0
      [<00000000291c3876>] do_dentry_open+0x3c0/0xdc0
      [<000000004015bcd6>] vfs_open+0x98/0xd0
      [<000000002b5f60c9>] do_open+0x520/0x8d0
      [<00000000376c7820>] path_openat+0x1c0/0x3e0
      [<00000000336a54b5>] do_filp_open+0x14c/0x324
      [<000000002802df13>] do_sys_openat2+0x2c4/0x530
      [<0000000094eea458>] __arm64_sys_openat+0x130/0x1c4
      [<00000000a71d7881>] el0_svc_common.constprop.0+0xfc/0x394
      [<00000000313647bf>] do_el0_svc+0xac/0xec
      [<000000002ef1c651>] el0_svc+0x20/0x30
      [<000000002fd4692a>] el0_sync_handler+0xb0/0xb4
      [<000000000c309c35>] el0_sync+0x160/0x180

The root cause is descripted as follows:

  __tracing_open() {  // 1. File 'trace' is being opened;
    ...
    *iter->trace = *tr->current_trace;  // 2. Tracer 'function_graph' is
                                        //    currently set;
    ...
    iter->trace->open(iter);  // 3. Call graph_trace_open() here,
                              //    and memory are allocated in it;
    ...
  }

  s_start() {  // 4. The opened file is being read;
    ...
    *iter->trace = *tr->current_trace;  // 5. If tracer is switched to
                                        //    'nop' or others, then memory
                                        //    in step 3 are leaked!!!
    ...
  }

To fix it, in s_start(), close tracer before switching then reopen the
new tracer after switching. And some tracers like 'wakeup' may not update
'iter->private' in some cases when reopen, so clear 'iter->private' in
graph_trace_close() to avoid it being mistakenly closed again.

Fixes: d7350c3f4569 ("tracing/core: make the read callbacks reentrants")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---

v2:
  - Fix an use-after-free issue which is due to some tracers like 'wakeup'
    may not update 'iter->private' in some cases when reopen, so clear
    'iter->private' in graph_trace_close() to avoid it being mistakenly
    closed again. Also update the commit message.
    Link: https://lore.kernel.org/all/8c853c0c-84f0-c8be-3020-561db6f87081@huawei.com/

v1:
  - Link: https://lore.kernel.org/all/20230808092905.2936459-1-zhengyejian1@huawei.com/

 kernel/trace/trace.c                 | 9 ++++++++-
 kernel/trace/trace_functions_graph.c | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..d50a0227baa3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4213,8 +4213,15 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	 * will point to the same string as current_trace->name.
 	 */
 	mutex_lock(&trace_types_lock);
-	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name))
+	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
+		/* Close iter->trace before switching to the new current tracer */
+		if (iter->trace->close)
+			iter->trace->close(iter);
 		*iter->trace = *tr->current_trace;
+		/* Reopen the new current tracer */
+		if (iter->trace->open)
+			iter->trace->open(iter);
+	}
 	mutex_unlock(&trace_types_lock);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c35fbaab2a47..4d4808186a0f 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1317,6 +1317,7 @@ void graph_trace_close(struct trace_iterator *iter)
 	if (data) {
 		free_percpu(data->cpu_data);
 		kfree(data);
+		iter->private = NULL;
 	}
 }
 
-- 
2.25.1

