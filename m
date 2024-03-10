Return-Path: <linux-kernel+bounces-98268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA48777A7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740A3280236
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D491374FA;
	Sun, 10 Mar 2024 16:52:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E433CC4
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710089539; cv=none; b=tCu4KiKc0c4AayHwB+nRuDws2gRqR+8YixWJ0ghSxRXoBwueMS9FbFlyoV2Y+1O7bxP7emI/PNEcaRrmkjUPSqSWIr28dKem6BnjoiNaiQPeWRN5lmjNoxVIy61imVuy28570a2jL+ANV4mwpc4ToZV3JoGwzXAkqjYeagrhOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710089539; c=relaxed/simple;
	bh=/F3LuQe60fPT4LnvMxZ00LB7Gb0hVDCKUjh19R6uz1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ade6LPBnAkx+jnI/6M4A94FQqrux8e6UfvkSJgQOXxYBXwELgF2Mv8JQgkZZbMC6ktLD9D1oC+zdV2nzTxWEKX40BjpHcJzJjviLKjwFihyFT9uwuQJWLfmcgzIaOLdtHtfksFLNJU1NuuGR9742qxCCKEgtH+WaSFRGRvkM17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A547CC433F1;
	Sun, 10 Mar 2024 16:52:18 +0000 (UTC)
Date: Sun, 10 Mar 2024 12:52:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Fixes for v6.8
Message-ID: <20240310125217.3f829bd5@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Linus,

Tracing fixes for v6.8-rc7:

- Do not allow large strings (> 4096) as single write to trace_marker

  The size of a string written into trace_marker was determined by
  the size of the sub-buffer in the ring buffer. That size is
  dependent on the PAGE_SIZE of the architecture as it can be mapped
  into user space. But on PowerPC, where PAGE_SIZE is 64K, that made
  the limit of the string of writing into trace_marker 64K.

  One of the selftests looks at the size of the ring buffer sub-buffers
  and writes that plus more into the trace_marker. The write will take
  what it can and report back what it consumed so that the user space
  application (like echo) will write the rest of the string. The string
  is stored in the ring buffer and can be read via the "trace" or
  "trace_pipe" files.

  The reading of the ring buffer uses vsnprintf(), which uses a precision
  "%.*s" to make sure it only reads what is stored in the buffer, as
  a bug could cause the string to be non terminated.

  With the combination of the precision change and the PAGE_SIZE of 64K
  allowing huge strings to be added into the ring buffer, plus the test
  that would actually stress that limit, a bug was reported that
  the precision used was too big for "%.*s" as the string was close to
  64K in size and the max precision of vsnprintf is 32K.

  Linus suggested not to have that precision as it could hide a bug
  if the string was again stored without a nul byte.

  Another issue that was brought up is that the trace_seq buffer is
  also based on PAGE_SIZE even though it is not tied to the architecture
  limit like the ring buffer sub-buffer is. Having it be 64K * 2 is
  simply just too big and wasting memory on systems with 64K page sizes.
  It is now hardcoded to 8K which is what all other architectures with
  4K PAGE_SIZE has.

  Finally, the write to trace_marker is now limited to 4K as there is no
  reason to write larger strings into trace_marker.

- ring_buffer_wait() should not loop.
  The ring_buffer_wait() does not have the full context (yet) on if it
  should loop or not. Just exit the loop as soon as its woken up and
  let the callers decide to loop or not (they already do, so it's a bit
  redundant).

- Fix shortest_full field to be the smallest amount in the ring buffer that
  a waiter is waiting for. The "shortest_full" field is updated when a new
  waiter comes in and wants to wait for a smaller amount of data in the
  ring buffer than other waiters. But after all waiters are woken up, it's
  not reset, so if another waiter comes in wanting to wait for more data,
  it will be woken up when the ring buffer has a smaller amount from what
  the previous waiters were waiting for.

- The wake up all waiters on close is incorrectly called frome .release()
  and not from .flush() so it will never wake up any waiters as the
  .release() will not get called until all .read() calls are finished. And the
  wakeup is for the waiters in those .read() calls.


Please pull the latest trace-ring-buffer-v6.8-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ring-buffer-v6.8-rc7

Tag SHA1: 60da80484a6502dc9ceb907f9c8de991399aa7af
Head SHA1: e5d7c1916562f0e856eb3d6f569629fcd535fed2


Steven Rostedt (Google) (6):
      tracing: Remove precision vsnprintf() check from print event
      tracing: Limit trace_seq size to just 8K and not depend on architecture PAGE_SIZE
      tracing: Limit trace_marker writes to just 4K
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Fix resetting of shortest_full
      tracing: Use .flush() call to wake up readers

