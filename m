Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572DA805C85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjLEQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345609AbjLEQwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:52:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE61728
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDD9C43140;
        Tue,  5 Dec 2023 16:51:57 +0000 (UTC)
Date:   Tue, 5 Dec 2023 11:52:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Always update snapshot buffer size
Message-ID: <20231205115223.5256e1a1@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It use to be that only the top level instance had a snapshot buffer (for
latency tracers like wakeup and irqsoff). The update of the ring buffer
size would check if the instance was the top level and if so, it would
also update the snapshot buffer as it needs to be the same as the main
buffer.

Now that lower level instances also has a snapshot buffer, they too need
to update their snapshot buffer sizes when the main buffer is changed,
otherwise the following can be triggered:

 # cd /sys/kernel/tracing
 # echo 1500 > buffer_size_kb
 # mkdir instances/foo
 # echo irqsoff > instances/foo/current_tracer
 # echo 1000 > instances/foo/buffer_size_kb

Produces:

 WARNING: CPU: 2 PID: 856 at kernel/trace/trace.c:1938 update_max_tr_single.part.0+0x27d/0x320

Which is:

	ret = ring_buffer_swap_cpu(tr->max_buffer.buffer, tr->array_buffer.buffer, cpu);

	if (ret == -EBUSY) {
		[..]
	}

	WARN_ON_ONCE(ret && ret != -EAGAIN && ret != -EBUSY);  <== here

That's because ring_buffer_swap_cpu() has:

	int ret = -EINVAL;

	[..]

	/* At least make sure the two buffers are somewhat the same */
	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
		goto out;

	[..]
 out:
	return ret;
 }

Instead, update all instances' snapshot buffer sizes when their main
buffer size is updated.

Cc: stable@vger.kernel.org
Fixes: 6d9b3fa5e7f6 ("tracing: Move tracing_max_latency into trace_array")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 110 +++++++++++++------------------------------
 1 file changed, 34 insertions(+), 76 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..06c2f8435e34 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2360,13 +2360,7 @@ int is_tracing_stopped(void)
 	return global_trace.stop_count;
 }
 
-/**
- * tracing_start - quick start of the tracer
- *
- * If tracing is enabled but was stopped by tracing_stop,
- * this will start the tracer back up.
- */
-void tracing_start(void)
+static void tracing_start_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
 	unsigned long flags;
@@ -2374,119 +2368,83 @@ void tracing_start(void)
 	if (tracing_disabled)
 		return;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (--global_trace.stop_count) {
-		if (global_trace.stop_count < 0) {
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (--tr->stop_count) {
+		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			global_trace.stop_count = 0;
+			tr->stop_count = 0;
 		}
 		goto out;
 	}
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
-}
-
-static void tracing_start_tr(struct trace_array *tr)
-{
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	if (tracing_disabled)
-		return;
-
-	/* If global, we need to also start the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_start();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-
-	if (--tr->stop_count) {
-		if (tr->stop_count < 0) {
-			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			tr->stop_count = 0;
-		}
-		goto out;
-	}
-
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_enable(buffer);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
 	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
- * tracing_stop - quick stop of the tracer
+ * tracing_start - quick start of the tracer
  *
- * Light weight way to stop tracing. Use in conjunction with
- * tracing_start.
+ * If tracing is enabled but was stopped by tracing_stop,
+ * this will start the tracer back up.
  */
-void tracing_stop(void)
+void tracing_start(void)
+
+{
+	return tracing_start_tr(&global_trace);
+}
+
+static void tracing_stop_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (global_trace.stop_count++)
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (tr->stop_count++)
 		goto out;
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
+	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
-static void tracing_stop_tr(struct trace_array *tr)
+/**
+ * tracing_stop - quick stop of the tracer
+ *
+ * Light weight way to stop tracing. Use in conjunction with
+ * tracing_start.
+ */
+void tracing_stop(void)
 {
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	/* If global, we need to also stop the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_stop();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-	if (tr->stop_count++)
-		goto out;
-
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
+	return tracing_stop_tr(&global_trace);
 }
 
 static int trace_save_cmdline(struct task_struct *tsk)
-- 
2.42.0

