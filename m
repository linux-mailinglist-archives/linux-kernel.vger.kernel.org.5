Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB8276FBEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjHDI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjHDI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:26:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C449C9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691137566; x=1722673566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q4YNu7fWoBQ4f21T/mVB+om7AomaDQ0aezAlCW+9t4o=;
  b=aZFzWzP4LOc4WRF+uEFKZiILFGMan0yZpNoPM+FGAd6YtdevcvDOPq/P
   nQrozn5tyb2GNJtDsuXntJAOFbmtRjmTHhF+NXYExFV1cXfGkKpeKpZm9
   rb/4Z9yyKPeGQ/LddglKplP0IOXXhDPHVbRcK5NEEvWC6vlFcubks26MA
   ehU1uJOvxzvxsCxaCnT1L0A1ma360DTKLjQkxB/djXsI6N8QnNcj9+GV4
   MJJkMyNeKwS5BJPqC16BG7KXVz1TTVfDcFdB+a0THOWvoNAM7Qny1gJyG
   Mrp6or53pHI8x8dTAgtr/iZOlBQiXWd1ag2EjiWnfGb7f/CkzDLg1+Phi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367561998"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="367561998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:26:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679843568"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="679843568"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2023 01:26:04 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second argument error code
Date:   Fri,  4 Aug 2023 00:57:34 -0700
Message-Id: <20230804075734.8372-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IDT event delivery of X86_TRAP_DF, X86_TRAP_TS, X86_TRAP_NP,
X86_TRAP_SS, X86_TRAP_GP, X86_TRAP_AC and X86_TRAP_CP pushes an error
code into the orig_ax member of the pt_regs structure, and the error
code is passed as the second argument of their C-handlers, although
the pt_regs structure is already passed as the first argument.

The asm entry code of such faults does the following

  movq ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
  movq $-1, ORIG_RAX(%rsp)	/* no syscall to restart */

to set the orig_ax member to -1 just before calling the C-handler.

In addition, the IRQ entry code uses the second error code argument
as its IRQ vector, as the IRQ asm entry code pushes its IRQ vector
into the orig_ax member.

