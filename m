Return-Path: <linux-kernel+bounces-97544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B261876BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE801C2177F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC305E092;
	Fri,  8 Mar 2024 20:22:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BA5D8E4;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929354; cv=none; b=LAzO90p1V0qxYs6CUfd6svFlpZ3iMl6yMSk0UA6rl7Mce1lA3tKy91fYvnkAZcpNBHMy8SStEg7e+f6z+/JZdyF/8OfpOPWVqjHSxczaVbj3gC8I5zc/NqnrcIhuKN8q7mDfrKJdqmQB8DVTRjlIhKyOa9QZF9jUZJRnGO7CgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929354; c=relaxed/simple;
	bh=qLLg2gqX2yxixorPTeSnh22VIk+O0FBQBzHrnYicbeo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qFfoGN2tGH3nEixVYyEi7TqIuRISNF7fzypnhJad0uTaTOAm4GRW1a30xmuJJkJLZUlJNkABucSOhnEIaZKNoWZWQdjIip6YAqUI0ITIXnBIiQPn9bOxpjOpduWZ0SESal2KEHHrYHH17DTMiBo3zZmjUDfIqWd9FbjuFCAiT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE17C43330;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1riglc-00000000ys7-1ikZ;
	Fri, 08 Mar 2024 15:24:32 -0500
Message-ID: <20240308202432.269350592@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 08 Mar 2024 15:24:06 -0500
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
Subject: [PATCH v2 4/6] tracing: Fix waking up tracing readers
References: <20240308202402.234176464@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When the tracing_pipe_raw file is closed, if there are readers still
blocked on it, they need to be woken up. Currently a wait_index is used.
When the readers need to be woken, the index is updated and they are all
woken up.

But there is a race where a new reader could be coming in just as the file
is being closed, and it could still block if the wake up happens just
before the reader enters the wait.

Add another field called "waking" and wrap both the waking and wait_index
around a new wait_lock to synchronize them.

When a reader comes in, it will save the current wait_index, but if waking
is set, then it will not block no matter what wait_index is.

After it wakes from the wait, if either the waking is set or the
wait_index is not the same as what it read before, then it will not block.

The waker will set waking and increment the wait_index. For the .flush()
function, it will not clear waking so that all new readers must not block.

There's an ioctl() that kicks all current waiters, but does not care about
new waiters. It will set the waking count back to what it was when it came
in.

There's still a race with the wait_on_pipe() with respect to the
ring_buffer_wait(), but that will be dealt with separately.

Link: https://lore.kernel.org/all/CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240308184007.805898590@goodmis.org

