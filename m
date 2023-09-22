Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09687AB08E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjIVL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjIVL0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:26:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DDC7AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:26:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A971007;
        Fri, 22 Sep 2023 04:26:42 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2DB93F5A1;
        Fri, 22 Sep 2023 04:26:02 -0700 (PDT)
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
Subject: [PATCH v2 1/2] KVM: arm64: Add handler for MOPS exceptions
Date:   Fri, 22 Sep 2023 12:25:07 +0100
Message-Id: <20230922112508.1774352-2-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922112508.1774352-1-kristina.martsenko@arm.com>
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An Armv8.8 FEAT_MOPS main or epilogue instruction will take an exception
if executed on a CPU with a different MOPS implementation option (A or
B) than the CPU where the preceding prologue instruction ran. In this
case the OS exception handler is expected to reset the registers and
restart execution from the prologue instruction.

A KVM guest may use the instructions at EL1 at times when the guest is
not able to handle the exception, expecting that the instructions will
only run on one CPU (e.g. when running UEFI boot services in the guest).
As KVM may reschedule the guest between different types of CPUs at any
time (on an asymmetric system), it needs to also handle the resulting
exception itself in case the guest is not able to. A similar situation
will also occur in the future when live migrating a guest from one type
of CPU to another.

Add handling for the MOPS exception to KVM. The handling can be shared
with the EL0 exception handler, as the logic and register layouts are
the same. The exception can be handled right after exiting a guest,
which avoids the cost of returning to the host exit handler.

Similarly to the EL0 exception handler, in case the main or epilogue
instruction is being single stepped, it makes sense to finish the step
before executing the prologue instruction, so advance the single step
state machine.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/traps.h          | 54 ++++++++++++++++++++++++-
 arch/arm64/kernel/traps.c               | 48 +---------------------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 17 ++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c        |  2 +
 arch/arm64/kvm/hyp/vhe/switch.c         |  1 +
 5 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d66dfb3a72dd..eefe766d6161 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -9,10 +9,9 @@
 
 #include <linux/list.h>
 #include <asm/esr.h>
+#include <asm/ptrace.h>
 #include <asm/sections.h>
 
-struct pt_regs;
-
 #ifdef CONFIG_ARMV8_DEPRECATED
 bool try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn);
 #else
@@ -101,4 +100,55 @@ static inline unsigned long arm64_ras_serror_get_severity(unsigned long esr)
 
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned long esr);
 void __noreturn arm64_serror_panic(struct pt_regs *regs, unsigned long esr);
