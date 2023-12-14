Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463BD812EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444057AbjLNLhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444016AbjLNLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:36:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A519E;
        Thu, 14 Dec 2023 03:36:51 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:36:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702553810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zs8gKTAbaLj6Ugbppwcmr7EJztUM6IrhnlHBemGHW7Y=;
        b=pWYmJd5lfkY/cET3wcTYGdmzWjLpcKfLasuGpN8iBLyrM4cgygeNmvESQSYsCMyB/QJT++
        seS0M+ArcQpO+J2pHwSapXr3m6Y8yAwAAKq20H3McjA5nc/f50pSaxBjwIz3dOVrpoGR5d
        dmTuJMGnL6HpJ2KkJfYBPJQSo+vSY3Z0/XtSBbXP7RfCAe/jREhjL9nzdXPWxH3YJGxiXi
        g/2lVQOclyYdsG5omYp+hu3cLqt7MAB0ixJ4IOXeRbjGe4DKG2y7mrCBDTchAYYJPzsTPM
        t4dF1RaJ1tZ5Mj805UywgWWSItBprE+INzwv/3zvWX5+XHMP7Xf1H0LQ4w1pNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702553810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zs8gKTAbaLj6Ugbppwcmr7EJztUM6IrhnlHBemGHW7Y=;
        b=7KaPOmzQPvs9z5Ebb8RiMTLXa2SgFijKXTWWNkTdMyIBXIodhhmDiECPQ9itVtsGZ6dLXt
        QWHEMfC6oKqXfJBg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Move some functions and defines to
 alternative.c
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129133332.31043-3-jgross@suse.com>
References: <20231129133332.31043-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <170255380982.398.7785469441002504669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     9824b00c2b58f9e1072ef3ece571a2cfc71089d4
Gitweb:        https://git.kernel.org/tip/9824b00c2b58f9e1072ef3ece571a2cfc71089d4
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 29 Nov 2023 14:33:29 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 10 Dec 2023 20:30:31 +01:00

x86/paravirt: Move some functions and defines to alternative.c

As a preparation for replacing paravirt patching completely by
alternative patching, move some backend functions and #defines to
the alternatives code and header.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231129133332.31043-3-jgross@suse.com
---
 arch/x86/include/asm/alternative.h        | 16 ++++++++++++-
 arch/x86/include/asm/paravirt.h           | 12 +---------
 arch/x86/include/asm/paravirt_types.h     |  4 +---
 arch/x86/include/asm/qspinlock_paravirt.h |  4 +--
 arch/x86/kernel/alternative.c             | 10 +++++++-
 arch/x86/kernel/kvm.c                     |  4 +--
 arch/x86/kernel/paravirt.c                | 30 ++++++----------------
 arch/x86/xen/irq.c                        |  2 +-
 8 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 65f7909..ce788ab 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -330,6 +330,22 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
 
+/* Macro for creating assembler functions avoiding any C magic. */
+#define DEFINE_ASM_FUNC(func, instr, sec)		\
+	asm (".pushsection " #sec ", \"ax\"\n"		\
+	     ".global " #func "\n\t"			\
+	     ".type " #func ", @function\n\t"		\
+	     ASM_FUNC_ALIGN "\n"			\
+	     #func ":\n\t"				\
+	     ASM_ENDBR					\
+	     instr "\n\t"				\
+	     ASM_RET					\
+	     ".size " #func ", . - " #func "\n\t"	\
+	     ".popsection")
+
+void BUG_func(void);
+void nop_func(void);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index aa76ac7..f18bfa7 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -720,18 +720,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #undef PVOP_VCALL4
 #undef PVOP_CALL4
 
