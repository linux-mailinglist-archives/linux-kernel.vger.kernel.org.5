Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3348B80E050
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbjLLAcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbjLLAbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:55 -0500
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E59C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:32:00 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b70de199f6so136500839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341119; x=1702945919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae3mm2ON6OBR2SQ7MBp1B1n4BG08XaXKdV3B0rLDua0=;
        b=XCwCsFtv2rxEBxW7o55QYAbG5HIbuB0n3ThUKB60BadjaTrKXeQX9E0cKrBlBp7weM
         2zX7gjPC9zl+NesoL1kq2/qrNmZDY71RlL8C3JpEegtyhH292bkVsDG/+KaaK4HoRx+c
         2oTH19o485cXu4GPL+v11VIUIBcfMhM4P1aRXyOolWHpvtlk/AD3pFbK86wfltQcB2/j
         MAGWHydYVLNiED6VEFeAwsRpIPksi49svtiLBszIXO1vpTbPloBlLxXWqFrZauXsJ/k+
         m+jgatftMiwU9JhthOqwqAkv80OIrnCx17PKek2HyDp3dOIyv8pUZYDE0VMceahVFUB0
         Kqxg==
X-Gm-Message-State: AOJu0Yxhxy9kC+bNNWSik/dsLcVQ1B7eOaF8Xs7/DquovA2oIupcK+mn
        I83k0iQZys6KeGxlTHINFbZybqc/c3kaEe3X
X-Google-Smtp-Source: AGHT+IFFnTqWyI9ONbjbRSI/1w6QKcMreHu+7cB/jmt66KeZeuoGVXZ27d97aYV3V34sqq/rXcuzYQ==
X-Received: by 2002:a5d:9a86:0:b0:7b7:2bb3:2b24 with SMTP id c6-20020a5d9a86000000b007b72bb32b24mr965359iom.43.1702341119171;
        Mon, 11 Dec 2023 16:31:59 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id c4-20020a029604000000b00468e18cd2f6sm2138532jai.132.2023.12.11.16.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:58 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 7/8] sched: Shard per-LLC shared runqueues
Date:   Mon, 11 Dec 2023 18:31:40 -0600
Message-ID: <20231212003141.216236-8-void@manifault.com>
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

The SHARED_RUNQ scheduler feature creates a FIFO queue per LLC that
tasks are put into on enqueue, and pulled from when a core in that LLC
would otherwise go idle. For CPUs with large LLCs, this can sometimes
cause significant contention, as illustrated in [0].

[0]: https://lore.kernel.org/all/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/

So as to try and mitigate this contention, we can instead shard the
per-LLC runqueue into multiple per-LLC shards.

While this doesn't outright prevent all contention, it does somewhat mitigate it.
For example, if we run the following schbench command which does almost
nothing other than pound the runqueue:

schbench -L -m 52 -p 512 -r 10 -t 1

we observe with lockstats that sharding significantly decreases
contention.

3 shards:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name         con-bounces    contentions       waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:      31510503       31510711           0.08          19.98        168932319.64     5.36            31700383      31843851       0.03           17.50        10273968.33      0.32
------------
&shard->lock       15731657          [<0000000068c0fd75>] pick_next_task_fair+0x4dd/0x510
&shard->lock       15756516          [<000000001faf84f9>] enqueue_task_fair+0x459/0x530
&shard->lock          21766          [<00000000126ec6ab>] newidle_balance+0x45a/0x650
&shard->lock            772          [<000000002886c365>] dequeue_task_fair+0x4c9/0x540
------------
&shard->lock          23458          [<00000000126ec6ab>] newidle_balance+0x45a/0x650
&shard->lock       16505108          [<000000001faf84f9>] enqueue_task_fair+0x459/0x530
&shard->lock       14981310          [<0000000068c0fd75>] pick_next_task_fair+0x4dd/0x510
&shard->lock            835          [<000000002886c365>] dequeue_task_fair+0x4c9/0x540

