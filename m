Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1974757DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjGRNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjGRNlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:41:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDBE9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687697; x=1721223697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7zyk3JWG0n/NRGusSO5HuAwJo/tzG1af2tLFBafaYXE=;
  b=Egrhh6nNGnS0m8aVSIPKnKUWoL1czDccNpNvTx/fGvri4U7VTQ7higjI
   XY7lybfDeeoY+0Wjmzb4SrgaMiLGz0W2928tl8JJN4uxjRRi65Qg1I53v
   D6HJEE/xB1ofqk1SabxECsCmlbC41O3Eik0ntgdPzh5UUHRxB6BEpY7FK
   8rV8G1EzFY7UO1Pkv6hhNhaKnL3c4pZolBnti7mBm5ShXRE62d0YlhNfJ
   Ef9+NMCcabrW1zLZMQIq1KbHchl+qp7kPiWgglnLwj3UVKSk2bX0evPJT
   T1TU32oL2jmStBOBtwQS2sQ6OaxRA1l55lajOeYs3SzzLpH5WL1ERf3NX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345800694"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345800694"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847706524"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="847706524"
Received: from ziqianlu-desk2.sh.intel.com ([10.239.159.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:41:33 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Date:   Tue, 18 Jul 2023 21:41:18 +0800
Message-ID: <20230718134120.81199-3-aaron.lu@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134120.81199-1-aaron.lu@intel.com>
References: <20230718134120.81199-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using sysbench to benchmark Postgres in a single docker instance
with sysbench's nr_threads set to nr_cpu, it is observed there are times
update_cfs_group() and update_load_avg() shows noticeable overhead on
a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):

        13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
        10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg

Annotate shows the cycles are mostly spent on accessing tg->load_avg
with update_load_avg() being the write side and update_cfs_group() being
the read side.

Tim Chen told me that PeterZ once mentioned a way to solve a similar
problem by making a counter per node so do the same for tg->load_avg.
After this change, the cost of the two functions are reduced and
sysbench transactions are increased on SPR. Below are test results.

===============================================
postgres_sysbench(transaction, higher is better)
nr_thread=100%/75%/50% were tested on 2 sockets SPR and Icelake and
results that have a measuable difference are:

nr_thread=100% on SPR
base:  90569.11±1.15%
node: 104152.26±0.34%  +15.0%

nr_thread=75% on SPR
base: 100803.96±0.57%
node: 107333.58±0.44%   +6.5%

=======================================================================
hackbench/pipe/threads/fd=20/loop=1000000 (throughput, higher is better)
group=1/4/8/16 were tested on 2 sockets SPR and Cascade lake and the
results that have a measuable difference are:

group=8 on SPR:
base:  437163±2.6%
node:  471203±1.2%   +7.8%

group=16 on SPR:
base:  468279±1.9%
node:  580385±1.7%  +23.9%

=============================================
netperf/TCP_STRAM
nr_thread=1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
Lake and there is no measuable difference.

=============================================
netperf/UDP_RR (throughput, higher is better)
nr_thread=1/25%/50%/75%/100% were tested on 2 sockets SPR and Cascade
Lake and results that have measuable difference are:

nr_thread=75% on Cascade lake:
base:  36701±1.7%
node:  39949±1.4%   +8.8%

nr_thread=75% on SPR:
base:  14249±3.8%
node:  19890±2.0%   +39.6%

nr_thread=100% on Cascade lake
base:  52275±0.6%
node:  53827±0.4%   +3.0%

nr_thread=100% on SPR
base:   9560±1.6%
node:  14186±3.9%   +48.4%

Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 29 ++++++++++++++++++++++++++---
 kernel/sched/sched.h | 43 +++++++++++++++++++++++++++++++++----------
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 066ff1c8ae4e..3af965a18866 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -691,7 +691,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
-			atomic_long_read(&cfs_rq->tg->load_avg));
+			tg_load_avg(cfs_rq->tg));
 #endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f913487928d..aceb8f5922cb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3496,7 +3496,7 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
 
 	load = max(scale_load_down(cfs_rq->load.weight), cfs_rq->avg.load_avg);
 
-	tg_weight = atomic_long_read(&tg->load_avg);
+	tg_weight = tg_load_avg(tg);
 
 	/* Ensure tg_weight >= load */
 	tg_weight -= cfs_rq->tg_load_avg_contrib;
@@ -3665,6 +3665,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	int node = cpu_to_node(smp_processor_id());
 
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
@@ -3673,7 +3674,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 		return;
 
 	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
-		atomic_long_add(delta, &cfs_rq->tg->load_avg);
+		atomic_long_add(delta, &cfs_rq->tg->node_info[node]->load_avg);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
 	}
 }
@@ -12439,7 +12440,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
-	int i;
+	int i, nodes;
 
 	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
 	if (!tg->cfs_rq)
@@ -12468,8 +12469,30 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		init_entity_runnable_average(se);
 	}
 
+#ifdef CONFIG_SMP
+	nodes = num_possible_nodes();
+	tg->node_info = kcalloc(nodes, sizeof(struct tg_node_info *), GFP_KERNEL);
+	if (!tg->node_info)
+		goto err_free;
+
+	for_each_node(i) {
+		tg->node_info[i] = kzalloc_node(sizeof(struct tg_node_info), GFP_KERNEL, i);
+		if (!tg->node_info[i])
+			goto err_free_node;
+	}
+#endif
+
 	return 1;
 
+#ifdef CONFIG_SMP
+err_free_node:
+	for_each_node(i) {
+		kfree(tg->node_info[i]);
+		if (!tg->node_info[i])
+			break;
+	}
+	kfree(tg->node_info);
+#endif
 err_free:
 	for_each_possible_cpu(i) {
 		kfree(tg->cfs_rq[i]);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14dfaafb3a8f..9cece2dbc95b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -359,6 +359,17 @@ struct cfs_bandwidth {
 #endif
 };
 
+struct tg_node_info {
+	/*
+	 * load_avg can be heavily contended at clock tick time and task
+	 * enqueue/dequeue time, so put it in its own cacheline separated
+	 * from other fields.
+	 */
+	struct {
+		atomic_long_t		load_avg;
+	} ____cacheline_aligned_in_smp;
+};
+
 /* Task group related information */
 struct task_group {
 	struct cgroup_subsys_state css;
@@ -373,15 +384,8 @@ struct task_group {
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
 
-#ifdef	CONFIG_SMP
-	/*
-	 * load_avg can be heavily contended at clock tick time, so put
-	 * it in its own cacheline separated from the fields above which
-	 * will also be accessed at each tick.
-	 */
-	struct {
-		atomic_long_t		load_avg;
-	} ____cacheline_aligned_in_smp;
+#ifdef CONFIG_SMP
+	struct tg_node_info	**node_info;
 #endif
 #endif
 
@@ -413,9 +417,28 @@ struct task_group {
 	/* Effective clamp values used for a task group */
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
-
 };
 
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
+static inline long tg_load_avg(struct task_group *tg)
+{
+	long load_avg = 0;
+	int i;
+
+	/*
+	 * The only path that can give us a root_task_group
+	 * here is from print_cfs_rq() thus unlikely.
+	 */
+	if (unlikely(tg == &root_task_group))
+		return 0;
+
+	for_each_node(i)
+		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
+
+	return load_avg;
+}
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
-- 
2.41.0