-#define DEFINE_PARAVIRT_ASM(func, instr, sec)		\
-	asm (".pushsection " #sec ", \"ax\"\n"		\
-	     ".global " #func "\n\t"			\
-	     ".type " #func ", @function\n\t"		\
-	     ASM_FUNC_ALIGN "\n"			\
-	     #func ":\n\t"				\
-	     ASM_ENDBR					\
-	     instr "\n\t"				\
-	     ASM_RET					\
-	     ".size " #func ", . - " #func "\n\t"	\
-	     ".popsection")
-
 extern void default_banner(void);
 void native_pv_lock_init(void) __init;
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 483e19e..166e961 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -540,8 +540,6 @@ int paravirt_disable_iospace(void);
 	__PVOP_VCALL(op, PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 
-void _paravirt_nop(void);
-void paravirt_BUG(void);
 unsigned long paravirt_ret0(void);
 #ifdef CONFIG_PARAVIRT_XXL
 u64 _paravirt_ident_64(u64);
@@ -551,7 +549,7 @@ void pv_native_irq_enable(void);
 unsigned long pv_native_read_cr2(void);
 #endif
 
-#define paravirt_nop	((void *)_paravirt_nop)
+#define paravirt_nop	((void *)nop_func)
 
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 85b6e36..ef9697f 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -56,8 +56,8 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 	"pop    %rdx\n\t"						\
 	FRAME_END
 
-DEFINE_PARAVIRT_ASM(__raw_callee_save___pv_queued_spin_unlock,
-		    PV_UNLOCK_ASM, .spinlock.text);
+DEFINE_ASM_FUNC(__raw_callee_save___pv_queued_spin_unlock,
+		PV_UNLOCK_ASM, .spinlock.text);
 
 #else /* CONFIG_64BIT */
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index be35c8c..ca25dd2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -385,6 +385,16 @@ apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
 	}
 }
 
+/* Low-level backend functions usable from alternative code replacements. */
+DEFINE_ASM_FUNC(nop_func, "", .entry.text);
+EXPORT_SYMBOL_GPL(nop_func);
+
+noinstr void BUG_func(void)
+{
+	BUG();
+}
+EXPORT_SYMBOL_GPL(BUG_func);
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 0ddb3bd..c461c1a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -803,8 +803,8 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
  "setne  %al\n\t"
 
-DEFINE_PARAVIRT_ASM(__raw_callee_save___kvm_vcpu_is_preempted,
-		    PV_VCPU_PREEMPTED_ASM, .text);
+DEFINE_ASM_FUNC(__raw_callee_save___kvm_vcpu_is_preempted,
+		PV_VCPU_PREEMPTED_ASM, .text);
 #endif
 
 static void __init kvm_guest_init(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 97f1436..acc5b10 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -34,14 +34,8 @@
 #include <asm/io_bitmap.h>
 #include <asm/gsseg.h>
 
-/*
- * nop stub, which must not clobber anything *including the stack* to
- * avoid confusing the entry prologues.
- */
-DEFINE_PARAVIRT_ASM(_paravirt_nop, "", .entry.text);
-
 /* stub always returning 0. */
-DEFINE_PARAVIRT_ASM(paravirt_ret0, "xor %eax,%eax", .entry.text);
+DEFINE_ASM_FUNC(paravirt_ret0, "xor %eax,%eax", .entry.text);
 
 void __init default_banner(void)
 {
@@ -49,12 +43,6 @@ void __init default_banner(void)
 	       pv_info.name);
 }
 
-/* Undefined instruction for dealing with missing ops pointers. */
-noinstr void paravirt_BUG(void)
-{
-	BUG();
-}
-
 static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 				    unsigned long addr, unsigned len)
 {
@@ -64,11 +52,11 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-DEFINE_PARAVIRT_ASM(_paravirt_ident_64, "mov %rdi, %rax", .text);
-DEFINE_PARAVIRT_ASM(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
-DEFINE_PARAVIRT_ASM(pv_native_irq_disable, "cli", .noinstr.text);
-DEFINE_PARAVIRT_ASM(pv_native_irq_enable, "sti", .noinstr.text);
-DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
+DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
+DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_irq_disable, "cli", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
+DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
@@ -96,9 +84,9 @@ unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
 	unsigned ret;
 
 	if (opfunc == NULL)
-		/* If there's no function, patch it with paravirt_BUG() */
-		ret = paravirt_patch_call(insn_buff, paravirt_BUG, addr, len);
-	else if (opfunc == _paravirt_nop)
+		/* If there's no function, patch it with BUG_func() */
+		ret = paravirt_patch_call(insn_buff, BUG_func, addr, len);
+	else if (opfunc == nop_func)
 		ret = 0;
 	else
 		/* Otherwise call the function. */
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 6092fea..39982f9 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -45,7 +45,7 @@ static const typeof(pv_ops) xen_irq_ops __initconst = {
 		/* Initial interrupt flag handling only called while interrupts off. */
 		.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0),
 		.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop),
-		.irq_enable = __PV_IS_CALLEE_SAVE(paravirt_BUG),
+		.irq_enable = __PV_IS_CALLEE_SAVE(BUG_func),
 
 		.safe_halt = xen_safe_halt,
 		.halt = xen_halt,
