Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59073809041
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjLGSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjLGSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8CF1715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:36:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3CBC433C8;
        Thu,  7 Dec 2023 18:36:47 +0000 (UTC)
Date:   Thu, 7 Dec 2023 13:37:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] tracing: Fixes for v6.7-rc4
Message-ID: <20231207133717.0b6d55d7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing fixes for v6.7-rc4:

- Snapshot buffer issues

  1. When instances started allowing latency tracers, it uses
     a snapshot buffer (another buffer that is not written to
     but swapped with the main buffer that is). The snapshot buffer
     needs to be the same size as the main buffer. But when the
     snapshot buffers were added to instances, the code to make
     the snapshot equal to the main buffer still was only doing it
     for the main buffer and not the instances.

  2. Need to stop the current tracer when resizing the buffers.
     Otherwise there can be a race if the tracer decides to make
     a snapshot between resizing the main buffer and the snapshot
     buffer.

  3. When a tracer is "stopped" in disables both the main buffer
     and the snapshot buffer. This needs to be done for instances
     and not only the main buffer, now that instances also have
     a snapshot buffer.

- Buffered event for filtering issues

  When filtering is enabled, because events can be dropped often,
  it is quicker to copy the event into a temp buffer and write that
  into the main buffer if it is not filtered or just drop the event
  if it is, than to write the event into the ring buffer and then
  try to discard it. This temp buffer is allocated and needs special
  synchronization to do so. But there were some issues with that:

  1. When disabling the filter and freeing the buffer, a call to all
     CPUs is required to stop each per_cpu usage. But the code
     called smp_call_function_many() which does not include the
     current CPU. If the task is migrated to another CPU when it
     enables the CPUs via smp_call_function_many(), it will not enable
     the one it is currently on and this causes issues later on.
     Use on_each_cpu_mask() instead, which includes the current CPU.

   2. When the allocation of the buffered event fails, it can give
      a warning. But the buffered event is just an optimization
      (it's still OK to write to the ring buffer and free it).
      Do not WARN in this case.

   3. The freeing of the buffer event requires synchronization.
      First a counter is decremented to zero so that no new uses
      of it will happen. Then it sets the buffered event to NULL,
      and finally it frees the buffered event. There's a synchronize_rcu()
      between the counter decrement and the setting the variable to
      NULL, but only a smp_wmb() between that and the freeing of the
      buffer. It is theoretically possible that a user missed seeing
      the decrement, but will use the buffer after it is free. Another
      synchronize_rcu() is needed in place of that smp_wmb().

- ring buffer timestamps on 32 bit machines

  The ring buffer timestamp on 32 bit machines has to break the 64 bit
  number into multiple values as cmpxchg is required on it, and a
  64 bit cmpxchg on 32 bit architectures is very slow. The code use
  to just use two 32 bit values and make it a 60 bit timestamp where
  the other 4 bits were used as counters for synchronization. It later
  came known that the timestamp on 32 bit still need all 64 bits in
  some cases. So 3 words were created to handle the 64 bits. But issues
  arised with this:

   1. The synchronization logic still only compared the counter
      with the first two, but not with the third number, so the
      synchronization could fail unknowingly.

   2. A check on discard of an event could race if an event happened
      between the discard and updating one of the counters. The
      counter needs to be updated (forcing an absolute timestamp
      and not to use a delta) before the actual discard happens.


Please pull the latest trace-v6.7-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7-rc4

Tag SHA1: 3b9bc2333a2c94ab143a76576ace6e62e013ace6
Head SHA1: f458a1453424e03462b5bb539673c9a3cddda480


Petr Pavlu (3):
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix a possible race when disabling buffered events

Steven Rostedt (Google) (5):
      tracing: Always update snapshot buffer size
      tracing: Stop current tracer when resizing buffer
      tracing: Disable snapshot buffer when stopping instance tracers
      ring-buffer: Force absolute timestamp on discard of event
      ring-buffer: Test last update in 32bit version of __rb_time_read()

----
 kernel/trace/ring_buffer.c |  23 +++----
 kernel/trace/trace.c       | 158 +++++++++++++++++----------------------------
 2 files changed, 69 insertions(+), 112 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43cc47d7faaf..8d2a4f00eca9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and bottom counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(bottom))
+	/* If top and msb counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
@@ -3030,22 +3030,19 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
 
+		/*
+		 * For the before_stamp to be different than the write_stamp
+		 * to make sure that the next event adds an absolute
+		 * value and does not rely on the saved write stamp, which
+		 * is now going to be bogus.
+		 */
+		rb_time_set(&cpu_buffer->before_stamp, 0);
+
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
 			return false;
 
-		/*
-		 * It's possible that the event time delta is zero
-		 * (has the same time stamp as the previous event)
-		 * in which case write_stamp and before_stamp could
-		 * be the same. In such a case, force before_stamp
-		 * to be different than write_stamp. It doesn't
-		 * matter what it is, as long as its different.
-		 */
-		if (!delta)
-			rb_time_set(&cpu_buffer->before_stamp, 0);
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9aebf904ff97..fbcd3bafb93e 100644
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
@@ -2770,8 +2728,11 @@ void trace_buffered_event_enable(void)
 	for_each_tracing_cpu(cpu) {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_NORETRY, 0);
-		if (!page)
-			goto failed;
+		/* This is just an optimization and can handle failures */
+		if (!page) {
+			pr_err("Failed to allocate event buffer\n");
+			break;
+		}
 
 		event = page_address(page);
 		memset(event, 0, sizeof(*event));
@@ -2785,10 +2746,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
@@ -2823,11 +2780,9 @@ void trace_buffered_event_disable(void)
 	if (--trace_buffered_event_ref)
 		return;
 
-	preempt_disable();
 	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	on_each_cpu_mask(tracing_buffer_mask, disable_trace_buffered_event,
+			 NULL, true);
 
 	/* Wait for all current users to finish */
 	synchronize_rcu();
@@ -2836,17 +2791,19 @@ void trace_buffered_event_disable(void)
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
+
 	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
+	 * Wait for all CPUs that potentially started checking if they can use
+	 * their event buffer only after the previous synchronize_rcu() call and
+	 * they still read a valid pointer from trace_buffered_event. It must be
+	 * ensured they don't see cleared trace_buffered_event_cnt else they
+	 * could wrongly decide to use the pointed-to buffer which is now freed.
 	 */
-	smp_wmb();
+	synchronize_rcu();
 
-	preempt_disable();
-	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	/* For each CPU, relinquish the buffer */
+	on_each_cpu_mask(tracing_buffer_mask, enable_trace_buffered_event, NULL,
+			 true);
 }
 
 static struct trace_buffer *temp_buffer;
@@ -6387,13 +6344,15 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
+	/* Do not allow tracing while resizng ring buffer */
+	tracing_stop_tr(tr);
+
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
 	if (ret < 0)
-		return ret;
+		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL) ||
-	    !tr->current_trace->use_max_tr)
+	if (!tr->current_trace->use_max_tr)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
@@ -6418,7 +6377,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 			WARN_ON(1);
 			tracing_disabled = 1;
 		}
-		return ret;
+		goto out_start;
 	}
 
 	update_buffer_entries(&tr->max_buffer, cpu);
@@ -6427,7 +6386,8 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
 	update_buffer_entries(&tr->array_buffer, cpu);
-
+ out_start:
+	tracing_start_tr(tr);
 	return ret;
 }
 
