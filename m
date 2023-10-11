Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96E7C4BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbjJKH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbjJKH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:28:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC6B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:28:00 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S546r0RmzzrTVw;
        Wed, 11 Oct 2023 15:25:24 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:27:57 +0800
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
Subject: [PATCH v5.10 05/15] arm64: rework BTI exception handling
Date:   Wed, 11 Oct 2023 07:26:51 +0000
Message-ID: <20231011072701.876772-6-ruanjinjie@huawei.com>
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

If a BTI exception is taken from EL1, the entry code will treat this as
an unhandled exception and will panic() the kernel. This is inconsistent
with the way we handle FPAC exceptions, which have a dedicated handler
and only necessarily kill the thread from which the exception was taken
from, and we don't log all the information that could be relevant to
debug the issue.

The code in do_bti() has:

	BUG_ON(!user_mode(regs));

... and it seems like the intent was to call this for EL1 BTI
exceptions, as with FPAC, but this was omitted due to an oversight.

This patch adds separate EL0 and EL1 BTI exception handlers, with the
latter calling die() directly to report the original context the BTI
exception was taken from. This matches our handling of FPAC exceptions.

Prior to this patch, a BTI failure is reported as:

| Unhandled 64-bit el1h sync exception on CPU0, ESR 0x0000000034000002 -- BTI
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00131-g7d937ff0221d-dirty #9
| Hardware name: linux,dummy-virt (DT)
| pstate: 20400809 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
| pc : test_bti_callee+0x4/0x10
| lr : test_bti_caller+0x1c/0x28
| sp : ffff80000800bdf0
| x29: ffff80000800bdf0 x28: 0000000000000000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: ffff80000a2b8000 x22: 0000000000000000 x21: 0000000000000000
| x20: ffff8000099fa5b0 x19: ffff800009ff7000 x18: fffffbfffda37000
| x17: 3120676e696d7573 x16: 7361202c6e6f6974 x15: 0000000041a90000
| x14: 0040000000000041 x13: 0040000000000001 x12: ffff000001a90000
| x11: fffffbfffda37480 x10: 0068000000000703 x9 : 0001000040000000
| x8 : 0000000000090000 x7 : 0068000000000f03 x6 : 0060000000000f83
| x5 : ffff80000a2b6000 x4 : ffff0000028d0000 x3 : ffff800009f78378
| x2 : 0000000000000000 x1 : 0000000040210000 x0 : ffff8000080257e4
| Kernel panic - not syncing: Unhandled exception
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00131-g7d937ff0221d-dirty #9
| Hardware name: linux,dummy-virt (DT)
| Call trace:
|  dump_backtrace.part.0+0xcc/0xe0
|  show_stack+0x18/0x5c
|  dump_stack_lvl+0x64/0x80
|  dump_stack+0x18/0x34
|  panic+0x170/0x360
|  arm64_exit_nmi.isra.0+0x0/0x80
|  el1h_64_sync_handler+0x64/0xd0
|  el1h_64_sync+0x64/0x68
|  test_bti_callee+0x4/0x10
|  smp_cpus_done+0xb0/0xbc
|  smp_init+0x7c/0x8c
|  kernel_init_freeable+0x128/0x28c
|  kernel_init+0x28/0x13c
|  ret_from_fork+0x10/0x20

With this patch applied, a BTI failure is reported as:

| Internal error: Oops - BTI: 0000000034000002 [#1] PREEMPT SMP
| Modules linked in:
| CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc3-00132-g0ad98265d582-dirty #8
| Hardware name: linux,dummy-virt (DT)
| pstate: 20400809 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
| pc : test_bti_callee+0x4/0x10
| lr : test_bti_caller+0x1c/0x28
| sp : ffff80000800bdf0
| x29: ffff80000800bdf0 x28: 0000000000000000 x27: 0000000000000000
| x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
| x23: ffff80000a2b8000 x22: 0000000000000000 x21: 0000000000000000
| x20: ffff8000099fa5b0 x19: ffff800009ff7000 x18: fffffbfffda37000
| x17: 3120676e696d7573 x16: 7361202c6e6f6974 x15: 0000000041a90000
| x14: 0040000000000041 x13: 0040000000000001 x12: ffff000001a90000
| x11: fffffbfffda37480 x10: 0068000000000703 x9 : 0001000040000000
| x8 : 0000000000090000 x7 : 0068000000000f03 x6 : 0060000000000f83
| x5 : ffff80000a2b6000 x4 : ffff0000028d0000 x3 : ffff800009f78378
| x2 : 0000000000000000 x1 : 0000000040210000 x0 : ffff800008025804
| Call trace:
|  test_bti_callee+0x4/0x10
|  smp_cpus_done+0xb0/0xbc
|  smp_init+0x7c/0x8c
|  kernel_init_freeable+0x128/0x28c
|  kernel_init+0x28/0x13c
|  ret_from_fork+0x10/0x20
| Code: d50323bf d53cd040 d65f03c0 d503233f (d50323bf)

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20220913101732.3925290-6-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/exception.h |  3 ++-
 arch/arm64/kernel/entry-common.c   | 14 +++++++++++++-
 arch/arm64/kernel/traps.c          | 10 +++++++---
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 6c869d1f51cc..3ed01b913f81 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -34,7 +34,8 @@ void arm64_enter_nmi(struct pt_regs *regs);
 void arm64_exit_nmi(struct pt_regs *regs);
 void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 void do_undefinstr(struct pt_regs *regs, unsigned long esr);
-void do_bti(struct pt_regs *regs);
+void do_el0_bti(struct pt_regs *regs);
+void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
 			struct pt_regs *regs);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b17f848a09c5..53e596aae4e8 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -141,6 +141,15 @@ static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 	exit_to_kernel_mode(regs);
 }
 
+static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	enter_from_kernel_mode(regs);
+	local_daif_inherit(regs);
+	do_el1_bti(regs, esr);
+	local_daif_mask();
+	exit_to_kernel_mode(regs);
+}
+
 static void noinstr el1_inv(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
@@ -212,6 +221,9 @@ asmlinkage void noinstr el1_sync_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_UNKNOWN:
 		el1_undef(regs, esr);
 		break;
+	case ESR_ELx_EC_BTI:
+		el1_bti(regs, esr);
+		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
 	case ESR_ELx_EC_WATCHPT_CUR:
@@ -327,7 +339,7 @@ static void noinstr el0_bti(struct pt_regs *regs)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_bti(regs);
+	do_el0_bti(regs);
 }
 
 static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5d29ba0d85c1..da13cfeee706 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -411,12 +411,16 @@ void do_undefinstr(struct pt_regs *regs, unsigned long esr)
 }
 NOKPROBE_SYMBOL(do_undefinstr);
 
-void do_bti(struct pt_regs *regs)
+void do_el0_bti(struct pt_regs *regs)
 {
-	BUG_ON(!user_mode(regs));
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_bti);
+
+void do_el1_bti(struct pt_regs *regs, unsigned long esr)
+{
+	die("Oops - BTI", regs, esr);
+}
+NOKPROBE_SYMBOL(do_el1_bti);
 
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
-- 
2.34.1

