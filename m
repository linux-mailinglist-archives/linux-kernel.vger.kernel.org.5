Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E977C4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjHOAtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHOAsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD751733
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC0964009
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42DEC433CA;
        Tue, 15 Aug 2023 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060502;
        bh=hhT1mF3skdDpP43eowGATSIN1CO8SgUeKtk2qpYb3S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rA/LTrLMHU1IwchZrk2sbrR7xCFsiemGnDZxbS5r4Tmlt3Y4vQ9hg8zxUgPWNMKxc
         OLXD//dDHDXpmNk2b/YOH26z6pCRXsA6uBy3yPCwkhBadeqH2MiF+fREPkvHGPK2fg
         OsnUVww0uX6mP0CAZTwkVaVAh6NCX+/WdXQHAhNMT/FhaQjkJkgsg4pPyAuGO3aZOQ
         cYiKMI9q4eAg+WABMF+bGc1Vod1sISDR9BDYFSldhZmmvOgPC3fhRjMIPAU6OQMYH8
         IMJDwluvPTox/ii04UozRDqx3sYaWauLOBVmH2QGUCkUCno8izwtWlST77h8fol2gA
         gsofnUuE4IIXw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 09/20] ARC: entry: use gp to cache task pointer (vs. r25)
Date:   Mon, 14 Aug 2023 17:48:02 -0700
Message-Id: <20230815004813.555115-10-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation is eventual ABI considerations for ARCv3 but even without
it this change us worthwhile as diffstat reduces 100 net lines

r25 is a callee saved register, normally not saved by entry code in
pt_regs. However because of its usage in CONFIG_ARC_CURR_IN_REG it needs
to be. This in turn requires a whole bunch of special casing when we
need to access r25. Then there is distinction between user mode r25 vs.
kernel mode r25 - hence distinct SAVE_CALLEE_SAVED_{USER,KERNEL}

Instead use gp which is a scratch register and thus saved already in entry
code. This cleans things up significantly and much nocer on eyes:

 - SAVE_CALLEE_SAVED_{USER,KERNEL} are now exactly same
 - no special user_r25 slot in pt_reggs

Note that typical global asm registers are callee-saved (r25), but gp is
not callee-saved thus needs additional -ffixed-<reg> toggle

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig                     |   6 +-
 arch/arc/Makefile                    |   6 +-
 arch/arc/include/asm/current.h       |   2 +-
 arch/arc/include/asm/entry-arcv2.h   |  17 ++---
 arch/arc/include/asm/entry-compact.h |  35 +++------
 arch/arc/include/asm/entry.h         | 107 ++++++++-------------------
 arch/arc/include/asm/ptrace.h        |   6 +-
 arch/arc/kernel/asm-offsets.c        |   2 -
 arch/arc/kernel/ctx_sw.c             |  13 +---
 arch/arc/kernel/ctx_sw_asm.S         |   2 +-
 arch/arc/kernel/entry.S              |   3 +-
 arch/arc/kernel/process.c            |  11 ---
 arch/arc/kernel/ptrace.c             |   2 -
 13 files changed, 58 insertions(+), 154 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 47b4acc7d0c9..c92bacc1ff4c 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -492,11 +492,11 @@ config ARC_KVADDR_SIZE
 	  kernel-user gutter)
 
 config ARC_CURR_IN_REG
-	bool "Dedicate Register r25 for current_task pointer"
+	bool "cache current task pointer in gp"
 	default y
 	help
-	  This reserved Register R25 to point to Current Task in
-	  kernel mode. This saves memory access for each such access
+	  This reserves gp register to point to Current Task in
+	  kernel mode eliding memory access for each access
 
 
 config ARC_EMUL_UNALIGNED
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 329400a1c355..2390dd042e36 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -28,14 +28,14 @@ cflags-y				+= $(tune-mcpu-def-y)
 endif
 endif
 
-
 ifdef CONFIG_ARC_CURR_IN_REG
 # For a global register definition, make sure it gets passed to every file
 # We had a customer reported bug where some code built in kernel was NOT using
-# any kernel headers, and missing the r25 global register
+# any kernel headers, and missing the global register
 # Can't do unconditionally because of recursive include issues
 # due to <linux/thread_info.h>
 LINUXINCLUDE	+=  -include $(srctree)/arch/arc/include/asm/current.h
+cflags-y	+= -ffixed-gp
 endif
 
 cflags-y				+= -fsection-anchors
