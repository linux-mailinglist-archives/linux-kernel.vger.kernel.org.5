Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E57CB9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJQFXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjJQFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:23:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B70B6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:23:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A283FEC;
        Mon, 16 Oct 2023 22:24:15 -0700 (PDT)
Received: from u200865.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 507A03F5A1;
        Mon, 16 Oct 2023 22:23:34 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, krisman@suse.de,
        broonie@kernel.org, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 2/3] arm64: cpufeature: Change DBM to display enabled cores
Date:   Tue, 17 Oct 2023 00:23:21 -0500
Message-ID: <20231017052322.1211099-3-jeremy.linton@arm.com>
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

Now that we have the ability to display the list of cores
with a feature when its selectivly enabled, lets convert
DBM to use that as well.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2dd695fc3472..b7b67bac0e60 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1848,6 +1848,8 @@ static int __init parse_kpti(char *str)
 early_param("kpti", parse_kpti);
 
 #ifdef CONFIG_ARM64_HW_AFDBM
+static struct cpumask dbm_cpus __read_mostly;
+
 static inline void __cpu_enable_hw_dbm(void)
 {
 	u64 tcr = read_sysreg(tcr_el1) | TCR_HD;
@@ -1883,35 +1885,22 @@ static bool cpu_can_use_dbm(const struct arm64_cpu_capabilities *cap)
 
 static void cpu_enable_hw_dbm(struct arm64_cpu_capabilities const *cap)
 {
-	if (cpu_can_use_dbm(cap))
+	if (cpu_can_use_dbm(cap)) {
 		__cpu_enable_hw_dbm();
+		cpumask_set_cpu(smp_processor_id(), &dbm_cpus);
+	}
 }
 
 static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
 		       int __unused)
 {
-	static bool detected = false;
 	/*
 	 * DBM is a non-conflicting feature. i.e, the kernel can safely
 	 * run a mix of CPUs with and without the feature. So, we
 	 * unconditionally enable the capability to allow any late CPU
 	 * to use the feature. We only enable the control bits on the
-	 * CPU, if it actually supports.
-	 *
-	 * We have to make sure we print the "feature" detection only
-	 * when at least one CPU actually uses it. So check if this CPU
-	 * can actually use it and print the message exactly once.
-	 *
-	 * This is safe as all CPUs (including secondary CPUs - due to the
-	 * LOCAL_CPU scope - and the hotplugged CPUs - via verification)
-	 * goes through the "matches" check exactly once. Also if a CPU
-	 * matches the criteria, it is guaranteed that the CPU will turn
-	 * the DBM on, as the capability is unconditionally enabled.
+	 * CPU, if it is supported.
 	 */
-	if (!detected && cpu_can_use_dbm(cap)) {
-		detected = true;
-		pr_info("detected: Hardware dirty bit management\n");
-	}
 
 	return true;
 }
@@ -2448,18 +2437,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	},
 #ifdef CONFIG_ARM64_HW_AFDBM
 	{
-		/*
-		 * Since we turn this on always, we don't want the user to
-		 * think that the feature is available when it may not be.
-		 * So hide the description.
-		 *
-		 * .desc = "Hardware pagetable Dirty Bit Management",
-		 *
-		 */
+		.desc = "Hardware dirty bit management",
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.capability = ARM64_HW_DBM,
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
+		.cpus = &dbm_cpus,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HAFDBS, DBM)
 	},
 #endif
-- 
2.41.0

