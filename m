Return-Path: <linux-kernel+bounces-940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDD81484B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E91283C28
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF85C2C68E;
	Fri, 15 Dec 2023 12:41:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE162D791;
	Fri, 15 Dec 2023 12:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F74DC433C8;
	Fri, 15 Dec 2023 12:41:53 +0000 (UTC)
Date: Fri, 15 Dec 2023 07:41:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>, Vincent Donnefort 
 <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Remove useless update to write_stamp in
 rb_try_to_discard()
Message-ID: <20231215074151.447e14c2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When filtering is enabled, a temporary buffer is created to place the
content of the trace event output so that the filter logic can decide
from the trace event output if the trace event should be filtered out or
not. If it is to be filtered out, the content in the temporary buffer is
simply discarded, otherwise it is written into the trace buffer.

But if an interrupt were to come in while a previous event was using that
temporary buffer, the event written by the interrupt would actually go
into the ring buffer itself to prevent corrupting the data on the
temporary buffer. If the event is to be filtered out, the event in the
ring buffer is discarded, or if it fails to discard because another event
were to have already come in, it is turned into padding.

The update to the write_stamp in the rb_try_to_discard() happens after a
fix was made to force the next event after the discard to use an absolute
timestamp by setting the before_stamp to zero so it does not match the
write_stamp (which causes an event to use the absolute timestamp).

But there's an effort in rb_try_to_discard() to put back the write_stamp
to what it was before the event was added. But this is useless and
wasteful because nothing is going to be using that write_stamp for
calculations as it still will not match the before_stamp.

Remove this useless update, and in doing so, we remove another
cmpxchg64()!

Also update the comments to reflect this change as well as remove some
extra white space in another comment.

Fixes: b2dd797543cf ("ring-buffer: Force absolute timestamp on discard of event")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 46 +++++++++-----------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 378ff9e53fe6..56b97a16ea16 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2792,25 +2792,6 @@ static unsigned rb_calculate_event_length(unsigned length)
 	return length;
 }
 
-static u64 rb_time_delta(struct ring_buffer_event *event)
-{
-	switch (event->type_len) {
-	case RINGBUF_TYPE_PADDING:
-		return 0;
-
-	case RINGBUF_TYPE_TIME_EXTEND:
-		return rb_event_time_stamp(event);
-
-	case RINGBUF_TYPE_TIME_STAMP:
-		return 0;
-
-	case RINGBUF_TYPE_DATA:
-		return event->time_delta;
-	default:
-		return 0;
-	}
-}
-
 static inline bool
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
@@ -2818,8 +2799,6 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	unsigned long new_index, old_index;
 	struct buffer_page *bpage;
 	unsigned long addr;
-	u64 write_stamp;
-	u64 delta;
 
 	new_index = rb_event_index(event);
 	old_index = new_index + rb_event_ts_length(event);
@@ -2828,13 +2807,10 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
-	delta = rb_time_delta(event);
-
-	rb_time_read(&cpu_buffer->write_stamp, &write_stamp);
-
-	/* Make sure the write stamp is read before testing the location */
-	barrier();
-
+	/*
+	 * Make sure the tail_page is still the same and
+	 * the next write location is the end of this event
+	 */
 	if (bpage->page == (void *)addr && rb_page_write(bpage) == old_index) {
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
@@ -2845,20 +2821,20 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		 * to make sure that the next event adds an absolute
 		 * value and does not rely on the saved write stamp, which
 		 * is now going to be bogus.
+		 *
+		 * By setting the before_stamp to zero, the next event
+		 * is not going to use the write_stamp and will instead
+		 * create an absolute timestamp. This means there's no
+		 * reason to update the wirte_stamp!
 		 */
 		rb_time_set(&cpu_buffer->before_stamp, 0);
 
-		/* Something came in, can't discard */
-		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				       write_stamp, write_stamp - delta))
-			return false;
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
 		 * that this event just added itself before updating
 		 * the write stamp. The interrupting event will fix the
-		 * write stamp for us, and use the before stamp as its delta.
+		 * write stamp for us, and use an absolute timestamp.
 		 */
 
 		/*
@@ -3295,7 +3271,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
-- 
2.42.0


