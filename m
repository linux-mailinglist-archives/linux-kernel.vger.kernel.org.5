Return-Path: <linux-kernel+bounces-5381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A6818A15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328E91C244AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089692D603;
	Tue, 19 Dec 2023 14:32:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBE420DDC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC71C433CC;
	Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9Y-00000003MFP-0VSl;
	Tue, 19 Dec 2023 09:33:00 -0500
Message-ID: <20231219143259.902317852@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 04/10] trace_seq: Increase the buffer size to almost two pages
References: <20231219143233.204534014@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that trace_marker can hold more than 1KB string, and can write as much
as the ring buffer can hold, the trace_seq is not big enough to hold
writes:

 ~# a="1234567890"
 ~# cnt=4080
 ~# s=""
 ~# while [ $cnt -gt 10 ]; do
 ~#	s="${s}${a}"
 ~#	cnt=$((cnt-10))
 ~# done
 ~# echo $s > trace_marker
 ~# cat trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 2/2   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
            <...>-860     [002] .....   105.543465: tracing_mark_write[LINE TOO BIG]
            <...>-860     [002] .....   105.543496: tracing_mark_write: 789012345678901234567890

By increasing the trace_seq buffer to almost two pages, it can now print
out the first line.

This also subtracts the rest of the trace_seq fields from the buffer, so
that the entire trace_seq is now PAGE_SIZE aligned.

Link: https://lore.kernel.org/linux-trace-kernel/20231209175220.19867af4@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_seq.h | 9 ++++++---
 kernel/trace/trace.c      | 6 +++---
 kernel/trace/trace_seq.c  | 3 ---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 3691e0e76a1a..9ec229dfddaa 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -8,11 +8,14 @@
 
 /*
  * Trace sequences are used to allow a function to call several other functions
- * to create a string of data to use (up to a max of PAGE_SIZE).
+ * to create a string of data to use.
  */
 
+#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
+	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
+
 struct trace_seq {
-	char			buffer[PAGE_SIZE];
+	char			buffer[TRACE_SEQ_BUFFER_SIZE];
 	struct seq_buf		seq;
 	size_t			readpos;
 	int			full;
@@ -21,7 +24,7 @@ struct trace_seq {
 static inline void
 trace_seq_init(struct trace_seq *s)
 {
-	seq_buf_init(&s->seq, s->buffer, PAGE_SIZE);
+	seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
 	s->full = 0;
 	s->readpos = 0;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dba1328e454b..0be30cccabb4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3753,7 +3753,7 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
 
 	/* OK if part of the temp seq buffer */
 	if ((addr >= (unsigned long)iter->tmp_seq.buffer) &&
-	    (addr < (unsigned long)iter->tmp_seq.buffer + PAGE_SIZE))
+	    (addr < (unsigned long)iter->tmp_seq.buffer + TRACE_SEQ_BUFFER_SIZE))
 		return true;
 
 	/* Core rodata can not be freed */
@@ -6932,8 +6932,8 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		goto out;
 	}
 
-	if (cnt >= PAGE_SIZE)
-		cnt = PAGE_SIZE - 1;
+	if (cnt >= TRACE_SEQ_BUFFER_SIZE)
+		cnt = TRACE_SEQ_BUFFER_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
 	trace_iterator_reset(iter);
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 7be97229ddf8..c158d65a8a88 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -13,9 +13,6 @@
  * trace_seq_init() more than once to reset the trace_seq to start
  * from scratch.
  * 
- * The buffer size is currently PAGE_SIZE, although it may become dynamic
- * in the future.
- *
  * A write to the buffer will either succeed or fail. That is, unlike
  * sprintf() there will not be a partial write (well it may write into
  * the buffer but it wont update the pointers). This allows users to
-- 
2.42.0



