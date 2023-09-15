Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51BC7A1F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjIOMt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjIOMtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A543CE7E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:49:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4586C15;
        Fri, 15 Sep 2023 05:50:22 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB4103F5A1;
        Fri, 15 Sep 2023 05:49:42 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: arm64: Configure HCRX_EL2 dynamically
Date:   Fri, 15 Sep 2023 13:48:38 +0100
Message-Id: <20230915124840.474888-2-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915124840.474888-1-kristina.martsenko@arm.com>
References: <20230915124840.474888-1-kristina.martsenko@arm.com>
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

At the moment the HCRX_EL2 system register is always initialized to
HCRX_GUEST_FLAGS when running a guest. Instead, choose the configuration
at vcpu reset time and save it in the vcpu struct, similarly to how
HCR_EL2 is set up. This will be needed in a subsequent change to
configure the register based on CPU features detected at runtime.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h    | 5 +++++
 arch/arm64/include/asm/kvm_host.h       | 1 +
 arch/arm64/kvm/arm.c                    | 1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 1 +
 arch/arm64/kvm/hyp/nvhe/pkvm.c          | 1 +
 6 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 3d6725ff0bf6..64ea27e6deb1 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -134,6 +134,11 @@ static inline void vcpu_ptrauth_disable(struct kvm_vcpu *vcpu)
 	vcpu->arch.hcr_el2 &= ~(HCR_API | HCR_APK);
 }
 
+static inline void vcpu_reset_hcrx(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcrx_el2 = HCRX_GUEST_FLAGS;
+}
+
 static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.vsesr_el2;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index af06ccb7ee34..2764748756a7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -487,6 +487,7 @@ struct kvm_vcpu_arch {
 
 	/* Values of trap registers for the guest. */
 	u64 hcr_el2;
+	u64 hcrx_el2;
 	u64 mdcr_el2;
 	u64 cptr_el2;
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4866b3f7b4ea..fa359fd6fca9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1318,6 +1318,7 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	}
 
 	vcpu_reset_hcr(vcpu);
+	vcpu_reset_hcrx(vcpu);
 	vcpu->arch.cptr_el2 = kvm_get_reset_cptr_el2(vcpu);
 
 	/*
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 9cfe6bd1dbe4..119b75344505 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -198,7 +198,7 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
 	write_sysreg(vcpu->arch.mdcr_el2, mdcr_el2);
 
 	if (cpus_have_final_cap(ARM64_HAS_HCX)) {
-		u64 hcrx = HCRX_GUEST_FLAGS;
+		u64 hcrx = vcpu->arch.hcrx_el2;
 		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)) {
 			u64 clr = 0, set = 0;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 857d9bc04fd4..26692083b80b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -35,6 +35,7 @@ static void flush_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
 	hyp_vcpu->vcpu.arch.hw_mmu	= host_vcpu->arch.hw_mmu;
 
 	hyp_vcpu->vcpu.arch.hcr_el2	= host_vcpu->arch.hcr_el2;
+	hyp_vcpu->vcpu.arch.hcrx_el2	= host_vcpu->arch.hcrx_el2;
 	hyp_vcpu->vcpu.arch.mdcr_el2	= host_vcpu->arch.mdcr_el2;
 	hyp_vcpu->vcpu.arch.cptr_el2	= host_vcpu->arch.cptr_el2;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 8033ef353a5d..8c8b37525dce 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -188,6 +188,7 @@ static void pvm_init_trap_regs(struct kvm_vcpu *vcpu)
 
 	/* Clear res0 and set res1 bits to trap potential new features. */
 	vcpu->arch.hcr_el2 &= ~(HCR_RES0);
+	vcpu->arch.hcrx_el2 &= ~(HCRX_EL2_RES0);
 	vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_RES0);
 	if (!has_hvhe()) {
 		vcpu->arch.cptr_el2 |= CPTR_NVHE_EL2_RES1;
-- 
2.25.1

