Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F042C776974
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjHIUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:05:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C910CF;
        Wed,  9 Aug 2023 13:05:01 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:04:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691611500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da2DVPK32kMqv/V4/F8umhzZV/X97UbiTtN0tntwD5Q=;
        b=DMY32+IcBW/vl+9uQvJjU9hmELWpoWvDREN9axe8vrGtm5ep+sk4NmVdTU5Lb1eyxhgJEy
        x0FF0Kqj6q9E2nUULJ1JfS8JAhIdvVYAFhjOPpKdkCzttliwUSxkEWbWULHsQ5Zn1I1hZo
        c0nkmf8v1RiqiT0RR4CqT9L+xsjO73+9B3N2cT1Yc0gTFjrQuOy2dRPzWZ2vASNVBEWumW
        tgrq/rIbWhyF9DSx2d0Eg6vTqe+hHmsvNrr3+17XvzzJiYIN/0UqHTQCRGn7QZOPjOERkK
        rQv9B53tTFBRnFXwey03HxxIGJPj9ny4UW+LfadM840AMre8AZE8NB5nYbJpnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691611500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da2DVPK32kMqv/V4/F8umhzZV/X97UbiTtN0tntwD5Q=;
        b=YMrvXELrKVug/xbpRguQsFvTU/7nkAWaHKbQ04dpgoP6puK17br7yJG1aawQDOJ3cn684G
        A55Zw0dY96UzdUBw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Crestmont PMU
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169161149918.27769.7106324049621373893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a430021faad6b4fa86c820fc3e7f8dbfc2f14fb4
Gitweb:        https://git.kernel.org/tip/a430021faad6b4fa86c820fc3e7f8dbfc2f14fb4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 22 May 2023 04:30:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Aug 2023 21:51:07 +02:00

perf/x86/intel: Add Crestmont PMU

The Grand Ridge and Sierra Forest are successors to Snow Ridge. They
both have Crestmont core. From the core PMU's perspective, they are
similar to the e-core of MTL. The only difference is the LBR event
logging feature, which will be implemented in the following patches.

Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/20230522113040.2329924-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 52 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  9 ++++--
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c7e7ed6..64a3533 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2129,6 +2129,17 @@ static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+EVENT_ATTR_STR(topdown-retiring,       td_retiring_cmt,        "event=0x72,umask=0x0");
+EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_cmt,        "event=0x73,umask=0x0");
+
+static struct attribute *cmt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_tnt),
+	EVENT_PTR(td_retiring_cmt),
+	EVENT_PTR(td_bad_spec_cmt),
+	EVENT_PTR(td_be_bound_tnt),
+	NULL
+};
+
 static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
 	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
 	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x800ff3ffffffffffull, RSP_0),
@@ -4840,6 +4851,8 @@ PMU_FORMAT_ATTR(ldlat, "config1:0-15");
 
 PMU_FORMAT_ATTR(frontend, "config1:0-23");
 
+PMU_FORMAT_ATTR(snoop_rsp, "config1:0-63");
+
 static struct attribute *intel_arch3_formats_attr[] = {
 	&format_attr_event.attr,
 	&format_attr_umask.attr,
@@ -4870,6 +4883,13 @@ static struct attribute *slm_format_attr[] = {
 	NULL
 };
 
+static struct attribute *cmt_format_attr[] = {
+	&format_attr_offcore_rsp.attr,
+	&format_attr_ldlat.attr,
+	&format_attr_snoop_rsp.attr,
+	NULL
+};
+
 static struct attribute *skl_format_attr[] = {
 	&format_attr_frontend.attr,
 	NULL,
@@ -5649,7 +5669,6 @@ static struct attribute *adl_hybrid_extra_attr[] = {
 	NULL
 };
 
-PMU_FORMAT_ATTR_SHOW(snoop_rsp, "config1:0-63");
 FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small);
 
 static struct attribute *mtl_hybrid_extra_attr_rtm[] = {
@@ -6197,6 +6216,37 @@ __init int intel_pmu_init(void)
 		name = "gracemont";
 		break;
 
+	case INTEL_FAM6_ATOM_CRESTMONT:
+	case INTEL_FAM6_ATOM_CRESTMONT_X:
+		x86_pmu.mid_ack = true;
+		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		x86_pmu.pebs_constraints = intel_grt_pebs_event_constraints;
+		x86_pmu.extra_regs = intel_cmt_extra_regs;
+
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.pebs_block = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+
+		intel_pmu_pebs_data_source_cmt();
+		x86_pmu.pebs_latency_data = mtl_latency_data_small;
+		x86_pmu.get_event_constraints = cmt_get_event_constraints;
+		x86_pmu.limit_period = spr_limit_period;
+		td_attr = cmt_events_attrs;
+		mem_attr = grt_mem_attrs;
+		extra_attr = cmt_format_attr;
+		pr_cont("Crestmont events, ");
+		name = "crestmont";
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index df88576..eb8dd8b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -144,7 +144,7 @@ void __init intel_pmu_pebs_data_source_adl(void)
 	__intel_pmu_pebs_data_source_grt(data_source);
 }
 
-static void __init intel_pmu_pebs_data_source_cmt(u64 *data_source)
+static void __init __intel_pmu_pebs_data_source_cmt(u64 *data_source)
 {
 	data_source[0x07] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOPX, FWD);
 	data_source[0x08] = OP_LH | P(LVL, L3) | LEVEL(L3) | P(SNOOP, HITM);
@@ -164,7 +164,12 @@ void __init intel_pmu_pebs_data_source_mtl(void)
 
 	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
 	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
-	intel_pmu_pebs_data_source_cmt(data_source);
+	__intel_pmu_pebs_data_source_cmt(data_source);
+}
+
+void __init intel_pmu_pebs_data_source_cmt(void)
+{
+	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
 }
 
 static u64 precise_store_data(u64 status)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d6de448..c8ba2be 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1606,6 +1606,8 @@ void intel_pmu_pebs_data_source_grt(void);
 
 void intel_pmu_pebs_data_source_mtl(void);
 
+void intel_pmu_pebs_data_source_cmt(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
