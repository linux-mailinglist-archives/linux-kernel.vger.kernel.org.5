Return-Path: <linux-kernel+bounces-1213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC31814BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CDEB213A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2236AEA;
	Fri, 15 Dec 2023 15:26:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DC37140;
	Fri, 15 Dec 2023 15:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE9AC433C8;
	Fri, 15 Dec 2023 15:26:35 +0000 (UTC)
Date: Fri, 15 Dec 2023 10:26:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Add disable-filter-buf option
Message-ID: <20231215102633.7a24cb77@rorschach.local.home>
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

Normally, when the filter is enabled, a temporary buffer is created to
copy the event data into it to perform the filtering logic. If the filter
passes and the event should be recorded, then the event is copied from the
temporary buffer into the ring buffer. If the event is to be discarded
then it is simply dropped. If another event comes in via an interrupt, it
will not use the temporary buffer as it is busy and will write directly
into the ring buffer.

The disable-filter-buf option will disable the temporary buffer and always
write into the ring buffer. This will avoid the copy when the event is to
be recorded, but also adds a bit more overhead on the discard, and if
another event were to interrupt the event that is to be discarded, then
the event will not be removed from the ring buffer but instead converted
to padding that will not be read by the reader. Padding will still take up
space on the ring buffer.

This option can be beneficial if most events are recorded and not
discarded, or simply for debugging the discard functionality of the ring
buffer.

Also fix some whitespace (that was fixed by editing this in vscode).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 23 +++++++++++++++++++++
 kernel/trace/trace.c           | 37 ++++++++++++++++++++--------------
 kernel/trace/trace.h           |  1 +
 3 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 23572f6697c0..7fe96da34962 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1239,6 +1239,29 @@ Here are the available options:
 	When the free_buffer is closed, tracing will
 	stop (tracing_on set to 0).
 
+  disable-filter-buf
+	Normally, when the filter is enabled, a temporary buffer is
+	created to copy the event data into it to perform the
+	filtering logic. If the filter passes and the event should
+	be recorded, then the event is copied from the temporary
+	buffer into the ring buffer. If the event is to be discarded
+	then it is simply dropped. If another event comes in via
+	an interrupt, it will not use the temporary buffer as it is
+	busy and will write directly into the ring buffer.
+
+	This option will disable the temporary buffer and always
+	write into the ring buffer. This will avoid the copy when
+	the event is to be recorded, but also adds a bit more
+	overhead on the discard, and if another event were to interrupt
+	the event that is to be discarded, then the event will not
+	be removed from the ring buffer but instead converted to
+	padding that will not be read by the reader. Padding will
+	still take up space on the ring buffer.
+
+	This option can be beneficial if most events are recorded and
+	not discarded, or simply for debugging the discard functionality
+	of the ring buffer.
+
   irq-info
 	Shows the interrupt, preempt count, need resched data.
 	When disabled, the trace looks like::
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 199df497db07..41b674b1b809 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5398,6 +5398,8 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 	return 0;
 }
 
+static int __tracing_set_filter_buffering(struct trace_array *tr, bool set);
+
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	int *map;
@@ -5451,6 +5453,9 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	if (mask == TRACE_ITER_FUNC_FORK)
 		ftrace_pid_follow_fork(tr, enabled);
 
+	if (mask == TRACE_ITER_DISABLE_FILTER_BUF)
+		__tracing_set_filter_buffering(tr, enabled);
+
 	if (mask == TRACE_ITER_OVERWRITE) {
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -6464,7 +6469,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -7534,27 +7539,29 @@ u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_eve
 	return ring_buffer_event_time_stamp(buffer, rbe);
 }
 
-/*
- * Set or disable using the per CPU trace_buffer_event when possible.
- */
-int tracing_set_filter_buffering(struct trace_array *tr, bool set)
+static int __tracing_set_filter_buffering(struct trace_array *tr, bool set)
 {
-	int ret = 0;
-
-	mutex_lock(&trace_types_lock);
-
 	if (set && tr->no_filter_buffering_ref++)
-		goto out;
+		return 0;
 
 	if (!set) {
-		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref)) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref))
+			return -EINVAL;
 
 		--tr->no_filter_buffering_ref;
 	}
- out:
+	return 0;
+}
+
+/*
+ * Set or disable using the per CPU trace_buffer_event when possible.
+ */
+int tracing_set_filter_buffering(struct trace_array *tr, bool set)
+{
+	int ret;
+
+	mutex_lock(&trace_types_lock);
+	ret = __tracing_set_filter_buffering(tr, set);
 	mutex_unlock(&trace_types_lock);
 
 	return ret;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0489e72c8169..a9529943cee2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1250,6 +1250,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(EVENT_FORK,		"event-fork"),		\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(DISABLE_FILTER_BUF,	"disable-filter-buffer"),\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
-- 
2.42.0


