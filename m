Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6031177FA70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352916AbjHQPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352961AbjHQPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:12:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C0F35A9;
        Thu, 17 Aug 2023 08:11:45 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692285055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4WpvSXJBp7tslXt/lRAPmiV67xkXdU4wz4n5XJbLWk=;
        b=Q1+j9/1ovZc/aOS1Njm1tormTZiZWUmZZXhH0mwERciU4WiT2SlgZwyAMvNH1uL2K9qVo0
        Bv/gF05ru5aPMUAdJTWopnENe3Ng1fNf6zglp+Oeo5pR1Gmf47odL191o5GWQUkjafI6AL
        ai5Pkr1Lfw/n3JhyahPxOhFyt9NEDwZGT0c0tS4PH055s//k+TUT23wWY8SUrqOPJt6EVZ
        ud8hZUcazt538a+zLGUFuY7+Go24o8oZtHUpon4/bfMX/vqR3ZJgge9+0WzDkcw/OPkNDR
        OQvt3BM2z89p179jsldJ8m/DniIkJ8gWQAbEFcUXh6Ux2JRvvcKLhxThozNA/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692285055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4WpvSXJBp7tslXt/lRAPmiV67xkXdU4wz4n5XJbLWk=;
        b=ACGc2uCV/WY6lAB/Zq2uiDJ7jJ3HFzOnpBCHlRt7ab/AOLhH7jCxXbkLZq/NxRWxdL5oxl
        0Vv56fYBVTGavjCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/ibt: Convert IBT selftest to asm
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <99a7e16b97bda97bf0a04aa141d6241cd8a839a2.1680912949.git.jpoimboe@kernel.org>
References: <99a7e16b97bda97bf0a04aa141d6241cd8a839a2.1680912949.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169228505520.27769.12332470800067037980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     c6cfcbd8ca43766851a8c952e3b570727147020f
Gitweb:        https://git.kernel.org/tip/c6cfcbd8ca43766851a8c952e3b570727147020f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 07 Apr 2023 17:16:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Aug 2023 17:07:09 +02:00

x86/ibt: Convert IBT selftest to asm

The following warning is reported when frame pointers and kernel IBT are
enabled:

  vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame

The problem is that objtool interprets the indirect branch in
ibt_selftest() as a sibling call, and GCC inserts a (partial) frame
pointer prologue before it:

  0000 000000000003f550 <ibt_selftest>:
  0000    3f550:	f3 0f 1e fa          	endbr64
  0004    3f554:	e8 00 00 00 00       	call   3f559 <ibt_selftest+0x9>	3f555: R_X86_64_PLT32	__fentry__-0x4
  0009    3f559:	55                   	push   %rbp
  000a    3f55a:	48 8d 05 02 00 00 00 	lea    0x2(%rip),%rax        # 3f563 <ibt_selftest_ip>
  0011    3f561:	ff e0                	jmp    *%rax

Note the inline asm is missing ASM_CALL_CONSTRAINT, so the 'push %rbp'
happens before the indirect branch and the 'mov %rsp, %rbp' happens
afterwards.

Simplify the generated code and make it easier to understand for both
tools and humans by moving the selftest to proper asm.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/99a7e16b97bda97bf0a04aa141d6241cd8a839a2.1680912949.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/traps.h   |  3 ++-
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/cet.c          | 23 +----------------------
 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/ibt_selftest.S | 17 +++++++++++++++++
 5 files changed, 22 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/kernel/ibt_selftest.S

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 75e0dab..b1c9cea 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,7 +18,8 @@ void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
-extern bool ibt_selftest(void);
+extern int ibt_selftest(void);
+extern int ibt_selftest_noendbr(void);
 
 #ifdef CONFIG_X86_F00F_BUG
 /* For handling the FOOF bug */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6b6bf47..eca9784 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -49,6 +49,7 @@ obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
+obj-$(CONFIG_X86_KERNEL_IBT)		+= ibt_selftest.o
 obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index cc10d8b..d2c732a 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,9 +81,6 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
-/* code label defined in asm below */
-extern void ibt_selftest_ip(void);
-
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -91,7 +88,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 		return;
 	}
 
-	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
 		return;
 	}
@@ -105,24 +102,6 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 	BUG();
 }
 
-/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
-noinline bool ibt_selftest(void)
-{
-	unsigned long ret;
-
-	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
-	     ANNOTATE_RETPOLINE_SAFE
-	     "	jmp *%%rax\n\t"
-	     "ibt_selftest_ip:\n\t"
-	     UNWIND_HINT_FUNC
-	     ANNOTATE_NOENDBR
-	     "	nop\n\t"
-
-	     : "=a" (ret) : : "memory");
-
-	return !ret;
-}
-
 static int __init ibt_setup(char *str)
 {
 	if (!strcmp(str, "off"))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cf5275a..3c6426c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -610,7 +610,7 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 
 	cr4_set_bits(X86_CR4_CET);
 
-	if (kernel_ibt && !ibt_selftest()) {
+	if (kernel_ibt && ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
diff --git a/arch/x86/kernel/ibt_selftest.S b/arch/x86/kernel/ibt_selftest.S
new file mode 100644
index 0000000..c43c4ed
--- /dev/null
+++ b/arch/x86/kernel/ibt_selftest.S
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <linux/objtool.h>
+#include <asm/nospec-branch.h>
+
+SYM_CODE_START(ibt_selftest_noendbr)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	/* #CP handler sets %ax to 0 */
+	RET
+SYM_CODE_END(ibt_selftest_noendbr)
+
+SYM_FUNC_START(ibt_selftest)
+	lea ibt_selftest_noendbr(%rip), %rax
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%rax
+SYM_FUNC_END(ibt_selftest)
