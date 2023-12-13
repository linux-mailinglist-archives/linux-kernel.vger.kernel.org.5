Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B680B8BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjLJEEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjLJEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA25123
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9A4C4339A;
        Sun, 10 Dec 2023 04:04:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3h-000000021Nl-3tTk;
        Sat, 09 Dec 2023 23:04:49 -0500
Message-ID: <20231210040449.711956756@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 05/14] ring-buffer: Read and write to ring buffers with custom sub buffer
 size
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

As the size of the ring sub buffer page can be changed dynamically,
the logic that reads and writes to the buffer should be fixed to take
that into account. Some internal ring buffer APIs are changed:
 ring_buffer_alloc_read_page()
 ring_buffer_free_read_page()
 ring_buffer_read_page()
A new API is introduced:
 ring_buffer_read_page_data()

Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-6-tz.stoyanov@gmail.com

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h          | 11 ++--
 kernel/trace/ring_buffer.c           | 75 ++++++++++++++++++++--------
 kernel/trace/ring_buffer_benchmark.c | 10 ++--
 kernel/trace/trace.c                 | 34 +++++++------
 4 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 12573306b889..fa802db216f9 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -192,10 +192,15 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
-void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu);
-void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data);
-int ring_buffer_read_page(struct trace_buffer *buffer, void **data_page,
+struct buffer_data_read_page;
+struct buffer_data_read_page *
+ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu);
+void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
+				struct buffer_data_read_page *page);
+int ring_buffer_read_page(struct trace_buffer *buffer,
+			  struct buffer_data_read_page *data_page,
 			  size_t len, int cpu, int full);
+void *ring_buffer_read_page_data(struct buffer_data_read_page *page);
 
 struct trace_seq;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7f18b2fd2514..4cb03b3b99e6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -317,6 +317,11 @@ struct buffer_data_page {
 	unsigned char	 data[] RB_ALIGN_DATA;	/* data of buffer page */
 };
 
+struct buffer_data_read_page {
+	unsigned		order;	/* order of the page */
+	struct buffer_data_page	*data;	/* actual data, stored in this page */
+};
+
 /*
  * Note, the buffer_page list must be first. The buffer pages
  * are allocated in cache lines, which means that each buffer
@@ -5616,40 +5621,48 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
  * Returns:
  *  The page allocated, or ERR_PTR
  */
-void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
+struct buffer_data_read_page *
+ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_page *bpage = NULL;
+	struct buffer_data_read_page *bpage = NULL;
 	unsigned long flags;
 	struct page *page;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
 
+	bpage = kzalloc(sizeof(*bpage), GFP_KERNEL);
+	if (!bpage)
+		return ERR_PTR(-ENOMEM);
+
+	bpage->order = buffer->subbuf_order;
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
 	if (cpu_buffer->free_page) {
-		bpage = cpu_buffer->free_page;
+		bpage->data = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
 	}
 
 	arch_spin_unlock(&cpu_buffer->lock);
 	local_irq_restore(flags);
 
-	if (bpage)
+	if (bpage->data)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
 				cpu_buffer->buffer->subbuf_order);
-	if (!page)
+	if (!page) {
+		kfree(bpage);
 		return ERR_PTR(-ENOMEM);
+	}
 
-	bpage = page_address(page);
+	bpage->data = page_address(page);
 
  out:
-	rb_init_page(bpage);
+	rb_init_page(bpage->data);
 
 	return bpage;
 }
@@ -5659,14 +5672,15 @@ EXPORT_SYMBOL_GPL(ring_buffer_alloc_read_page);
  * ring_buffer_free_read_page - free an allocated read page
  * @buffer: the buffer the page was allocate for
  * @cpu: the cpu buffer the page came from
- * @data: the page to free
+ * @page: the page to free
  *
  * Free a page allocated from ring_buffer_alloc_read_page.
  */
