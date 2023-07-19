Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3B75A25C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGSWs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGSWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F72106;
        Wed, 19 Jul 2023 15:47:34 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UMk38UOgdNwFRCj2YTH55xmXrTZckAHjEl/1m6ix7VQ=;
        b=ihAugvY8Xd0Oco05CatdbMIa5JuDGxAU6Yr6Vdm/H5/JicUDsdi/OvqMxA8ZxDF72br1XP
        aI6HK5Lx66RKbjeOen6qp0Zt4urnmoSKXaIbXASJgy6mHJsxCqEPU6N7aqf8l3g7c36pC3
        G75psEypEa+brZfd8IGld+pj4TOGDrknw+9iyoXCoyzPZCbTM4e09tOF43bVjjDP1GQZY5
        qsJLepbWL7BH1KUl0KlZkqaecJkYqqzpSd45ozeayLcZyJyedk9vdn28RTf5enLCbcbiad
        kXM+ihjASG+XK6tCrzNO3FV/BrpcXQVaL+J93UaeoBvstHhyxlUK95izHtwDUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UMk38UOgdNwFRCj2YTH55xmXrTZckAHjEl/1m6ix7VQ=;
        b=C77FRNxOqtu1CDZ+HEhxWOGu76DpmuSSMEuFEGpCKjr41iF5lT39svMbdoIVi6bJlXxA7k
        uAGs5/e1EMAGXOBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Add user control-protection fault handler
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685232.28540.13812234239774487648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     15068ceb1df8df9d444d315a211d24cbcbe8890b
Gitweb:        https://git.kernel.org/tip/15068ceb1df8df9d444d315a211d24cbcbe8890b
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:53 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:50 -07:00

x86/shstk: Add user control-protection fault handler

A control-protection fault is triggered when a control-flow transfer
attempt violates Shadow Stack or Indirect Branch Tracking constraints.
For example, the return address for a RET instruction differs from the copy
on the shadow stack.

There already exists a control-protection fault handler for handling kernel
IBT faults. Refactor this fault handler into separate user and kernel
handlers, like the page fault handler. Add a control-protection handler
for usermode. To avoid ifdeffery, put them both in a new file cet.c, which
is compiled in the case of either of the two CET features supported in the
kernel: kernel IBT or user mode shadow stack. Move some static inline
functions from traps.c into a header so they can be used in cet.c.

Opportunistically fix a comment in the kernel IBT part of the fault
handler that is on the end of the line instead of preceding it.

Keep the same behavior for the kernel side of the fault handler, except for
converting a BUG to a WARN in the case of a #CP happening when the feature
is missing. This unifies the behavior with the new shadow stack code, and
also prevents the kernel from crashing under this situation which is
potentially recoverable.

The control-protection fault handler works in a similar way as the general
protection fault handler. It provides the si_code SEGV_CPERR to the signal
handler.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-28-rick.p.edgecombe%40intel.com
---
 arch/arm/kernel/signal.c                 |  2 +-
 arch/arm64/kernel/signal.c               |  2 +-
 arch/arm64/kernel/signal32.c             |  2 +-
 arch/sparc/kernel/signal32.c             |  2 +-
 arch/sparc/kernel/signal_64.c            |  2 +-
 arch/x86/include/asm/disabled-features.h |  8 +-
 arch/x86/include/asm/idtentry.h          |  2 +-
 arch/x86/include/asm/traps.h             | 12 +++-
 arch/x86/kernel/cet.c                    | 94 ++++++++++++++++++++---
 arch/x86/kernel/idt.c                    |  2 +-
 arch/x86/kernel/signal_32.c              |  2 +-
 arch/x86/kernel/signal_64.c              |  2 +-
 arch/x86/kernel/traps.c                  | 12 +---
 arch/x86/xen/enlighten_pv.c              |  2 +-
 arch/x86/xen/xen-asm.S                   |  2 +-
 include/uapi/asm-generic/siginfo.h       |  3 +-
 16 files changed, 117 insertions(+), 34 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 8d0afa1..79a6730 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -682,7 +682,7 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e304f7e..0df8cc2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1344,7 +1344,7 @@ void __init minsigstksz_setup(void)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 4700f85..bbd5427 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -460,7 +460,7 @@ void compat_setup_restart_syscall(struct pt_regs *regs)
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index ca450c7..a23cdd7 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -753,7 +753,7 @@ out:
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 570e43e..b4e4109 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -562,7 +562,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
  */
 static_assert(NSIGILL	== 11);
 static_assert(NSIGFPE	== 15);
