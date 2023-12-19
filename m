Return-Path: <linux-kernel+bounces-5198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C058187E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A851C2422E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331A18AEA;
	Tue, 19 Dec 2023 12:46:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4910199AD;
	Tue, 19 Dec 2023 12:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B191AC433C7;
	Tue, 19 Dec 2023 12:46:34 +0000 (UTC)
Date: Tue, 19 Dec 2023 07:47:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Check if absolute timestamp goes backwards
Message-ID: <20231219074732.18b092d4@gandalf.local.home>
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

The check_buffer() which checks the timestamps of the ring buffer
sub-buffer page, when enabled, only checks if the adding of deltas of the
events from the last absolute timestamp or the timestamp of the sub-buffer
page adds up to the current event.

What it does not check is if the absolute timestamp causes the time of the
events to go backwards, as that can cause issues elsewhere.

Test for the timestamp going backwards too.

This also fixes a slight issue where if the warning triggers at boot up
(because of the resetting of the tsc), it will disable all further checks,
even those that are after boot Have it continue checking if the warning
was ignored during boot up.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 46 +++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c0cc45482e1e..f7dc74e45ebf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3309,6 +3309,23 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 static DEFINE_PER_CPU(atomic_t, checking);
 static atomic_t ts_dump;
 
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
+
 /*
  * Check if the current event time stamp matches the deltas on
  * the buffer page.
@@ -3362,7 +3379,12 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 
 		case RINGBUF_TYPE_TIME_STAMP:
 			delta = rb_event_time_stamp(event);
-			ts = rb_fix_abs_ts(delta, ts);
+			delta = rb_fix_abs_ts(delta, ts);
+			if (delta < ts) {
+				buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
+						   cpu_buffer->cpu, ts, delta);
+			}
+			ts = delta;
 			break;
 
 		case RINGBUF_TYPE_PADDING:
@@ -3379,23 +3401,11 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 	if ((full && ts > info->ts) ||
 	    (!full && ts + info->delta != info->ts)) {
-		/* If another report is happening, ignore this one */
-		if (atomic_inc_return(&ts_dump) != 1) {
-			atomic_dec(&ts_dump);
-			goto out;
-		}
-		atomic_inc(&cpu_buffer->record_disabled);
-		/* There's some cases in boot up that this can happen */
-		WARN_ON_ONCE(system_state != SYSTEM_BOOTING);
-		pr_warn("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\n",
-			cpu_buffer->cpu,
-			ts + info->delta, info->ts, info->delta,
-			info->before, info->after,
-			full ? " (full)" : "", show_interrupt_level());
-		dump_buffer_page(bpage, info, tail);
-		atomic_dec(&ts_dump);
-		/* Do not re-enable checking */
-		return;
+		buffer_warn_return("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\n",
+				   cpu_buffer->cpu,
+				   ts + info->delta, info->ts, info->delta,
+				   info->before, info->after,
+				   full ? " (full)" : "", show_interrupt_level());
 	}
 out:
 	atomic_dec(this_cpu_ptr(&checking));
-- 
2.42.0


