Return-Path: <linux-kernel+bounces-4302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4D817B24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACB81F23E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827C72053;
	Mon, 18 Dec 2023 19:42:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242ED71450;
	Mon, 18 Dec 2023 19:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA59FC433C9;
	Mon, 18 Dec 2023 19:42:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFJWa-000000038lg-1Ydx;
	Mon, 18 Dec 2023 14:43:36 -0500
Message-ID: <20231218194336.159193625@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 18 Dec 2023 14:42:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 2/2] ring-buffer: Remove 32bit timestamp logic
References: <20231218194247.018725743@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Each event has a 27 bit timestamp delta that is used to hold the delta
from the last event. If the time between events is greater than 2^27, then
a timestamp is added that holds a 59 bit absolute timestamp.

Until a389d86f7fd09 ("ring-buffer: Have nested events still record running
time stamp"), if an interrupt interrupted an event in progress, all the
events delta would be zero to not deal with the races that need to be
handled. The commit a389d86f7fd09 changed that to handle the races giving
all events, even those that preempt other events, still have an accurate
timestamp.

To handle those races requires performing 64-bit cmpxchg on the
timestamps. But doing 64-bit cmpxchg on 32-bit architectures is considered
very slow. To try to deal with this the timestamp logic was broken into
two and then three 32-bit cmpxchgs, with the thought that two (or three)
32-bit cmpxchgs are still faster than a single 64-bit cmpxchg on 32-bit
architectures.

Part of the problem with this is that I didn't have any 32-bit
architectures to test on. After hitting several subtle bugs in this code,
an effort was made to try and see if three 32-bit cmpxchgs are indeed
faster than a single 64-bit. After a few people brushed off the dust of
their old 32-bit machines, tests were done, and even though 32-bit cmpxchg
was faster than a single 64-bit, it was in the order of 50% at best, not
300%.

After some more refactoring of the code, 3 of the 4 64-bit cmpxchg were
removed:

 https://lore.kernel.org/linux-trace-kernel/20231211114420.36dde01b@gandalf.local.home
 https://lore.kernel.org/linux-trace-kernel/20231214222921.193037a7@gandalf.local.home
 https://lore.kernel.org/linux-trace-kernel/20231215081810.1f4f38fe@rorschach.local.home

The last remaining 64-bit cmpxchg is only in a slow path and to keep the
next event from having to add an absolute timestamp. This is not worth the
trouble of a slow cmpxchg. Only do the cmpxchg on 64-bit architectures and
just have the 32-bit architectures insert an absolute timestamp for the
next event that comes after the slow path. The slow path only happens if
the event being recorded is interrupted between a few lines of code and
that interrupt writes an event into the same buffer. This seldom happens
and should not cause any issues by inserting an extra absolute timestamp
when it does happen.

Now the complex 32-bit workaround for 64-bit cmpxchg can be removed.

Link: https://lore.kernel.org/all/20231213214632.15047c40@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/all/20231215165628.387150742@goodmis.org

- Fixed the check for expect == t->time to use local64_read()
  and not READ_ONCE().

 kernel/trace/ring_buffer.c | 238 +++++--------------------------------
 1 file changed, 27 insertions(+), 211 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 455a2113eb02..3eda81ed7d7e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -27,6 +27,7 @@
 #include <linux/cpu.h>
 #include <linux/oom.h>
 
+#include <asm/local64.h>
 #include <asm/local.h>
 
 /*
@@ -463,27 +464,9 @@ enum {
 	RB_CTX_MAX
 };
 
-#if BITS_PER_LONG == 32
-#define RB_TIME_32
-#endif
-
-/* To test on 64 bit machines */
-//#define RB_TIME_32
-
-#ifdef RB_TIME_32
-
-struct rb_time_struct {
-	local_t		cnt;
-	local_t		top;
-	local_t		bottom;
-	local_t		msb;
-};
-#else
-#include <asm/local64.h>
 struct rb_time_struct {
 	local64_t	time;
 };
-#endif
 typedef struct rb_time_struct rb_time_t;
 
 #define MAX_NEST	5
@@ -573,192 +556,34 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
-#ifdef RB_TIME_32
-
-/*
- * On 32 bit machines, local64_t is very expensive. As the ring
- * buffer doesn't need all the features of a true 64 bit atomic,
- * on 32 bit, it uses these functions (64 still uses local64_t).
- *
- * For the ring buffer, 64 bit required operations for the time is
- * the following:
- *
- *  - Reads may fail if it interrupted a modification of the time stamp.
- *      It will succeed if it did not interrupt another write even if
- *      the read itself is interrupted by a write.
- *      It returns whether it was successful or not.
- *
- *  - Writes always succeed and will overwrite other writes and writes
- *      that were done by events interrupting the current write.
- *
- *  - A write followed by a read of the same time stamp will always succeed,
- *      but may not contain the same value.
- *
- *  - A cmpxchg will fail if it interrupted another write or cmpxchg.
- *      Other than that, it acts like a normal cmpxchg.
- *
- * The 60 bit time stamp is broken up by 30 bits in a top and bottom half
- *  (bottom being the least significant 30 bits of the 60 bit time stamp).
- *
- * The two most significant bits of each half holds a 2 bit counter (0-3).
- * Each update will increment this counter by one.
- * When reading the top and bottom, if the two counter bits match then the
- *  top and bottom together make a valid 60 bit number.
- */
-#define RB_TIME_SHIFT	30
-#define RB_TIME_VAL_MASK ((1 << RB_TIME_SHIFT) - 1)
-#define RB_TIME_MSB_SHIFT	 60
-
-static inline int rb_time_cnt(unsigned long val)
-{
-	return (val >> RB_TIME_SHIFT) & 3;
-}
-
-static inline u64 rb_time_val(unsigned long top, unsigned long bottom)
-{
-	u64 val;
-
-	val = top & RB_TIME_VAL_MASK;
-	val <<= RB_TIME_SHIFT;
-	val |= bottom & RB_TIME_VAL_MASK;
-
-	return val;
-}
-
-static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
-{
-	unsigned long top, bottom, msb;
-	unsigned long c;
-
-	/*
-	 * If the read is interrupted by a write, then the cnt will
-	 * be different. Loop until both top and bottom have been read
-	 * without interruption.
-	 */
-	do {
-		c = local_read(&t->cnt);
-		top = local_read(&t->top);
-		bottom = local_read(&t->bottom);
-		msb = local_read(&t->msb);
-	} while (c != local_read(&t->cnt));
-
-	*cnt = rb_time_cnt(top);
-
-	/* If top, msb or bottom counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(msb) || *cnt != rb_time_cnt(bottom))
-		return false;
-
-	/* The shift to msb will lose its cnt bits */
-	*ret = rb_time_val(top, bottom) | ((u64)msb << RB_TIME_MSB_SHIFT);
-	return true;
-}
-
-static bool rb_time_read(rb_time_t *t, u64 *ret)
-{
-	unsigned long cnt;
-
-	return __rb_time_read(t, ret, &cnt);
-}
-
-static inline unsigned long rb_time_val_cnt(unsigned long val, unsigned long cnt)
-{
-	return (val & RB_TIME_VAL_MASK) | ((cnt & 3) << RB_TIME_SHIFT);
-}
-
-static inline void rb_time_split(u64 val, unsigned long *top, unsigned long *bottom,
-				 unsigned long *msb)
-{
-	*top = (unsigned long)((val >> RB_TIME_SHIFT) & RB_TIME_VAL_MASK);
-	*bottom = (unsigned long)(val & RB_TIME_VAL_MASK);
-	*msb = (unsigned long)(val >> RB_TIME_MSB_SHIFT);
-}
-
-static inline void rb_time_val_set(local_t *t, unsigned long val, unsigned long cnt)
-{
-	val = rb_time_val_cnt(val, cnt);
-	local_set(t, val);
-}
-
-static void rb_time_set(rb_time_t *t, u64 val)
-{
-	unsigned long cnt, top, bottom, msb;
-
-	rb_time_split(val, &top, &bottom, &msb);
-
-	/* Writes always succeed with a valid number even if it gets interrupted. */
-	do {
-		cnt = local_inc_return(&t->cnt);
-		rb_time_val_set(&t->top, top, cnt);
-		rb_time_val_set(&t->bottom, bottom, cnt);
-		rb_time_val_set(&t->msb, val >> RB_TIME_MSB_SHIFT, cnt);
-	} while (cnt != local_read(&t->cnt));
-}
-
-static inline bool
-rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
-{
-	return local_try_cmpxchg(l, &expect, set);
-}
-
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
-#else /* 64 bits */
-
-/* local64_t always succeeds */
-
-static inline bool rb_time_read(rb_time_t *t, u64 *ret)
+static inline void rb_time_read(rb_time_t *t, u64 *ret)
 {
 	*ret = local64_read(&t->time);
-	return true;
 }
 static void rb_time_set(rb_time_t *t, u64 val)
 {
 	local64_set(&t->time, val);
 }
 
-static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
+#if BITS_PER_LONG == 32
+#define RB_TIME_32
+#endif
+
+/* To test on 64 bit machines */
+//#define RB_TIME_32
+
+#ifdef RB_TIME_32
+/*
+ * Do not bother trying to update the 64-bit timestamp for 32-bit
+ * architectures. All this will do is to keep the next event from
+ * having to force an absolute timestamp. This doesn't happen often
+ * and a few extra absolute timestamps should not be a problem.
+ */
+static inline void rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set) { }
+#else
+static inline void rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
-	return local64_try_cmpxchg(&t->time, &expect, set);
+	(void)local64_try_cmpxchg(&t->time, &expect, set);
 }
 #endif
 
