Return-Path: <linux-kernel+bounces-139620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124528A0572
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CF91C229A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8267A0C;
	Thu, 11 Apr 2024 01:26:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DE61674;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798786; cv=none; b=l4TGjJsEdC/0yJu/78eftZ5li7dg/4O6iN6lVXx4BJLzvkWE/FcGSML/cEZ3HHhLYHZfsxOONCr3EquWxPs/R+UKWqyDhGE+puIm5WuJ1ccHkhb9Y5HQxpxRc/7mXJzRI3NdZw2lUnFgRvL4txEJfXeqM2nAaHdEcs0cPaJtFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798786; c=relaxed/simple;
	bh=G17z1aT/3B5BtwWO23Z92QlEpsuy8r9Regd4BdW0d2o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VqFulNx+ECY/rbo7gmBd4PRf1UzDudqPv8+J9HtR+F+K+3awEe02MTe3WHxd2b944pnPCgPra2rbHNr9InCjEu0n3o3DS4QnLvrV+qqMpjklZ/UWphDu9+nJbvQufbKtgPkR4yC6DIDMpAokTFshav978FwtJGV+wBsaN+Krmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA2C4166A;
	Thu, 11 Apr 2024 01:26:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rujFQ-00000000nVS-2uul;
	Wed, 10 Apr 2024 21:29:04 -0400
Message-ID: <20240411012904.554737831@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 10 Apr 2024 21:25:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH v2 03/11] ring-buffer: Add ring_buffer_meta data
References: <20240411012541.285904543@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Populate the ring_buffer_meta array. It holds the pointer to the
head_buffer (next to read), the commit_buffer (next to write) the size of
the sub-buffers, number of sub-buffers and an array that keeps track of
the order of the sub-buffers.

This information will be stored in the persistent memory to help on reboot
to reconstruct the ring buffer.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 208 ++++++++++++++++++++++++++++++++-----
 1 file changed, 183 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a6d22a77f128..db8762faef77 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -43,6 +43,11 @@
 static void update_pages_handler(struct work_struct *work);
 
 struct ring_buffer_meta {
+	unsigned long	head_buffer;
+	unsigned long	commit_buffer;
+	__u32		subbuf_size;
+	__u32		nr_subbufs;
+	int		buffers[];
 };
 
 /*
@@ -498,6 +503,7 @@ struct ring_buffer_per_cpu {
 	struct mutex			mapping_lock;
 	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
+	struct ring_buffer_meta		*ring_meta;
 
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
@@ -1258,6 +1264,11 @@ static void rb_head_page_activate(struct ring_buffer_per_cpu *cpu_buffer)
 	 * Set the previous list pointer to have the HEAD flag.
 	 */
 	rb_set_list_to_head(head->list.prev);
+
+	if (cpu_buffer->ring_meta) {
+		struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+		meta->head_buffer = (unsigned long)head->page;
+	}
 }
 
 static void rb_list_head_clear(struct list_head *list)
@@ -1505,50 +1516,125 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
 }
 
 /*
- * Return a specific sub-buffer for a given @cpu defined by @idx.
+ * Return the ring_buffer_meta for a given @cpu.
  */
