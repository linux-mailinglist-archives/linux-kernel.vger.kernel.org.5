Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7601C7BDCF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376634AbjJINAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376619AbjJINAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:00:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1406791;
        Mon,  9 Oct 2023 05:59:59 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:59:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696856397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3HiOIZsIyFdSr2F1fohkWTnmCwztZew7iNH3Hzfqy0=;
        b=3VZ0ahc2vWr0EhBmOY8Q4zuJziiyQaMgsxgPhUk2RZCZi1QqsgXzCxpk7I8YLzC+3hbOCr
        4GDkmDqo9ny9XdBDUGqOWpOUdGSGpT64Dbjmsb/rXWQwMAmdaeNtO0kEMl/M82e4cBjX/n
        EXI0+9Itz+rKHX21X5+c13MQ/qiZvM4RD5qwlbyBAhbd9ppJsRIN9D6e2FKamqOGlpc8ec
        NeGT4VKMVeKICPjZRjjKS2rgfw8McVh6e8/Be6AWCUyD1V9HzwQoRAuFqTT4TeFSWEV4a7
        ICiQ4BGuqqqbkRlQW4uN5wVrCW3+XLy0BNZHndz/L8cukqCAazafuozzV6WLMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696856397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3HiOIZsIyFdSr2F1fohkWTnmCwztZew7iNH3Hzfqy0=;
        b=jv4T7h4BZ+jdHPZy2FeGFL1XL2SnzTHcRqO61BMC4I9/xWilrvR3GH9InE2xlMXazd1i6N
        dqbrWl8DZEu902Bw==
From:   "tip-bot2 for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove the EM_MAX_COMPLEXITY limit
Cc:     Pierre Gondois <Pierre.Gondois@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009060037.170765-2-sshegde@linux.vnet.ibm.com>
References: <20231009060037.170765-2-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <169685639709.3135.8213502166667270279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5b77261c5510f1e6f4d359e97dd3e39ee7259c3d
Gitweb:        https://git.kernel.org/tip/5b77261c5510f1e6f4d359e97dd3e39ee7259c3d
Author:        Pierre Gondois <Pierre.Gondois@arm.com>
AuthorDate:    Mon, 09 Oct 2023 11:30:36 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 13:07:27 +02:00

sched/topology: Remove the EM_MAX_COMPLEXITY limit

The Energy Aware Scheduler (EAS) estimates the energy consumption
of placing a task on different CPUs. The goal is to minimize this
energy consumption. Estimating the energy of different task placements
is increasingly complex with the size of the platform.

To avoid having a slow wake-up path, EAS is only enabled if this
complexity is low enough.

The current complexity limit was set in:

  b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate platforms")

... based on the first implementation of EAS, which was re-computing
the power of the whole platform for each task placement scenario, see:

  390031e4c309 ("sched/fair: Introduce an energy estimation helper function")

... but the complexity of EAS was reduced in:

  eb92692b2544d ("sched/fair: Speed-up energy-aware wake-ups")

... and find_energy_efficient_cpu() (feec) algorithm was updated in:

  3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")

find_energy_efficient_cpu() (feec) is now doing:

	feec()
	\_ for_each_pd(pd) [0]
	  // get max_spare_cap_cpu and compute_prev_delta
	  \_ for_each_cpu(pd) [1]

	  \_ eenv_pd_busy_time(pd) [2]
		\_ for_each_cpu(pd)

	  // compute_energy(pd) without the task
	  \_ eenv_pd_max_util(pd, -1) [3.0]
	    \_ for_each_cpu(pd)
	  \_ em_cpu_energy(pd, -1)
	    \_ for_each_ps(pd)

	  // compute_energy(pd) with the task on prev_cpu
	  \_ eenv_pd_max_util(pd, prev_cpu) [3.1]
	    \_ for_each_cpu(pd)
	  \_ em_cpu_energy(pd, prev_cpu)
	    \_ for_each_ps(pd)

	  // compute_energy(pd) with the task on max_spare_cap_cpu
	  \_ eenv_pd_max_util(pd, max_spare_cap_cpu) [3.2]
	    \_ for_each_cpu(pd)
	  \_ em_cpu_energy(pd, max_spare_cap_cpu)
	    \_ for_each_ps(pd)

	[3.1] happens only once since prev_cpu is unique. With the same
	      definitions for nr_pd, nr_cpus and nr_ps, the complexity is of:

		nr_pd * (2 * [nr_cpus in pd] + 2 * ([nr_cpus in pd] + [nr_ps in pd]))
		+ ([nr_cpus in pd] + [nr_ps in pd])

		 [0]  * (     [1] + [2]      +       [3.0] + [3.2]                  )
		+ [3.1]

		= nr_pd * (4 * [nr_cpus in pd] + 2 * [nr_ps in pd])
		+ [nr_cpus in prev pd] + nr_ps

