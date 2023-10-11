Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F017C4F96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJKKG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJKKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1992BD3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:30 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S57c64hmlzkXyt;
        Wed, 11 Oct 2023 18:02:30 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 18:06:27 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <yuzenghui@huawei.com>, <anshuman.khandual@arm.com>,
        <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <youngmin.nam@samsung.com>,
        <ardb@kernel.org>, <f.fainelli@gmail.com>, <james.morse@arm.com>,
        <sashal@kernel.org>, <scott@os.amperecomputing.com>,
        <ebiederm@xmission.com>, <haibinzhang@tencent.com>,
        <hewenliang4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 RESEND 03/15] arm64: consistently pass ESR_ELx to die()
Date:   Wed, 11 Oct 2023 10:05:33 +0000
Message-ID: <20231011100545.979577-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011100545.979577-1-ruanjinjie@huawei.com>
References: <20231011100545.979577-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

commit 0f2cb928a1547ae8f89e80a4b8df2c6c02ae5f96 upstream.

Currently, bug_handler() and kasan_handler() call die() with '0' as the
'err' value, whereas die_kernel_fault() passes the ESR_ELx value.

For consistency, this patch ensures we always pass the ESR_ELx value to
die(). As this is only called for exceptions taken from kernel mode,
there should be no user-visible change as a result of this patch.

For UNDEFINED exceptions, I've had to modify do_undefinstr() and its
callers to pass the ESR_ELx value. In all cases the ESR_ELx value had
already been read and was available.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220913101732.3925290-4-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/exception.h |  2 +-
 arch/arm64/kernel/entry-common.c   | 14 +++++++-------
 arch/arm64/kernel/traps.c          | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 59c3facb8a56..18f7a095b91e 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -33,7 +33,7 @@ asmlinkage void exit_to_user_mode(void);
 void arm64_enter_nmi(struct pt_regs *regs);
 void arm64_exit_nmi(struct pt_regs *regs);
 void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs);
-void do_undefinstr(struct pt_regs *regs);
+void do_undefinstr(struct pt_regs *regs, unsigned long esr);
 void do_bti(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr);
 void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int esr,
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ec120ed18faf..c1d6720ae397 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -132,11 +132,11 @@ static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
 	exit_to_kernel_mode(regs);
 }
 
-static void noinstr el1_undef(struct pt_regs *regs)
+static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
 	local_daif_inherit(regs);
-	do_undefinstr(regs);
+	do_undefinstr(regs, esr);
 	local_daif_mask();
 	exit_to_kernel_mode(regs);
 }
@@ -210,7 +210,7 @@ asmlinkage void noinstr el1_sync_handler(struct pt_regs *regs)
 		break;
 	case ESR_ELx_EC_SYS64:
 	case ESR_ELx_EC_UNKNOWN:
-		el1_undef(regs);
+		el1_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_BREAKPT_CUR:
 	case ESR_ELx_EC_SOFTSTP_CUR:
@@ -316,11 +316,11 @@ static void noinstr el0_sp(struct pt_regs *regs, unsigned long esr)
 	do_sp_pc_abort(regs->sp, esr, regs);
 }
 
-static void noinstr el0_undef(struct pt_regs *regs)
+static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode();
 	local_daif_restore(DAIF_PROCCTX);
-	do_undefinstr(regs);
+	do_undefinstr(regs, esr);
 }
 
 static void noinstr el0_bti(struct pt_regs *regs)
@@ -394,7 +394,7 @@ asmlinkage void noinstr el0_sync_handler(struct pt_regs *regs)
 		el0_pc(regs, esr);
 		break;
 	case ESR_ELx_EC_UNKNOWN:
-		el0_undef(regs);
+		el0_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_BTI:
 		el0_bti(regs);
@@ -454,7 +454,7 @@ asmlinkage void noinstr el0_sync_compat_handler(struct pt_regs *regs)
 	case ESR_ELx_EC_CP14_MR:
 	case ESR_ELx_EC_CP14_LS:
 	case ESR_ELx_EC_CP14_64:
-		el0_undef(regs);
+		el0_undef(regs, esr);
 		break;
 	case ESR_ELx_EC_CP15_32:
 	case ESR_ELx_EC_CP15_64:
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 3a88bb1202ad..2060ba0ee6b4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -395,7 +395,7 @@ void arm64_notify_segfault(unsigned long addr)
 	force_signal_inject(SIGSEGV, code, addr, 0);
 }
 
-void do_undefinstr(struct pt_regs *regs)
+void do_undefinstr(struct pt_regs *regs, unsigned long esr)
 {
 	/* check for AArch32 breakpoint instructions */
 	if (!aarch32_break_handler(regs))
@@ -405,7 +405,7 @@ void do_undefinstr(struct pt_regs *regs)
 		return;
 
 	if (!user_mode(regs))
-		die("Oops - Undefined instruction", regs, 0);
+		die("Oops - Undefined instruction", regs, esr);
 
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
 }
@@ -663,7 +663,7 @@ void do_cp15instr(unsigned int esr, struct pt_regs *regs)
 		hook_base = cp15_64_hooks;
 		break;
 	default:
-		do_undefinstr(regs);
+		do_undefinstr(regs, esr);
 		return;
 	}
 
@@ -678,7 +678,7 @@ void do_cp15instr(unsigned int esr, struct pt_regs *regs)
 	 * EL0. Fall back to our usual undefined instruction handler
 	 * so that we handle these consistently.
 	 */
-	do_undefinstr(regs);
+	do_undefinstr(regs, esr);
 }
 NOKPROBE_SYMBOL(do_cp15instr);
 #endif
@@ -698,7 +698,7 @@ void do_sysinstr(unsigned int esr, struct pt_regs *regs)
 	 * back to our usual undefined instruction handler so that we handle
 	 * these consistently.
 	 */
-	do_undefinstr(regs);
+	do_undefinstr(regs, esr);
 }
 NOKPROBE_SYMBOL(do_sysinstr);
 
@@ -901,7 +901,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 {
 	switch (report_bug(regs->pc, regs)) {
 	case BUG_TRAP_TYPE_BUG:
-		die("Oops - BUG", regs, 0);
+		die("Oops - BUG", regs, esr);
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
@@ -969,7 +969,7 @@ static int kasan_handler(struct pt_regs *regs, unsigned int esr)
 	 * This is something that might be fixed at some point in the future.
 	 */
 	if (!recover)
-		die("Oops - KASAN", regs, 0);
+		die("Oops - KASAN", regs, esr);
 
 	/* If thread survives, skip over the brk instruction and continue: */
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
-- 
2.34.1