+
+static inline void arm64_mops_reset_regs(struct user_pt_regs *regs, unsigned long esr)
+{
+	bool wrong_option = esr & ESR_ELx_MOPS_ISS_WRONG_OPTION;
+	bool option_a = esr & ESR_ELx_MOPS_ISS_OPTION_A;
+	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
+	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
+	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
+	unsigned long dst, src, size;
+
+	dst = regs->regs[dstreg];
+	src = regs->regs[srcreg];
+	size = regs->regs[sizereg];
+
+	/*
+	 * Put the registers back in the original format suitable for a
+	 * prologue instruction, using the generic return routine from the
+	 * Arm ARM (DDI 0487I.a) rules CNTMJ and MWFQH.
+	 */
+	if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
+		/* SET* instruction */
+		if (option_a ^ wrong_option) {
+			/* Format is from Option A; forward set */
+			regs->regs[dstreg] = dst + size;
+			regs->regs[sizereg] = -size;
+		}
+	} else {
+		/* CPY* instruction */
+		if (!(option_a ^ wrong_option)) {
+			/* Format is from Option B */
+			if (regs->pstate & PSR_N_BIT) {
+				/* Backward copy */
+				regs->regs[dstreg] = dst - size;
+				regs->regs[srcreg] = src - size;
+			}
+		} else {
+			/* Format is from Option A */
+			if (size & BIT(63)) {
+				/* Forward copy */
+				regs->regs[dstreg] = dst + size;
+				regs->regs[srcreg] = src + size;
+				regs->regs[sizereg] = -size;
+			}
+		}
+	}
+
+	if (esr & ESR_ELx_MOPS_ISS_FROM_EPILOGUE)
+		regs->pc -= 8;
+	else
+		regs->pc -= 4;
+}
 #endif
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8b70759cdbb9..ede65a20e7dc 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -516,53 +516,7 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 
 void do_el0_mops(struct pt_regs *regs, unsigned long esr)
 {
-	bool wrong_option = esr & ESR_ELx_MOPS_ISS_WRONG_OPTION;
-	bool option_a = esr & ESR_ELx_MOPS_ISS_OPTION_A;
-	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
-	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
-	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
-	unsigned long dst, src, size;
-
-	dst = pt_regs_read_reg(regs, dstreg);
-	src = pt_regs_read_reg(regs, srcreg);
-	size = pt_regs_read_reg(regs, sizereg);
-
-	/*
-	 * Put the registers back in the original format suitable for a
-	 * prologue instruction, using the generic return routine from the
-	 * Arm ARM (DDI 0487I.a) rules CNTMJ and MWFQH.
-	 */
-	if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
-		/* SET* instruction */
-		if (option_a ^ wrong_option) {
-			/* Format is from Option A; forward set */
-			pt_regs_write_reg(regs, dstreg, dst + size);
-			pt_regs_write_reg(regs, sizereg, -size);
-		}
-	} else {
-		/* CPY* instruction */
-		if (!(option_a ^ wrong_option)) {
-			/* Format is from Option B */
-			if (regs->pstate & PSR_N_BIT) {
-				/* Backward copy */
-				pt_regs_write_reg(regs, dstreg, dst - size);
-				pt_regs_write_reg(regs, srcreg, src - size);
-			}
-		} else {
-			/* Format is from Option A */
-			if (size & BIT(63)) {
-				/* Forward copy */
-				pt_regs_write_reg(regs, dstreg, dst + size);
-				pt_regs_write_reg(regs, srcreg, src + size);
-				pt_regs_write_reg(regs, sizereg, -size);
-			}
-		}
-	}
-
-	if (esr & ESR_ELx_MOPS_ISS_FROM_EPILOGUE)
-		regs->pc -= 8;
-	else
-		regs->pc -= 4;
+	arm64_mops_reset_regs(&regs->user_regs, esr);
 
 	/*
 	 * If single stepping then finish the step before executing the
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 9cfe6bd1dbe4..f99d8af0b9af 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -30,6 +30,7 @@
 #include <asm/fpsimd.h>
 #include <asm/debug-monitors.h>
 #include <asm/processor.h>
+#include <asm/traps.h>
 
 struct kvm_exception_table_entry {
 	int insn, fixup;
@@ -265,6 +266,22 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 	return __get_fault_info(vcpu->arch.fault.esr_el2, &vcpu->arch.fault);
 }
 
+static bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
+{
+	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
+	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
+	write_sysreg_el2(*vcpu_pc(vcpu), SYS_ELR);
+
+	/*
+	 * Finish potential single step before executing the prologue
+	 * instruction.
+	 */
+	*vcpu_cpsr(vcpu) &= ~DBG_SPSR_SS;
+	write_sysreg_el2(*vcpu_cpsr(vcpu), SYS_SPSR);
+
+	return true;
+}
+
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c353a06ee7e6..c50f8459e4fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -192,6 +192,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
 	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
+	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
 };
 
 static const exit_handler_fn pvm_exit_handlers[] = {
@@ -203,6 +204,7 @@ static const exit_handler_fn pvm_exit_handlers[] = {
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
 	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
+	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
 };
 
 static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 6537f58b1a8c..796202f2e08f 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -126,6 +126,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
 	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
+	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
 };
 
 static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
-- 
2.25.1

