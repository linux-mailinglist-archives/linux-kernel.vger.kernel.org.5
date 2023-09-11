Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE079B02C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbjIKUvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbjIKNv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:51:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF867FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694440279; x=1725976279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7WbtEAdAV3mORur/JCQXAcOnjxvqrw8areo/T/vSAg0=;
  b=nDkCjXnDLJZTmy5FK/pLy1aSUcdUE91Qyf9IR1k+L9MJAf2GPIwJLX38
   GgUrZQl1g0e+Vb4GrjlmMYB3Ts51CPQ3JjkaNrYW5ZKOeVJZC4NU7LqH9
   gJp8ncR0ljyztmCXjkbTCUqY6zIHa1ChMN3tVNOqw5TRAB20Z9h5ZcxSa
   rU3bukgQW9X6Dg/42OMpxFseMOjYc2uWtGaEEndyj2Fd2H+LpsON1xn1p
   i1hzoAtCshGjEI6MegJ/z/Vm5PWhjeitBxDfIJIRHV6m+9kNA11Ua/Oip
   geuQZ4Xorz82E2LdAlWljElvjy+TqYTOmmUf1wmZ/gNnl8m2tokdYmie7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375437544"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375437544"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693090780"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="693090780"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2023 06:51:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Fix broken fixed event constraints extension
Date:   Mon, 11 Sep 2023 06:51:28 -0700
Message-Id: <20230911135128.2322833-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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

The cleanup code commit 97588df87b56
("perf/x86/intel: Add common intel_pmu_init_hybrid()") forgot adding
the intel_pmu_check_event_constraints() into update_pmu_cap(). The
architectural perf events cannot utilize the general-purpose counters.

The codes to check and update the counters, event constraints and
extra_regs are the same among hybrid systems. Move
intel_pmu_check_hybrid_pmus() to the init_hybrid_pmu().
Remove the duplicate check in the update_pmu_cap().

Fixes: 97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 65 +++++++++++++++---------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 83dfbba1ee69..e1543d6dc48a 100644
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
 
-- 
2.35.1

