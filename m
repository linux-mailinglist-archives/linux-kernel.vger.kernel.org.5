Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190CD7EB254
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjKNOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjKNOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:36:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61F8D6B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A663BC433B9;
        Tue, 14 Nov 2023 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972552;
        bh=eZaW7Q4M/zzv5URqk5Jj7aBPK/YCTtlJ1HieBEOkpao=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=F9qS4cNYbmzk9CRD6I1kPZKHC55oQxPorNN4MjGLqUUzu4rd9kc34C0K9+ecjB60c
         5rmZdt/jC+2Um8aR3019vjqiiXBcxJQ3sYcN07cE8yUR4Lgd21jjmlNsMM0Ccb6qVo
         7UQ5UKlycZbLz5QASOR6SPVjI77leds3Q1bHy61jxt2JdIGF7rK7rrd+pA58jSyHFN
         ROMq4kC+uXUiI7cDdwbLGBE1LgAiK7mV2GY3s/TryAeV45iLjvIBedjO7k2t0SkzXI
         7/SgJ4C2ZlmT3xljSKXHNAjI+j2yYFXjmm5S3hy3j3crbU1N4URsQxDktC8o9jBpUk
         GJyWDYJrx+m7A==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:54 +0000
Subject: [PATCH v2 09/21] arm64/cpufeature: Hook new identification
 registers up to cpufeature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-9-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7888; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eZaW7Q4M/zzv5URqk5Jj7aBPK/YCTtlJ1HieBEOkpao=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4Wboob+aN212olICG31A2T4E/iZQdufTXtP+L/a
 6WBz/MWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmwAKCRAk1otyXVSH0DrKB/
 9eMgz51jPlNWTFwaHt9t5/kYA6OPCJPH9tbByrkoUFrcq2Fh1uK6lOCbtVLzULmczakiMffQmz4Gq8
 kVQZiekNfDUvPUJzfMCKCwHpTFjY2X8MKkcwU0AAyrTkzcEKgxlVhlitzaFELsw3o3d7F94IsILdMo
 ZDwWNyId6qUBmknicwCX6mVvSNEiWl1EI1x2x9siQG6PZP8FlOF8NC8Lf1KKVN3b7K7bgEGlEqtx++
 8fZwYZ2SJlfClxSGJLcwhBDIMra/13oVCARioTogmzckk9h/lQAqG7q03aWoSJlifsbEbMvontBWVV
 W9CxKD5hfAzRXWBd0LD9CpJUJ+9WkQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2023 architecture extensions have defined several new ID registers,
hook them up to the cpufeature code so we can add feature checks and hwcaps
based on their contents.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpu.h   |  3 +++
 arch/arm64/kernel/cpufeature.c | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c    |  3 +++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index f3034099fd95..b99138bc3d4a 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -53,14 +53,17 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64isar0;
 	u64		reg_id_aa64isar1;
 	u64		reg_id_aa64isar2;
+	u64		reg_id_aa64isar3;
 	u64		reg_id_aa64mmfr0;
 	u64		reg_id_aa64mmfr1;
 	u64		reg_id_aa64mmfr2;
 	u64		reg_id_aa64mmfr3;
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
+	u64		reg_id_aa64pfr2;
 	u64		reg_id_aa64zfr0;
 	u64		reg_id_aa64smfr0;
+	u64		reg_id_aa64fpfr0;
 
 	struct cpuinfo_32bit	aarch32;
 };
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 646591c67e7a..c8d38e5ce997 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -234,6 +234,10 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_CSV2_SHIFT, 4, 0),
@@ -267,6 +271,10 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64pfr2[] = {
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_EL1_F64MM_SHIFT, 4, 0),
@@ -319,6 +327,10 @@ static const struct arm64_ftr_bits ftr_id_aa64smfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64fpfr0[] = {
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EL1_ECV_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EL1_FGT_SHIFT, 4, 0),
@@ -702,10 +714,12 @@ static const struct __ftr_reg_entry {
 			       &id_aa64pfr0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1,
 			       &id_aa64pfr1_override),
+	ARM64_FTR_REG(SYS_ID_AA64PFR2_EL1, ftr_id_aa64pfr2),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ZFR0_EL1, ftr_id_aa64zfr0,
 			       &id_aa64zfr0_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64SMFR0_EL1, ftr_id_aa64smfr0,
 			       &id_aa64smfr0_override),