No sharding:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name        con-bounces    contentions         waittime-min   waittime-max waittime-total         waittime-avg    acq-bounces   acquisitions   holdtime-min  holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:     117868635      118361486           0.09           393.01       1250954097.25          10.57           119345882     119780601      0.05          343.35       38313419.51      0.32
------------
&shard->lock       59169196          [<0000000060507011>] __enqueue_entity+0xdc/0x110
&shard->lock       59084239          [<00000000f1c67316>] __dequeue_entity+0x78/0xa0
&shard->lock         108051          [<00000000084a6193>] newidle_balance+0x45a/0x650
------------
&shard->lock       60028355          [<0000000060507011>] __enqueue_entity+0xdc/0x110
&shard->lock         119882          [<00000000084a6193>] newidle_balance+0x45a/0x650
&shard->lock       58213249          [<00000000f1c67316>] __dequeue_entity+0x78/0xa0

The contention is ~3-4x worse if we don't shard at all. This roughly
matches the fact that we had 3 shards on the host where this was
collected. This could be addressed in future patch sets by adding a
debugfs knob to control the sharding granularity. If we make the shards
even smaller (what's in this patch, i.e. a size of 6), the contention
goes away almost entirely:

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name    	   con-bounces    contentions   waittime-min  waittime-max waittime-total   waittime-avg   acq-bounces   acquisitions   holdtime-min  holdtime-max holdtime-total   holdtime-avg
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:      13839849       13877596      0.08          13.23        5389564.95       0.39           46910241      48069307       0.06          16.40        16534469.35      0.34
------------
&shard->lock           3559          [<00000000ea455dcc>] newidle_balance+0x45a/0x650
&shard->lock        6992418          [<000000002266f400>] __dequeue_entity+0x78/0xa0
&shard->lock        6881619          [<000000002a62f2e0>] __enqueue_entity+0xdc/0x110
------------
&shard->lock        6640140          [<000000002266f400>] __dequeue_entity+0x78/0xa0
&shard->lock           3523          [<00000000ea455dcc>] newidle_balance+0x45a/0x650
&shard->lock        7233933          [<000000002a62f2e0>] __enqueue_entity+0xdc/0x110

Interestingly, SHARED_RUNQ performs worse than NO_SHARED_RUNQ on the schbench
benchmark on Milan, but we contend even more on the rq lock:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name         con-bounces    contentions   waittime-min  waittime-max waittime-total   waittime-avg   acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&rq->__lock:       9617614        9656091       0.10          79.64        69665812.00      7.21           18092700      67652829       0.11           82.38        344524858.87     5.09
-----------
&rq->__lock        6301611          [<000000003e63bf26>] task_rq_lock+0x43/0xe0
&rq->__lock        2530807          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock         109360          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock         178218          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
-----------
&rq->__lock        3245506          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock        1294355          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
&rq->__lock        2837804          [<000000003e63bf26>] task_rq_lock+0x43/0xe0
&rq->__lock        1627866          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10

..................................................................................................................................................................................................

&shard->lock:       7338558       7343244       0.10          35.97        7173949.14       0.98           30200858      32679623       0.08           35.59        16270584.52      0.50
------------
&shard->lock        2004142          [<00000000f8aa2c91>] __dequeue_entity+0x78/0xa0
&shard->lock        2611264          [<00000000473978cc>] newidle_balance+0x45a/0x650
&shard->lock        2727838          [<0000000028f55bb5>] __enqueue_entity+0xdc/0x110
------------
&shard->lock        2737232          [<00000000473978cc>] newidle_balance+0x45a/0x650
&shard->lock        1693341          [<00000000f8aa2c91>] __dequeue_entity+0x78/0xa0
&shard->lock        2912671          [<0000000028f55bb5>] __enqueue_entity+0xdc/0x110

...................................................................................................................................................................................................

If we look at the lock stats with SHARED_RUNQ disabled, the rq lock still
contends the most, but it's significantly less than with it enabled:

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name          con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&rq->__lock:        791277         791690        0.12           110.54       4889787.63       6.18            1575996       62390275       0.13           112.66       316262440.56     5.07
-----------
&rq->__lock         263343          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock          19394          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock           4143          [<000000003b542e83>] __task_rq_lock+0x51/0xf0
&rq->__lock          51094          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
-----------
&rq->__lock          23756          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock         379048          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock            677          [<000000003b542e83>] __task_rq_lock+0x51/0xf0
&rq->__lock          47962          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170

In general, the takeaway here is that sharding does help with
contention, but it's not necessarily one size fits all, and it's
workload dependent. For now, let's include sharding to try and avoid
contention, and because it doesn't seem to regress CPUs that don't need
it such as the AMD 7950X.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c  | 181 +++++++++++++++++++++++++++++--------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 126 insertions(+), 58 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b2f4f8620265..3f085c122712 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -92,45 +92,44 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 /**
- * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
- * runnable tasks within an LLC.
- * @list: The list of tasks in the shared_runq.
- * @lock: The raw spinlock that synchronizes access to the shared_runq.
+ * struct shared_runq_shard - A structure containing a task list and a spinlock
+ * for a subset of cores in a struct shared_runq.
+ * @list: The list of tasks in the shard.
+ * @lock: The raw spinlock that synchronizes access to the shard.
  *
  * WHAT
  * ====
  *
  * This structure enables the scheduler to be more aggressively work
- * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
- * pulled from when another core in the LLC is going to go idle.
+ * conserving, by placing waking tasks on a per-LLC FIFO queue shard that can
+ * then be pulled from when another core in the LLC is going to go idle.
+ *
+ * struct rq stores two pointers in its struct cfs_rq:
  *
- * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
- * Waking tasks are enqueued in the calling CPU's struct shared_runq in
- * __enqueue_entity(), and are opportunistically pulled from the shared_runq
- * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
- * to being pulled from the shared_runq, in which case they're simply dequeued
- * from the shared_runq in __dequeue_entity().
+ * 1. The per-LLC struct shared_runq which contains one or more shards of
+ *    enqueued tasks.
+ *
+ * 2. The shard inside of the per-LLC struct shared_runq which contains the
+ *    list of runnable tasks for that shard.
+ *
+ * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard in
+ * __enqueue_entity(), and are opportunistically pulled from the shared_runq in
+ * newidle_balance(). Pulling from shards is an O(# shards) operation.
  *
  * There is currently no task-stealing between shared_runqs in different LLCs,
  * which means that shared_runq is not fully work conserving. This could be
  * added at a later time, with tasks likely only being stolen across
  * shared_runqs on the same NUMA node to avoid violating NUMA affinities.
  *
- * Note that there is a per-CPU allocation of struct shared_runq objects to
- * account for the possibility that sched domains are reconfigured during e.g.
- * hotplug. In practice, most of these struct shared_runq objects are unused at
- * any given time, with the struct shared_runq of a single core per LLC being
- * referenced by all other cores in the LLC via a pointer in their struct
- * cfs_rq.
- *
  * HOW
  * ===
  *
- * A shared_runq is comprised of a list, and a spinlock for synchronization.
- * Given that the critical section for a shared_runq is typically a fast list
- * operation, and that the shared_runq is localized to a single LLC, the
- * spinlock will typically only be contended on workloads that do little else
- * other than hammer the runqueue.
+ * A struct shared_runq_shard is comprised of a list, and a spinlock for
+ * synchronization.  Given that the critical section for a shared_runq is
+ * typically a fast list operation, and that the shared_runq_shard is localized
+ * to a subset of cores on a single LLC (plus other cores in the LLC that pull
+ * from the shard in newidle_balance()), the spinlock will typically only be
+ * contended on workloads that do little else other than hammer the runqueue.
  *
  * WHY
  * ===
@@ -144,11 +143,35 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
  * it, as well as to strike a balance between work conservation, and L3 cache
  * locality.
  */
-struct shared_runq {
+struct shared_runq_shard {
 	struct list_head list;
 	raw_spinlock_t lock;
 } ____cacheline_aligned;
 
+/* This would likely work better as a configurable knob via debugfs */
+#define SHARED_RUNQ_SHARD_SZ 6
+#define SHARED_RUNQ_MAX_SHARDS \
+	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
+
+/**
+ * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
+ * runnable tasks within an LLC.
+ * @num_shards: The number of shards currently active in the shared_runq.
+ * @shards: The shards of the shared_runq. Only @num_shards of these shards are
+ * active at any given time.
+ *
+ * A per-LLC shared_runq that is composed of one of more shards. There is a
+ * per-CPU allocation of struct shared_runq objects to account for the
+ * possibility that sched domains are reconfigured during e.g. hotplug. In
+ * practice, most of these struct shared_runq objects are unused at any given
+ * time, with the struct shared_runq of a single core per LLC being referenced
+ * by all other cores in the LLC via a pointer in their struct cfs_rq.
+ */
+struct shared_runq {
+	unsigned int num_shards;
+	struct shared_runq_shard shards[SHARED_RUNQ_MAX_SHARDS];
+} ____cacheline_aligned;
+
 #ifdef CONFIG_SMP
 
 static DEFINE_PER_CPU(struct shared_runq, shared_runqs);
@@ -159,31 +182,61 @@ static struct shared_runq *rq_shared_runq(struct rq *rq)
 	return rq->cfs.shared_runq;
 }
 
+static struct shared_runq_shard *rq_shared_runq_shard(struct rq *rq)
+{
+	return rq->cfs.shard;
+}
+
+static int shared_runq_shard_idx(const struct shared_runq *runq, int cpu)
+{
+	return (cpu >> 1) % runq->num_shards;
+}
+
 static void shared_runq_reassign_domains(void)
 {
 	int i;
 	struct shared_runq *shared_runq;
 	struct rq *rq;
 	struct rq_flags rf;
+	unsigned int num_shards, shard_idx;
+
+	for_each_possible_cpu(i) {
+		if (per_cpu(sd_llc_id, i) == i) {
+			shared_runq = &per_cpu(shared_runqs, per_cpu(sd_llc_id, i));
+
+			num_shards = per_cpu(sd_llc_size, i) / SHARED_RUNQ_SHARD_SZ;
+			if (per_cpu(sd_llc_size, i) % SHARED_RUNQ_SHARD_SZ)
+				num_shards++;
+			shared_runq->num_shards = num_shards;
+		}
+	}
 
 	for_each_possible_cpu(i) {
 		rq = cpu_rq(i);
 		shared_runq = &per_cpu(shared_runqs, per_cpu(sd_llc_id, i));
 
+		shard_idx = shared_runq_shard_idx(shared_runq, i);
 		rq_lock(rq, &rf);
 		rq->cfs.shared_runq = shared_runq;
+		rq->cfs.shard = &shared_runq->shards[shard_idx];
 		rq_unlock(rq, &rf);
 	}
 }
 
 static void __shared_runq_drain(struct shared_runq *shared_runq)
 {
-	struct task_struct *p, *tmp;
+	unsigned int i;
 
-	raw_spin_lock(&shared_runq->lock);
-	list_for_each_entry_safe(p, tmp, &shared_runq->list, shared_runq_node)
-		list_del_init(&p->shared_runq_node);
-	raw_spin_unlock(&shared_runq->lock);
+	for (i = 0; i < shared_runq->num_shards; i++) {
+		struct shared_runq_shard *shard;
+		struct task_struct *p, *tmp;
+
+		shard = &shared_runq->shards[i];
+		raw_spin_lock(&shard->lock);
+		list_for_each_entry_safe(p, tmp, &shard->list, shared_runq_node)
+			list_del_init(&p->shared_runq_node);
+		raw_spin_unlock(&shard->lock);
+	}
 }
 
 static void update_domains_fair(void)
@@ -237,41 +290,38 @@ void shared_runq_toggle(bool enabling)
 	/*
 	 * Disable dequeue _after_ ensuring that all of the shared runqueues
 	 * are fully drained. Otherwise, a task could remain enqueued on a
-	 * shared runqueue after the feature was disabled, and could exit
-	 * before drain has completed.
+	 * shard after the feature was disabled, and could exit before drain
+	 * has completed.
 	 */
 	static_branch_disable_cpuslocked(&__shared_runq_force_dequeue);
 }
 
