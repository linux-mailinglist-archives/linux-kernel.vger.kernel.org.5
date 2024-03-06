Return-Path: <linux-kernel+bounces-93216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C72872C70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B18289AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD81B295;
	Wed,  6 Mar 2024 01:58:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5EFC01;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690295; cv=none; b=H4gY6nIO3ugzCUNN5MfnEtiPqGF500CNs3Usw2VdaP1Acd6Kk30JWSHExG8JsqUdxNiDRq8wRtPwUns+pQ/ognXBz6vQ13UAQPjCGNF3DvSeSYqJNYrFL0PRsadTsEScNbq0+tW8QOiIA16CEC/hxH31Xv0wpwGGUr5mwRv87Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690295; c=relaxed/simple;
	bh=ZKShaqpkZZF9PUDpuAu2YxtJR6tLcb8gXSihlRlAzTk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Qmm8UmoYvCR5gFC3HurkEM9vBSNF3io/KayW1cKmMaypKKnvfMEPzMkFsA3IVHzppIIQ5K7CPpqdNpAgINfBBjofFsWuNSBQW0LSZ44WBUF87oqk0rwUK//XQuauRP6KVkhZ41EL5HR7W3bJH/jb05WkoSzH/Oqv/jQPD7Fft+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F44C32782;
	Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhgZi-00000000TDp-34Bg;
	Tue, 05 Mar 2024 21:00:06 -0500
Message-ID: <20240306020006.586558735@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 05 Mar 2024 20:59:18 -0500
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
Subject: [PATCH 8/8] ring-buffer: Validate boot range memory events
References: <20240306015910.766510873@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Make sure all the events in each of the sub-buffers that were mapped in a
memory region are valid. This moves the code that walks the buffers for
time-stamp validation out of the CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS
ifdef block and is used to validate the content. Only the ring buffer
event meta data is checked and not the data load.

This also has a second purpose. The buffer_page structure that points to
the data sub-buffers has accounting that keeps track of the number of
events that are on the sub-buffer. This updates that counter as well. That
counter is used in reading the buffer and knowing if the ring buffer is
empty or not.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 222 +++++++++++++++++++++++++++----------
 1 file changed, 165 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e74185a4d864..f7b511935fcf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1610,10 +1610,171 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 		subbuf = (void *)subbuf + subbuf_size;
 	}
 
-	pr_info("Ring buffer meta is from previous boot!\n");
 	return true;
 }
 
+static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf);
+
+#ifdef CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS
+static DEFINE_PER_CPU(atomic_t, checking);
+static atomic_t ts_dump;
+
+#define buffer_warn_return(fmt, ...)					\
+	do {								\
+		/* If another report is happening, ignore this one */	\
+		if (atomic_inc_return(&ts_dump) != 1) {			\
+			atomic_dec(&ts_dump);				\
+			goto out;					\
+		}							\
+		atomic_inc(&cpu_buffer->record_disabled);		\
+		pr_warn(fmt, ##__VA_ARGS__);				\
+		dump_buffer_page(bpage, info, tail);			\
+		atomic_dec(&ts_dump);					\
+		/* There's some cases in boot up that this can happen */ \
+		if (WARN_ON_ONCE(system_state != SYSTEM_BOOTING))	\
+			/* Do not re-enable checking */			\
+			return;						\
+	} while (0)
+#else
+#define buffer_warn_return(fmt, ...) do { } while (0)
+#endif
+
+static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu,
+			       unsigned long long *timestamp, bool warn)
+{
+	struct ring_buffer_event *event;
+	u64 ts, delta;
+	int events = 0;
+	int e;
+
+	ts = dpage->time_stamp;
+
+	for (e = 0; e < tail; e += rb_event_length(event)) {
+
+		event = (struct ring_buffer_event *)(dpage->data + e);
+
+		switch (event->type_len) {
+
+		case RINGBUF_TYPE_TIME_EXTEND:
+			delta = rb_event_time_stamp(event);
+			ts += delta;
+			break;
+
+		case RINGBUF_TYPE_TIME_STAMP:
+			delta = rb_event_time_stamp(event);
+			delta = rb_fix_abs_ts(delta, ts);
+			if (warn && delta < ts) {
+				buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
+						   cpu, ts, delta);
+			}
+			ts = delta;
+			break;
+
+		case RINGBUF_TYPE_PADDING:
+			if (event->time_delta == 1)
+				break;
+			fallthrough;
+		case RINGBUF_TYPE_DATA:
+			events++;
+			ts += event->time_delta;
+			break;
+
+		default:
+			return -1;
+		}
+	}
+	*timestamp = ts;
+	return events;
+}
+
+static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
+{
+	unsigned long long ts;
+	int tail;
+
+	tail = local_read(&dpage->commit);
+	return rb_read_data_buffer(dpage, tail, cpu, &ts, false);
+}
+
+/* If the meta data has been validated, now validate the events */
+static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct buffer_page *head_page;
+	unsigned long entry_bytes = 0;
+	unsigned long entries = 0;
+	int ret;
+	int i;
+
+	if (!meta || !meta->head_buffer)
+		return;
+
+	/* Do the reader page first */
+	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
+	if (ret < 0) {
+		printk("INVALID READER PAGE\n");
+		goto invalid;
+	}
+	entries += ret;
+	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
+	local_set(&cpu_buffer->reader_page->entries, ret);
+
+	head_page = cpu_buffer->head_page;
+
+	/* If both the head and commit are on the reader_page then we are done. */
+	if (head_page == cpu_buffer->reader_page &&
+	    head_page == cpu_buffer->commit_page)
+		goto done;
+
+	/* Iterate until finding the commit page */
+	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
+
+		/* Reader page has already been done */
+		if (head_page == cpu_buffer->reader_page)
+			continue;
+
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		if (ret < 0) {
+			pr_info("Ring buffer meta [%d] invalid buffer page\n",
+				cpu_buffer->cpu);
+			goto invalid;
+		}
+		entries += ret;
+		entry_bytes += local_read(&head_page->page->commit);
+		local_set(&cpu_buffer->head_page->entries, ret);
+
+		if (head_page == cpu_buffer->commit_page)
+			break;
+	}
+
+	if (head_page != cpu_buffer->commit_page) {
+		pr_info("Ring buffer meta [%d] commit page not found\n",
+			cpu_buffer->cpu);
+		goto invalid;
+	}
+ done:
+	local_set(&cpu_buffer->entries, entries);
+	local_set(&cpu_buffer->entries_bytes, entry_bytes);
+
+	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	return;
+
+ invalid:
+	/* The content of the buffers are invalid, reset the meta data */
+	meta->head_buffer = 0;
+	meta->commit_buffer = 0;
+
+	/* Reset the reader page */
+	local_set(&cpu_buffer->reader_page->entries, 0);
+	local_set(&cpu_buffer->reader_page->page->commit, 0);
+
+	/* Reset all the subbuffers */
+	for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
+		local_set(&head_page->entries, 0);
+		local_set(&head_page->page->commit, 0);
+	}
+}
+
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
@@ -1691,8 +1852,6 @@ static void *rbm_next(struct seq_file *m, void *v, loff_t *pos)
 	return rbm_start(m, pos);
 }
 
