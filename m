Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B87EB264
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjKNOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjKNOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049B5173A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:36:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991D6C4AF73;
        Tue, 14 Nov 2023 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972572;
        bh=SgGxSb9kQA/bzFV0T8szlBL5sjGe7ntk4tQniBm8gOw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=vFhCe2snOULXdo871SMt+nDCqrS9241TrSxnAc/ZFILxII4Fra0o4TYxIg3ZVyijA
         YyrSDO+C9E5hA4UJIOwkKJttXi3wz0zJYiXMsrlVOptpHdInl376Nh/tE/i7AWiGlR
         zBLMIcOMZcdr7snv8Kjulk4prkiA+Lpl6CHUDlRLCvUaY4VJ8NO3GSiXLXpKdWK+EP
         eSDkylrwSDMaUhIlwWsw5BV4cnNFrvups1kXBcQOgV5dhlkMdpcKCmZQD2VTalsoLn
         yENYuWd6yhflRqi43RRzYl4lYXWZAvNHMsIB4QqsXzrppsEWwiq96Cy4OzG9jGcFiE
         L3TrjWeWtpUcg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:35:00 +0000
Subject: [PATCH v2 15/21] KVM: arm64: Support FEAT_FPMR for guests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-15-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6384; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SgGxSb9kQA/bzFV0T8szlBL5sjGe7ntk4tQniBm8gOw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WgnXw0TkQR4icJqepbU4lRD4hEfPZbylDbXx7j
 uZtrMWmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFoAAKCRAk1otyXVSH0M8hB/
 wMlQwGWNQy8S+erxBA3wfg9J+HfuTHfSzfU11fVLODJvBFOlZfR+A8m+Hau61Z1Thm78x9jFvdY6NG
 c2wsjEoKlpsL5u2vwz185ToqMSIrxlC2NvOZJlvf28BxeQ/mN5nlkkuVkD/S6J9DiHzjON7klZdPzb
 dHSNpnjd/34t2VfOxS24DHXtc3jIIJhfpNGVfjeIma4An/4LsvlCpfUNg+WGfIPaTxdEBAAzsjKcqL
 EHohTF29nLVI1Tc721mQBZ7DstEsDLTNL9yn+FiNPNJmKDsSN9apdt2iPii+YFszuG1k6M22QviQzg
 8SrYrYf82u9Y8uAzrp0VwMOH+63LJA
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

FEAT_FPMR introduces a new system register FPMR which allows configuration
of floating point behaviour, currently for FP8 specific features. Allow use
of this in guests, disabling the trap while guests are running and saving
and restoring the value along with the rest of the floating point state.
Since FPMR is stored immediately after the main floating point state we
share it with the hypervisor by adjusting the size of the shared region.

