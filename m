Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3771081081B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378341AbjLMCTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378302AbjLMCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3774EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C56C433C9;
        Wed, 13 Dec 2023 02:19:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr3-00000002Tmn-1a3V;
        Tue, 12 Dec 2023 21:20:09 -0500
Message-ID: <20231213022009.153898232@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 04/15] ring-buffer: Set new size of the ring buffer sub page
References: <20231213021914.361709558@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 8ba7a45f7c21..6c780d7204ba 100644
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
 
@@ -1658,10 +1659,12 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
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
@@ -1740,7 +1743,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	rb_check_bpage(cpu_buffer, bpage);
 
 	cpu_buffer->reader_page = bpage;
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
+
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -1824,6 +1828,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
 		goto fail_free_buffer;
 
 	/* Default buffer page size - one system page */
+	buffer->subbuf_order = 0;
 	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
 
 	/* Max payload is buffer page size - header (8bytes) */
@@ -5645,8 +5650,8 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY, 0);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -5695,7 +5700,7 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
 	local_irq_restore(flags);
 
  out:
-	free_page((unsigned long)bpage);
+	free_pages((unsigned long)bpage, buffer->subbuf_order);
 }
 EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
 
@@ -5955,7 +5960,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
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
@@ -5967,12 +5978,67 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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


