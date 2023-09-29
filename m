Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546D7B2E00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjI2Ijh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjI2IjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:39:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF7CD3;
        Fri, 29 Sep 2023 01:39:04 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:39:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695976743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VleefmjdcCp/KazIv8mxgFWlfnF4dtOyZiY7hzPqcss=;
        b=oE5J5Ihfbv63Jgncqr/0F8k73BaSYgdTcU+V0pQzzA/PG80z5HUrLHi/nm7+cx6cvwelUa
        icW8Y5chHC4rlltfyMg8UL1baJbuZUFZ74NUYsvNz1x++7M82Ai8XodcxVwiRGzwol9GtJ
        R+1/PWguxWs+3KDViDx3/4aKegu9gskrh4I2dZXtjH2QI4tc8a4ktZ9+Y+BiSf1JbttgtU
        FJm6UmszTINFV913sKETo0fydFEEdIWa98RkztCUkNuKwNnOtbzSztSITGdha/Y+PXfFPh
        LRbR2A/a7d0uRDVdalFEMS4BAUgLKuzN36gqBUk52btn89rGI6IQgWvnFmLHsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695976743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VleefmjdcCp/KazIv8mxgFWlfnF4dtOyZiY7hzPqcss=;
        b=vzFEz38cCWuZ4Ujq1Vki7a1HnKp+WRZWYvARZE/uk52+QD7/fZIR/j6oKfeTheSEOnPKWe
        tgmmy7HYVvLBMLCg==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Cc:     "Qais Yousef (Google)" <qyousef@layalina.io>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230916232955.2099394-2-qyousef@layalina.io>
References: <20230916232955.2099394-2-qyousef@layalina.io>
MIME-Version: 1.0
Message-ID: <169597674244.27769.17215104305593460514.tip-bot2@tip-bot2>
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

Commit-ID:     6b00a40147653c8ea748e8f4396510f252763364
Gitweb:        https://git.kernel.org/tip/6b00a40147653c8ea748e8f4396510f252763364
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Sun, 17 Sep 2023 00:29:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Sep 2023 10:29:14 +02:00

sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0

When uclamp_max is being used, the util of the task could be higher than
the spare capacity of the CPU, but due to uclamp_max value we force-fit
it there.

The way the condition for checking for max_spare_cap in
find_energy_efficient_cpu() was constructed; it ignored any CPU that has
its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
hence ending up never performing compute_energy() for this cluster and
missing an opportunity for a better energy efficient placement to honour
uclamp_max setting.

	max_spare_cap = 0;
	cpu_cap = capacity_of(cpu) - cpu_util(p);  // 0 if cpu_util(p) is high

	...

	util_fits_cpu(...);		// will return true if uclamp_max forces it to fit

	...

	// this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
	if (cpu_cap > max_spare_cap) {
		max_spare_cap = cpu_cap;
		max_spare_cap_cpu = cpu;
	}

prev_spare_cap suffers from a similar problem.

Fix the logic by converting the variables into long and treating -1
value as 'not populated' instead of 0 which is a viable and correct
spare capacity value. We need to be careful signed comparison is used
when comparing with cpu_cap in one of the conditions.

Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230916232955.2099394-2-qyousef@layalina.io
---
 kernel/sched/fair.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2973173..4ce949b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7703,11 +7703,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
-		unsigned long cur_delta, max_spare_cap = 0;
+		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long prev_spare_cap = 0;
+		unsigned long cur_delta, base_energy;
 		int max_spare_cap_cpu = -1;
-		unsigned long base_energy;
 		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
@@ -7770,7 +7769,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7782,7 +7781,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7790,7 +7789,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > 0) {
+		if (prev_spare_cap > -1) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