Access to FPMR is covered by both a register specific trap HCRX_EL2.EnFPM
and the overall floating point access trap so we just unconditionally
enable the FPMR specific trap and rely on the floating point access trap to
detect guest floating point usage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h        |  2 +-
 arch/arm64/include/asm/kvm_host.h       |  4 +++-
 arch/arm64/kvm/fpsimd.c                 | 20 +++++++++++++++++---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  7 ++++++-
 arch/arm64/kvm/sys_regs.c               | 11 +++++++++++
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 9f9239d86900..95f3b44e7c3a 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -103,7 +103,7 @@
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 #define HCRX_GUEST_FLAGS \
-	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | \
+	(HCRX_EL2_SMPME | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM | \
 	 (cpus_have_final_cap(ARM64_HAS_MOPS) ? (HCRX_EL2_MSCEn | HCRX_EL2_MCE2) : 0))
 #define HCRX_HOST_FLAGS (HCRX_EL2_MSCEn | HCRX_EL2_TCR2En | HCRX_EL2_EnFPM)
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f8d98985a39c..9885adff06fa 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -391,6 +391,8 @@ enum vcpu_sysreg {
 	CNTP_CVAL_EL0,
 	CNTP_CTL_EL0,
 
+	FPMR,
+
 	/* Memory Tagging Extension registers */
 	RGSR_EL1,	/* Random Allocation Tag Seed Register */
 	GCR_EL1,	/* Tag Control Register */
@@ -517,7 +519,6 @@ struct kvm_vcpu_arch {
 	enum fp_type fp_type;
 	unsigned int sve_max_vl;
 	u64 svcr;
-	u64 fpmr;
 
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
@@ -576,6 +577,7 @@ struct kvm_vcpu_arch {
 	struct kvm_guest_debug_arch external_debug_state;
 
 	struct user_fpsimd_state *host_fpsimd_state;	/* hyp VA */
+	u64 *host_fpmr;					/* hyp VA */
 	struct task_struct *parent_task;
 
 	struct {
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index e3e611e30e91..dee078625d0d 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -14,6 +14,16 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
+static void *fpsimd_share_end(struct user_fpsimd_state *fpsimd)
+{
+	void *share_end = fpsimd + 1;
+
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		share_end += sizeof(u64);
+
+	return share_end;
+}
+
 void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 {
 	struct task_struct *p = vcpu->arch.parent_task;
@@ -23,7 +33,7 @@ void kvm_vcpu_unshare_task_fp(struct kvm_vcpu *vcpu)
 		return;
 
 	fpsimd = &p->thread.uw.fpsimd_state;
-	kvm_unshare_hyp(fpsimd, fpsimd + 1);
+	kvm_unshare_hyp(fpsimd, fpsimd_share_end(fpsimd));
 	put_task_struct(p);
 }
 
@@ -45,11 +55,15 @@ int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu)
 	kvm_vcpu_unshare_task_fp(vcpu);
 
 	/* Make sure the host task fpsimd state is visible to hyp: */
-	ret = kvm_share_hyp(fpsimd, fpsimd + 1);
+	ret = kvm_share_hyp(fpsimd, fpsimd_share_end(fpsimd));
 	if (ret)
 		return ret;
 
 	vcpu->arch.host_fpsimd_state = kern_hyp_va(fpsimd);
+	if (cpus_have_final_cap(ARM64_HAS_FPMR)) {
+		WARN_ON_ONCE(&current->thread.fpmr + 1 != fpsimd_share_end(fpsimd));
+		vcpu->arch.host_fpmr = kern_hyp_va(&current->thread.fpmr);
+	}
 
 	/*
 	 * We need to keep current's task_struct pinned until its data has been
@@ -153,7 +167,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 		fp_state.sve_vl = vcpu->arch.sve_max_vl;
 		fp_state.sme_state = NULL;
 		fp_state.svcr = &vcpu->arch.svcr;
-		fp_state.fpmr = &vcpu->arch.fpmr;
+		fp_state.fpmr = &__vcpu_sys_reg(vcpu, FPMR);
 		fp_state.fp_type = &vcpu->arch.fp_type;
 
 		if (vcpu_has_sve(vcpu))
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index f99d8af0b9af..a51b21a2e26f 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -339,10 +339,15 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	isb();
 
 	/* Write out the host state if it's in the registers */
-	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
+	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED) {
 		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
+		if (cpus_have_final_cap(ARM64_HAS_FPMR))
+			*vcpu->arch.host_fpmr = read_sysreg_s(SYS_FPMR);
+	}
 
 	/* Restore the guest state */
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		write_sysreg_s(__vcpu_sys_reg(vcpu, FPMR), SYS_FPMR);
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b843da5e4bb9..0789fb632623 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1914,6 +1914,15 @@ static unsigned int hidden_user_visibility(const struct kvm_vcpu *vcpu,
 	.visibility = hidden_user_visibility,	\
 }
 
+static unsigned int fpmr_visibility(const struct kvm_vcpu *vcpu,
+				    const struct sys_reg_desc *rd)
+{
+	if (cpus_have_final_cap(ARM64_HAS_FPMR))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
 /*
  * Since reset() callback and field val are not used for idregs, they will be
  * used for specific purposes for idregs.
@@ -2310,6 +2319,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
 	{ SYS_DESC(SYS_SVCR), undef_access },
+	{ SYS_DESC(SYS_FPMR), access_rw, reset_unknown, FPMR,
+	  .visibility = fpmr_visibility },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
 	  .reg = PMCR_EL0, .get_user = get_pmcr, .set_user = set_pmcr },

-- 
2.30.2

