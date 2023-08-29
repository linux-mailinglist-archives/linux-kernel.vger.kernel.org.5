Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7F78CD04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjH2TcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbjH2Tb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:31:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C6CC9;
        Tue, 29 Aug 2023 12:31:47 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:31:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693337506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEB0m2AyWDgJNjF1R2kq3IPfbfz3B3fvdogiTcLqWP8=;
        b=mu6rbg7hHKmuUTCzYXrnl2Wy4H6Sq3+bt2v/aduCwacaBCkmRcaoG7oybAP9ae+Ar/eLc4
        WmLE42lxWG93FOorVgf7yTJ+ZHggvM7swQS+OT5dsUmGqF6NsCSLFzNuEhlsZ57eSNJfAG
        ZSG933fYIgHFuWnQBd99igejXMa/uuJs7ZtiWW0klAK4ASb93ror5ZqOTMzvJ4Ck0TXYI2
        bQVlsU0ZZetx0sqxPP389GiGVCC6wuhEtD02oJ7piAwc7gwObOhSyFV6DffH/Hkh1vAYvr
        wYGpfJUuiD/Uecb4S3oPS95o9Ql9SlNQVniDlBF0cmMGf1B+RvJU4NL4v74jIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693337506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEB0m2AyWDgJNjF1R2kq3IPfbfz3B3fvdogiTcLqWP8=;
        b=Mxrq70A+adccEcV0YA77bQdT4DsfColxivr27HZt/+8vrU2j1+MKh/cJHCUAaGIhkqp/Y4
        +9G4D3j99zhFHXBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Factor out the initialization code for SPR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829125806.3016082-3-kan.liang@linux.intel.com>
References: <20230829125806.3016082-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169333750600.27769.11298820290383514120.tip-bot2@tip-bot2>
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

Commit-ID:     0ba0c03528e918a8f6b5aa63d502fdc6a9d80fc7
Gitweb:        https://git.kernel.org/tip/0ba0c03528e918a8f6b5aa63d502fdc6a9d80fc7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 29 Aug 2023 05:58:02 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Aug 2023 20:59:22 +02:00

perf/x86/intel: Factor out the initialization code for SPR

The SPR and ADL p-core have a similar uarch. Most of the initialization
code can be shared.

Factor out intel_pmu_init_glc() for the common initialization code.
The common part of the ADL p-core will be replaced by the later patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230829125806.3016082-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 49 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 93be19c..86aad32 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5916,6 +5916,30 @@ static __always_inline bool is_mtl(u8 x86_model)
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
@@ -6567,24 +6591,10 @@ __init int intel_pmu_init(void)
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
@@ -6593,14 +6603,7 @@ __init int intel_pmu_init(void)
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