The commit d99015b1abbad ("x86: move entry_64.S register saving out of
the macros") introduced the changes to set orig_ax to -1, but I can't
see why it's required. Our tests on x86_64 and x86_32 seem fine if
orig_ax is left unchanged instead of set to -1.

It's probably cleaner and simpler to remove the second argument from
such C-handlers while leave orig_ax unchanged to pass the error code
inside the first argument. This patch allows FRED to use IDT exception
and IRQ handlers with no or minimal changes.

The DECLARE_IDTENTRY_*_ERRORCODE macros still need to be kept to emit
the ASM stubs, which do NOT need to push -1 as an error code placement.
As a result, their corresponding DEFINE_IDTENTRY_*_ERRORCODE macros
are kept, although they simply mapped to their no _ERRORCODE suffix
versions.

I haven't checked Xen implications with this change, i.e., does Xen
hypervisor need to adjust how it passes arguments to PV guests?

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/common.c          |   2 +-
 arch/x86/entry/entry_32.S        |   7 --
 arch/x86/entry/entry_64.S        |  22 ++-----
 arch/x86/include/asm/idtentry.h  | 108 ++++++++++---------------------
 arch/x86/include/asm/irq_stack.h |  43 ++----------
 arch/x86/kernel/apic/apic.c      |   2 +-
 arch/x86/kernel/doublefault_32.c |   2 +-
 arch/x86/kernel/irq.c            |   1 +
 arch/x86/kernel/sev.c            |  10 +--
 arch/x86/kernel/traps.c          |  14 ++--
 arch/x86/mm/fault.c              |   6 +-
 arch/x86/xen/enlighten_pv.c      |   2 +-
 12 files changed, 69 insertions(+), 150 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..83d31cd82a65 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -305,7 +305,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	bool inhcall;
 
 	instrumentation_begin();
-	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
+	run_irq_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6e6af42e044a..41345b0d9bb8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -642,8 +642,6 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	movl	%esp, %eax
-	movl	PT_ORIG_EAX(%esp), %edx		/* get the vector from stack */
-	movl	$-1, PT_ORIG_EAX(%esp)		/* no syscall to restart */
 	call	\cfunc
 	jmp	handle_exception_return
 SYM_CODE_END(asm_\cfunc)
@@ -1036,11 +1034,6 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	ENCODE_FRAME_POINTER
 
 	movl	PT_GS(%esp), %edi		# get the function address
-
-	/* fixup orig %eax */
-	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
-
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC edi
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de22511..ddfa0e7b8485 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -337,9 +337,8 @@ SYM_CODE_END(xen_error_entry)
 /**
  * idtentry_body - Macro to emit code calling the C function
  * @cfunc:		C function to be called
- * @has_error_code:	Hardware pushed error code on stack
  */
-.macro idtentry_body cfunc has_error_code:req
+.macro idtentry_body cfunc
 
 	/*
 	 * Call error_entry() and switch to the task stack if from userspace.
@@ -356,12 +355,6 @@ SYM_CODE_END(xen_error_entry)
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
-
-	.if \has_error_code == 1
-		movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	.endif
-
 	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
@@ -412,7 +405,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \cfunc \has_error_code
+	idtentry_body \cfunc
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -485,7 +478,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body noist_\cfunc, has_error_code=0
+	idtentry_body noist_\cfunc
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -548,12 +541,7 @@ SYM_CODE_START(\asmsym)
 	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
-	/* Update pt_regs */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
-
 	call	kernel_\cfunc
 
 	/*
@@ -565,7 +553,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body user_\cfunc, has_error_code=1
+	idtentry_body user_\cfunc
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -589,8 +577,6 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
 	/* For some configurations \cfunc ends up being a noreturn. */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b241af4ce9b4..7e0e9f8bc8ab 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -15,7 +15,7 @@
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
- *		      No error code pushed by hardware
+ *		      An error code may be pushed by hardware
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
@@ -76,42 +76,25 @@ static __always_inline void __##func(struct pt_regs *regs)
  * - The XEN PV trap entry point: xen_##func (maybe unused)
  * - The C handler called from the ASM entry point
  *
- * Same as DECLARE_IDTENTRY, but has an extra error_code argument for the
- * C-handler.
+ * Same as DECLARE_IDTENTRY(), but required for emitting the ASM stubs, which
+ * do NOT need to push -1 as an error code placement.
  */
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
-	asmlinkage void asm_##func(void);				\
-	asmlinkage void xen_asm_##func(void);				\
-	__visible void func(struct pt_regs *regs, unsigned long error_code)
+	DECLARE_IDTENTRY(vector, func)
 
 /**
  * DEFINE_IDTENTRY_ERRORCODE - Emit code for simple IDT entry points
  *			       Error code pushed by hardware
  * @func:	Function name of the entry point
  *
- * Same as DEFINE_IDTENTRY, but has an extra error_code argument
+ * Same as DEFINE_IDTENTRY().
  */
 #define DEFINE_IDTENTRY_ERRORCODE(func)					\
-static __always_inline void __##func(struct pt_regs *regs,		\
-				     unsigned long error_code);		\
-									\
-__visible noinstr void func(struct pt_regs *regs,			\
-			    unsigned long error_code)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	__##func (regs, error_code);					\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static __always_inline void __##func(struct pt_regs *regs,		\
-				     unsigned long error_code)
+	DEFINE_IDTENTRY(func)
 
 /**
  * DECLARE_IDTENTRY_RAW - Declare functions for raw IDT entry points
- *		      No error code pushed by hardware
+ *		      An error code may be pushed by hardware
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
@@ -135,7 +118,7 @@ static __always_inline void __##func(struct pt_regs *regs,		\
  * is required before the enter/exit() helpers are invoked.
  */
 #define DEFINE_IDTENTRY_RAW(func)					\
