Return-Path: <linux-kernel+bounces-72056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2934885AE65
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB940284AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F655C16;
	Mon, 19 Feb 2024 22:28:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030DF9E0;
	Mon, 19 Feb 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381700; cv=none; b=HmVvOAL3IRuwz+CwLPyruJi4iCOR+95A+7tvW/ynDvu9sv+x3nBogTgki59oBzuCM/vDZ4J6NGGyZBdAQ84tRcACo5682BzWX61iMBDkH7EKO2e1KLGHBl0plA2qPMzMxd1PDOeJ3z/lkbZRWJ++GbiOcqNrCuCUmYOPK6qxq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381700; c=relaxed/simple;
	bh=i6q7y2j0vNWvZS7oD9Y9HjF1bcJC1i3lu0aXjcy0EyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ybt9jo5VC3oWlGAI70STD7uxWhBuc57ArHTNeSJf4rwWSFh8VIvnJJuMTzQlGbMGoc0cPXQnR5cd7Ai1ecx/XFPGB97UoG68C6WUS6bZ0vQom8YgAWPbi/E0uTOHjjYUKdf1JDa+8IDkpeQ7gl7gr2RzEwGBNtVXBp98EMYnVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B067FC433C7;
	Mon, 19 Feb 2024 22:28:19 +0000 (UTC)
Date: Mon, 19 Feb 2024 17:30:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] ring-buffer: Simplify reservation with try_cmpxchg()
 loop
Message-ID: <20240219173003.08339d54@gandalf.local.home>
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

Instead of using local_add_return() to reserve the ring buffer data,
Mathieu Desnoyers suggested using local_cmpxchg(). This would simplify the
reservation with the time keeping code.

Although, it does not get rid of the double time stamps (before_stamp and
write_stamp), using cmpxchg() does get rid of the more complex case when
an interrupting event occurs between getting the timestamps and reserving
the data, as when that happens, it just tries again instead of dealing
with it.

Before we had:

	w = local_read(&tail_page->write);
	/* get time stamps */
	write = local_add_return(length, &tail_page->write);
	if (write - length == w) {
		/* do simple case */
	} else {
		/* do complex case */
	}

By switching the local_add_return() to a local_try_cmpxchg() it can now be:

	 w = local_read(&tail_page->write);
 again:
	/* get time stamps */
	if (!local_try_cmpxchg(&tail_page->write, &w, w + length))
		goto again;

	 /* do simple case */

The benchmarks between the two showed no regressions when trying this:

 Enable: CONFIG_TRACEPOINT_BENCHMARK

 # trace-cmd record -m 800000 -e benchmark sleep 60

Before the patch:

 # trace-cmd report | tail
 event_benchmark-944   [003]  1998.910191: benchmark_event:      last=150 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=150
 event_benchmark-944   [003]  1998.910192: benchmark_event:      last=149 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=149
 event_benchmark-944   [003]  1998.910193: benchmark_event:      last=150 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=150
 event_benchmark-944   [003]  1998.910193: benchmark_event:      last=150 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=150
 event_benchmark-944   [003]  1998.910194: benchmark_event:      last=136 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=136
 event_benchmark-944   [003]  1998.910194: benchmark_event:      last=138 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=138
 event_benchmark-944   [003]  1998.910195: benchmark_event:      last=150 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=150
 event_benchmark-944   [003]  1998.910196: benchmark_event:      last=151 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=151
 event_benchmark-944   [003]  1998.910196: benchmark_event:      last=150 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=150
 event_benchmark-944   [003]  1998.910197: benchmark_event:      last=152 first=3488 max=1199686 min=124 avg=208 std=39 std^2=1579 delta=152

After the patch:

 # trace-cmd report | tail
 event_benchmark-848   [004]   171.414716: benchmark_event:      last=143 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=143
 event_benchmark-848   [004]   171.414717: benchmark_event:      last=142 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=142
 event_benchmark-848   [004]   171.414718: benchmark_event:      last=142 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=142
 event_benchmark-848   [004]   171.414718: benchmark_event:      last=141 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=141
 event_benchmark-848   [004]   171.414719: benchmark_event:      last=141 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=141
 event_benchmark-848   [004]   171.414719: benchmark_event:      last=141 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=141
 event_benchmark-848   [004]   171.414720: benchmark_event:      last=140 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=140
 event_benchmark-848   [004]   171.414721: benchmark_event:      last=142 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=142
 event_benchmark-848   [004]   171.414721: benchmark_event:      last=145 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=145
 event_benchmark-848   [004]   171.414722: benchmark_event:      last=144 first=14483 max=1155491 min=125 avg=189 std=16 std^2=264 delta=144

It may have even improved!

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240118181206.4977da2f@gandalf.local.home

- If the try_cmpxchg() fails when it added a timestamp, it is likely to add
  the length of that timestamp again. Subtract the length if it fails.

 kernel/trace/ring_buffer.c | 103 ++++++++++++-------------------------
 1 file changed, 34 insertions(+), 69 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..4ba0af82c33e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3455,9 +3455,11 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
 
