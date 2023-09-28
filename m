Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332D7B20CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjI1PRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjI1PQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:16:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25131CCD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:16:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE021476;
        Thu, 28 Sep 2023 08:17:26 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.3.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7AD23F59C;
        Thu, 28 Sep 2023 08:16:43 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org, maz@kernel.org,
        suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
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
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: KVM: Write TRFCR value on guest switch with nVHE
Date:   Thu, 28 Sep 2023 16:16:08 +0100
Message-Id: <20230928151611.3042443-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928151611.3042443-1-james.clark@arm.com>
References: <20230928151611.3042443-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest value for TRFCR requested by the Coresight driver is saved
in guest_trfcr_el1. On guest switch this value needs to be written to
the register. Currently TRFCR is only modified when we want to disable
trace completely in guests due to an issue with TRBE. Expand the
__debug_save_trace() function to always write to the register if a
different value for guests is required, but also keep the existing TRBE
disable behavior if that's required.

The TRFCR restore function remains functionally the same, except a value
of 0 doesn't mean "don't restore" anymore. Now that we save both guest
and host values the register is restored any time the guest and host
values differ.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/kvm/debug.c             | 13 ++++++-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 56 ++++++++++++++++++------------
 2 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 379d2677961f..e39f2d535b25 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -332,10 +332,21 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 
-	/* Check if we have TRBE implemented and available at the host */
+	/*
+	 * Check if we have TRBE implemented and available at the host. If it's
+	 * in use at the time of guest switch it will need to be disabled and
+	 * then restored.
+	 */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
 	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
+	/*
+	 * Also save TRFCR on nVHE if FEAT_TRF (TraceFilt) exists. This will be
+	 * done in cases where use of TRBE doesn't completely disable trace and
+	 * handles the exclude_host/exclude_guest rules of the trace session.
+	 */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT))
+		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 55bc01e9808f..7ceb16be14cd 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -51,32 +51,44 @@ static void __debug_restore_spe(u64 pmscr_el1)
 	write_sysreg_s(pmscr_el1, SYS_PMSCR_EL1);
 }
 
-static void __debug_save_trace(u64 *trfcr_el1)
+/*
+ * Save TRFCR and disable trace completely if TRBE is being used, otherwise
+ * apply required guest TRFCR value.
+ */
+static void __debug_save_trace(struct kvm_vcpu *vcpu)
 {
-	*trfcr_el1 = 0;
+	vcpu->arch.host_debug_state.host_trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
 
 	/* Check if the TRBE is enabled */
-	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
-		return;
-	/*
-	 * Prohibit trace generation while we are in guest.
-	 * Since access to TRFCR_EL1 is trapped, the guest can't
-	 * modify the filtering set by the host.
-	 */
-	*trfcr_el1 = read_sysreg_s(SYS_TRFCR_EL1);
-	write_sysreg_s(0, SYS_TRFCR_EL1);
-	isb();
-	/* Drain the trace buffer to memory */
-	tsb_csync();
+	if (read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E) {
+		/*
+		 * Prohibit trace generation while we are in guest. Since access
+		 * to TRFCR_EL1 is trapped, the guest can't modify the filtering
+		 * set by the host.
+		 */
+		vcpu->arch.host_debug_state.guest_trfcr_el1 = 0;
+		write_sysreg_s(0, SYS_TRFCR_EL1);
+		isb();
+		/* Drain the trace buffer to memory */
+		tsb_csync();
+	} else {
+		/*
+		 * Not using TRBE, so guest trace works. Apply the guest filters
+		 * provided by the Coresight driver, if different.
+		 */
+		if (vcpu->arch.host_debug_state.guest_trfcr_el1 !=
+		    vcpu->arch.host_debug_state.host_trfcr_el1)
+			write_sysreg_s(vcpu->arch.host_debug_state.guest_trfcr_el1,
+				       SYS_TRFCR_EL1);
+	}
 }
 
-static void __debug_restore_trace(u64 trfcr_el1)
+static void __debug_restore_trace(struct kvm_vcpu *vcpu)
 {
-	if (!trfcr_el1)
-		return;
-
 	/* Restore trace filter controls */
-	write_sysreg_s(trfcr_el1, SYS_TRFCR_EL1);
+	if (vcpu->arch.host_debug_state.host_trfcr_el1 !=
+	    vcpu->arch.host_debug_state.guest_trfcr_el1)
+		write_sysreg_s(vcpu->arch.host_debug_state.host_trfcr_el1, SYS_TRFCR_EL1);
 }
 
 void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
@@ -84,9 +96,9 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 	/* Disable and flush SPE data generation */
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
-	/* Disable and flush Self-Hosted Trace generation */
+
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
-		__debug_save_trace(&vcpu->arch.host_debug_state.host_trfcr_el1);
+		__debug_save_trace(vcpu);
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -99,7 +111,7 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
-		__debug_restore_trace(vcpu->arch.host_debug_state.host_trfcr_el1);
+		__debug_restore_trace(vcpu);
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
-- 
2.34.1

