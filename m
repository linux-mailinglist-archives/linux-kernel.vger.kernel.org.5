Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76F79D083
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbjILL7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjILL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:58:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66131981;
        Tue, 12 Sep 2023 04:58:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0BC433C7;
        Tue, 12 Sep 2023 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694519881;
        bh=G3ZQqiwe5gyTFzZ+daR1X2GrYG5m5yMSRJlV8uyElWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9waNLu43RFFaehAC2n7+UH532/KbktpyyUI5X4q9mkeuMBcnRYayjmZetCZt/gbv
         KbY+tNF613mLp/gYnys/+D2vN13XmCS4e3aDnOjY9Xy7pgvUUz3UcCdSGnoNWNFgEN
         zSqTfJ56Y4/gIhE22VFdx3QfCxyDAvZQpdSAoK1ymsPfxcjdZrW/wsmmKy9r3AoTlT
         dPyljxaiQO0uLPQGsB6zioThmZOXDLPjtSTbOhOiUN20Xx9Hq9QnNTDgIwiyNBP6Br
         KSLoRFPUZuqT/zd5r06UTfaV3WUjBdKoowgmgFXuW3qoLl4trKIz+ZzguGO7bpsOqA
         2PqjCXdRT2fzA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] riscv: vector: allow kernel-mode Vector with preemption
Date:   Tue, 12 Sep 2023 13:57:27 +0200
Message-Id: <20230912115728.172982-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912115728.172982-1-bjorn@kernel.org>
References: <20230912115728.172982-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Chiu <andy.chiu@sifive.com>

Add kernel_vstate to keep track of kernel-mode Vector registers when
trap introduced context switch happens. Also, provide trap_pt_regs to
let context save/restore routine reference status.VS at which the trap
takes place. The thread flag TIF_RISCV_V_KERNEL_MODE indicates whether
a task is running in kernel-mode Vector with preemption 'ON'. So context
switch routines know and would save V-regs to kernel_vstate and restore
V-regs immediately from kernel_vstate if the bit is set.

Apart from a task's preemption status, the capability of
running preemptive kernel-mode Vector is jointly controlled by the
RISCV_V_VSTATE_CTRL_PREEMPTIBLE mask in the task's
thread.vstate_ctrl. This bit is masked whenever a trap takes place in
kernel mode while executing preemptive Vector code.

Also, provide a config CONFIG_RISCV_ISA_V_PREEMPTIVE to give users an
option to disable preemptible kernel-mode Vector at build time. Users
with constraint memory may want to disable this config as preemptible
kernel-mode Vector needs extra space for tracking per thread's
kernel-mode V context. Or, users might as well want to disable it if all
kernel-mode Vector code is time sensitive and cannot tolerate context
swicth overhead.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/Kconfig                     | 10 +++++
 arch/riscv/include/asm/processor.h     |  2 +
 arch/riscv/include/asm/simd.h          |  4 +-
 arch/riscv/include/asm/thread_info.h   |  4 ++
 arch/riscv/include/asm/vector.h        | 27 +++++++++++--
 arch/riscv/kernel/asm-offsets.c        |  2 +
 arch/riscv/kernel/entry.S              | 45 ++++++++++++++++++++++
 arch/riscv/kernel/kernel_mode_vector.c | 53 ++++++++++++++++++++++++--
 arch/riscv/kernel/process.c            |  8 +++-
 arch/riscv/kernel/vector.c             |  3 +-
 10 files changed, 148 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..dc51164b8fd4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -520,6 +520,16 @@ config RISCV_ISA_V_DEFAULT_ENABLE
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_V_PREEMPTIVE
+	bool "Run kernel-mode Vector with kernel preemption"
+	depends on PREEMPTION
+	depends on RISCV_ISA_V
+	default y
+	help
+	  Ordinarily the kernel disables preemption before running in-kernel
+	  Vector code. This config frees the kernel from disabling preemption
+	  by adding memory on demand for tracking kernel's V-context.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3e23e1786d05..f9b85e37e624 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -82,6 +82,8 @@ struct thread_struct {
 	unsigned long bad_cause;
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
+	struct pt_regs *trap_pt_regs;
+	struct __riscv_v_ext_state kernel_vstate;
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.h
index ef70af78005d..a54a0ce58f4d 100644
--- a/arch/riscv/include/asm/simd.h
+++ b/arch/riscv/include/asm/simd.h
@@ -12,6 +12,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
+#include <linux/thread_info.h>
 
 #ifdef CONFIG_RISCV_ISA_V
 
@@ -35,7 +36,8 @@ static __must_check inline bool may_use_simd(void)
 	 * where it is set.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-	       !this_cpu_read(vector_context_busy);