-__visible noinstr void func(struct pt_regs *regs)
+	__visible noinstr void func(struct pt_regs *regs)
 
 /**
  * DECLARE_IDTENTRY_RAW_ERRORCODE - Declare functions for raw IDT entry points
@@ -143,7 +126,8 @@ __visible noinstr void func(struct pt_regs *regs)
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_ERRORCODE()
+ * Maps to DECLARE_IDTENTRY_ERRORCODE() for emitting the ASM stubs, which
+ * do NOT need to push -1 as an error code placement
  */
 #define DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)			\
 	DECLARE_IDTENTRY_ERRORCODE(vector, func)
@@ -157,13 +141,10 @@ __visible noinstr void func(struct pt_regs *regs)
  * The macro is written so it acts as function definition. Append the
  * body with a pair of curly brackets.
  *
- * Contrary to DEFINE_IDTENTRY_ERRORCODE() this does not invoke the
- * irqentry_enter/exit() helpers before and after the body invocation. This
- * needs to be done in the body itself if applicable. Use if extra work
- * is required before the enter/exit() helpers are invoked.
+ * Same as DEFINE_IDTENTRY_RAW().
  */
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
-__visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
+	DEFINE_IDTENTRY_RAW(func)
 
 /**
  * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
@@ -171,40 +152,37 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_ERRORCODE()
+ * Maps to DECLARE_IDTENTRY().
  */
 #define DECLARE_IDTENTRY_IRQ(vector, func)				\
-	DECLARE_IDTENTRY_ERRORCODE(vector, func)
+	DECLARE_IDTENTRY(vector, func)
 
 /**
  * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
  * @func:	Function name of the entry point
  *
- * The vector number is pushed by the low level entry stub and handed
- * to the function as error_code argument which needs to be truncated
- * to an u8 because the push is sign extending.
+ * The vector number is pushed by the low level entry stub into the orig_ax
+ * member of the pt_regs structure passed as the only argument.
  *
  * irq_enter/exit_rcu() are invoked before the function body and the
  * KVM L1D flush request is set. Stack switching to the interrupt stack
  * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
-static void __##func(struct pt_regs *regs, u32 vector);			\
+static void __##func(struct pt_regs *regs);				\
 									\
-__visible noinstr void func(struct pt_regs *regs,			\
-			    unsigned long error_code)			\
+__visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
-	u32 vector = (u32)(u8)error_code;				\
 									\
 	instrumentation_begin();					\
 	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_irq_on_irqstack_cond(__##func, regs, vector);		\
+	run_irq_on_irqstack_cond(__##func, regs);			\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
 									\
-static noinline void __##func(struct pt_regs *regs, u32 vector)
+static noinline void __##func(struct pt_regs *regs)
 
 /**
  * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
@@ -225,26 +203,10 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
  * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
  * @func:	Function name of the entry point
  *
- * irqentry_enter/exit() and irq_enter/exit_rcu() are invoked before the
- * function body. KVM L1D flush request is set.
- *
- * Runs the function on the interrupt stack if the entry hit kernel mode
+ * Maps to DEFINE_IDTENTRY_IRQ().
  */
 #define DEFINE_IDTENTRY_SYSVEC(func)					\
