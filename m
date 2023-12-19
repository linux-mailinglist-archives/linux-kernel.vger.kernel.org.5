Return-Path: <linux-kernel+bounces-6064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD398193B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8691C254FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985438DCA;
	Tue, 19 Dec 2023 22:37:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B23D0AE;
	Tue, 19 Dec 2023 22:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD11C433C8;
	Tue, 19 Dec 2023 22:37:01 +0000 (UTC)
Date: Tue, 19 Dec 2023 17:38:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, Kent
 Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 16/15] ring-buffer: Use subbuf_order for buffer page
 masking
Message-ID: <20231219173800.66eefb7a@gandalf.local.home>
In-Reply-To: <20231219185414.474197117@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
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

The comparisons to PAGE_SIZE were all converted to use the
buffer->subbuf_order, but the use of PAGE_MASK was missed.

Convert all the PAGE_MASK usages over to:

  (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1

Fixes: TBD ("ring-buffer: Page size per ring buffer")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7ee6779bf292..173d2595ce2d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2269,11 +2269,13 @@ rb_commit_index(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static __always_inline unsigned
-rb_event_index(struct ring_buffer_event *event)
+rb_event_index(struct ring_buffer_per_cpu *cpu_buffer, struct ring_buffer_event *event)
 {
 	unsigned long addr = (unsigned long)event;
 
-	return (addr & ~PAGE_MASK) - BUF_PAGE_HDR_SIZE;
+	addr &= (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1;
+
+	return addr - BUF_PAGE_HDR_SIZE;
 }
 
 static void rb_inc_iter(struct ring_buffer_iter *iter)
@@ -2646,7 +2648,8 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 /* Slow path */
 static struct ring_buffer_event *
-rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
+rb_add_time_stamp(struct ring_buffer_per_cpu *cpu_buffer,
+		  struct ring_buffer_event *event, u64 delta, bool abs)
 {
 	if (abs)
 		event->type_len = RINGBUF_TYPE_TIME_STAMP;
@@ -2654,7 +2657,7 @@ rb_add_time_stamp(struct ring_buffer_event *event, u64 delta, bool abs)
 		event->type_len = RINGBUF_TYPE_TIME_EXTEND;
 
 	/* Not the first event on the page, or not delta? */
-	if (abs || rb_event_index(event)) {
+	if (abs || rb_event_index(cpu_buffer, event)) {
 		event->time_delta = delta & TS_MASK;
 		event->array[0] = delta >> TS_SHIFT;
 	} else {
@@ -2728,7 +2731,7 @@ static void rb_add_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		if (!abs)
 			info->delta = 0;
 	}
-	*event = rb_add_time_stamp(*event, info->delta, abs);
+	*event = rb_add_time_stamp(cpu_buffer, *event, info->delta, abs);
 	*length -= RB_LEN_TIME_EXTEND;
 	*delta = 0;
 }
@@ -2812,10 +2815,10 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage;
 	unsigned long addr;
 
-	new_index = rb_event_index(event);
+	new_index = rb_event_index(cpu_buffer, event);
 	old_index = new_index + rb_event_ts_length(event);
 	addr = (unsigned long)event;
-	addr &= PAGE_MASK;
+	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
@@ -3726,7 +3729,7 @@ rb_decrement_entry(struct ring_buffer_per_cpu *cpu_buffer,
 	struct buffer_page *bpage = cpu_buffer->commit_page;
 	struct buffer_page *start;
 
-	addr &= PAGE_MASK;
+	addr &= ~((PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1);
 
 	/* Do the likely case first */
 	if (likely(bpage->page == (void *)addr)) {
-- 
2.42.0


