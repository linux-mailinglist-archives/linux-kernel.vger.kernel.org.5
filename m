Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8652580E051
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjLLAcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345472AbjLLAbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:55 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915CA7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:59 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35e70495835so15609435ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341118; x=1702945918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vFhZEBnSX7P03wenRqNCN6oXasaFa4ZGXtqw+9S9fs=;
        b=YhR7UBn2zZwICBZYskVLkAGikjYPZPUGDdcglT35VHhEBh+iwd3pDC/HyeI0nsMdZm
         lmGL1yu/j5O8ULg3InPE/19H9z3Kp2rFi0q+Q3p8JqRh/R82mt6xzgUu5rNLrzWOXVI8
         aUS0sQ9YdU73Mr+FUY1ZRnZ1FDoYiOx95XABFqhyhW65f1ideBAOz3CVNjfzVhP7xSGD
         w+Grn0GCM1hY0GuSF8cgew/d5K6KN32lD/D8uIiMYG8EWE1s2Ssuc0bBcnnkVQxgxq11
         QKUF/8G75B52bUiiEkdYC5/qXArtO0V5XR0PfokxJ8cJx0KzaujL72WGtaIHiPGp1Zfc
         +9oA==
X-Gm-Message-State: AOJu0YzDwn13BGpK1qGYbRNCU1x8KdYTP9o26oY5HgTCfzdQs8k13Mze
        fn/lzTAvA2g7/bimcxhnIoqBIwLpOQ2KwHDi
X-Google-Smtp-Source: AGHT+IFeDK8aUQlvRjz8G1ITD65evFcsvCVZs+B9XIV6EW80YJ6/+JMNvn8bcabrz3HsDy4KQkoH2g==
X-Received: by 2002:a05:6e02:1a89:b0:35d:6a7d:a675 with SMTP id k9-20020a056e021a8900b0035d6a7da675mr8447568ilv.15.1702341117882;
        Mon, 11 Dec 2023 16:31:57 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id x10-20020a02970a000000b00468ea2264e1sm2076301jai.73.2023.12.11.16.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:57 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 6/8] sched: Implement shared runqueue in fair.c
Date:   Mon, 11 Dec 2023 18:31:39 -0600
Message-ID: <20231212003141.216236-7-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231212003141.216236-1-void@manifault.com>
References: <20231212003141.216236-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overview
========

The scheduler must constantly strike a balance between work
conservation, and avoiding costly migrations which harm performance due
to e.g. decreased cache locality. The matter is further complicated by
the topology of the system. Migrating a task between cores on the same
LLC may be more optimal than keeping a task local to the CPU, whereas
migrating a task between LLCs or NUMA nodes may tip the balance in the
other direction.

With that in mind, while CFS is by and large mostly a work conserving
scheduler, there are certain instances where the scheduler will choose
to keep a task local to a CPU, when it would have been more optimal to
migrate it to an idle core.

An example of such a workload is the HHVM / web workload at Meta. HHVM
is a VM that JITs Hack and PHP code in service of web requests. Like
other JIT / compilation workloads, it tends to be heavily CPU bound, and
exhibit generally poor cache locality. To try and address this, we set
several debugfs (/sys/kernel/debug/sched) knobs on our HHVM workloads:

- migration_cost_ns -> 0
- latency_ns -> 20000000
- min_granularity_ns -> 10000000
- wakeup_granularity_ns -> 12000000

These knobs are intended both to encourage the scheduler to be as work
conserving as possible (migration_cost_ns -> 0), and also to keep tasks
running for relatively long time slices so as to avoid the overhead of
context switching (the other knobs). Collectively, these knobs provide a
substantial performance win; resulting in roughly a 20% improvement in
throughput. Worth noting, however, is that this improvement is _not_ at
full machine saturation.

That said, even with these knobs, we noticed that CPUs were still going
idle even when the host was overcommitted. In response, we wrote the
"shared runqueue" (SHARED_RUNQ) feature proposed in this patch set. The
idea behind SHARED_RUNQ is simple: it enables the scheduler to be more
aggressively work conserving by placing a waking task into a sharded
per-LLC FIFO queue that can be pulled from by another core in the LLC
FIFO queue which can then be pulled from before it goes idle.

With this simple change, we were able to achieve a 1 - 1.6% improvement
in throughput, as well as a small, consistent improvement in p95 and p99
latencies, in HHVM. These performance improvements were in addition to
the wins from the debugfs knobs mentioned above, and to other benchmarks
outlined below in the Results section.