-static struct task_struct *shared_runq_pop_task(struct rq *rq)
+static struct task_struct *
+shared_runq_pop_task(struct shared_runq_shard *shard, int target)
 {
 	struct task_struct *p;
-	struct shared_runq *shared_runq;
 
-	shared_runq = rq_shared_runq(rq);
-	if (list_empty(&shared_runq->list))
+	if (list_empty(&shard->list))
 		return NULL;
 
-	raw_spin_lock(&shared_runq->lock);
-	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
+	raw_spin_lock(&shard->lock);
+	p = list_first_entry_or_null(&shard->list, struct task_struct,
 				     shared_runq_node);
-	if (p && is_cpu_allowed(p, cpu_of(rq)))
+	if (p && is_cpu_allowed(p, target))
 		list_del_init(&p->shared_runq_node);
 	else
 		p = NULL;
-	raw_spin_unlock(&shared_runq->lock);
+	raw_spin_unlock(&shard->lock);
 
 	return p;
 }
 
-static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
+static void shared_runq_push_task(struct shared_runq_shard *shard,
+				  struct task_struct *p)
 {
-	struct shared_runq *shared_runq;
-
-	shared_runq = rq_shared_runq(rq);
-	raw_spin_lock(&shared_runq->lock);
-	list_add_tail(&p->shared_runq_node, &shared_runq->list);
-	raw_spin_unlock(&shared_runq->lock);
+	raw_spin_lock(&shard->lock);
+	list_add_tail(&p->shared_runq_node, &shard->list);
+	raw_spin_unlock(&shard->lock);
 }
 
 static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