-static_assert(NSIGSEGV	== 9);
+static_assert(NSIGSEGV	== 10);
 static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index b9c7eae..702d93f 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -111,6 +111,12 @@
 #define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+#define DISABLE_IBT	0
+#else
+#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -134,7 +140,7 @@
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
-#define DISABLED_MASK18	0
+#define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b241af4..61e0e63 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -614,7 +614,7 @@ DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_DF,	xenpv_exc_double_fault);
 #endif
 
 /* #CP */
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 DECLARE_IDTENTRY_ERRORCODE(X86_TRAP_CP,	exc_control_protection);
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 47ecfff..75e0dab 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -47,4 +47,16 @@ void __noreturn handle_stack_overflow(struct pt_regs *regs,
 				      struct stack_info *info);
 #endif
 
+static inline void cond_local_irq_enable(struct pt_regs *regs)
+{
+	if (regs->flags & X86_EFLAGS_IF)
+		local_irq_enable();
+}
+
+static inline void cond_local_irq_disable(struct pt_regs *regs)
+{
+	if (regs->flags & X86_EFLAGS_IF)
+		local_irq_disable();
+}
+
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index 7ad22b7..cc10d8b 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -4,10 +4,6 @@
 #include <asm/bugs.h>
 #include <asm/traps.h>
 
