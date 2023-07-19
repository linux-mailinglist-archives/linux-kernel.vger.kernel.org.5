Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152E175A259
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGSWsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGSWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E752101;
        Wed, 19 Jul 2023 15:47:33 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HcJtl/lDJvwYrsv2/7sLKLHfN7xWMLiYme8gtQ0Lf6Q=;
        b=pZRfo35K7PHWfaxSC3cppXQxbr5X3R4qncUSSvNJ3CuZRPjFYhSAL370rooOTe9HPU4y47
        V4q6T4owdEUnnTNwfeaw6g0ohhdyDBqe7T+6CJW70RXEwu4Xgt2veyDR/YFqEZXyTbsUqW
        AG3Yoh5OABsmJX0m5L9duh9rTuiMnKxd89NF7zg+nDl9zSZt2M0x0x+K7ifAJs2VOhJmum
        BLH3kabndYnpqzmw6jTdttImXwh/t3EQvQtvThjwn5a0XuYO/44Ms+ub9uW1k+4eE6iDTg
        8HuBjQ8sqIRyQIlpt7Pd3kWGnoZET8fCTELmP0KjfYx6WgXfxKYFvn7m3ipH4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HcJtl/lDJvwYrsv2/7sLKLHfN7xWMLiYme8gtQ0Lf6Q=;
        b=YobHdytbOEa20OaSC/SUTvYtGPfPsoKssRk6i7eyYUpO0gPCi18XGPZWRBZ2nTUntwP/2E
        lqmfTsmDl6JajyCA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Handle thread shadow stack
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685148.28540.10037240289753804658.tip-bot2@tip-bot2>
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

Commit-ID:     6b15802b17d29ff3bc90d89c1503b5210b04b888
Gitweb:        https://git.kernel.org/tip/6b15802b17d29ff3bc90d89c1503b5210b04b888
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:55 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:50 -07:00

x86/shstk: Handle thread shadow stack

When a process is duplicated, but the child shares the address space with
the parent, there is potential for the threads sharing a single stack to
cause conflicts for each other. In the normal non-CET case this is handled
in two ways.

With regular CLONE_VM a new stack is provided by userspace such that the
parent and child have different stacks.

For vfork, the parent is suspended until the child exits. So as long as
the child doesn't return from the vfork()/CLONE_VFORK calling function and
sticks to a limited set of operations, the parent and child can share the
same stack.

For shadow stack, these scenarios present similar sharing problems. For the
CLONE_VM case, the child and the parent must have separate shadow stacks.
Instead of changing clone to take a shadow stack, have the kernel just
allocate one and switch to it.

Use stack_size passed from clone3() syscall for thread shadow stack size. A
compat-mode thread shadow stack size is further reduced to 1/4. This
allows more threads to run in a 32-bit address space. The clone() does not
pass stack_size, which was added to clone3(). In that case, use
RLIMIT_STACK size and cap to 4 GB.

For shadow stack enabled vfork(), the parent and child can share the same
shadow stack, like they can share a normal stack. Since the parent is
suspended until the child terminates, the child will not interfere with
the parent while executing as long as it doesn't return from the vfork()
and overwrite up the shadow stack. The child can safely overwrite down
the shadow stack, as the parent can just overwrite this later. So CET does
not add any additional limitations for vfork().

Free the shadow stack on thread exit by doing it in mm_release(). Skip
this when exiting a vfork() child since the stack is shared in the
parent.

During this operation, the shadow stack pointer of the new thread needs
to be updated to point to the newly allocated shadow stack. Since the
ability to do this is confined to the FPU subsystem, change
fpu_clone() to take the new shadow stack pointer, and update it
internally inside the FPU subsystem. This part was suggested by Thomas
Gleixner.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-30-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/fpu/sched.h   |  3 +-
 arch/x86/include/asm/mmu_context.h |  2 +-
 arch/x86/include/asm/shstk.h       |  5 ++++-
 arch/x86/kernel/fpu/core.c         | 36 ++++++++++++++++++++++++-
 arch/x86/kernel/process.c          | 21 ++++++++++++++-
 arch/x86/kernel/shstk.c            | 41 +++++++++++++++++++++++++++--
 6 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index 78fcde7..ca6e5e5 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -11,7 +11,8 @@
 
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 extern void fpu__drop(struct fpu *fpu);
-extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal);
+extern int  fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
+		      unsigned long shstk_addr);
 extern void fpu_flush_thread(void);
 
 /*
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 1d29dc7..416901d 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -186,6 +186,8 @@ do {						\
 #else
 #define deactivate_mm(tsk, mm)			\
 do {						\
+	if (!tsk->vfork_done)			\
+		shstk_free(tsk);		\
 	load_gs_index(0);			\
 	loadsegment(fs, 0);			\
 } while (0)
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 2b1f7c9..d4a5c7b 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -15,11 +15,16 @@ struct thread_shstk {
 
 long shstk_prctl(struct task_struct *task, int option, unsigned long features);
 void reset_thread_features(void);
+unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
+				       unsigned long stack_size);
 void shstk_free(struct task_struct *p);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
+static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
+						     unsigned long clone_flags,
+						     unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 375852c..e03b6b1 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -552,8 +552,36 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 	}
 }
 
+/* A passed ssp of zero will not cause any update */
+static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
+{
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	struct cet_user_state *xstate;
+
+	/* If ssp update is not needed. */
+	if (!ssp)
+		return 0;
+
+	xstate = get_xsave_addr(&dst->thread.fpu.fpstate->regs.xsave,
+				XFEATURE_CET_USER);
+
+	/*
+	 * If there is a non-zero ssp, then 'dst' must be configured with a shadow
+	 * stack and the fpu state should be up to date since it was just copied
+	 * from the parent in fpu_clone(). So there must be a valid non-init CET
+	 * state location in the buffer.
+	 */
+	if (WARN_ON_ONCE(!xstate))
+		return 1;
+
+	xstate->user_ssp = (u64)ssp;
+#endif
+	return 0;
+}
+
 /* Clone current's FPU state on fork */
