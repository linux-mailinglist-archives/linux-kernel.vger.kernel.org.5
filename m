Return-Path: <linux-kernel+bounces-98264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C468777A2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0C5B2107B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325FB39ACB;
	Sun, 10 Mar 2024 16:37:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239F24219;
	Sun, 10 Mar 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710088673; cv=none; b=VyJKJX7cvP/JjIwTZjpMITdkaczWdNpJh1AVCLN4f2j3kL2RckKJeH53C7mlq5MJjeh6eBfuxdjxv2frKH2S4M7LUBF+/RsJsCLeM1ai7MktBcv3ypJVpGddfOaTN8AeJitbUexijVXyp6IBEsQQ89bVXQyIGKiqJdhdM1L4p90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710088673; c=relaxed/simple;
	bh=HOoZ1vLwV0Z/nT2AMqSg+qDgVo7LPPVbt0z6qTqTQfQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EhLU2l8O6xxS2sYL8uF1bN50Bix83FsLO0k7vg7oPtBUB1NpAki3D+hBg7zAR0fp1MrqQrUqJ6z4heOuou0jIKuKhTPcUBKRXdnxE5AlWShVD/JHG58L65b06pU5bdZFWSB6bmqLg9/2dw6h0kG1NgsQJMS0yOt0f4NrBNr1Ko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FEBC43390;
	Sun, 10 Mar 2024 16:37:53 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rjMDL-00000001Pb5-1U7K;
	Sun, 10 Mar 2024 12:39:55 -0400
Message-ID: <20240310163955.216982555@goodmis.org>
User-Agent: quilt/0.67
Date: Sun, 10 Mar 2024 12:32:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linke li <lilinke99@qq.com>,
 Rabin Vincent <rabin@rab.in>
Subject: [for-linus][PATCH 1/3] ring-buffer: Fix waking up ring buffer readers
References: <20240310163218.425365963@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A task can wait on a ring buffer for when it fills up to a specific
watermark. The writer will check the minimum watermark that waiters are
waiting for and if the ring buffer is past that, it will wake up all the
waiters.

The waiters are in a wait loop, and will first check if a signal is
pending and then check if the ring buffer is at the desired level where it
should break out of the loop.

If a file that uses a ring buffer closes, and there's threads waiting on
the ring buffer, it needs to wake up those threads. To do this, a
"wait_index" was used.

Before entering the wait loop, the waiter will read the wait_index. On
wakeup, it will check if the wait_index is different than when it entered
the loop, and will exit the loop if it is. The waker will only need to
update the wait_index before waking up the waiters.

This had a couple of bugs. One trivial one and one broken by design.

The trivial bug was that the waiter checked the wait_index after the
schedule() call. It had to be checked between the prepare_to_wait() and
the schedule() which it was not.

The main bug is that the first check to set the default wait_index will
always be outside the prepare_to_wait() and the schedule(). That's because
the ring_buffer_wait() doesn't have enough context to know if it should
break out of the loop.

The loop itself is not needed, because all the callers to the
ring_buffer_wait() also has their own loop, as the callers have a better
sense of what the context is to decide whether to break out of the loop
or not.

Just have the ring_buffer_wait() block once, and if it gets woken up, exit
the function and let the callers decide what to do next.

Link: https://lore.kernel.org/all/CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240308202431.792933613@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linke li <lilinke99@qq.com>
Cc: Rabin Vincent <rabin@rab.in>
Fixes: e30f53aad2202 ("tracing: Do not busy wait in buffer splice")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 139 ++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 71 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0699027b4f4c..3400f11286e3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -384,7 +384,6 @@ struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
 	wait_queue_head_t		full_waiters;
-	long				wait_index;
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
@@ -798,14 +797,40 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 		rbwork = &cpu_buffer->irq_work;
 	}
 
