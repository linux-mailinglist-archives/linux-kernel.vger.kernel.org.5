Return-Path: <linux-kernel+bounces-49441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58321846A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7971C29F56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347718EAD;
	Fri,  2 Feb 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaD4K5vu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79918AEE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861449; cv=none; b=mchae6UVb09j9/DrSfksCbRbuTm33GYoYrhFbn4n/Kp9brXXvEMEIYUIc4OqgyAWJEJeDpfSTeXHZofwT53C2E75Rfu0nz5UUujKWqnP+/o1oeeCN2erXvZH4CIEZS6Uhidt4AqrBWp3n+qSgPGS1DrpvPzKeK32ldK99ra1gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861449; c=relaxed/simple;
	bh=XvGrGNouSr+0XomitksSmtHJyT2Bn0wbu87wMiy9Dy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRtJoSW8vwiF1oGErbLJCC8KB9qJhfSwklr9LCvSpSClSze1Kpmw1xhFD9jsogqJyzTSVjC7A8E0XxIQ2Eug6IsNnbopeRwsp/T8TpNNQzYw+je1RfinbXbNiC8idgWRw2kfNYz/LwlN/ZEfo4/JNJ5/XAtYyZgs3k8xONcT/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaD4K5vu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706861445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCgceAE8jBD2WohfFUuNrr+O/9K6+IZGaVDTilf9JRw=;
	b=SaD4K5vupbXwYT4BtFqvofZeVGIyvUNaM5hDA+KDghMl0zNfyC/pyl3aWcEmHOB3ef/laT
	bcFD1VbRjRIoIWWI+DI9jB24gSpGQDppiHlbTrzAcV7IKcWrG0o/9gSXtm2AS7HLzlM49y
	apv4Tgn41Ysn4N5rk65Yuo2DoneIomc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-dtpG1UN6MtqxFsoNZDIZvg-1; Fri, 02 Feb 2024 03:10:40 -0500
X-MC-Unique: dtpG1UN6MtqxFsoNZDIZvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCF6A185A780;
	Fri,  2 Feb 2024 08:10:39 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04626C2590D;
	Fri,  2 Feb 2024 08:10:36 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Segall <bsegall@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH v2 1/5] sched/fair: Only throttle CFS tasks on return to userspace
Date: Fri,  2 Feb 2024 09:09:16 +0100
Message-ID: <20240202080920.3337862-2-vschneid@redhat.com>
In-Reply-To: <20240202080920.3337862-1-vschneid@redhat.com>
References: <20240202080920.3337862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Benjamin Segall <bsegall@google.com>

The basic idea of this implementation is to maintain duplicate runqueues
in each cfs_rq that contain duplicate pointers to sched_entitys which
should bypass throttling. Then we can skip throttling cfs_rqs that have
any such children, and when we pick inside any not-actually-throttled
cfs_rq, we only look at this duplicated list.

"Which tasks should bypass throttling" here is "all schedule() calls
that don't set a special flag", but could instead involve the lockdep
markers (except for the problem of percpu-rwsem and similar) or explicit
flags around syscalls and faults, or something else.

This approach avoids any O(tasks) loops, but leaves partially-throttled
cfs_rqs still contributing their full h_nr_running to their parents,
which might result in worse balancing. Also it adds more (generally
still small) overhead to the common enqueue/dequeue/pick paths.

The very basic debug test added is to run a cpusoaker and "cat
/sys/kernel/debug/sched_locked_spin" pinned to the same cpu in the same
cgroup with a quota < 1 cpu.

Not-signed-off-by: Benjamin Segall <bsegall@google.com>
[Slight comment / naming changes]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched.h |   7 ++
 kernel/entry/common.c |   2 +-
 kernel/entry/kvm.c    |   2 +-
 kernel/sched/core.c   |  20 ++++
 kernel/sched/debug.c  |  28 +++++
 kernel/sched/fair.c   | 232 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |   3 +
 7 files changed, 281 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03bfe9ab29511..4a0105d1eaa21 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -303,6 +303,7 @@ extern long schedule_timeout_killable(long timeout);
 extern long schedule_timeout_uninterruptible(long timeout);
 extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
+asmlinkage void schedule_usermode(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
 #ifdef CONFIG_PREEMPT_RT
@@ -553,6 +554,9 @@ struct sched_entity {
 	struct cfs_rq			*my_q;
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct list_head		kernel_node;
+#endif
 #endif
 
 #ifdef CONFIG_SMP
@@ -1539,6 +1543,9 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	atomic_t			in_return_to_user;
+#endif
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba3..16b5432a62c6f 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -156,7 +156,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		local_irq_enable_exit_to_user(ti_work);
 
 		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+			schedule_usermode(); /* TODO: also all of the arch/ loops that don't use this yet */
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd1..fc4b73de07539 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -14,7 +14,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		}
 
 		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+			schedule_usermode();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			resume_user_mode_work(NULL);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index db4be4921e7f0..a7c028fad5a89 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4529,6 +4529,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&p->se.kernel_node);
+	atomic_set(&p->in_return_to_user, 0);
+#endif
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
@@ -6818,6 +6822,22 @@ asmlinkage __visible void __sched schedule(void)
 }
 EXPORT_SYMBOL(schedule);
 
+asmlinkage __visible void __sched schedule_usermode(void)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	/*
+	 * This is only atomic because of this simple implementation. We could
+	 * do something with an SM_USER to avoid other-cpu scheduler operations
+	 * racing against these writes.
+	 */
+	atomic_set(&current->in_return_to_user, true);
+	schedule();
+	atomic_set(&current->in_return_to_user, false);
+#else
+	schedule();
+#endif
+}
+
 /*
  * synchronize_rcu_tasks() makes sure that no task is stuck in preempted
  * state (have scheduled out non-voluntarily) by making sure that all
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834df..4a89dbc3ddfcd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -319,6 +319,32 @@ static const struct file_operations sched_verbose_fops = {
 	.llseek =       default_llseek,
 };
 
+static DEFINE_MUTEX(sched_debug_spin_mutex);
+static int sched_debug_spin_show(struct seq_file *m, void *v) {
+	int count;
+	mutex_lock(&sched_debug_spin_mutex);
+	for (count = 0; count < 1000; count++) {
+		u64 start2;
+		start2 = jiffies;
+		while (jiffies == start2)
+			cpu_relax();
+		schedule();
+	}
+	mutex_unlock(&sched_debug_spin_mutex);
+	return 0;
+}
+static int sched_debug_spin_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_debug_spin_show, NULL);
+}
+
+static const struct file_operations sched_debug_spin_fops = {
+	.open		= sched_debug_spin_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static const struct seq_operations sched_debug_sops;
 
 static int sched_debug_open(struct inode *inode, struct file *filp)
@@ -374,6 +400,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_create_file("sched_locked_spin", 0444, NULL, NULL,
+			    &sched_debug_spin_fops);
 	return 0;
 }
 late_initcall(sched_init_debug);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b803030c3a037..a1808459a5acc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -128,6 +128,7 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: 5 msec, units: microseconds)
  */
 static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+static unsigned int sysctl_sched_cfs_bandwidth_kernel_bypass	= 1;
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -146,6 +147,15 @@ static struct ctl_table sched_fair_sysctls[] = {
 		.proc_handler   = proc_dointvec_minmax,
 		.extra1         = SYSCTL_ONE,
 	},
+	{
+		.procname       = "sched_cfs_bandwidth_kernel_bypass",
+		.data           = &sysctl_sched_cfs_bandwidth_kernel_bypass,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	{
@@ -5445,14 +5455,34 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 /*
  * Pick the next process, keeping these things in mind, in this order:
- * 1) keep things fair between processes/task groups
- * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
+ * 1) If we're inside a throttled cfs_rq, only pick threads in the kernel
+ * 2) keep things fair between processes/task groups
+ * 3) pick the "next" process, since someone really wants that to run
+ * 4) pick the "last" process, for cache locality
+ * 5) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq)
+pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
 {
+#ifdef CONFIG_CFS_BANDWIDTH
+	/*
+	 * TODO: This might trigger, I'm not sure/don't remember. Regardless,
+	 * while we do not explicitly handle the case where h_kernel_running
+	 * goes to 0, we will call account/check_cfs_rq_runtime at worst in
+	 * entity_tick and notice that we can now properly do the full
+	 * throttle_cfs_rq.
+	 */
+	WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));
+	if (throttled && !list_empty(&cfs_rq->kernel_children)) {
+		/*
+		 * TODO: you'd want to factor out pick_eevdf to just take
+		 * tasks_timeline, and replace this list with a second rbtree
+		 * and a call to pick_eevdf.
+		 */
+		return list_first_entry(&cfs_rq->kernel_children,
+					struct sched_entity, kernel_node);
+	}
+#endif
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
@@ -5651,8 +5681,14 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
+	 *
+	 * Don't resched_curr() if curr is in the kernel. We won't throttle the
+	 * cfs_rq if any task is in the kernel, and if curr in particular is we
+	 * don't need to preempt it in favor of whatever other task is in the
+	 * kernel.
 	 */
