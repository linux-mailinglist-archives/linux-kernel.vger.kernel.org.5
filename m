Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A7D7907A5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352075AbjIBLvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjIBLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE817E7E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A3960B27
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB73C43395;
        Sat,  2 Sep 2023 11:51:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9q-000Jwg-2d;
        Sat, 02 Sep 2023 07:51:18 -0400
Message-ID: <20230902115118.629845964@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 03/11] tracing: Fix race issue between cpu buffer write and swap
References: <20230902115035.786076237@goodmis.org>
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

From: Zheng Yejian <zhengyejian1@huawei.com>

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

Link: https://lore.kernel.org/linux-trace-kernel/20230831132739.4070878-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Fixes: f1affcaaa861 ("tracing: Add snapshot in the per_cpu trace directories")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3e55375f47e0..23579fba1a57 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7599,6 +7599,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
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
@@ -7657,13 +7662,15 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
2.40.1