-	rbwork->wait_index++;
-	/* make sure the waiters see the new index */
-	smp_wmb();
-
 	/* This can be called in any context */
 	irq_work_queue(&rbwork->work);
 }
 
+static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	bool ret = false;
+
+	/* Reads of all CPUs always waits for any data */
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		return !ring_buffer_empty(buffer);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	if (!ring_buffer_empty_cpu(buffer, cpu)) {
+		unsigned long flags;
+		bool pagebusy;
+
+		if (!full)
+			return true;
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+		ret = !pagebusy && full_hit(buffer, cpu, full);
+
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+	return ret;
+}
+
 /**
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
@@ -821,7 +846,6 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
-	long wait_index;
 	int ret = 0;
 
 	/*
@@ -840,81 +864,54 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		work = &cpu_buffer->irq_work;
 	}
 
-	wait_index = READ_ONCE(work->wait_index);
-
-	while (true) {
-		if (full)
-			prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-		else
-			prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
-
-		/*
-		 * The events can happen in critical sections where
-		 * checking a work queue can cause deadlocks.
-		 * After adding a task to the queue, this flag is set
-		 * only to notify events to try to wake up the queue
-		 * using irq_work.
-		 *
-		 * We don't clear it even if the buffer is no longer
-		 * empty. The flag only causes the next event to run
-		 * irq_work to do the work queue wake up. The worse
-		 * that can happen if we race with !trace_empty() is that
-		 * an event will cause an irq_work to try to wake up
-		 * an empty queue.
-		 *
-		 * There's no reason to protect this flag either, as
-		 * the work queue and irq_work logic will do the necessary
-		 * synchronization for the wake ups. The only thing
-		 * that is necessary is that the wake up happens after
-		 * a task has been queued. It's OK for spurious wake ups.
-		 */
-		if (full)
-			work->full_waiters_pending = true;
-		else
-			work->waiters_pending = true;
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		if (cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer))
-			break;
-
-		if (cpu != RING_BUFFER_ALL_CPUS &&
-		    !ring_buffer_empty_cpu(buffer, cpu)) {
-			unsigned long flags;
-			bool pagebusy;
-			bool done;
-
-			if (!full)
-				break;
-
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
-			done = !pagebusy && full_hit(buffer, cpu, full);
+	if (full)
+		prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
+	else
+		prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
 
-			if (!cpu_buffer->shortest_full ||
-			    cpu_buffer->shortest_full > full)
-				cpu_buffer->shortest_full = full;
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-			if (done)
-				break;
-		}
+	/*
+	 * The events can happen in critical sections where
+	 * checking a work queue can cause deadlocks.
+	 * After adding a task to the queue, this flag is set
+	 * only to notify events to try to wake up the queue
+	 * using irq_work.
+	 *
+	 * We don't clear it even if the buffer is no longer
+	 * empty. The flag only causes the next event to run
+	 * irq_work to do the work queue wake up. The worse
+	 * that can happen if we race with !trace_empty() is that
+	 * an event will cause an irq_work to try to wake up
+	 * an empty queue.
+	 *
+	 * There's no reason to protect this flag either, as
+	 * the work queue and irq_work logic will do the necessary
+	 * synchronization for the wake ups. The only thing
+	 * that is necessary is that the wake up happens after
+	 * a task has been queued. It's OK for spurious wake ups.
+	 */
+	if (full)
+		work->full_waiters_pending = true;
+	else
+		work->waiters_pending = true;
 
-		schedule();
+	if (rb_watermark_hit(buffer, cpu, full))
+		goto out;
 
-		/* Make sure to see the new wait index */
-		smp_rmb();
-		if (wait_index != work->wait_index)
-			break;
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
 	}
 
+	schedule();
+ out:
 	if (full)
 		finish_wait(&work->full_waiters, &wait);
 	else
 		finish_wait(&work->waiters, &wait);
 
+	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
+		ret = -EINTR;
+
 	return ret;
 }
 
-- 
2.43.0