-static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf);
-
 static int rbm_show(struct seq_file *m, void *v)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
@@ -1940,6 +2099,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	if (ret < 0)
 		goto fail_free_reader;
 
+	rb_meta_validate_events(cpu_buffer);
+
 	/* If the boot meta was valid then this has already been updated */
 	meta = cpu_buffer->ring_meta;
 	if (!meta || !meta->head_buffer ||
@@ -3844,26 +4005,6 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 	pr_warn("expected end:0x%lx last event actually ended at:0x%x\n", tail, e);
 }
 
-static DEFINE_PER_CPU(atomic_t, checking);
-static atomic_t ts_dump;
-
-#define buffer_warn_return(fmt, ...)					\
-	do {								\
-		/* If another report is happening, ignore this one */	\
-		if (atomic_inc_return(&ts_dump) != 1) {			\
-			atomic_dec(&ts_dump);				\
-			goto out;					\
-		}							\
-		atomic_inc(&cpu_buffer->record_disabled);		\
-		pr_warn(fmt, ##__VA_ARGS__);				\
-		dump_buffer_page(bpage, info, tail);			\
-		atomic_dec(&ts_dump);					\
-		/* There's some cases in boot up that this can happen */ \
-		if (WARN_ON_ONCE(system_state != SYSTEM_BOOTING))	\
-			/* Do not re-enable checking */			\
-			return;						\
-	} while (0)
-
 /*
  * Check if the current event time stamp matches the deltas on
  * the buffer page.
@@ -3902,41 +4043,8 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
 
-	ts = bpage->time_stamp;
-
-	for (e = 0; e < tail; e += rb_event_length(event)) {
-
-		event = (struct ring_buffer_event *)(bpage->data + e);
-
-		switch (event->type_len) {
-
-		case RINGBUF_TYPE_TIME_EXTEND:
-			delta = rb_event_time_stamp(event);
-			ts += delta;
-			break;
-
-		case RINGBUF_TYPE_TIME_STAMP:
-			delta = rb_event_time_stamp(event);
-			delta = rb_fix_abs_ts(delta, ts);
-			if (delta < ts) {
-				buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
-						   cpu_buffer->cpu, ts, delta);
-			}
-			ts = delta;
-			break;
+	ret = rb_read_data_buffer(bpage, tail, &ts, cpu_buffer->cpu, true);
 
-		case RINGBUF_TYPE_PADDING:
-			if (event->time_delta == 1)
-				break;
-			fallthrough;
-		case RINGBUF_TYPE_DATA:
-			ts += event->time_delta;
-			break;
-
-		default:
-			RB_WARN_ON(cpu_buffer, 1);
-		}
-	}
 	if ((full && ts > info->ts) ||
 	    (!full && ts + info->delta != info->ts)) {
 		buffer_warn_return("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\n",
-- 
2.43.0