-static void __##func(struct pt_regs *regs);				\
-									\
-__visible noinstr void func(struct pt_regs *regs)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_sysvec_on_irqstack_cond(__##func, regs);			\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static noinline void __##func(struct pt_regs *regs)
+	DEFINE_IDTENTRY_IRQ(func)
 
 /**
  * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
@@ -297,8 +259,8 @@ static __always_inline void __##func(struct pt_regs *regs)
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_RAW, but declares also the NOIST C handler
- * which is called from the ASM entry point on user mode entry
+ * Maps to DECLARE_IDTENTRY_RAW(), but declares also the NOIST C handler
+ * which is called from the ASM entry point on user mode entry.
  */
 #define DECLARE_IDTENTRY_IST(vector, func)				\
 	DECLARE_IDTENTRY_RAW(vector, func);				\
@@ -309,19 +271,19 @@ static __always_inline void __##func(struct pt_regs *regs)
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE, but declares also the
+ * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE(), but declares also the
  * safe_stack C handler.
  */
 #define DECLARE_IDTENTRY_VC(vector, func)				\
 	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
-	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
-	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
+	__visible noinstr void kernel_##func(struct pt_regs *regs);	\
+	__visible noinstr void   user_##func(struct pt_regs *regs)
 
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
  *
- * Maps to DEFINE_IDTENTRY_RAW
+ * Maps to DEFINE_IDTENTRY_RAW().
  */
 #define DEFINE_IDTENTRY_IST(func)					\
 	DEFINE_IDTENTRY_RAW(func)
@@ -342,7 +304,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE
+ * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE().
  */
 #define DECLARE_IDTENTRY_DF(vector, func)				\
 	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func)
@@ -351,7 +313,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * DEFINE_IDTENTRY_DF - Emit code for double fault
  * @func:	Function name of the entry point
  *
- * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE().
  */
 #define DEFINE_IDTENTRY_DF(func)					\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
@@ -361,9 +323,9 @@ static __always_inline void __##func(struct pt_regs *regs)
 			       when raised from kernel mode
  * @func:	Function name of the entry point
  *
- * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE().
  */
-#define DEFINE_IDTENTRY_VC_KERNEL(func)				\
+#define DEFINE_IDTENTRY_VC_KERNEL(func)					\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
 
 /**
@@ -371,9 +333,9 @@ static __always_inline void __##func(struct pt_regs *regs)
 			     when raised from user mode
  * @func:	Function name of the entry point
  *
- * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE().
  */
-#define DEFINE_IDTENTRY_VC_USER(func)				\
+#define DEFINE_IDTENTRY_VC_USER(func)					\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(user_##func)
 
 #else	/* CONFIG_X86_64 */
@@ -390,7 +352,6 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DECLARE_IDTENTRY_DF(vector, func)				\
 	asmlinkage void asm_##func(void);				\
 	__visible void func(struct pt_regs *regs,			\
-			    unsigned long error_code,			\
 			    unsigned long address)
 
 /**
@@ -402,7 +363,6 @@ static __always_inline void __##func(struct pt_regs *regs)
  */
 #define DEFINE_IDTENTRY_DF(func)					\
 __visible noinstr void func(struct pt_regs *regs,			\
-			    unsigned long error_code,			\
 			    unsigned long address)
 
 #endif	/* !CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 798183867d78..d04186267e26 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -153,7 +153,7 @@
 }
 
 /*
- * Function call sequence for __call_on_irqstack() for system vectors.
+ * Function call sequence for __call_on_irqstack() for IRQs.
  *
  * Note that irq_enter_rcu() and irq_exit_rcu() do not use the input
  * mechanism because these functions are global and cannot be optimized out
@@ -166,41 +166,20 @@
  * call to idtentry_exit() anyway, it's likely that it does not cause extra
  * effort for this asm magic.
  */
-#define ASM_CALL_SYSVEC							\
+#define ASM_CALL_IRQ							\
 	"call irq_enter_rcu				\n"		\
 	ASM_CALL_ARG1							\
 	"call irq_exit_rcu				\n"
 
-#define SYSVEC_CONSTRAINTS	, [arg1] "r" (regs)
+#define IRQ_CONSTRAINTS        , [arg1] "r" (regs)
 
