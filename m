Return-Path: <linux-kernel+bounces-4660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9781805D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D3285A73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3553B4;
	Tue, 19 Dec 2023 04:06:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CC11700;
	Tue, 19 Dec 2023 04:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC995C433C8;
	Tue, 19 Dec 2023 04:06:15 +0000 (UTC)
Date: Mon, 18 Dec 2023 23:07:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] ring-buffer: Fix slowpath of interrupted event
Message-ID: <20231218230712.3a76b081@gandalf.local.home>
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

To synchronize the timestamps with the ring buffer reservation, there are
two timestamps that are saved in the buffer meta data.

1. before_stamp
2. write_stamp

When the two are equal, the write_stamp is considered valid, as in, it may
be used to calculate the delta of the next event as the write_stamp is the
timestamp of the previous reserved event on the buffer.

This is done by the following:

 /*A*/	w = current position on the ring buffer
	before = before_stamp
	after = write_stamp
	ts = read current timestamp

	if (before != after) {
		write_stamp is not valid, force adding an absolute
		timestamp.
	}

 /*B*/	before_stamp = ts

 /*C*/	write = local_add_return(event length, position on ring buffer)

	if (w == write - event length) {
		/* Nothing interrupted between A and C */
 /*E*/		write_stamp = ts;
		delta = ts - after
		/*
		 * If nothing interrupted again,
		 * before_stamp == write_stamp and write_stamp
		 * can be used to calculate the delta for
		 * events that come in after this one.
		 */
	} else {

		/*
		 * The slow path!
		 * Was interrupted between A and C.
		 */

This is the place that there's a bug. We currently have:

		after = write_stamp
		ts = read current timestamp

 /*F*/		if (write == current position on the ring buffer &&
		    after < ts && cmpxchg(write_stamp, after, ts)) {

			delta = ts - after;

		} else {
			delta = 0;
		}

The assumption is that if the current position on the ring buffer hasn't
moved between C and F, then it also was not interrupted, and that the last
event written has a timestamp that matches the write_stamp. That is the
write_stamp is valid.

But this may not be the case:

If a task context event was interrupted by softirq between B and C.

And the softirq wrote an event that got interrupted by a hard irq between
C and E.

and the hard irq wrote an event (does not need to be interrupted)

We have:

 /*B*/ before_stamp = ts of normal context

   ---> interrupted by softirq

	/*B*/ before_stamp = ts of softirq context

	  ---> interrupted by hardirq

		/*B*/ before_stamp = ts of hard irq context
		/*E*/ write_stamp = ts of hard irq context

		/* matches and write_stamp valid */
	  <----

	/*E*/ write_stamp = ts of softirq context

	/* No longer matches before_stamp, write_stamp is not valid! */

   <---

 w != write - length, go to slow path

// Right now the order of events in the ring buffer is:
//
// |-- softirq event --|-- hard irq event --|-- normal context event --|
//

 after = write_stamp (this is the ts of softirq)
 ts = read current timestamp

 if (write == current position on the ring buffer [true] &&
     after < ts [true] && cmpxchg(write_stamp, after, ts) [true]) {

	delta = ts - after  [Wrong!]

The delta is to be between the hard irq event and the normal context
event, but the above logic made the delta between the softirq event and
the normal context event, where the hard irq event is between the two. This
will shift all the remaining event timestamps on the sub-buffer
incorrectly.

The write_stamp is only valid if it matches the before_stamp. The cmpxchg
does nothing to help this.

Instead, the following logic can be done to fix this:

	before = before_stamp
	ts = read current timestamp
	before_stamp = ts

	after = write_stamp

	if (write == current position on the ring buffer &&
	    after == before && after < ts) {

		delta = ts - after

	} else {
		delta = 0;
	}

The above will only use the write_stamp if it still matches before_stamp
and was tested to not have changed since C.

As a bonus, with this logic we do not need any 64-bit cmpxchg() at all!

This mean the 32-bit rb_time_t workaround can finally be removed. But
that's for a later time.

Link: https://lore.kernel.org/linux-trace-kernel/20231218175229.58ec3daf@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: dd93942570789 ("ring-buffer: Do not try to put back write_stamp")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 79 ++++++++++++--------------------------
 1 file changed, 24 insertions(+), 55 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5a114e752f11..e7055f52afe0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -700,48 +700,6 @@ rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 	return local_try_cmpxchg(l, &expect, set);
 }
 
-static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	unsigned long cnt, top, bottom, msb;
-	unsigned long cnt2, top2, bottom2, msb2;
-	u64 val;
-
-	/* Any interruptions in this function should cause a failure */
-	cnt = local_read(&t->cnt);
-
-	/* The cmpxchg always fails if it interrupted an update */
-	 if (!__rb_time_read(t, &val, &cnt2))
-		 return false;
-
-	 if (val != expect)
-		 return false;
-
-	 if ((cnt & 3) != cnt2)
-		 return false;
-
-	 cnt2 = cnt + 1;
-
-	 rb_time_split(val, &top, &bottom, &msb);
-	 msb = rb_time_val_cnt(msb, cnt);
-	 top = rb_time_val_cnt(top, cnt);
-	 bottom = rb_time_val_cnt(bottom, cnt);
-
-	 rb_time_split(set, &top2, &bottom2, &msb2);
-	 msb2 = rb_time_val_cnt(msb2, cnt);
-	 top2 = rb_time_val_cnt(top2, cnt2);
-	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
-
-	if (!rb_time_read_cmpxchg(&t->cnt, cnt, cnt2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->top, top, top2))
-		return false;
-	if (!rb_time_read_cmpxchg(&t->bottom, bottom, bottom2))
-		return false;
-	return true;
-}
-
 #else /* 64 bits */
 
 /* local64_t always succeeds */
@@ -755,11 +713,6 @@ static void rb_time_set(rb_time_t *t, u64 val)
 {
 	local64_set(&t->time, val);
 }
-
-static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
-{
-	return local64_try_cmpxchg(&t->time, &expect, set);
-}
 #endif
 
 /*
@@ -3610,20 +3563,36 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		/* Was interrupted before here, write_stamp must be valid */
+
+		/* Save the old before_stamp */
+		a_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
 		RB_WARN_ON(cpu_buffer, !a_ok);
+
+		/*
+		 * Read a new timestamp and update the before_stamp to make
+		 * the next event after this one force using an absolute
+		 * timestamp. This is in case an interrupt were to come in
+		 * between E and F.
+		 */
 		ts = rb_time_stamp(cpu_buffer->buffer);
+		rb_time_set(&cpu_buffer->before_stamp, ts);
+
+		barrier();
+ /*E*/		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+		/* Was interrupted before here, write_stamp must be valid */
+		RB_WARN_ON(cpu_buffer, !a_ok);
 		barrier();
- /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after < ts &&
-		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				    info->after, ts)) {
-			/* Nothing came after this event between C and E */
+ /*F*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
+		    info->after == info->before && info->after < ts) {
+			/*
+			 * Nothing came after this event between C and F, it is
+			 * safe to use info->after for the delta as it
+			 * matched info->before and is still valid.
+			 */
 			info->delta = ts - info->after;
 		} else {
 			/*
-			 * Interrupted between C and E:
+			 * Interrupted between C and F:
 			 * Lost the previous events time stamp. Just set the
 			 * delta to zero, and this will be the same time as
 			 * the event this event interrupted. And the events that
-- 
2.42.0