@@ -67,7 +67,7 @@ cflags-$(CONFIG_ARC_DW2_UNWIND)		+= -fasynchronous-unwind-tables $(cfi)
 # small data is default for elf32 tool-chain. If not usable, disable it
 # This also allows repurposing GP as scratch reg to gcc reg allocator
 disable_small_data := y
-cflags-$(disable_small_data)		+= -mno-sdata -fcall-used-gp
+cflags-$(disable_small_data)		+= -mno-sdata
 
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -mbig-endian
 ldflags-$(CONFIG_CPU_BIG_ENDIAN)	+= -EB
diff --git a/arch/arc/include/asm/current.h b/arch/arc/include/asm/current.h
index 9b9bdd3e6538..06be89f6f2f0 100644
--- a/arch/arc/include/asm/current.h
+++ b/arch/arc/include/asm/current.h
@@ -13,7 +13,7 @@
 
 #ifdef CONFIG_ARC_CURR_IN_REG
 
-register struct task_struct *curr_arc asm("r25");
+register struct task_struct *curr_arc asm("gp");
 #define current (curr_arc)
 
 #else
diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 0ff4c0610561..858742feab71 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -18,7 +18,6 @@
  *              |      orig_r0      |
  *              |      event/ECR    |
  *              |      bta          |
- *              |      user_r25     |
  *              |      gp           |
  *              |      fp           |
  *              |      sp           |
@@ -56,7 +55,7 @@
 	;                 hardware does even if CONFIG_ARC_IRQ_NO_AUTOSAVE
 	;   4. Auto save: (optional) r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI
 	;