-#define run_sysvec_on_irqstack_cond(func, regs)				\
+#define run_irq_on_irqstack_cond(func, regs)				\
 {									\
 	assert_function_type(func, void (*)(struct pt_regs *));		\
 	assert_arg_type(regs, struct pt_regs *);			\
 									\
-	call_on_irqstack_cond(func, regs, ASM_CALL_SYSVEC,		\
-			      SYSVEC_CONSTRAINTS, regs);		\
-}
-
-/*
- * As in ASM_CALL_SYSVEC above the clobbers force the compiler to store
- * @regs and @vector in callee saved registers.
- */
-#define ASM_CALL_IRQ							\
-	"call irq_enter_rcu				\n"		\
-	ASM_CALL_ARG2							\
-	"call irq_exit_rcu				\n"
-
-#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" ((unsigned long)vector)
-
-#define run_irq_on_irqstack_cond(func, regs, vector)			\
-{									\
-	assert_function_type(func, void (*)(struct pt_regs *, u32));	\
-	assert_arg_type(regs, struct pt_regs *);			\
-	assert_arg_type(vector, u32);					\
-									\
 	call_on_irqstack_cond(func, regs, ASM_CALL_IRQ,			\
-			      IRQ_CONSTRAINTS, regs, vector);		\
+			      IRQ_CONSTRAINTS, regs);			\
 }
 
 #ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
@@ -220,22 +199,14 @@
 #endif
 
 #else /* CONFIG_X86_64 */
-/* System vector handlers always run on the stack they interrupted. */
-#define run_sysvec_on_irqstack_cond(func, regs)				\
+/* always run on the stack they interrupted. */
+#define run_irq_on_irqstack_cond(func, regs)				\
 {									\
 	irq_enter_rcu();						\
 	func(regs);							\
 	irq_exit_rcu();							\
 }
 