- My tests triggered a warning about calling a mutex_lock() after a
  prepare_to_wait() that changed the task's state. Convert the affected
  mutex over to a spinlock.

 include/linux/trace_events.h |   3 +-
 kernel/trace/trace.c         | 104 +++++++++++++++++++++++++++++------
 2 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d68ff9b1247f..adf8e163a7be 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -103,7 +103,8 @@ struct trace_iterator {
 	unsigned int		temp_size;
 	char			*fmt;	/* modified format holder */
 	unsigned int		fmt_size;
-	long			wait_index;
+	int			wait_index;
+	int			waking;	/* set by a waker */
 
 	/* trace_seq for __print_flags() and __print_symbolic() etc. */
 	struct trace_seq	tmp_seq;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c9c898307348..a184dbdf8e91 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1955,6 +1955,68 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
+/*
+ * In order to wake up readers and have them return back to user space,
+ * the iterator has two counters:
+ *
+ *  wait_index - always increases every time a waker wakes up the readers.
+ *  waking - Set by the waker when waking and cleared afterward.
+ *
+ * Both are protected together with the wait_lock.
+ * When waking, the lock is taken and both indexes are incremented.
+ * The reader will first prepare the wait by taking the lock,
+ * if waking is set, it will sleep regardless of what wait_index is.
+ * Then after it sleeps it checks if wait_index has been updated
+ * and if it has, it will not sleep again.
+ *
+ * Note, if wait_woken_clear() is not called, then all new readers
+ * will not sleep (this happens in closing the file).
+ *
+ * wait_lock needs to be a spinlock and not a mutex as it can be called
+ * after prepare_to_wait(), which changes the task's state.
+ */
+static DEFINE_SPINLOCK(wait_lock);
+
+static bool wait_woken_prepare(struct trace_iterator *iter, int *wait_index)
+{
+	bool woken = false;
+
+	spin_lock(&wait_lock);
+	if (iter->waking)
+		woken = true;
+	*wait_index = iter->wait_index;
+	spin_unlock(&wait_lock);
+
+	return woken;
+}
+
+static bool wait_woken_check(struct trace_iterator *iter, int *wait_index)
+{
+	bool woken = false;
+
+	spin_lock(&wait_lock);
+	if (iter->waking || *wait_index != iter->wait_index)
+		woken = true;
+	spin_unlock(&wait_lock);
+
+	return woken;
+}
+
+static void wait_woken_set(struct trace_iterator *iter)
+{
+	spin_lock(&wait_lock);
+	iter->waking++;
+	iter->wait_index++;
+	spin_unlock(&wait_lock);
+}
+
+static void wait_woken_clear(struct trace_iterator *iter)
+{
+	spin_lock(&wait_lock);
+	iter->waking--;
+	spin_unlock(&wait_lock);
+}
+
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
 	int ret;
@@ -8312,9 +8374,11 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	struct ftrace_buffer_info *info = filp->private_data;
 	struct trace_iterator *iter = &info->iter;
 	void *trace_data;
+	int wait_index;
 	int page_size;
 	ssize_t ret = 0;
 	ssize_t size;
+	bool woken;
 
 	if (!count)
 		return 0;
@@ -8353,6 +8417,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	if (info->read < page_size)
 		goto read;
 
+	woken = wait_woken_prepare(iter, &wait_index);
  again:
 	trace_access_lock(iter->cpu_file);
 	ret = ring_buffer_read_page(iter->array_buffer->buffer,
@@ -8362,7 +8427,7 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	trace_access_unlock(iter->cpu_file);
 
 	if (ret < 0) {
-		if (trace_empty(iter)) {
+		if (trace_empty(iter) && !woken) {
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 
@@ -8370,6 +8435,8 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 			if (ret)
 				return ret;
 
+			woken = wait_woken_check(iter, &wait_index);
+
 			goto again;
 		}
 		return 0;
@@ -8398,12 +8465,14 @@ static int tracing_buffers_flush(struct file *file, fl_owner_t id)
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	iter->wait_index++;
-	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
+	wait_woken_set(iter);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
+	/*
+	 * Do not call wait_woken_clear(), as the file is being closed.
+	 * this will prevent any new readers from sleeping.
+	 */
 	return 0;
 }
 
@@ -8500,9 +8569,11 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		.spd_release	= buffer_spd_release,
 	};
 	struct buffer_ref *ref;
+	int wait_index;
 	int page_size;
 	int entries, i;
 	ssize_t ret = 0;
+	bool woken = false;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (iter->snapshot && iter->tr->current_trace->use_max_tr)
@@ -8522,6 +8593,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	if (splice_grow_spd(pipe, &spd))
 		return -ENOMEM;
 
+	woken = wait_woken_prepare(iter, &wait_index);
  again:
 	trace_access_lock(iter->cpu_file);
 	entries = ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu_file);
@@ -8573,17 +8645,17 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
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
@@ -8592,10 +8664,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 		if (!tracer_tracing_is_on(iter->tr))
 			goto out;
 
-		/* Make sure we see the new wait_index */
-		smp_rmb();
-		if (wait_index != iter->wait_index)
-			goto out;
+		woken = wait_woken_check(iter, &wait_index);
 
 		goto again;
 	}
@@ -8616,15 +8685,16 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	if (cmd)
 		return -ENOIOCTLCMD;
 
-	mutex_lock(&trace_types_lock);
-
-	iter->wait_index++;
-	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
+	wait_woken_set(iter);
 
 	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
 
-	mutex_unlock(&trace_types_lock);
+	/*
+	 * This just kicks existing readers, a new reader coming in may
+	 * still sleep.
+	 */
+	wait_woken_clear(iter);
+
 	return 0;
 }
 
-- 
2.43.0



