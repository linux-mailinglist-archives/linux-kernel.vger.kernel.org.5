Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B947C7B28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJMBam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMBal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:30:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A548EBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:30:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C28113D5;
        Thu, 12 Oct 2023 18:31:19 -0700 (PDT)
Received: from u200865.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FD653F7A6;
        Thu, 12 Oct 2023 18:30:38 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, krisman@suse.de,
        broonie@kernel.org, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] arm64: cpufeature: Display the set of cores with a feature
Date:   Thu, 12 Oct 2023 20:30:16 -0500
Message-ID: <20231013013016.197102-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
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
---
 arch/arm64/include/asm/cpufeature.h |  2 ++
 arch/arm64/kernel/cpufeature.c      | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

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
index 444a73c2e638..18711e35924c 100644
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
@@ -2411,10 +2409,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		 * message to be shown until at least one CPU is detected to
 		 * support the feature.
 		 */
+		.desc = "Activity Monitors Unit (AMU)",
 		.capability = ARM64_HAS_AMU_EXTN,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.matches = has_amu,
 		.cpu_enable = cpu_amu_enable,
+		.cpus = &amu_cpus,
 		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, AMU, IMP)
 	},
 #endif /* CONFIG_ARM64_AMU_EXTN */
@@ -2981,7 +2981,7 @@ static void update_cpu_capabilities(u16 scope_mask)
 		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
-		if (caps->desc)
+		if (caps->desc && !caps->cpus)
 			pr_info("detected: %s\n", caps->desc);
 
 		__set_bit(caps->capability, system_cpucaps);
@@ -3330,6 +3330,7 @@ unsigned long cpu_get_elf_hwcap2(void)
 
 static void __init setup_system_capabilities(void)
 {
+	int i;
 	/*
 	 * We have finalised the system-wide safe feature
 	 * registers, finalise the capabilities that depend
@@ -3338,6 +3339,15 @@ static void __init setup_system_capabilities(void)
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

