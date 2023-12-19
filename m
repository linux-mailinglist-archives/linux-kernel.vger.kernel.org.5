Return-Path: <linux-kernel+bounces-5846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF681900F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B8F1C220AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6933DB8C;
	Tue, 19 Dec 2023 18:55:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10513BB55;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1089C433CC;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGZ-00000003R5M-0fTL;
	Tue, 19 Dec 2023 13:56:31 -0500
Message-ID: <20231219185630.944104939@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:26 -0500
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
Subject: [PATCH v5 12/15] ring-buffer: Just update the subbuffers when changing their
 allocation order
References: <20231219185414.474197117@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
index 23ead7602da0..7ee6779bf292 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5856,11 +5856,11 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
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
 
@@ -5874,11 +5874,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
-	bsize = sizeof(void *) * buffer->cpus;
-	cpu_buffers = kzalloc(bsize, GFP_KERNEL);
-	if (!cpu_buffers)
-		return -ENOMEM;
-
 	old_order = buffer->subbuf_order;
 	old_size = buffer->subbuf_size;
 
@@ -5894,33 +5889,88 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
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
@@ -5931,12 +5981,16 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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



