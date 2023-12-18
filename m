Return-Path: <linux-kernel+bounces-4301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E7817B25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9702845A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E472055;
	Mon, 18 Dec 2023 19:42:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B77144F;
	Mon, 18 Dec 2023 19:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B3C433C7;
	Mon, 18 Dec 2023 19:42:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFJWa-000000038lD-0NVh;
	Mon, 18 Dec 2023 14:43:36 -0500
Message-ID: <20231218194335.876165358@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 18 Dec 2023 14:42:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 1/2] ring-buffer: Replace rb_time_cmpxchg() with rb_time_cmp_and_update()
References: <20231218194247.018725743@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's only one place that performs a 64-bit cmpxchg for the timestamp
processing. The cmpxchg is only to set the write_stamp equal to the
before_stamp, and if it doesn't get set, then the next event will simply
be forced to add an absolute timestamp.

Given that 64-bit cmpxchg is expensive on 32-bit, and the current
workaround uses 3 consecutive 32-bit cmpxchg doesn't make it any faster.
It's best to just not do the cmpxchg as a simple compare works for the
accuracy of the timestamp. The only thing that will happen without the
cmpxchg is the prepended absolute timestamp on the next event which is not
that big of a deal as the path where this happens is seldom hit because it
requires an interrupt to happen between a few lines of code that also
writes an event into the same buffer.

With this change, the 32-bit rb_time_t workaround can be removed.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/all/20231215165628.096822746@goodmis.org

- Restructure to have the rb_tiem_cmp_and_update() to test for
  equal outside the cmpxchg, and allow both 64 and 32 bit to
  possibly fail the update but still return true for the match.

 kernel/trace/ring_buffer.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1a26b3a1901f..455a2113eb02 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -762,6 +762,26 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 }
 #endif
 
+/*
+ * Returns true if t == expect, and if possible will update with set,
+ * but t is not guaranteed to be updated even if this returns true
+ */
+static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
+{
+	u64 old_time;
+
+	/* Should not happen */
+	if (!rb_time_read(t, &old_time))
+		return false;
+	if (expect == old_time) {
+		/* Try to update it */
+		rb_time_cmpxchg(t, expect, set);
+		return true;
+	}
+	/* No need to do the cmpxchg() */
+	return false;
+}
+
 /*
  * Enable this to make sure that the event passed to
  * ring_buffer_event_time_stamp() is not committed and also
@@ -3622,9 +3642,17 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
 		    info->after < ts &&
-		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				    info->after, ts)) {
-			/* Nothing came after this event between C and E */
+		    rb_time_cmp_and_update(&cpu_buffer->write_stamp,
+					   info->after, ts)) {
+			/*
+			 * Nothing came after this event between C and E it is
+			 * safe to use info->after for the delta.
+			 * The above rb_time_cmp_and_update() may or may not
+			 * have updated the write_stamp. If it did not then
+			 * the next event will simply add an absolute timestamp
+			 * as the write_stamp will be different than the
+			 * before_stamp.
+			 */
 			info->delta = ts - info->after;
 		} else {
 			/*
-- 
2.42.0



