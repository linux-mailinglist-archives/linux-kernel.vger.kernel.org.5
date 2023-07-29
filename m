Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3B768117
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjG2Srz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjG2Sry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D81FDD
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EECE606A0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 18:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA4C433C8;
        Sat, 29 Jul 2023 18:47:50 +0000 (UTC)
Date:   Sat, 29 Jul 2023 14:47:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: fixes for 6.5
Message-ID: <20230729144749.4f8e96ef@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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


Linus,

Tracing fixes for 6.5:

- Fix to /sys/kernel/tracing/per_cpu/cpu*/stats read and entries.
  If a resize shrinks the buffer it clears the read count to notify
  readers that they need to reset. But the read count is also used for
  accounting and this causes the numbers to be off. Instead, create a
  separate variable to use to notify readers to reset.

- Fix the ref counts of the "soft disable" mode. The wrong value was
  used for testing if soft disable mode should be enabled or disable,
  but instead, just change the logic to do the enable and disable
  in place when the SOFT_MODE is set or cleared.

- Several kernel-doc fixes

- Removal of unused external declarations


Please pull the latest trace-v6.5-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.5-rc3

Tag SHA1: 2834c3b23d4e5d9f5e339c48e5b4c51fb5b2dce3
Head SHA1: dea499781a1150d285c62b26659f62fb00824fce


Gaosheng Cui (4):
      ring-buffer: Fix kernel-doc warnings in ring_buffer.c
      tracing/synthetic: Fix kernel-doc warnings in trace_events_synth.c
      tracing: Fix kernel-doc warnings in trace_events_trigger.c
      tracing: Fix kernel-doc warnings in trace_seq.c

YueHaibing (1):
      ftrace: Remove unused extern declarations

Zheng Yejian (2):
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

----
 include/linux/ftrace.h              |  4 ----
 kernel/trace/ring_buffer.c          | 25 +++++++++++++------------
 kernel/trace/trace_events.c         | 14 ++++----------
 kernel/trace/trace_events_synth.c   |  1 +
 kernel/trace/trace_events_trigger.c |  2 ++
 kernel/trace/trace_seq.c            |  1 +
 6 files changed, 21 insertions(+), 26 deletions(-)
---------------------------
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce156c7704ee..aad9cf8876b5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -684,7 +684,6 @@ void __init
 ftrace_set_early_filter(struct ftrace_ops *ops, char *buf, int enable);
 
 /* defined in arch */
-extern int ftrace_ip_converted(unsigned long ip);
 extern int ftrace_dyn_arch_init(void);
 extern void ftrace_replace_code(int enable);
 extern int ftrace_update_ftrace_func(ftrace_func_t func);
@@ -859,9 +858,6 @@ static inline int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_a
 }
 #endif
 
