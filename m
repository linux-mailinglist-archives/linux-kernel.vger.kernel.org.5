Return-Path: <linux-kernel+bounces-21655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4A82926E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48351F26A89
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08F1871;
	Wed, 10 Jan 2024 02:26:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8417C6;
	Wed, 10 Jan 2024 02:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129BCC433F1;
	Wed, 10 Jan 2024 02:26:02 +0000 (UTC)
Date: Tue, 9 Jan 2024 21:27:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH v3] ring-buffer: Have mmapped ring buffer keep track of
 missed events
Message-ID: <20240109212702.5b8e6045@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

While testing libtracefs on the mmapped ring buffer, the test that checks
if missed events are accounted for failed when using the mapped buffer.
This is because the mapped page does not update the missed events that
were dropped because the writer filled up the ring buffer before the
reader could catch it.

Add the missed events to the reader page/sub-buffer when the IOCTL is done
and a new reader page is acquired.

Note that all accesses to the reader_page via rb_page_commit() had to be
switched to rb_page_size(), and rb_page_size() which was just a copy of
rb_page_commit() but now it masks out the RB_MISSED bits. This is needed
as the mapped reader page is still active in the ring buffer code and
where it reads the commit field of the bpage for the size, it now must
mask it otherwise the missed bits that are now set will corrupt the size
returned.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20240109173552.0b40d199@gandalf.local.home/

- Remove left-over "dump_stack()" that was used for debugging

 kernel/trace/ring_buffer.c | 60 ++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 07dae67424a9..603956bc1e59 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -312,6 +312,8 @@ static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 /* Missed count stored at end */
 #define RB_MISSED_STORED	(1 << 30)
 
+#define RB_MISSED_MASK		(3 << 30)
+
 struct buffer_data_page {
 	u64		 time_stamp;	/* page time stamp */
 	local_t		 commit;	/* write committed index */
@@ -2303,7 +2305,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 /* Size is determined by what has been committed */
 static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
 {
-	return rb_page_commit(bpage);
+	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
 }
 
 static __always_inline unsigned
@@ -3930,7 +3932,7 @@ static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
 		return true;
 
 	/* Reader should exhaust content in reader page */
-	if (reader->read != rb_page_commit(reader))
+	if (reader->read != rb_page_size(reader))
 		return false;
 
 	/*
@@ -4401,7 +4403,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	return ((iter->head_page == commit_page && iter->head >= commit) ||
 		(iter->head_page == reader && commit_page == head_page &&
 		 head_page->read == commit &&
-		 iter->head == rb_page_commit(cpu_buffer->reader_page)));
+		 iter->head == rb_page_size(cpu_buffer->reader_page)));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_empty);
 
@@ -5745,7 +5747,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	event = rb_reader_event(cpu_buffer);
 
 	read = reader->read;
-	commit = rb_page_commit(reader);
+	commit = rb_page_size(reader);
 
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
@@ -5822,7 +5824,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += rb_page_commit(reader);
+		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
 		rb_init_page(bpage);
@@ -6349,6 +6351,8 @@ struct page *ring_buffer_map_fault(struct trace_buffer *buffer, int cpu,
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
+	struct buffer_page *reader;
+	unsigned long missed_events;
 	unsigned long reader_size;
 	unsigned long flags;
 
@@ -6374,9 +6378,53 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
-	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
+	reader = rb_get_reader_page(cpu_buffer);
+	if (WARN_ON(!reader))
 		goto out;
 
+	/* Check if any events were dropped */
+	missed_events = cpu_buffer->lost_events;
+
+	if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
+		if (missed_events) {
+			struct buffer_data_page *bpage = reader->page;
+			unsigned int commit;
+			/*
+			 * Use the real_end for the data size,
+			 * This gives us a chance to store the lost events
+			 * on the page.
+			 */
+			if (reader->real_end)
+				local_set(&bpage->commit, reader->real_end);
+			/*
+			 * If there is room at the end of the page to save the
+			 * missed events, then record it there.
+			 */
+			commit = rb_page_size(reader);
+			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+				memcpy(&bpage->data[commit], &missed_events,
+				       sizeof(missed_events));
+				local_add(RB_MISSED_STORED, &bpage->commit);
+				commit += sizeof(missed_events);
+			}
+			local_add(RB_MISSED_EVENTS, &bpage->commit);
+			/*
+			 * This page may be off to user land. Zero it out here.
+			 */
+			if (commit < buffer->subbuf_size)
+				memset(&bpage->data[commit], 0,
+				       buffer->subbuf_size - commit);
+		}
+	} else {
+		/*
+		 * There really shouldn't be any missed events if the commit
+		 * is on the reader page.
+		 */
+		WARN_ON_ONCE(missed_events);
+	}
+
+	cpu_buffer->lost_events = 0;
+
 	goto consume;
 out:
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.43.0