-static void *rb_range_buffer(struct trace_buffer *buffer, int cpu, int nr_pages, int idx)
+static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
 {
-	unsigned long ptr;
 	int subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+	unsigned long ptr = buffer->range_addr_start;
+	struct ring_buffer_meta *meta;
 	int nr_subbufs;
 
-	/* Include the reader page */
-	nr_subbufs = nr_pages + 1;
+	if (!ptr)
+		return NULL;
+
+	/* When nr_pages passed in is zero, the first meta has already been initialized */
+	if (!nr_pages) {
+		meta = (struct ring_buffer_meta *)ptr;
+		nr_subbufs = meta->nr_subbufs;
+	} else {
+		meta = NULL;
+		/* Include the reader page */
+		nr_subbufs = nr_pages + 1;
+	}
 
 	/*
 	 * The first chunk may not be subbuffer aligned, where as
 	 * the rest of the chunks are.
 	 */
-	ptr = buffer->range_addr_start;
-	ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
 	if (cpu) {
-		unsigned long p;
-
-		ptr += subbuf_size * nr_subbufs;
-
-		/* Save the beginning of this CPU chunk */
-		p = ptr;
-
 		ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
+		ptr += subbuf_size * nr_subbufs;
 
 		if (cpu > 1) {
 			unsigned long size;
+			unsigned long p;
 
+			/* Save the beginning of this CPU chunk */
+			p = ptr;
+			ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
 			ptr += subbuf_size * nr_subbufs;
 
 			/* Now all chunks after this are the same size */
 			size = ptr - p;
 			ptr += size * (cpu - 2);
-
-			ptr = rb_range_align_subbuf(ptr, subbuf_size, nr_subbufs);
 		}
 	}
-	if (ptr + subbuf_size * nr_subbufs > buffer->range_addr_end)
+	return (void *)ptr;
+}
+
+static void *rb_subbufs_from_meta(struct ring_buffer_meta *meta)
+{
+	int subbuf_size = meta->subbuf_size;
+	unsigned long ptr;
+
+	ptr = (unsigned long)meta;
+	ptr = rb_range_align_subbuf(ptr, subbuf_size, meta->nr_subbufs);
+
+	return (void *)ptr;
+}
+
+/*
+ * Return a specific sub-buffer for a given @cpu defined by @idx.
+ */
+static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
+{
+	struct ring_buffer_meta *meta;
+	unsigned long ptr;
+	int subbuf_size;
+
+	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
+	if (!meta)
+		return NULL;
+
+	if (WARN_ON_ONCE(idx >= meta->nr_subbufs))
 		return NULL;
+
+	subbuf_size = meta->subbuf_size;
+
+	/* Map this buffer to the order that's in meta->buffers[] */
+	idx = meta->buffers[idx];
+
+	ptr = (unsigned long)rb_subbufs_from_meta(meta);
+
+	ptr += subbuf_size * idx;
+	if (ptr + subbuf_size > cpu_buffer->buffer->range_addr_end)
+		return NULL;
+
 	return (void *)ptr;
 }
 
+static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
+{
+	struct ring_buffer_meta *meta;
+	void *subbuf;
+	int cpu;
+	int i;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		meta = rb_range_meta(buffer, nr_pages, cpu);
+
+		meta->nr_subbufs = nr_pages + 1;
+		meta->subbuf_size = PAGE_SIZE;
+
+		subbuf = rb_subbufs_from_meta(meta);
+
+		/*
+		 * The buffers[] array holds the order of the sub-buffers
+		 * that are after the meta data. The sub-buffers may
+		 * be swapped out when read and inserted into a different
+		 * location of the ring buffer. Although their addresses
+		 * remain the same, the buffers[] array contains the
+		 * index into the sub-buffers holding their actual order.
+		 */
+		for (i = 0; i < meta->nr_subbufs; i++) {
+			meta->buffers[i] = i;
+			rb_init_page(subbuf);
+			subbuf += meta->subbuf_size;
+		}
+	}
+}
+
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		long nr_pages, struct list_head *pages)
 {
@@ -1589,7 +1675,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		set_current_oom_origin();
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
-		int cpu = cpu_buffer->cpu;
 
 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 				    mflags, cpu_to_node(cpu_buffer->cpu));
@@ -1602,10 +1687,11 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		if (buffer->range_addr_start) {
 			/* A range was given. Use that for the buffer page */
-			bpage->page = rb_range_buffer(buffer, cpu, nr_pages, i + 1);
+			bpage->page = rb_range_buffer(cpu_buffer, i + 1);
 			if (!bpage->page)
 				goto free_pages;
 			bpage->range = 1;
+			bpage->id = i + 1;
 		} else {
 			page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
 						mflags | __GFP_COMP | __GFP_ZERO,
@@ -1613,9 +1699,9 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			if (!page)
 				goto free_pages;
 			bpage->page = page_address(page);
+			rb_init_page(bpage->page);
 		}
 		bpage->order = cpu_buffer->buffer->subbuf_order;
-		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
 			goto free_pages;
