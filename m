Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10BA79EB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbjIMOvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIMOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:51:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78DAF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:51:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A95C433C8;
        Wed, 13 Sep 2023 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694616668;
        bh=pq3nk8J7Pgfsje8SmShu7aic14zBJ4Nxtn9AzPHOET0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BcdAp9WNCsuhQXgHPhQnZMYuiaxLhY5xmKhqo9EYXVaOThMA2uFS1hDcaMNHU6mM/
         E7eTDbUN09k81gBbg163wma4VfAvsStivD7osaPQCNLJqWOl/jGKX/u7+9WKVdF3y6
         se5axOrzAIRo47U5pbzuIcaGMOHotzrZNJALG7b75Zn41x6KzD435v6o8zURFjXOMt
         BLsr5wuajB80SkG1/LtX1G0quwuhuzqbZIEOGyRVTyywzTmPBFccnPnmK8Ign2mIPt
         LdnRTz/0zA3zZSrrvRc+DkKtBCUqbeQCLRQ+gYBqGC0oskiHtF4eMTbODoEFlLFMhI
         r+KaFBmphQVEg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 13 Sep 2023 15:48:12 +0100
Subject: [PATCH 1/2] arm64/sve: Remove ZCR pseudo register from cpufeature
 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-arm64-vec-len-cpufeature-v1-1-cc69b0600a8a@kernel.org>
References: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
In-Reply-To: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6503; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pq3nk8J7Pgfsje8SmShu7aic14zBJ4Nxtn9AzPHOET0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAcxXcBzAG/telKALR9V7HbUnEXkXIdSO4i2QWN4O
 WFVG+kGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQHMVwAKCRAk1otyXVSH0MO1B/
 4hxQdy+k/tjxrucr2EFv+EXdBdMvyFOQ5syJBTJZBUVxf1yigEW1r494jJd64shcMX/ImcIJHnGq03
 2An6FGZPVAaYUelmKXgPOGJHd+axgaYmI3m/gcKkJRtGratxkmYwqfrpttfEAJwaxDIff8+crP6Uic
 gCYfmcV+sKDHzUiLMQ+DCg0XpVrrnbtChQ6h88kyale9zZpJE2ZmCZYVmX5peY/Ihom5XPlReJjO1D
 8aza6ysJn4O3DHHDs88mY4lFAB0xa1Ii2y/V8NrzWDI7ZZlgVWkKKEtveB+QLPu7MOIrz3Fpn/YfF1
 vPe/2o/qht1PWcO0FpS45uFJl0oL3T
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reasons that are not currently apparent during cpufeature enumeration
we maintain a pseudo register for ZCR which records the maximum supported
vector length using the value that would be written to ZCR_EL1.LEN to
configure it. This is not exposed to userspace and is not sufficient for
detecting unsupportable configurations, we need the more detailed checks in
vec_update_vq_map() for that since we can't cope with missing vector
lengths on late CPUs and KVM requires an exactly matching set of supported
vector lengths as EL1 can enumerate VLs directly with the hardware.

Remove the code, replacing the usage in sve_setup() with a query of the
vq_map.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpu.h    |  3 ---
 arch/arm64/include/asm/fpsimd.h |  1 -
 arch/arm64/kernel/cpufeature.c  | 30 ++++++------------------------
 arch/arm64/kernel/fpsimd.c      | 35 +++--------------------------------
 4 files changed, 9 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index e749838b9c5d..f85650dc561c 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -64,9 +64,6 @@ struct cpuinfo_arm64 {
 
 	struct cpuinfo_32bit	aarch32;
 
-	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
-	u64		reg_zcr;
-
 	/* pseudo-SMCR for recording maximum SMCR_EL1 LEN value: */
 	u64		reg_smcr;
 };
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8df46f186c64..9e5d3a0812b6 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -128,7 +128,6 @@ extern void sme_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void sme2_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 extern void fa64_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
-extern u64 read_zcr_features(void);
 extern u64 read_smcr_features(void);
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b018ae12ff5f..64a6ffa64e50 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -610,12 +610,6 @@ static const struct arm64_ftr_bits ftr_id_dfr1[] = {
 	ARM64_FTR_END,
 };
 
