Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180080B8BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjLJEEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjLJEEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C72115
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240DEC433CC;
        Sun, 10 Dec 2023 04:04:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3h-000000021MJ-0IZM;
        Sat, 09 Dec 2023 23:04:49 -0500
Message-ID: <20231210040448.852632640@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 02/14] ring-buffer: Page size per ring buffer
References: <20231210035404.053677508@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

Currently the size of one sub buffer page is global for all buffers and
it is hard coded to one system page. In order to introduce configurable
ring buffer sub page size, the internal logic should be refactored to
work with sub page size per ring buffer.

Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-3-tz.stoyanov@gmail.com

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  2 +-
 kernel/trace/ring_buffer.c  | 65 +++++++++++++++++++------------------
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace.h        |  1 +
 kernel/trace/trace_events.c | 59 +++++++++++++++++++++++++--------
 5 files changed, 82 insertions(+), 47 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index b1b03b2c0f08..ce46218ce46d 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -200,7 +200,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer, void **data_page,
 struct trace_seq;
 
 int ring_buffer_print_entry_header(struct trace_seq *s);
-int ring_buffer_print_page_header(struct trace_seq *s);
+int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s);
 
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d59d14e67da1..a4354287dec3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -373,14 +373,6 @@ static inline bool test_time_stamp(u64 delta)
 	return !!(delta & TS_DELTA_TEST);
 }
 
-#define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
-
-/* Max payload is BUF_PAGE_SIZE - header (8bytes) */
-#define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
-
-/* Events may have a timestamp attached to them */
-#define BUF_MAX_EVENT_SIZE (BUF_MAX_DATA_SIZE - RB_LEN_TIME_EXTEND)
-
 struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
@@ -530,6 +522,9 @@ struct trace_buffer {
 
 	struct rb_irq_work		irq_work;
 	bool				time_stamp_abs;
+
+	unsigned int			subbuf_size;
+	unsigned int			max_data_size;
 };
 
 struct ring_buffer_iter {
@@ -546,7 +541,7 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
-int ring_buffer_print_page_header(struct trace_seq *s)
+int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s)
 {
 	struct buffer_data_page field;
 
@@ -570,7 +565,7 @@ int ring_buffer_print_page_header(struct trace_seq *s)
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)BUF_PAGE_SIZE,
+			 (unsigned int)buffer->subbuf_size,
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
@@ -1822,7 +1817,13 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 	if (!zalloc_cpumask_var(&buffer->cpumask, GFP_KERNEL))
 		goto fail_free_buffer;
 
-	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	/* Default buffer page size - one system page */
+	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
+
+	/* Max payload is buffer page size - header (8bytes) */
+	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
+
+	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
 	buffer->flags = flags;
 	buffer->clock = trace_clock_local;
 	buffer->reader_lock_key = key;
@@ -2141,7 +2142,7 @@ static void update_pages_handler(struct work_struct *work)
  * @size: the new size.
  * @cpu_id: the cpu buffer to resize
  *
- * Minimum size is 2 * BUF_PAGE_SIZE.
+ * Minimum size is 2 * buffer->subbuf_size.
  *
  * Returns 0 on success and < 0 on failure.
  */
@@ -2163,7 +2164,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 	    !cpumask_test_cpu(cpu_id, buffer->cpumask))
 		return 0;
 
-	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
+	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);
 
 	/* we need a minimum of two pages */
 	if (nr_pages < 2)