- /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
+ /*A*/	w = local_read(&tail_page->write);
 	barrier();
 	rb_time_read(&cpu_buffer->before_stamp, &info->before);
+	/* Read before_stamp only the first time through */
+ again:
 	rb_time_read(&cpu_buffer->write_stamp, &info->after);
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
@@ -3470,7 +3472,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * absolute timestamp.
 		 * Don't bother if this is the start of a new page (w == 0).
 		 */
-		if (!w) {
+		if (!(w & RB_WRITE_MASK)) {
 			/* Use the sub-buffer timestamp */
 			info->delta = 0;
 		} else if (unlikely(info->before != info->after)) {
@@ -3487,89 +3489,52 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
  /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
 
- /*C*/	write = local_add_return(info->length, &tail_page->write);
+ /*C*/	if (!local_try_cmpxchg(&tail_page->write, &w, w + info->length)) {
+		if (info.add_timestamp & (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND))
+			info.length -= RB_LEN_TIME_EXTEND;
+		goto again;
+	}
 
-	/* set write to only the index of the write */
-	write &= RB_WRITE_MASK;
+	/* Set write to the start of this event */
+	write = w & RB_WRITE_MASK;
 
-	tail = write - info->length;
+	/* set tail to the end of the event */
+	tail = write + info->length;
 
 	/* See if we shot pass the end of this buffer page */
-	if (unlikely(write > cpu_buffer->buffer->subbuf_size)) {
+	if (unlikely(tail > cpu_buffer->buffer->subbuf_size)) {
 		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
-		return rb_move_tail(cpu_buffer, tail, info);
+		return rb_move_tail(cpu_buffer, write, info);
 	}
 
-	if (likely(tail == w)) {
-		/* Nothing interrupted us between A and C */
- /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
-		/*
-		 * If something came in between C and D, the write stamp
-		 * may now not be in sync. But that's fine as the before_stamp
-		 * will be different and then next event will just be forced
-		 * to use an absolute timestamp.
-		 */
-		if (likely(!(info->add_timestamp &
-			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
-			/* This did not interrupt any time update */
-			info->delta = info->ts - info->after;
-		else
-			/* Just use full timestamp for interrupting event */
-			info->delta = info->ts;
-		check_buffer(cpu_buffer, info, tail);
-	} else {
-		u64 ts;
-		/* SLOW PATH - Interrupted between A and C */
-
-		/* Save the old before_stamp */
-		rb_time_read(&cpu_buffer->before_stamp, &info->before);
-
-		/*
-		 * Read a new timestamp and update the before_stamp to make
-		 * the next event after this one force using an absolute
-		 * timestamp. This is in case an interrupt were to come in
-		 * between E and F.
-		 */
-		ts = rb_time_stamp(cpu_buffer->buffer);
-		rb_time_set(&cpu_buffer->before_stamp, ts);
-
-		barrier();
- /*E*/		rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		barrier();
- /*F*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after == info->before && info->after < ts) {
-			/*
-			 * Nothing came after this event between C and F, it is
-			 * safe to use info->after for the delta as it
-			 * matched info->before and is still valid.
-			 */
-			info->delta = ts - info->after;
-		} else {
-			/*
-			 * Interrupted between C and F:
-			 * Lost the previous events time stamp. Just set the
-			 * delta to zero, and this will be the same time as
-			 * the event this event interrupted. And the events that
-			 * came after this will still be correct (as they would
-			 * have built their delta on the previous event.
-			 */
-			info->delta = 0;
-		}
-		info->ts = ts;
-		info->add_timestamp &= ~RB_ADD_STAMP_FORCE;
-	}
+	/* Nothing interrupted us between A and C */
+ /*D*/	rb_time_set(&cpu_buffer->write_stamp, info->ts);
+	/*
+	 * If something came in between C and D, the write stamp
+	 * may now not be in sync. But that's fine as the before_stamp
+	 * will be different and then next event will just be forced
+	 * to use an absolute timestamp.
+	 */
+	if (likely(!(info->add_timestamp &
+		     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
+		/* This did not interrupt any time update */
+		info->delta = info->ts - info->after;
+	else
+		/* Just use full timestamp for interrupting event */
+		info->delta = info->ts;
+	check_buffer(cpu_buffer, info, write);
 
 	/*
 	 * If this is the first commit on the page, then it has the same
 	 * timestamp as the page itself.
 	 */
-	if (unlikely(!tail && !(info->add_timestamp &
+	if (unlikely(!write && !(info->add_timestamp &
 				(RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 		info->delta = 0;
 
 	/* We reserved something on the buffer */
 
-	event = __rb_page_index(tail_page, tail);
+	event = __rb_page_index(tail_page, write);
 	rb_update_event(cpu_buffer, event, info);
 
 	local_inc(&tail_page->entries);
@@ -3578,7 +3543,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	 * If this is the first commit on the page, then update
 	 * its timestamp.
 	 */
-	if (unlikely(!tail))
+	if (unlikely(!write))
 		tail_page->page->time_stamp = info->ts;
 
 	/* account for these added bytes */
-- 
2.43.0


