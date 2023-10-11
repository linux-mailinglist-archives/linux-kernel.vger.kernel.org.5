Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920757C4FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjJKKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjJKKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC019AC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:07:41 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S57g55RL4z1M9LQ;
        Wed, 11 Oct 2023 18:05:05 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:07:38 +0800
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
Subject: [PATCH v5.15 04/15] arm64: rework FPAC exception handling
Date:   Wed, 11 Oct 2023 10:06:44 +0000
Message-ID: <20231011100655.979626-5-ruanjinjie@huawei.com>
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

commit a1fafa3b24a70461bbf3e5c0770893feb0a49292 upstream.

If an FPAC exception is taken from EL1, the entry code will call
do_ptrauth_fault(), where due to:

	BUG_ON(!user_mode(regs))

... the kernel will report a problem within do_ptrauth_fault() rather
than reporting the original context the FPAC exception was taken from.
The pt_regs and ESR value reported will be from within
do_ptrauth_fault() and the code dump will be for the BRK in BUG_ON(),
which isn't sufficient to debug the cause of the original exception.

This patch makes the reporting better by having separate EL0 and EL1
FPAC exception handlers, with the latter calling die() directly to
report the original context the FPAC exception was taken from.

Note that we only need to prevent kprobes of the EL1 FPAC handler, since
the EL0 FPAC handler cannot be called recursively.

For consistency with do_el0_svc*(), I've named the split functions
do_el{0,1}_fpac() rather than do_el{0,1}_ptrauth_fault(). I've also
clarified the comment to not imply there are casues other than FPAC
exceptions.

Prior to this patch FPAC exceptions are reported as:

| kernel BUG at arch/arm64/kernel/traps.c:517!
| Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00130-g9c8a180a1cdf-dirty #12
| Hardware name: FVP Base RevC (DT)
| pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : do_ptrauth_fault+0x3c/0x40
| lr : el1_fpac+0x34/0x54
| sp : ffff80000a3bbc80
| x29: ffff80000a3bbc80 x28: ffff0008001d8000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: 0000000020400009 x22: ffff800008f70fa4 x21: ffff80000a3bbe00
| x20: 0000000072000000 x19: ffff80000a3bbcb0 x18: fffffbfffda37000
| x17: 3120676e696d7573 x16: 7361202c6e6f6974 x15: 0000000081a90000
| x14: 0040000000000041 x13: 0040000000000001 x12: ffff000001a90000
| x11: fffffbfffda37480 x10: 0068000000000703 x9 : 0001000080000000
| x8 : 0000000000090000 x7 : 0068000000000f03 x6 : 0060000000000783
| x5 : ffff80000a3bbcb0 x4 : ffff0008001d8000 x3 : 0000000072000000
| x2 : 0000000000000000 x1 : 0000000020400009 x0 : ffff80000a3bbcb0
| Call trace:
|  do_ptrauth_fault+0x3c/0x40
|  el1h_64_sync_handler+0xc4/0xd0
|  el1h_64_sync+0x64/0x68
|  test_pac+0x8/0x10
|  smp_init+0x7c/0x8c
|  kernel_init_freeable+0x128/0x28c
|  kernel_init+0x28/0x13c
|  ret_from_fork+0x10/0x20
| Code: 97fffe5e a8c17bfd d50323bf d65f03c0 (d4210000)

With this patch applied FPAC exceptions are reported as:

| Internal error: Oops - FPAC: 0000000072000000 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00132-g78846e1c4757-dirty #11
| Hardware name: FVP Base RevC (DT)
| pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : test_pac+0x8/0x10
| lr : 0x0
| sp : ffff80000a3bbe00
| x29: ffff80000a3bbe00 x28: 0000000000000000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: ffff80000a2c8000 x22: 0000000000000000 x21: 0000000000000000
| x20: ffff8000099fa5b0 x19: ffff80000a007000 x18: fffffbfffda37000
| x17: 3120676e696d7573 x16: 7361202c6e6f6974 x15: 0000000081a90000
| x14: 0040000000000041 x13: 0040000000000001 x12: ffff000001a90000
| x11: fffffbfffda37480 x10: 0068000000000703 x9 : 0001000080000000
| x8 : 0000000000090000 x7 : 0068000000000f03 x6 : 0060000000000783
| x5 : ffff80000a2c6000 x4 : ffff0008001d8000 x3 : ffff800009f88378
| x2 : 0000000000000000 x1 : 0000000080210000 x0 : ffff000001a90000
| Call trace:
|  test_pac+0x8/0x10
|  smp_init+0x7c/0x8c
|  kernel_init_freeable+0x128/0x28c
|  kernel_init+0x28/0x13c
|  ret_from_fork+0x10/0x20
| Code: d50323bf d65f03c0 d503233f aa1f03fe (d50323bf)

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20220913101732.3925290-5-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/exception.h |  3 ++-
 arch/arm64/kernel/entry-common.c   |  4 ++--
 arch/arm64/kernel/traps.c          | 16 ++++++++++------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index babbe2db8010..79385ae73f8d 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -71,7 +71,8 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr);
 void do_cp15instr(unsigned long esr, struct pt_regs *regs);
 void do_el0_svc(struct pt_regs *regs);
 void do_el0_svc_compat(struct pt_regs *regs);
-void do_ptrauth_fault(struct pt_regs *regs, unsigned long esr);
+void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
+void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
 void do_serror(struct pt_regs *regs, unsigned long esr);
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 4dbdadc5daa1..a4fd4de22c15 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -394,7 +394,7 @@ static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_ptrauth_fault(regs, esr);
+	do_el1_fpac(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -601,7 +601,7 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_ptrauth_fault(regs, esr);
+	do_el0_fpac(regs, esr);
 	exit_to_user_mode(regs);
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 591eb1a44d30..6bdbeba76fd4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -509,16 +509,20 @@ void do_bti(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_bti);
 
-void do_ptrauth_fault(struct pt_regs *regs, unsigned long esr)
+void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
+{
+	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
+}
+
+void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	/*
-	 * Unexpected FPAC exception or pointer authentication failure in
-	 * the kernel: kill the task before it does any more harm.
+	 * Unexpected FPAC exception in the kernel: kill the task before it
+	 * does any more harm.
 	 */
-	BUG_ON(!user_mode(regs));
-	force_signal_inject(SIGILL, ILL_ILLOPN, regs->pc, esr);
+	die("Oops - FPAC", regs, esr);
 }
-NOKPROBE_SYMBOL(do_ptrauth_fault);
+NOKPROBE_SYMBOL(do_el1_fpac);
 
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
-- 
2.34.1

