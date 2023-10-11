Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7597C4FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjJKKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjJKKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:18:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2130412B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:07:47 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S57gC51XdzrTWK;
        Wed, 11 Oct 2023 18:05:11 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:07:45 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <broonie@kernel.org>,
        <anshuman.khandual@arm.com>, <alexandru.elisei@arm.com>,
        <sashal@kernel.org>, <maz@kernel.org>,
        <gregkh@linuxfoundation.org>, <james.morse@arm.com>,
        <pcc@google.com>, <scott@os.amperecomputing.com>,
        <ebiederm@xmission.com>, <haibinzhang@tencent.com>,
        <hewenliang4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.15 10/15] arm64: rework EL0 MRS emulation
Date:   Wed, 11 Oct 2023 10:06:50 +0000
Message-ID: <20231011100655.979626-11-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100655.979626-1-ruanjinjie@huawei.com>
References: <20231011100655.979626-1-ruanjinjie@huawei.com>
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

commit f5962add74b61f8ae31c6311f75ca35d7e1d2d8f upstream.

On CPUs without FEAT_IDST, ID register emulation is slower than it needs
to be, as all threads contend for the same lock to perform the
emulation. This patch reworks the emulation to avoid this unnecessary
contention.

On CPUs with FEAT_IDST (which is mandatory from ARMv8.4 onwards), EL0
accesses to ID registers result in a SYS trap, and emulation of these is
handled with a sys64_hook. These hooks are statically allocated, and no
locking is required to iterate through the hooks and perform the
emulation, allowing emulation to occur in parallel with no contention.

On CPUs without FEAT_IDST, EL0 accesses to ID registers result in an
UNDEFINED exception, and emulation of these accesses is handled with an
undef_hook. When an EL0 MRS instruction is trapped to EL1, the kernel
finds the relevant handler by iterating through all of the undef_hooks,
requiring undef_lock to be held during this lookup.

This locking is only required to safely traverse the list of undef_hooks
(as it can be concurrently modified), and the actual emulation of the
MRS does not require any mutual exclusion. This locking is an
unfortunate bottleneck, especially given that MRS emulation is enabled
unconditionally and is never disabled.

This patch reworks the non-FEAT_IDST MRS emulation logic so that it can
be invoked directly from do_el0_undef(). This removes the bottleneck,
allowing MRS traps to be handled entirely in parallel, and is a stepping
stone to making all of the undef_hooks lock-free.

I've tested this in a 64-vCPU VM on a 64-CPU ThunderX2 host, with a
benchmark which spawns a number of threads which each try to read
ID_AA64ISAR0_EL1 1000000 times. This is vastly more contention than will
ever be seen in realistic usage, but clearly demonstrates the removal of
the bottleneck:

  | Threads || Time (seconds)                       |
  |         || Before           || After            |
  |         || Real   | System  || Real   | System  |
  |---------++--------+---------++--------+---------|
  |       1 ||   0.29 |    0.20 ||   0.24 |    0.12 |
  |       2 ||   0.35 |    0.51 ||   0.23 |    0.27 |
  |       4 ||   1.08 |    3.87 ||   0.24 |    0.56 |
  |       8 ||   4.31 |   33.60 ||   0.24 |    1.11 |
  |      16 ||   9.47 |  149.39 ||   0.23 |    2.15 |
  |      32 ||  19.07 |  605.27 ||   0.24 |    4.38 |
  |      64 ||  65.40 | 3609.09 ||   0.33 |   11.27 |

Aside from the speedup, there should be no functional change as a result
of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-6-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/kernel/cpufeature.c      | 23 +++++------------------
 arch/arm64/kernel/traps.c           |  3 +++
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a77b5f49b3a6..72aaf7b92b31 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -808,7 +808,8 @@ static inline bool system_supports_tlb_range(void)
 		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
 }
 
-extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
+int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
+bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
 static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d4ee345ff429..f17d6cdea260 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3106,35 +3106,22 @@ int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt)
 	return rc;
 }
 
-static int emulate_mrs(struct pt_regs *regs, u32 insn)
+bool try_emulate_mrs(struct pt_regs *regs, u32 insn)
 {
 	u32 sys_reg, rt;
 
+	if (compat_user_mode(regs) || !aarch64_insn_is_mrs(insn))
+		return false;
+
 	/*
 	 * sys_reg values are defined as used in mrs/msr instruction.
 	 * shift the imm value to get the encoding.
 	 */
 	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
 	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
-	return do_emulate_mrs(regs, sys_reg, rt);
+	return do_emulate_mrs(regs, sys_reg, rt) == 0;
 }
 
-static struct undef_hook mrs_hook = {
-	.instr_mask = 0xffff0000,
-	.instr_val  = 0xd5380000,
-	.pstate_mask = PSR_AA32_MODE_MASK,
-	.pstate_val = PSR_MODE_EL0t,
-	.fn = emulate_mrs,
-};
-
-static int __init enable_mrs_emulation(void)
-{
-	register_undef_hook(&mrs_hook);
-	return 0;
-}
-
-core_initcall(enable_mrs_emulation);
-
 enum mitigation_state arm64_get_meltdown_state(void)
 {
 	if (__meltdown_safe)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index e943b7c46d86..1f9285a35560 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -499,6 +499,9 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 	if (user_insn_read(regs, &insn))
 		goto out_err;
 
+	if (try_emulate_mrs(regs, insn))
+		return;
+
 	if (call_undef_hook(regs, insn) == 0)
 		return;
 
-- 
2.34.1

