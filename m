Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCABF7728BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHGPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHGPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:08:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21481FCB;
        Mon,  7 Aug 2023 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=66ekyCUENIMavZ2WhIojiSg1D0xOpQjxDO9xj4o0pFA=; b=B+YPt6k+SELqFxYUyoGZ4aZghj
        SolJUHMptDwcpbVVgWah5ZyJLHjGPK/rv2nTcBH9zYEirqvgzIH2KQg0bwLKKW/33HmhH0Fjy/CXJ
        LrttrTWs3M6q7ctvgp6lsoAncR0JQpb3Bx+CUoD/17s4YUkU2z1Qq9HKWA7skqdKeGebs4PNEGoVp
        KAOBBbxZEZ002IgCQPiOhP6jSO7inIlhY0ZZgCYw1If0pNFt4YzPy1/QM7uFztQ5DQ7wigfkxScHh
        4BbR85++bcv3DkcD10CoadC+6YZW2xL1PGqWf7awebxcIDCnuj/joVWb13yCiPSmqKd9SPb6qk7vc
        4WrsO4nw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qT1pP-003w7m-38;
        Mon, 07 Aug 2023 15:07:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94828300473;
        Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 758B9202F9530; Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Message-ID: <20230807150405.686834933@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:38:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        Tony Luck <tony.luck@intel.com>, luto@kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/3] x86/cpu: Fix Gracemont uarch
References: <20230807123806.700370534@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alderlake N is an E-core only product using Gracemont
micro-architecture. It fits the pre-existing naming scheme perfectly
fine, adhere to it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c              |    2 +-
 arch/x86/events/intel/cstate.c            |    2 +-
 arch/x86/events/intel/uncore.c            |    2 +-
 arch/x86/events/msr.c                     |    2 +-
 arch/x86/events/rapl.c                    |    2 +-
 arch/x86/include/asm/intel-family.h       |    3 ++-
 arch/x86/kernel/cpu/intel_epb.c           |    2 +-
 arch/x86/mm/init.c                        |    2 +-
 drivers/idle/intel_idle.c                 |   10 +++++-----
 drivers/platform/x86/intel/pmc/core.c     |    2 +-
 drivers/powercap/intel_rapl_common.c      |    2 +-
 drivers/powercap/intel_rapl_msr.c         |    2 +-
 drivers/thermal/intel/intel_tcc_cooling.c |    2 +-
 tools/power/x86/turbostat/turbostat.c     |    2 +-
 14 files changed, 19 insertions(+), 18 deletions(-)

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
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -669,6 +669,7 @@ static const struct x86_cpu_id intel_cst
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
@@ -684,7 +685,6 @@ static const struct x86_cpu_id intel_cst
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1858,7 +1858,6 @@ static const struct x86_cpu_id intel_unc
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
@@ -1867,6 +1866,7 @@ static const struct x86_cpu_id intel_unc
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_uncore_init),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -106,7 +106,7 @@ static bool test_intel(int idx, void *da
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -804,7 +804,7 @@ static const struct x86_cpu_id rapl_mode
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&model_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
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
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -206,7 +206,7 @@ static int intel_epb_offline(unsigned in
 static const struct x86_cpu_id intel_epb_normal[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,
 				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,
 				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,
 				   ENERGY_PERF_BIAS_NORMAL_POWERSAVE),
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -273,7 +273,7 @@ static void __init probe_page_size_mask(
 static const struct x86_cpu_id invlpg_miss_ids[] = {
 	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
 	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
+	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
 	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
 	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
 	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -960,7 +960,7 @@ static struct cpuidle_state adl_l_cstate
 		.enter = NULL }
 };
 
-static struct cpuidle_state adl_n_cstates[] __initdata = {
+static struct cpuidle_state gmt_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -1405,8 +1405,8 @@ static const struct idle_cpu idle_cpu_ad
 	.state_table = adl_l_cstates,
 };
 
-static const struct idle_cpu idle_cpu_adl_n __initconst = {
-	.state_table = adl_n_cstates,
+static const struct idle_cpu idle_cpu_gmt __initconst = {
+	.state_table = gmt_cstates,
 };
 
 static const struct idle_cpu idle_cpu_spr __initconst = {
@@ -1479,7 +1479,7 @@ static const struct x86_cpu_id intel_idl
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&idle_cpu_adl_n),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&idle_cpu_gmt),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
@@ -1979,7 +1979,7 @@ static void __init intel_idle_init_cstat
 		break;
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 		adl_idle_state_table_update();
 		break;
 	}
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1123,7 +1123,7 @@ static const struct x86_cpu_id intel_pmc
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_core_init),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1250,7 +1250,7 @@ static const struct x86_cpu_id rapl_ids[
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -141,7 +141,7 @@ static const struct x86_cpu_id pl4_suppo
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -60,7 +60,7 @@ static const struct x86_cpu_id tcc_ids[]
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5447,7 +5447,7 @@ unsigned int intel_model_duplicates(unsi
 	case INTEL_FAM6_LAKEFIELD:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
-	case INTEL_FAM6_ALDERLAKE_N:
+	case INTEL_FAM6_ATOM_GRACEMONT:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:


