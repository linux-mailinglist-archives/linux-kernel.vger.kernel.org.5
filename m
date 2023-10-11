Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6687C4FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjJKKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310319B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:07:44 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S57dZ37tbzLqWT;
        Wed, 11 Oct 2023 18:03:46 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:07:41 +0800
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
Subject: [PATCH v5.15 07/15] arm64: split EL0/EL1 UNDEF handlers
Date:   Wed, 11 Oct 2023 10:06:47 +0000
Message-ID: <20231011100655.979626-8-ruanjinjie@huawei.com>
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

commit 61d64a376ea80f9097e7ea599bcd68671b836dc6 upstream.

In general, exceptions taken from EL1 need to be handled separately from
exceptions taken from EL0, as the logic to handle the two cases can be
significantly divergent, and exceptions taken from EL1 typically have
more stringent requirements on locking and instrumentation.

Subsequent patches will rework the way EL1 UNDEFs are handled in order
to address longstanding soundness issues with instrumentation and RCU.
In preparation for that rework, this patch splits the existing
do_undefinstr() handler into separate do_el0_undef() and do_el1_undef()
handlers.

Prior to this patch, do_undefinstr() was marked with NOKPROBE_SYMBOL(),
preventing instrumentation via kprobes. However, do_undefinstr() invokes
other code which can be instrumented, and:

* For UNDEFINED exceptions taken from EL0, there is no risk of recursion
  within kprobes. Therefore it is safe for do_el0_undef to be
  instrumented with kprobes, and it does not need to be marked with
  NOKPROBE_SYMBOL().

* For UNDEFINED exceptions taken from EL1, either:

  (a) The exception is has been taken when manipulating SSBS; these cases
      are limited and do not occur within code that can be invoked
      recursively via kprobes. Hence, in these cases instrumentation
      with kprobes is benign.

  (b) The exception has been taken for an unknown reason, as other than
      manipulating SSBS we do not expect to take UNDEFINED exceptions
      from EL1. Any handling of these exception is best-effort.

  ... and in either case, marking do_el1_undef() with NOKPROBE_SYMBOL()
  isn't sufficient to prevent recursion via kprobes as functions it
  calls (including die()) are instrumentable via kprobes.

  Hence, it's not worthwhile to mark do_el1_undef() with
  NOKPROBE_SYMBOL(). The same applies to do_el1_bti() and do_el1_fpac(),
  so their NOKPROBE_SYMBOL() annotations are also removed.

Aside from the new instrumentability, there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20221019144123.612388-3-mark.rutland@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/exception.h |  3 ++-
 arch/arm64/kernel/entry-common.c   |  4 ++--
 arch/arm64/kernel/traps.c          | 22 ++++++++++++----------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 7466239adac0..515ebe24fd44 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -58,7 +58,8 @@ asmlinkage void call_on_irq_stack(struct pt_regs *regs,
 asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
 
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
-void do_undefinstr(struct pt_regs *regs, unsigned long esr);
+void do_el0_undef(struct pt_regs *regs, unsigned long esr);
+void do_el1_undef(struct pt_regs *regs, unsigned long esr);
 void do_el0_bti(struct pt_regs *regs);
 void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 31bdaccabd29..864423297c00 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -375,7 +375,7 @@ static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_undefinstr(regs, esr);
+	do_el1_undef(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -570,7 +570,7 @@ static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
 	local_daif_restore(DAIF_PROCCTX);
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 	exit_to_user_mode(regs);
 }
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 2ff0c8ddcacf..2999ccf4c117 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -486,7 +486,7 @@ void arm64_notify_segfault(unsigned long addr)
 	force_signal_inject(SIGSEGV, code, addr, 0);
 }
 
-void do_undefinstr(struct pt_regs *regs, unsigned long esr)
+void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
@@ -495,12 +495,16 @@ void do_undefinstr(struct pt_regs *regs, unsigned long esr)
 	if (call_undef_hook(regs) == 0)
 		return;
 
-	if (!user_mode(regs))
-		die("Oops - Undefined instruction", regs, esr);
-
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
-NOKPROBE_SYMBOL(do_undefinstr);
+
+void do_el1_undef(struct pt_regs *regs, unsigned long esr)
+{
+	if (call_undef_hook(regs) == 0)
+		return;
+
+	die("Oops - Undefined instruction", regs, esr);
+}
 
 void do_el0_bti(struct pt_regs *regs)
 {
@@ -511,7 +515,6 @@ void do_el1_bti(struct pt_regs *regs, unsigned long esr)
 {
 	die("Oops - BTI", regs, esr);
 }
-NOKPROBE_SYMBOL(do_el1_bti);
 
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
@@ -526,7 +529,6 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 	 */
 	die("Oops - FPAC", regs, esr);
 }
-NOKPROBE_SYMBOL(do_el1_fpac);
 
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
@@ -763,7 +765,7 @@ void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 		hook_base = cp15_64_hooks;
 		break;
 	default:
-		do_undefinstr(regs, esr);
+		do_el0_undef(regs, esr);
 		return;
 	}
 
@@ -778,7 +780,7 @@ void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 	 * EL0. Fall back to our usual undefined instruction handler
 	 * so that we handle these consistently.
 	 */
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 #endif
 
@@ -797,7 +799,7 @@ void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 	 * back to our usual undefined instruction handler so that we handle
 	 * these consistently.
 	 */
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 
 static const char *esr_class_str[] = {
-- 
2.34.1

