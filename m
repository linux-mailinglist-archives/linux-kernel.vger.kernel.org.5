Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262FA76FE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHDKOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjHDKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:13:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50B5446AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:13:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA8D81007;
        Fri,  4 Aug 2023 03:14:34 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.3.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AC883F6C4;
        Fri,  4 Aug 2023 03:13:49 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev
Cc:     James Clark <james.clark@arm.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] arm64: KVM: Support exclude_guest for Coresight trace in nVHE
Date:   Fri,  4 Aug 2023 11:13:12 +0100
Message-Id: <20230804101317.460697-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804101317.460697-1-james.clark@arm.com>
References: <20230804101317.460697-1-james.clark@arm.com>
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

Currently trace will always be generated in nVHE as long as TRBE isn't
being used. To allow filtering out guest trace, re-apply the filter
rules before switching to the guest.

The TRFCR restore function remains the same.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/kvm/debug.c             |  7 ++++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 56 +++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..ebb4db20a859 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -335,10 +335,17 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
 	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	/*
+	 * Save TRFCR on nVHE if FEAT_TRF exists. This will be done in cases
+	 * where DEBUG_STATE_SAVE_TRBE doesn't completely disable trace.
+	 */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT))
+		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 4558c02eb352..0e8c85b29b92 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -51,13 +51,17 @@ static void __debug_restore_spe(u64 pmscr_el1)
 	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
 }
 
-static void __debug_save_trace(u64 *trfcr_el1)
+/*
+ * Save TRFCR and disable trace completely if TRBE is being used. Return true
+ * if trace was disabled.
+ */
+static bool __debug_save_trace(u64 *trfcr_el1)
 {
 	*trfcr_el1 = 0;
 
 	/* Check if the TRBE is enabled */
 	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
-		return;
+		return false;
 	/*
 	 * Prohibit trace generation while we are in guest.
 	 * Since access to TRFCR_EL1 is trapped, the guest can't
@@ -68,6 +72,8 @@ static void __debug_save_trace(u64 *trfcr_el1)
 	isb();
 	/* Drain the trace buffer to memory */
 	tsb_csync();
+
+	return true;
 }
 
 static void __debug_restore_trace(u64 trfcr_el1)
@@ -79,14 +85,55 @@ static void __debug_restore_trace(u64 trfcr_el1)
 	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
 }
 
+#if IS_ENABLED(CONFIG_PERF_EVENTS)
+static inline void __debug_save_trfcr(struct kvm_vcpu *vcpu)
+{
+	u64 trfcr;
+	struct kvm_etm_event etm_event = vcpu->arch.host_debug_state.etm_event;
+
+	/* No change if neither are excluded */
+	if (!etm_event.exclude_guest && !etm_event.exclude_host) {
+		/* Zeroing prevents restoring a stale value */
+		vcpu->arch.host_debug_state.trfcr_el1 = 0;
+		return;
+	}
+
+	trfcr = read_sysreg_s(SYS_TRFCR_EL1);
+	vcpu->arch.host_debug_state.trfcr_el1 = trfcr;
+
+	if (etm_event.exclude_guest) {
+		trfcr &= ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
+	} else {
+		/*
+		 * If host was excluded then EL0 and ELx tracing bits will
+		 * already be cleared so they need to be set now for the guest.
+		 */
+		trfcr |= etm_event.exclude_kernel ? 0 : TRFCR_ELx_ExTRE;
+		trfcr |= etm_event.exclude_user ? 0 : TRFCR_ELx_E0TRE;
+	}
+	write_sysreg_s(trfcr, SYS_TRFCR_EL1);
+}
+#else
+static inline void __debug_save_trfcr(struct kvm_vcpu *vcpu) {}
+#endif
+
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
+	bool trc_disabled = false;
+
 	/* Disable and flush SPE data generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
 	/* Disable and flush Self-Hosted Trace generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
+		trc_disabled = __debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
+
+	/*
+	 * As long as trace wasn't completely disabled due to use of TRBE,
+	 * TRFCR can be saved and the exclude_guest rules applied.
+	 */
+	if (!trc_disabled && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
+		__debug_save_trfcr(vcpu);
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -98,7 +145,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE) ||
+	    vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
 		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
 }
 
-- 
2.34.1