Design
======

Note that the design described here reflects sharding, which will be
added in a subsequent patch. The design is described that way in this
commit summary as the benchmarks described in the results section below
all include sharded SHARED_RUNQ. The patches are not combined into one
to ease the burden of review.

The design of SHARED_RUNQ is quite simple. A shared_runq is simply a
list of struct shared_runq_shard objects, which itself is simply a
struct list_head of tasks, and a spinlock:

struct shared_runq_shard {
	struct list_head list;
	raw_spinlock_t lock;
} ____cacheline_aligned;

struct shared_runq {
	u32 num_shards;
	struct shared_runq_shard shards[];
} ____cacheline_aligned;

We create a struct shared_runq per LLC, ensuring they're in their own
cachelines to avoid false sharing between CPUs on different LLCs, and we
create a number of struct shared_runq_shard objects that are housed
there.

When a task first wakes up, it enqueues itself in the shared_runq_shard
of its current LLC at the end of enqueue_task_fair(). Enqueues only
happen if the task was not manually migrated to the current core by
select_task_rq(), and is not pinned to a specific CPU.

A core will pull a task from the shards in its LLC's shared_runq at the
beginning of newidle_balance().

Difference between SHARED_RUNQ and SIS_NODE
===========================================

In [0] Peter proposed a patch that addresses Tejun's observations that
when workqueues are targeted towards a specific LLC on his Zen2 machine
with small CCXs, that there would be significant idle time due to
select_idle_sibling() not considering anything outside of the current
LLC.

This patch (SIS_NODE) is essentially the complement to the proposal
here. SID_NODE causes waking tasks to look for idle cores in neighboring
LLCs on the same die, whereas SHARED_RUNQ causes cores about to go idle
to look for enqueued tasks. That said, in its current form, the two
features at are a different scope as SIS_NODE searches for idle cores
between LLCs, while SHARED_RUNQ enqueues tasks within a single LLC.

The patch was since removed in [1], and we compared the results to
shared_Runq (previously called "swqueue") in [2]. SIS_NODE did not
outperform SHARED_RUNQ on any of the benchmarks, so we elect to not
compare against it again for this v2 patch set.

[0]: https://lore.kernel.org/all/20230530113249.GA156198@hirez.programming.kicks-ass.net/
[1]: https://lore.kernel.org/all/20230605175636.GA4253@hirez.programming.kicks-ass.net/
[2]: https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/

Worth noting as well is that pointed out in [3] that the logic behind
including SIS_NODE in the first place should apply to SHARED_RUNQ
(meaning that e.g. very small Zen2 CPUs with only 3/4 cores per LLC
should benefit from having a single shared_runq stretch across multiple
LLCs). I drafted a patch that implements this by having a minimum LLC
size for creating a shard, and stretches a shared_runq across multiple
LLCs if they're smaller than that size, and sent it to Tejun to test on
his Zen2. Tejun reported back that SIS_NODE did not seem to make a
difference:

[3]: https://lore.kernel.org/lkml/20230711114207.GK3062772@hirez.programming.kicks-ass.net/

			    o____________o__________o
			    |    mean    | Variance |
			    o------------o----------o
Vanilla:		    | 108.84s    | 0.0057   |
NO_SHARED_RUNQ:		    | 108.82s    | 0.119s   |
SHARED_RUNQ:		    | 108.17s    | 0.038s   |
SHARED_RUNQ w/ SIS_NODE:    | 108.87s    | 0.111s   |
			    o------------o----------o

I similarly tried running kcompile on SHARED_RUNQ with SIS_NODE on my
7950X Zen3, but didn't see any gain relative to plain SHARED_RUNQ.

Conclusion
==========

SHARED_RUNQ in this form provides statistically significant wins for
several types of workloads, and various CPU topologies. The reason for
this is roughly the same for all workloads: SHARED_RUNQ encourages work
conservation inside of a CCX by having a CPU do an O(# per-LLC shards)
iteration over the shared_runq shards in an LLC. We could similarly do
an O(n) iteration over all of the runqueues in the current LLC when a
core is going idle, but that's quite costly (especially for larger
LLCs), and sharded SHARED_RUNQ seems to provide a performant middle
ground between doing an O(n) walk, and doing an O(1) pull from a single
per-LLC shared runq.