@@ -1696,7 +1782,13 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	cpu_buffer->reader_page = bpage;
 
 	if (buffer->range_addr_start) {
-		bpage->page = rb_range_buffer(buffer, cpu, nr_pages, 0);
+		/*
+		 * Range mapped buffers have the same restrictions as memory
+		 * mapped ones do.
+		 */
+		cpu_buffer->mapped = 1;
+		cpu_buffer->ring_meta = rb_range_meta(buffer, nr_pages, cpu);
+		bpage->page = rb_range_buffer(cpu_buffer, 0);
 		if (!bpage->page)
 			goto fail_free_reader;
 		bpage->range = 1;
@@ -1707,8 +1799,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (!page)
 			goto fail_free_reader;
 		bpage->page = page_address(page);
+		rb_init_page(bpage->page);
 	}
-	rb_init_page(bpage->page);
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
@@ -1722,6 +1814,10 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	rb_head_page_activate(cpu_buffer);
+	if (cpu_buffer->ring_meta) {
+		struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+		meta->commit_buffer = meta->head_buffer;
+	}
 
 	return cpu_buffer;
 
@@ -1833,6 +1929,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		nr_pages--;
 		buffer->range_addr_start = start;
 		buffer->range_addr_end = end;
+
+		rb_range_meta_init(buffer, nr_pages);
 	} else {
 
 		/* need at least two pages */
@@ -2517,6 +2615,52 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 	iter->next_event = 0;
 }
 
+/* Return the index into the sub-buffers for a given sub-buffer */
+static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf)
+{
+	void *subbuf_array;
+
+	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
+	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
+	return (subbuf - subbuf_array) / meta->subbuf_size;
+}
+
+static void rb_update_meta_head(struct ring_buffer_per_cpu *cpu_buffer,
+				struct buffer_page *next_page)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	unsigned long old_head = (unsigned long)next_page->page;
+	unsigned long new_head;
+
+	rb_inc_page(&next_page);
+	new_head = (unsigned long)next_page->page;
+
+	/*
+	 * Only move it forward once, if something else came in and
+	 * moved it forward, then we don't want to touch it.
+	 */
+	(void)cmpxchg(&meta->head_buffer, old_head, new_head);
+}
+
+static void rb_update_meta_reader(struct ring_buffer_per_cpu *cpu_buffer,
+				  struct buffer_page *reader)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	void *old_reader = cpu_buffer->reader_page->page;
+	void *new_reader = reader->page;
+	int id;
+
+	id = reader->id;
+	cpu_buffer->reader_page->id = id;
+	reader->id = 0;
+
+	meta->buffers[0] = rb_meta_subbuf_idx(meta, new_reader);
+	meta->buffers[id] = rb_meta_subbuf_idx(meta, old_reader);
+
+	/* The head pointer is the one after the reader */
+	rb_update_meta_head(cpu_buffer, reader);
+}
+
 /*
  * rb_handle_head_page - writer hit the head page
  *
@@ -2566,6 +2710,8 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
+		if (cpu_buffer->ring_meta)
+			rb_update_meta_head(cpu_buffer, next_page);
 		/*
 		 * The entries will be zeroed out when we move the
 		 * tail page.
@@ -3127,6 +3273,10 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		rb_inc_page(&cpu_buffer->commit_page);
+		if (cpu_buffer->ring_meta) {
+			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+			meta->commit_buffer = (unsigned long)cpu_buffer->commit_page->page;
+		}
 		/* add barrier to keep gcc from optimizing too much */
 		barrier();
 	}
@@ -4744,6 +4894,9 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	if (!ret)
 		goto spin;
 
+	if (cpu_buffer->ring_meta)
+		rb_update_meta_reader(cpu_buffer, reader);
+
 	/*
 	 * Yay! We succeeded in replacing the page.
 	 *
@@ -5434,11 +5587,16 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
-	if (cpu_buffer->mapped)
-		rb_update_meta_page(cpu_buffer);
-
 	rb_head_page_activate(cpu_buffer);
 	cpu_buffer->pages_removed = 0;
+
+	if (cpu_buffer->mapped) {
+		rb_update_meta_page(cpu_buffer);
+		if (cpu_buffer->ring_meta) {
+			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+			meta->commit_buffer = meta->head_buffer;
+		}
+	}
 }
 
 /* Must have disabled the cpu buffer then done a synchronize_rcu */
-- 
2.43.0



