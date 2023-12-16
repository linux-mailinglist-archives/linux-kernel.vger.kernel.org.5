Return-Path: <linux-kernel+bounces-2065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4E81576F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1869F1C219AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B540134CA;
	Sat, 16 Dec 2023 04:29:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0B134AC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C891C433C8;
	Sat, 16 Dec 2023 04:29:57 +0000 (UTC)
Date: Fri, 15 Dec 2023 23:29:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Fixes for v6.7-rc5
Message-ID: <20231215232956.3127a09b@rorschach.local.home>
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

Tracing fixes for v6.7-rc5:

- Fix eventfs to check creating new files for events with names greater than
  NAME_MAX. The eventfs lookup needs to check the return result of
  simple_lookup().

- Fix the ring buffer to check the proper max data size. Events must be able to
  fit on the ring buffer sub-buffer, if it cannot, then it fails to be written
  and the logic to add the event is avoided. The code to check if an event can
  fit failed to add the possible absolute timestamp which may make the event
  not be able to fit. This causes the ring buffer to go into an infinite loop
  trying to find a sub-buffer that would fit the event. Luckily, there's a check
  that will bail out if it looped over a 1000 times and it also warns.

  The real fix is not to add the absolute timestamp to an event that is
  starting at the beginning of a sub-buffer because it uses the sub-buffer
  timestamp. By avoiding the timestamp at the start of the sub-buffer allows
  events that pass the first check to always find a sub-buffer that it can fit
  on.

- Have large events that do not fit on a trace_seq to print "LINE TOO BIG" like
  it does for the trace_pipe instead of what it does now which is to silently
  drop the output.

- Fix a memory leak of forgetting to free the spare page that is saved by a
  trace instance.

- Update the size of the snapshot buffer when the main buffer is updated if the
  snapshot buffer is allocated.

- Fix ring buffer timestamp logic by removing all the places that tried to put
  the before_stamp back to the write stamp so that the next event doesn't add
  an absolute timestamp. But each of these updates added a race where by making
  the two timestamp equal, it was validating the write_stamp so that it can be
  incorrectly used for calculating the delta of an event.

- There's a temp buffer used for printing the event that was using the event
  data size for allocation when it needed to use the size of the entire event
  (meta-data and payload data)

- For hardening, use "%.*s" for printing the trace_marker output, to limit the
  amount that is printed by the size of the event. This was discovered by
  development that added a bug that truncated the '\0' and caused a crash.

- Fix a use-after-free bug in the use of the histogram files when an instance
  is being removed.

- Remove a useless update in the rb_try_to_discard of the write_stamp. The
  before_stamp was already changed to force the next event to add an absolute
  timestamp that the write_stamp is not used. But the write_stamp is modified
  again using an unneeded 64-bit cmpxchg.

- Fix several races in the 32-bit implementation of the rb_time_cmpxchg() that
  does a 64-bit cmpxchg.

- While looking at fixing the 64-bit cmpxchg, I noticed that because the ring
  buffer uses normal cmpxchg, and this can be done in NMI context, there's some
  architectures that do not have a working cmpxchg in NMI context. For these
  architectures, fail recording events that happen in NMI context.


Please pull the latest trace-v6.7-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.7-rc5

Tag SHA1: 387087dd6332177f97699b06adb12b8f01069a71
Head SHA1: 712292308af2265cd9b126aedfa987f10f452a33


Beau Belgrave (1):
      eventfs: Fix events beyond NAME_MAX blocking tasks

Mathieu Desnoyers (1):
      ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()

Steven Rostedt (Google) (12):
      ring-buffer: Fix writing to the buffer with max_data_size
      tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
      ring-buffer: Fix memory leak of free page
      tracing: Update snapshot buffer on resize if it is allocated
      ring-buffer: Do not update before stamp when switching sub-buffers
      ring-buffer: Have saved event hold the entire event
      tracing: Add size check when printing trace_marker output
      ring-buffer: Do not try to put back write_stamp
      ring-buffer: Remove useless update to write_stamp in rb_try_to_discard()
      ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
      ring-buffer: Have rb_time_cmpxchg() set the msb counter too
      ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Zheng Yejian (1):
      tracing: Fix uaf issue when open the hist or hist_debug file

