Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB23E79EB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjIMOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241517AbjIMOvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:51:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49108B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:51:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347EC433C7;
        Wed, 13 Sep 2023 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694616669;
        bh=dxmFWlhH81flf7nvWhZZF4V16G6a/RKinvFAz4miYSc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LA6G7lab8b44QGDqyC1ABUI4cYPR3h7qo319BWAYdfKwzvt1VtTcPhMIb6flhu2ag
         +MG7nC3jUe0pHmfVJauiydFg5KSpuin3WAsV/EW4ExEorCj7gtUPQ2ueR7fSsLEVhX
         lJQOpXdR/hcQemDlaZKhN0rGd0wxJu/BN5unUwcK/n5/JE6KFuqxcvV7xvwmDUpwi4
         szqpv6gEvdU68BumaZGdo31OAviKwO3mV5boeIJp/fCMxI6W/qLCjsDncwq+EFTsoJ
         N55n6UEQOAVaD9DuAyieyLYFc9HEzHE+qxSr3rhSginVSc6S51VrH1ysGuhIFkMc6f
         JInM+c2SLjszw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 13 Sep 2023 15:48:13 +0100
Subject: [PATCH 2/2] arm64/sve: Remove SMCR pseudo register from cpufeature
 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-arm64-vec-len-cpufeature-v1-2-cc69b0600a8a@kernel.org>
References: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
In-Reply-To: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6440; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dxmFWlhH81flf7nvWhZZF4V16G6a/RKinvFAz4miYSc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAcxXdoeRoGhERCVYT7Z2gxtxpZyHQ0Jwzp1EGXO6
 6BwIuM2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQHMVwAKCRAk1otyXVSH0JgcB/
 9SFD2468CmvfbRqkj/3PZ/SJn6jW5xGXAgM5yM/uA/xFfOjnlM4F+ECwoa4Sq1/j7dDEjewa1YK8ED
 1Xev3t1nNSeHi3MZxH7DrrmOyaOQKw//7k+IGj9CWHJLKW2TuqHUeUCL2NOjXZbGKkeOsfTW6VdVep
 TnGZS6CpS9Dl5Zmi5yMpjeX4wcuEPmkMAjsrNLjPerHfg8gWJzVa+htXbK04FLe5bwA7aunqp287u5
 A2OzbLbI/EBSgJaZCaUATKOGzLzx93eIF8ThJtS3usQ+109Rzd5jD7QgIH95STDq6BpraVnJYR3Ehv
 nfgWJ2MuXVU8IqRfivKlgGgDyLTP0v
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For reasons that are not currently apparent during cpufeature enumeration
we maintain a pseudo register for SMCR which records the maximum supported
vector length using the value that would be written to SMCR_EL1.LEN to
configure it. This is not exposed to userspace and is not sufficient for
detecting unsupportable configurations, we need the more detailed checks in
vec_update_vq_map() for that since we can't cope with missing vector
lengths on late CPUs and KVM requires an exactly matching set of supported
vector lengths as EL1 can enumerate VLs directly with the hardware.

Remove the code, replacing the usage in sme_setup() with a query of the
vq_map.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpu.h   |  3 ---
 arch/arm64/kernel/cpufeature.c | 28 +++++-----------------------
 arch/arm64/kernel/fpsimd.c     | 40 +++++-----------------------------------
 3 files changed, 10 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index f85650dc561c..f3034099fd95 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -63,9 +63,6 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64smfr0;
 
 	struct cpuinfo_32bit	aarch32;
-
-	/* pseudo-SMCR for recording maximum SMCR_EL1 LEN value: */
-	u64		reg_smcr;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 64a6ffa64e50..2a6f3870652a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -610,12 +610,6 @@ static const struct arm64_ftr_bits ftr_id_dfr1[] = {
 	ARM64_FTR_END,
 };
 
-static const struct arm64_ftr_bits ftr_smcr[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
-		SMCR_ELx_LEN_SHIFT, SMCR_ELx_LEN_WIDTH, 0),	/* LEN */
-	ARM64_FTR_END,
-};
-
 /*
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
@@ -728,9 +722,6 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 	ARM64_FTR_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3),
 
-	/* Op1 = 0, CRn = 1, CRm = 2 */
-	ARM64_FTR_REG(SYS_SMCR_EL1, ftr_smcr),
-
 	/* Op1 = 1, CRn = 0, CRm = 0 */
 	ARM64_FTR_REG(SYS_GMID_EL1, ftr_gmid),
 
