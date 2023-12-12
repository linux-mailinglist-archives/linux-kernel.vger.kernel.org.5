Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201DE80EE37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbjLLOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376341AbjLLOAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:00:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF9B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:00:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CF0C433C8;
        Tue, 12 Dec 2023 14:00:15 +0000 (UTC)
Date:   Tue, 12 Dec 2023 09:00:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Allow for max buffer data size trace_marker
 writes
Message-ID: <20231212090057.41b28efe@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow a trace write to be as big as the ring buffer tracing data will
allow. Currently, it only allows writes of 1KB in size, but there's no
reason that it cannot allow what the ring buffer can hold.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231209175003.63db40ab@gandalf.local.home

- Now that there's a new fix for the max event size, there's no more
  BUF_MAX_EVENT_SIZE macro. Now the BUF_MAX_DATA_SIZE can be used again.

- Check if the buffer itself is requesting forced timestamps, and if so,
  decrement from the max size, the timestamp size.

- This no longer depends on the previous fix change, as it's now using
  existing macros.

 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 15 +++++++++++++++
 kernel/trace/trace.c        | 28 +++++++++++++++++++++-------
 3 files changed, 37 insertions(+), 7 deletions(-)

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
index a3eaa052f4de..882aab2bede3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5250,6 +5250,21 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
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
index ef86379555e4..bd6d28dad05d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7272,6 +7272,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	enum event_trigger_type tt = ETT_NONE;
 	struct trace_buffer *buffer;
 	struct print_entry *entry;
+	int meta_size;
 	ssize_t written;
 	int size;
 	int len;
@@ -7286,12 +7287,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
 		return -EINVAL;
 
-	if (cnt > TRACE_BUF_SIZE)
-		cnt = TRACE_BUF_SIZE;
-
-	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
-
-	size = sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
+	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
+ again:
+	size = cnt + meta_size;
 
 	/* If less than "<faulted>", then make sure we can still add that */
 	if (cnt < FAULTED_SIZE)
@@ -7300,9 +7298,25 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
-	if (unlikely(!event))
+	if (unlikely(!event)) {
+		/*
+		 * If the size was greated than what was allowed, then
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

