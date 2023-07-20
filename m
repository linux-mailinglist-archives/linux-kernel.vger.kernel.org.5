Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9F75AA49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjGTJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjGTIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:34:29 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB5268E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:34:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kenan.liu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VnpHxp-_1689842063;
Received: from iZbp125ew08a9bxe5bn4s4Z.localdomain(mailfrom:Kenan.Liu@linux.alibaba.com fp:SMTPD_---0VnpHxp-_1689842063)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 16:34:24 +0800
From:   "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     luoben@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] sched/fair: Adjust CFS loadbalance for machine with qemu native CPU topology.
Date:   Thu, 20 Jul 2023 16:34:12 +0800
Message-Id: <1689842053-5291-2-git-send-email-Kenan.Liu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>

Multithreading workloads in VM with Qemu may encounter an unexpected
phenomenon: one hyperthread of a physical core is busy while its sibling
is idle. The main reason is that hyperthread index is consecutive in qemu
native x86 CPU model which is different from the physical topology. As the
current kernel scheduler implementation, hyperthread with an even ID
number will be picked up in a much higher probability during load-balancing
and load-deploying. To solve the imbalance, when on a machine with multi
core and hyperthread index is consecutive per core, change the result of
select_idle_core() according to the hyperthread on which the task ran
before.

Signed-off-by: Kenan.Liu <Kenan.Liu@linux.alibaba.com>
Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a739..ad7c93f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -125,6 +125,9 @@
 static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
+static bool smt_neighbour_topo;
+static bool core_smt_topo_detect;
+static unsigned int smt_nr_cpu = 2;
 
 int sched_thermal_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
@@ -140,6 +143,26 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 #ifdef CONFIG_SMP
+static void explore_core_smp_topology(void)
+{
+	int cpu = smp_processor_id(), sibling;
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+
+	if (nr_cpu_ids <= 2)
+		return;
+
+	smt_nr_cpu = cpumask_weight(smt_mask);
+	if (smt_nr_cpu < 2)
+		return;
+
+	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
+		if (cpu == sibling)
+			continue;
+		if (abs(cpu - sibling) == 1)
+			smt_neighbour_topo = true;
+	}
+}
+
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
  */
@@ -6887,9 +6910,16 @@ void __update_idle_core(struct rq *rq)
 static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	bool idle = true;
-	int cpu;
+	int cpu, sibling = core;
+
+	if (!core_smt_topo_detect) {
+		explore_core_smp_topology();
+		core_smt_topo_detect = true;
+	}
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		if (cpu != core)
+			sibling = cpu;
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
@@ -6905,8 +6935,12 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			*idle_cpu = cpu;
 	}
 
-	if (idle)
+	if (idle) {
+		if (!smt_neighbour_topo || unlikely(core % smt_nr_cpu))
+			return core;
+		core = task_cpu(p) % smt_nr_cpu ? core : sibling;
 		return core;
+	}
 
 	cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	return -1;
-- 
1.8.3.1

