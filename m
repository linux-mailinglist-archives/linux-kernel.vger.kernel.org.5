Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C697D0009
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjJSQ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345284AbjJSQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:56:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BE118A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:56:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE7FC1476;
        Thu, 19 Oct 2023 09:56:46 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CEFD3F5A1;
        Thu, 19 Oct 2023 09:56:02 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, maz@kernel.org, suzuki.poulose@arm.com
Cc:     broonie@kernel.org, James Clark <james.clark@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] arm64: KVM: Move SPE and trace registers to the sysreg array
Date:   Thu, 19 Oct 2023 17:55:00 +0100
Message-Id: <20231019165510.1966367-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019165510.1966367-1-james.clark@arm.com>
References: <20231019165510.1966367-1-james.clark@arm.com>
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

pmscr_el1 and trfcr_el1 are currently special cased in the
host_debug_state struct, but they're just registers after all so give
them entries in the sysreg array and refer to them through the host
context.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h  |  6 ++--
 arch/arm64/include/asm/kvm_hyp.h   |  4 +--
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 44 +++++++++++++++---------------
 arch/arm64/kvm/hyp/nvhe/switch.c   |  4 +--
 4 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4a966c0d7373..7c82927ddaf2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -437,6 +437,8 @@ enum vcpu_sysreg {
 	CNTHP_CVAL_EL2,
 	CNTHV_CTL_EL2,
 	CNTHV_CVAL_EL2,
+	PMSCR_EL1,	/* Statistical profiling extension */
+	TRFCR_EL1,	/* Self-hosted trace filters */
 
 	NR_SYS_REGS	/* Nothing after this line! */
 };
@@ -570,10 +572,6 @@ struct kvm_vcpu_arch {
 	struct {
 		/* {Break,watch}point registers */
 		struct kvm_guest_debug_arch regs;
-		/* Statistical profiling extension */
-		u64 pmscr_el1;
-		/* Self-hosted trace */
-		u64 trfcr_el1;
 	} host_debug_state;
 
 	/* VGIC state */
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 66efd67ea7e8..52ac90d419e7 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -103,8 +103,8 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu);
 void __debug_switch_to_host(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_NVHE_HYPERVISOR__
-void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu);
-void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
+void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt);
+void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt);
 #endif
 
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 4558c02eb352..f389ee59788c 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -14,12 +14,12 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
-static void __debug_save_spe(u64 *pmscr_el1)
+static void __debug_save_spe(struct kvm_cpu_context *host_ctxt)
 {
 	u64 reg;
 
 	/* Clear pmscr in case of early return */
-	*pmscr_el1 = 0;
+	ctxt_sys_reg(host_ctxt, PMSCR_EL1) = 0;
 
 	/*
 	 * At this point, we know that this CPU implements
@@ -31,7 +31,7 @@ static void __debug_save_spe(u64 *pmscr_el1)
 		return;
 
 	/* Yes; save the control register and disable data generation */
-	*pmscr_el1 = read_sysreg_s(SYS_PMSCR_EL1);
+	ctxt_sys_reg(host_ctxt, PMSCR_EL1) = read_sysreg_s(SYS_PMSCR_EL1);
 	write_sysreg_s(0, SYS_PMSCR_EL1);
 	isb();
 
@@ -39,21 +39,21 @@ static void __debug_save_spe(u64 *pmscr_el1)
 	psb_csync();
 }
 
-static void __debug_restore_spe(u64 pmscr_el1)
+static void __debug_restore_spe(struct kvm_cpu_context *host_ctxt)
 {
-	if (!pmscr_el1)
+	if (!ctxt_sys_reg(host_ctxt, PMSCR_EL1))
 		return;
 
 	/* The host page table is installed, but not yet synchronised */
 	isb();
 
 	/* Re-enable data generation */
-	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
+	write_sysreg_s(ctxt_sys_reg(host_ctxt, PMSCR_EL1), SYS_PMSCR_EL1);
 }
 
-static void __debug_save_trace(u64 *trfcr_el1)
+static void __debug_save_trace(struct kvm_cpu_context *host_ctxt)
 {
-	*trfcr_el1 = 0;
+	ctxt_sys_reg(host_ctxt, TRFCR_EL1) = 0;
 
 	/* Check if the TRBE is enabled */
 	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
@@ -63,30 +63,30 @@ static void __debug_save_trace(u64 *trfcr_el1)
 	 * Since access to TRFCR_EL1 is trapped, the guest can't
 	 * modify the filtering set by the host.
 	 */
-	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
+	ctxt_sys_reg(host_ctxt, TRFCR_EL1) = read_sysreg_s(SYS_TRFCR_EL1);
 	write_sysreg_s(0, SYS_TRFCR_EL1);
 	isb();
 	/* Drain the trace buffer to memory */
 	tsb_csync();
 }
 
-static void __debug_restore_trace(u64 trfcr_el1)
+static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt)
 {
-	if (!trfcr_el1)
+	if (!ctxt_sys_reg(host_ctxt, TRFCR_EL1))
 		return;
 
 	/* Restore trace filter controls */
-	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
+	write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1), SYS_TRFCR_EL1);
 }
 
-void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
+void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt)
 {
 	/* Disable and flush SPE data generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
-		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_SPE))
+		__debug_save_spe(host_ctxt);
 	/* Disable and flush Self-Hosted Trace generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRBE))
+		__debug_save_trace(host_ctxt);
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -94,12 +94,12 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 	__debug_switch_to_guest_common(vcpu);
 }
 
-void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
+void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt)
 {
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
-		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_SPE))
+		__debug_restore_spe(host_ctxt);
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRBE))
+		__debug_restore_trace(host_ctxt);
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c50f8459e4fc..6b4b24ae077f 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -278,7 +278,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * translation regime to EL2 (via MDCR_EL2_E2PB == 0) and
 	 * before we load guest Stage1.
 	 */
-	__debug_save_host_buffers_nvhe(vcpu);
+	__debug_save_host_buffers_nvhe(host_ctxt);
 
 	/*
 	 * We're about to restore some new MMU state. Make sure
@@ -345,7 +345,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * This must come after restoring the host sysregs, since a non-VHE
 	 * system may enable SPE here and make use of the TTBRs.
 	 */
-	__debug_restore_host_buffers_nvhe(vcpu);
+	__debug_restore_host_buffers_nvhe(host_ctxt);
 
 	if (pmu_switch_needed)
 		__pmu_switch_to_host(vcpu);
-- 
2.34.1

