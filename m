Return-Path: <linux-kernel+bounces-8740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F1381BB94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0157728C6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637774E15;
	Thu, 21 Dec 2023 16:10:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AB73190
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C46C433CC;
	Thu, 21 Dec 2023 16:10:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGLdb-000000041O5-0GxN;
	Thu, 21 Dec 2023 11:11:07 -0500
Message-ID: <20231221161106.846599574@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 11:10:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [for-next][PATCH 16/16] ring-buffer: Use subbuf_order for buffer page masking
References: <20231221161024.478795180@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The comparisons to PAGE_SIZE were all converted to use the
buffer->subbuf_order, but the use of PAGE_MASK was missed.

Convert all the PAGE_MASK usages over to:

  (PAGE_SIZE << cpu_buffer->buffer->subbuf_order) - 1

Link: https://lore.kernel.org/linux-trace-kernel/20231219173800.66eefb7a@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Fixes: 139f84002145 ("ring-buffer: Page size per ring buffer")
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