-void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data)
+void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
+				struct buffer_data_read_page *data_page)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct buffer_data_page *bpage = data;
+	struct buffer_data_page *bpage = data_page->data;
 	struct page *page = virt_to_page(bpage);
 	unsigned long flags;
 
@@ -5675,8 +5689,12 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	/* If the page is still in use someplace else, we can't reuse it */
-	if (page_ref_count(page) > 1)
+	/*
+	 * If the page is still in use someplace else, or order of the page
+	 * is different from the subbuffer order of the buffer -
+	 * we can't reuse it
+	 */
+	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
 		goto out;
 
 	local_irq_save(flags);
@@ -5691,7 +5709,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	local_irq_restore(flags);
 
  out:
-	free_pages((unsigned long)bpage, buffer->subbuf_order);
+	free_pages((unsigned long)bpage, data_page->order);
+	kfree(data_page);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -5712,9 +5731,10 @@ EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
  *	rpage = ring_buffer_alloc_read_page(buffer, cpu);
  *	if (IS_ERR(rpage))
  *		return PTR_ERR(rpage);
- *	ret = ring_buffer_read_page(buffer, &rpage, len, cpu, 0);
+ *	ret = ring_buffer_read_page(buffer, rpage, len, cpu, 0);
  *	if (ret >= 0)
- *		process_page(rpage, ret);
+ *		process_page(ring_buffer_read_page_data(rpage), ret);
+ *	ring_buffer_free_read_page(buffer, cpu, rpage);
  *
  * When @full is set, the function will not return true unless
  * the writer is off the reader page.
@@ -5729,7 +5749,8 @@ EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
  *  <0 if no data has been transferred.
  */
 int ring_buffer_read_page(struct trace_buffer *buffer,
-			  void **data_page, size_t len, int cpu, int full)
+			  struct buffer_data_read_page *data_page,
+			  size_t len, int cpu, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
 	struct ring_buffer_event *event;
@@ -5754,10 +5775,12 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 
 	len -= BUF_PAGE_HDR_SIZE;
 
-	if (!data_page)
+	if (!data_page || !data_page->data)
+		goto out;
+	if (data_page->order != buffer->subbuf_order)
 		goto out;
 
-	bpage = *data_page;
+	bpage = data_page->data;
 	if (!bpage)
 		goto out;
 
@@ -5851,11 +5874,11 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		/* swap the pages */
 		rb_init_page(bpage);
 		bpage = reader->page;
-		reader->page = *data_page;
+		reader->page = data_page->data;
 		local_set(&reader->write, 0);
 		local_set(&reader->entries, 0);
 		reader->read = 0;