----
 fs/tracefs/event_inode.c         |   4 ++
 kernel/trace/ring_buffer.c       | 115 ++++++++++++++-------------------------
 kernel/trace/trace.c             |  16 +++++-
 kernel/trace/trace.h             |   1 +
 kernel/trace/trace_events_hist.c |  12 ++--
 kernel/trace/trace_output.c      |   6 +-
 6 files changed, 72 insertions(+), 82 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0b90869fd805..43e237864a42 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -546,6 +546,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
 		ret = simple_lookup(dir, dentry, flags);
+		if (IS_ERR(ret))
+			goto out;
 		create_dir_dentry(ei, ei_child, ei_dentry, true);
 		created = true;
 		break;
@@ -568,6 +570,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			if (r <= 0)
 				continue;
 			ret = simple_lookup(dir, dentry, flags);
+			if (IS_ERR(ret))
+				goto out;
 			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
 					   fops, true);
 			break;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8d2a4f00eca9..5a114e752f11 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and msb counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(msb))
+	/* If top, msb or bottom counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb) || *cnt != rb_time_cnt(bottom))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
@@ -706,6 +706,9 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	unsigned long cnt2, top2, bottom2, msb2;
 	u64 val;
 
+	/* Any interruptions in this function should cause a failure */
+	cnt = local_read(&t->cnt);
+
 	/* The cmpxchg always fails if it interrupted an update */
 	 if (!__rb_time_read(t, &val, &cnt2))
 		 return false;
@@ -713,17 +716,18 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 	 if (val != expect)
 		 return false;
 
-	 cnt = local_read(&t->cnt);
 	 if ((cnt & 3) != cnt2)
 		 return false;
 
 	 cnt2 = cnt + 1;
 
 	 rb_time_split(val, &top, &bottom, &msb);
+	 msb = rb_time_val_cnt(msb, cnt);
 	 top = rb_time_val_cnt(top, cnt);
 	 bottom = rb_time_val_cnt(bottom, cnt);
 
 	 rb_time_split(set, &top2, &bottom2, &msb2);
+	 msb2 = rb_time_val_cnt(msb2, cnt);
 	 top2 = rb_time_val_cnt(top2, cnt2);
 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
 
@@ -1787,6 +1791,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
+	free_page((unsigned long)cpu_buffer->free_page);
+
 	kfree(cpu_buffer);
 }
 
@@ -2407,7 +2413,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > BUF_MAX_DATA_SIZE)
+	if ((iter->head + length) > commit || length > BUF_PAGE_SIZE)
 		/* Writer corrupted the read? */
 		goto reset;
 
@@ -2981,25 +2987,6 @@ static unsigned rb_calculate_event_length(unsigned length)
 	return length;
 }
 
-static u64 rb_time_delta(struct ring_buffer_event *event)
-{
-	switch (event->type_len) {
-	case RINGBUF_TYPE_PADDING:
-		return 0;
-
-	case RINGBUF_TYPE_TIME_EXTEND:
-		return rb_event_time_stamp(event);
-
-	case RINGBUF_TYPE_TIME_STAMP:
-		return 0;
-
-	case RINGBUF_TYPE_DATA:
-		return event->time_delta;
-	default:
-		return 0;
-	}
-}
-
 static inline bool
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
@@ -3007,8 +2994,6 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	unsigned long new_index, old_index;
 	struct buffer_page *bpage;
 	unsigned long addr;
-	u64 write_stamp;
-	u64 delta;
 
 	new_index = rb_event_index(event);
 	old_index = new_index + rb_event_ts_length(event);
