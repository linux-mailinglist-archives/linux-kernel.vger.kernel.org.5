Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9078CCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbjH2TcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbjH2Tbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:31:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F722193;
        Tue, 29 Aug 2023 12:31:47 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:31:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gTeaCmCaZwhpNCKwzsyZOQslYR8QleUrypSp+WC1Hs=;
        b=VEvrIFg1lbO0/60zDSnd1H8nfjW4fCLID+ZGUDSKh4GLx2e0OIBVP6swRgmyl9NYnDu0tT
        RYBDiBSuvktzLupF8FdDvFmeWH5GC4insAY+7xCfHL9iH0l3L8rHpZ2yA+Ya4Im5YWTIxl
        n9ImErV26OmbDOrqM180vJEyEdRt7hgvPRVs51WwOUm89Zdm4ykIQww+KR7Ttd3XTXb+mX
        34llAu+wMXUohi54LOAb+7zz73aaHPfJb28OEtANtzbrrVgdIbbVQdCw+pBB4a2w6UDUyz
        6pZo3UDBJyKnrt8i0X9VCNh+dOtLQTqFKDmnxWuPAajNYIO6ixKwZ3kZJGbgwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gTeaCmCaZwhpNCKwzsyZOQslYR8QleUrypSp+WC1Hs=;
        b=ooaoBh/z7txFRAPjJVy5tOGUhxkX2cxtqe0j0mAf0mdnk3ACLVpxXiVcjkQ0WDTuHFYRIh
        v9Z5rqQY1Mm3pWDg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Factor out the initialization code
 for ADL e-core
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829125806.3016082-4-kan.liang@linux.intel.com>
References: <20230829125806.3016082-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169333750555.27769.9134949396302927831.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d87d221f854b62f5e8026505497d33404ef6050c
Gitweb:        https://git.kernel.org/tip/d87d221f854b62f5e8026505497d33404ef6050c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 29 Aug 2023 05:58:03 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 20:59:22 +02:00

perf/x86/intel: Factor out the initialization code for ADL e-core

>From PMU's perspective, the ADL e-core and newer SRF/GRR have a similar
uarch. Most of the initialization code can be shared.

Factor out intel_pmu_init_grt() for the common initialization code.
The common part of the ADL e-core will be replaced by the later patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829125806.3016082-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 58 ++++++++++++-----------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 86aad32..95ac7bb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5940,6 +5940,25 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
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
@@ -6218,28 +6237,10 @@ __init int intel_pmu_init(void)
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
@@ -6249,28 +6250,11 @@ __init int intel_pmu_init(void)
 
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