The complexity limit was set to 2048 in:

  b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate platforms")

... to make "EAS usable up to 16 CPUs with per-CPU DVFS and less than 8
performance states each". For the same platform, the complexity would
actually be of:

  16 * (4 + 2 * 7) + 1 + 7 = 296

Since the EAS complexity was greatly reduced since the limit was
introduced, bigger platforms can handle EAS.

For instance, a platform with 112 CPUs with 7 performance states
each would not reach it:

  112 * (4 + 2 * 7) + 1 + 7 = 2024

To reflect this improvement in the underlying EAS code, remove
the EAS complexity check.

Note that a limit on the number of CPUs still holds against
EM_MAX_NUM_CPUS to avoid overflows during the energy estimation.

[ mingo: Updates to the changelog. ]

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20231009060037.170765-2-sshegde@linux.vnet.ibm.com
---
 Documentation/scheduler/sched-energy.rst | 29 +----------------
 kernel/sched/topology.c                  | 39 +----------------------
 2 files changed, 6 insertions(+), 62 deletions(-)

diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index fc853c8..70e2921 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -359,32 +359,9 @@ in milli-Watts or in an 'abstract scale'.
 6.3 - Energy Model complexity
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The task wake-up path is very latency-sensitive. When the EM of a platform is
-too complex (too many CPUs, too many performance domains, too many performance
-states, ...), the cost of using it in the wake-up path can become prohibitive.
-The energy-aware wake-up algorithm has a complexity of:
-
-	C = Nd * (Nc + Ns)
-
-with: Nd the number of performance domains; Nc the number of CPUs; and Ns the
-total number of OPPs (ex: for two perf. domains with 4 OPPs each, Ns = 8).
-
-A complexity check is performed at the root domain level, when scheduling
-domains are built. EAS will not start on a root domain if its C happens to be
-higher than the completely arbitrary EM_MAX_COMPLEXITY threshold (2048 at the
-time of writing).
-
-If you really want to use EAS but the complexity of your platform's Energy
-Model is too high to be used with a single root domain, you're left with only
-two possible options:
-
-    1. split your system into separate, smaller, root domains using exclusive
-       cpusets and enable EAS locally on each of them. This option has the
-       benefit to work out of the box but the drawback of preventing load
-       balance between root domains, which can result in an unbalanced system
-       overall;
-    2. submit patches to reduce the complexity of the EAS wake-up algorithm,
-       hence enabling it to cope with larger EMs in reasonable time.
+EAS does not impose any complexity limit on the number of PDs/OPPs/CPUs but
+restricts the number of CPUs to EM_MAX_NUM_CPUS to prevent overflows during
+the energy estimation.
 
 
 6.4 - Schedutil governor
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1cc5959..fcda3f0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -348,32 +348,13 @@ static void sched_energy_set(bool has_eas)
  *    1. an Energy Model (EM) is available;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. no SMT is detected.
- *    4. the EM complexity is low enough to keep scheduling overheads low;
- *    5. schedutil is driving the frequency of all CPUs of the rd;
- *    6. frequency invariance support is present;
- *
- * The complexity of the Energy Model is defined as:
- *
- *              C = nr_pd * (nr_cpus + nr_ps)
- *
- * with parameters defined as:
- *  - nr_pd:    the number of performance domains
- *  - nr_cpus:  the number of CPUs
- *  - nr_ps:    the sum of the number of performance states of all performance
- *              domains (for example, on a system with 2 performance domains,
- *              with 10 performance states each, nr_ps = 2 * 10 = 20).
- *
- * It is generally not a good idea to use such a model in the wake-up path on
- * very complex platforms because of the associated scheduling overheads. The
- * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
- * with per-CPU DVFS and less than 8 performance states each, for example.
+ *    4. schedutil is driving the frequency of all CPUs of the rd;
+ *    5. frequency invariance support is present;
  */
-#define EM_MAX_COMPLEXITY 2048
-
 extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
-	int i, nr_pd = 0, nr_ps = 0, nr_cpus = cpumask_weight(cpu_map);
+	int i;
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
@@ -431,20 +412,6 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = pd;
 		pd = tmp;
-
-		/*
-		 * Count performance domains and performance states for the
-		 * complexity check.
-		 */
-		nr_pd++;
-		nr_ps += em_pd_nr_perf_states(pd->em_pd);
-	}
-
-	/* Bail out if the Energy Model complexity is too high. */
-	if (nr_pd * (nr_ps + nr_cpus) > EM_MAX_COMPLEXITY) {
-		WARN(1, "rd %*pbl: Failed to start EAS, EM complexity is too high\n",
-						cpumask_pr_args(cpu_map));
-		goto free;
 	}
 
 	perf_domain_debug(cpu_map, pd);