+	ARM64_FTR_REG(SYS_ID_AA64FPFR0_EL1, ftr_id_aa64fpfr0),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -717,6 +731,7 @@ static const struct __ftr_reg_entry {
 			       &id_aa64isar1_override),
 	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2,
 			       &id_aa64isar2_override),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR3_EL1, ftr_id_aa64isar3),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
@@ -1043,14 +1058,17 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR2_EL1, info->reg_id_aa64isar2);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR3_EL1, info->reg_id_aa64isar3);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR3_EL1, info->reg_id_aa64mmfr3);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64PFR2_EL1, info->reg_id_aa64pfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64SMFR0_EL1, info->reg_id_aa64smfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64FPFR0_EL1, info->reg_id_aa64fpfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0))
 		init_32bit_cpu_features(&info->aarch32);
@@ -1291,6 +1309,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64isar1, boot->reg_id_aa64isar1);
 	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR2_EL1, cpu,
 				      info->reg_id_aa64isar2, boot->reg_id_aa64isar2);
+	taint |= check_update_ftr_reg(SYS_ID_AA64ISAR3_EL1, cpu,
+				      info->reg_id_aa64isar3, boot->reg_id_aa64isar3);
 
 	/*
 	 * Differing PARange support is fine as long as all peripherals and
@@ -1310,6 +1330,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64pfr0, boot->reg_id_aa64pfr0);
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR1_EL1, cpu,
 				      info->reg_id_aa64pfr1, boot->reg_id_aa64pfr1);
+	taint |= check_update_ftr_reg(SYS_ID_AA64PFR2_EL1, cpu,
+				      info->reg_id_aa64pfr2, boot->reg_id_aa64pfr2);
 
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
@@ -1317,6 +1339,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
 				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64FPFR0_EL1, cpu,
+				      info->reg_id_aa64fpfr0, boot->reg_id_aa64fpfr0);
+
 	/* Probe vector lengths */
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
@@ -1429,8 +1454,10 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 
 	read_sysreg_case(SYS_ID_AA64PFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64PFR1_EL1);
+	read_sysreg_case(SYS_ID_AA64PFR2_EL1);
 	read_sysreg_case(SYS_ID_AA64ZFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64SMFR0_EL1);
+	read_sysreg_case(SYS_ID_AA64FPFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64DFR0_EL1);
 	read_sysreg_case(SYS_ID_AA64DFR1_EL1);
 	read_sysreg_case(SYS_ID_AA64MMFR0_EL1);
@@ -1440,6 +1467,7 @@ u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_AA64ISAR0_EL1);
 	read_sysreg_case(SYS_ID_AA64ISAR1_EL1);
 	read_sysreg_case(SYS_ID_AA64ISAR2_EL1);
+	read_sysreg_case(SYS_ID_AA64ISAR3_EL1);
 
 	read_sysreg_case(SYS_CNTFRQ_EL0);
 	read_sysreg_case(SYS_CTR_EL0);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a257da7b56fe..8322e968fd0d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -448,14 +448,17 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
 	info->reg_id_aa64isar1 = read_cpuid(ID_AA64ISAR1_EL1);
 	info->reg_id_aa64isar2 = read_cpuid(ID_AA64ISAR2_EL1);
+	info->reg_id_aa64isar3 = read_cpuid(ID_AA64ISAR3_EL1);
 	info->reg_id_aa64mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
 	info->reg_id_aa64mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
 	info->reg_id_aa64mmfr2 = read_cpuid(ID_AA64MMFR2_EL1);
 	info->reg_id_aa64mmfr3 = read_cpuid(ID_AA64MMFR3_EL1);
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
+	info->reg_id_aa64pfr2 = read_cpuid(ID_AA64PFR2_EL1);
 	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
 	info->reg_id_aa64smfr0 = read_cpuid(ID_AA64SMFR0_EL1);
+	info->reg_id_aa64fpfr0 = read_cpuid(ID_AA64FPFR0_EL1);
 
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
 		info->reg_gmid = read_cpuid(GMID_EL1);

-- 
2.30.2

