Return-Path: <linux-kernel+bounces-38305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C9A83BDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B7D1F2ED9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE241CD39;
	Thu, 25 Jan 2024 09:42:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C11BF2F;
	Thu, 25 Jan 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175727; cv=none; b=P71CQwcDLbEiR8aWskOV9KMLj3gThMJOd8XgLdbXPVkxAxq9OeGYKivz1GyOR+Tg1l3/dUls8WXPLDsXfnTWqpAcRr7cNIfTlgUYBnypEBZLGzQ/wIki2zXhJCWyTrlAGB0/mndGPLXecXgvZkfxkfBXN/dK/XUAbCGaKu/GXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175727; c=relaxed/simple;
	bh=kHyYYCdBgYQk24bzTT7RfjZBbzTiO+dJI+C6Eodq4+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIy65lguGBhcCJkwCRTIvZSyqOep68ZhqmbbwKHxFOxcRZ/FWNDs0s/enRLmrWPP5S6IogfMBO3laWDDFAKFjnnW9x0tw3q0pM3Frz1J65kus9L3MIHTaKeCvAoX3SMZ+irPKNgAjkjEQ2i9sEEELKYlbCMSEFT2h41Bb+kRga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C2CC1515;
	Thu, 25 Jan 2024 01:42:48 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BFE23F73F;
	Thu, 25 Jan 2024 01:41:58 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	kvmarm@lists.linux.dev
Subject: [PATCH V16 5/8] KVM: arm64: nvhe: Disable branch generation in nVHE guests
Date: Thu, 25 Jan 2024 15:11:16 +0530
Message-Id: <20240125094119.2542332-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-1-anshuman.khandual@arm.com>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the BRBE before we enter the guest, saving the status and enable it
back once we get out of the guest. This avoids capturing branch records in
the guest kernel or userspace, which would be confusing the host samples.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V16:

- Dropped BRBCR_EL1 and BRBFCR_EL1 from enum vcpu_sysreg
- Reverted back the KVM NVHE patch - used host_debug_state based 'brbcr_el1'
  element, and dropped the previous dependency on Jame's coresight series

 arch/arm64/include/asm/kvm_host.h  |  5 ++++-
 arch/arm64/kvm/debug.c             |  5 +++++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 33 ++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 21c57b812569..bce8792092af 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -569,7 +569,7 @@ struct kvm_vcpu_arch {
 	u8 cflags;
 
 	/* Input flags to the hypervisor code, potentially cleared after use */
-	u8 iflags;
+	u16 iflags;
 
 	/* State flags for kernel bookkeeping, unused by the hypervisor code */
 	u8 sflags;
@@ -610,6 +610,7 @@ struct kvm_vcpu_arch {
 		u64 pmscr_el1;
 		/* Self-hosted trace */
 		u64 trfcr_el1;
+		u64 brbcr_el1;
 	} host_debug_state;
 
 	/* VGIC state */
@@ -779,6 +780,8 @@ struct kvm_vcpu_arch {
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 /* vcpu running in HYP context */
 #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
+/* Save BRBE context if active  */
+#define DEBUG_STATE_SAVE_BRBE	__vcpu_single_flag(iflags, BIT(8))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..99f85d8acbf3 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -335,10 +335,15 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
 	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+
+	/* Check if we have BRBE implemented and available at the host */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT))
+		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_BRBE);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 4558c02eb352..79bcf0fb1326 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -79,6 +79,34 @@ static void __debug_restore_trace(u64 trfcr_el1)
 	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
 }
 
+static void __debug_save_brbe(u64 *brbcr_el1)
+{
+	*brbcr_el1 = 0;
+
+	/* Check if the BRBE is enabled */
+	if (!(read_sysreg_s(SYS_BRBCR_EL1) & (BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE)))
+		return;
+
+	/*
+	 * Prohibit branch record generation while we are in guest.
+	 * Since access to BRBCR_EL1 is trapped, the guest can't
+	 * modify the filtering set by the host.
+	 */
+	*brbcr_el1 = read_sysreg_s(SYS_BRBCR_EL1);
+	write_sysreg_s(0, SYS_BRBCR_EL1);
+	isb();
+}
+
+static void __debug_restore_brbe(u64 brbcr_el1)
+{
+	if (!brbcr_el1)
+		return;
+
+	/* Restore BRBE controls */
+	write_sysreg_s(brbcr_el1, SYS_BRBCR_EL1);
+	isb();
+}
+
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	/* Disable and flush SPE data generation */
@@ -87,6 +115,9 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 	/* Disable and flush Self-Hosted Trace generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
 		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
+	/* Disable BRBE branch records */
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_BRBE))
+		__debug_save_brbe(&vcpu->arch.host_debug_state.brbcr_el1);
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -100,6 +131,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
 		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_BRBE))
+		__debug_restore_brbe(vcpu->arch.host_debug_state.brbcr_el1);
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
-- 
2.25.1


