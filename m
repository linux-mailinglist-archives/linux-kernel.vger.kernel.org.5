Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782F7CB9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjJQFXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjJQFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:23:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6FCA4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:23:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9D72F4;
        Mon, 16 Oct 2023 22:24:13 -0700 (PDT)
Received: from u200865.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0347E3F5A1;
        Mon, 16 Oct 2023 22:23:32 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, krisman@suse.de,
        broonie@kernel.org, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 1/3] arm64: cpufeature: Display the set of cores with a feature
Date:   Tue, 17 Oct 2023 00:23:20 -0500
Message-ID: <20231017052322.1211099-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017052322.1211099-1-jeremy.linton@arm.com>
References: <20231017052322.1211099-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMU feature can be enabled on a subset of the cores in a system.
Because of that, it prints a message for each core as it is detected.
This becomes tedious when there are hundreds of cores. Instead, for
CPU features which can be enabled on a subset of the present cores,
lets wait until update_cpu_capabilities() and print the subset of cores
the feature was enabled on.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/kernel/cpufeature.c      | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5bba39376055..19b4d001d845 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -23,6 +23,7 @@
 #include <linux/bug.h>
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
+#include <linux/cpumask.h>
 
 /*
  * CPU feature register tracking
@@ -380,6 +381,7 @@ struct arm64_cpu_capabilities {
 	 * method is robust against being called multiple times.
 	 */
 	const struct arm64_cpu_capabilities *match_list;
+	const struct cpumask *cpus;
 };
 
 static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 444a73c2e638..2dd695fc3472 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1944,8 +1944,6 @@ int get_cpu_with_amu_feat(void)
 static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 {
 	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
-		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
-			smp_processor_id());
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
 
 		/* 0 reference values signal broken/disabled counters */
@@ -2405,16 +2403,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #endif /* CONFIG_ARM64_RAS_EXTN */
 #ifdef CONFIG_ARM64_AMU_EXTN
 	{
-		/*
-		 * The feature is enabled by default if CONFIG_ARM64_AMU_EXTN=y.
-		 * Therefore, don't provide .desc as we don't want the detection
-		 * message to be shown until at least one CPU is detected to
-		 * support the feature.
-		 */
+		.desc = "Activity Monitors Unit (AMU)",
 		.capability = ARM64_HAS_AMU_EXTN,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.matches = has_amu,
 		.cpu_enable = cpu_amu_enable,
+		.cpus = &amu_cpus,
 		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, AMU, IMP)
 	},
 #endif /* CONFIG_ARM64_AMU_EXTN */
@@ -2981,7 +2975,7 @@ static void update_cpu_capabilities(u16 scope_mask)
 		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
-		if (caps->desc)
+		if (caps->desc && !caps->cpus)
 			pr_info("detected: %s\n", caps->desc);
 
 		__set_bit(caps->capability, system_cpucaps);
@@ -3330,6 +3324,7 @@ unsigned long cpu_get_elf_hwcap2(void)
 
 static void __init setup_system_capabilities(void)
 {
+	int i;
 	/*
 	 * We have finalised the system-wide safe feature
 	 * registers, finalise the capabilities that depend
@@ -3338,6 +3333,15 @@ static void __init setup_system_capabilities(void)
 	 */
 	update_cpu_capabilities(SCOPE_SYSTEM);
 	enable_cpu_capabilities(SCOPE_ALL & ~SCOPE_BOOT_CPU);
+
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		const struct arm64_cpu_capabilities *caps = cpucap_ptrs[i];
+
+		if (caps && caps->cpus && caps->desc &&
+			cpumask_any(caps->cpus) < nr_cpu_ids)
+			pr_info("detected: %s on CPU%*pbl\n",
+				caps->desc, cpumask_pr_args(caps->cpus));
+	}
 }
 
 void __init setup_cpu_features(void)
-- 
2.41.0