-int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
+int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
+	      unsigned long ssp)
 {
 	struct fpu *src_fpu = &current->thread.fpu;
 	struct fpu *dst_fpu = &dst->thread.fpu;
@@ -613,6 +641,12 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 	if (use_xsave())
 		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
 
+	/*
+	 * Update shadow stack pointer, in case it changed during clone.
+	 */
+	if (update_fpu_shstk(dst, ssp))
+		return 1;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ff9b80a..cc7a642 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -50,6 +50,7 @@
 #include <asm/unwind.h>
 #include <asm/tdx.h>
 #include <asm/mmu_context.h>
+#include <asm/shstk.h>
 
 #include "process.h"
 
@@ -121,6 +122,7 @@ void exit_thread(struct task_struct *tsk)
 
 	free_vm86(t);
 
+	shstk_free(tsk);
 	fpu__drop(fpu);
 }
 
@@ -142,6 +144,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	struct inactive_task_frame *frame;
 	struct fork_frame *fork_frame;
 	struct pt_regs *childregs;
+	unsigned long new_ssp;
 	int ret = 0;
 
 	childregs = task_pt_regs(p);
@@ -179,7 +182,16 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
-	fpu_clone(p, clone_flags, args->fn);
+	/*
+	 * Allocate a new shadow stack for thread if needed. If shadow stack,
+	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
+	 * update it.
+	 */
+	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+	if (IS_ERR_VALUE(new_ssp))
+		return PTR_ERR((void *)new_ssp);
+
+	fpu_clone(p, clone_flags, args->fn, new_ssp);
 
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
@@ -225,6 +237,13 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
 		io_bitmap_share(p);
 
+	/*
+	 * If copy_thread() if failing, don't leak the shadow stack possibly
+	 * allocated in shstk_alloc_thread_stack() above.
+	 */
+	if (ret)
+		shstk_free(p);
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 3cb8522..bd9cdc3 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -47,7 +47,7 @@ static unsigned long alloc_shstk(unsigned long size)
 	unsigned long addr, unused;
 
 	mmap_write_lock(mm);
-	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
 		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
 
 	mmap_write_unlock(mm);
@@ -126,6 +126,37 @@ void reset_thread_features(void)
 	current->thread.features_locked = 0;
 }
 
+unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
+				       unsigned long stack_size)
+{
+	struct thread_shstk *shstk = &tsk->thread.shstk;
+	unsigned long addr, size;
+
+	/*
+	 * If shadow stack is not enabled on the new thread, skip any
+	 * switch to a new shadow stack.
+	 */
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	/*
+	 * For CLONE_VM, except vfork, the child needs a separate shadow
+	 * stack.
+	 */
+	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
+		return 0;
+
+	size = adjust_shstk_size(stack_size);
+	addr = alloc_shstk(size);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	shstk->base = addr;
+	shstk->size = size;
+
+	return addr + size;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
@@ -134,7 +165,13 @@ void shstk_free(struct task_struct *tsk)
 	    !features_enabled(ARCH_SHSTK_SHSTK))
 		return;
 
-	if (!tsk->mm)
+	/*
+	 * When fork() with CLONE_VM fails, the child (tsk) already has a
+	 * shadow stack allocated, and exit_thread() calls this function to
+	 * free it.  In this case the parent (current) and the child share
+	 * the same mm struct.
+	 */
+	if (!tsk->mm || tsk->mm != current->mm)
 		return;
 
 	unmap_shadow_stack(shstk->base, shstk->size);