-	; (B) Manually saved some regs: r12,r25,r30, sp,fp,gp, ACCL pair
+	; (B) Manually saved some regs: r12,r30, sp,fp,gp, ACCL pair
 
 #ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
 	; carve pt_regs on stack (case #3), PC/STAT32 already on stack
@@ -157,17 +156,17 @@
 
 	st	r10, [sp, PT_sp]	; SP (pt_regs->sp)
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	st	r25, [sp, PT_user_r25]
-	GET_CURR_TASK_ON_CPU	r25
-#endif
-
 #ifdef CONFIG_ARC_HAS_ACCL_REGS
 	ST2	r58, r59, PT_r58
 #endif
 
 	/* clobbers r10, r11 registers pair */
 	DSP_SAVE_REGFILE_IRQ
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	GET_CURR_TASK_ON_CPU	gp
+#endif
+
 .endm
 
 /*------------------------------------------------------------------------*/
@@ -188,10 +187,6 @@
 	sr	r10, [AUX_USER_SP]
 1:
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	ld	r25, [sp, PT_user_r25]
-#endif
-
 	/* clobbers r10, r11 registers pair */
 	DSP_RESTORE_REGFILE_IRQ
 
diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index 67ff06e15cea..e3383e1cb040 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -151,14 +151,6 @@
 	/* ARC700 doesn't provide auto-stack switching */
 	SWITCH_TO_KERNEL_STK
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	/* Treat r25 as scratch reg (save on stack) and load with "current" */
-	PUSH    r25
-	GET_CURR_TASK_ON_CPU   r25
-#else
-	sub     sp, sp, 4
-#endif
-
 	st.a	r0, [sp, -8]    /* orig_r0 needed for syscall (skip ECR slot) */
 	sub	sp, sp, 4	/* skip pt_regs->sp, already saved above */
 
@@ -179,6 +171,11 @@
 
 	lr	r10, [ecr]
 	st      r10, [sp, PT_event]    /* EV_Trap expects r10 to have ECR */
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/* gp already saved on stack: now load with "current" */
+	GET_CURR_TASK_ON_CPU   gp
+#endif
 .endm
 
 /*--------------------------------------------------------------
@@ -208,11 +205,8 @@
 	POP	gp
 	RESTORE_R12_TO_R0
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	ld	r25, [sp, 12]
-#endif
 	ld  sp, [sp] /* restore original sp */
-	/* orig_r0, ECR, user_r25 skipped automatically */
+	/* orig_r0, ECR skipped automatically */
 .endm
 
 /* Dummy ECR values for Interrupts */
@@ -229,13 +223,6 @@
 
 	SWITCH_TO_KERNEL_STK
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	/* Treat r25 as scratch reg (save on stack) and load with "current" */
-	PUSH    r25
-	GET_CURR_TASK_ON_CPU   r25
-#else
-	sub     sp, sp, 4
-#endif
 
 	PUSH	0x003\LVL\()abcd    /* Dummy ECR */
 	sub	sp, sp, 8	    /* skip orig_r0 (not needed)
@@ -255,6 +242,10 @@
 	PUSHAX	lp_start
 	PUSHAX	bta_l\LVL\()
 
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/* gp already saved on stack: now load with "current" */
+	GET_CURR_TASK_ON_CPU   gp
+#endif
 .endm
 
 /*--------------------------------------------------------------
@@ -282,11 +273,7 @@
 	POP	gp
 	RESTORE_R12_TO_R0
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	ld	r25, [sp, 12]
-#endif
-	ld  sp, [sp] /* restore original sp */
-	/* orig_r0, ECR, user_r25 skipped automatically */
+	ld  sp, [sp] /* restore original sp; orig_r0, ECR skipped implicitly */
 .endm
 
 /* Get thread_info of "current" tsk */
diff --git a/arch/arc/include/asm/entry.h b/arch/arc/include/asm/entry.h
index 2980bc9b7653..49c2e090cb5c 100644
--- a/arch/arc/include/asm/entry.h
+++ b/arch/arc/include/asm/entry.h
@@ -91,7 +91,7 @@
  * Helpers to save/restore callee-saved regs:
  * used by several macros below
  *-------------------------------------------------------------*/
-.macro SAVE_R13_TO_R24
+.macro SAVE_R13_TO_R25
 	PUSH	r13
 	PUSH	r14
 	PUSH	r15
@@ -104,9 +104,11 @@
 	PUSH	r22
 	PUSH	r23
 	PUSH	r24
+	PUSH	r25
 .endm
 
-.macro RESTORE_R24_TO_R13
+.macro RESTORE_R25_TO_R13
+	POP	r25
 	POP	r24
 	POP	r23
 	POP	r22
@@ -121,81 +123,31 @@
 	POP	r13
 .endm
 
-/*--------------------------------------------------------------
- * Collect User Mode callee regs as struct callee_regs - needed by
- * fork/do_signal/unaligned-access-emulation.
- * (By default only scratch regs are saved on entry to kernel)
- *
- * Special handling for r25 if used for caching Task Pointer.
- * It would have been saved in task->thread.user_r25 already, but to keep
- * the interface same it is copied into regular r25 placeholder in
- * struct callee_regs.
- *-------------------------------------------------------------*/
+/*
+ * save user mode callee regs as struct callee_regs
+ *  - needed by fork/do_signal/unaligned-access-emulation.
+ */
 .macro SAVE_CALLEE_SAVED_USER
+	SAVE_R13_TO_R25
+.endm
 
-	mov	r12, sp		; save SP as ref to pt_regs
-	SAVE_R13_TO_R24
-
-#ifdef CONFIG_ARC_CURR_IN_REG
-	; Retrieve orig r25 and save it with rest of callee_regs
-	ld	r12, [r12, PT_user_r25]
-	PUSH	r12
-#else
-	PUSH	r25
-#endif
-
+/*
+ * restore user mode callee regs as struct callee_regs
+ *  - could have been changed by ptrace tracer or unaligned-access fixup
+ */
+.macro RESTORE_CALLEE_SAVED_USER
+	RESTORE_R25_TO_R13
 .endm
 
-/*--------------------------------------------------------------
- * Save kernel Mode callee regs at the time of Contect Switch.
- *
- * Special handling for r25 if used for caching Task Pointer.
- * Kernel simply skips saving it since it will be loaded with
- * incoming task pointer anyways
- *-------------------------------------------------------------*/
+/*
+ * save/restore kernel mode callee regs at the time of context switch
+ */
 .macro SAVE_CALLEE_SAVED_KERNEL
-
-	SAVE_R13_TO_R24
-
-#ifdef CONFIG_ARC_CURR_IN_REG
-	sub     sp, sp, 4
-#else
-	PUSH	r25
-#endif
+	SAVE_R13_TO_R25
 .endm
 
-/*--------------------------------------------------------------
- * Opposite of SAVE_CALLEE_SAVED_KERNEL
- *-------------------------------------------------------------*/
 .macro RESTORE_CALLEE_SAVED_KERNEL
-
-#ifdef CONFIG_ARC_CURR_IN_REG
-	add     sp, sp, 4  /* skip usual r25 placeholder */
-#else
-	POP	r25
-#endif
-	RESTORE_R24_TO_R13
-.endm
-
-/*--------------------------------------------------------------
- * Opposite of SAVE_CALLEE_SAVED_USER
- *
- * ptrace tracer or unaligned-access fixup might have changed a user mode
- * callee reg which is saved back to usual r25 storage location
- *-------------------------------------------------------------*/
-.macro RESTORE_CALLEE_SAVED_USER
-
-#ifdef CONFIG_ARC_CURR_IN_REG
-	POP	r12
-#else
-	POP	r25
-#endif
-	RESTORE_R24_TO_R13
-
-	; SP is back to start of pt_regs
-#ifdef CONFIG_ARC_CURR_IN_REG
-	st	r12, [sp, PT_user_r25]
-#endif
+	RESTORE_R25_TO_R13
 .endm
 
 /*--------------------------------------------------------------
@@ -231,10 +183,10 @@
 
 #ifdef CONFIG_SMP
 
-/*-------------------------------------------------
+/*
  * Retrieve the current running task on this CPU
- * 1. Determine curr CPU id.
- * 2. Use it to index into _current_task[ ]
+ *  - loads it from backing _current_task[] (and can't use the
+ *    caching reg for current task
  */
 .macro  GET_CURR_TASK_ON_CPU   reg
 	GET_CPU_ID  \reg
@@ -256,7 +208,7 @@
 	add2 \tmp, @_current_task, \tmp
 	st   \tsk, [\tmp]
 #ifdef CONFIG_ARC_CURR_IN_REG
-	mov r25, \tsk
+	mov gp, \tsk
 #endif
 
 .endm
@@ -271,21 +223,20 @@
 .macro  SET_CURR_TASK_ON_CPU    tsk, tmp
 	st  \tsk, [@_current_task]
 #ifdef CONFIG_ARC_CURR_IN_REG
-	mov r25, \tsk
+	mov gp, \tsk
 #endif
 .endm
 
 #endif /* SMP / UNI */
 
-/* ------------------------------------------------------------------
+/*
  * Get the ptr to some field of Current Task at @off in task struct
- *  -Uses r25 for Current task ptr if that is enabled
+ *  - Uses current task cached in reg if enabled
  */
-
 #ifdef CONFIG_ARC_CURR_IN_REG
 
 .macro GET_CURR_TASK_FIELD_PTR  off,  reg
-	add \reg, r25, \off
+	add \reg, gp, \off
 .endm
 
 #else
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index cf90fcd2a628..e9798f46cdc4 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -52,11 +52,9 @@ struct pt_regs {
 		};
 		unsigned long event;
 	};
