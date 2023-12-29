Return-Path: <linux-kernel+bounces-13237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C082018E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3303F1C215C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496D14AA0;
	Fri, 29 Dec 2023 21:12:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291014292;
	Fri, 29 Dec 2023 21:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D875FC433CC;
	Fri, 29 Dec 2023 21:12:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rJKAl-00000000Mcp-0HmC;
	Fri, 29 Dec 2023 16:13:39 -0500
Message-ID: <20231229211338.928136124@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 29 Dec 2023 16:13:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jiri Olsa <jolsa@kernel.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/3] tracing: Fix blocked reader of snapshot buffer
References: <20231229211314.081907608@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If an application blocks on the snapshot or snapshot_raw files, expecting
to be woken up when a snapshot occurs, it will not happen. Or it may
happen with an unexpected result.

That result is that the application will be reading the main buffer
instead of the snapshot buffer. That is because when the snapshot occurs,
the main and snapshot buffers are swapped. But the reader has a descriptor
still pointing to the buffer that it originally connected to.

This is fine for the main buffer readers, as they may be blocked waiting
for a watermark to be hit, and when a snapshot occurs, the data that the
main readers want is now on the snapshot buffer.

But for waiters of the snapshot buffer, they are waiting for an event to
occur that will trigger the snapshot and they can then consume it quickly
to save the snapshot before the next snapshot occurs. But to do this, they
need to read the new snapshot buffer, not the old one that is now
receiving new data.

Also, it does not make sense to have a watermark "buffer_percent" on the
snapshot buffer, as the snapshot buffer is static and does not receive new
data except all at once.

Link: https://lore.kernel.org/linux-trace-kernel/20231228095149.77f5b45d@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: debdd57f5145f ("tracing: Make a snapshot feature available from userspace")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c |  3 ++-
 kernel/trace/trace.c       | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 32c0dd2fd1c3..9286f88fcd32 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -949,7 +949,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 199df497db07..a0defe156b57 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1894,6 +1894,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	__update_max_tr(tr, tsk, cpu);
 
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 
 /**
@@ -1945,12 +1948,23 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	int ret;
+
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
-				full);
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	/*
+	 * Make sure this is still the snapshot buffer, as if a snapshot were
+	 * to happen, this would now be the main buffer.
+	 */
+	if (iter->snapshot)
+		iter->array_buffer = &iter->tr->max_buffer;
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
@@ -8517,7 +8531,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 
-- 
2.42.0