@@ -2410,7 +2411,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > iter->cpu_buffer->buffer->max_data_size)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -2643,6 +2644,7 @@ static inline void
 rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	      unsigned long tail, struct rb_event_info *info)
 {
+	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	struct buffer_page *tail_page = info->tail_page;
 	struct ring_buffer_event *event;
 	unsigned long length = info->length;
@@ -2651,13 +2653,13 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * Only the event that crossed the page boundary
 	 * must fill the old tail_page with padding.
 	 */
-	if (tail >= BUF_PAGE_SIZE) {
+	if (tail >= bsize) {
 		/*
 		 * If the page was filled, then we still need
 		 * to update the real_end. Reset it to zero
 		 * and the reader will ignore it.
 		 */
-		if (tail == BUF_PAGE_SIZE)
+		if (tail == bsize)
 			tail_page->real_end = 0;
 
 		local_sub(length, &tail_page->write);
@@ -2685,7 +2687,7 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If we are less than the minimum size, we don't need to
 	 * worry about it.
 	 */
-	if (tail > (BUF_PAGE_SIZE - RB_EVNT_MIN_SIZE)) {
+	if (tail > (bsize - RB_EVNT_MIN_SIZE)) {
 		/* No room for any events */
 
 		/* Mark the rest of the page with padding */
@@ -2700,19 +2702,19 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	/* Put in a discarded event */
-	event->array[0] = (BUF_PAGE_SIZE - tail) - RB_EVNT_HDR_SIZE;
+	event->array[0] = (bsize - tail) - RB_EVNT_HDR_SIZE;
 	event->type_len = RINGBUF_TYPE_PADDING;
 	/* time delta must be non zero */
 	event->time_delta = 1;
 
 	/* account for padding bytes */
-	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
+	local_add(bsize - tail, &cpu_buffer->entries_bytes);
 
 	/* Make sure the padding is visible before the tail_page->write update */
 	smp_wmb();
 
 	/* Set write to end of buffer */
-	length = (tail + length) - BUF_PAGE_SIZE;
+	length = (tail + length) - bsize;
 	local_sub(length, &tail_page->write);
 }
 
@@ -3608,7 +3610,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	tail = write - info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > BUF_PAGE_SIZE)) {
+	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
 		/* before and after may now different, fix it up*/
 		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
 		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
@@ -3817,7 +3819,7 @@ ring_buffer_lock_reserve(struct trace_buffer *buffer, unsigned long length)
 	if (unlikely(atomic_read(&cpu_buffer->record_disabled)))
 		goto out;
 
-	if (unlikely(length > BUF_MAX_EVENT_SIZE))
+	if (unlikely(length > buffer->max_data_size - RB_LEN_TIME_EXTEND))
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -3967,7 +3969,7 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	if (atomic_read(&cpu_buffer->record_disabled))
 		goto out;
 
-	if (length > BUF_MAX_EVENT_SIZE)
+	if (length > buffer->max_data_size - RB_LEN_TIME_EXTEND)
 		goto out;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
@@ -4547,6 +4549,7 @@ static struct buffer_page *
 rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct buffer_page *reader = NULL;
+	unsigned long bsize = READ_ONCE(cpu_buffer->buffer->subbuf_size);
 	unsigned long overwrite;
 	unsigned long flags;
 	int nr_loops = 0;
@@ -4682,7 +4685,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 #define USECS_WAIT	1000000
         for (nr_loops = 0; nr_loops < USECS_WAIT; nr_loops++) {
 		/* If the write is past the end of page, a writer is still updating it */
-		if (likely(!reader || rb_page_write(reader) <= BUF_PAGE_SIZE))
+		if (likely(!reader || rb_page_write(reader) <= bsize))
 			break;
 
 		udelay(1);
@@ -5125,7 +5128,7 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	iter->event = kmalloc(buffer->max_data_size, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;
@@ -5243,14 +5246,14 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 {
 	/*
 	 * Earlier, this method returned
-	 *	BUF_PAGE_SIZE * buffer->nr_pages
+	 *	buffer->subbuf_size * buffer->nr_pages
 	 * Since the nr_pages field is now removed, we have converted this to
 	 * return the per cpu buffer value.
 	 */
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return 0;
 
-	return BUF_PAGE_SIZE * buffer->buffers[cpu]->nr_pages;
+	return buffer->subbuf_size * buffer->buffers[cpu]->nr_pages;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
@@ -5262,7 +5265,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_size);
  */
 unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
 {
-	return BUF_MAX_EVENT_SIZE;
+	return buffer->max_data_size - RB_LEN_TIME_EXTEND;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
 
@@ -5868,7 +5871,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		/* If there is room at the end of the page to save the
 		 * missed events, then record it there.
 		 */
-		if (BUF_PAGE_SIZE - commit >= sizeof(missed_events)) {
+		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
 			memcpy(&bpage->data[commit], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &bpage->commit);
@@ -5880,8 +5883,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (commit < BUF_PAGE_SIZE)
-		memset(&bpage->data[commit], 0, BUF_PAGE_SIZE - commit);
+	if (commit < buffer->subbuf_size)
+		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
 
  out_unlock:
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 077b20e83e7c..90e0ea91521f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5012,7 +5012,7 @@ static int tracing_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int tracing_release_generic_tr(struct inode *inode, struct file *file)
+int tracing_release_generic_tr(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 97b01dfd7070..af07194db3d5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -616,6 +616,7 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_release_generic_tr(struct inode *inode, struct file *file);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b70d03818038..7c364b87352e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1893,9 +1893,9 @@ subsystem_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 }
 
 static ssize_t
-show_header(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+show_header_page_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
-	int (*func)(struct trace_seq *s) = filp->private_data;
+	struct trace_array *tr = filp->private_data;
 	struct trace_seq *s;
 	int r;
 
@@ -1908,7 +1908,31 @@ show_header(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	trace_seq_init(s);
 
-	func(s);
+	ring_buffer_print_page_header(tr->array_buffer.buffer, s);
+	r = simple_read_from_buffer(ubuf, cnt, ppos,
+				    s->buffer, trace_seq_used(s));
+
+	kfree(s);
+
+	return r;
+}
+
+static ssize_t
+show_header_event_file(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_seq *s;
+	int r;
+
+	if (*ppos)
+		return 0;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	trace_seq_init(s);
+
+	ring_buffer_print_entry_header(s);
 	r = simple_read_from_buffer(ubuf, cnt, ppos,
 				    s->buffer, trace_seq_used(s));
 
@@ -2165,10 +2189,18 @@ static const struct file_operations ftrace_tr_enable_fops = {
 	.release = subsystem_release,
 };
 
-static const struct file_operations ftrace_show_header_fops = {
-	.open = tracing_open_generic,
-	.read = show_header,
+static const struct file_operations ftrace_show_header_page_fops = {
+	.open = tracing_open_generic_tr,
+	.read = show_header_page_file,
 	.llseek = default_llseek,
+	.release = tracing_release_generic_tr,
+};
+
+static const struct file_operations ftrace_show_header_event_fops = {
+	.open = tracing_open_generic_tr,
+	.read = show_header_event_file,
+	.llseek = default_llseek,
+	.release = tracing_release_generic_tr,
 };
 
 static int
@@ -3794,17 +3826,16 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 		return 1;
 	}
 
-	if (strcmp(name, "header_page") == 0)
-		*data = ring_buffer_print_page_header;
-
-	else if (strcmp(name, "header_event") == 0)
-		*data = ring_buffer_print_entry_header;
+	if (strcmp(name, "header_page") == 0) {
+		*mode = TRACE_MODE_READ;
+		*fops = &ftrace_show_header_page_fops;
 
-	else
+	} else if (strcmp(name, "header_event") == 0) {
+		*mode = TRACE_MODE_READ;
+		*fops = &ftrace_show_header_event_fops;
+	} else
 		return 0;
 
-	*mode = TRACE_MODE_READ;
-	*fops = &ftrace_show_header_fops;
 	return 1;
 }
 
-- 
2.42.0


