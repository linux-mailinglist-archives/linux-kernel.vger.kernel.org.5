Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1DF7C4BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjJKH2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbjJKH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:28:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD8FD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:28:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S545q6Y5FzVlXw;
        Wed, 11 Oct 2023 15:24:31 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:28:00 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <yuzenghui@huawei.com>, <anshuman.khandual@arm.com>,
        <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <youngmin.nam@samsung.com>,
        <renzhijie2@huawei.com>, <ardb@kernel.org>, <f.fainelli@gmail.com>,
        <james.morse@arm.com>, <sashal@kernel.org>,
        <scott@os.amperecomputing.com>, <ebiederm@xmission.com>,
        <haibinzhang@tencent.com>, <hewenliang4@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 08/15] arm64: factor out EL1 SSBS emulation hook
Date:   Wed, 11 Oct 2023 07:26:54 +0000
Message-ID: <20231011072701.876772-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011072701.876772-1-ruanjinjie@huawei.com>
References: <20231011072701.876772-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Currently call_undef_hook() is used to handle UNDEFINED exceptions from
EL0 and EL1. As support for deprecated instructions may be enabled
independently, the handlers for individual instructions are organised as
a linked list of struct undef_hook which can be manipulated dynamically.
As this can be manipulated dynamically, the list is protected with a
raw_spinlock which must be acquired when handling UNDEFINED exceptions
or when manipulating the list of handlers.

This locking is unfortunate as it serialises handling of UNDEFINED
exceptions, and requires RCU to be enabled for lockdep, requiring the
use of RCU_NONIDLE() in resume path of cpu_suspend() since commit:

  a2c42bbabbe260b7 ("arm64: spectre: Prevent lockdep splat on v4 mitigation enable path")

The list of UNDEFINED handlers largely consist of handlers for
exceptions taken from EL0, and the only handler for exceptions taken
from EL1 handles `MSR SSBS, #imm` on CPUs which feature PSTATE.SSBS but
lack the corresponding MSR (Immediate) instruction. Other than this we
never expect to take an UNDEFINED exception from EL1 in normal
operation.

This patch reworks do_el0_undef() to invoke the EL1 SSBS handler
directly, relegating call_undef_hook() to only handle EL0 UNDEFs. This
removes redundant work to iterate the list for EL1 UNDEFs, and removes
the need for locking, permitting EL1 UNDEFs to be handled in parallel
without contention.

The RCU_NONIDLE() call in cpu_suspend() will be removed in a subsequent
patch, as there are other potential issues with the use of
instrumentable code and RCU in the CPU suspend code.

I've tested this by forcing the detection of SSBS on a CPU that doesn't
have it, and verifying that the try_emulate_el1_ssbs() callback is
invoked.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-4-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/spectre.h |  2 ++
 arch/arm64/kernel/proton-pack.c  | 26 +++++++-------------------
 arch/arm64/kernel/traps.c        | 15 ++++++++-------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 4b3a5f050f71..e48afcb69392 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -18,6 +18,7 @@ enum mitigation_state {
 	SPECTRE_VULNERABLE,
 };
 
+struct pt_regs;
 struct task_struct;
 
 enum mitigation_state arm64_get_spectre_v2_state(void);
@@ -33,4 +34,5 @@ enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
 u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
+bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index faa8a6bf2376..9c0e9d9eed6e 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -537,10 +537,13 @@ bool has_spectre_v4(const struct arm64_cpu_capabilities *cap, int scope)
 	return state != SPECTRE_UNAFFECTED;
 }
 
-static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
+bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr)
 {
-	if (user_mode(regs))
-		return 1;
+	const u32 instr_mask = ~(1U << PSTATE_Imm_shift);
+	const u32 instr_val = 0xd500401f | PSTATE_SSBS;
+
+	if ((instr & instr_mask) != instr_val)
+		return false;
 
 	if (instr & BIT(PSTATE_Imm_shift))
 		regs->pstate |= PSR_SSBS_BIT;
@@ -548,19 +551,11 @@ static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)
 		regs->pstate &= ~PSR_SSBS_BIT;
 
 	arm64_skip_faulting_instruction(regs, 4);
-	return 0;
+	return true;
 }
 
-static struct undef_hook ssbs_emulation_hook = {
-	.instr_mask	= ~(1U << PSTATE_Imm_shift),
-	.instr_val	= 0xd500401f | PSTATE_SSBS,
-	.fn		= ssbs_emulation_handler,
-};
-
 static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 {
-	static bool undef_hook_registered = false;
-	static DEFINE_RAW_SPINLOCK(hook_lock);
 	enum mitigation_state state;
 
 	/*
@@ -571,13 +566,6 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 	if (state != SPECTRE_MITIGATED || !this_cpu_has_cap(ARM64_SSBS))
 		return state;
 
-	raw_spin_lock(&hook_lock);
-	if (!undef_hook_registered) {
-		register_undef_hook(&ssbs_emulation_hook);
-		undef_hook_registered = true;
-	}
-	raw_spin_unlock(&hook_lock);
-
 	if (spectre_v4_mitigations_off()) {
 		sysreg_clear_set(sctlr_el1, 0, SCTLR_ELx_DSSBS);
 		asm volatile(SET_PSTATE_SSBS(1));
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index a2dfce6493d2..15d490ef7462 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -311,12 +311,7 @@ static int call_undef_hook(struct pt_regs *regs)
 	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
 	void __user *pc = (void __user *)instruction_pointer(regs);
 
-	if (!user_mode(regs)) {
-		__le32 instr_le;
-		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
-			goto exit;
-		instr = le32_to_cpu(instr_le);
-	} else if (compat_thumb_mode(regs)) {
+	if (compat_thumb_mode(regs)) {
 		/* 16-bit Thumb instruction */
 		__le16 instr_le;
 		if (get_user(instr_le, (__le16 __user *)pc))
@@ -409,9 +404,15 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 
 void do_el1_undef(struct pt_regs *regs, unsigned long esr)
 {
-	if (call_undef_hook(regs) == 0)
+	u32 insn;
+
+	if (aarch64_insn_read((void *)regs->pc, &insn))
+		goto out_err;
+
+	if (try_emulate_el1_ssbs(regs, insn))
 		return;
 
+out_err:
 	die("Oops - Undefined instruction", regs, esr);
 }
 
-- 
2.34.1

