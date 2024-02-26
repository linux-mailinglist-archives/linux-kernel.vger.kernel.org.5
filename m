Return-Path: <linux-kernel+bounces-82366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF06868346
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9400F287711
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1BF131755;
	Mon, 26 Feb 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+aG+x78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83CF131E3F;
	Mon, 26 Feb 2024 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983828; cv=none; b=d4/00mEc0RDbqNqOXOKLmOxwr9pRM2ahqrA25cowegRSycRDsJxXSTAKEx3W4skPF37PV9oOimw+MzJ74IrBxMR77abeJUvSsEebwcGEjkesVnJBoolkSpYyIMwMLu8QTBXGYPyIUT2iirnrKGoB+n83Q30Mos4+LBvrsMYX+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983828; c=relaxed/simple;
	bh=Jec+4jSEe3TE9NlPCIYI3vp1JTkd6IOOCraufqfC27M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYcFsS9HrnxGlLY7ad+kz3+aE05exnhzmKgn1UE3zyxU1bYD5zQHmGg9BMOkvDzqhCvsz87+5rg3iaW9Tb0ACfS8lem/rGc/qeaWuT7aMcozeJuckD+zsX+jl/QYdkd/RFc/s+ijs5UOuOozPflZJjmPZuTXkSHOtayHGHjrWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+aG+x78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D536C433A6;
	Mon, 26 Feb 2024 21:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708983828;
	bh=Jec+4jSEe3TE9NlPCIYI3vp1JTkd6IOOCraufqfC27M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a+aG+x78P7NW2Nj1FmO3D/uRGKdQFzq8iwfBek8oRL0YSFz6bCfihGgQs7vB0zy3R
	 su1UhucYcu9jFXaU/cGebwZtVpsLwiwgU3PoM2t9dh44oxOMNu+9vFeg6r4iCYDmml
	 9wbYxo8oEjh+1tFMnIn1W31g20cjucYC9i+LljVuAkOv4IiS6d+AbvAdgec57E1pdQ
	 Hnl7hmfqj6t1/1/knncZ22/cOksnCoJvAWKHFIHxGF+urxclZ6kdfqCvYzLqEQB81h
	 oSpNhmlGlfMABanjmTHhULGsMtoH24U+3gphcev8NZQ/i7C/lpgiOUfsOJuXfENKia
	 20uNWKcQSGsvA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 26 Feb 2024 20:44:10 +0000
Subject: [PATCH 1/2] KVM: arm64: Rename variable for tracking ownership of
 FP state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-kvm-arm64-group-fp-data-v1-1-07d13759517e@kernel.org>
References: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
In-Reply-To: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=8388; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Jec+4jSEe3TE9NlPCIYI3vp1JTkd6IOOCraufqfC27M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl3QYOoqwHcuZulALfPHG3XnAMl4YDy7lOglcCoS6I
 K5Ee6KGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZd0GDgAKCRAk1otyXVSH0CnbB/
 4xC5iAHrUF08i9DPh17+BqLgs/3GTTiDZdE70rolU+sX+TNMsSXUvJJ9eYab9s4LUkQdvBJADrk031
 t8CraKfPviP72eefkre5W8zyl++GKWldV0Tjmu3GNvRbLNDqzOKhbVC7oaWVEVsjz1r+UX7/jL8qJw
 IwD0bQRtWQ/PtVq8Ct7MGml34O9PLmxXgPG5lFmP1tVQPI9StGjRxEKuWxI76SdT2Ew8rjnjTlK4rB
 TIHPBtb2qQcliwvuGYFd8Q+9yYG9NB/cAi6FN3CgE28YVG+maj6wQWv0hFgX4cqoZIW4vVIfU/ICiH
 FqZFZB9BehOp8PJANwnCw7SAmIcFmE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for refactoring how we store the actual FP state into a
single struct let's free up the name 'fp_state' which we currently use for
the variable where we track the ownership of the FP registers to something
a bit more specific to it's usage. While we're at it also move the enum
definition next to the rest of the FP state.

No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_emulate.h    |  4 ++--
 arch/arm64/include/asm/kvm_host.h       | 14 +++++++-------
 arch/arm64/kvm/arm.c                    |  2 +-
 arch/arm64/kvm/fpsimd.c                 | 10 +++++-----
 arch/arm64/kvm/hyp/include/hyp/switch.h |  6 +++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  4 ++--
 arch/arm64/kvm/hyp/nvhe/switch.c        |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c         |  2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index b804fe832184..1211d93aa712 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -593,7 +593,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
 
 		if (!vcpu_has_sve(vcpu) ||
-		    (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED))
+		    (vcpu->arch.fp_owner != FP_STATE_GUEST_OWNED))
 			val |= CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN;
 		if (cpus_have_final_cap(ARM64_SME))
 			val |= CPACR_EL1_SMEN_EL1EN | CPACR_EL1_SMEN_EL0EN;