While SHARED_RUNQ in this form encourages work conservation, it of
course does not guarantee it given that we don't implement any kind of
work stealing between shared_runq's. In the future, we could potentially
push CPU utilization even higher by enabling work stealing between
shared_runq's, likely between CCXs on the same NUMA node.

Appendix
========

Worth noting is that various people's review feedback contributed to
this patch. Most notably is likely K Prateek Nayak
<kprateek.nayak@amd.com> who suggested checking this_rq->rd->overload to
avoid unnecessary contention and load balancing overhead with the
SHARED_RUNQ patches, and also corrected how we were doing idle cost
accounting.

Originally-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/sched.h   |   2 +
 init/init_task.c        |   3 +
 kernel/sched/core.c     |  13 ++
 kernel/sched/fair.c     | 332 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |   4 +
 kernel/sched/sched.h    |   9 ++
 kernel/sched/topology.c |   4 +-
 7 files changed, 364 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d258162deb0..0e329040c2ed 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -794,6 +794,8 @@ struct task_struct {
 	unsigned long			wakee_flip_decay_ts;
 	struct task_struct		*last_wakee;
 
+	struct list_head		shared_runq_node;
+
 	/*
 	 * recent_used_cpu is initially set as the last CPU used by a task
 	 * that wakes affine another task. Waker/wakee relationships can
diff --git a/init/init_task.c b/init/init_task.c
index 5727d42149c3..e57587988cb9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -75,6 +75,9 @@ struct task_struct init_task
 	.stack		= init_stack,
 	.usage		= REFCOUNT_INIT(2),
 	.flags		= PF_KTHREAD,
+#ifdef CONFIG_SMP
+	.shared_runq_node = LIST_HEAD_INIT(init_task.shared_runq_node),
+#endif
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045ac2539f37..f12aaa3674fa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4523,6 +4523,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
+	INIT_LIST_HEAD(&p->shared_runq_node);
 #endif
 	init_sched_mm_cid(p);
 }
@@ -9713,6 +9714,18 @@ int sched_cpu_deactivate(unsigned int cpu)
 	return 0;
 }
 
+void sched_update_domains(void)
+{
+	const struct sched_class *class;
+
+	update_sched_domain_debugfs();
+
+	for_each_class(class) {
+		if (class->update_domains)
+			class->update_domains();
+	}
+}
+
 static void sched_rq_cpu_starting(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 49f047df5d9d..b2f4f8620265 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -91,7 +91,273 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
+/**
+ * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
+ * runnable tasks within an LLC.
+ * @list: The list of tasks in the shared_runq.
+ * @lock: The raw spinlock that synchronizes access to the shared_runq.
+ *
+ * WHAT
+ * ====
+ *
+ * This structure enables the scheduler to be more aggressively work
+ * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
+ * pulled from when another core in the LLC is going to go idle.
+ *
+ * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
+ * Waking tasks are enqueued in the calling CPU's struct shared_runq in
+ * __enqueue_entity(), and are opportunistically pulled from the shared_runq
+ * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
+ * to being pulled from the shared_runq, in which case they're simply dequeued
+ * from the shared_runq in __dequeue_entity().
+ *
+ * There is currently no task-stealing between shared_runqs in different LLCs,
+ * which means that shared_runq is not fully work conserving. This could be
+ * added at a later time, with tasks likely only being stolen across
+ * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
+ *
+ * Note that there is a per-CPU allocation of struct shared_runq objects to
+ * account for the possibility that sched domains are reconfigured during e.g.
+ * hotplug. In practice, most of these struct shared_runq objects are unused at
+ * any given time, with the struct shared_runq of a single core per LLC being
+ * referenced by all other cores in the LLC via a pointer in their struct
+ * cfs_rq.
+ *
+ * HOW
+ * ===
+ *
+ * A shared_runq is comprised of a list, and a spinlock for synchronization.
+ * Given that the critical section for a shared_runq is typically a fast list
+ * operation, and that the shared_runq is localized to a single LLC, the
+ * spinlock will typically only be contended on workloads that do little else
+ * other than hammer the runqueue.
+ *
+ * WHY
+ * ===
+ *
+ * As mentioned above, the main benefit of shared_runq is that it enables more
+ * aggressive work conservation in the scheduler. This can benefit workloads
+ * that benefit more from CPU utilization than from L1/L2 cache locality.
+ *
+ * shared_runqs are segmented across LLCs both to avoid contention on the
+ * shared_runq spinlock by minimizing the number of CPUs that could contend on
+ * it, as well as to strike a balance between work conservation, and L3 cache
+ * locality.
+ */
+struct shared_runq {
+	struct list_head list;
+	raw_spinlock_t lock;
+} ____cacheline_aligned;
+
 #ifdef CONFIG_SMP
+
+static DEFINE_PER_CPU(struct shared_runq, shared_runqs);
+DEFINE_STATIC_KEY_FALSE(__shared_runq_force_dequeue);
+
+static struct shared_runq *rq_shared_runq(struct rq *rq)
+{
+	return rq->cfs.shared_runq;
+}
+
+static void shared_runq_reassign_domains(void)
+{
+	int i;
+	struct shared_runq *shared_runq;
+	struct rq *rq;
+	struct rq_flags rf;
+
+	for_each_possible_cpu(i) {
+		rq = cpu_rq(i);
+		shared_runq = &per_cpu(shared_runqs, per_cpu(sd_llc_id, i));
+
+		rq_lock(rq, &rf);
+		rq->cfs.shared_runq = shared_runq;
+		rq_unlock(rq, &rf);
+	}
+}
+
+static void __shared_runq_drain(struct shared_runq *shared_runq)
+{
+	struct task_struct *p, *tmp;
+
+	raw_spin_lock(&shared_runq->lock);
+	list_for_each_entry_safe(p, tmp, &shared_runq->list, shared_runq_node)
+		list_del_init(&p->shared_runq_node);
+	raw_spin_unlock(&shared_runq->lock);
+}
+
+static void update_domains_fair(void)
+{
+	int i;
+	struct shared_runq *shared_runq;
+
+	/* Avoid racing with SHARED_RUNQ enable / disable. */
+	lockdep_assert_cpus_held();
+
+	shared_runq_reassign_domains();
+
+	/* Ensure every core sees its updated shared_runq pointers. */
+	synchronize_rcu();
+
+	/*
+	 * Drain all tasks from all shared_runq's to ensure there are no stale
+	 * tasks in any prior domain runq. This can cause us to drain live
+	 * tasks that would otherwise have been safe to schedule, but this
+	 * isn't a practical problem given how infrequently domains are
+	 * rebuilt.
+	 */
+	for_each_possible_cpu(i) {
+		shared_runq = &per_cpu(shared_runqs, i);
+		__shared_runq_drain(shared_runq);
+	}
+}
+
+void shared_runq_toggle(bool enabling)
+{
+	int cpu;
+
+	if (enabling) {
+		static_branch_enable_cpuslocked(&__shared_runq_force_dequeue);
+		return;
+	}
+
+	/* Avoid racing with hotplug. */
+	lockdep_assert_cpus_held();
+
+	/* Ensure all cores have stopped enqueueing / dequeuing tasks. */
+	synchronize_rcu();
+
+	for_each_possible_cpu(cpu) {
+		int sd_id;
+
+		sd_id = per_cpu(sd_llc_id, cpu);
+		if (cpu == sd_id)
+			__shared_runq_drain(rq_shared_runq(cpu_rq(cpu)));
+	}
+	/*
+	 * Disable dequeue _after_ ensuring that all of the shared runqueues
+	 * are fully drained. Otherwise, a task could remain enqueued on a
+	 * shared runqueue after the feature was disabled, and could exit
+	 * before drain has completed.
+	 */
+	static_branch_disable_cpuslocked(&__shared_runq_force_dequeue);
+}
+
+static struct task_struct *shared_runq_pop_task(struct rq *rq)
+{
+	struct task_struct *p;
+	struct shared_runq *shared_runq;
+
+	shared_runq = rq_shared_runq(rq);
+	if (list_empty(&shared_runq->list))
+		return NULL;
+
+	raw_spin_lock(&shared_runq->lock);
+	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
+				     shared_runq_node);
+	if (p && is_cpu_allowed(p, cpu_of(rq)))
+		list_del_init(&p->shared_runq_node);
+	else
+		p = NULL;
+	raw_spin_unlock(&shared_runq->lock);
+
+	return p;
+}
+
+static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
+{
+	struct shared_runq *shared_runq;
+
+	shared_runq = rq_shared_runq(rq);
+	raw_spin_lock(&shared_runq->lock);
+	list_add_tail(&p->shared_runq_node, &shared_runq->list);
+	raw_spin_unlock(&shared_runq->lock);
+}
+
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
+{
+	/*
+	 * Only enqueue the task in the shared runqueue if:
+	 *
+	 * - SHARED_RUNQ is enabled
+	 * - The task isn't pinned to a specific CPU
+	 * - The rq is empty, meaning the task will be picked next anyways.
+	 */
+	if (!sched_feat(SHARED_RUNQ) ||
+	    p->nr_cpus_allowed == 1 ||
+	    rq->nr_running < 1)
+		return;
+
+	shared_runq_push_task(rq, p);
+}
+
+static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
+{
+	struct task_struct *p = NULL;
+	struct rq *src_rq;
+	struct rq_flags src_rf;
+	int ret = 0, cpu;
+
+	p = shared_runq_pop_task(rq);
+	if (!p)
+		return 0;
+
+	rq_unpin_lock(rq, rf);
+	raw_spin_rq_unlock(rq);
+
+	src_rq = task_rq_lock(p, &src_rf);
+
+	cpu = cpu_of(rq);
+	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p) &&
+	    likely(!is_migration_disabled(p) && is_cpu_allowed(p, cpu))) {
+		update_rq_clock(src_rq);
+		src_rq = move_queued_task(src_rq, &src_rf, p, cpu);
+		ret = 1;
+	}
+
+	if (src_rq != rq) {
+		task_rq_unlock(src_rq, p, &src_rf);
+		raw_spin_rq_lock(rq);
+	} else {
+		rq_unpin_lock(rq, &src_rf);
+		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
+	}
+	rq_repin_lock(rq, rf);
+
+	if (rq->nr_running != rq->cfs.h_nr_running)
+		ret = -1;
+
+	return ret;
+}
+
+static void shared_runq_dequeue_task(struct task_struct *p)
+{
+	struct shared_runq *shared_runq;
+
+	/*
+	 * Always dequeue a task if:
+	 * - SHARED_RUNQ is enabled
+	 * - The __shared_runq_force_dequeue static branch is enabled.
+	 *
+	 * The latter is necessary to ensure that we've fully drained the
+	 * shared runqueues after the feature has been disabled. Otherwise, we
+	 * could end up in a situation where we stop dequeuing tasks, and a
+	 * task exits while still on the shared runqueue before it's been
+	 * drained.
+	 */
+	if (!sched_feat(SHARED_RUNQ) &&
+	    !static_branch_unlikely(&__shared_runq_force_dequeue))
+		return;
+
+	if (!list_empty(&p->shared_runq_node)) {
+		shared_runq = rq_shared_runq(task_rq(p));
+		raw_spin_lock(&shared_runq->lock);
+		if (likely(!list_empty(&p->shared_runq_node)))
+			list_del_init(&p->shared_runq_node);
+		raw_spin_unlock(&shared_runq->lock);
+	}
+}
+
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
  */