-/* May be defined in arch */
-extern int ftrace_arch_read_dyn_info(char *buf, int size);
-
 extern int skip_trace(unsigned long ip);
 extern void ftrace_module_init(struct module *mod);
 extern void ftrace_module_enable(struct module *mod);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index de061dd47313..52dea5dd5362 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -523,6 +523,8 @@ struct ring_buffer_per_cpu {
 	rb_time_t			before_stamp;
 	u64				event_stamp[MAX_NEST];
 	u64				read_stamp;
+	/* pages removed since last reset */
+	unsigned long			pages_removed;
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
 	struct list_head		new_pages; /* new pages to add */
@@ -559,6 +561,7 @@ struct ring_buffer_iter {
 	struct buffer_page		*head_page;
 	struct buffer_page		*cache_reader_page;
 	unsigned long			cache_read;
+	unsigned long			cache_pages_removed;
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
@@ -947,6 +950,7 @@ static void rb_wake_up_waiters(struct irq_work *work)
 /**
  * ring_buffer_wake_waiters - wake up any waiters on this ring buffer
  * @buffer: The ring buffer to wake waiters on
+ * @cpu: The CPU buffer to wake waiters on
  *
  * In the case of a file that represents a ring buffer is closing,
  * it is prudent to wake up any waiters that are on this.
@@ -1957,6 +1961,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		to_remove = rb_list_head(to_remove)->next;
 		head_bit |= (unsigned long)to_remove & RB_PAGE_HEAD;
 	}
+	/* Read iterators need to reset themselves when some pages removed */
+	cpu_buffer->pages_removed += nr_removed;
 
 	next_page = rb_list_head(to_remove)->next;
 
@@ -1978,12 +1984,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 		cpu_buffer->head_page = list_entry(next_page,
 						struct buffer_page, list);
 
-	/*
-	 * change read pointer to make sure any read iterators reset
-	 * themselves
-	 */
-	cpu_buffer->read = 0;
-
 	/* pages are removed, resume tracing and then free the pages */
 	atomic_dec(&cpu_buffer->record_disabled);
 	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
@@ -3376,7 +3376,6 @@ void ring_buffer_nest_end(struct trace_buffer *buffer)
 /**
  * ring_buffer_unlock_commit - commit a reserved
  * @buffer: The buffer to commit to
- * @event: The event pointer to commit.
  *
  * This commits the data to the ring buffer, and releases any locks held.
  *
@@ -4395,6 +4394,7 @@ static void rb_iter_reset(struct ring_buffer_iter *iter)
 
 	iter->cache_reader_page = iter->head_page;
 	iter->cache_read = cpu_buffer->read;
+	iter->cache_pages_removed = cpu_buffer->pages_removed;
 
 	if (iter->head) {
 		iter->read_stamp = cpu_buffer->read_stamp;
@@ -4849,12 +4849,13 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
 	buffer = cpu_buffer->buffer;
 
 	/*
-	 * Check if someone performed a consuming read to
-	 * the buffer. A consuming read invalidates the iterator
-	 * and we need to reset the iterator in this case.
+	 * Check if someone performed a consuming read to the buffer
+	 * or removed some pages from the buffer. In these cases,
+	 * iterator was invalidated and we need to reset it.
 	 */
 	if (unlikely(iter->cache_read != cpu_buffer->read ||
-		     iter->cache_reader_page != cpu_buffer->reader_page))
+		     iter->cache_reader_page != cpu_buffer->reader_page ||
+		     iter->cache_pages_removed != cpu_buffer->pages_removed))
 		rb_iter_reset(iter);
 
  again:
@@ -5298,6 +5299,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->last_overrun = 0;
 
 	rb_head_page_activate(cpu_buffer);
+	cpu_buffer->pages_removed = 0;
 }
 
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
@@ -5356,7 +5358,6 @@ EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 /**
  * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
- * @cpu: The CPU buffer to be reset
  */
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5d6ae4eae510..578f1f7d49a6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -611,7 +611,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
-	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
 
@@ -635,6 +634,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
 			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -673,6 +674,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
 			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Enable use of trace_buffered_event */
+			trace_buffered_event_enable();
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
@@ -712,15 +715,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		break;
 	}
 
-	/* Enable or disable use of trace_buffered_event */
-	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
-	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
-		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
-			trace_buffered_event_enable();
-		else
-			trace_buffered_event_disable();
-	}
-
 	return ret;
 }
 
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d6a70aff2410..dd398afc8e25 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1230,6 +1230,7 @@ EXPORT_SYMBOL_GPL(__synth_event_gen_cmd_start);
  * synth_event_gen_cmd_array_start - Start synthetic event command from an array
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
  * @name: The name of the synthetic event
+ * @mod: The module creating the event, NULL if not created from a module
  * @fields: An array of type/name field descriptions
  * @n_fields: The number of field descriptions contained in the fields array
  *
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index e535959939d3..46439e3bcec4 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -31,7 +31,9 @@ void trigger_data_free(struct event_trigger_data *data)
 /**
  * event_triggers_call - Call triggers associated with a trace event
  * @file: The trace_event_file associated with the event
+ * @buffer: The ring buffer that the event is being written to
  * @rec: The trace entry for the event, NULL for unconditional invocation
+ * @event: The event meta data in the ring buffer
  *
  * For each trigger associated with an event, invoke the trigger
  * function registered with the associated trigger command.  If rec is
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index e5e299260d0c..bac06ee3b98b 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -131,6 +131,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
  * trace_seq_vprintf - sequence printing of trace information
  * @s: trace sequence descriptor
  * @fmt: printf format string
+ * @args: Arguments for the format string
  *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formatting of a trace
