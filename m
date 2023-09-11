Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84579B978
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbjIKVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbjIKOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:41:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C33E6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694443279; x=1725979279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fP6lcYAEFq9U7qSWfa1lBWDCFuWhwBgw5CCzMRcZCBs=;
  b=RVABoi2VPi9HvoRUnFhPmwPUIrednC4UJA3VORY3GZi2ED7ebuowLx+z
   y3IrWPaxezMrM/luRMjZofMJq5g5ZXAKNKe5tCMK456KVPRwr4SYVDi3S
   Yj+N8jcDalzqaOv5/Ij0DUccJRpYCD7xnl+XT5Zm4enqSDh7xmwMkArhL
   gg0Q5WYphGt9VIubJNx/aNRiiaCX7i0yVAp9+2Rt1Omz0wW5b18+aouxZ
   0s/fwHhiYFIMf3NCZ3SGpwszVixI4FSySZHtNkW5SAJaqNbEsxSwiOPEZ
   OISs5U25YfGGWNNfgXYFs6H7BZXepXn2VJAVNisPD7pZ3tCKhq8c0HMi/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377011639"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377011639"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="808847165"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="808847165"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2023 07:41:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Extend the ref-cycles event to GP counters
Date:   Mon, 11 Sep 2023 07:41:38 -0700
Message-Id: <20230911144139.2354015-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The current ref-cycles event is only available on the fixed counter 2.
Starting from the GLC and GRT core, the architectural UnHalted Reference
Cycles event (0x013c) which is available on general-purpose counters
can collect the exact same events as the fixed counter 2.

Update the mapping of ref-cycles to 0x013c. So the ref-cycles can be
available on both fixed counter 2 and general-purpose counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e1543d6dc48a..a08f794a0e79 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -211,6 +211,14 @@ static struct event_constraint intel_slm_event_constraints[] __read_mostly =
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -314,6 +322,7 @@ static struct event_constraint intel_glc_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
@@ -5983,6 +5992,12 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 	return 0;
 }
 
+static __always_inline void intel_pmu_ref_cycles_ext(void)
+{
+	if (!(x86_pmu.events_maskl & (INTEL_PMC_MSK_FIXED_REF_CYCLES >> INTEL_PMC_IDX_FIXED)))
+		intel_perfmon_event_map[PERF_COUNT_HW_REF_CPU_CYCLES] = 0x013c;
+}
+
 static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
 {
 	x86_pmu.late_ack = true;
@@ -6005,6 +6020,8 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
 	memcpy(hybrid_var(pmu, hw_cache_extra_regs), glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	hybrid(pmu, event_constraints) = intel_glc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_glc_pebs_event_constraints;
+
+	intel_pmu_ref_cycles_ext();
 }
 
 static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
@@ -6021,9 +6038,11 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 	memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
-	hybrid(pmu, event_constraints) = intel_slm_event_constraints;
+	hybrid(pmu, event_constraints) = intel_grt_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_grt_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_grt_extra_regs;
+
+	intel_pmu_ref_cycles_ext();
 }
 
 __init int intel_pmu_init(void)
-- 
2.35.1

