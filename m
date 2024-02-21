Return-Path: <linux-kernel+bounces-74862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7085DDBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CE31F23EED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9A2811E5;
	Wed, 21 Feb 2024 14:06:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0C7FBA5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524401; cv=none; b=FgxU+kiEziQElJA25ibplQJMRlYb+KGUPk7vCkEmnDYaegrD6XlHaibXT/DzapFPAYUOcuqcG8jbpQ0whJKgHvlJs0aX2/AtV+CPfyM+/xrLNPDrdN6gI7Wu7yygfU6NeUul+ywEGGfY2ebvnKiIr86TO7U9zSQuWfRJ/nIQygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524401; c=relaxed/simple;
	bh=aS+rpV9JS/+Sdrzuv8Q/HkmvG/2nlGWpJfNxzR9Cjes=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=N5gvVazTbdxliG562toAd1lenJiWQr+qciQllFqs/ofqU7RA2tXj6kFt+ydE0GuxzHaD4iHkUlgU3Pr/LiRtOBi5AM74zbE+OzdxmKyOAMh5aKZKds+rs2NCqISxttY85FMv1JSpKeq5dNo8/SoUvHmqlu6nBApBFl0UUapBIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C078C43399;
	Wed, 21 Feb 2024 14:06:40 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rcnGu-00000002i9M-3O38;
	Wed, 21 Feb 2024 09:08:28 -0500
Message-ID: <20240221140828.669444738@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 21 Feb 2024 09:08:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: [for-next][PATCH 05/11] tracing: Move saved_cmdline code into trace_sched_switch.c
References: <20240221140756.797572998@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The code that handles saved_cmdlines is split between the trace.c file and
the trace_sched_switch.c. There's some history to this. The
trace_sched_switch.c was originally created to handle the sched_switch
tracer that was deprecated due to sched_switch trace event making it
obsolete. But that file did not get deleted as it had some code to help
with saved_cmdlines. But trace.c has grown tremendously since then. Just
move all the saved_cmdlines code into trace_sched_switch.c as that's the
only reason that file still exists, and trace.c has gotten too big.

No functional changes.

Link: https://lore.kernel.org/linux-trace-kernel/20240220140703.497966629@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c              | 515 +-----------------------------
 kernel/trace/trace.h              |  10 +
 kernel/trace/trace_sched_switch.c | 515 ++++++++++++++++++++++++++++++
 3 files changed, 528 insertions(+), 512 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 06c593fc93d0..50fab999e72e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -39,7 +39,6 @@
 #include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/panic_notifier.h>
-#include <linux/kmemleak.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
@@ -105,7 +104,7 @@ dummy_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
  * tracing is active, only save the comm when a trace event
  * occurred.
  */
-static DEFINE_PER_CPU(bool, trace_taskinfo_save);
+DEFINE_PER_CPU(bool, trace_taskinfo_save);
 
 /*
  * Kill all tracing for good (never come back).
@@ -2299,96 +2298,6 @@ void tracing_reset_all_online_cpus(void)
 	mutex_unlock(&trace_types_lock);
 }
 
-/*
- * The tgid_map array maps from pid to tgid; i.e. the value stored at index i
- * is the tgid last observed corresponding to pid=i.
- */
-static int *tgid_map;
-
-/* The maximum valid index into tgid_map. */
-static size_t tgid_map_max;
-
-#define SAVED_CMDLINES_DEFAULT 128
-#define NO_CMDLINE_MAP UINT_MAX
-/*
- * Preemption must be disabled before acquiring trace_cmdline_lock.
- * The various trace_arrays' max_lock must be acquired in a context
- * where interrupt is disabled.
- */
-static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
-struct saved_cmdlines_buffer {
-	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
-	unsigned *map_cmdline_to_pid;
-	unsigned cmdline_num;
-	int cmdline_idx;
-	char saved_cmdlines[];
-};
-static struct saved_cmdlines_buffer *savedcmd;
-
-/* Holds the size of a cmdline and pid element */
-#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
-	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
-
-static inline char *get_saved_cmdlines(int idx)
-{
-	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
-}
-
-static inline void set_cmdline(int idx, const char *cmdline)
-{
-	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
-}
-
-static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-{
-	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
-
-	kmemleak_free(s);
-	free_pages((unsigned long)s, order);
-}
-
-static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
-{
-	struct saved_cmdlines_buffer *s;
-	struct page *page;
-	int orig_size, size;
-	int order;
-
-	/* Figure out how much is needed to hold the given number of cmdlines */
-	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
-	order = get_order(orig_size);
-	size = 1 << (order + PAGE_SHIFT);
-	page = alloc_pages(GFP_KERNEL, order);
-	if (!page)
-		return NULL;
-
-	s = page_address(page);
-	kmemleak_alloc(s, size, 1, GFP_KERNEL);
-	memset(s, 0, sizeof(*s));
-
-	/* Round up to actual allocation */
-	val = (size - sizeof(*s)) / SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
-	s->cmdline_num = val;
-
-	/* Place map_cmdline_to_pid array right after saved_cmdlines */
-	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
-
-	s->cmdline_idx = 0;
-	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
-	       sizeof(s->map_pid_to_cmdline));
-	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
-	       val * sizeof(*s->map_cmdline_to_pid));
-
-	return s;
-}
-
-static int trace_create_savedcmd(void)
-{
-	savedcmd = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
-
-	return savedcmd ? 0 : -ENOMEM;
-}
-
 int is_tracing_stopped(void)
 {
 	return global_trace.stop_count;
@@ -2481,201 +2390,6 @@ void tracing_stop(void)
 	return tracing_stop_tr(&global_trace);
 }
 
