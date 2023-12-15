Return-Path: <linux-kernel+bounces-1523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD88814FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555F6B22DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584AE3013A;
	Fri, 15 Dec 2023 18:25:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46E41846;
	Fri, 15 Dec 2023 18:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0040AC433C7;
	Fri, 15 Dec 2023 18:25:03 +0000 (UTC)
Date: Fri, 15 Dec 2023 13:25:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Add filter-buffer option
Message-ID: <20231215132502.1ae9c1a6@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

=46rom 62a1de0f0f9d942934565e625a7880fd85ae216a Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Fri, 15 Dec 2023 10:26:33 -0500
Subject: [PATCH] tracing: Add filter-buffer option

Normally, when the filter is enabled, a temporary buffer is created to
copy the event data into it to perform the filtering logic. If the filter
passes and the event should be recorded, then the event is copied from the
temporary buffer into the ring buffer. If the event is to be discarded
then it is simply dropped. If another event comes in via an interrupt, it
will not use the temporary buffer as it is busy and will write directly
into the ring buffer.

The filter-buffer option will allow the user to disable this feature. By
default, it is enabled. When disabled, it disables the temporary buffer
and always writes into the ring buffer. This will avoid the copy when the
event is to be recorded, but also adds a bit more overhead on the discard,
and if another event were to interrupt the event that is to be discarded,
then the event will not be removed from the ring buffer but instead
converted to padding that will not be read by the reader. Padding will
still take up space on the ring buffer.

This option can be beneficial if most events are recorded and not
discarded, or simply for debugging the discard functionality of the ring
buffer.

Also fix some whitespace (that was fixed by editing this in vscode).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231215102633=
.7a24cb77@rorschach.local.home

- Renamed "disable-filter-buffer" to "filter-buffer" and made it
  default enabled, where the user needs to disable it. (Mathieu Desnoyers)


 Documentation/trace/ftrace.rst | 23 ++++++++++++++++++++
 kernel/trace/trace.c           | 39 ++++++++++++++++++++--------------
 kernel/trace/trace.h           |  1 +
 3 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 23572f6697c0..7ec26eb814e9 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1239,6 +1239,29 @@ Here are the available options:
 	When the free_buffer is closed, tracing will
 	stop (tracing_on set to 0).
=20
+  filter-buffer
+	Normally, when the filter is enabled, a temporary buffer is
+	created to copy the event data into it to perform the
+	filtering logic. If the filter passes and the event should
+	be recorded, then the event is copied from the temporary
+	buffer into the ring buffer. If the event is to be discarded
+	then it is simply dropped. If another event comes in via
+	an interrupt, it will not use the temporary buffer as it is
+	busy and will write directly into the ring buffer.
+
+	This option, when cleared, will disable the temporary buffer and always
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
index 55dabee4c78b..e18c83104e24 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -466,7 +466,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
 	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
 	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
-	 TRACE_ITER_HASH_PTR)
+	 TRACE_ITER_HASH_PTR | TRACE_ITER_FILTER_BUF)
=20
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
@@ -5398,6 +5398,8 @@ int trace_keep_overwrite(struct tracer *tracer, u32 m=
ask, int set)
 	return 0;
 }
=20
+static int __tracing_set_filter_buffering(struct trace_array *tr, bool set=
);
+
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	int *map;
@@ -5451,6 +5453,9 @@ int set_tracer_flag(struct trace_array *tr, unsigned =
int mask, int enabled)
 	if (mask =3D=3D TRACE_ITER_FUNC_FORK)
 		ftrace_pid_follow_fork(tr, enabled);
=20
+	if (mask =3D=3D TRACE_ITER_FILTER_BUF)
+		__tracing_set_filter_buffering(tr, !enabled);
+
 	if (mask =3D=3D TRACE_ITER_OVERWRITE) {
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -6464,7 +6469,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace =3D=3D &nop_trace)
 		return;
-=09
+
 	tr->current_trace->enabled--;
=20
 	if (tr->current_trace->reset)
@@ -7552,27 +7557,29 @@ u64 tracing_event_time_stamp(struct trace_buffer *b=
uffer, struct ring_buffer_eve
 	return ring_buffer_event_time_stamp(buffer, rbe);
 }
=20
-/*
- * Set or disable using the per CPU trace_buffer_event when possible.
- */
-int tracing_set_filter_buffering(struct trace_array *tr, bool set)
+static int __tracing_set_filter_buffering(struct trace_array *tr, bool set)
 {
-	int ret =3D 0;
-
-	mutex_lock(&trace_types_lock);
-
 	if (set && tr->no_filter_buffering_ref++)
-		goto out;
+		return 0;
=20
 	if (!set) {
-		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref)) {
-			ret =3D -EINVAL;
-			goto out;
-		}
+		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref))
+			return -EINVAL;
=20
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
+	ret =3D __tracing_set_filter_buffering(tr, set);
 	mutex_unlock(&trace_types_lock);
=20
 	return ret;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 79180aed13ee..f82dce7ea3ff 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1251,6 +1251,7 @@ extern int trace_get_user(struct trace_parser *parser=
, const char __user *ubuf,
 		C(EVENT_FORK,		"event-fork"),		\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(FILTER_BUF,		"filter-buffer"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
--=20
2.42.0