@@ -288,7 +338,7 @@ static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
 	    rq->nr_running < 1)
 		return;
 
-	shared_runq_push_task(rq, p);
+	shared_runq_push_task(rq_shared_runq_shard(rq), p);
 }
 
 static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
@@ -296,9 +346,22 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	struct task_struct *p = NULL;
 	struct rq *src_rq;
 	struct rq_flags src_rf;
+	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
+	u32 i, starting_idx, curr_idx, num_shards;
 	int ret = 0, cpu;
 
-	p = shared_runq_pop_task(rq);
+	shared_runq = rq_shared_runq(rq);
+	num_shards = shared_runq->num_shards;
+	starting_idx = shared_runq_shard_idx(shared_runq, cpu_of(rq));
+	for (i = 0; i < num_shards; i++) {
+		curr_idx = (starting_idx + i) % num_shards;
+		shard = &shared_runq->shards[curr_idx];
+
+		p = shared_runq_pop_task(shard, cpu_of(rq));
+		if (p)
+			break;
+	}
 	if (!p)
 		return 0;
 
@@ -332,8 +395,6 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 
 static void shared_runq_dequeue_task(struct task_struct *p)
 {
-	struct shared_runq *shared_runq;
-
 	/*
 	 * Always dequeue a task if:
 	 * - SHARED_RUNQ is enabled
@@ -350,11 +411,13 @@ static void shared_runq_dequeue_task(struct task_struct *p)
 		return;
 
 	if (!list_empty(&p->shared_runq_node)) {
-		shared_runq = rq_shared_runq(task_rq(p));
-		raw_spin_lock(&shared_runq->lock);
+		struct shared_runq_shard *shard;
+
+		shard = rq_shared_runq_shard(task_rq(p));
+		raw_spin_lock(&shard->lock);
 		if (likely(!list_empty(&p->shared_runq_node)))
 			list_del_init(&p->shared_runq_node);
-		raw_spin_unlock(&shared_runq->lock);
+		raw_spin_unlock(&shard->lock);
 	}
 }
 
@@ -13514,8 +13577,9 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
-	int i;
+	int i, j;
 	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
 
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
@@ -13528,8 +13592,11 @@ __init void init_sched_fair_class(void)
 		INIT_LIST_HEAD(&cpu_rq(i)->cfsb_csd_list);
 #endif
 		shared_runq = &per_cpu(shared_runqs, i);
-		INIT_LIST_HEAD(&shared_runq->list);
-		raw_spin_lock_init(&shared_runq->lock);
+		for (j = 0; j < SHARED_RUNQ_MAX_SHARDS; j++) {
+			shard = &shared_runq->shards[j];
+			INIT_LIST_HEAD(&shard->list);
+			raw_spin_lock_init(&shard->lock);
+		}
 	}
 
 	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 79cbdb251ad5..4b4534f08d25 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,7 +599,8 @@ struct cfs_rq {
 #endif
 
 #ifdef CONFIG_SMP
-	struct shared_runq	*shared_runq;
+	struct shared_runq	 *shared_runq;
+	struct shared_runq_shard *shard;
 	/*
 	 * CFS load tracking
 	 */
-- 
2.42.1

