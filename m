Return-Path: <linux-kernel+bounces-405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9181409F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21D91C221DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B494646B1;
	Fri, 15 Dec 2023 03:28:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD3CA70;
	Fri, 15 Dec 2023 03:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF97AC433C8;
	Fri, 15 Dec 2023 03:28:33 +0000 (UTC)
Date: Thu, 14 Dec 2023 22:29:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Joel Fernandes <joel@joelfernandes.org>, Vincent Donnefort 
 <vdonnefort@google.com>
Subject: [PATCH v2] ring-buffer: Do not try to put back write_stamp
Message-ID: <20231214222921.193037a7@gandalf.local.home>
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

If an update to an event is interrupted by another event between the time
the initial event allocated its buffer and where it wrote to the
write_stamp, the code try to reset the write stamp back to the what it had
just overwritten. It knows that it was overwritten via checking the
before_stamp, and if it didn't match what it wrote to the before_stamp
before it allocated its space, it knows it was overwritten.

To put back the write_stamp, it uses the before_stamp it read. The problem
here is that by writing the before_stamp to the write_stamp it makes the
two equal again, which means that the write_stamp can be considered valid
as the last timestamp written to the ring buffer. But this is not
necessarily true. The event that interrupted the event could have been
interrupted in a way that it was interrupted as well, and can end up
leaving with an invalid write_stamp. But if this happens and returns to
this context that uses the before_stamp to update the write_stamp again,
it can possibly incorrectly make it valid, causing later events to have in
correct time stamps.

As it is OK to leave this function with an invalid write_stamp (one that
doesn't match the before_stamp), there's no reason to try to make it valid
again in this case. If this race happens, then just leave with the invalid
write_stamp and the next event to come along will just add a absolute
timestamp and validate everything again.

Cc: stable@vger.kernel.org
Fixes: a389d86f7fd09 ("ring-buffer: Have nested events still record running time stamp")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/all/20231214221803.1a923e10@gandalf.local.home/

- I forgot to remove the commit that deletes the rb_time_* logic.
  Had to rebase the patch.

 kernel/trace/ring_buffer.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d9caee7f542..2668dde23343 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3612,14 +3612,14 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	if (likely(tail == w)) {
-		u64 save_before;
-		bool s_ok;
-
 		/* Nothing interrupted us between A and C */
  /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
-		barrier();
- /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
-		RB_WARN_ON(cpu_buffer, !s_ok);
+		/*
+		 * If something came in between C and D, the write stamp
+		 * may now not be in sync. But that's fine as the before_stamp
+		 * will be different and then next event will just be forced
+		 * to use an absolute timestamp.
+		 */
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
@@ -3627,24 +3627,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		else
 			/* Just use full timestamp for interrupting event */
 			info->delta = info->ts;
-		barrier();
 		check_buffer(cpu_buffer, info, tail);
-		if (unlikely(info->ts != save_before)) {
-			/* SLOW PATH - Interrupted between C and E */
-
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-			RB_WARN_ON(cpu_buffer, !a_ok);
-
-			/* Write stamp must only go forward */
-			if (save_before > info->after) {
-				/*
-				 * We do not care about the result, only that
-				 * it gets updated atomically.
-				 */
-				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-						      info->after, save_before);
-			}
-		}
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
-- 
2.42.0


