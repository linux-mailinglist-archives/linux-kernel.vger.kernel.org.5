Return-Path: <linux-kernel+bounces-100242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825938793EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7581F23C88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891E7A71C;
	Tue, 12 Mar 2024 12:14:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B77A12B;
	Tue, 12 Mar 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245697; cv=none; b=K1WRVamccaROWkMMlHmD7su+lN6QrUbJo9GpmF1cfmR9QmJOwG7bLXX2q0MP3cXn9lK4I4z3FiVp6VytmZxk8muAOQS1sjZNkvt27e7jd7C7Dq9sZYe5Lju6adAeo4zZlPIrP4nClsdyXJ5IxIm2I3yTAqMKrNUuHuUBS6oO9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245697; c=relaxed/simple;
	bh=8LOUjWQ8T9GS+GwmSDKVoVsWbFNPD6fGlsNznIECHSM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lNud9F1LCPpFHR1CMBf3+7UtiQyKuRxMMPL+Ng2imez86AKdeD4Agp2kYeUw+PVeW98fV/NeNCBbUFgXOCEFCzp2UH4XgCNEDhJcgMExEScsV7TDt8NppqfL0sM1liJHpfPLSQDd5zcID1XGHWBBN/GlTudZv6Z/zfeoT/i+vBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19361C43394;
	Tue, 12 Mar 2024 12:14:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rk143-00000001uZA-2GfF;
	Tue, 12 Mar 2024 08:17:03 -0400
Message-ID: <20240312121703.399598519@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 12 Mar 2024 08:15:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 joel@joelfernandes.org,
 linke li <lilinke99@qq.com>,
 Rabin Vincent <rabin@rab.in>,
 stable@vger.kernel.org
Subject: [PATCH v4 1/2] ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
References: <20240312121506.972039112@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Convert ring_buffer_wait() over to wait_event_interruptible(). The default
condition is to execute the wait loop inside __wait_event() just once.

This does not change the ring_buffer_wait() prototype yet, but
restructures the code so that it can take a "cond" and "data" parameter
and will call wait_event_interruptible() with a helper function as the
condition.

The helper function (rb_wait_cond) takes the cond function and data
parameters. It will first check if the buffer hit the watermark defined by
the "full" parameter and then call the passed in condition parameter. If
either are true, it returns true.

If rb_wait_cond() does not return true, it will set the appropriate
"waiters_pending" flag and returns false.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |   1 +
 kernel/trace/ring_buffer.c  | 116 +++++++++++++++++++++---------------
 2 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..338a33db1577 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,6 +98,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
+typedef bool (*ring_buffer_cond_fn)(void *data);
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6ef763f57c66..c198ba466853 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -842,43 +842,15 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
 	return ret;
 }
 
-/**
- * ring_buffer_wait - wait for input to the ring buffer
- * @buffer: buffer to wait on
- * @cpu: the cpu buffer to wait on
- * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
- *
- * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
- * as data is added to any of the @buffer's cpu buffers. Otherwise
- * it will wait for data to be added to a specific cpu buffer.
- */
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+static inline bool
+rb_wait_cond(struct rb_irq_work *rbwork, struct trace_buffer *buffer,
+	     int cpu, int full, ring_buffer_cond_fn cond, void *data)
 {
-	struct ring_buffer_per_cpu *cpu_buffer;
-	DEFINE_WAIT(wait);
-	struct rb_irq_work *work;
-	int ret = 0;
-
-	/*
-	 * Depending on what the caller is waiting for, either any
-	 * data in any cpu buffer, or a specific buffer, put the
-	 * caller on the appropriate wait queue.
-	 */
-	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
-		/* Full only makes sense on per cpu reads */
-		full = 0;
-	} else {
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -ENODEV;
-		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
-	}
+	if (rb_watermark_hit(buffer, cpu, full))
+		return true;
 
-	if (full)
-		prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-	else
-		prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
+	if (cond(data))
+		return true;
 
 	/*
 	 * The events can happen in critical sections where
@@ -901,27 +873,75 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	 * a task has been queued. It's OK for spurious wake ups.
 	 */
 	if (full)
-		work->full_waiters_pending = true;
+		rbwork->full_waiters_pending = true;
 	else
-		work->waiters_pending = true;
+		rbwork->waiters_pending = true;
 
-	if (rb_watermark_hit(buffer, cpu, full))
-		goto out;
+	return false;
+}
 
-	if (signal_pending(current)) {
-		ret = -EINTR;
-		goto out;
+/*
+ * The default wait condition for ring_buffer_wait() is to just to exit the
+ * wait loop the first time it is woken up.
+ */
+static bool rb_wait_once(void *data)
+{
+	long *once = data;
+
+	/* wait_event() actually calls this twice before scheduling*/
+	if (*once > 1)
+		return true;
+
+	(*once)++;
+	return false;
+}
+
+/**
+ * ring_buffer_wait - wait for input to the ring buffer
+ * @buffer: buffer to wait on
+ * @cpu: the cpu buffer to wait on
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ *
+ * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
+ * as data is added to any of the @buffer's cpu buffers. Otherwise
+ * it will wait for data to be added to a specific cpu buffer.
+ */
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct wait_queue_head *waitq;
+	ring_buffer_cond_fn cond;
+	struct rb_irq_work *rbwork;
+	void *data;
+	long once = 0;
+	int ret = 0;
+
+	cond = rb_wait_once;
+	data = &once;
+
+	/*
+	 * Depending on what the caller is waiting for, either any
+	 * data in any cpu buffer, or a specific buffer, put the
+	 * caller on the appropriate wait queue.
+	 */
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		rbwork = &buffer->irq_work;
+		/* Full only makes sense on per cpu reads */
+		full = 0;
+	} else {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			return -ENODEV;
+		cpu_buffer = buffer->buffers[cpu];
+		rbwork = &cpu_buffer->irq_work;
 	}
 
-	schedule();
- out:
 	if (full)
-		finish_wait(&work->full_waiters, &wait);
+		waitq = &rbwork->full_waiters;
 	else
-		finish_wait(&work->waiters, &wait);
+		waitq = &rbwork->waiters;
 
-	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
-		ret = -EINTR;
+	ret = wait_event_interruptible((*waitq),
+				rb_wait_cond(rbwork, buffer, cpu, full, cond, data));
 
 	return ret;
 }
-- 
2.43.0



