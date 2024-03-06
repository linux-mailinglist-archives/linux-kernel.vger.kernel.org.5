Return-Path: <linux-kernel+bounces-93215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B431872C6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0471C227E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A41AACA;
	Wed,  6 Mar 2024 01:58:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5FBDF4D;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690295; cv=none; b=C0moDiM29V/IzKLgwrr+rkXySq+L5mShSF7QQ7D64CpmRmAdrTJsASjx3SY0MT+ipwnPdUYcAxWctDWAl1GricHr0Z6cPRVlQiY+0l3lD7NoqykpLBh/QfWCPzp5uv5reevvn/312hmf7myA4SdhOtGCcStYfE/Oh33cVNaN1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690295; c=relaxed/simple;
	bh=Tn/6xaTC2W1L4/hOdrfLHam9sH6p0LWo1P7r5ZH4URU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=psRuEBo6sHWDrGIxf+/nAcVZS06c6Rg/JT59cWmTiCBwLa/rJhLBk4L4Mw/Q+ErMJR/Rt9D16JtcqVAyxtfzQXzTBnVxWdDEAOhq8XfbhRuKSUSbMsScvDzqpiIMSWg0LjQ7sDTcjMoqVYTxq9yUc8fJ7Ycq04HK8t/A/FUdgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36B3C433A6;
	Wed,  6 Mar 2024 01:58:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZi-00000000TCM-10VX;
	Tue, 05 Mar 2024 21:00:06 -0500
Message-ID: <20240306020006.100449500@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:15 -0500
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
Subject: [PATCH 5/8] ring-buffer: Add ring_buffer_meta data
References: <20240306015910.766510873@goodmis.org>
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
 kernel/trace/ring_buffer.c | 207 ++++++++++++++++++++++++++++++++-----
 1 file changed, 182 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 367597dc766b..5a90ada49366 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -42,6 +42,11 @@
 static void update_pages_handler(struct work_struct *work);
 
 struct ring_buffer_meta {
+	unsigned long	head_buffer;
+	unsigned long	commit_buffer;
+	__u32		subbuf_size;
+	__u32		nr_subbufs;
+	int		buffers[];
 };
 
 /*
@@ -497,6 +502,7 @@ struct ring_buffer_per_cpu {
 	struct mutex			mapping_lock;
 	unsigned long			*subbuf_ids;	/* ID to subbuf addr */
 	struct trace_buffer_meta	*meta_page;
+	struct ring_buffer_meta		*ring_meta;
 
 	/* ring buffer pages to update, > 0 to add, < 0 to remove */
 	long				nr_pages_to_update;
@@ -1206,6 +1212,11 @@ static void rb_head_page_activate(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -1453,50 +1464,124 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
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
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		meta = rb_range_meta(buffer, nr_pages, cpu);
+
+		meta->nr_subbufs = nr_pages + 1;
+		meta->subbuf_size = buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
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
+		for (int i = 0; i < meta->nr_subbufs; i++) {
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
@@ -1537,7 +1622,6 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		set_current_oom_origin();
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
-		int cpu = cpu_buffer->cpu;
 
 		bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
 				    mflags, cpu_to_node(cpu_buffer->cpu));
@@ -1550,10 +1634,11 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
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
 						mflags | __GFP_ZERO,
@@ -1561,9 +1646,9 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 			if (!page)
 				goto free_pages;
 			bpage->page = page_address(page);
+			rb_init_page(bpage->page);
 		}
 		bpage->order = cpu_buffer->buffer->subbuf_order;
-		rb_init_page(bpage->page);
 
 		if (user_thread && fatal_signal_pending(current))
 			goto free_pages;
@@ -1644,7 +1729,13 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
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
@@ -1654,8 +1745,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (!page)
 			goto fail_free_reader;
 		bpage->page = page_address(page);
+		rb_init_page(bpage->page);
 	}
-	rb_init_page(bpage->page);
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
@@ -1669,6 +1760,10 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	rb_head_page_activate(cpu_buffer);
+	if (cpu_buffer->ring_meta) {
+		struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+		meta->commit_buffer = meta->head_buffer;
+	}
 
 	return cpu_buffer;
 
@@ -1780,6 +1875,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		nr_pages--;
 		buffer->range_addr_start = start;
 		buffer->range_addr_end = end;
+
+		rb_range_meta_init(buffer, nr_pages);
 	} else {
 
 		/* need at least two pages */
@@ -2464,6 +2561,52 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
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
@@ -2513,6 +2656,8 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
+		if (cpu_buffer->ring_meta)
+			rb_update_meta_head(cpu_buffer, next_page);
 		/*
 		 * The entries will be zeroed out when we move the
 		 * tail page.
@@ -3074,6 +3219,10 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		rb_inc_page(&cpu_buffer->commit_page);
+		if (cpu_buffer->ring_meta) {
+			struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+			meta->commit_buffer = cpu_buffer->commit_page->page;
+		}
 		/* add barrier to keep gcc from optimizing too much */
 		barrier();
 	}
@@ -4691,6 +4840,9 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	if (!ret)
 		goto spin;
 
+	if (cpu_buffer->ring_meta)
+		rb_update_meta_reader(cpu_buffer, reader);
+
 	/*
 	 * Yay! We succeeded in replacing the page.
 	 *
@@ -5381,11 +5533,16 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
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



