Return-Path: <linux-kernel+bounces-31380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA306832D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7379AB25E40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612005577E;
	Fri, 19 Jan 2024 16:47:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9A43AB3;
	Fri, 19 Jan 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682848; cv=none; b=dmkNrbeSxdUF8ZCfpFkOWiJtZh8OUoH4tnnKM4DXYYC7GBsJlemjKOvvrkNmESJZBSZu42y5mN+N0YmdG5mVr9XvhsUe11Ic7EcpFbLr4rkovV8mejlmVpYv7r2arOz9SWpTP1zNEAz4XM5G87cXIgaRtlfIrM73FxxhReLCUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682848; c=relaxed/simple;
	bh=Swv7Msm9WUuaJKjApMDGUhjHVCGMxjgbl+goQYdxZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cj43LlfK3WLy9qU2exQLg7YxFhcYe/jpA+CJecDtP6HsY61JJE5emzqILDhkuNANwmzG1AzBGwfACk7KSCICoY9slPLbs/tcswkMEy9VU4toCYVgBQx4pTLKPAysjV5DyZw1T7H8C4MNb11akeVtElQikzCGY6WabSLOPzCrnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED465C433F1;
	Fri, 19 Jan 2024 16:47:25 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:48:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Add writer_loops to stat file
Message-ID: <20240119114847.71dc2d18@gandalf.local.home>
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

As the ring buffer never had a cmpxchg loop until the reserving logic
added one, add a statistic on how many times it happens. This can be used
to make sure there's not any issues because the writer is retrying.

 ~# cat /sys/kernel/tracing/per_cpu/cpu0/stats
entries: 51226
overrun: 3920945
commit overrun: 0
bytes: 1441376
oldest event ts:  2881.254827
now ts:  2912.011953
dropped events: 0
read events: 0
writer loops: 267

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
[ Depends on:
  https://lore.kernel.org/linux-trace-kernel/20240118181206.4977da2f@gandalf.local.home/
]

 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 22 +++++++++++++++++++++-
 kernel/trace/trace.c        |  3 +++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..f2bd59f24f7a 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -180,6 +180,7 @@ unsigned long ring_buffer_overrun_cpu(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_commit_overrun_cpu(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_dropped_events_cpu(struct trace_buffer *buffer, int cpu);
 unsigned long ring_buffer_read_events_cpu(struct trace_buffer *buffer, int cpu);
+unsigned long ring_buffer_writer_loops(struct trace_buffer *buffer, int cpu);
 
 u64 ring_buffer_time_stamp(struct trace_buffer *buffer);
 void ring_buffer_normalize_time_stamp(struct trace_buffer *buffer,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 74f8895785ca..a8a32c15c8b6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -474,6 +474,7 @@ struct ring_buffer_per_cpu {
 	local_t				pages_touched;
 	local_t				pages_lost;
 	local_t				pages_read;
+	local_t				writer_loops;
 	long				last_pages_touch;
 	size_t				shortest_full;
 	unsigned long			read;
@@ -3483,8 +3484,10 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
  /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
 
- /*C*/	if (!local_try_cmpxchg(&tail_page->write, &w, w + info->length))
+ /*C*/	if (!local_try_cmpxchg(&tail_page->write, &w, w + info->length)) {
+		local_inc(&cpu_buffer->writer_loops);
 		goto again;
+	}
 
 	/* Set write to the start of this event */
 	write = w & RB_WRITE_MASK;
@@ -4062,6 +4065,22 @@ u64 ring_buffer_oldest_event_ts(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_oldest_event_ts);
 
+/**
+ * ring_buffer_writer_loops - get the number of times writer failed cmpxchg
+ * @buffer: The ring buffer
+ * @cpu: The per CPU buffer to read from.
+ */
+unsigned long ring_buffer_writer_loops(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return 0;
+
+	cpu_buffer = buffer->buffers[cpu];
+	return local_read(&cpu_buffer->writer_loops);
+}
+
 /**
  * ring_buffer_bytes_cpu - get the number of bytes unconsumed in a cpu buffer
  * @buffer: The ring buffer
@@ -5145,6 +5164,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->pages_touched, 0);
 	local_set(&cpu_buffer->pages_lost, 0);
 	local_set(&cpu_buffer->pages_read, 0);
+	local_set(&cpu_buffer->writer_loops, 0);
 	cpu_buffer->last_pages_touch = 0;
 	cpu_buffer->shortest_full = 0;
 	cpu_buffer->read = 0;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 46dbe22121e9..3a5f33c344c4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8670,6 +8670,9 @@ tracing_stats_read(struct file *filp, char __user *ubuf,
 	cnt = ring_buffer_read_events_cpu(trace_buf->buffer, cpu);
 	trace_seq_printf(s, "read events: %ld\n", cnt);
 
+	cnt = ring_buffer_writer_loops(trace_buf->buffer, cpu);
+	trace_seq_printf(s, "writer loops: %ld\n", cnt);
+
 	count = simple_read_from_buffer(ubuf, count, ppos,
 					s->buffer, trace_seq_used(s));
 
-- 
2.43.0


