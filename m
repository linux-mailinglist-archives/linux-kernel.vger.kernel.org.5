Return-Path: <linux-kernel+bounces-82367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C7868347
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348D71C23D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A8A13246E;
	Mon, 26 Feb 2024 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ucfx8m/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760A131E28;
	Mon, 26 Feb 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983830; cv=none; b=Z3IrzCEQY2qGvEOwQzePN8WtpCBzlWiz/kzaq14FSCiC2h2apbg7yOeh6E4okJM+X9mivm3DzKCqRuaUETZOypDWRXecsWzoyIeErjRynjfbZCLRDZ7pZVqqkd9MXL13m+p+dvviNLCP0RfuNVGc8jjkMNS2u3weiFseBbAVArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983830; c=relaxed/simple;
	bh=hZC4T/H/3uUmFlacUDnTpnQhs8dVMlojfX4EFThzU3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJdFlS+kXY2oYHzN6tfRUJJyjqNSu3TbPyr1BXaN/+1vhP/7jWbvqK1znJ0oesvmbJ/veEnufg0QYwhr2+6dXVh8gfuYKmK9R6KYrOdc7F+pDkq97VbhlGc1VaKQU0M8zbvhGhjYojjsPISyke39n+TulIlQk9E31cNxVv7faq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ucfx8m/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC71C433F1;
	Mon, 26 Feb 2024 21:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708983830;
	bh=hZC4T/H/3uUmFlacUDnTpnQhs8dVMlojfX4EFThzU3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ucfx8m/WSnG3ryl67f/6qZ33c9UDhhiB6FG4p89uvDnIXO2XRujJN7xEkDcO3Ua+R
	 oWcKpt4TrCZjAjh7go5ASFx6dgbEVVUNb9LbLR9cR1oDmhpLQhNi+ZWQX3tqh0Pj74
	 wL3VzVYnY3NBDwRl/gxRylYwkemOfMtt6O+GzPlgwoc45w3Q/rkj9x65M5Gbe6phT5
	 zzxJGy1bZcFctXPm48Bv4LvdEmupykRxptso60dS67v6kmLT/6Qo11biWg9YzWxuOy
	 5ZE1wKVA4dee8f4+zhTkCCfJXySPPlkPL96nCSuToM0/P7WH8KrL7D5jXqateq9Fiz
	 A4y92zu0uGiqQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 26 Feb 2024 20:44:11 +0000
Subject: [PATCH 2/2] KVM: arm64: Reuse struct cpu_fp_state to track the
 guest FP state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-kvm-arm64-group-fp-data-v1-2-07d13759517e@kernel.org>
References: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
In-Reply-To: <20240226-kvm-arm64-group-fp-data-v1-0-07d13759517e@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=9781; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hZC4T/H/3uUmFlacUDnTpnQhs8dVMlojfX4EFThzU3w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl3QYO1hLJUK/NFohF305xR7YZG+uWE5iTVcjdg/ad
 FId0XKyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZd0GDgAKCRAk1otyXVSH0EW1B/
 9kX5YFCqVWrk+J//TPYLj/tDy6p0p8l7vgAXYMiGU1FxvyX/CvEZRU0XmgV0eqEJ9N4zMiMOXxHsYm
 Fk2O8rvrMjvb2tPgQYfb44vy+48CiqKAKx0MMgqKrVq1rIgx+MNkDVFQgi36olK5nxETECoL0WABXf
 rMpUO96lvMY2p7Ue+mUDorCqpRdhlEGN335EOqE2u/0ctQGJ/+UquV+9si/0xBZIr2RIZ9QeLWKdNw
 zQuX8TyM4JbAze6G5Z6s5fOUlX/Gmm6pqShjV47j5dh4HYqg3z9kzu/ktR9Z9b93jcvvhTx6gtNbKQ
 /nbde1qaUzNxwAyo5AwjCILn8uh4Ax
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

At present we store the various bits of floating point state individually
in struct kvm_vpcu_arch and construct a struct cpu_fp_state to share with
the host each time we exit the guest. Let's simplify this a little by
having a struct cpu_fp_state in the struct kvm_vcpu_arch and initialising
this while initialising the guest.

As part of this remove the separate variables used for the SVE register
storage and vector length information, just using the variables in the
struct cpu_fp_state directly.

Since cpu_fp_state stores pointers to variables to be updated as part of
saving we do still need some variables stored directly in the struct for
the FPSIMD registers, SVCR and the type of FP state saved. Due to the
embedding of the FPSIMD registers into ucontext which is stored directly in
the host's data and the future need to support KVM's system register view
of SVCR and FPMR unpicking these indirections would be more involved.

No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h  | 11 +++++------
 arch/arm64/kvm/arm.c               | 12 ++++++++++++
 arch/arm64/kvm/fpsimd.c            | 19 +------------------
 arch/arm64/kvm/guest.c             | 21 ++++++++++++++-------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |  5 +++--
 arch/arm64/kvm/reset.c             | 14 ++++++++------
 6 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e0fbba52f1d3..47bd769a26ff 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -539,9 +539,8 @@ struct kvm_vcpu_arch {
 	 * floating point code saves the register state of a task it
 	 * records which view it saved in fp_type.
 	 */
-	void *sve_state;
+	struct cpu_fp_state fp_state;
 	enum fp_type fp_type;
-	unsigned int sve_max_vl;
 	u64 svcr;
 
 	/* Ownership of the FP regs */
@@ -799,16 +798,16 @@ struct kvm_vcpu_arch {
 
 
 /* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
+#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.fp_state.sve_state) + \
+			     sve_ffr_offset((vcpu)->arch.fp_state.sve_vl))
 
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
+#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.fp_state.sve_vl)
 
 #define vcpu_sve_state_size(vcpu) ({					\
 	size_t __size_ret;						\
 	unsigned int __vcpu_vq;						\
 									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.fp_state.sve_vl))) {	\
 		__size_ret = 0;						\
 	} else {							\
 		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a2cba18effb2..84cc0dbd9b14 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -379,6 +379,18 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.fp_owner = FP_STATE_FREE;
 
+	/*
+	 * Initial setup for FP state for sharing with host, if SVE is
+	 * enabled additional configuration will be done.
+	 *
+	 * Currently we do not support SME guests so SVCR is always 0
+	 * and we just need a variable to point to.
+	 */
+	vcpu->arch.fp_state.st = &vcpu->arch.ctxt.fp_regs;
+	vcpu->arch.fp_state.fp_type = &vcpu->arch.fp_type;
+	vcpu->arch.fp_state.svcr = &vcpu->arch.svcr;
+	vcpu->arch.fp_state.to_save = FP_STATE_FPSIMD;
+
 	/* Set up the timer */
 	kvm_timer_vcpu_init(vcpu);
 
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8dbd62d1e677..45fe4a942992 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -143,24 +143,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	WARN_ON_ONCE(!irqs_disabled());
 
 	if (vcpu->arch.fp_owner == FP_STATE_GUEST_OWNED) {
-
-		/*
-		 * Currently we do not support SME guests so SVCR is
-		 * always 0 and we just need a variable to point to.
-		 */
-		fp_state.st = &vcpu->arch.ctxt.fp_regs;
-		fp_state.sve_state = vcpu->arch.sve_state;
-		fp_state.sve_vl = vcpu->arch.sve_max_vl;
-		fp_state.sme_state = NULL;
-		fp_state.svcr = &vcpu->arch.svcr;
-		fp_state.fp_type = &vcpu->arch.fp_type;
-
-		if (vcpu_has_sve(vcpu))
-			fp_state.to_save = FP_STATE_SVE;
-		else
-			fp_state.to_save = FP_STATE_FPSIMD;
-
-		fpsimd_bind_state_to_cpu(&fp_state);
+		fpsimd_bind_state_to_cpu(&vcpu->arch.fp_state);
 
 		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 	}
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index aaf1d4939739..54e9d3b648f0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -317,7 +317,7 @@ static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!vcpu_has_sve(vcpu))
 		return -ENOENT;
 
-	if (WARN_ON(!sve_vl_valid(vcpu->arch.sve_max_vl)))
+	if (WARN_ON(!sve_vl_valid(vcpu->arch.fp_state.sve_vl)))
 		return -EINVAL;
 
 	memset(vqs, 0, sizeof(vqs));
@@ -344,7 +344,7 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (kvm_arm_vcpu_sve_finalized(vcpu))
 		return -EPERM; /* too late! */
 
-	if (WARN_ON(vcpu->arch.sve_state))
+	if (WARN_ON(vcpu->arch.fp_state.sve_state))
 		return -EINVAL;
 
 	if (copy_from_user(vqs, (const void __user *)reg->addr, sizeof(vqs)))
@@ -373,8 +373,11 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (max_vq < SVE_VQ_MIN)
 		return -EINVAL;
 
-	/* vcpu->arch.sve_state will be alloc'd by kvm_vcpu_finalize_sve() */
-	vcpu->arch.sve_max_vl = sve_vl_from_vq(max_vq);
+	/*
+	 * vcpu->arch.fp_state.sve_state will be alloc'd by
+	 * kvm_vcpu_finalize_sve().
+	 */
+	vcpu->arch.fp_state.sve_vl = sve_vl_from_vq(max_vq);
 
 	return 0;
 }
@@ -403,7 +406,10 @@ static int set_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
  */
 #define vcpu_sve_slices(vcpu) 1
 
-/* Bounds of a single SVE register slice within vcpu->arch.sve_state */
+/*
+ * Bounds of a single SVE register slice within
+ * vcpu->arch.fp_state.sve_state
+ */
 struct sve_state_reg_region {
 	unsigned int koffset;	/* offset into sve_state in kernel memory */
 	unsigned int klen;	/* length in kernel memory */
@@ -499,7 +505,7 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!kvm_arm_vcpu_sve_finalized(vcpu))
 		return -EPERM;
 
-	if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
+	if (copy_to_user(uptr, vcpu->arch.fp_state.sve_state + region.koffset,
 			 region.klen) ||
 	    clear_user(uptr + region.klen, region.upad))
 		return -EFAULT;
@@ -525,7 +531,8 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!kvm_arm_vcpu_sve_finalized(vcpu))
 		return -EPERM;
 
-	if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
+	if (copy_from_user(vcpu->arch.fp_state.sve_state + region.koffset,
+			   uptr,
 			   region.klen))
 		return -EFAULT;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 85ea18227d33..63971b801cf3 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -29,8 +29,9 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 
 	hyp_vcpu->vcpu.arch.ctxt	= host_vcpu->arch.ctxt;
 
-	hyp_vcpu->vcpu.arch.sve_state	= kern_hyp_va(host_vcpu->arch.sve_state);
-	hyp_vcpu->vcpu.arch.sve_max_vl	= host_vcpu->arch.sve_max_vl;
+	hyp_vcpu->vcpu.arch.fp_state.sve_state
+		= kern_hyp_va(host_vcpu->arch.fp_state.sve_state);
+	hyp_vcpu->vcpu.arch.fp_state.sve_vl = host_vcpu->arch.fp_state.sve_vl;
 
 	hyp_vcpu->vcpu.arch.hw_mmu	= host_vcpu->arch.hw_mmu;
 
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 68d1d05672bd..675b8925242f 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -75,7 +75,7 @@ int __init kvm_arm_init_sve(void)
 
 static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.sve_max_vl = kvm_sve_max_vl;
+	vcpu->arch.fp_state.sve_vl = kvm_sve_max_vl;
 
 	/*
 	 * Userspace can still customize the vector lengths by writing
@@ -87,7 +87,7 @@ static void kvm_vcpu_enable_sve(struct kvm_vcpu *vcpu)
 
 /*
  * Finalize vcpu's maximum SVE vector length, allocating
- * vcpu->arch.sve_state as necessary.
+ * vcpu->arch.fp_state.sve_state as necessary.
  */
 static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 {
@@ -96,7 +96,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 	size_t reg_sz;
 	int ret;
 
-	vl = vcpu->arch.sve_max_vl;
+	vl = vcpu->arch.fp_state.sve_vl;
 
 	/*
 	 * Responsibility for these properties is shared between
@@ -118,7 +118,8 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 		return ret;
 	}
 	
-	vcpu->arch.sve_state = buf;
+	vcpu->arch.fp_state.sve_state = buf;
+	vcpu->arch.fp_state.to_save = FP_STATE_SVE;
 	vcpu_set_flag(vcpu, VCPU_SVE_FINALIZED);
 	return 0;
 }
@@ -149,7 +150,7 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 
 void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	void *sve_state = vcpu->arch.sve_state;
+	void *sve_state = vcpu->arch.fp_state.sve_state;
 
 	kvm_vcpu_unshare_task_fp(vcpu);
 	kvm_unshare_hyp(vcpu, vcpu + 1);
@@ -162,7 +163,8 @@ void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
 static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_has_sve(vcpu))
-		memset(vcpu->arch.sve_state, 0, vcpu_sve_state_size(vcpu));
+		memset(vcpu->arch.fp_state.sve_state, 0,
+		       vcpu_sve_state_size(vcpu));
 }
 
 static void kvm_vcpu_enable_ptrauth(struct kvm_vcpu *vcpu)

-- 
2.30.2


