Return-Path: <linux-kernel+bounces-5379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15324818A12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C62A1C21B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D612225D9;
	Tue, 19 Dec 2023 14:32:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45A20DC2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BE1C433BA;
	Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9X-00000003MEv-3Tx5;
	Tue, 19 Dec 2023 09:32:59 -0500
Message-ID: <20231219143259.611969166@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 03/10] tracing: Allow for max buffer data size trace_marker writes
References: <20231219143233.204534014@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow a trace write to be as big as the ring buffer tracing data will
allow. Currently, it only allows writes of 1KB in size, but there's no
reason that it cannot allow what the ring buffer can hold.

Link: https://lore.kernel.org/linux-trace-kernel/20231212131901.5f501e72@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 15 +++++++++++++++
 kernel/trace/trace.c        | 31 ++++++++++++++++++++++++-------
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201..b1b03b2c0f08 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -141,6 +141,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
 bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
 
 unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu);
+unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
 
 void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
 void ring_buffer_reset_online_cpus(struct trace_buffer *buffer);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bfe2697a92ee..16b640d824f9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5190,6 +5190,21 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+/**
+ * ring_buffer_max_event_size - return the max data size of an event
+ * @buffer: The ring buffer.
+ *
+ * Returns the maximum size an event can be.
+ */
+unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer)
+{
+	/* If abs timestamp is requested, events have a timestamp too */
+	if (ring_buffer_time_stamp_abs(buffer))
+		return BUF_MAX_DATA_SIZE - RB_LEN_TIME_EXTEND;
+	return BUF_MAX_DATA_SIZE;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_max_event_size);
+
 static void rb_clear_buffer_page(struct buffer_page *page)
 {
 	local_set(&page->write, 0);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 59e39b652afb..dba1328e454b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7278,8 +7278,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	enum event_trigger_type tt = ETT_NONE;
 	struct trace_buffer *buffer;
 	struct print_entry *entry;
+	int meta_size;
 	ssize_t written;
-	int size;
+	size_t size;
 	int len;
 
 /* Used in tracing_mark_raw_write() as well */
@@ -7292,12 +7293,12 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
 		return -EINVAL;
 
-	if (cnt > TRACE_BUF_SIZE)
-		cnt = TRACE_BUF_SIZE;
-
-	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
+	if ((ssize_t)cnt < 0)
+		return -EINVAL;
 
-	size = sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
+	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
+ again:
+	size = cnt + meta_size;
 
 	/* If less than "<faulted>", then make sure we can still add that */
 	if (cnt < FAULTED_SIZE)
@@ -7306,9 +7307,25 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
-	if (unlikely(!event))
+	if (unlikely(!event)) {
+		/*
+		 * If the size was greater than what was allowed, then
+		 * make it smaller and try again.
+		 */
+		if (size > ring_buffer_max_event_size(buffer)) {
+			/* cnt < FAULTED size should never be bigger than max */
+			if (WARN_ON_ONCE(cnt < FAULTED_SIZE))
+				return -EBADF;
+			cnt = ring_buffer_max_event_size(buffer) - meta_size;
+			/* The above should only happen once */
+			if (WARN_ON_ONCE(cnt + meta_size == size))
+				return -EBADF;
+			goto again;
+		}
+
 		/* Ring buffer disabled, return as if not open for write */
 		return -EBADF;
+	}
 
 	entry = ring_buffer_event_data(event);
 	entry->ip = _THIS_IP_;
-- 
2.42.0