-static const struct arm64_ftr_bits ftr_zcr[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
-		ZCR_ELx_LEN_SHIFT, ZCR_ELx_LEN_WIDTH, 0),	/* LEN */
-	ARM64_FTR_END,
-};
-
 static const struct arm64_ftr_bits ftr_smcr[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
 		SMCR_ELx_LEN_SHIFT, SMCR_ELx_LEN_WIDTH, 0),	/* LEN */
@@ -735,7 +729,6 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3),
 
 	/* Op1 = 0, CRn = 1, CRm = 2 */
-	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
 	ARM64_FTR_REG(SYS_SMCR_EL1, ftr_smcr),
 
 	/* Op1 = 1, CRn = 0, CRm = 0 */
@@ -1039,8 +1032,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
-		info->reg_zcr = read_zcr_features();
-		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
+		sve_kernel_enable(NULL);
 		vec_init_vq_map(ARM64_VEC_SVE);
 	}
 
@@ -1288,15 +1280,13 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64SMFR0_EL1, cpu,
 				      info->reg_id_aa64smfr0, boot->reg_id_aa64smfr0);
 
+	/* Probe vector lengths */
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
-		info->reg_zcr = read_zcr_features();
-		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
-					info->reg_zcr, boot->reg_zcr);
-
-		/* Probe vector lengths */
-		if (!system_capabilities_finalized())
+		if (!system_capabilities_finalized()) {
+			sve_kernel_enable(NULL);
 			vec_update_vq_map(ARM64_VEC_SVE);
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_ARM64_SME) &&
@@ -3152,19 +3142,11 @@ static void verify_local_elf_hwcaps(void)
 
 static void verify_sve_features(void)
 {
-	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
-	u64 zcr = read_zcr_features();
-
-	unsigned int safe_len = safe_zcr & ZCR_ELx_LEN_MASK;
-	unsigned int len = zcr & ZCR_ELx_LEN_MASK;
-
-	if (len < safe_len || vec_verify_vq_map(ARM64_VEC_SVE)) {
+	if (vec_verify_vq_map(ARM64_VEC_SVE)) {
 		pr_crit("CPU%d: SVE: vector length support mismatch\n",
 			smp_processor_id());
 		cpu_die_early();
 	}
-
-	/* Add checks on other ZCR bits here if necessary */
 }
 
 static void verify_sme_features(void)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 91e44ac7150f..35bf40c2f972 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1170,32 +1170,12 @@ void sve_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 	isb();
 }
 
-/*
- * Read the pseudo-ZCR used by cpufeatures to identify the supported SVE
- * vector length.
- *
- * Use only if SVE is present.
- * This function clobbers the SVE vector length.
- */
-u64 read_zcr_features(void)
-{
-	/*
-	 * Set the maximum possible VL, and write zeroes to all other
-	 * bits to see if they stick.
-	 */
-	sve_kernel_enable(NULL);
-	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
-
-	/* Return LEN value that would be written to get the maximum VL */
-	return sve_vq_from_vl(sve_get_vl()) - 1;
-}
-
 void __init sve_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
-	u64 zcr;
 	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
 	unsigned long b;
+	int max_bit;
 
 	if (!system_supports_sve())
 		return;
@@ -1208,17 +1188,8 @@ void __init sve_setup(void)
 	if (WARN_ON(!test_bit(__vq_to_bit(SVE_VQ_MIN), info->vq_map)))
 		set_bit(__vq_to_bit(SVE_VQ_MIN), info->vq_map);
 
-	zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
-	info->max_vl = sve_vl_from_vq((zcr & ZCR_ELx_LEN_MASK) + 1);
-
-	/*
-	 * Sanity-check that the max VL we determined through CPU features
-	 * corresponds properly to sve_vq_map.  If not, do our best:
-	 */
-	if (WARN_ON(info->max_vl != find_supported_vector_length(ARM64_VEC_SVE,
-								 info->max_vl)))
-		info->max_vl = find_supported_vector_length(ARM64_VEC_SVE,
-							    info->max_vl);
+	max_bit = find_first_bit(info->vq_map, SVE_VQ_MAX);
+	info->max_vl = sve_vl_from_vq(__bit_to_vq(max_bit));
 
 	/*
 	 * For the default VL, pick the maximum supported value <= 64.

-- 
2.30.2

