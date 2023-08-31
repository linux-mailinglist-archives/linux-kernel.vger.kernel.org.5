Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429178EE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbjHaN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHaN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:27:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FE1A2;
        Thu, 31 Aug 2023 06:27:46 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rc23v3QtxzrSK2;
        Thu, 31 Aug 2023 21:26:03 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 31 Aug 2023 21:27:43 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xukuohai@huawei.com>,
        <zhengyejian1@huawei.com>
Subject: [PATCH] tracing: Fix race issue between cpu buffer write and swap
Date:   Thu, 31 Aug 2023 21:27:39 +0800
Message-ID: <20230831132739.4070878-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning happened in rb_end_commit() at code:
	if (RB_WARN_ON(cpu_buffer, !local_read(&cpu_buffer->committing)))

  WARNING: CPU: 0 PID: 139 at kernel/trace/ring_buffer.c:3142
	rb_commit+0x402/0x4a0
  Call Trace:
   ring_buffer_unlock_commit+0x42/0x250
   trace_buffer_unlock_commit_regs+0x3b/0x250
   trace_event_buffer_commit+0xe5/0x440
   trace_event_buffer_reserve+0x11c/0x150
   trace_event_raw_event_sched_switch+0x23c/0x2c0
   __traceiter_sched_switch+0x59/0x80
   __schedule+0x72b/0x1580
   schedule+0x92/0x120
   worker_thread+0xa0/0x6f0

It is because the race between writing event into cpu buffer and swapping
cpu buffer through file per_cpu/cpu0/snapshot:

  Write on CPU 0             Swap buffer by per_cpu/cpu0/snapshot on CPU 1
  --------                   --------
                             tracing_snapshot_write()
                               [...]

  ring_buffer_lock_reserve()
    cpu_buffer = buffer->buffers[cpu]; // 1. Suppose find 'cpu_buffer_a';
    [...]
    rb_reserve_next_event()
      [...]

                               ring_buffer_swap_cpu()
                                 if (local_read(&cpu_buffer_a->committing))
                                     goto out_dec;
                                 if (local_read(&cpu_buffer_b->committing))
                                     goto out_dec;
                                 buffer_a->buffers[cpu] = cpu_buffer_b;
                                 buffer_b->buffers[cpu] = cpu_buffer_a;
                                 // 2. cpu_buffer has swapped here.

      rb_start_commit(cpu_buffer);
      if (unlikely(READ_ONCE(cpu_buffer->buffer)
          != buffer)) { // 3. This check passed due to 'cpu_buffer->buffer'
        [...]           //    has not changed here.
        return NULL;
      }
                                 cpu_buffer_b->buffer = buffer_a;
                                 cpu_buffer_a->buffer = buffer_b;
                                 [...]

      // 4. Reserve event from 'cpu_buffer_a'.

  ring_buffer_unlock_commit()
    [...]
    cpu_buffer = buffer->buffers[cpu]; // 5. Now find 'cpu_buffer_b' !!!
    rb_commit(cpu_buffer)
      rb_end_commit()  // 6. WARN for the wrong 'committing' state !!!

Based on above analysis, we can easily reproduce by following testcase:
  ``` bash
  #!/bin/bash

  dmesg -n 7
  sysctl -w kernel.panic_on_warn=1
  TR=/sys/kernel/tracing
  echo 7 > ${TR}/buffer_size_kb
  echo "sched:sched_switch" > ${TR}/set_event
  while [ true ]; do
          echo 1 > ${TR}/per_cpu/cpu0/snapshot
  done &
  while [ true ]; do
          echo 1 > ${TR}/per_cpu/cpu0/snapshot
  done &
  while [ true ]; do
          echo 1 > ${TR}/per_cpu/cpu0/snapshot
  done &
  ```

To fix it, IIUC, we can use smp_call_function_single() to do the swap on
the target cpu where the buffer is located, so that above race would be
avoided.

Fixes: f1affcaaa861 ("tracing: Add snapshot in the per_cpu trace directories")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e64aaad5361..55bb08aaf392 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7618,6 +7618,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static void tracing_swap_cpu_buffer(void *tr)
+{
+	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+}
+
 static ssize_t
 tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		       loff_t *ppos)
@@ -7676,13 +7681,15 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
 			break;
-		local_irq_disable();
 		/* Now, we're going to swap */
-		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
+			local_irq_disable();
 			update_max_tr(tr, current, smp_processor_id(), NULL);
-		else
-			update_max_tr_single(tr, current, iter->cpu_file);
-		local_irq_enable();
+			local_irq_enable();
+		} else {
+			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
+						 (void *)tr, 1);
+		}
 		break;
 	default:
 		if (tr->allocated_snapshot) {
-- 
2.25.1