@@ -3017,14 +3002,10 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 
 	bpage = READ_ONCE(cpu_buffer->tail_page);
 
-	delta = rb_time_delta(event);
-
-	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
-		return false;
-
-	/* Make sure the write stamp is read before testing the location */
-	barrier();
-
+	/*
+	 * Make sure the tail_page is still the same and
+	 * the next write location is the end of this event
+	 */
 	if (bpage->page == (void *)addr && rb_page_write(bpage) == old_index) {
 		unsigned long write_mask =
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
@@ -3035,20 +3016,20 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		 * to make sure that the next event adds an absolute
 		 * value and does not rely on the saved write stamp, which
 		 * is now going to be bogus.
+		 *
+		 * By setting the before_stamp to zero, the next event
+		 * is not going to use the write_stamp and will instead
+		 * create an absolute timestamp. This means there's no
+		 * reason to update the wirte_stamp!
 		 */
 		rb_time_set(&cpu_buffer->before_stamp, 0);
 
-		/* Something came in, can't discard */
-		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
-				       write_stamp, write_stamp - delta))
-			return false;
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
 		 * that this event just added itself before updating
 		 * the write stamp. The interrupting event will fix the
-		 * write stamp for us, and use the before stamp as its delta.
+		 * write stamp for us, and use an absolute timestamp.
 		 */
 
 		/*
@@ -3485,7 +3466,7 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 		return;
 
 	/*
-	 * If this interrupted another event, 
+	 * If this interrupted another event,
 	 */
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
@@ -3579,7 +3560,10 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * absolute timestamp.
 		 * Don't bother if this is the start of a new page (w == 0).
 		 */