@@ -1038,14 +1029,14 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 
 	if (IS_ENABLED(CONFIG_ARM64_SME) &&
 	    id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1))) {
-		info->reg_smcr = read_smcr_features();
+		sme_kernel_enable(NULL);
+
 		/*
 		 * We mask out SMPS since even if the hardware
 		 * supports priorities the kernel does not at present
 		 * and we block access to them.
 		 */
 		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
-		init_cpu_ftr_reg(SYS_SMCR_EL1, info->reg_smcr);
 		vec_init_vq_map(ARM64_VEC_SME);
 	}
 
@@ -1291,15 +1282,14 @@ void update_cpu_features(int cpu,
 
 	if (IS_ENABLED(CONFIG_ARM64_SME) &&
 	    id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1))) {
-		info->reg_smcr = read_smcr_features();
+		sme_kernel_enable(NULL);
+
 		/*
 		 * We mask out SMPS since even if the hardware
 		 * supports priorities the kernel does not at present
 		 * and we block access to them.
 		 */
 		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
-		taint |= check_update_ftr_reg(SYS_SMCR_EL1, cpu,
-					info->reg_smcr, boot->reg_smcr);
 
 		/* Probe vector lengths */
 		if (!system_capabilities_finalized())
@@ -3151,19 +3141,11 @@ static void verify_sve_features(void)
 
 static void verify_sme_features(void)
 {
-	u64 safe_smcr = read_sanitised_ftr_reg(SYS_SMCR_EL1);
-	u64 smcr = read_smcr_features();
-
-	unsigned int safe_len = safe_smcr & SMCR_ELx_LEN_MASK;
-	unsigned int len = smcr & SMCR_ELx_LEN_MASK;
-
-	if (len < safe_len || vec_verify_vq_map(ARM64_VEC_SME)) {
+	if (vec_verify_vq_map(ARM64_VEC_SME)) {
 		pr_crit("CPU%d: SME: vector length support mismatch\n",
 			smp_processor_id());
 		cpu_die_early();
 	}
-
-	/* Add checks on other SMCR bits here if necessary */
 }
 
 static void verify_hyp_capabilities(void)
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 35bf40c2f972..04c801001767 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1304,32 +1304,10 @@ void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 		       SYS_SMCR_EL1);
 }
 
-/*
- * Read the pseudo-SMCR used by cpufeatures to identify the supported
- * vector length.
- *
- * Use only if SME is present.
- * This function clobbers the SME vector length.
- */
-u64 read_smcr_features(void)
-{
-	sme_kernel_enable(NULL);
-
-	/*
-	 * Set the maximum possible VL.
-	 */
-	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_LEN_MASK,
-		       SYS_SMCR_EL1);
-
-	/* Return LEN value that would be written to get the maximum VL */
-	return sve_vq_from_vl(sme_get_vl()) - 1;
-}
-
 void __init sme_setup(void)
 {
 	struct vl_info *info = &vl_info[ARM64_VEC_SME];
-	u64 smcr;
-	int min_bit;
+	int min_bit, max_bit;
 
 	if (!system_supports_sme())
 		return;
@@ -1338,24 +1316,16 @@ void __init sme_setup(void)
 	 * SME doesn't require any particular vector length be
 	 * supported but it does require at least one.  We should have
 	 * disabled the feature entirely while bringing up CPUs but
-	 * let's double check here.
+	 * let's double check here.  The bitmap is SVE_VQ_MAP sized for
+	 * sharing with SVE.
 	 */
 	WARN_ON(bitmap_empty(info->vq_map, SVE_VQ_MAX));
 
 	min_bit = find_last_bit(info->vq_map, SVE_VQ_MAX);
 	info->min_vl = sve_vl_from_vq(__bit_to_vq(min_bit));
 
-	smcr = read_sanitised_ftr_reg(SYS_SMCR_EL1);
-	info->max_vl = sve_vl_from_vq((smcr & SMCR_ELx_LEN_MASK) + 1);
-
-	/*
-	 * Sanity-check that the max VL we determined through CPU features
-	 * corresponds properly to sme_vq_map.  If not, do our best:
-	 */
-	if (WARN_ON(info->max_vl != find_supported_vector_length(ARM64_VEC_SME,
-								 info->max_vl)))
-		info->max_vl = find_supported_vector_length(ARM64_VEC_SME,
-							    info->max_vl);
+	max_bit = find_first_bit(info->vq_map, SVE_VQ_MAX);
+	info->max_vl = sve_vl_from_vq(__bit_to_vq(max_bit));
 
 	WARN_ON(info->min_vl > info->max_vl);
 

-- 
2.30.2

