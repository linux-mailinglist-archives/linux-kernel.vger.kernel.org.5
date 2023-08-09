Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D405776973
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjHIUFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjHIUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0119310C4;
        Wed,  9 Aug 2023 13:05:02 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:05:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691611501;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdlxZPMpdCMOYpFCXewQFlmLJwiODe3OfBy7LkkokeI=;
        b=B/NQ+cD1hFPdQeBzgYMz26Bf6Zqb5+ZayJAufhExAp42QTlQgW60q7Km77hEoQcbaB44mj
        N2zGVzTsI1qauEZPTdBFLbXPHPyYDInIC95fJtas8F0I4u2xMkFf25c5aguIuE8h5nOoyl
        wnhzh6L9RXYwbhKWSKWKlMR6R2yHaRKbA6OkTnCph0B1QLcaeqZ7lKYkGhf3eSVhmrnWyU
        FfsXr9lqSVVBrVKMk2TTpvnlLsIY1Ox/0SU3C0shSWhxmacO4mnNjQ8HU/Wfx4tsG/ZiMQ
        QM+UQPnuysA3sz9FQgEpxx+v0MjBBwcwCSzCaMcQKzgt5y8tu0dnkzUD6xMlVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691611501;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdlxZPMpdCMOYpFCXewQFlmLJwiODe3OfBy7LkkokeI=;
        b=1UxrE7CKVUzLrF+wtPcn0NF5jxay1J1L6YTZKOXhlALTGlt5px+wl6BFyDmpl1JqFFIUGp
        9MXmMRPEK2fb7gCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Fix Gracemont uarch
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807150405.686834933@infradead.org>
References: <20230807150405.686834933@infradead.org>
MIME-Version: 1.0
Message-ID: <169161150071.27769.11191928945885213108.tip-bot2@tip-bot2>
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

Commit-ID:     882cdb06b668488a42ef717a260c05ba7dc43a49
Gitweb:        https://git.kernel.org/tip/882cdb06b668488a42ef717a260c05ba7dc43a49
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 07 Aug 2023 14:38:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Aug 2023 21:51:06 +02:00

x86/cpu: Fix Gracemont uarch

Alderlake N is an E-core only product using Gracemont
micro-architecture. It fits the pre-existing naming scheme perfectly
fine, adhere to it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230807150405.686834933@infradead.org
---
 arch/x86/events/intel/core.c              |  2 +-
 arch/x86/events/intel/cstate.c            |  2 +-
 arch/x86/events/intel/uncore.c            |  2 +-
 arch/x86/events/msr.c                     |  2 +-
 arch/x86/events/rapl.c                    |  2 +-
 arch/x86/include/asm/intel-family.h       |  3 ++-
 arch/x86/kernel/cpu/intel_epb.c           |  2 +-
 arch/x86/mm/init.c                        |  2 +-
 drivers/idle/intel_idle.c                 | 10 +++++-----
 drivers/platform/x86/intel/pmc/core.c     |  2 +-
 drivers/powercap/intel_rapl_common.c      |  2 +-
 drivers/powercap/intel_rapl_msr.c         |  2 +-
 drivers/thermal/intel/intel_tcc_cooling.c |  2 +-
 tools/power/x86/turbostat/turbostat.c     |  2 +-
 14 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a149faf..c7e7ed6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6167,7 +6167,7 @@ __init int intel_pmu_init(void)
 		name = "Tremont";
 		break;
 
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 		x86_pmu.mid_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 97035db..96fffb2 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -669,6 +669,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
@@ -684,7 +685,6 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index bc22660..69043e0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1858,7 +1858,6 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
@@ -1867,6 +1866,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 61c59e0..9e237b3 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -106,7 +106,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 52e6e7e..1579429 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -804,7 +804,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&model_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b3af2d4..4041326 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -114,7 +114,6 @@
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
-#define INTEL_FAM6_ALDERLAKE_N		0xBE
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
@@ -154,6 +153,8 @@
 #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
 #define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
 
+#define INTEL_FAM6_ATOM_GRACEMONT	0xBE /* Alderlake N */
+
 #define INTEL_FAM6_SIERRAFOREST_X	0xAF
 
 #define INTEL_FAM6_GRANDRIDGE		0xB6
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index 3b84761..e4c3ba9 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -206,7 +206,7 @@ static int intel_epb_offline(unsigned int cpu)
 static const struct x86_cpu_id intel_epb_normal[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
 				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,
 				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
 				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8192452..ad207f3 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -273,7 +273,7 @@ static void __init probe_page_size_mask(void)
 static const struct x86_cpu_id invlpg_miss_ids[] = {
 	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
 	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
+	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
 	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
 	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
 	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b930036..46c6de3 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -960,7 +960,7 @@ static struct cpuidle_state adl_l_cstates[] __initdata = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state adl_n_cstates[] __initdata = {
+static struct cpuidle_state gmt_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -1405,8 +1405,8 @@ static const struct idle_cpu idle_cpu_adl_l __initconst = {
 	.state_table = adl_l_cstates,
 };
 
-static const struct idle_cpu idle_cpu_adl_n __initconst = {
-	.state_table = adl_n_cstates,
+static const struct idle_cpu idle_cpu_gmt __initconst = {
+	.state_table = gmt_cstates,
 };
 
 static const struct idle_cpu idle_cpu_spr __initconst = {
@@ -1479,7 +1479,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&idle_cpu_adl_n),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&idle_cpu_gmt),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
@@ -1979,7 +1979,7 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		break;
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 		adl_idle_state_table_update();
 		break;
 	}
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5a36b3f..84c175b 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1123,7 +1123,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 4e646e5..a942a25 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1250,7 +1250,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 569e25e..1e775b0 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -141,7 +141,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index e95f799..6c39214 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -60,7 +60,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8a36ba5..9a10512 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5447,7 +5447,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_LAKEFIELD:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