-		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+		if (!w) {
+			/* Use the sub-buffer timestamp */
+			info->delta = 0;
+		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
@@ -3602,26 +3586,19 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/* See if we shot pass the end of this buffer page */
 	if (unlikely(write > BUF_PAGE_SIZE)) {
-		/* before and after may now different, fix it up*/
-		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-		if (a_ok && b_ok && info->before != info->after)
-			(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
-					      info->before, info->after);
-		if (a_ok && b_ok)
-			check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
+		check_buffer(cpu_buffer, info, CHECK_FULL_PAGE);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 
 	if (likely(tail == w)) {
-		u64 save_before;
-		bool s_ok;
-
 		/* Nothing interrupted us between A and C */
  /*D*/		rb_time_set(&cpu_buffer->write_stamp, info->ts);
-		barrier();
- /*E*/		s_ok = rb_time_read(&cpu_buffer->before_stamp, &save_before);
-		RB_WARN_ON(cpu_buffer, !s_ok);
+		/*
+		 * If something came in between C and D, the write stamp
+		 * may now not be in sync. But that's fine as the before_stamp
+		 * will be different and then next event will just be forced
+		 * to use an absolute timestamp.
+		 */
 		if (likely(!(info->add_timestamp &
 			     (RB_ADD_STAMP_FORCE | RB_ADD_STAMP_ABSOLUTE))))
 			/* This did not interrupt any time update */
@@ -3629,24 +3606,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		else
 			/* Just use full timestamp for interrupting event */
 			info->delta = info->ts;
-		barrier();
 		check_buffer(cpu_buffer, info, tail);
-		if (unlikely(info->ts != save_before)) {
-			/* SLOW PATH - Interrupted between C and E */
-
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-			RB_WARN_ON(cpu_buffer, !a_ok);
-
-			/* Write stamp must only go forward */
-			if (save_before > info->after) {
-				/*
-				 * We do not care about the result, only that
-				 * it gets updated atomically.
-				 */
-				(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-						      info->after, save_before);
-			}
-		}
 	} else {
 		u64 ts;
 		/* SLOW PATH - Interrupted between A and C */
@@ -3714,6 +3674,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
+	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	    (unlikely(in_nmi()))) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
 
@@ -3737,6 +3703,8 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	if (ring_buffer_time_stamp_abs(cpu_buffer->buffer)) {
 		add_ts_default = RB_ADD_STAMP_ABSOLUTE;
 		info.length += RB_LEN_TIME_EXTEND;
+		if (info.length > BUF_MAX_DATA_SIZE)
+			goto out_fail;
 	} else {
 		add_ts_default = RB_ADD_STAMP_NONE;
 	}
@@ -5118,7 +5086,8 @@ ring_buffer_read_prepare(struct trace_buffer *buffer, int cpu, gfp_t flags)
 	if (!iter)
 		return NULL;
 
-	iter->event = kmalloc(BUF_MAX_DATA_SIZE, flags);
+	/* Holds the entire event: data and meta data */
+	iter->event = kmalloc(BUF_PAGE_SIZE, flags);
 	if (!iter->event) {
 		kfree(iter);
 		return NULL;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fbcd3bafb93e..199df497db07 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4722,7 +4722,11 @@ static int s_show(struct seq_file *m, void *v)
 		iter->leftover = ret;
 
 	} else {
-		print_trace_line(iter);
+		ret = print_trace_line(iter);
+		if (ret == TRACE_TYPE_PARTIAL_LINE) {
+			iter->seq.full = 0;
+			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
+		}
 		ret = trace_print_seq(m, &iter->seq);
 		/*
 		 * If we overflow the seq_file buffer, then it will
@@ -4964,6 +4968,12 @@ int tracing_release_file_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
+{
+	tracing_release_file_tr(inode, filp);
+	return single_release(inode, filp);
+}
+
 static int tracing_mark_open(struct inode *inode, struct file *filp)
 {
 	stream_open(inode, filp);
@@ -6344,7 +6354,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
-	/* Do not allow tracing while resizng ring buffer */
+	/* Do not allow tracing while resizing ring buffer */
 	tracing_stop_tr(tr);
 
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
@@ -6352,7 +6362,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!tr->current_trace->use_max_tr)
+	if (!tr->allocated_snapshot)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b7f4ea25a194..0489e72c8169 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -617,6 +617,7 @@ int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 int tracing_open_file_tr(struct inode *inode, struct file *filp);
 int tracing_release_file_tr(struct inode *inode, struct file *filp);
+int tracing_single_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1abc07fba1b9..5ecf3c8bde20 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5623,10 +5623,12 @@ static int event_hist_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	/* Clear private_data to avoid warning in single_open() */
+	file->private_data = NULL;
 	return single_open(file, hist_show, file);
 }
 
@@ -5634,7 +5636,7 @@ const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = tracing_single_release_file_tr,
 };
 
 #ifdef CONFIG_HIST_TRIGGERS_DEBUG
@@ -5900,10 +5902,12 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
-	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	ret = tracing_open_file_tr(inode, file);
 	if (ret)
 		return ret;
 
+	/* Clear private_data to avoid warning in single_open() */
+	file->private_data = NULL;
 	return single_open(file, hist_debug_show, file);
 }
 
@@ -5911,7 +5915,7 @@ const struct file_operations event_hist_debug_fops = {
 	.open = event_hist_debug_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = single_release,
+	.release = tracing_single_release_file_tr,
 };
 #endif
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..3e7fa44dc2b2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1587,11 +1587,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
 {
 	struct print_entry *field;
 	struct trace_seq *s = &iter->seq;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
 	seq_print_ip_sym(s, field->ip, flags);
-	trace_seq_printf(s, ": %s", field->buf);
+	trace_seq_printf(s, ": %.*s", max, field->buf);
 
 	return trace_handle_return(s);
 }
@@ -1600,10 +1601,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
 					 struct trace_event *event)
 {
 	struct print_entry *field;
+	int max = iter->ent_size - offsetof(struct print_entry, buf);
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
+	trace_seq_printf(&iter->seq, "# %lx %.*s", field->ip, max, field->buf);
 
 	return trace_handle_return(&iter->seq);
 }