-	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
+	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr) &&
+	    list_empty(&rq_of(cfs_rq)->curr->se.kernel_node))
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -5741,12 +5777,22 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	return 0;
 }
 
+static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
+static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count);
+
 static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, kernel_delta, dequeue = 1;
+
+	/*
+	 * We don't actually throttle, though account() will have made sure to
+	 * resched us so that we pick into a kernel task.
+	 */
+	if (cfs_rq->h_kernel_running)
+		return false;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5778,6 +5824,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	kernel_delta = cfs_rq->h_kernel_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -5791,6 +5838,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		dequeue_kernel(qcfs_rq, se, kernel_delta);
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5813,6 +5861,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+		dequeue_kernel(qcfs_rq, se, kernel_delta);
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5835,7 +5884,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
+	long task_delta, idle_task_delta, kernel_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -5870,6 +5919,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
+	kernel_delta = cfs_rq->h_kernel_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -5882,6 +5932,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		enqueue_kernel(qcfs_rq, se, kernel_delta);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -5899,6 +5950,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
+		enqueue_kernel(qcfs_rq, se, kernel_delta);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6557,6 +6609,86 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 }
 #endif
 
+/*
+ * We keep track of all children that are runnable in the kernel with a count of
+ * all descendants. The state is checked on enqueue and put_prev (and hard
+ * cleared on dequeue), and is stored just as the filled/empty state of the
+ * kernel_node list entry.
+ *
+ * These are simple helpers that do both parts, and should be called bottom-up
+ * until hitting a throttled cfs_rq whenever a task changes state (or a cfs_rq
+ * is (un)throttled).
+ */
+static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count)
+{
+	if (count == 0)
+		return;
+
+	if (list_empty(&se->kernel_node))
+		list_add(&se->kernel_node, &cfs_rq->kernel_children);
+	cfs_rq->h_kernel_running += count;
+}
+
+static bool is_kernel_task(struct task_struct *p)
+{
+	return sysctl_sched_cfs_bandwidth_kernel_bypass && !atomic_read(&p->in_return_to_user);
+}
+
+/*
+ * When called on a task this always transitions it to a !kernel state.
+ *
+ * When called on a group it is just synchronizing the state with the new
+ * h_kernel_waiters, unless this it has been throttled and is !on_rq
+ */
+static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count)
+{
+	if (count == 0)
+		return;
+
+	if (!se->on_rq || entity_is_task(se) ||
+	    !group_cfs_rq(se)->h_kernel_running)
+		list_del_init(&se->kernel_node);
+	cfs_rq->h_kernel_running -= count;
+}
+
+/*
+ * Returns if the cfs_rq "should" be throttled but might not be because of
+ * kernel threads bypassing throttle.
+ */
+static bool cfs_rq_throttled_loose(struct cfs_rq *cfs_rq)
+{
+	if (!cfs_bandwidth_used())
+		return false;
+
+	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
+		return false;
+	return true;
+}
+
+static void unthrottle_on_enqueue(struct task_struct *p)
+{
+	struct sched_entity *se = &p->se;
+
+	if (!cfs_bandwidth_used() || !sysctl_sched_cfs_bandwidth_kernel_bypass)
+		return;
+	if (!cfs_rq_of(&p->se)->throttle_count)
+		return;
+
+	/*
+	 * MAYBE TODO: doing it this simple way is O(throttle_count *
+	 * cgroup_depth). We could optimize that into a single pass, but making
+	 * a mostly-copy of unthrottle_cfs_rq that does that is a pain and easy
+	 * to get wrong. (And even without unthrottle_on_enqueue it's O(nm),
+	 * just not while holding rq->lock the whole time)
+	 */
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		if (cfs_rq->throttled)
+			unthrottle_cfs_rq(cfs_rq);
+	}
+}
+
 #else /* CONFIG_CFS_BANDWIDTH */
 
 static inline bool cfs_bandwidth_used(void)
@@ -6604,6 +6736,16 @@ bool cfs_task_bw_constrained(struct task_struct *p)
 	return false;
 }
 #endif
