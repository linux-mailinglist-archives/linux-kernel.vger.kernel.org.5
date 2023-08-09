Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC4776C07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjHIWNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHIWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:13:10 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC0213F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:12:58 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-635f293884cso1864656d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619177; x=1692223977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=289uBjwPOn362GkpAcGTsnLiJb6Nd9Y0Sebv5Fsn+ec=;
        b=hYxF0oshW+I07f/BqJomcfSnAi0dfzOmxXwrU0oGL/haYwc069LjqsZ7nWSawAmRMQ
         snkaeoPT9aS56UwqliNtYg9x/n/nEASuNzOQK63JDJpYfIEZzyNmKOPjbN5EfJ7Pdo1v
         +4SfGhvudoHvmOtei1tVnQF9XLW7xP8kCl2RPAMRx1FtMdTfray3n3DYmAFM9zcm8AyF
         8Lq1LE8HBbIuY+QGBg/Qau63OXUWP6Bsy3HVo7TQVSBdFuw7vzPLmoEl08/QzR7t1cjs
         FrBB/koAbqGPx6zS/+2P6Qo/qQP9q1ab39w3cJ8rt5U2BmhM9ADdZj42RxerC2H46xSs
         sLwA==
X-Gm-Message-State: AOJu0Yy8fRuQye0VmgJuEjVPaokxsDb7h0h/qalGEj4IdQBtEpVFNw0f
        uUp2DJjOXd7LogcJKgI5e1SiMISVlqgXNPed
X-Google-Smtp-Source: AGHT+IHwkkaDHI/tgBUc2JCBjfLIIHwOxJYuKxKjoDM3LQLz4al/U1X+L53Gs7vJlEFUJ3btWhdyAA==
X-Received: by 2002:a0c:db06:0:b0:626:1906:bcac with SMTP id d6-20020a0cdb06000000b006261906bcacmr627824qvk.0.1691619177105;
        Wed, 09 Aug 2023 15:12:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id p6-20020a0ce186000000b00631fea4d5bcsm4752789qvl.95.2023.08.09.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:12:56 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Date:   Wed,  9 Aug 2023 17:12:18 -0500
Message-ID: <20230809221218.163894-8-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 kernel/sched/fair.c  | 149 ++++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 108 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e740f8da578..d67d86d3bfdf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -143,19 +143,27 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
  * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
  * runnable tasks within an LLC.
  *
+ * struct shared_runq_shard - A structure containing a task list and a spinlock
+ * for a subset of cores in a struct shared_runq.
+ *
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
+ *
+ * 1. The per-LLC struct shared_runq which contains one or more shards of
+ *    enqueued tasks.
  *
- * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
- * Waking tasks are enqueued in the calling CPU's struct shared_runq in
- * __enqueue_entity(), and are opportunistically pulled from the shared_runq
- * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
- * to being pulled from the shared_runq, in which case they're simply dequeued
- * from the shared_runq in __dequeue_entity().
+ * 2. The shard inside of the per-LLC struct shared_runq which contains the
+ *    list of runnable tasks for that shard.
+ *
+ * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard in
+ * __enqueue_entity(), and are opportunistically pulled from the shared_runq in
+ * newidle_balance(). Pulling from shards is an O(# shards) operation.
  *
  * There is currently no task-stealing between shared_runqs in different LLCs,
  * which means that shared_runq is not fully work conserving. This could be
@@ -165,11 +173,12 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
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
@@ -183,11 +192,21 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
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
+struct shared_runq {
+	unsigned int num_shards;
+	struct shared_runq_shard shards[SHARED_RUNQ_MAX_SHARDS];
+} ____cacheline_aligned;
+
 #ifdef CONFIG_SMP
 
 static DEFINE_PER_CPU(struct shared_runq, shared_runqs);
@@ -197,31 +216,61 @@ static struct shared_runq *rq_shared_runq(struct rq *rq)
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
@@ -272,35 +321,32 @@ void shared_runq_toggle(bool enabling)
 	}
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
@@ -314,7 +360,7 @@ static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
 	if (p->nr_cpus_allowed == 1)
 		return;
 
-	shared_runq_push_task(rq, p);
+	shared_runq_push_task(rq_shared_runq_shard(rq), p);
 }
 
 static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
@@ -322,9 +368,22 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	struct task_struct *p = NULL;
 	struct rq *src_rq;
 	struct rq_flags src_rf;
+	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
+	u32 i, starting_idx, curr_idx, num_shards;
 	int ret = -1;
 
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
 
@@ -353,11 +412,11 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 
 static void shared_runq_dequeue_task(struct task_struct *p)
 {
-	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
 
 	if (!list_empty(&p->shared_runq_node)) {
-		shared_runq = rq_shared_runq(task_rq(p));
-		raw_spin_lock(&shared_runq->lock);
+		shard = rq_shared_runq_shard(task_rq(p));
+		raw_spin_lock(&shard->lock);
 		/*
 		 * Need to double-check for the list being empty to avoid
 		 * racing with the list being drained on the domain recreation
@@ -365,7 +424,7 @@ static void shared_runq_dequeue_task(struct task_struct *p)
 		 */
 		if (likely(!list_empty(&p->shared_runq_node)))
 			list_del_init(&p->shared_runq_node);
-		raw_spin_unlock(&shared_runq->lock);
+		raw_spin_unlock(&shard->lock);
 	}
 }
 
@@ -13260,8 +13319,9 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class(void)
 {
 #ifdef CONFIG_SMP
-	int i;
+	int i, j;
 	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
 
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
@@ -13272,8 +13332,11 @@ __init void init_sched_fair_class(void)
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
index 3665dd935649..b504f8f4416b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -580,7 +580,8 @@ struct cfs_rq {
 #endif
 
 #ifdef CONFIG_SMP
-	struct shared_runq	*shared_runq;
+	struct shared_runq	 *shared_runq;
+	struct shared_runq_shard *shard;
 	/*
 	 * CFS load tracking
 	 */
-- 
2.41.0

