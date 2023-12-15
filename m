Return-Path: <linux-kernel+bounces-1480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8827814F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D33E1F2200E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672AE41859;
	Fri, 15 Dec 2023 17:54:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790D3FB37;
	Fri, 15 Dec 2023 17:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B15BC433C8;
	Fri, 15 Dec 2023 17:54:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rECPY-00000002wPH-2S1r;
	Fri, 15 Dec 2023 12:55:44 -0500
Message-ID: <20231215175544.370837340@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 12:55:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v4 04/15] ring-buffer: Set new size of the ring buffer sub page
References: <20231215175502.106587604@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

There are two approaches when changing the size of the ring buffer
sub page:
 1. Destroying all pages and allocating new pages with the new size.
 2. Allocating new pages, copying the content of the old pages before
    destroying them.
The first approach is easier, it is selected in the proposed
implementation. Changing the ring buffer sub page size is supposed to
not happen frequently. Usually, that size should be set only once,
when the buffer is not in use yet and is supposed to be empty.

Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-5-tz.stoyanov@gmail.com

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 80 ++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7774202d7212..27e72cc87daa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -331,6 +331,7 @@ struct buffer_page {
 	unsigned	 read;		/* index for next read */
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
+	unsigned	 order;		/* order of the page */
 	struct buffer_data_page *page;	/* Actual data page */
 };
 
@@ -361,7 +362,7 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
 
 static void free_buffer_page(struct buffer_page *bpage)
 {
-	free_page((unsigned long)bpage->page);
+	free_pages((unsigned long)bpage->page, bpage->order);
 	kfree(bpage);
 }
 
@@ -1481,10 +1482,12 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags, 0);
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
 		bpage->page = page_address(page);
+		bpage->order = cpu_buffer->buffer->subbuf_order;
 		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
@@ -1563,7 +1566,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	rb_check_bpage(cpu_buffer, bpage);
 
 	cpu_buffer->reader_page = bpage;
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
+
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -1647,6 +1651,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 		goto fail_free_buffer;
 
 	/* Default buffer page size - one system page */
+	buffer->subbuf_order = 0;
 	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
@@ -5436,8 +5441,8 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY, 0);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -5486,7 +5491,7 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	local_irq_restore(flags);
 
  out:
-	free_page((unsigned long)bpage);
+	free_pages((unsigned long)bpage, buffer->subbuf_order);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -5746,7 +5751,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
  */
 int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
+	struct ring_buffer_per_cpu **cpu_buffers;
+	int old_order, old_size;
+	int nr_pages;
 	int psize;
+	int bsize;
+	int err;
+	int cpu;
 
 	if (!buffer || order < 0)
 		return -EINVAL;
@@ -5758,12 +5769,67 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
+	bsize = sizeof(void *) * buffer->cpus;
+	cpu_buffers = kzalloc(bsize, GFP_KERNEL);
+	if (!cpu_buffers)
+		return -ENOMEM;
+
+	old_order = buffer->subbuf_order;
+	old_size = buffer->subbuf_size;
+
+	/* prevent another thread from changing buffer sizes */
+	mutex_lock(&buffer->mutex);
+	atomic_inc(&buffer->record_disabled);
+
+	/* Make sure all commits have finished */
+	synchronize_rcu();
+
 	buffer->subbuf_order = order;
 	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
 
-	/* Todo: reset the buffer with the new page size */
+	/* Make sure all new buffers are allocated, before deleting the old ones */
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		nr_pages = buffer->buffers[cpu]->nr_pages;
+		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
+		if (!cpu_buffers[cpu]) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		rb_free_cpu_buffer(buffer->buffers[cpu]);
+		buffer->buffers[cpu] = cpu_buffers[cpu];
+	}
+
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	kfree(cpu_buffers);
 
 	return 0;
+
+error:
+	buffer->subbuf_order = old_order;
+	buffer->subbuf_size = old_size;
+
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpu_buffers[cpu])
+			continue;
+		kfree(cpu_buffers[cpu]);
+	}
+	kfree(cpu_buffers);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
 
-- 
2.42.0



