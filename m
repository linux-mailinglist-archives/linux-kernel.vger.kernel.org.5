Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897867591AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGSJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGSJbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:31:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891C26AA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:30:48 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R5VpR0wVyzNmM3;
        Wed, 19 Jul 2023 17:27:27 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:30:46 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <tim.c.chen@linux.intel.com>,
        <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v9 2/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Wed, 19 Jul 2023 17:28:38 +0800
Message-ID: <20230719092838.2302-3-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230719092838.2302-1-yangyicong@huawei.com>
References: <20230719092838.2302-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <song.bao.hua@hisilicon.com>

For platforms having clusters like Kunpeng920, CPUs within the same cluster
have lower latency when synchronizing and accessing shared resources like
cache. Thus, this patch tries to find an idle cpu within the cluster of the
target CPU before scanning the whole LLC to gain lower latency. This
will be implemented in 3 steps in select_idle_sibling():
1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
   if they're sharing cluster with the target CPU. Otherwise record them
   and do the scanning first.
2. Scanning the cluster prior to the LLC of the target CPU for an
   idle CPU to wakeup.
3. If no idle CPU found after scanning and the prev_cpu/recent_used_cpu
   can be used, use them.

Testing has been done on Kunpeng920 by pinning tasks to one numa and two
numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.

With this patch, We noticed enhancement on tbench and netperf within one
numa or cross two numa on 6.5-rc1:
tbench results (node 0):
             baseline                    patched
  1:        325.9673        378.9117 (   16.24%)
  4:       1311.9667       1501.5033 (   14.45%)
  8:       2629.4667       2961.9100 (   12.64%)
 16:       5259.1633       5928.0833 (   12.72%)
 32:      10368.6333      10566.8667 (    1.91%)
 64:       7868.7700       8182.0100 (    3.98%)
128:       6528.5733       6801.8000 (    4.19%)
tbench results (node 0-1):
              vanilla                    patched
  1:        329.2757        380.8907 (   15.68%)
  4:       1327.7900       1494.5300 (   12.56%)
  8:       2627.2133       2917.1233 (   11.03%)
 16:       5201.3367       5835.9233 (   12.20%)
 32:       8811.8500      11154.2000 (   26.58%)
 64:      15832.4000      19643.7667 (   24.07%)
128:      12605.5667      14639.5667 (   16.14%)
netperf results TCP_RR (node 0):
             baseline                    patched
  1:      77302.8667      92172.2100 (   19.24%)
  4:      78724.9200      91581.3100 (   16.33%)
  8:      79168.1296      91091.7942 (   15.06%)
 16:      81079.4200      90546.5225 (   11.68%)
 32:      82201.5799      78910.4982 (   -4.00%)
 64:      29539.3509      29131.4698 (   -1.38%)
128:      12082.7522      11956.7705 (   -1.04%)
netperf results TCP_RR (node 0-1):
             baseline                    patched
  1:      78340.5233      92101.8733 (   17.57%)
  4:      79644.2483      91326.7517 (   14.67%)
  8:      79557.4313      90737.8096 (   14.05%)
 16:      79215.5304      90568.4542 (   14.33%)
 32:      78999.3983      85460.6044 (    8.18%)
 64:      74198.9494      74325.4361 (    0.17%)
128:      27397.4810      27757.5471 (    1.31%)
netperf results UDP_RR (node 0):
             baseline                    patched
  1:      95721.9367     111546.1367 (   16.53%)
  4:      96384.2250     110036.1408 (   14.16%)
  8:      97460.6546     109968.0883 (   12.83%)
 16:      98876.1687     109387.8065 (   10.63%)
 32:     104364.6417     105241.6767 (    0.84%)
 64:      37502.6246      37451.1204 (   -0.14%)
128:      14496.1780      14610.5538 (    0.79%)
netperf results UDP_RR (node 0-1):
             baseline                    patched
  1:      96176.1633     111397.5333 (   15.83%)
  4:      94758.5575     105681.7833 (   11.53%)
  8:      94340.2200     104138.3613 (   10.39%)
 16:      95208.5285     106714.0396 (   12.08%)
 32:      74745.9028     100713.8764 (   34.74%)
 64:      59351.4977      73536.1434 (   23.90%)