-static __ro_after_init bool ibt_fatal = true;
-
-extern void ibt_selftest_ip(void); /* code label defined in asm below */
-
 enum cp_error_code {
 	CP_EC        = (1 << 15) - 1,
 
@@ -20,15 +16,80 @@ enum cp_error_code {
 	CP_ENCL	     = 1 << 15,
 };
 
-DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+static const char cp_err[][10] = {
+	[0] = "unknown",
+	[1] = "near ret",
+	[2] = "far/iret",
+	[3] = "endbranch",
+	[4] = "rstorssp",
+	[5] = "setssbsy",
+};
+
+static const char *cp_err_string(unsigned long error_code)
+{
+	unsigned int cpec = error_code & CP_EC;
+
+	if (cpec >= ARRAY_SIZE(cp_err))
+		cpec = 0;
+	return cp_err[cpec];
+}
+
+static void do_unexpected_cp(struct pt_regs *regs, unsigned long error_code)
+{
+	WARN_ONCE(1, "Unexpected %s #CP, error_code: %s\n",
+		  user_mode(regs) ? "user mode" : "kernel mode",
+		  cp_err_string(error_code));
+}
+
+static DEFINE_RATELIMIT_STATE(cpf_rate, DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
+static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
-	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
-		pr_err("Unexpected #CP\n");
-		BUG();
+	struct task_struct *tsk;
+	unsigned long ssp;
+
+	/*
+	 * An exception was just taken from userspace. Since interrupts are disabled
+	 * here, no scheduling should have messed with the registers yet and they
+	 * will be whatever is live in userspace. So read the SSP before enabling
+	 * interrupts so locking the fpregs to do it later is not required.
+	 */
+	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+
+	cond_local_irq_enable(regs);
+
+	tsk = current;
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_CP;
+
+	/* Ratelimit to prevent log spamming. */
+	if (show_unhandled_signals && unhandled_signal(tsk, SIGSEGV) &&
+	    __ratelimit(&cpf_rate)) {
+		pr_emerg("%s[%d] control protection ip:%lx sp:%lx ssp:%lx error:%lx(%s)%s",
+			 tsk->comm, task_pid_nr(tsk),
+			 regs->ip, regs->sp, ssp, error_code,
+			 cp_err_string(error_code),
+			 error_code & CP_ENCL ? " in enclave" : "");
+		print_vma_addr(KERN_CONT " in ", regs->ip);
+		pr_cont("\n");
 	}
 
-	if (WARN_ON_ONCE(user_mode(regs) || (error_code & CP_EC) != CP_ENDBR))
+	force_sig_fault(SIGSEGV, SEGV_CPERR, (void __user *)0);
+	cond_local_irq_disable(regs);
+}
+
+static __ro_after_init bool ibt_fatal = true;
+
+/* code label defined in asm below */
+extern void ibt_selftest_ip(void);
+
+static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
+{
+	if ((error_code & CP_EC) != CP_ENDBR) {
+		do_unexpected_cp(regs, error_code);
 		return;
+	}
 
 	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
 		regs->ax = 0;
@@ -74,3 +135,18 @@ static int __init ibt_setup(char *str)
 }
 
 __setup("ibt=", ibt_setup);
+
+DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
+{
+	if (user_mode(regs)) {
+		if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+			do_user_cp_fault(regs, error_code);
+		else
+			do_unexpected_cp(regs, error_code);
+	} else {
+		if (cpu_feature_enabled(X86_FEATURE_IBT))
+			do_kernel_cp_fault(regs, error_code);
+		else
+			do_unexpected_cp(regs, error_code);
+	}
+}
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc..5074b84 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -107,7 +107,7 @@ static const __initconst struct idt_data def_idts[] = {
 	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
 #endif
 
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 	INTG(X86_TRAP_CP,		asm_exc_control_protection),
 #endif
 
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc0..c12624b 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -402,7 +402,7 @@ Efault:
 */
 static_assert(NSIGILL  == 11);
 static_assert(NSIGFPE  == 15);
-static_assert(NSIGSEGV == 9);
+static_assert(NSIGSEGV == 10);
 static_assert(NSIGBUS  == 5);
 static_assert(NSIGTRAP == 6);
 static_assert(NSIGCHLD == 6);
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 13a1e60..0e808c7 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -403,7 +403,7 @@ void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
 */
 static_assert(NSIGILL  == 11);
 static_assert(NSIGFPE  == 15);
-static_assert(NSIGSEGV == 9);
+static_assert(NSIGSEGV == 10);
 static_assert(NSIGBUS  == 5);
 static_assert(NSIGTRAP == 6);
 static_assert(NSIGCHLD == 6);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6f666df..f358350 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -77,18 +77,6 @@
 
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
-static inline void cond_local_irq_enable(struct pt_regs *regs)
-{
-	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_enable();
-}
-
-static inline void cond_local_irq_disable(struct pt_regs *regs)
-{
-	if (regs->flags & X86_EFLAGS_IF)
-		local_irq_disable();
-}
-
 __always_inline int is_valid_bugaddr(unsigned long addr)
 {
 	if (addr < TASK_SIZE_MAX)
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 93b6582..aa797b8 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -694,7 +694,7 @@ static struct trap_array_entry trap_array[] = {
 	TRAP_ENTRY(exc_coprocessor_error,		false ),
 	TRAP_ENTRY(exc_alignment_check,			false ),
 	TRAP_ENTRY(exc_simd_coprocessor_error,		false ),
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 	TRAP_ENTRY(exc_control_protection,		false ),
 #endif
 };
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 08f1ceb..9e5e680 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -148,7 +148,7 @@ xen_pv_trap asm_exc_page_fault
 xen_pv_trap asm_exc_spurious_interrupt_bug
 xen_pv_trap asm_exc_coprocessor_error
 xen_pv_trap asm_exc_alignment_check
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_CET
 xen_pv_trap asm_exc_control_protection
 #endif
 #ifdef CONFIG_X86_MCE
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index ffbe4ce..0f52d0a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -242,7 +242,8 @@ typedef struct siginfo {
 #define SEGV_ADIPERR	7	/* Precise MCD exception */
 #define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
 #define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
-#define NSIGSEGV	9
+#define SEGV_CPERR	10	/* Control protection fault */
+#define NSIGSEGV	10
 
 /*
  * SIGBUS si_codes
