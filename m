Return-Path: <linux-kernel+bounces-97546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EEB876BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B924F1F21DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4A5FDAF;
	Fri,  8 Mar 2024 20:22:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C285E06E;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929355; cv=none; b=NVHcvD+b4vYtTG3gGk6Dc+ESQ6OAUqSCNVTVFLu8FAYcu0ts/kNttxTql8iwmo+O7k62D7w9lTiRPnD0MUjslRVeRtHZCZr9VX+elJLq5gfmGkAMa0AAPKyUb9CGu7D4giw4Y+sKfNsrFQBL4vW/1OpwAzXbbxBcW4d6QEYQxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929355; c=relaxed/simple;
	bh=nJ/wrHpgBX5oVgJnVXfCRoTe+d97YXazgxDiH/YeWNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nVmFBGWdy5brD+hqAdeKnyrU4idD98ThVWHiRjynuj967YI+kF2hvWEP5z3xr1R5/fZG+Ue/w0GrG4rcDbvFQ+pO6sjwf1P6LEn8f6/WSgD4J1MxfMqHAia99HVHI9NTqsPPUJNvj/+Y9V3C6Wbc5qxCiBwBLma/HAr0HAQf9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B564DC4166A;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1riglc-00000000yt5-33ty;
	Fri, 08 Mar 2024 15:24:32 -0500
Message-ID: <20240308202432.591339104@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 08 Mar 2024 15:24:08 -0500
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
Subject: [PATCH v2 6/6] tracing/ring-buffer: Fix wait_on_pipe() race
References: <20240308202402.234176464@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When the trace_pipe_raw file is closed, there should be no new readers on
the file descriptor. This is mostly handled with the waking and wait_index
fields of the iterator. But there's still a slight race.

     CPU 0				CPU 1
     -----				-----
 wait_woken_prepare()
    if (waking)
       woken = true;
    index = wait_index;
				   wait_woken_set()
				      waking = true
				      wait_index++;
				   ring_buffer_wake_waiters();
 wait_on_pipe()
    ring_buffer_wait();

The ring_buffer_wait() will miss the wakeup from CPU 1. The problem is
that the ring_buffer_wait() needs the logic of:

	prepare_to_wait();
	if (!condition)
		schedule();

Where the missing condition check is the iter->waking.

Either that condition check needs to be passed to ring_buffer_wait() or
the function needs to be broken up into three parts. This chooses to do
the break up.

Break ring_buffer_wait() into:

	ring_buffer_prepare_to_wait();
	ring_buffer_wait();
	ring_buffer_finish_wait();

Now wait_on_pipe() can have:

	ring_buffer_prepare_to_wait();
	if (!iter->waking)
		ring_buffer_wait();
	ring_buffer_finish_wait();

And this will catch the above race, as the waiter will either see waking,
or already have been woken up.

Link: https://lore.kernel.org/all/CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  4 ++
 kernel/trace/ring_buffer.c  | 88 ++++++++++++++++++++++++++-----------
 kernel/trace/trace.c        | 14 +++++-
 3 files changed, 78 insertions(+), 28 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..e5b5903cdc21 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,7 +98,11 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
