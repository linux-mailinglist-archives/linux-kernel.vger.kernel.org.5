Return-Path: <linux-kernel+bounces-102412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422D87B1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5BD288F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C654BD3;
	Wed, 13 Mar 2024 19:16:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88D54735
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357412; cv=none; b=l9sRgHl37VrmtMsm2OEf/BdzNa+PM/AuDtPcrePoPSPtoYe8UEBbNRpM0571cilNYmAQsaqD48HtJFibySjcBn+qtvdyK5lc1z+EfIKd3wkIHf0RUvE5/+WHIaX0rWelHWRHH+SJxf1msY5BPpBNhzAm8O6dATiu5sCs5nW9zeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357412; c=relaxed/simple;
	bh=lpNIVtU21M9AHxzFVrLm+ZgJSRUDOFBAxcpeXY0InCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H1cxueMo51YyxxU278vwKgZQ4VYD4xm6n6vVnJ5dUcJrDn28YXORJYN8NGLFyOw/eBepq+XKm9SRqkqtRp4jBx06MlpdFxqigOAiJbBcw60pQOK03+0kPk4Xe66fbJqGDfnEYjaEO3yQQFNiyHa8orfsQ2c2X2o8DUYkCAVF9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE19CC433F1;
	Wed, 13 Mar 2024 19:16:51 +0000 (UTC)
Date: Wed, 13 Mar 2024 15:19:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing/ring-buffer: Fixes that were for 6.8
Message-ID: <20240313151900.16491cc7@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

[
  This is the continuation of the work where you gave this comment:

  https://lore.kernel.org/all/CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com/

  I hit some other bugs when writing this code that took a bit of time to
  find and fix. This is not my 6.9 pull request, but just the fixes that were
  supposed to make 6.8 but I ran out of time.
]

  

Tracing/ring-buffer fixes for 6.8 (to be applied in 6.9-rc):

- Do not update shortest_full in rb_watermark_hit() if the watermark
  is hit. The shortest_full field was being updated regardless if
  the task was going to wait or not. If the watermark is hit, then
  the task is not going to wait, so do not update the shortest_full
  field (used by the waker).

- Update shortest_full field before setting the full_waiters_pending flag

  In the poll logic, the full_waiters_pending flag was being set
  before the shortest_full field was set. If the full_waiters_pending
  flag is set, writers will check the shortest_full field which has
  the least percentage of data that the ring buffer needs to be
  filled before waking up. The writer will check shortest_full if
  full_waiters_pending is set, and if the ring buffer percentage filled
  is greater than shortest full, then it will call the irq_work to
  wake up the waiters.

  The problem was that the poll logic set the full_waiters_pending flag
  before updating shortest_full, which when zero will always trigger
  the writer to call the irq_work to wake up the waiters. The irq_work
  will reset the shortest_full field back to zero as the woken waiters
  is suppose to reset it.

- There's some optimized logic in the rb_watermark_hit() that is used
  in ring_buffer_wait(). Use that helper function in the poll logic
  as well.

- Restructure ring_buffer_wait() to use wait_event_interruptible()

  The logic to wake up pending readers when the file descriptor is
  closed is racy. Restructure ring_buffer_wait() to allow callers
  to pass in conditions besides the ring buffer having enough data
  in it by using wait_event_interruptible().

- Update the tracing_wait_on_pipe() to call ring_buffer_wait() with
  its own conditions to exit the wait loop.


Please pull the latest trace-ring-buffer-v6.8-rc7-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ring-buffer-v6.8-rc7-2

Tag SHA1: 5bcce8cb68b3b688148454564f0909045ec9218e
Head SHA1: 2aa043a55b9a764c9cbde5a8c654eeaaffe224cf


Steven Rostedt (Google) (5):
      ring-buffer: Do not set shortest_full when full target is hit
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Reuse rb_watermark_hit() for the poll logic
      ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
      tracing/ring-buffer: Fix wait_on_pipe() race

----
 include/linux/ring_buffer.h  |   4 +-
 include/linux/trace_events.h |   5 +-
 kernel/trace/ring_buffer.c   | 158 +++++++++++++++++++++++++------------------
 kernel/trace/trace.c         |  43 ++++++++----
 4 files changed, 132 insertions(+), 78 deletions(-)
