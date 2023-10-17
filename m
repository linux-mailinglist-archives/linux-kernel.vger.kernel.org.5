Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC767CB9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjJQFXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJQFXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:23:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0AEA4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:23:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C2961007;
        Mon, 16 Oct 2023 22:24:16 -0700 (PDT)
Received: from u200865.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 724BB3F5A1;
        Mon, 16 Oct 2023 22:23:35 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, krisman@suse.de,
        broonie@kernel.org, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 3/3] arm64: cpufeature: Change 32-bit EL0 to display enabled cores
Date:   Tue, 17 Oct 2023 00:23:22 -0500
Message-ID: <20231017052322.1211099-4-jeremy.linton@arm.com>
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
with a feature when it is selectivly enabled, lets display the
cores enabled for 32-bit use at EL0.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b7b67bac0e60..512cbe446b41 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1533,8 +1533,17 @@ static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
 	if (!has_cpuid_feature(entry, scope))
 		return allow_mismatched_32bit_el0;
 
-	if (scope == SCOPE_SYSTEM)
-		pr_info("detected: 32-bit EL0 Support\n");
+	if (scope == SCOPE_SYSTEM) {
+		struct arm64_cpu_capabilities *has_32bit;
+
+		has_32bit = (struct arm64_cpu_capabilities *)entry;
+
+		has_32bit->cpus = system_32bit_el0_cpumask();
+		if (has_32bit->cpus == cpu_possible_mask)
+			has_32bit->cpus = cpu_online_mask;
+		if (has_32bit->cpus == cpu_none_mask)
+			has_32bit->cpus = NULL;
+	}
 
 	return true;
 }
@@ -2307,9 +2316,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, NV, IMP)
 	},
 	{
+		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0_DO_NOT_USE,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_32bit_el0,
+		.cpus = cpu_none_mask,
 		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, EL0, AARCH32)
 	},
 #ifdef CONFIG_KVM
-- 
2.41.0