@@ -114,6 +380,15 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: ~5%)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
+#else
+void shared_runq_toggle(bool enabling)
+{}
+
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
+{}
+
+static void shared_runq_dequeue_task(struct task_struct *p)
+{}
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -823,6 +1098,8 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (entity_is_task(se))
+		shared_runq_enqueue_task(rq_of(cfs_rq), task_of(se));
 	avg_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -834,6 +1111,8 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	avg_vruntime_sub(cfs_rq, se);
+	if (entity_is_task(se))
+		shared_runq_dequeue_task(task_of(se));
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -8211,6 +8490,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 
 static void task_dead_fair(struct task_struct *p)
 {
+	WARN_ON_ONCE(!list_empty(&p->shared_runq_node));
 	remove_entity_load_avg(&p->se);
 }
 
@@ -12299,15 +12579,47 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (!READ_ONCE(this_rq->rd->overload) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	/* Skip all balancing if the root domain is not overloaded. */
+	if (!READ_ONCE(this_rq->rd->overload)) {
 
 		if (sd)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
+		goto out;
+	} else if (sched_feat(SHARED_RUNQ)) {
+		/*
+		 * Ignore avg_idle and always try to pull a task from the
+		 * shared_runq when enabled. The goal of SHARED_RUNQ is to
+		 * maximize work conservation, so we want to avoid heuristics
+		 * that could potentially negate that such as newidle lb cost
+		 * tracking.
+		 */
+		pulled_task = shared_runq_pick_next_task(this_rq, rf);
+		if (pulled_task) {
+			rcu_read_unlock();
+			goto out_swq;
+		}
+
+		/*
+		 * We drop and reacquire the rq lock when checking for tasks in
+		 * the shared_runq shards, so check if there's a wakeup pending
+		 * to potentially avoid having to do the full load_balance()
+		 * pass.
+		 */
+		if (this_rq->ttwu_pending) {
+			rcu_read_unlock();
+			return 0;
+		}
+	}
+
+	if (sd && this_rq->avg_idle < sd->max_newidle_lb_cost) {
+		update_next_balance(sd, &next_balance);
+		rcu_read_unlock();
+
 		goto out;
 	}
+
 	rcu_read_unlock();
 
 	/*
@@ -12327,6 +12639,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 domain_cost;
 
+		/*
+		 * Skip <= LLC domains as they likely won't have any tasks if
+		 * the shared runq is empty.
+		 */
+		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
+			continue;
+
 		update_next_balance(sd, &next_balance);
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
@@ -12359,6 +12678,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	raw_spin_rq_lock(this_rq);
 	rq_repin_lock(this_rq, rf);
 
+out_swq:
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
@@ -12733,6 +13053,9 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
+#ifdef CONFIG_SMP
+	WARN_ON_ONCE(!list_empty(&p->shared_runq_node));
+#endif
 	detach_task_cfs_rq(p);
 }
 
