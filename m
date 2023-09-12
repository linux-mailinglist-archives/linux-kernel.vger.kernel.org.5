Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6BE79C836
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjILHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjILHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:31:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3506E73;
        Tue, 12 Sep 2023 00:31:40 -0700 (PDT)
Date:   Tue, 12 Sep 2023 07:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694503898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jet7XTWSaNPwbMS2DlU5TGqn0pZ8qPKgdrukyVrPsv4=;
        b=ZFXn7L7Cm2fpmWf+14jqlDDbl4RWyWlbN1FaYHDeGLeT44M4WBXMpuiVN0+0ruveLAX/13
        86CpvCjpHvwO2tJ/6Orrv8dnIXCZLnf3aXq7cnMgO4hZ6zvWW2OE71vFulDbMvcaC4AUXq
        r0wcJ9p331lsVIj72Wuq7g4ygu/O5JcEW9amneD2qfbQnZ3sY4V9mZm1cnlCE81Lvkb6/p
        W1HFEIwUviMuDFQRo20izVhAu1GCOccFP+Vofm64uJEa5kMmyGA/9K0u2b2lqjFve/fH2B
        jwEqY498Fj4YScmyPQPGRxoMyoVoLmAk2IW0V8d2ISl6hYNMNnse3u4qOpyQKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694503898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jet7XTWSaNPwbMS2DlU5TGqn0pZ8qPKgdrukyVrPsv4=;
        b=/cu2e7d5q2ZoiQZ8teqUo4w4wBBMSIOQWecYA4paUUu7p6/XeA8GkaQRYa+dNmq8JLz2tM
        b2okQRMpBB0aLVDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Fix broken fixed event constraints extension
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230911135128.2322833-1-kan.liang@linux.intel.com>
References: <20230911135128.2322833-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169450389818.27769.2767579659988778304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     950ecdc672aec9cd29036b2e2535b07c103af494
Gitweb:        https://git.kernel.org/tip/950ecdc672aec9cd29036b2e2535b07c103af494
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 11 Sep 2023 06:51:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Sep 2023 08:22:24 +02:00

perf/x86/intel: Fix broken fixed event constraints extension

Unnecessary multiplexing is triggered when running an "instructions"
event on an MTL.

perf stat -e cpu_core/instructions/,cpu_core/instructions/ -a sleep 1

 Performance counter stats for 'system wide':

       115,489,000      cpu_core/instructions/                (50.02%)
       127,433,777      cpu_core/instructions/                (49.98%)

       1.002294504 seconds time elapsed

Linux architectural perf events, e.g., cycles and instructions, usually
have dedicated fixed counters. These events also have equivalent events
which can be used in the general-purpose counters. The counters are
precious. In the intel_pmu_check_event_constraints(), perf check/extend
the event constraints of these events. So these events can utilize both
fixed counters and general-purpose counters.

The following cleanup commit:

  97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")

forgot adding the intel_pmu_check_event_constraints() into update_pmu_cap().
The architectural perf events cannot utilize the general-purpose counters.

The code to check and update the counters, event constraints and
extra_regs is the same among hybrid systems. Move
intel_pmu_check_hybrid_pmus() to init_hybrid_pmu(), and
emove the duplicate check in update_pmu_cap().

Fixes: 97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230911135128.2322833-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 65 ++++++++++++++---------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 83dfbba..e1543d6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4598,6 +4598,13 @@ static void intel_pmu_check_num_counters(int *num_counters,
 					 int *num_counters_fixed,
 					 u64 *intel_ctrl, u64 fixed_mask);
 
+static void intel_pmu_check_event_constraints(struct event_constraint *event_constraints,
+					      int num_counters,
+					      int num_counters_fixed,
+					      u64 intel_ctrl);
+
+static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
+
 static inline bool intel_pmu_broken_perf_cap(void)
 {
 	/* The Perf Metric (Bit 15) is always cleared */
@@ -4618,12 +4625,6 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 			    &eax, &ebx, &ecx, &edx);
 		pmu->num_counters = fls(eax);
 		pmu->num_counters_fixed = fls(ebx);
-		intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
-					     &pmu->intel_ctrl, ebx);
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
-		pmu->unconstrained = (struct event_constraint)
-				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
-							0, pmu->num_counters, 0, 0);
 	}
 
 
@@ -4631,6 +4632,16 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
 	}
+}
+
+static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
+{
+	intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
+				     &pmu->intel_ctrl, (1ULL << pmu->num_counters_fixed) - 1);
+	pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+	pmu->unconstrained = (struct event_constraint)
+			     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+						0, pmu->num_counters, 0, 0);
 
 	if (pmu->intel_cap.perf_metrics)
 		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
@@ -4641,6 +4652,13 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 	else
 		pmu->pmu.capabilities |= ~PERF_PMU_CAP_AUX_OUTPUT;
+
+	intel_pmu_check_event_constraints(pmu->event_constraints,
+					  pmu->num_counters,
+					  pmu->num_counters_fixed,
+					  pmu->intel_ctrl);
+
+	intel_pmu_check_extra_regs(pmu->extra_regs);
 }
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
@@ -4696,6 +4714,8 @@ static bool init_hybrid_pmu(int cpu)
 	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(pmu);
 
+	intel_pmu_check_hybrid_pmus(pmu);
+
 	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
 		return false;
 
@@ -5915,36 +5935,6 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
 	}
 }
 
-static void intel_pmu_check_hybrid_pmus(u64 fixed_mask)
-{
-	struct x86_hybrid_pmu *pmu;
-	int i;
-
-	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		pmu = &x86_pmu.hybrid_pmu[i];
-
-		intel_pmu_check_num_counters(&pmu->num_counters,
-					     &pmu->num_counters_fixed,
-					     &pmu->intel_ctrl,
-					     fixed_mask);
-
-		if (pmu->intel_cap.perf_metrics) {
-			pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
-			pmu->intel_ctrl |= INTEL_PMC_MSK_FIXED_SLOTS;
-		}
-
-		if (pmu->intel_cap.pebs_output_pt_available)
-			pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
-
-		intel_pmu_check_event_constraints(pmu->event_constraints,
-						  pmu->num_counters,
-						  pmu->num_counters_fixed,
-						  pmu->intel_ctrl);
-
-		intel_pmu_check_extra_regs(pmu->extra_regs);
-	}
-}
-
 static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
 	{ hybrid_small, "cpu_atom" },
 	{ hybrid_big, "cpu_core" },
@@ -6869,9 +6859,6 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
-	if (is_hybrid() && !boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
-
 	if (x86_pmu.intel_cap.pebs_timing_info)
 		x86_pmu.flags |= PMU_FL_RETIRE_LATENCY;
 