@@ -770,9 +595,7 @@ static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
 {
 	u64 old_time;
 
-	/* Should not happen */
-	if (!rb_time_read(t, &old_time))
-		return false;
+	rb_time_read(t, &old_time);
 	if (expect == old_time) {
 		/* Try to update it */
 		rb_time_cmpxchg(t, expect, set);
@@ -887,10 +710,7 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	WARN_ONCE(1, "nest (%d) greater than max", nest);
 
  fail:
-	/* Can only fail on 32 bit */
-	if (!rb_time_read(&cpu_buffer->write_stamp, &ts))
-		/* Screw it, just read the current time */
-		ts = rb_time_stamp(cpu_buffer->buffer);
+	rb_time_read(&cpu_buffer->write_stamp, &ts);
 
 	return ts;
 }
@@ -2887,7 +2707,7 @@ rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  (unsigned long long)info->ts,
 		  (unsigned long long)info->before,
 		  (unsigned long long)info->after,
-		  (unsigned long long)(rb_time_read(&cpu_buffer->write_stamp, &write_stamp) ? write_stamp : 0),
+		  (unsigned long long)({rb_time_read(&cpu_buffer->write_stamp, &write_stamp); write_stamp;}),
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
@@ -3564,16 +3384,14 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	struct ring_buffer_event *event;
 	struct buffer_page *tail_page;
 	unsigned long tail, write, w;
-	bool a_ok;
-	bool b_ok;
 
 	/* Don't let the compiler play games with cpu_buffer->tail_page */
 	tail_page = info->tail_page = READ_ONCE(cpu_buffer->tail_page);
 
  /*A*/	w = local_read(&tail_page->write) & RB_WRITE_MASK;
 	barrier();
-	b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-	a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+	rb_time_read(&cpu_buffer->before_stamp, &info->before);
+	rb_time_read(&cpu_buffer->write_stamp, &info->after);
 	barrier();
 	info->ts = rb_time_stamp(cpu_buffer->buffer);
 
@@ -3588,7 +3406,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		if (!w) {
 			/* Use the sub-buffer timestamp */
 			info->delta = 0;
-		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
+		} else if (unlikely(info->before != info->after)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
@@ -3635,9 +3453,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		/* Was interrupted before here, write_stamp must be valid */
-		RB_WARN_ON(cpu_buffer, !a_ok);
+		rb_time_read(&cpu_buffer->write_stamp, &info->after);
 		ts = rb_time_stamp(cpu_buffer->buffer);
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-- 
2.42.0



