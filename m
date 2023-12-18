Return-Path: <linux-kernel+bounces-3934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68292817541
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7571C239F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2AF3D552;
	Mon, 18 Dec 2023 15:32:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883B1D137;
	Mon, 18 Dec 2023 15:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CBCC433C7;
	Mon, 18 Dec 2023 15:32:02 +0000 (UTC)
Date: Mon, 18 Dec 2023 10:32:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] tracing: Add filter-direct option
Message-ID: <20231218103259.75f1ac6a@gandalf.local.home>
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

Normally, when the filter is enabled, a temporary buffer is created to
copy the event data into it to perform the filtering logic. If the filter
passes and the event should be recorded, then the event is copied from the
temporary buffer into the ring buffer. If the event is to be discarded
then it is simply dropped. If another event comes in via an interrupt, it
will not use the temporary buffer as it is busy and will write directly
into the ring buffer.

The filter-direct option will allow the user to disable this feature. By
default, it is disabled. When enabled, it disables the temporary buffer
and always writes into the ring buffer. This will avoid the copy when the
event is to be recorded, but also adds a bit more overhead on the discard,
and if another event were to interrupt the event that is to be discarded,
then the event will not be removed from the ring buffer but instead
converted to padding that will not be read by the reader. Padding will
still take up space on the ring buffer.

This option is mainly used for kselftests to stress test the ring buffer
discard logic.

Also fix some whitespace (that was fixed by editing this in vscode).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231215132502.1ae9c1a6@rorschach.local.home

- Changed the option name to filter-direct

- Added the config option CONFIG_TRACE_FILTER_DIRECT

- Moved the documentation from Documentation and into tho Kconfig
  This is because the option is focused on being used for kselftest
  purposes

 kernel/trace/Kconfig | 28 ++++++++++++++++++++++++++++
 kernel/trace/trace.c | 39 ++++++++++++++++++++++++---------------
 kernel/trace/trace.h |  8 ++++++++
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..5362206e6e82 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -949,6 +949,34 @@ config TRACE_EVAL_MAP_FILE
 
 	If unsure, say N.
 
+config TRACE_FILTER_DIRECT
+	bool "Add filter-direct option to test direct ring buffer filtering"
+	help
+	  Normally, when the filter is enabled, a temporary buffer is
+	  created to copy the event data into it to perform the
+	  filtering logic. If the filter passes and the event should
+	  be recorded, then the event is copied from the temporary
+	  buffer into the ring buffer. If the event is to be discarded
+	  then it is simply dropped. If another event comes in via
+	  an interrupt, it will not use the temporary buffer as it is
+	  busy and will write directly into the ring buffer.
+
+	  Enabling this config will create a trace option "filter-direct",
+	  that, when enabled, will disable the temporary buffer and always
+	  write directly into the ring buffer. This will avoid the copy when
+	  the event is to be recorded, but also adds a bit more
+	  overhead on the discard, and if another event were to interrupt
+	  the event that is to be discarded, then the event will not
+	  be removed from the ring buffer but instead converted to
+	  padding that will not be read by the reader. Padding will
+	  still take up space on the ring buffer.
+
+	  This option is to allow kselftest to test the ring buffer filter
+	  direct functionality that sometimes gets performed. This option
+	  degrades the performance of trace filtering.
+
+	  Unless you are running kselftests, say N
+
 config FTRACE_RECORD_RECURSION
 	bool "Record functions that recurse in function tracing"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 55dabee4c78b..36df0364cb9e 100644
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
@@ -5451,6 +5453,11 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	if (mask == TRACE_ITER_FUNC_FORK)
 		ftrace_pid_follow_fork(tr, enabled);
 
+#ifdef CONFIG_TRACE_FILTER_DIRECT
+	if (mask == TRACE_ITER_FILTER_DIRECT)
+		__tracing_set_filter_buffering(tr, enabled);
+#endif
+
 	if (mask == TRACE_ITER_OVERWRITE) {
 		ring_buffer_change_overwrite(tr->array_buffer.buffer, enabled);
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -6464,7 +6471,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -7552,27 +7559,29 @@ u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_eve
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
index 79180aed13ee..53ab9ef847e9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1218,6 +1218,13 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define STACK_FLAGS
 #endif
 
+#ifdef CONFIG_TRACE_FILTER_DIRECT
+# define DIRECT_FILTER				\
+		C(FILTER_DIRECT,	"filter-direct"),
+#else
+# define DIRECT_FILTER
+#endif
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1254,6 +1261,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
+		DIRECT_FILTER					\
 		BRANCH_FLAGS
 
 /*
-- 
2.42.0


