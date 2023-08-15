Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A391177C4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjHOAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjHOAsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4951726
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D1F360B9D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAD4C433C9;
        Tue, 15 Aug 2023 00:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060502;
        bh=Bg9dTJaDB6ft5D9/0UBWehGD1kWgD8ZN9J/FDF/TexY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0cdlB7IicBynG/qM4sTxEVOSTdMqLrjvgygkSRWeDxiSQVm6aGL/vSZWhbf5gwj6
         VpqkhER5twL2nqdsvmQQXXWvCV+9JCgP30NZhmDJFLZP8EQ1mGb2UWffn/cbCnMQen
         sVI8wBWduzinxevKV9DMEkdEckfD4loVlNHOO0XwPC6nF48xHpKu8kZ6+3AZvqIfKU
         BO8P9/lO06sfyv57ylwaKc9SuV9jmvrOYD5/NltdjdIHIMJNldLZq02+FEq45YYOxM
         y5bxdb0nbAAxbUX5qbIsgpiXkBmOUx582BK5Y0NFtROCl9XwndpV08Db/BNL9TDt8d
         9krxZe8PUhp7A==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 11/20] ARC: __switch_to: asm with dwarf ops (vs. inline asm)
Date:   Mon, 14 Aug 2023 17:48:04 -0700
Message-Id: <20230815004813.555115-12-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__switch_to() is final step of context switch, swapping kernel modes
stack (and callee regs) of outgoing task with next task.

It is also the starting point of stack unwinging of a sleeping task and
captures SP, FP, BLINK and the corresponding dwarf info. Back when
dinosaurs still roamed around, ARC gas didn't support CFI pseudo ops and
gcc was responsible for generating dwarf info. Thus it had to be written
in "C" with inline asm to do the hand crafting of stack. The function
prologue (and crucial saving of blink etc) was still gcc generated but
not visible in code. Likewise dwarf info was missing.

Now with modern tools, we can make things more obvious by writing the
code in asm and adding approproate dwarf cfi pseudo ops.

This is mostly non functional change, except for slight chnages to asm

 - ARCompact doesn't support MOV_S fp, sp, so we use MOV

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/dwarf.h |  32 +++++++----
 arch/arc/kernel/Makefile     |   9 +--
 arch/arc/kernel/ctx_sw.c     | 103 -----------------------------------
 arch/arc/kernel/ctx_sw_asm.S |  72 +++++++++++++-----------
 4 files changed, 61 insertions(+), 155 deletions(-)
 delete mode 100644 arch/arc/kernel/ctx_sw.c

diff --git a/arch/arc/include/asm/dwarf.h b/arch/arc/include/asm/dwarf.h
index 5f4de05bd4ee..a0d5ebe1bc3f 100644
--- a/arch/arc/include/asm/dwarf.h
+++ b/arch/arc/include/asm/dwarf.h
@@ -10,23 +10,31 @@
 
 #ifdef ARC_DW2_UNWIND_AS_CFI
 
-#define CFI_STARTPROC	.cfi_startproc
-#define CFI_ENDPROC	.cfi_endproc
-#define CFI_DEF_CFA	.cfi_def_cfa
-#define CFI_REGISTER	.cfi_register
-#define CFI_REL_OFFSET	.cfi_rel_offset
-#define CFI_UNDEFINED	.cfi_undefined
+#define CFI_STARTPROC		.cfi_startproc
+#define CFI_ENDPROC		.cfi_endproc
+#define CFI_DEF_CFA		.cfi_def_cfa
+#define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
+#define CFI_DEF_CFA_REGISTER	.cfi_def_cfa_register
+#define CFI_OFFSET		.cfi_offset
+#define CFI_REL_OFFSET		.cfi_rel_offset
+#define CFI_REGISTER		.cfi_register
+#define CFI_RESTORE		.cfi_restore
+#define CFI_UNDEFINED		.cfi_undefined
 
 #else
 
 #define CFI_IGNORE	#
 
-#define CFI_STARTPROC	CFI_IGNORE
-#define CFI_ENDPROC	CFI_IGNORE
-#define CFI_DEF_CFA	CFI_IGNORE
-#define CFI_REGISTER	CFI_IGNORE
-#define CFI_REL_OFFSET	CFI_IGNORE
-#define CFI_UNDEFINED	CFI_IGNORE
+#define CFI_STARTPROC		CFI_IGNORE
+#define CFI_ENDPROC		CFI_IGNORE
+#define CFI_DEF_CFA		CFI_IGNORE
+#define CFI_DEF_CFA_OFFSET	CFI_IGNORE
+#define CFI_DEF_CFA_REGISTER	CFI_IGNORE
+#define CFI_OFFSET		CFI_IGNORE
+#define CFI_REL_OFFSET		CFI_IGNORE
+#define CFI_REGISTER		CFI_IGNORE
+#define CFI_RESTORE		CFI_IGNORE
+#define CFI_UNDEFINED		CFI_IGNORE
 
 #endif	/* !ARC_DW2_UNWIND_AS_CFI */
 
diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 0723d888ac44..95fbf9364c67 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -5,6 +5,8 @@
 
 obj-y	:= head.o arcksyms.o setup.o irq.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o
+obj-y	+= ctx_sw_asm.o
+
 obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
 obj-$(CONFIG_ISA_ARCV2)			+= entry-arcv2.o intc-arcv2.o
 
@@ -24,11 +26,4 @@ ifdef CONFIG_ISA_ARCOMPACT
 CFLAGS_fpu.o   += -mdpfp
 endif
 
-ifdef CONFIG_ARC_DW2_UNWIND
-CFLAGS_ctx_sw.o += -fno-omit-frame-pointer
-obj-y += ctx_sw.o
-else
-obj-y += ctx_sw_asm.o
-endif
-
 extra-y := vmlinux.lds
diff --git a/arch/arc/kernel/ctx_sw.c b/arch/arc/kernel/ctx_sw.c
deleted file mode 100644
index 40d89440b7e4..000000000000
--- a/arch/arc/kernel/ctx_sw.c
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- *
- * Vineetg: Aug 2009
- *  -"C" version of lowest level context switch asm macro called by schedular
- *   gcc doesn't generate the dward CFI info for hand written asm, hence can't
- *   backtrace out of it (e.g. tasks sleeping in kernel).
- *   So we cheat a bit by writing almost similar code in inline-asm.
- *  -This is a hacky way of doing things, but there is no other simple way.
- *   I don't want/intend to extend unwinding code to understand raw asm
- */
-
-#include <asm/asm-offsets.h>
-#include <asm/switch_to.h>
-#include <linux/sched/debug.h>
-
-#define KSP_WORD_OFF 	((TASK_THREAD + THREAD_KSP) / 4)
-
-struct task_struct *__sched
-__switch_to(struct task_struct *prev_task, struct task_struct *next_task)
-{
-	unsigned int tmp;
-	unsigned int prev = (unsigned int)prev_task;
-	unsigned int next = (unsigned int)next_task;
-
-	__asm__ __volatile__(
-		/* FP/BLINK save generated by gcc (standard function prologue */
-		"st.a    r13, [sp, -4]   \n\t"
-		"st.a    r14, [sp, -4]   \n\t"
-		"st.a    r15, [sp, -4]   \n\t"
-		"st.a    r16, [sp, -4]   \n\t"
-		"st.a    r17, [sp, -4]   \n\t"
-		"st.a    r18, [sp, -4]   \n\t"
-		"st.a    r19, [sp, -4]   \n\t"
-		"st.a    r20, [sp, -4]   \n\t"
-		"st.a    r21, [sp, -4]   \n\t"
-		"st.a    r22, [sp, -4]   \n\t"
-		"st.a    r23, [sp, -4]   \n\t"
-		"st.a    r24, [sp, -4]   \n\t"
-		"st.a    r25, [sp, -4]   \n\t"
-
-		/* set ksp of outgoing task in tsk->thread.ksp */
-#if KSP_WORD_OFF <= 255
-		"st.as   sp, [%3, %1]    \n\t"
-#else
-		/*
-		 * Workaround for NR_CPUS=4k
-		 * %1 is bigger than 255 (S9 offset for st.as)
-		 */
-		"add2    r24, %3, %1     \n\t"
-		"st      sp, [r24]       \n\t"
-#endif
-
-		/*
-		 * setup _current_task with incoming tsk.
-		 * optionally, set caching reg to that as well
-		 * For SMP extra work to get to &_current_task[cpu]
-		 * (open coded SET_CURR_TASK_ON_CPU)
-		 */
-#ifndef CONFIG_SMP
-		"st  %2, [@_current_task]	\n\t"
-#else
-		"lr   r24, [identity]		\n\t"
-		"lsr  r24, r24, 8		\n\t"
-		"bmsk r24, r24, 7		\n\t"
-		"add2 r24, @_current_task, r24	\n\t"
-		"st   %2,  [r24]		\n\t"
-#endif
-#ifdef CONFIG_ARC_CURR_IN_REG
-		"mov gp, %2   \n\t"
-#endif
-
-		/* get ksp of incoming task from tsk->thread.ksp */
-		"ld.as  sp, [%2, %1]   \n\t"
-
-		/* start loading it's CALLEE reg file */
-		"ld.ab   r25, [sp, 4]   \n\t"
-		"ld.ab   r24, [sp, 4]   \n\t"
-		"ld.ab   r23, [sp, 4]   \n\t"
-		"ld.ab   r22, [sp, 4]   \n\t"
-		"ld.ab   r21, [sp, 4]   \n\t"
-		"ld.ab   r20, [sp, 4]   \n\t"
-		"ld.ab   r19, [sp, 4]   \n\t"
-		"ld.ab   r18, [sp, 4]   \n\t"
-		"ld.ab   r17, [sp, 4]   \n\t"
-		"ld.ab   r16, [sp, 4]   \n\t"
-		"ld.ab   r15, [sp, 4]   \n\t"
-		"ld.ab   r14, [sp, 4]   \n\t"
-		"ld.ab   r13, [sp, 4]   \n\t"
-
-		/* last (ret value) = prev : although for ARC it mov r0, r0 */
-		"mov     %0, %3        \n\t"
-
-		/* FP/BLINK restore generated by gcc (standard func epilogue */
-
-		: "=r"(tmp)
-		: "n"(KSP_WORD_OFF), "r"(next), "r"(prev)
-		: "blink"
-	);
-
-	return (struct task_struct *)tmp;
-}
diff --git a/arch/arc/kernel/ctx_sw_asm.S b/arch/arc/kernel/ctx_sw_asm.S
index 95cba6265e2b..59d779004e64 100644
--- a/arch/arc/kernel/ctx_sw_asm.S
+++ b/arch/arc/kernel/ctx_sw_asm.S
@@ -13,48 +13,54 @@
 
 #define KSP_WORD_OFF 	((TASK_THREAD + THREAD_KSP) / 4)
 