-
-	unsigned long user_r25;
 };
 
-#define MAX_REG_OFFSET offsetof(struct pt_regs, user_r25)
+#define MAX_REG_OFFSET offsetof(struct pt_regs, event)
 
 #else
 
@@ -79,8 +77,6 @@ struct pt_regs {
 
 	unsigned long bta;	/* bta_l1, bta_l2, erbta */
 
-	unsigned long user_r25;
-
 	unsigned long r26;	/* gp */
 	unsigned long fp;
 	unsigned long sp;	/* user/kernel sp depending on where we came from  */
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index 0e884036ab74..37324fd9a72f 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -63,8 +63,6 @@ int main(void)
 	DEFINE(PT_blink, offsetof(struct pt_regs, blink));
 	DEFINE(PT_lpe, offsetof(struct pt_regs, lp_end));
 	DEFINE(PT_lpc, offsetof(struct pt_regs, lp_count));
-	DEFINE(PT_user_r25, offsetof(struct pt_regs, user_r25));
-
 	DEFINE(SZ_CALLEE_REGS, sizeof(struct callee_regs));
 	DEFINE(SZ_PT_REGS, sizeof(struct pt_regs));
 
diff --git a/arch/arc/kernel/ctx_sw.c b/arch/arc/kernel/ctx_sw.c
index bf16f777a0bc..40d89440b7e4 100644
--- a/arch/arc/kernel/ctx_sw.c
+++ b/arch/arc/kernel/ctx_sw.c
@@ -38,11 +38,7 @@ __switch_to(struct task_struct *prev_task, struct task_struct *next_task)
 		"st.a    r22, [sp, -4]   \n\t"
 		"st.a    r23, [sp, -4]   \n\t"
 		"st.a    r24, [sp, -4]   \n\t"
-#ifndef CONFIG_ARC_CURR_IN_REG
 		"st.a    r25, [sp, -4]   \n\t"
-#else
-		"sub     sp, sp, 4      \n\t"	/* usual r25 placeholder */
-#endif
 
 		/* set ksp of outgoing task in tsk->thread.ksp */
 #if KSP_WORD_OFF <= 255
@@ -58,7 +54,7 @@ __switch_to(struct task_struct *prev_task, struct task_struct *next_task)
 
 		/*
 		 * setup _current_task with incoming tsk.
-		 * optionally, set r25 to that as well
+		 * optionally, set caching reg to that as well
 		 * For SMP extra work to get to &_current_task[cpu]
 		 * (open coded SET_CURR_TASK_ON_CPU)
 		 */
@@ -72,19 +68,14 @@ __switch_to(struct task_struct *prev_task, struct task_struct *next_task)
 		"st   %2,  [r24]		\n\t"
 #endif
 #ifdef CONFIG_ARC_CURR_IN_REG
-		"mov r25, %2   \n\t"
+		"mov gp, %2   \n\t"
 #endif
 
 		/* get ksp of incoming task from tsk->thread.ksp */
 		"ld.as  sp, [%2, %1]   \n\t"
 
 		/* start loading it's CALLEE reg file */
-
-#ifndef CONFIG_ARC_CURR_IN_REG
 		"ld.ab   r25, [sp, 4]   \n\t"
-#else
-		"add    sp, sp, 4       \n\t"
-#endif
 		"ld.ab   r24, [sp, 4]   \n\t"
 		"ld.ab   r23, [sp, 4]   \n\t"
 		"ld.ab   r22, [sp, 4]   \n\t"
diff --git a/arch/arc/kernel/ctx_sw_asm.S b/arch/arc/kernel/ctx_sw_asm.S
index 02c461484761..95cba6265e2b 100644
--- a/arch/arc/kernel/ctx_sw_asm.S
+++ b/arch/arc/kernel/ctx_sw_asm.S
@@ -49,7 +49,7 @@ __switch_to:
 	SET_CURR_TASK_ON_CPU  r1, r3
 
 	/* reload SP with kernel mode stack pointer in task->thread.ksp */
-	ld.as  sp, [r1, (TASK_THREAD + THREAD_KSP)/4]
+	ld.as  sp, [r1, KSP_WORD_OFF]
 
 	/* restore the registers */
 	RESTORE_CALLEE_SAVED_KERNEL
diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
index 54e91df678dd..cd26e0fa5044 100644
--- a/arch/arc/kernel/entry.S
+++ b/arch/arc/kernel/entry.S
@@ -210,7 +210,6 @@ trap_with_param:
 
 	; Save callee regs in case gdb wants to have a look
 	; SP will grow up by size of CALLEE Reg-File
-	; NOTE: clobbers r12
 	SAVE_CALLEE_SAVED_USER
 
 	; save location of saved Callee Regs @ thread_struct->pc
@@ -318,7 +317,7 @@ resume_user_mode_begin:
 	;      tracer might call PEEKUSR(CALLEE reg)
 	;
 	; NOTE: SP will grow up by size of CALLEE Reg-File
-	SAVE_CALLEE_SAVED_USER		; clobbers r12
+	SAVE_CALLEE_SAVED_USER
 
 	; save location of saved Callee Regs @ thread_struct->callee
 	GET_CURR_TASK_FIELD_PTR   TASK_THREAD, r10
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 980b71da2f61..96f591508142 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -162,7 +162,6 @@ asmlinkage void ret_from_fork(void);
  * |      SP        |
  * |    orig_r0     |
  * |    event/ECR   |
- * |    user_r25    |
  * ------------------  <===== END of PAGE
  */
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
@@ -243,16 +242,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 */
 	c_callee->r25 = task_thread_info(p)->thr_ptr;
 
-#ifdef CONFIG_ARC_CURR_IN_REG
-	/*
-	 * setup usermode thread pointer #2:
-	 * however for this special use of r25 in kernel, __switch_to() sets
-	 * r25 for kernel needs and only in the final return path is usermode
-	 * r25 setup, from pt_regs->user_r25. So set that up as well
-	 */
-	c_regs->user_r25 = c_callee->r25;
-#endif
-
 	return 0;
 }
 
diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index 2abdcd9b09e8..8226df3163fe 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -47,7 +47,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_NAME(sp),
 	REG_OFFSET_NAME(orig_r0),
 	REG_OFFSET_NAME(event),
-	REG_OFFSET_NAME(user_r25),
 	REG_OFFSET_END,
 };
 
@@ -57,7 +56,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REG_OFFSET_NAME(orig_r0),
 	REG_OFFSET_NAME(event),
 	REG_OFFSET_NAME(bta),
-	REG_OFFSET_NAME(user_r25),
 	REG_OFFSET_NAME(r26),
 	REG_OFFSET_NAME(fp),
 	REG_OFFSET_NAME(sp),
-- 
2.34.1