128:      23755.4971      26648.7413 (   12.18%)

Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
in the code has not been tested but it supposed to work.

Chen Yu also noticed this will improve the performance of tbench and
netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
cluster sharing L2 Cache.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
[https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 59 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 12 +++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..d91bf64f81f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7012,6 +7012,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	if (static_branch_unlikely(&sched_cluster_active)) {
+		struct sched_group *sg = sd->groups;
+
+		if (sg->flags & SD_CLUSTER) {
+			for_each_cpu_wrap(cpu, sched_group_span(sg), target + 1) {
+				if (!cpumask_test_cpu(cpu, cpus))
+					continue;
+
+				if (has_idle_core) {
+					i = select_idle_core(p, cpu, cpus, &idle_cpu);
+					if ((unsigned int)i < nr_cpumask_bits)
+						return i;
+				} else {
+					if (--nr <= 0)
+						return -1;
+					idle_cpu = __select_idle_cpu(cpu, p);
+					if ((unsigned int)idle_cpu < nr_cpumask_bits)
+						return idle_cpu;
+				}
+			}
+			cpumask_andnot(cpus, cpus, sched_group_span(sg));
+		}
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -7019,7 +7043,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return i;
 
 		} else {
-			if (!--nr)
+			if (--nr <= 0)
 				return -1;
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
@@ -7121,7 +7145,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util, util_min, util_max;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, prev_aff = -1;
 
 	/*
 	 * On asymmetric system, update task utilization because we will check
@@ -7148,8 +7172,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_cpu(task_util, util_min, util_max, prev))
-		return prev;
+	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
+		if (!static_branch_unlikely(&sched_cluster_active))
+			return prev;
+
+		if (cpus_share_resources(prev, target))
+			return prev;
+		prev_aff = prev;
+	}
 
 	/*
 	 * Allow a per-cpu kthread to stack with the wakee if the
@@ -7176,7 +7206,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
-		return recent_used_cpu;
+		if (!static_branch_unlikely(&sched_cluster_active))
+			return recent_used_cpu;
+
+		if (cpus_share_resources(recent_used_cpu, target))
+			return recent_used_cpu;
+	} else {
+		recent_used_cpu = -1;
 	}
 
 	/*
@@ -7217,6 +7253,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	/*
+	 * For cluster machines which have lower sharing cache like L2 or
+	 * LLC Tag, we tend to find an idle CPU in the target's cluster
+	 * first. But prev_cpu or recent_used_cpu may also be a good candidate,
+	 * use them if possible when no idle CPU found in select_idle_cpu().
+	 */
+	if ((unsigned int)prev_aff < nr_cpumask_bits &&
+	    (available_idle_cpu(prev_aff) || sched_idle_cpu(prev_aff)))
+		return prev_aff;
+	if ((unsigned int)recent_used_cpu < nr_cpumask_bits &&
+	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)))
+		return recent_used_cpu;
+
 	return target;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4ff8cdc5a55a..ebf53f98f5f7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1853,6 +1853,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
+extern struct static_key_false sched_cluster_active;
 
 static __always_inline bool sched_asym_cpucap_active(void)
 {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ce1fd8e00346..2b8f419179d3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -671,7 +671,9 @@ DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
+
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
+DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -2366,6 +2368,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
 	bool has_asym = false;
+	bool has_cluster = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
 		goto error;
@@ -2491,12 +2494,18 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 			WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
 
 		cpu_attach_domain(sd, d.rd, i);
+
+		if (lowest_flag_domain(i, SD_CLUSTER))
+			has_cluster = true;
 	}
 	rcu_read_unlock();
 
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
+	if (has_cluster)
+		static_branch_inc_cpuslocked(&sched_cluster_active);
+
 	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
@@ -2596,6 +2605,9 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
 	if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
 		static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
 
+	if (static_branch_unlikely(&sched_cluster_active))
+		static_branch_dec_cpuslocked(&sched_cluster_active);
+
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map)
 		cpu_attach_domain(NULL, &def_root_domain, i);
-- 
2.24.0