@@ -601,7 +601,7 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
 		val = CPTR_NVHE_EL2_RES1;
 
 		if (vcpu_has_sve(vcpu) &&
-		    (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED))
+		    (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED))
 			val |= CPTR_EL2_TZ;
 		if (cpus_have_final_cap(ARM64_SME))
 			val &= ~CPTR_EL2_TSM;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..e0fbba52f1d3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -544,6 +544,13 @@ struct kvm_vcpu_arch {
 	unsigned int sve_max_vl;
 	u64 svcr;
 
+	/* Ownership of the FP regs */
+	enum {
+		FP_STATE_FREE,
+		FP_STATE_HOST_OWNED,
+		FP_STATE_GUEST_OWNED,
+	} fp_owner;
+
 	/* Stage 2 paging state used by the hardware on next switch */
 	struct kvm_s2_mmu *hw_mmu;
 
@@ -558,13 +565,6 @@ struct kvm_vcpu_arch {
 	/* Exception Information */
 	struct kvm_vcpu_fault_info fault;
 
-	/* Ownership of the FP regs */
-	enum {
-		FP_STATE_FREE,
-		FP_STATE_HOST_OWNED,
-		FP_STATE_GUEST_OWNED,
-	} fp_state;
-
 	/* Configuration flags, set once and for all before the vcpu can run */
 	u8 cflags;
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a25265aca432..a2cba18effb2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -377,7 +377,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	 * Default value for the FP state, will be overloaded at load
 	 * time if we support FP (pretty likely)
 	 */
-	vcpu->arch.fp_state = FP_STATE_FREE;
+	vcpu->arch.fp_owner = FP_STATE_FREE;
 
 	/* Set up the timer */
 	kvm_timer_vcpu_init(vcpu);
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8c1d0d4853df..8dbd62d1e677 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -86,7 +86,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
 	 * FP_STATE_FREE if the flag set.
 	 */
-	vcpu->arch.fp_state = FP_STATE_HOST_OWNED;
+	vcpu->arch.fp_owner = FP_STATE_HOST_OWNED;
 
 	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
 	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
@@ -110,7 +110,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 		 * been saved, this is very unlikely to happen.
 		 */
 		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
-			vcpu->arch.fp_state = FP_STATE_FREE;
+			vcpu->arch.fp_owner = FP_STATE_FREE;
 			fpsimd_save_and_flush_cpu_state();
 		}
 	}
@@ -126,7 +126,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu)
 {
 	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
-		vcpu->arch.fp_state = FP_STATE_FREE;
+		vcpu->arch.fp_owner = FP_STATE_FREE;
 }
 
 /*
@@ -142,7 +142,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(!irqs_disabled());
 
-	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
+	if (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED) {
 
 		/*
 		 * Currently we do not support SME guests so SVCR is
@@ -195,7 +195,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		isb();
 	}
 
-	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED) {
+	if (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED) {
 		if (vcpu_has_sve(vcpu)) {
 			__vcpu_sys_reg(vcpu, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index a038320cdb08..575c39847d40 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -42,7 +42,7 @@ extern struct kvm_exception_table_entry __stop___kvm_ex_table;
 /* Check whether the FP regs are owned by the guest */
 static inline bool guest_owns_fp_regs(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.fp_state == FP_STATE_GUEST_OWNED;
+	return vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED;
 }
 
 /* Save the 32-bit only FPSIMD system register state */
@@ -370,7 +370,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	isb();
 
 	/* Write out the host state if it's in the registers */
-	if (vcpu->arch.fp_state == FP_STATE_HOST_OWNED)
+	if (vcpu->arch.fp_owner == FP_STATE_HOST_OWNED)
 		__fpsimd_save_state(vcpu->arch.host_fpsimd_state);
 
 	/* Restore the guest state */
@@ -383,7 +383,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (!(read_sysreg(hcr_el2) & HCR_RW))
 		write_sysreg(__vcpu_sys_reg(vcpu, FPEXC32_EL2), fpexc32_el2);
 
-	vcpu->arch.fp_state = FP_STATE_GUEST_OWNED;
+	vcpu->arch.fp_owner = FP_STATE_GUEST_OWNED;
 
 	return true;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 2385fd03ed87..85ea18227d33 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -39,7 +39,7 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_vcpu->vcpu.arch.cptr_el2	= host_vcpu->arch.cptr_el2;
 
 	hyp_vcpu->vcpu.arch.iflags	= host_vcpu->arch.iflags;
-	hyp_vcpu->vcpu.arch.fp_state	= host_vcpu->arch.fp_state;
+	hyp_vcpu->vcpu.arch.fp_owner	= host_vcpu->arch.fp_owner;
 
 	hyp_vcpu->vcpu.arch.debug_ptr	= kern_hyp_va(host_vcpu->arch.debug_ptr);
 	hyp_vcpu->vcpu.arch.host_fpsimd_state = host_vcpu->arch.host_fpsimd_state;
@@ -64,7 +64,7 @@ static void sync_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	host_vcpu->arch.fault		= hyp_vcpu->vcpu.arch.fault;
 
 	host_vcpu->arch.iflags		= hyp_vcpu->vcpu.arch.iflags;
-	host_vcpu->arch.fp_state	= hyp_vcpu->vcpu.arch.fp_state;
+	host_vcpu->arch.fp_owner	= hyp_vcpu->vcpu.arch.fp_owner;
 
 	host_cpu_if->vgic_hcr		= hyp_cpu_if->vgic_hcr;
 	for (i = 0; i < hyp_cpu_if->used_lrs; ++i)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c50f8459e4fc..9f9404c9bbae 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -337,7 +337,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	__sysreg_restore_state_nvhe(host_ctxt);
 
-	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED)
+	if (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED)
 		__fpsimd_save_fpexc32(vcpu);
 
 	__debug_switch_to_host(vcpu);
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 1581df6aec87..17596586806c 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -258,7 +258,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_restore_host_state_vhe(host_ctxt);
 
-	if (vcpu->arch.fp_state == FP_STATE_GUEST_OWNED)
+	if (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED)
 		__fpsimd_save_fpexc32(vcpu);
 
 	__debug_switch_to_host(vcpu);

-- 
2.30.2


