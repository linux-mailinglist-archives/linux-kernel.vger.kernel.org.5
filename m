Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39571810825
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378418AbjLMCTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378307AbjLMCTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18CEA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5FC433C7;
        Wed, 13 Dec 2023 02:19:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr5-00000002Tqn-2fDi;
        Tue, 12 Dec 2023 21:20:11 -0500
Message-ID: <20231213022011.432211428@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 12/15] ring-buffer: Just update the subbuffers when changing their
 allocation order
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ring_buffer_subbuf_order_set() was creating ring_buffer_per_cpu
cpu_buffers with the new subbuffers with the updated order, and if they
all successfully were created, then they the ring_buffer's per_cpu buffers
would be freed and replaced by them.

The problem is that the freed per_cpu buffers contains state that would be
lost. Running the following commands:

1. # echo 3 > /sys/kernel/tracing/buffer_subbuf_order
2. # echo 0 > /sys/kernel/tracing/tracing_cpumask
3. # echo 1 > /sys/kernel/tracing/snapshot
4. # echo ff > /sys/kernel/tracing/tracing_cpumask
5. # echo test > /sys/kernel/tracing/trace_marker

Would result in:

 -bash: echo: write error: Bad file descriptor

That's because the state of the per_cpu buffers of the snapshot buffer is
lost when the order is changed (the order of a freed snapshot buffer goes
to 0 to save memory, and when the snapshot buffer is allocated again, it
goes back to what the main buffer is).

In operation 2, the snapshot buffers were set to "disable" (as all the
ring buffers CPUs were disabled).

In operation 3, the snapshot is allocated and a call to
ring_buffer_subbuf_order_set() replaced the per_cpu buffers losing the
"record_disable" count.

When it was enabled again, the atomic_dec(&cpu_buffer->record_disable) was
decrementing a zero, setting it to -1. Writing 1 into the snapshot would
swap the snapshot buffer with the main buffer, so now the main buffer is
"disabled", and nothing can write to the ring buffer anymore.

Instead of creating new per_cpu buffers and losing the state of the old
buffers, basically do what the resize does and just allocate new subbuf
pages into the new_pages link list of the per_cpu buffer and if they all
succeed, then replace the old sub buffers with the new ones. This keeps
the per_cpu buffer descriptor in tact and by doing so, keeps its state.

Fixes: TBD ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 88 ++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 86d3cac2a877..e08e646c4277 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5998,11 +5998,11 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
  */
 int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 {
-	struct ring_buffer_per_cpu **cpu_buffers;
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct buffer_page *bpage, *tmp;
 	int old_order, old_size;
 	int nr_pages;
 	int psize;
-	int bsize;
 	int err;
 	int cpu;
 
@@ -6016,11 +6016,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
-	bsize = sizeof(void *) * buffer->cpus;
-	cpu_buffers = kzalloc(bsize, GFP_KERNEL);
-	if (!cpu_buffers)
-		return -ENOMEM;
-
 	old_order = buffer->subbuf_order;
 	old_size = buffer->subbuf_size;
 
@@ -6036,33 +6031,88 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	/* Make sure all new buffers are allocated, before deleting the old ones */
 	for_each_buffer_cpu(buffer, cpu) {
+
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
+		cpu_buffer = buffer->buffers[cpu];
+
 		/* Update the number of pages to match the new size */
 		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
 		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
 
-		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
-		if (!cpu_buffers[cpu]) {
+		/* we need a minimum of two pages */
+		if (nr_pages < 2)
+			nr_pages = 2;
+
+		cpu_buffer->nr_pages_to_update = nr_pages;
+
+		/* Include the reader page */
+		nr_pages++;
+
+		/* Allocate the new size buffer */
+		INIT_LIST_HEAD(&cpu_buffer->new_pages);
+		if (__rb_allocate_pages(cpu_buffer, nr_pages,
+					&cpu_buffer->new_pages)) {
+			/* not enough memory for new pages */
 			err = -ENOMEM;
 			goto error;
 		}
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
+
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
-		rb_free_cpu_buffer(buffer->buffers[cpu]);
-		buffer->buffers[cpu] = cpu_buffers[cpu];
+		cpu_buffer = buffer->buffers[cpu];
+
+		/* Clear the head bit to make the link list normal to read */
+		rb_head_page_deactivate(cpu_buffer);
+
+		/* Now walk the list and free all the old sub buffers */
+		list_for_each_entry_safe(bpage, tmp, cpu_buffer->pages, list) {
+			list_del_init(&bpage->list);
+			free_buffer_page(bpage);
+		}
+		/* The above loop stopped an the last page needing to be freed */
+		bpage = list_entry(cpu_buffer->pages, struct buffer_page, list);
+		free_buffer_page(bpage);
+
+		/* Free the current reader page */
+		free_buffer_page(cpu_buffer->reader_page);
+
+		/* One page was allocated for the reader page */
+		cpu_buffer->reader_page = list_entry(cpu_buffer->new_pages.next,
+						     struct buffer_page, list);
+		list_del_init(&cpu_buffer->reader_page->list);
+
+		/* The cpu_buffer pages are a link list with no head */
+		cpu_buffer->pages = cpu_buffer->new_pages.next;
+		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
+		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
+
+		/* Clear the new_pages list */
+		INIT_LIST_HEAD(&cpu_buffer->new_pages);
+
+		cpu_buffer->head_page
+			= list_entry(cpu_buffer->pages, struct buffer_page, list);
+		cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
+
+		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
+		cpu_buffer->nr_pages_to_update = 0;
+
+		free_pages((unsigned long)cpu_buffer->free_page, old_order);
+		cpu_buffer->free_page = NULL;
+
+		rb_head_page_activate(cpu_buffer);
+
+		rb_check_pages(cpu_buffer);
 	}
 
 	atomic_dec(&buffer->record_disabled);
 	mutex_unlock(&buffer->mutex);
 
-	kfree(cpu_buffers);
-
 	return 0;
 
 error:
@@ -6073,12 +6123,16 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	mutex_unlock(&buffer->mutex);
 
 	for_each_buffer_cpu(buffer, cpu) {
-		if (!cpu_buffers[cpu])
+		cpu_buffer = buffer->buffers[cpu];
+
+		if (!cpu_buffer->nr_pages_to_update)
 			continue;
-		rb_free_cpu_buffer(cpu_buffers[cpu]);
-		kfree(cpu_buffers[cpu]);
+
+		list_for_each_entry_safe(bpage, tmp, &cpu_buffer->new_pages, list) {
+			list_del_init(&bpage->list);
+			free_buffer_page(bpage);
+		}
 	}
-	kfree(cpu_buffers);
 
 	return err;
 }
-- 
2.42.0