-;################### Low Level Context Switch ##########################
+; IN
+;  - r0: prev task (also current)
+;  - r1: next task
+; OUT
+;  - r0: prev task (so r0 not touched)
 
 	.section .sched.text,"ax",@progbits
-	.align 4
-	.global __switch_to
-	.type   __switch_to, @function
-__switch_to:
-	CFI_STARTPROC
-
-	/* Save regs on kernel mode stack of task */
-	st.a    blink, [sp, -4]
-	st.a    fp, [sp, -4]
+ENTRY_CFI(__switch_to)
+
+	/* save kernel stack frame regs of @prev task */
+	push	blink
+	CFI_DEF_CFA_OFFSET 4
+	CFI_OFFSET r31, -4
+
+	push	fp
+	CFI_DEF_CFA_OFFSET 8
+	CFI_OFFSET r27, -8
+
+	mov	fp, sp
+	CFI_DEF_CFA_REGISTER r27
+
+	/* kernel mode callee regs of @prev */
 	SAVE_CALLEE_SAVED_KERNEL
 
-	/* Save the now KSP in task->thread.ksp */
+	/* save final SP to @prev->thread.ksp */
 #if KSP_WORD_OFF  <= 255
 	st.as  sp, [r0, KSP_WORD_OFF]
 #else
 	/* Workaround for NR_CPUS=4k as ST.as can only take s9 offset */
-	add2	r24, r0, KSP_WORD_OFF
-	st	sp, [r24]
+	add2	r10, r0, KSP_WORD_OFF
+	st	sp, [r10]
 #endif
-	/*
-	* Return last task in r0 (return reg)
-	* On ARC, Return reg = First Arg reg = r0.
-	* Since we already have last task in r0,
-	* don't need to do anything special to return it
-	*/
-
-	/*
-	 * switch to new task, contained in r1
-	 * Temp reg r3 is required to get the ptr to store val
-	 */
-	SET_CURR_TASK_ON_CPU  r1, r3
-
-	/* reload SP with kernel mode stack pointer in task->thread.ksp */
-	ld.as  sp, [r1, KSP_WORD_OFF]
-
-	/* restore the registers */
+	/* update @next in _current_task[] and GP register caching it */
+	SET_CURR_TASK_ON_CPU  r1, r10
+
+	/* load SP from @next->thread.ksp */
+	ld.as	sp, [r1, KSP_WORD_OFF]
+
+	/* restore callee regs, stack frame regs of @next */
 	RESTORE_CALLEE_SAVED_KERNEL
-	ld.ab   fp, [sp, 4]
-	ld.ab   blink, [sp, 4]
-	j       [blink]
 
+	pop	fp
+	CFI_RESTORE r27
+	CFI_DEF_CFA r28, 4
+
+	pop	blink
+	CFI_RESTORE r31
+	CFI_DEF_CFA_OFFSET 0
+
+	j      [blink]
 END_CFI(__switch_to)
-- 
2.34.1