+static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count) {}
+static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int count) {}
+static inline bool is_kernel_task(struct task_struct *p)
+{
+	return false;
+}
+static bool cfs_rq_throttled_loose(struct cfs_rq *cfs_rq)
+{
+	return false;
+}
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #if !defined(CONFIG_CFS_BANDWIDTH) || !defined(CONFIG_NO_HZ_FULL)
@@ -6707,6 +6849,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	bool kernel_task = is_kernel_task(p);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6735,6 +6878,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			enqueue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6755,6 +6900,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			enqueue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6785,6 +6932,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
+
+	if (kernel_task)
+		unthrottle_on_enqueue(p);
 }
 
 static void set_next_buddy(struct sched_entity *se);
@@ -6801,6 +6951,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
+	bool kernel_task = !list_empty(&p->se.kernel_node);
 
 	util_est_dequeue(&rq->cfs, p);
 
@@ -6813,6 +6964,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			dequeue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6845,6 +6998,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
+		if (kernel_task)
+			dequeue_kernel(cfs_rq, se, 1);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -8343,11 +8498,40 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	resched_curr(rq);
 }
 
+static void handle_kernel_task_prev(struct task_struct *prev)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct sched_entity *se = &prev->se;
+	bool p_in_kernel = is_kernel_task(prev);
+	bool p_in_kernel_tree = !list_empty(&se->kernel_node);
+	/*
+	 * These extra loops are bad and against the whole point of the merged
+	 * PNT, but it's a pain to merge, particularly since we want it to occur
+	 * before check_cfs_runtime().
+	 */
+	if (p_in_kernel_tree && !p_in_kernel) {
+		WARN_ON_ONCE(!se->on_rq); /* dequeue should have removed us */
+		for_each_sched_entity(se) {
+			dequeue_kernel(cfs_rq_of(se), se, 1);
+			if (cfs_rq_throttled(cfs_rq_of(se)))
+				break;
+		}
+	} else if (!p_in_kernel_tree && p_in_kernel && se->on_rq) {
+		for_each_sched_entity(se) {
+			enqueue_kernel(cfs_rq_of(se), se, 1);
+			if (cfs_rq_throttled(cfs_rq_of(se)))
+				break;
+		}
+	}
+#endif
+}
+
 #ifdef CONFIG_SMP
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
+	bool throttled = false;
 
 again:
 	cfs_rq = &rq->cfs;
@@ -8368,7 +8552,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 				goto again;
 		}
 
-		se = pick_next_entity(cfs_rq);
+		if (cfs_rq_throttled_loose(cfs_rq))
+			throttled = true;
+
+		se = pick_next_entity(cfs_rq, throttled);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8383,6 +8570,14 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
+	bool throttled;
+
+	/*
+	 * We want to handle this before check_cfs_runtime(prev). We'll
+	 * duplicate a little work in the goto simple case, but that's fine
+	 */
+	if (prev)
+		handle_kernel_task_prev(prev);
 
 again:
 	if (!sched_fair_runnable(rq))
@@ -8400,6 +8595,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	 * hierarchy, only change the part that actually changes.
 	 */
 
+	throttled = false;
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
@@ -8431,7 +8627,10 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			}
 		}
 
-		se = pick_next_entity(cfs_rq);
+		if (cfs_rq_throttled_loose(cfs_rq))
+			throttled = true;
+
+		se = pick_next_entity(cfs_rq, throttled);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8469,8 +8668,11 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	if (prev)
 		put_prev_task(rq, prev);
 
+	throttled = false;
 	do {
-		se = pick_next_entity(cfs_rq);
+		if (cfs_rq_throttled_loose(cfs_rq))
+			throttled = true;
+		se = pick_next_entity(cfs_rq, throttled);
 		set_next_entity(cfs_rq, se);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
@@ -8534,6 +8736,8 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev)
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
 
+	handle_kernel_task_prev(prev);
+
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
@@ -12818,6 +13022,9 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&cfs_rq->kernel_children);
+#endif
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -12970,6 +13177,9 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&se->kernel_node);
+#endif
 }
 
 static DEFINE_MUTEX(shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77de..0b33ce2e60555 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -580,6 +580,7 @@ struct cfs_rq {
 
 	struct rb_root_cached	tasks_timeline;
 
+
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
 	 * It is set to NULL otherwise (i.e when none are currently running).
@@ -658,8 +659,10 @@ struct cfs_rq {
 	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
+	int			h_kernel_running;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head	kernel_children;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
-- 
2.43.0


