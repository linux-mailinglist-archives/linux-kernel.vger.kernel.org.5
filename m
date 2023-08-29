Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58378C49E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjH2M6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjH2M6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA406BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313884; x=1724849884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MgxxfOL3Ya8/z9wpXTgjf4K5Z5+XB/wR2Opc55Rkc0=;
  b=TJXiy3cUC99f9wwUPabQy2xeJSIjIQEkgqF007vNB6UiC02UYklUJmTm
   nESCEc0WoHTVJaZpPJaAq+Bg8OlXrp3L6YTBTgcp1kZPkMKgNYv+DtAu6
   EV5SdA3AtG+GP+XKulL/zYuJRGAJbhC+qAR/qai1z8FrY1F5nxjSOnjSl
   FgQArUVkmDUwFhTw/MkZTimw6Xcdc65fZwlKMOzPBp+RjdissGN+iSZSS
   NeEJKmiVPCJ3csdSRDZQ3jh20s03iU4w07oXuGJD6fa0OQdioPlc9J3hF
   fShq0pmCeSK7LPMexnK6zceeaNl7t1I3neeJ2jaEf8NJRONIoMYLT9llr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354916"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354916"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272023"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272023"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:04 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/6] perf/x86/intel: Factor out the initialization code for ADL e-core
Date:   Tue, 29 Aug 2023 05:58:03 -0700
Message-Id: <20230829125806.3016082-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230829125806.3016082-1-kan.liang@linux.intel.com>
References: <20230829125806.3016082-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, the ADL e-core and newer SRF/GRR have a similar
uarch. Most of the initialization code can be shared.

Factor out intel_pmu_init_grt() for the common initialization code.
The common part of the ADL e-core will be replaced by the later patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 58 +++++++++++++-----------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e9e69401524a..cffaa97035a0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5933,6 +5933,25 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
 	hybrid(pmu, pebs_constraints) = intel_glc_pebs_event_constraints;
 }
 
+static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
+{
+	x86_pmu.mid_ack = true;
+	x86_pmu.limit_period = glc_limit_period;
+	x86_pmu.pebs_aliases = NULL;
+	x86_pmu.pebs_prec_dist = true;
+	x86_pmu.pebs_block = true;
+	x86_pmu.lbr_pt_coexist = true;
+	x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+	x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+
+	memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+	hybrid(pmu, event_constraints) = intel_slm_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_grt_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_grt_extra_regs;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -6211,28 +6230,10 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GRACEMONT:
-		x86_pmu.mid_ack = true;
-		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
-		       sizeof(hw_cache_event_ids));
-		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
-		       sizeof(hw_cache_extra_regs));
-		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
-
-		x86_pmu.event_constraints = intel_slm_event_constraints;
-		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
-		x86_pmu.extra_regs = intel_grt_extra_regs;
-
-		x86_pmu.pebs_aliases = NULL;
-		x86_pmu.pebs_prec_dist = true;
-		x86_pmu.pebs_block = true;
-		x86_pmu.lbr_pt_coexist = true;
-		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-
+		intel_pmu_init_grt(NULL);
 		intel_pmu_pebs_data_source_grt();
 		x86_pmu.pebs_latency_data = adl_latency_data_small;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
-		x86_pmu.limit_period = glc_limit_period;
 		td_attr = tnt_events_attrs;
 		mem_attr = grt_mem_attrs;
 		extra_attr = nhm_format_attr;
@@ -6242,28 +6243,11 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_CRESTMONT:
 	case INTEL_FAM6_ATOM_CRESTMONT_X:
-		x86_pmu.mid_ack = true;
-		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
-		       sizeof(hw_cache_event_ids));
-		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
-		       sizeof(hw_cache_extra_regs));
-		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
-
-		x86_pmu.event_constraints = intel_slm_event_constraints;
-		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
+		intel_pmu_init_grt(NULL);
 		x86_pmu.extra_regs = intel_cmt_extra_regs;
-
-		x86_pmu.pebs_aliases = NULL;
-		x86_pmu.pebs_prec_dist = true;
-		x86_pmu.lbr_pt_coexist = true;
-		x86_pmu.pebs_block = true;
-		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-
 		intel_pmu_pebs_data_source_cmt();
 		x86_pmu.pebs_latency_data = mtl_latency_data_small;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
-		x86_pmu.limit_period = glc_limit_period;
 		td_attr = cmt_events_attrs;
 		mem_attr = grt_mem_attrs;
 		extra_attr = cmt_format_attr;
-- 
2.35.1