---------------------------
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..dc5ae4e96aee 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,7 +98,9 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
+typedef bool (*ring_buffer_cond_fn)(void *data);
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
+		     ring_buffer_cond_fn cond, void *data);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
 void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..fc6d0af56bb1 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -103,13 +103,16 @@ struct trace_iterator {
 	unsigned int		temp_size;
 	char			*fmt;	/* modified format holder */
 	unsigned int		fmt_size;
-	long			wait_index;
+	atomic_t		wait_index;
 
 	/* trace_seq for __print_flags() and __print_symbolic() etc. */
 	struct trace_seq	tmp_seq;
 
 	cpumask_var_t		started;
 
+	/* Set when the file is closed to prevent new waiters */
+	bool			closed;
+
 	/* it's true when current open file is snapshot */
 	bool			snapshot;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index aa332ace108b..350607cce869 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -834,51 +834,24 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
 		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
 		ret = !pagebusy && full_hit(buffer, cpu, full);
 
-		if (!cpu_buffer->shortest_full ||
-		    cpu_buffer->shortest_full > full)
-			cpu_buffer->shortest_full = full;
+		if (!ret && (!cpu_buffer->shortest_full ||
+			     cpu_buffer->shortest_full > full)) {
+		    cpu_buffer->shortest_full = full;
+		}
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
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
@@ -901,27 +874,78 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
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
+ * @cond: condition function to break out of wait (NULL to run once)
+ * @data: the data to pass to @cond.
+ *
+ * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
+ * as data is added to any of the @buffer's cpu buffers. Otherwise
+ * it will wait for data to be added to a specific cpu buffer.
+ */
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full,
+		     ring_buffer_cond_fn cond, void *data)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct wait_queue_head *waitq;
+	struct rb_irq_work *rbwork;
+	long once = 0;
+	int ret = 0;
+
+	if (!cond) {
+		cond = rb_wait_once;
+		data = &once;
+	}
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
@@ -959,21 +983,30 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	}
 
 	if (full) {
-		unsigned long flags;
-
 		poll_wait(filp, &rbwork->full_waiters, poll_table);
 
-		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		if (rb_watermark_hit(buffer, cpu, full))
+			return EPOLLIN | EPOLLRDNORM;
+		/*
+		 * Only allow full_waiters_pending update to be seen after
+		 * the shortest_full is set (in rb_watermark_hit). If the
+		 * writer sees the full_waiters_pending flag set, it will
+		 * compare the amount in the ring buffer to shortest_full.
+		 * If the amount in the ring buffer is greater than the
+		 * shortest_full percent, it will call the irq_work handler
+		 * to wake up this list. The irq_handler will reset shortest_full
+		 * back to zero. That's done under the reader_lock, but
+		 * the below smp_mb() makes sure that the update to
+		 * full_waiters_pending doesn't leak up into the above.
+		 */
+		smp_mb();
 		rbwork->full_waiters_pending = true;
-		if (!cpu_buffer->shortest_full ||
-		    cpu_buffer->shortest_full > full)
-			cpu_buffer->shortest_full = full;
-		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-	} else {
-		poll_wait(filp, &rbwork->waiters, poll_table);
-		rbwork->waiters_pending = true;
+		return 0;
 	}
 
+	poll_wait(filp, &rbwork->waiters, poll_table);
+	rbwork->waiters_pending = true;
+
 	/*
 	 * There's a tight race between setting the waiters_pending and
 	 * checking if the ring buffer is empty.  Once the waiters_pending bit
@@ -989,9 +1022,6 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	 */
 	smp_mb();
 
-	if (full)
-		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
-
 	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
 	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
 		return EPOLLIN | EPOLLRDNORM;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9c898307348..d390fea3a6a5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1955,15 +1955,36 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+struct pipe_wait {
+	struct trace_iterator		*iter;
+	int				wait_index;
+};
+
+static bool wait_pipe_cond(void *data)
+{
+	struct pipe_wait *pwait = data;
+	struct trace_iterator *iter = pwait->iter;
+
+	if (atomic_read_acquire(&iter->wait_index) != pwait->wait_index)
+		return true;
+
+	return iter->closed;
+}
+
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	struct pipe_wait pwait;
 	int ret;
 
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+	pwait.wait_index = atomic_read_acquire(&iter->wait_index);
+	pwait.iter = iter;
+
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full,
+			       wait_pipe_cond, &pwait);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	/*
@@ -8398,9 +8419,9 @@ static int tracing_buffers_flush(struct file *file, fl_owner_t id)
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	iter->wait_index++;
+	iter->closed = true;
 	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
+	(void)atomic_fetch_inc_release(&iter->wait_index);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
@@ -8500,6 +8521,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		.spd_release	= buffer_spd_release,
 	};
 	struct buffer_ref *ref;
+	bool woken = false;
 	int page_size;
 	int entries, i;
 	ssize_t ret = 0;
@@ -8573,17 +8595,17 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 	/* did we read anything? */
 	if (!spd.nr_pages) {
-		long wait_index;
 
 		if (ret)
 			goto out;
 
+		if (woken)
+			goto out;
+
 		ret = -EAGAIN;
 		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
 			goto out;
 
-		wait_index = READ_ONCE(iter->wait_index);
-
 		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
@@ -8592,10 +8614,8 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if (!tracer_tracing_is_on(iter->tr))
 			goto out;
 
-		/* Make sure we see the new wait_index */
-		smp_rmb();
-		if (wait_index != iter->wait_index)
-			goto out;
+		/* Iterate one more time to collect any new data then exit */
+		woken = true;
 
 		goto again;
 	}
@@ -8618,9 +8638,8 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 
 	mutex_lock(&trace_types_lock);
 
-	iter->wait_index++;
 	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
+	(void)atomic_fetch_inc_release(&iter->wait_index);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 