@@ -13125,6 +13448,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.task_dead		= task_dead_fair,
 	.set_cpus_allowed	= set_cpus_allowed_common,
+	.update_domains		= update_domains_fair,
 #endif
 
 	.task_tick		= task_tick_fair,
@@ -13191,6 +13515,7 @@ __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
 	int i;
+	struct shared_runq *shared_runq;
 
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
@@ -13202,6 +13527,9 @@ __init void init_sched_fair_class(void)
 		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
 		INIT_LIST_HEAD(&cpu_rq(i)->cfsb_csd_list);
 #endif
+		shared_runq = &per_cpu(shared_runqs, i);
+		INIT_LIST_HEAD(&shared_runq->list);
+		raw_spin_lock_init(&shared_runq->lock);
 	}
 
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3ddf84de430..c38fac5dd042 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -88,3 +88,7 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(HZ_BW, true)
+
+#ifdef CONFIG_SMP
+SCHED_FEAT_CALLBACK(SHARED_RUNQ, false, shared_runq_toggle)
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 517e67a0cc9a..79cbdb251ad5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -514,6 +514,12 @@ static inline bool cfs_task_bw_constrained(struct task_struct *p) { return false
 
 #endif	/* CONFIG_CGROUP_SCHED */
 
+#ifdef CONFIG_SMP
+extern void sched_update_domains(void);
+#else
+static inline void sched_update_domains(void) {}
+#endif /* CONFIG_SMP */
+
 extern void unregister_rt_sched_group(struct task_group *tg);
 extern void free_rt_sched_group(struct task_group *tg);
 extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
@@ -593,6 +599,7 @@ struct cfs_rq {
 #endif
 
 #ifdef CONFIG_SMP
+	struct shared_runq	*shared_runq;
 	/*
 	 * CFS load tracking
 	 */
@@ -2158,6 +2165,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 #endif /* SCHED_DEBUG */
 
 typedef void (*sched_feat_change_f)(bool enabling);
+extern void shared_runq_toggle(bool enabling);
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
@@ -2317,6 +2325,7 @@ struct sched_class {
 	void (*rq_offline)(struct rq *rq);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
+	void (*update_domains)(void);
 #endif
 
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..0f69209ba56a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2612,6 +2612,8 @@ int __init sched_init_domains(const struct cpumask *cpu_map)
 		doms_cur = &fallback_doms;
 	cpumask_and(doms_cur[0], cpu_map, housekeeping_cpumask(HK_TYPE_DOMAIN));
 	err = build_sched_domains(doms_cur[0], NULL);
+	if (!err)
+		sched_update_domains();
 
 	return err;
 }
@@ -2780,7 +2782,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	dattr_cur = dattr_new;
 	ndoms_cur = ndoms_new;
 
-	update_sched_domain_debugfs();
+	sched_update_domains();
 }
 
 /*
-- 
2.42.1