-static int trace_save_cmdline(struct task_struct *tsk)
-{
-	unsigned tpid, idx;
-
-	/* treat recording of idle task as a success */
-	if (!tsk->pid)
-		return 1;
-
-	tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
-
-	/*
-	 * It's not the end of the world if we don't get
-	 * the lock, but we also don't want to spin
-	 * nor do we want to disable interrupts,
-	 * so if we miss here, then better luck next time.
-	 *
-	 * This is called within the scheduler and wake up, so interrupts
-	 * had better been disabled and run queue lock been held.
-	 */
-	lockdep_assert_preemption_disabled();
-	if (!arch_spin_trylock(&trace_cmdline_lock))
-		return 0;
-
-	idx = savedcmd->map_pid_to_cmdline[tpid];
-	if (idx == NO_CMDLINE_MAP) {
-		idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;
-
-		savedcmd->map_pid_to_cmdline[tpid] = idx;
-		savedcmd->cmdline_idx = idx;
-	}
-
-	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
-	set_cmdline(idx, tsk->comm);
-
-	arch_spin_unlock(&trace_cmdline_lock);
-
-	return 1;
-}
-
-static void __trace_find_cmdline(int pid, char comm[])
-{
-	unsigned map;
-	int tpid;
-
-	if (!pid) {
-		strcpy(comm, "<idle>");
-		return;
-	}
-
-	if (WARN_ON_ONCE(pid < 0)) {
-		strcpy(comm, "<XXX>");
-		return;
-	}
-
-	tpid = pid & (PID_MAX_DEFAULT - 1);
-	map = savedcmd->map_pid_to_cmdline[tpid];
-	if (map != NO_CMDLINE_MAP) {
-		tpid = savedcmd->map_cmdline_to_pid[map];
-		if (tpid == pid) {
-			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
-			return;
-		}
-	}
-	strcpy(comm, "<...>");
-}
-
-void trace_find_cmdline(int pid, char comm[])
-{
-	preempt_disable();
-	arch_spin_lock(&trace_cmdline_lock);
-
-	__trace_find_cmdline(pid, comm);
-
-	arch_spin_unlock(&trace_cmdline_lock);
-	preempt_enable();
-}
-
-static int *trace_find_tgid_ptr(int pid)
-{
-	/*
-	 * Pairs with the smp_store_release in set_tracer_flag() to ensure that
-	 * if we observe a non-NULL tgid_map then we also observe the correct
-	 * tgid_map_max.
-	 */
-	int *map = smp_load_acquire(&tgid_map);
-
-	if (unlikely(!map || pid > tgid_map_max))
-		return NULL;
-
-	return &map[pid];
-}
-
-int trace_find_tgid(int pid)
-{
-	int *ptr = trace_find_tgid_ptr(pid);
-
-	return ptr ? *ptr : 0;
-}
-
-static int trace_save_tgid(struct task_struct *tsk)
-{
-	int *ptr;
-
-	/* treat recording of idle task as a success */
-	if (!tsk->pid)
-		return 1;
-
-	ptr = trace_find_tgid_ptr(tsk->pid);
-	if (!ptr)
-		return 0;
-
-	*ptr = tsk->tgid;
-	return 1;
-}
-
-static bool tracing_record_taskinfo_skip(int flags)
-{
-	if (unlikely(!(flags & (TRACE_RECORD_CMDLINE | TRACE_RECORD_TGID))))
-		return true;
-	if (!__this_cpu_read(trace_taskinfo_save))
-		return true;
-	return false;
-}
-
-/**
- * tracing_record_taskinfo - record the task info of a task
- *
- * @task:  task to record
- * @flags: TRACE_RECORD_CMDLINE for recording comm
- *         TRACE_RECORD_TGID for recording tgid
- */
-void tracing_record_taskinfo(struct task_struct *task, int flags)
-{
-	bool done;
-
-	if (tracing_record_taskinfo_skip(flags))
-		return;
-
-	/*
-	 * Record as much task information as possible. If some fail, continue
-	 * to try to record the others.
-	 */
-	done = !(flags & TRACE_RECORD_CMDLINE) || trace_save_cmdline(task);
-	done &= !(flags & TRACE_RECORD_TGID) || trace_save_tgid(task);
-
-	/* If recording any information failed, retry again soon. */
-	if (!done)
-		return;
-
-	__this_cpu_write(trace_taskinfo_save, false);
-}
-
-/**
- * tracing_record_taskinfo_sched_switch - record task info for sched_switch
- *
- * @prev: previous task during sched_switch
- * @next: next task during sched_switch
- * @flags: TRACE_RECORD_CMDLINE for recording comm
- *         TRACE_RECORD_TGID for recording tgid
- */
-void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
-					  struct task_struct *next, int flags)
-{
-	bool done;
-
-	if (tracing_record_taskinfo_skip(flags))
-		return;
-
-	/*
-	 * Record as much task information as possible. If some fail, continue
-	 * to try to record the others.
-	 */
-	done  = !(flags & TRACE_RECORD_CMDLINE) || trace_save_cmdline(prev);
-	done &= !(flags & TRACE_RECORD_CMDLINE) || trace_save_cmdline(next);
-	done &= !(flags & TRACE_RECORD_TGID) || trace_save_tgid(prev);
-	done &= !(flags & TRACE_RECORD_TGID) || trace_save_tgid(next);
-
-	/* If recording any information failed, retry again soon. */
-	if (!done)
-		return;
-
-	__this_cpu_write(trace_taskinfo_save, false);
-}
-
-/* Helpers to record a specific task information */
-void tracing_record_cmdline(struct task_struct *task)
-{
-	tracing_record_taskinfo(task, TRACE_RECORD_CMDLINE);
-}
-
-void tracing_record_tgid(struct task_struct *task)
-{
-	tracing_record_taskinfo(task, TRACE_RECORD_TGID);
-}
-
 /*
  * Several functions return TRACE_TYPE_PARTIAL_LINE if the trace_seq
  * overflowed, and TRACE_TYPE_HANDLED otherwise. This helper function
@@ -5432,29 +5146,6 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 	return 0;
 }
 
-static int trace_alloc_tgid_map(void)
-{
-	int *map;
-
-	if (tgid_map)
-		return 0;
-
-	tgid_map_max = pid_max;
-	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
-		       GFP_KERNEL);
-	if (!map)
-		return -ENOMEM;
-
-	/*
-	 * Pairs with smp_load_acquire() in
-	 * trace_find_tgid_ptr() to ensure that if it observes
-	 * the tgid_map we just allocated then it also observes
-	 * the corresponding tgid_map_max value.
-	 */
-	smp_store_release(&tgid_map, map);
-	return 0;
-}
-
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
@@ -5479,6 +5170,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		trace_event_enable_cmd_record(enabled);
 
 	if (mask == TRACE_ITER_RECORD_TGID) {
+
 		if (trace_alloc_tgid_map() < 0) {
 			tr->trace_flags &= ~TRACE_ITER_RECORD_TGID;
 			return -ENOMEM;
@@ -5924,207 +5616,6 @@ static const struct file_operations tracing_readme_fops = {
 	.llseek		= generic_file_llseek,
 };
 
-static void *saved_tgids_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	int pid = ++(*pos);
-
-	return trace_find_tgid_ptr(pid);
-}
-
-static void *saved_tgids_start(struct seq_file *m, loff_t *pos)
-{
-	int pid = *pos;
-
-	return trace_find_tgid_ptr(pid);
-}
-
-static void saved_tgids_stop(struct seq_file *m, void *v)
-{
-}
-
-static int saved_tgids_show(struct seq_file *m, void *v)
-{
-	int *entry = (int *)v;
-	int pid = entry - tgid_map;
-	int tgid = *entry;
-
-	if (tgid == 0)
-		return SEQ_SKIP;
-
-	seq_printf(m, "%d %d\n", pid, tgid);
-	return 0;
-}
-
-static const struct seq_operations tracing_saved_tgids_seq_ops = {
-	.start		= saved_tgids_start,
-	.stop		= saved_tgids_stop,
-	.next		= saved_tgids_next,
-	.show		= saved_tgids_show,
-};
-
-static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
-{
-	int ret;
-
-	ret = tracing_check_open_get_tr(NULL);
-	if (ret)
-		return ret;
-
-	return seq_open(filp, &tracing_saved_tgids_seq_ops);
-}
-
-
-static const struct file_operations tracing_saved_tgids_fops = {
-	.open		= tracing_saved_tgids_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static void *saved_cmdlines_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	unsigned int *ptr = v;
-
-	if (*pos || m->count)
-		ptr++;
-
-	(*pos)++;
-
-	for (; ptr < &savedcmd->map_cmdline_to_pid[savedcmd->cmdline_num];
-	     ptr++) {
-		if (*ptr == -1 || *ptr == NO_CMDLINE_MAP)
-			continue;
-
-		return ptr;
-	}
-
-	return NULL;
-}
-
-static void *saved_cmdlines_start(struct seq_file *m, loff_t *pos)
-{
-	void *v;
-	loff_t l = 0;
-
-	preempt_disable();
-	arch_spin_lock(&trace_cmdline_lock);
-
-	v = &savedcmd->map_cmdline_to_pid[0];
-	while (l <= *pos) {
-		v = saved_cmdlines_next(m, v, &l);
-		if (!v)
-			return NULL;
-	}
-
-	return v;
-}
-
-static void saved_cmdlines_stop(struct seq_file *m, void *v)
-{
-	arch_spin_unlock(&trace_cmdline_lock);
-	preempt_enable();
-}
-
-static int saved_cmdlines_show(struct seq_file *m, void *v)
-{
-	char buf[TASK_COMM_LEN];
-	unsigned int *pid = v;
-
-	__trace_find_cmdline(*pid, buf);
-	seq_printf(m, "%d %s\n", *pid, buf);
-	return 0;
-}
-
-static const struct seq_operations tracing_saved_cmdlines_seq_ops = {
-	.start		= saved_cmdlines_start,
-	.next		= saved_cmdlines_next,
-	.stop		= saved_cmdlines_stop,
-	.show		= saved_cmdlines_show,
-};
-
-static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
-{
-	int ret;
-
-	ret = tracing_check_open_get_tr(NULL);
-	if (ret)
-		return ret;
-
-	return seq_open(filp, &tracing_saved_cmdlines_seq_ops);
-}
-
-static const struct file_operations tracing_saved_cmdlines_fops = {
-	.open		= tracing_saved_cmdlines_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static ssize_t
-tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
-				 size_t cnt, loff_t *ppos)
-{
-	char buf[64];
-	int r;
-
-	preempt_disable();
-	arch_spin_lock(&trace_cmdline_lock);
-	r = scnprintf(buf, sizeof(buf), "%u\n", savedcmd->cmdline_num);
-	arch_spin_unlock(&trace_cmdline_lock);
-	preempt_enable();
-
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
-}
-
-static int tracing_resize_saved_cmdlines(unsigned int val)
-{
-	struct saved_cmdlines_buffer *s, *savedcmd_temp;
-
-	s = allocate_cmdlines_buffer(val);
-	if (!s)
-		return -ENOMEM;
-
-	preempt_disable();
-	arch_spin_lock(&trace_cmdline_lock);
-	savedcmd_temp = savedcmd;
-	savedcmd = s;
-	arch_spin_unlock(&trace_cmdline_lock);
-	preempt_enable();
-	free_saved_cmdlines_buffer(savedcmd_temp);
-
-	return 0;
-}
-
-static ssize_t
-tracing_saved_cmdlines_size_write(struct file *filp, const char __user *ubuf,
-				  size_t cnt, loff_t *ppos)
-{
-	unsigned long val;
-	int ret;
-
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
-	if (ret)
-		return ret;
-
-	/* must have at least 1 entry or less than PID_MAX_DEFAULT */
-	if (!val || val > PID_MAX_DEFAULT)
-		return -EINVAL;
-
-	ret = tracing_resize_saved_cmdlines((unsigned int)val);
-	if (ret < 0)
-		return ret;
-
-	*ppos += cnt;
-
-	return cnt;
-}
-
-static const struct file_operations tracing_saved_cmdlines_size_fops = {
-	.open		= tracing_open_generic,
-	.read		= tracing_saved_cmdlines_size_read,
-	.write		= tracing_saved_cmdlines_size_write,
-};
-
 #ifdef CONFIG_TRACE_EVAL_MAP_FILE
 static union trace_eval_map_item *
 update_eval_map(union trace_eval_map_item *ptr)
@@ -10693,7 +10184,7 @@ __init static int tracer_alloc_buffers(void)
 out_free_pipe_cpumask:
 	free_cpumask_var(global_trace.pipe_cpumask);
 out_free_savedcmd:
-	free_saved_cmdlines_buffer(savedcmd);
+	trace_free_saved_cmdlines_buffer();
 out_free_temp_buffer:
 	ring_buffer_free(temp_buffer);
 out_rm_hp_state:
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 00f873910c5d..e4f0714d7a49 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1375,6 +1375,16 @@ static inline void trace_buffer_unlock_commit(struct trace_array *tr,
 	trace_buffer_unlock_commit_regs(tr, buffer, event, trace_ctx, NULL);
 }
 
+DECLARE_PER_CPU(bool, trace_taskinfo_save);
+int trace_save_cmdline(struct task_struct *tsk);
+int trace_create_savedcmd(void);
+int trace_alloc_tgid_map(void);
+void trace_free_saved_cmdlines_buffer(void);
+
+extern const struct file_operations tracing_saved_cmdlines_fops;
+extern const struct file_operations tracing_saved_tgids_fops;
+extern const struct file_operations tracing_saved_cmdlines_size_fops;
+
 DECLARE_PER_CPU(struct ring_buffer_event *, trace_buffered_event);
 DECLARE_PER_CPU(int, trace_buffered_event_cnt);
 void trace_buffered_event_disable(void);
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index c9ffdcfe622e..8a407adb0e1c 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/uaccess.h>
+#include <linux/kmemleak.h>
 #include <linux/ftrace.h>
 #include <trace/events/sched.h>
 
@@ -148,3 +149,517 @@ void tracing_stop_tgid_record(void)
 {
 	tracing_stop_sched_switch(RECORD_TGID);
 }
+
+/*
+ * The tgid_map array maps from pid to tgid; i.e. the value stored at index i
+ * is the tgid last observed corresponding to pid=i.
+ */
+static int *tgid_map;
+
+/* The maximum valid index into tgid_map. */
+static size_t tgid_map_max;
+
+#define SAVED_CMDLINES_DEFAULT 128
+#define NO_CMDLINE_MAP UINT_MAX
+/*
+ * Preemption must be disabled before acquiring trace_cmdline_lock.
+ * The various trace_arrays' max_lock must be acquired in a context
+ * where interrupt is disabled.
+ */
+static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+struct saved_cmdlines_buffer {
+	unsigned map_pid_to_cmdline[PID_MAX_DEFAULT+1];
+	unsigned *map_cmdline_to_pid;
+	unsigned cmdline_num;
+	int cmdline_idx;
+	char saved_cmdlines[];
+};
+static struct saved_cmdlines_buffer *savedcmd;
+
+/* Holds the size of a cmdline and pid element */
+#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
+	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
+
+static inline char *get_saved_cmdlines(int idx)
+{
+	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
+}
+
+static inline void set_cmdline(int idx, const char *cmdline)
+{
+	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+}
+
+static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
+{
+	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
+
+	kmemleak_free(s);
+	free_pages((unsigned long)s, order);
+}
+
+static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
+{
+	struct saved_cmdlines_buffer *s;
+	struct page *page;
+	int orig_size, size;
+	int order;
+
+	/* Figure out how much is needed to hold the given number of cmdlines */
+	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
+	order = get_order(orig_size);
+	size = 1 << (order + PAGE_SHIFT);
+	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		return NULL;
+
+	s = page_address(page);
+	kmemleak_alloc(s, size, 1, GFP_KERNEL);
+	memset(s, 0, sizeof(*s));
+
+	/* Round up to actual allocation */
+	val = (size - sizeof(*s)) / SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
+	s->cmdline_num = val;
+
+	/* Place map_cmdline_to_pid array right after saved_cmdlines */
+	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
+
+	s->cmdline_idx = 0;
+	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
+	       sizeof(s->map_pid_to_cmdline));
+	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
+	       val * sizeof(*s->map_cmdline_to_pid));
+
+	return s;
+}
+
+int trace_create_savedcmd(void)
+{
+	savedcmd = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
+
+	return savedcmd ? 0 : -ENOMEM;
+}
+
+int trace_save_cmdline(struct task_struct *tsk)
+{
+	unsigned tpid, idx;
+
+	/* treat recording of idle task as a success */
+	if (!tsk->pid)
+		return 1;
+
+	tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
+
+	/*
+	 * It's not the end of the world if we don't get
+	 * the lock, but we also don't want to spin
+	 * nor do we want to disable interrupts,
+	 * so if we miss here, then better luck next time.
+	 *
+	 * This is called within the scheduler and wake up, so interrupts
+	 * had better been disabled and run queue lock been held.
+	 */
+	lockdep_assert_preemption_disabled();
+	if (!arch_spin_trylock(&trace_cmdline_lock))
+		return 0;
+
+	idx = savedcmd->map_pid_to_cmdline[tpid];
+	if (idx == NO_CMDLINE_MAP) {
+		idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;
+
+		savedcmd->map_pid_to_cmdline[tpid] = idx;
+		savedcmd->cmdline_idx = idx;
+	}
+
+	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
+	set_cmdline(idx, tsk->comm);
+
+	arch_spin_unlock(&trace_cmdline_lock);
+
+	return 1;
+}
+
+static void __trace_find_cmdline(int pid, char comm[])
+{
+	unsigned map;
+	int tpid;
+
+	if (!pid) {
+		strcpy(comm, "<idle>");
+		return;
+	}
+
+	if (WARN_ON_ONCE(pid < 0)) {
+		strcpy(comm, "<XXX>");
+		return;
+	}
+
+	tpid = pid & (PID_MAX_DEFAULT - 1);
+	map = savedcmd->map_pid_to_cmdline[tpid];
+	if (map != NO_CMDLINE_MAP) {
+		tpid = savedcmd->map_cmdline_to_pid[map];
+		if (tpid == pid) {
+			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
+			return;
+		}
+	}
+	strcpy(comm, "<...>");
+}
+
+void trace_find_cmdline(int pid, char comm[])
+{
+	preempt_disable();
+	arch_spin_lock(&trace_cmdline_lock);
+
+	__trace_find_cmdline(pid, comm);
+
+	arch_spin_unlock(&trace_cmdline_lock);
+	preempt_enable();
+}
+
+static int *trace_find_tgid_ptr(int pid)
+{
+	/*
+	 * Pairs with the smp_store_release in set_tracer_flag() to ensure that
+	 * if we observe a non-NULL tgid_map then we also observe the correct
+	 * tgid_map_max.
+	 */
+	int *map = smp_load_acquire(&tgid_map);
+
+	if (unlikely(!map || pid > tgid_map_max))
+		return NULL;
+
+	return &map[pid];
+}
+
+int trace_find_tgid(int pid)
+{
+	int *ptr = trace_find_tgid_ptr(pid);
+
+	return ptr ? *ptr : 0;
+}
+
+static int trace_save_tgid(struct task_struct *tsk)
+{
+	int *ptr;
+
+	/* treat recording of idle task as a success */
+	if (!tsk->pid)
+		return 1;
+
+	ptr = trace_find_tgid_ptr(tsk->pid);
+	if (!ptr)
+		return 0;
+
+	*ptr = tsk->tgid;
+	return 1;
+}
+
+static bool tracing_record_taskinfo_skip(int flags)
+{
+	if (unlikely(!(flags & (TRACE_RECORD_CMDLINE | TRACE_RECORD_TGID))))
+		return true;
+	if (!__this_cpu_read(trace_taskinfo_save))
+		return true;
+	return false;
+}
+
+/**
+ * tracing_record_taskinfo - record the task info of a task
+ *
+ * @task:  task to record
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
+ */
+void tracing_record_taskinfo(struct task_struct *task, int flags)
+{
+	bool done;
+
+	if (tracing_record_taskinfo_skip(flags))
+		return;
+
+	/*
+	 * Record as much task information as possible. If some fail, continue
+	 * to try to record the others.
+	 */
+	done = !(flags & TRACE_RECORD_CMDLINE) || trace_save_cmdline(task);
+	done &= !(flags & TRACE_RECORD_TGID) || trace_save_tgid(task);
+
+	/* If recording any information failed, retry again soon. */
+	if (!done)
+		return;
+
+	__this_cpu_write(trace_taskinfo_save, false);
+}
+
+/**
+ * tracing_record_taskinfo_sched_switch - record task info for sched_switch
+ *
+ * @prev: previous task during sched_switch
+ * @next: next task during sched_switch
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
+ */
+void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
+					  struct task_struct *next, int flags)
+{
+	bool done;
+
+	if (tracing_record_taskinfo_skip(flags))
+		return;
+
+	/*
+	 * Record as much task information as possible. If some fail, continue
+	 * to try to record the others.
+	 */
+	done  = !(flags & TRACE_RECORD_CMDLINE) || trace_save_cmdline(prev);
+	done &= !(flags & TRACE_RECORD_CMDLINE) || trace_save_cmdline(next);
+	done &= !(flags & TRACE_RECORD_TGID) || trace_save_tgid(prev);
+	done &= !(flags & TRACE_RECORD_TGID) || trace_save_tgid(next);
+
+	/* If recording any information failed, retry again soon. */
+	if (!done)
+		return;
+
+	__this_cpu_write(trace_taskinfo_save, false);
+}
+
+/* Helpers to record a specific task information */
+void tracing_record_cmdline(struct task_struct *task)
+{
+	tracing_record_taskinfo(task, TRACE_RECORD_CMDLINE);
+}
+
+void tracing_record_tgid(struct task_struct *task)
+{
+	tracing_record_taskinfo(task, TRACE_RECORD_TGID);
+}
+
+int trace_alloc_tgid_map(void)
+{
+	int *map;
+
+	if (tgid_map)
+		return 0;
+
+	tgid_map_max = pid_max;
+	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
+		       GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	/*
+	 * Pairs with smp_load_acquire() in
+	 * trace_find_tgid_ptr() to ensure that if it observes
+	 * the tgid_map we just allocated then it also observes
+	 * the corresponding tgid_map_max value.
+	 */
+	smp_store_release(&tgid_map, map);
+	return 0;
+}
+
+static void *saved_tgids_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	int pid = ++(*pos);
+
+	return trace_find_tgid_ptr(pid);
+}
+
+static void *saved_tgids_start(struct seq_file *m, loff_t *pos)
+{
+	int pid = *pos;
+
+	return trace_find_tgid_ptr(pid);
+}
+
+static void saved_tgids_stop(struct seq_file *m, void *v)
+{
+}
+
+static int saved_tgids_show(struct seq_file *m, void *v)
+{
+	int *entry = (int *)v;
+	int pid = entry - tgid_map;
+	int tgid = *entry;
+
+	if (tgid == 0)
+		return SEQ_SKIP;
+
+	seq_printf(m, "%d %d\n", pid, tgid);
+	return 0;
+}
+
+static const struct seq_operations tracing_saved_tgids_seq_ops = {
+	.start		= saved_tgids_start,
+	.stop		= saved_tgids_stop,
+	.next		= saved_tgids_next,
+	.show		= saved_tgids_show,
+};
+
+static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
+
+	return seq_open(filp, &tracing_saved_tgids_seq_ops);
+}
+
+
+const struct file_operations tracing_saved_tgids_fops = {
+	.open		= tracing_saved_tgids_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static void *saved_cmdlines_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	unsigned int *ptr = v;
+
+	if (*pos || m->count)
+		ptr++;
+
+	(*pos)++;
+
+	for (; ptr < &savedcmd->map_cmdline_to_pid[savedcmd->cmdline_num];
+	     ptr++) {
+		if (*ptr == -1 || *ptr == NO_CMDLINE_MAP)
+			continue;
+
+		return ptr;
+	}
+
+	return NULL;
+}
+
+static void *saved_cmdlines_start(struct seq_file *m, loff_t *pos)
+{
+	void *v;
+	loff_t l = 0;
+
+	preempt_disable();
+	arch_spin_lock(&trace_cmdline_lock);
+
+	v = &savedcmd->map_cmdline_to_pid[0];
+	while (l <= *pos) {
+		v = saved_cmdlines_next(m, v, &l);
+		if (!v)
+			return NULL;
+	}
+
+	return v;
+}
+
+static void saved_cmdlines_stop(struct seq_file *m, void *v)
+{
+	arch_spin_unlock(&trace_cmdline_lock);
+	preempt_enable();
+}
+
+static int saved_cmdlines_show(struct seq_file *m, void *v)
+{
+	char buf[TASK_COMM_LEN];
+	unsigned int *pid = v;
+
+	__trace_find_cmdline(*pid, buf);
+	seq_printf(m, "%d %s\n", *pid, buf);
+	return 0;
+}
+
+static const struct seq_operations tracing_saved_cmdlines_seq_ops = {
+	.start		= saved_cmdlines_start,
+	.next		= saved_cmdlines_next,
+	.stop		= saved_cmdlines_stop,
+	.show		= saved_cmdlines_show,
+};
+
+static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+
+	ret = tracing_check_open_get_tr(NULL);
+	if (ret)
+		return ret;
+
+	return seq_open(filp, &tracing_saved_cmdlines_seq_ops);
+}
+
+const struct file_operations tracing_saved_cmdlines_fops = {
+	.open		= tracing_saved_cmdlines_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static ssize_t
+tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
+				 size_t cnt, loff_t *ppos)
+{
+	char buf[64];
+	int r;
+
+	preempt_disable();
+	arch_spin_lock(&trace_cmdline_lock);
+	r = scnprintf(buf, sizeof(buf), "%u\n", savedcmd->cmdline_num);
+	arch_spin_unlock(&trace_cmdline_lock);
+	preempt_enable();
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+void trace_free_saved_cmdlines_buffer(void)
+{
+	free_saved_cmdlines_buffer(savedcmd);
+}
+
+static int tracing_resize_saved_cmdlines(unsigned int val)
+{
+	struct saved_cmdlines_buffer *s, *savedcmd_temp;
+
+	s = allocate_cmdlines_buffer(val);
+	if (!s)
+		return -ENOMEM;
+
+	preempt_disable();
+	arch_spin_lock(&trace_cmdline_lock);
+	savedcmd_temp = savedcmd;
+	savedcmd = s;
+	arch_spin_unlock(&trace_cmdline_lock);
+	preempt_enable();
+	free_saved_cmdlines_buffer(savedcmd_temp);
+
+	return 0;
+}
+
+static ssize_t
+tracing_saved_cmdlines_size_write(struct file *filp, const char __user *ubuf,
+				  size_t cnt, loff_t *ppos)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	/* must have at least 1 entry or less than PID_MAX_DEFAULT */
+	if (!val || val > PID_MAX_DEFAULT)
+		return -EINVAL;
+
+	ret = tracing_resize_saved_cmdlines((unsigned int)val);
+	if (ret < 0)
+		return ret;
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
+const struct file_operations tracing_saved_cmdlines_size_fops = {
+	.open		= tracing_open_generic,
+	.read		= tracing_saved_cmdlines_size_read,
+	.write		= tracing_saved_cmdlines_size_write,
+};
-- 
2.43.0



