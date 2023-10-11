Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC577C4BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbjJKH22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345123AbjJKH2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:28:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA48DC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:28:02 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S546t1tFjzrTVs;
        Wed, 11 Oct 2023 15:25:26 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 15:27:59 +0800
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
Subject: [PATCH v5.10 07/15] arm64: split EL0/EL1 UNDEF handlers
Date:   Wed, 11 Oct 2023 07:26:53 +0000
Message-ID: <20231011072701.876772-8-ruanjinjie@huawei.com>
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
---
 arch/arm64/include/asm/exception.h |  3 ++-
 arch/arm64/kernel/entry-common.c   |  4 ++--
 arch/arm64/kernel/traps.c          | 22 ++++++++++++----------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index a31584c63a6c..cc5b2203d876 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -33,7 +33,8 @@ asmlinkage void exit_to_user_mode(void);
 void arm64_enter_nmi(struct pt_regs *regs);
 void arm64_exit_nmi(struct pt_regs *regs);
 void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
-void do_undefinstr(struct pt_regs *regs, unsigned long esr);
+void do_el0_undef(struct pt_regs *regs, unsigned long esr);
+void do_el1_undef(struct pt_regs *regs, unsigned long esr);
 void do_el0_bti(struct pt_regs *regs);
 void do_el1_bti(struct pt_regs *regs, unsigned long esr);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 397c55468ed8..7a8cd856ee85 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -136,7 +136,7 @@ static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_undefinstr(regs, esr);
+	do_el1_undef(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -332,7 +332,7 @@ static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 
 static void noinstr el0_bti(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cc57ffe0503a..a2dfce6493d2 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -395,7 +395,7 @@ void arm64_notify_segfault(unsigned long addr)
 	force_signal_inject(SIGSEGV, code, addr, 0);
 }
 
-void do_undefinstr(struct pt_regs *regs, unsigned long esr)
+void do_el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
@@ -404,12 +404,16 @@ void do_undefinstr(struct pt_regs *regs, unsigned long esr)
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
@@ -420,7 +424,6 @@ void do_el1_bti(struct pt_regs *regs, unsigned long esr)
 {
 	die("Oops - BTI", regs, esr);
 }
-NOKPROBE_SYMBOL(do_el1_bti);
 
 void do_el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
@@ -435,7 +438,6 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
 	 */
 	die("Oops - FPAC", regs, esr);
 }
-NOKPROBE_SYMBOL(do_el1_fpac);
 
 #define __user_cache_maint(insn, address, res)			\
 	if (address >= user_addr_max()) {			\
@@ -671,7 +673,7 @@ void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 		hook_base = cp15_64_hooks;
 		break;
 	default:
-		do_undefinstr(regs, esr);
+		do_el0_undef(regs, esr);
 		return;
 	}
 
@@ -686,7 +688,7 @@ void do_el0_cp15(unsigned long esr, struct pt_regs *regs)
 	 * EL0. Fall back to our usual undefined instruction handler
 	 * so that we handle these consistently.
 	 */
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 #endif
 
@@ -705,7 +707,7 @@ void do_el0_sys(unsigned long esr, struct pt_regs *regs)
 	 * back to our usual undefined instruction handler so that we handle
 	 * these consistently.
 	 */
-	do_undefinstr(regs, esr);
+	do_el0_undef(regs, esr);
 }
 
 static const char *esr_class_str[] = {
-- 
2.34.1