----
 include/linux/trace_seq.h   |   8 ++-
 kernel/trace/ring_buffer.c  | 169 ++++++++++++++++++++++++--------------------
 kernel/trace/trace.c        |  31 +++++---
 kernel/trace/trace_output.c |   6 +-
 4 files changed, 120 insertions(+), 94 deletions(-)
---------------------------
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 9ec229dfddaa..1ef95c0287f0 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -9,9 +9,15 @@
 /*
  * Trace sequences are used to allow a function to call several other functions
  * to create a string of data to use.
+ *
+ * Have the trace seq to be 8K which is typically PAGE_SIZE * 2 on
+ * most architectures. The TRACE_SEQ_BUFFER_SIZE (which is
+ * TRACE_SEQ_SIZE minus the other fields of trace_seq), is the
+ * max size the output of a trace event may be.
  */
 
-#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
+#define TRACE_SEQ_SIZE		8192
+#define TRACE_SEQ_BUFFER_SIZE	(TRACE_SEQ_SIZE - \
 	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
 
 struct trace_seq {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0699027b4f4c..aa332ace108b 100644
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
@@ -756,8 +755,19 @@ static void rb_wake_up_waiters(struct irq_work *work)
 
 	wake_up_all(&rbwork->waiters);
 	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
+		/* Only cpu_buffer sets the above flags */
+		struct ring_buffer_per_cpu *cpu_buffer =
+			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
+
+		/* Called from interrupt context */
+		raw_spin_lock(&cpu_buffer->reader_lock);
 		rbwork->wakeup_full = false;
 		rbwork->full_waiters_pending = false;
+
+		/* Waking up all waiters, they will reset the shortest full */
+		cpu_buffer->shortest_full = 0;
+		raw_spin_unlock(&cpu_buffer->reader_lock);
+
 		wake_up_all(&rbwork->full_waiters);
 	}
 }
@@ -798,14 +808,40 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
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
@@ -821,7 +857,6 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
-	long wait_index;
 	int ret = 0;
 
 	/*
@@ -840,81 +875,54 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
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
 
@@ -937,28 +945,33 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	struct rb_irq_work *work;
+	struct rb_irq_work *rbwork;
 
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
+		rbwork = &buffer->irq_work;
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
+		rbwork = &cpu_buffer->irq_work;
 	}
 
 	if (full) {
-		poll_wait(filp, &work->full_waiters, poll_table);
-		work->full_waiters_pending = true;
+		unsigned long flags;
+
+		poll_wait(filp, &rbwork->full_waiters, poll_table);
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		rbwork->full_waiters_pending = true;
 		if (!cpu_buffer->shortest_full ||
 		    cpu_buffer->shortest_full > full)
 			cpu_buffer->shortest_full = full;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
-		poll_wait(filp, &work->waiters, poll_table);
-		work->waiters_pending = true;
+		poll_wait(filp, &rbwork->waiters, poll_table);
+		rbwork->waiters_pending = true;
 	}
 
 	/*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..c9c898307348 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7293,6 +7293,8 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#define TRACE_MARKER_MAX_SIZE		4096
+
 static ssize_t
 tracing_mark_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7320,6 +7322,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if ((ssize_t)cnt < 0)
 		return -EINVAL;
 
+	if (cnt > TRACE_MARKER_MAX_SIZE)
+		cnt = TRACE_MARKER_MAX_SIZE;
+
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
@@ -7328,11 +7333,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt < FAULTED_SIZE)
 		size += FAULTED_SIZE - cnt;
 
-	if (size > TRACE_SEQ_BUFFER_SIZE) {
-		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
-		goto again;
-	}
-
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
@@ -8393,6 +8393,20 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	return size;
 }
 
+static int tracing_buffers_flush(struct file *file, fl_owner_t id)
+{
+	struct ftrace_buffer_info *info = file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	iter->wait_index++;
+	/* Make sure the waiters see the new wait_index */
+	smp_wmb();
+
+	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
+
+	return 0;
+}
+
 static int tracing_buffers_release(struct inode *inode, struct file *file)
 {
 	struct ftrace_buffer_info *info = file->private_data;
@@ -8404,12 +8418,6 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 
 	__trace_array_put(iter->tr);
 
-	iter->wait_index++;
-	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
-
-	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
-
 	if (info->spare)
 		ring_buffer_free_read_page(iter->array_buffer->buffer,
 					   info->spare_cpu, info->spare);
@@ -8625,6 +8633,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.read		= tracing_buffers_read,
 	.poll		= tracing_buffers_poll,
 	.release	= tracing_buffers_release,
+	.flush		= tracing_buffers_flush,
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3e7fa44dc2b2..d8b302d01083 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1587,12 +1587,11 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %.*s", max, field->buf);
+	trace_seq_printf(s, ": %s", field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1601,11 +1600,10 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
-	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }

