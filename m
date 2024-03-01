Return-Path: <linux-kernel+bounces-88916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C562186E854
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56581C23BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6D3A27B;
	Fri,  1 Mar 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeV7i9Mz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142F18646;
	Fri,  1 Mar 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317296; cv=none; b=a9ZSCp1kBpO4WiF6LaJkEfX0k3lMdgGMmKCaylyHc682oFKnvjnjYPwN8pB92Q7pi53kqsQfnGuNAKbJzuO3ONSTX932YK09am6P39eiQ20LwZkooc4Gt/PWPZ+D3K7OVUjkxnfxutedwbda4wFkQJnBFLwO/LQgoE1sINM0HII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317296; c=relaxed/simple;
	bh=N+fUwPUOMDkwBHD4MVnQIW7HznWWYO5TtdodRcr3xV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YBm2jMMNLMfGPMlpyGuOX5s4qTI/hs0i5MXa7xV6r1tK4lJV1s5m8btUIAuaf9I97jxZiGIF8CLglo9wpbYZAQGegubb3O34o3L7jzX9BNOqAPopJJKQPSOOBACQo4W3faoOvLFVTMfGf9AFB4X1xfQLjow3JV/Q6y/GYGIXIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeV7i9Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0D8C433C7;
	Fri,  1 Mar 2024 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317295;
	bh=N+fUwPUOMDkwBHD4MVnQIW7HznWWYO5TtdodRcr3xV0=;
	h=From:Date:Subject:To:Cc:From;
	b=FeV7i9MzGRA2/PYI+c2AP52z3M4Iv57qdWlIhBbCX2xsX8rwbs5H7jCOf4NUGxYiK
	 gy5S6J6OgAQk/jf4aUbvsXEBh20UNdFKcqNSVyopZqJMV9W0VaYs3uid1GARRqlg8e
	 lMSiNmpN0oCkXPJ62rVIa8/2gQfu+vYOai+fTxL1oNot0qlDcD4Rfy23rbLWc2D823
	 G2qFjL/pC0fc8rJoQJVE2oBxzH05rcsuJ1TvaHBYBk1Wd7QjLQ8E0L/M6vf1OXcf3G
	 jM2ZMe0arm7mwSw+OCl+Gqaeb6VzeQoBvNkkT0s2zgc3pSRyh8e5W4L82nlHnqA7FH
	 r+XfmMYg61aSw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 01 Mar 2024 18:05:53 +0000
Subject: [PATCH] KVM: arm64: Only save S1PIE registers when dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAZ4mUC/x3MSwqEMBBF0a1IjS2I1cFGtyIO0uapReOHCogg7
 t3g8AzuvSjBFIna4iLDoUm3NaMqCxrmsE5gjdkkTrwT+fL/WDjYUnuOGGFsmBJHaQJ87aL7fSi
 nu2HU8912/X0/Bw3j32YAAAA=
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6674; i=broonie@kernel.org;
 h=from:subject:message-id; bh=N+fUwPUOMDkwBHD4MVnQIW7HznWWYO5TtdodRcr3xV0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl4hysQpRjuoX731BHrUuwuEQv8FiSyUksrtzvOGvH
 19kAyoqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZeIcrAAKCRAk1otyXVSH0BCpB/
 0X5yCGQxbooieSSXEd9pOM6qcPVl1CwNIt8sOAsIvsEoR4x+0/0dbdrT91g86z3g7imU2yFS1o5Uay
 h7Bp97K+T52Rpd1tf2cT6bEOAXuG8McatyryXR2PHUgVajb9L7tlKlCnVTLQoP2UTiVq99C5Zn1TK+
 tBo6WK6n/KyLFI0X+WflW+em15fTyS0P5jrWsT1wNdMelaJpzaps41vVqQb2meV9/WayBB/ix77nPu
 JLqVI82NSYns7/cw1UGN7bB/oMuYl6vhfwn0ACRAhMUSjCJ2mzQN7FztwgjwVq4z6AO5auBMB1Krvh
 Glbpu01d/CX++5jery1gF71d1IvZ9a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we save the S1PIE registers every time we exit the guest but
the expected usage pattern for these registers is that they will be
written to very infrequently, likely once during initialisation and then
never updated again.  This means that most likely most of our saves of
these registers are redundant.  Let's avoid these redundant saves by
enabling fine grained write traps for the EL0 and EL1 PIE registers when
switching to the guest and only saving if a write happened.

We track if the registers have been written by storing a mask of bits
for HFGWTR_EL2, we may be able to use the same approach for other
registers with similar access patterns.  We assume that it is likely
that both registers will be written in quick succession and mark both
PIR_EL1 and PIRE0_EL1 as dirty if either is written in order to minimise
overhead.

This will have a negative performance impact if guests do start updating
these registers frequently but since the PIE indexes have a wide impact
on the page tables it seems likely that this will not be the case.

We do not need to check for FGT support since it is mandatory for
systems with PIE.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
I don't have a good sense if this is a good idea or not, or if this is a
desirable implementation of the concept - the patch is based on some
concerns about the cost of the system register context switching.  We
should be able to do something similar for some of the other registers.
---
 arch/arm64/include/asm/kvm_host.h          | 37 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h    | 36 +++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |  6 ++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..340567e9b206 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -475,6 +475,8 @@ enum vcpu_sysreg {
 };
 
 struct kvm_cpu_context {
+	u64	reg_dirty;		/* Mask of HFGWTR_EL2 bits */
+
 	struct user_pt_regs regs;	/* sp = sp_el0 */
 
 	u64	spsr_abt;
@@ -492,6 +494,32 @@ struct kvm_cpu_context {
 	u64 *vncr_array;
 };
 
+static inline bool __ctxt_reg_dirty(const struct kvm_cpu_context *ctxt,
+				    u64 trap)
+{
+	return ctxt->reg_dirty & trap;
+}
+
+static inline bool __ctxt_reg_set_dirty(struct kvm_cpu_context *ctxt, u64 trap)
+{
+	return ctxt->reg_dirty |= trap;
+}
+
+static inline bool __ctxt_reg_set_clean(struct kvm_cpu_context *ctxt, u64 trap)
+{
+	return ctxt->reg_dirty &= ~trap;
+}
+
+#define ctxt_reg_dirty(ctxt, trap) \
+	__ctxt_reg_dirty(ctxt, HFGxTR_EL2_##trap)
+
+
+#define ctxt_reg_set_dirty(ctxt, trap) \
+	__ctxt_reg_set_dirty(ctxt, HFGxTR_EL2_##trap)
+
+#define ctxt_reg_set_clean(ctxt, trap) \
+	__ctxt_reg_set_clean(ctxt, HFGxTR_EL2_##trap)
+
 struct kvm_host_data {
 	struct kvm_cpu_context host_ctxt;
 };
@@ -1118,6 +1146,15 @@ static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
 	/* The host's MPIDR is immutable, so let's set it up at boot time */
 	ctxt_sys_reg(cpu_ctxt, MPIDR_EL1) = read_cpuid_mpidr();
+
+	/*
+	 * Save the S1PIE setup on first use, we assume the host will
+	 * never update.
+	 */
+	if (cpus_have_final_cap(ARM64_HAS_S1PIE)) {
+		ctxt_reg_set_dirty(cpu_ctxt, nPIR_EL1);
+		ctxt_reg_set_dirty(cpu_ctxt, nPIRE0_EL1);
+	}
 }
 
 static inline bool kvm_system_needs_idmapped_vectors(void)
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index a038320cdb08..2cccc7f2b492 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -152,6 +152,12 @@ static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 	if (cpus_have_final_cap(ARM64_WORKAROUND_AMPERE_AC03_CPU_38))
 		w_set |= HFGxTR_EL2_TCR_EL1_MASK;
 
+	/*
+	 * Trap writes to infrequently updated registers.
+	 */
+	if (cpus_have_final_cap(ARM64_HAS_S1PIE))
+		w_clr |= HFGxTR_EL2_nPIR_EL1 | HFGxTR_EL2_nPIRE0_EL1;
+
 	if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)) {
 		compute_clr_set(vcpu, HFGRTR_EL2, r_clr, r_set);
 		compute_clr_set(vcpu, HFGWTR_EL2, w_clr, w_set);
@@ -570,6 +576,33 @@ static bool handle_ampere1_tcr(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static inline bool kvm_hyp_handle_read_mostly_sysreg(struct kvm_vcpu *vcpu)
+{
+	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
+	u64 fgt_w_set;
+
+	switch (sysreg) {
+	case SYS_PIR_EL1:
+	case SYS_PIRE0_EL1:
+		/*
+		 * PIR registers are always restored, we just need to
+		 * disable write traps.  We expect EL0 and EL1
+		 * controls to be updated close together so enable
+		 * both.
+		 */
+		if (!cpus_have_final_cap(ARM64_HAS_S1PIE))
+			return false;
+		fgt_w_set = HFGxTR_EL2_nPIRE0_EL1 | HFGxTR_EL2_nPIR_EL1;
+		break;
+	default:
+		return false;
+	}
+
+	sysreg_clear_set_s(SYS_HFGWTR_EL2, 0, fgt_w_set);
+	vcpu->arch.ctxt.reg_dirty |= fgt_w_set;
+	return true;
+}
+
 static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
@@ -590,6 +623,9 @@ static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (kvm_hyp_handle_cntpct(vcpu))
 		return true;
 
+	if (kvm_hyp_handle_read_mostly_sysreg(vcpu))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index bb6b571ec627..f60d27288b2a 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -55,9 +55,13 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 	ctxt_sys_reg(ctxt, CONTEXTIDR_EL1) = read_sysreg_el1(SYS_CONTEXTIDR);
 	ctxt_sys_reg(ctxt, AMAIR_EL1)	= read_sysreg_el1(SYS_AMAIR);
 	ctxt_sys_reg(ctxt, CNTKCTL_EL1)	= read_sysreg_el1(SYS_CNTKCTL);
-	if (cpus_have_final_cap(ARM64_HAS_S1PIE)) {
+	if (ctxt_reg_dirty(ctxt, nPIR_EL1)) {
 		ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
+		ctxt_reg_set_clean(ctxt, nPIR_EL1);
+	}
+	if (ctxt_reg_dirty(ctxt, nPIRE0_EL1)) {
 		ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
+		ctxt_reg_set_clean(ctxt, nPIRE0_EL1);
 	}
 	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
 	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240227-kvm-arm64-defer-regs-d29ae460d0b3

Best regards,
-- 
Mark Brown <broonie@kernel.org>


