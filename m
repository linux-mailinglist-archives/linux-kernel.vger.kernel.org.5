Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A67878C49F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbjH2M6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjH2M6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:58:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1289BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313883; x=1724849883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QldM16VWt9sIxeALCKvfIhayNh8wAJ4+hob5Nr/kC4A=;
  b=HjFR5bc+UF6rzaSOPWwrgzWlzlvwSaZAx6gnP4SlCOZXN3F4u+KS2MGb
   fwb5FRkNoNlokwMOvEXBwaUzf1/f5nJSzEj1sQ1Wjkq2IhOAk42bZi1Qu
   +T2hzbRXKVOrgmTYUiajHIMAF9YBt+hmKyELpIfjugQmWlzoEtqWkrcdU
   zZg1twmyH+zsFcBzuYF+7Ff1xo6h1NClw2nATA+rtK/9dl5zaotv7NE3Z
   T3s8WD9WFsdtIfPjfGqrDu4eyKJn5WcwpVQLkDgmZINAbI8lD3/lW2PfH
   IryPHlD+/YjDo/rNQvU0uhsrrWwmkLy6R1z6tYdQ4YJ1ZXOB3wqPDIM8q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406354912"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406354912"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853272014"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853272014"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 05:58:03 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     dapeng1.mi@linux.intel.com, zhenyuw@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/6] perf/x86/intel: Factor out the initialization code for SPR
Date:   Tue, 29 Aug 2023 05:58:02 -0700
Message-Id: <20230829125806.3016082-3-kan.liang@linux.intel.com>
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

The SPR and ADL p-core have a similar uarch. Most of the initialization
code can be shared.

Factor out intel_pmu_init_glc() for the common initialization code.
The common part of the ADL p-core will be replaced by the later patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 49 +++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6c98c272d4f8..e9e69401524a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5909,6 +5909,30 @@ static __always_inline bool is_mtl(u8 x86_model)
 	       (x86_model == INTEL_FAM6_METEORLAKE_L);
 }
 
+static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
+{
+	x86_pmu.late_ack = true;
+	x86_pmu.limit_period = glc_limit_period;
+	x86_pmu.pebs_aliases = NULL;
+	x86_pmu.pebs_prec_dist = true;
+	x86_pmu.pebs_block = true;
+	x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+	x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+	x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+	x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
+	x86_pmu.lbr_pt_coexist = true;
+	x86_pmu.num_topdown_events = 8;
+	static_call_update(intel_pmu_update_topdown_event,
+			   &icl_update_topdown_event);
+	static_call_update(intel_pmu_set_topdown_event_period,
+			   &icl_set_topdown_event_period);
+
+	memcpy(hybrid_var(pmu, hw_cache_event_ids), glc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs), glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid(pmu, event_constraints) = intel_glc_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_glc_pebs_event_constraints;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -6560,24 +6584,10 @@ __init int intel_pmu_init(void)
 		fallthrough;
 	case INTEL_FAM6_GRANITERAPIDS_X:
 	case INTEL_FAM6_GRANITERAPIDS_D:
-		pmem = true;
-		x86_pmu.late_ack = true;
-		memcpy(hw_cache_event_ids, glc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
-		memcpy(hw_cache_extra_regs, glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
-
-		x86_pmu.event_constraints = intel_glc_event_constraints;
-		x86_pmu.pebs_constraints = intel_glc_pebs_event_constraints;
+		intel_pmu_init_glc(NULL);
 		if (!x86_pmu.extra_regs)
 			x86_pmu.extra_regs = intel_rwc_extra_regs;
-		x86_pmu.limit_period = glc_limit_period;
 		x86_pmu.pebs_ept = 1;
-		x86_pmu.pebs_aliases = NULL;
-		x86_pmu.pebs_prec_dist = true;
-		x86_pmu.pebs_block = true;
-		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
-		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
@@ -6586,14 +6596,7 @@ __init int intel_pmu_init(void)
 		mem_attr = glc_events_attrs;
 		td_attr = glc_td_events_attrs;
 		tsx_attr = glc_tsx_events_attrs;
-		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
-		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_skl(pmem);
-		x86_pmu.num_topdown_events = 8;
-		static_call_update(intel_pmu_update_topdown_event,
-				   &icl_update_topdown_event);
-		static_call_update(intel_pmu_set_topdown_event_period,
-				   &icl_set_topdown_event_period);
+		intel_pmu_pebs_data_source_skl(true);
 		pr_cont("Sapphire Rapids events, ");
 		name = "sapphire_rapids";
 		break;
-- 
2.35.1