+int ring_buffer_prepare_to_wait(struct trace_buffer *buffer, int cpu, int *full,
+				struct wait_queue_entry *wait);
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
+void ring_buffer_finish_wait(struct trace_buffer *buffer, int cpu, int full,
+				 struct wait_queue_entry *wait);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
 void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 856d0e5b0da5..fa7090f6b4fc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -868,29 +868,29 @@ rb_get_work_queue(struct trace_buffer *buffer, int cpu, int *full)
 }
 
 /**
- * ring_buffer_wait - wait for input to the ring buffer
+ * ring_buffer_prepare_to_wait - Prepare to wait for data on the ring buffer
  * @buffer: buffer to wait on
  * @cpu: the cpu buffer to wait on
- * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ * @full: wait until the percentage of pages are available,
+ *         if @cpu != RING_BUFFER_ALL_CPUS. It may be updated via this function.
+ * @wait: The wait queue entry.
  *
- * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
- * as data is added to any of the @buffer's cpu buffers. Otherwise
- * it will wait for data to be added to a specific cpu buffer.
+ * This must be called before ring_buffer_wait(). It calls the prepare_to_wait()
+ * on @wait for the necessary wait queue defined by @buffer, @cpu, and @full.
  */
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+int ring_buffer_prepare_to_wait(struct trace_buffer *buffer, int cpu, int *full,
+				 struct wait_queue_entry *wait)
 {
 	struct rb_irq_work *rbwork;
-	DEFINE_WAIT(wait);
-	int ret = 0;
 
-	rbwork = rb_get_work_queue(buffer, cpu, &full);
+	rbwork = rb_get_work_queue(buffer, cpu, full);
 	if (IS_ERR(rbwork))
 		return PTR_ERR(rbwork);
 
-	if (full)
-		prepare_to_wait(&rbwork->full_waiters, &wait, TASK_INTERRUPTIBLE);
+	if (*full)
+		prepare_to_wait(&rbwork->full_waiters, wait, TASK_INTERRUPTIBLE);
 	else
-		prepare_to_wait(&rbwork->waiters, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&rbwork->waiters, wait, TASK_INTERRUPTIBLE);
 
 	/*
 	 * The events can happen in critical sections where
@@ -912,30 +912,66 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	 * that is necessary is that the wake up happens after
 	 * a task has been queued. It's OK for spurious wake ups.
 	 */
-	if (full)
+	if (*full)
 		rbwork->full_waiters_pending = true;
 	else
 		rbwork->waiters_pending = true;
 
-	if (rb_watermark_hit(buffer, cpu, full))
-		goto out;
+	return 0;
+}
 
-	if (signal_pending(current)) {
-		ret = -EINTR;
-		goto out;
-	}
+/**
+ * ring_buffer_finish_wait - clean up of ring_buffer_prepare_to_wait()
+ * @buffer: buffer to wait on
+ * @cpu: the cpu buffer to wait on
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ * @wait: The wait queue entry.
+ *
+ * This must be called after ring_buffer_prepare_to_wait(). It cleans up
+ * the @wait for the queue defined by @buffer, @cpu, and @full.
+ */
+void ring_buffer_finish_wait(struct trace_buffer *buffer, int cpu, int full,
+				 struct wait_queue_entry *wait)
+{
+	struct rb_irq_work *rbwork;
+
+	rbwork = rb_get_work_queue(buffer, cpu, &full);
+	if (WARN_ON_ONCE(IS_ERR(rbwork)))
+		return;
 
-	schedule();
- out:
 	if (full)
-		finish_wait(&rbwork->full_waiters, &wait);
+		finish_wait(&rbwork->full_waiters, wait);
 	else
-		finish_wait(&rbwork->waiters, &wait);
+		finish_wait(&rbwork->waiters, wait);
+}
 
-	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
-		ret = -EINTR;
+/**
+ * ring_buffer_wait - wait for input to the ring buffer
+ * @buffer: buffer to wait on
+ * @cpu: the cpu buffer to wait on
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ *
+ * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
+ * as data is added to any of the @buffer's cpu buffers. Otherwise
+ * it will wait for data to be added to a specific cpu buffer.
+ *
+ * ring_buffer_prepare_to_wait() must be called before this function
+ * and ring_buffer_finish_wait() must be called after.
+ */
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+{
+	if (rb_watermark_hit(buffer, cpu, full))
+		return 0;
 
-	return ret;
+	if (signal_pending(current))
+		return -EINTR;
+
+	schedule();
+
+	if (!rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
+		return -EINTR;
+
+	return 0;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a184dbdf8e91..2d6bc6ee8a58 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1984,7 +1984,8 @@ static bool wait_woken_prepare(struct trace_iterator *iter, int *wait_index)
 	spin_lock(&wait_lock);
 	if (iter->waking)
 		woken = true;
-	*wait_index = iter->wait_index;
+	if (wait_index)
+		*wait_index = iter->wait_index;
 	spin_unlock(&wait_lock);
 
 	return woken;
@@ -2019,13 +2020,22 @@ static void wait_woken_clear(struct trace_iterator *iter)
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	struct trace_buffer *buffer;
+	DEFINE_WAIT(wait);
 	int ret;
 
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+	buffer = iter->array_buffer->buffer;
+
+	ret = ring_buffer_prepare_to_wait(buffer, iter->cpu_file, &full, &wait);
+	if (ret < 0)
+		return ret;
+	if (!wait_woken_prepare(iter, NULL))
+		ret = ring_buffer_wait(buffer, iter->cpu_file, full);
+	ring_buffer_finish_wait(buffer, iter->cpu_file, full, &wait);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	/*
-- 
2.43.0