+	       !this_cpu_read(vector_context_busy) &&
+	       !test_thread_flag(TIF_RISCV_V_KERNEL_MODE);
 }
 
 #else /* ! CONFIG_RISCV_ISA_V */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index b182f2d03e25..8797d520e8ef 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -94,6 +94,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
+#define TIF_RISCV_V_KERNEL_MODE			13 /* kernel-mode Vector run with preemption-on */
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -101,9 +102,12 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+#define _TIF_RISCV_V_KERNEL_MODE	(1 << TIF_RISCV_V_KERNEL_MODE)
 
 #define _TIF_WORK_MASK \
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
 
+#define RISCV_V_VSTATE_CTRL_PREEMPTIBLE	0x20
+
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 9b818aac8a94..9fb2dea66abd 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -196,9 +196,24 @@ static inline void __switch_to_vector(struct task_struct *prev,
 {
 	struct pt_regs *regs;
 
-	regs = task_pt_regs(prev);
-	riscv_v_vstate_save(&prev->thread.vstate, regs);
-	riscv_v_vstate_set_restore(next, task_pt_regs(next));
+	if (IS_ENABLED(CONFIG_RISCV_ISA_V_PREEMPTIVE) &&
+	    test_tsk_thread_flag(prev, TIF_RISCV_V_KERNEL_MODE)) {
+		regs = prev->thread.trap_pt_regs;
+		WARN_ON(!regs);
+		riscv_v_vstate_save(&prev->thread.kernel_vstate, regs);
+	} else {
+		regs = task_pt_regs(prev);
+		riscv_v_vstate_save(&prev->thread.vstate, regs);
+	}
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_V_PREEMPTIVE) &&
+	    test_tsk_thread_flag(next, TIF_RISCV_V_KERNEL_MODE)) {
+		regs = next->thread.trap_pt_regs;
+		WARN_ON(!regs);
+		riscv_v_vstate_restore(&next->thread.kernel_vstate, regs);
+	} else {
+		riscv_v_vstate_set_restore(next, task_pt_regs(next));
+	}
 }
 
 void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
@@ -223,4 +238,10 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 
 #endif /* CONFIG_RISCV_ISA_V */
 
+#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
+void kernel_vector_allow_preemption(void);
+#else
+#define kernel_vector_allow_preemption()	do {} while (0)
+#endif
+
 #endif /* ! __ASM_RISCV_VECTOR_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index d6a75aac1d27..4b062f7741b2 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -38,6 +38,8 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+	OFFSET(TASK_THREAD_TRAP_REGP, task_struct, thread.trap_pt_regs);
+	OFFSET(TASK_THREAD_VSTATE_CTRL, task_struct, thread.vstate_ctrl);
 
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..b6a7d4e9f526 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -66,6 +66,29 @@ _save_context:
 	REG_S s4, PT_CAUSE(sp)
 	REG_S s5, PT_TP(sp)
 
+#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
+	/*
+	 * Record the register set at the frame where in-kernel V registers are
+	 * last alive.
+	 */
+	REG_L s0, TASK_TI_FLAGS(tp)
+	li s1, 1 << TIF_RISCV_V_KERNEL_MODE
+	and s0, s0, s1
+	beqz s0, 1f
+	li s0, TASK_THREAD_TRAP_REGP
+	add s0, s0, tp
+	REG_L s1, (s0)
+	bnez s1, 1f
+	REG_S sp, (s0)
+	li s0, TASK_THREAD_VSTATE_CTRL
+	add s0, s0, tp
+	REG_L s1, (s0)
+	li s2, ~RISCV_V_VSTATE_CTRL_PREEMPTIBLE
+	and s1, s1, s2
+	REG_S s1, (s0)
+1:
+#endif
+
 	/*
 	 * Set the scratch register to 0, so that if a recursive exception
 	 * occurs, the exception vector knows it came from the kernel
@@ -129,6 +152,28 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 */
 	csrw CSR_SCRATCH, tp
 1:
+#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
+	/*
+	 * Clear tracking of the trap registers when we return to the frame
+	 * that uses kernel mode Vector.
+	 */
+	REG_L s0, TASK_TI_FLAGS(tp)
+	li s1, 1 << TIF_RISCV_V_KERNEL_MODE
+	and s0, s0, s1
+	beqz s0, 1f
+	li s0, TASK_THREAD_TRAP_REGP
+	add s0, s0, tp
+	REG_L s1, (s0)
+	bne s1, sp, 1f
+	REG_S x0, (s0)
+	li s0, TASK_THREAD_VSTATE_CTRL
+	add s0, s0, tp
+	REG_L s1, (s0)
+	ori s1, s1, RISCV_V_VSTATE_CTRL_PREEMPTIBLE
+	REG_S s1, (s0)
+1:
+#endif
+
 	REG_L a0, PT_STATUS(sp)
 	/*
 	 * The current load reservation is effectively part of the processor's
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index d9e097e68937..5c64f2034cdc 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -10,6 +10,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/types.h>
+#include <linux/slab.h>
 
 #include <asm/vector.h>
 #include <asm/switch_to.h>
@@ -48,6 +49,44 @@ static void put_cpu_vector_context(void)
 	preempt_enable();
 }
 
+#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
+void kernel_vector_allow_preemption(void)
+{
+	current->thread.vstate_ctrl |= RISCV_V_VSTATE_CTRL_PREEMPTIBLE;
+}
+
+static bool kernel_vector_preemptible(void)
+{
+	return !!(current->thread.vstate_ctrl & RISCV_V_VSTATE_CTRL_PREEMPTIBLE);
+}
+
+static int riscv_v_start_kernel_context(void)
+{
+	struct __riscv_v_ext_state *vstate;
+
+	vstate = &current->thread.kernel_vstate;
+	if (!vstate->datap) {
+		vstate->datap = kmalloc(riscv_v_vsize, GFP_KERNEL);
+		if (!vstate->datap)
+			return -ENOMEM;
+	}
+
+	current->thread.trap_pt_regs = NULL;
+	WARN_ON(test_and_set_thread_flag(TIF_RISCV_V_KERNEL_MODE));
+	return 0;
+}
+
+static void riscv_v_stop_kernel_context(void)
+{
+	WARN_ON(!test_and_clear_thread_flag(TIF_RISCV_V_KERNEL_MODE));
+	current->thread.trap_pt_regs = NULL;
+}
+#else
+#define kernel_vector_preemptible()	(false)
+#define riscv_v_start_kernel_context()	(0)
+#define riscv_v_stop_kernel_context()	do {} while (0)
+#endif /* CONFIG_RISCV_ISA_V_PREEMPTIVE */
+
 /*
  * kernel_vector_begin(): obtain the CPU vector registers for use by the calling
  * context
@@ -70,11 +109,14 @@ void kernel_vector_begin(void)
 
 	riscv_v_vstate_save(&current->thread.vstate, task_pt_regs(current));
 
-	get_cpu_vector_context();
+	if (!preemptible() || !kernel_vector_preemptible()) {
+		get_cpu_vector_context();
+	} else {
+		if (riscv_v_start_kernel_context())
+			get_cpu_vector_context();
+	}
 
 	riscv_v_enable();
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(kernel_vector_begin);
 
@@ -96,6 +138,9 @@ void kernel_vector_end(void)
 
 	riscv_v_disable();
 
-	put_cpu_vector_context();
+	if (!test_thread_flag(TIF_RISCV_V_KERNEL_MODE))
+		put_cpu_vector_context();
+	else
+		riscv_v_stop_kernel_context();
 }
 EXPORT_SYMBOL_GPL(kernel_vector_end);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index ec89e7edb6fd..18cb37c305ab 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -160,8 +160,11 @@ void flush_thread(void)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	/* Free the vector context of datap. */
-	if (has_vector())
+	if (has_vector()) {
 		kfree(tsk->thread.vstate.datap);
+		if (IS_ENABLED(CONFIG_RISCV_ISA_V_PREEMPTIVE))
+			kfree(tsk->thread.kernel_vstate.datap);
+	}
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
@@ -170,7 +173,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	*dst = *src;
 	/* clear entire V context, including datap for a new task */
 	memset(&dst->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
+	memset(&dst->thread.kernel_vstate, 0, sizeof(struct __riscv_v_ext_state));
 	clear_tsk_thread_flag(dst, TIF_RISCV_V_DEFER_RESTORE);
+	clear_tsk_thread_flag(dst, TIF_RISCV_V_KERNEL_MODE);
 
 	return 0;
 }
@@ -205,6 +210,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		childregs->a0 = 0; /* Return value of fork() */
 		p->thread.s[0] = 0;
 	}
+	kernel_vector_allow_preemption();
 	p->thread.ra = (unsigned long)ret_from_fork;
 	p->thread.sp = (unsigned long)childregs; /* kernel sp */
 	return 0;
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 9d583b760db4..42f227077ee5 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -122,7 +122,8 @@ static inline void riscv_v_ctrl_set(struct task_struct *tsk, int cur, int nxt,
 	ctrl |= VSTATE_CTRL_MAKE_NEXT(nxt);
 	if (inherit)
 		ctrl |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
-	tsk->thread.vstate_ctrl = ctrl;
+	tsk->thread.vstate_ctrl &= ~PR_RISCV_V_VSTATE_CTRL_MASK;
+	tsk->thread.vstate_ctrl |= ctrl;
 }
 
 bool riscv_v_vstate_ctrl_user_allowed(void)
-- 
2.39.2

