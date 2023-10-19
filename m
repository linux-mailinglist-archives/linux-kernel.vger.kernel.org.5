Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC67D000C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbjJSQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346227AbjJSQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:56:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D381D48
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:56:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB95143D;
        Thu, 19 Oct 2023 09:57:07 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74C1A3F5A1;
        Thu, 19 Oct 2023 09:56:23 -0700 (PDT)
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
        Fuad Tabba <tabba@google.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] arm64: KVM: Write TRFCR value on guest switch with nVHE
Date:   Thu, 19 Oct 2023 17:55:03 +0100
Message-Id: <20231019165510.1966367-6-james.clark@arm.com>
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

The guest value for TRFCR requested by the Coresight driver is saved
in sysregs[TRFCR_EL1]. On guest switch this value needs to be written to
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
 arch/arm64/include/asm/kvm_hyp.h   |  6 ++-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 68 ++++++++++++++++++------------
 arch/arm64/kvm/hyp/nvhe/switch.c   |  4 +-
 3 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 52ac90d419e7..6286e580696e 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -103,8 +103,10 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu);
 void __debug_switch_to_host(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_NVHE_HYPERVISOR__
-void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt);
-void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt);
+void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
+				    struct kvm_cpu_context *guest_ctxt);
+void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
+				       struct kvm_cpu_context *guest_ctxt);
 #endif
 
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index f389ee59788c..6174f710948e 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -51,42 +51,57 @@ static void __debug_restore_spe(struct kvm_cpu_context *host_ctxt)
 	write_sysreg_s(ctxt_sys_reg(host_ctxt, PMSCR_EL1), SYS_PMSCR_EL1);
 }
 
-static void __debug_save_trace(struct kvm_cpu_context *host_ctxt)
+/*
+ * Save TRFCR and disable trace completely if TRBE is being used, otherwise
+ * apply required guest TRFCR value.
+ */
+static void __debug_save_trace(struct kvm_cpu_context *host_ctxt,
+			       struct kvm_cpu_context *guest_ctxt)
 {
-	ctxt_sys_reg(host_ctxt, TRFCR_EL1) = 0;
+	ctxt_sys_reg(host_ctxt, TRFCR_EL1) = read_sysreg_s(SYS_TRFCR_EL1);
 
 	/* Check if the TRBE is enabled */
-	if (!(read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E))
-		return;
-	/*
-	 * Prohibit trace generation while we are in guest.
-	 * Since access to TRFCR_EL1 is trapped, the guest can't
-	 * modify the filtering set by the host.
-	 */
-	ctxt_sys_reg(host_ctxt, TRFCR_EL1) = read_sysreg_s(SYS_TRFCR_EL1);
-	write_sysreg_s(0, SYS_TRFCR_EL1);
-	isb();
-	/* Drain the trace buffer to memory */
-	tsb_csync();
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRBE) &&
+	    (read_sysreg_s(SYS_TRBLIMITR_EL1) & TRBLIMITR_EL1_E)) {
+		/*
+		 * Prohibit trace generation while we are in guest. Since access
+		 * to TRFCR_EL1 is trapped, the guest can't modify the filtering
+		 * set by the host.
+		 */
+		ctxt_sys_reg(guest_ctxt, TRFCR_EL1) = 0;
+		write_sysreg_s(0, SYS_TRFCR_EL1);
+		isb();
+		/* Drain the trace buffer to memory */
+		tsb_csync();
+	} else {
+		/*
+		 * Not using TRBE, so guest trace works. Apply the guest filters
+		 * provided by the Coresight driver, if different.
+		 */
+		if (ctxt_sys_reg(host_ctxt, TRFCR_EL1) !=
+		    ctxt_sys_reg(guest_ctxt, TRFCR_EL1))
+			write_sysreg_s(ctxt_sys_reg(guest_ctxt, TRFCR_EL1),
+				       SYS_TRFCR_EL1);
+	}
 }
 
-static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt)
+static void __debug_restore_trace(struct kvm_cpu_context *host_ctxt,
+				  struct kvm_cpu_context *guest_ctxt)
 {
-	if (!ctxt_sys_reg(host_ctxt, TRFCR_EL1))
-		return;
-
 	/* Restore trace filter controls */
-	write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1), SYS_TRFCR_EL1);
+	if (ctxt_sys_reg(host_ctxt, TRFCR_EL1) != ctxt_sys_reg(guest_ctxt, TRFCR_EL1))
+		write_sysreg_s(ctxt_sys_reg(host_ctxt, TRFCR_EL1), SYS_TRFCR_EL1);
 }
 
-void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt)
+void __debug_save_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
+				    struct kvm_cpu_context *guest_ctxt)
 {
 	/* Disable and flush SPE data generation */
 	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_save_spe(host_ctxt);
-	/* Disable and flush Self-Hosted Trace generation */
-	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_save_trace(host_ctxt);
+
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRFCR))
+		__debug_save_trace(host_ctxt, guest_ctxt);
 }
 
 void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -94,12 +109,13 @@ void __debug_switch_to_guest(struct kvm_vcpu *vcpu)
 	__debug_switch_to_guest_common(vcpu);
 }
 
-void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt)
+void __debug_restore_host_buffers_nvhe(struct kvm_cpu_context *host_ctxt,
+				       struct kvm_cpu_context *guest_ctxt)
 {
 	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_restore_spe(host_ctxt);
-	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRBE))
-		__debug_restore_trace(host_ctxt);
+	if (vcpu_get_flag(host_ctxt->__hyp_running_vcpu, DEBUG_STATE_SAVE_TRFCR))
+		__debug_restore_trace(host_ctxt, guest_ctxt);
 }
 
 void __debug_switch_to_host(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 6b4b24ae077f..c7bea5cf672d 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -278,7 +278,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * translation regime to EL2 (via MDCR_EL2_E2PB == 0) and
 	 * before we load guest Stage1.
 	 */
-	__debug_save_host_buffers_nvhe(host_ctxt);
+	__debug_save_host_buffers_nvhe(host_ctxt, guest_ctxt);
 
 	/*
 	 * We're about to restore some new MMU state. Make sure
@@ -345,7 +345,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * This must come after restoring the host sysregs, since a non-VHE
 	 * system may enable SPE here and make use of the TTBRs.
 	 */
-	__debug_restore_host_buffers_nvhe(host_ctxt);
+	__debug_restore_host_buffers_nvhe(host_ctxt, guest_ctxt);
 
 	if (pmu_switch_needed)
 		__pmu_switch_to_host(vcpu);
-- 
2.34.1