-		*data_page = bpage;
+		data_page->data = bpage;
 
 		/*
 		 * Use the real_end for the data size,
@@ -5900,6 +5923,18 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+/**
+ * ring_buffer_read_page_data - get pointer to the data in the page.
+ * @page:  the page to get the data from
+ *
+ * Returns pointer to the actual data in this page.
+ */
+void *ring_buffer_read_page_data(struct buffer_data_read_page *page)
+{
+	return page->data;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
+
 /**
  * ring_buffer_subbuf_size_get - get size of the sub buffer.
  * @buffer: the buffer to get the sub buffer size from
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index aef34673d79d..008187ebd7fe 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -104,10 +104,11 @@ static enum event_status read_event(int cpu)
 
 static enum event_status read_page(int cpu)
 {
+	struct buffer_data_read_page *bpage;
 	struct ring_buffer_event *event;
 	struct rb_page *rpage;
 	unsigned long commit;
-	void *bpage;
+	int page_size;
 	int *entry;
 	int ret;
 	int inc;
@@ -117,14 +118,15 @@ static enum event_status read_page(int cpu)
 	if (IS_ERR(bpage))
 		return EVENT_DROPPED;
 
-	ret = ring_buffer_read_page(buffer, &bpage, PAGE_SIZE, cpu, 1);
+	page_size = ring_buffer_subbuf_size_get(buffer);
+	ret = ring_buffer_read_page(buffer, bpage, page_size, cpu, 1);
 	if (ret >= 0) {
-		rpage = bpage;
+		rpage = ring_buffer_read_page_data(bpage);
 		/* The commit may have missed event flags set, clear them */
 		commit = local_read(&rpage->commit) & 0xfffff;
 		for (i = 0; i < commit && !test_error ; i += inc) {
 
-			if (i >= (PAGE_SIZE - offsetof(struct rb_page, data))) {
+			if (i >= (page_size - offsetof(struct rb_page, data))) {
 				TEST_ERROR();
 				break;
 			}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 503fd7a57177..8e9853d38c8d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8271,6 +8271,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 {
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
+	void *trace_data;
+	int page_size;
 	ssize_t ret = 0;
 	ssize_t size;
 
@@ -8282,6 +8284,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 		return -EBUSY;
 #endif
 
+	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+
 	if (!info->spare) {
 		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
 							  iter->cpu_file);
@@ -8296,13 +8300,13 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 		return ret;
 
 	/* Do we have previous read data to read? */
-	if (info->read < PAGE_SIZE)
+	if (info->read < page_size)
 		goto read;
 
  again:
 	trace_access_lock(iter->cpu_file);
 	ret = ring_buffer_read_page(iter->array_buffer->buffer,
-				    &info->spare,
+				    info->spare,
 				    count,
 				    iter->cpu_file, 0);
 	trace_access_unlock(iter->cpu_file);
@@ -8323,11 +8327,11 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	info->read = 0;
  read:
-	size = PAGE_SIZE - info->read;
+	size = page_size - info->read;
 	if (size > count)
 		size = count;
-
-	ret = copy_to_user(ubuf, info->spare + info->read, size);
+	trace_data = ring_buffer_read_page_data(info->spare);
+	ret = copy_to_user(ubuf, trace_data + info->read, size);
 	if (ret == size)
 		return -EFAULT;
 
@@ -8438,6 +8442,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		.spd_release	= buffer_spd_release,
 	};
 	struct buffer_ref *ref;
+	int page_size;
 	int entries, i;
 	ssize_t ret = 0;
 
@@ -8446,13 +8451,14 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		return -EBUSY;
 #endif
 
-	if (*ppos & (PAGE_SIZE - 1))
+	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
+	if (*ppos & (page_size - 1))
 		return -EINVAL;
 
-	if (len & (PAGE_SIZE - 1)) {
-		if (len < PAGE_SIZE)
+	if (len & (page_size - 1)) {
+		if (len < page_size)
 			return -EINVAL;
-		len &= PAGE_MASK;
+		len &= (~(page_size - 1));
 	}
 
 	if (splice_grow_spd(pipe, &spd))
@@ -8462,7 +8468,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	trace_access_lock(iter->cpu_file);
 	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 
-	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= PAGE_SIZE) {
+	for (i = 0; i < spd.nr_pages_max && len && entries; i++, len -= page_size) {
 		struct page *page;
 		int r;
 
@@ -8483,7 +8489,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		}
 		ref->cpu = iter->cpu_file;
 
-		r = ring_buffer_read_page(ref->buffer, &ref->page,
+		r = ring_buffer_read_page(ref->buffer, ref->page,
 					  len, iter->cpu_file, 1);
 		if (r < 0) {
 			ring_buffer_free_read_page(ref->buffer, ref->cpu,
@@ -8492,14 +8498,14 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 			break;
 		}
 
-		page = virt_to_page(ref->page);
+		page = virt_to_page(ring_buffer_read_page_data(ref->page));
 
 		spd.pages[i] = page;
-		spd.partial[i].len = PAGE_SIZE;
+		spd.partial[i].len = page_size;
 		spd.partial[i].offset = 0;
 		spd.partial[i].private = (unsigned long)ref;
 		spd.nr_pages++;
-		*ppos += PAGE_SIZE;
+		*ppos += page_size;
 
 		entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
 	}
-- 
2.42.0