-/* Switches to the irq stack within func() */
-#define run_irq_on_irqstack_cond(func, regs, vector)			\
-{									\
-	irq_enter_rcu();						\
-	func(regs, vector);						\
-	irq_exit_rcu();							\
-}
-
 #endif /* !CONFIG_X86_64 */
 
 #endif
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index af49e24b46a4..af3170239b2e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2230,7 +2230,7 @@ static noinline void handle_spurious_interrupt(u8 vector)
  */
 DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {
-	handle_spurious_interrupt(vector);
+	handle_spurious_interrupt((u32)(u8)regs->orig_ax);
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index 6eaf9a6bc02f..f2d635290034 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -70,7 +70,7 @@ asmlinkage noinstr void __noreturn doublefault_shim(void)
 	regs.cx		= TSS(cx);
 	regs.bx		= TSS(bx);
 
-	exc_double_fault(&regs, 0, cr2);
+	exc_double_fault(&regs, cr2);
 
 	/*
 	 * x86_32 does not save the original CR3 anywhere on a task switch.
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9f668d2f3d11..be1d8aeabdde 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -246,6 +246,7 @@ static __always_inline void handle_irq(struct irq_desc *desc,
  */
 DEFINE_IDTENTRY_IRQ(common_interrupt)
 {
+	u32 vector = (u32)(u8)regs->orig_ax;
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ee7bed453de..34432c1c52ee 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1773,24 +1773,23 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 
 static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 {
-	long error_code = ctxt->fi.error_code;
 	int trapnr = ctxt->fi.vector;
 
 	ctxt->regs->orig_ax = ctxt->fi.error_code;
 
 	switch (trapnr) {
 	case X86_TRAP_GP:
-		exc_general_protection(ctxt->regs, error_code);
+		exc_general_protection(ctxt->regs);
 		break;
 	case X86_TRAP_UD:
 		exc_invalid_op(ctxt->regs);
 		break;
 	case X86_TRAP_PF:
 		write_cr2(ctxt->fi.cr2);
-		exc_page_fault(ctxt->regs, error_code);
+		exc_page_fault(ctxt->regs);
 		break;
 	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
+		exc_alignment_check(ctxt->regs);
 		break;
 	default:
 		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
@@ -1885,6 +1884,7 @@ static __always_inline bool vc_is_db(unsigned long error_code)
  */
 DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 {
+	unsigned long error_code = regs->orig_ax;
 	irqentry_state_t irq_state;
 
 	/*
@@ -1937,6 +1937,8 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
  */
 DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
 {
+	unsigned long error_code = regs->orig_ax;
+
 	/*
 	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
 	 */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4a817d20ce3b..26d023560d03 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -233,6 +233,8 @@ enum cp_error_code {
 
 DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 {
+	unsigned long error_code = regs->orig_ax;
+
 	if (!cpu_feature_enabled(X86_FEATURE_IBT)) {
 		pr_err("Unexpected #CP\n");
 		BUG();
@@ -360,24 +362,25 @@ DEFINE_IDTENTRY(exc_coproc_segment_overrun)
 
 DEFINE_IDTENTRY_ERRORCODE(exc_invalid_tss)
 {
-	do_error_trap(regs, error_code, "invalid TSS", X86_TRAP_TS, SIGSEGV,
+	do_error_trap(regs, regs->orig_ax, "invalid TSS", X86_TRAP_TS, SIGSEGV,
 		      0, NULL);
 }
 
 DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
 {
-	do_error_trap(regs, error_code, "segment not present", X86_TRAP_NP,
+	do_error_trap(regs, regs->orig_ax, "segment not present", X86_TRAP_NP,
 		      SIGBUS, 0, NULL);
 }
 
 DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
 {
-	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
+	do_error_trap(regs, regs->orig_ax, "stack segment", X86_TRAP_SS, SIGBUS,
 		      0, NULL);
 }
 
 DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
+	unsigned long error_code = regs->orig_ax;
 	char *str = "alignment check";
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
@@ -436,6 +439,7 @@ __visible void __noreturn handle_stack_overflow(struct pt_regs *regs,
  */
 DEFINE_IDTENTRY_DF(exc_double_fault)
 {
+	unsigned long error_code = regs->orig_ax;
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
 
@@ -728,6 +732,7 @@ static void gp_user_force_sig_segv(struct pt_regs *regs, int trapnr,
 
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
+	unsigned long error_code = regs->orig_ax;
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
 	unsigned long gp_addr;
@@ -1254,7 +1259,8 @@ DEFINE_IDTENTRY(exc_simd_coprocessor_error)
 	if (IS_ENABLED(CONFIG_X86_INVD_BUG)) {
 		/* AMD 486 bug: INVD in CPL 0 raises #XF instead of #GP */
 		if (!static_cpu_has(X86_FEATURE_XMM)) {
-			__exc_general_protection(regs, 0);
+			regs->orig_ax = 0;
+			__exc_general_protection(regs);
 			return;
 		}
 	}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e8711b2cafaf..c821ea389194 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1471,9 +1471,9 @@ trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 }
 
 static __always_inline void
-handle_page_fault(struct pt_regs *regs, unsigned long error_code,
-			      unsigned long address)
+handle_page_fault(struct pt_regs *regs, unsigned long address)
 {
+	unsigned long error_code = regs->orig_ax;
 	trace_page_fault_entries(regs, error_code, address);
 
 	if (unlikely(kmmio_fault(regs, address)))
@@ -1539,7 +1539,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	state = irqentry_enter(regs);
 
 	instrumentation_begin();
-	handle_page_fault(regs, error_code, address);
+	handle_page_fault(regs, address);
 	instrumentation_end();
 
 	irqentry_exit(regs, state);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 93b658248d01..929d56acd033 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -614,7 +614,7 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_nmi)
 DEFINE_IDTENTRY_RAW_ERRORCODE(xenpv_exc_double_fault)
 {
 	/* On Xen PV, DF doesn't use IST.  The C part is the same as native. */
-	exc_double_fault(regs, error_code);
+	exc_double_fault(regs);
 }
 
 DEFINE_IDTENTRY_RAW(xenpv_exc_debug)
-- 
2.34.1

