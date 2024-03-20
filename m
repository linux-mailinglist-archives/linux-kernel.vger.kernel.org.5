Return-Path: <linux-kernel+bounces-108937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9D881239
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69A81C2337B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22344C92;
	Wed, 20 Mar 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG5K0Pr1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BBE42057
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940768; cv=none; b=GCTSo2Vlu3N4K+pLKLJq966WpGYEQhuecy+pj3p7MfErGN1D+O3Hxe/X181PNYqAa5aihSGXx+4arZlzDZ/1Lsz0hRq/dcieJm+bkSmwJz077uDpkGvzoOFSwxYsmbMPHHR/rYmb5ypHwbOobzkoNSc3QcezfOFhx+dTB1E3Sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940768; c=relaxed/simple;
	bh=ausMwHJXpvTk41K07x9OYY60cAwk1gecRSszn1W+ieM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovvKBzJKWskMS9C9I/LrhkezJcPB00EMjwPNcRaYRI7U7pS92Z+ivmG1lYeiBL0Owg+yHpmgQfUOyoIVToYO+BF9VfTgNdd9e2puCRZLe7yIoMg7aFifN3IzX8flc7uYI1dz1LnlyX5VdBl2AV3IwCwfOFkqLhJSZgoGfcV/FN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG5K0Pr1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4146f26cdffso1417675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710940764; x=1711545564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBqK9mVDHnM4irUED4XCXmmSzkSmKldZzK6+oRs4PJ8=;
        b=iG5K0Pr1tZ8FnODSfQpE3ox8+iGrCIWjlXk62J235x65fpS7NKlKTEWOZE/x+J7STz
         Ml4DE4cG6RyXQaZLpuVlInT0vaQGXxorn/JfI1GTttKX7TjrXvTh+dkd7XzqlggR/t0W
         4xfKz6MOkULfrH1g09o2PLvhkbOdAk3luR4cORlhl2keVlyscm+EhHi6O/qOkIcBRDCb
         ski6kHP480xu18hWsF7tpMa6mEXcqv1tdo/JvpRd6R4pox8VAwaxiFDOmfsir3Wr7vAG
         CiTzR3igfadHw1681ARz8YGb/KKOb8OxsrimSKr6zIAgKB5CU2M+D56h1ty6OB1vrC2m
         VKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710940764; x=1711545564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBqK9mVDHnM4irUED4XCXmmSzkSmKldZzK6+oRs4PJ8=;
        b=n7oFDElkBz12G3JDbdi4aRhLVG6hqddYR1ERpsSOIuXCelWLy76J+l1S+vEU/MLDZi
         9RoiOCQlfxy4XpvFhP3EMr+s/2t9KDxVzpQVmJm6nIIH1mN9xzI83IFatIqI5Ka2XyhW
         EtzfHf/b8Pda1XwI7z4M87dUxGVXsQe7SVRhmtPMcnuSUhLde4eBbUjDgP0TqP9j6WQN
         +BIMdyDZKn+uXGn9AjSov646aUYJet0tmIp/ZrH0EnVq9vBujDQ7s8J/7gBbdLcpfN0m
         RBbCWq6gn4IZLTWfNj05c0M1tRnE34ortm+Ga/81wsjm+bFBtLR/754afQI/8bco8Gzh
         g1oQ==
X-Gm-Message-State: AOJu0YxUctsF+C4rZbxpMIy3tI8dyqSELsicprK6Sdth1gzOWG7UF+Ek
	5+ZRHMryNEFCRQOb74B3RiDJ6kxx4BSZqOHPHGCy+lmDAtjVkz66ScW7+/wggcE=
X-Google-Smtp-Source: AGHT+IFYbHYrtgHpC/Jm2MWz21Gz7k5KVooQp+SH7g7jdXEat22Bm9EiPlDowPmVxb84uRjRlWPQOw==
X-Received: by 2002:a05:600c:3c8a:b0:414:d95:cc47 with SMTP id bg10-20020a05600c3c8a00b004140d95cc47mr4780976wmb.30.1710940763526;
        Wed, 20 Mar 2024 06:19:23 -0700 (PDT)
Received: from kepler.redhat.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00414621c77f9sm2247072wmq.1.2024.03.20.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:19:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 1/1] headers/deps: x86/fpu: Make task_struct::thread constant size
Date: Wed, 20 Mar 2024 14:19:08 +0100
Message-Id: <20240320131908.2708438-2-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320131908.2708438-1-mingo@kernel.org>
References: <20240320131908.2708438-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn thread.fpu into a pointer. Since most FPU code internals work by passing
around the FPU pointer already, the code generation impact is small.

This allows us to remove the old kludge of task_struct being variable size:

  struct task_struct {

       ...
       /*
        * New fields for task_struct should be added above here, so that
        * they are included in the randomized portion of task_struct.
        */
       randomized_struct_fields_end

       /* CPU-specific state of this task: */
       struct thread_struct            thread;

       /*
        * WARNING: on x86, 'thread_struct' contains a variable-sized
        * structure.  It *MUST* be at the end of 'task_struct'.
        *
        * Do not put anything below here!
        */
  };

.. which creates a number of problems, such as requiring thread_struct to be
the last member of the struct - not allowing it to be struct-randomized, etc.

But the primary motivation is to allow the decoupling of task_struct from
hardware details (<asm/processor.h> in particular), and to eventually allow
the per-task infrastructure:

   DECLARE_PER_TASK(type, name);
   ...
   per_task(current, name) = val;

.. which requires task_struct to be a constant size struct.

The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
now that the FPU structure is not embedded in the task struct anymore, which
reduces text footprint a bit.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/include/asm/processor.h | 14 ++++++--------
 arch/x86/kernel/fpu/context.h    |  4 ++--
 arch/x86/kernel/fpu/core.c       | 51 ++++++++++++++++++++++++++-------------------------
 arch/x86/kernel/fpu/init.c       | 28 ++++++++++++++++++----------
 arch/x86/kernel/fpu/regset.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/signal.c     | 18 +++++++++---------
 arch/x86/kernel/fpu/xstate.c     | 22 +++++++++++-----------
 arch/x86/kernel/fpu/xstate.h     |  6 +++---
 arch/x86/kernel/process.c        |  6 +++---
 arch/x86/kernel/signal.c         |  6 +++---
 arch/x86/kernel/traps.c          |  2 +-
 arch/x86/math-emu/fpu_aux.c      |  2 +-
 arch/x86/math-emu/fpu_entry.c    |  4 ++--
 arch/x86/math-emu/fpu_system.h   |  2 +-
 arch/x86/mm/extable.c            |  2 +-
 include/linux/sched.h            | 13 +++----------
 17 files changed, 102 insertions(+), 102 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index c485f1944c5f..3cf20ab49b5f 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -41,7 +41,7 @@ static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
 	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
-		struct fpu *old_fpu = &old->thread.fpu;
+		struct fpu *old_fpu = old->thread.fpu;
 
 		save_fpregs_to_fpstate(old_fpu);
 		/*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..151880f2b079 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -491,19 +491,17 @@ struct thread_struct {
 #endif
 
 	/* Floating point and extended processor state */
-	struct fpu		fpu;
-	/*
-	 * WARNING: 'fpu' is dynamically-sized.  It *MUST* be at
-	 * the end.
-	 */
+	struct fpu		*fpu;
 };
 
-extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
-
+/*
+ * X86 doesn't need any embedded-FPU-struct quirks:
+ */
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
-	fpu_thread_struct_whitelist(offset, size);
+	*offset = 0;
+	*size = 0;
 }
 
 static inline void
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index f6d856bd50bc..96d1f34179b3 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -53,7 +53,7 @@ static inline void fpregs_activate(struct fpu *fpu)
 /* Internal helper for switch_fpu_return() and signal frame setup */
 static inline void fpregs_restore_userregs(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 	int cpu = smp_processor_id();
 
 	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
@@ -67,7 +67,7 @@ static inline void fpregs_restore_userregs(void)
 		 * If PKRU is enabled, then the PKRU value is already
 		 * correct because it was either set in switch_to() or in
 		 * flush_thread(). So it is excluded because it might be
-		 * not up to date in current->thread.fpu.xsave state.
+		 * not up to date in current->thread.fpu->xsave state.
 		 *
 		 * XFD state is handled in restore_fpregs_from_fpstate().
 		 */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 520deb411a70..93a45de0c67f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -204,7 +204,7 @@ static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
 		return;
 
 	spin_lock_irq(&current->sighand->siglock);
-	fpuperm = &current->group_leader->thread.fpu.guest_perm;
+	fpuperm = &current->group_leader->thread.fpu->guest_perm;
 	perm = fpuperm->__state_perm;
 
 	/* First fpstate allocation locks down permissions. */
@@ -316,7 +316,7 @@ EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
  */
 void fpu_sync_guest_vmexit_xfd_state(void)
 {
-	struct fpstate *fps = current->thread.fpu.fpstate;
+	struct fpstate *fps = current->thread.fpu->fpstate;
 
 	lockdep_assert_irqs_disabled();
 	if (fpu_state_size_dynamic()) {
@@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(fpu_sync_guest_vmexit_xfd_state);
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 {
 	struct fpstate *guest_fps = guest_fpu->fpstate;
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 	struct fpstate *cur_fps = fpu->fpstate;
 
 	fpregs_lock();
@@ -430,7 +430,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(&current->thread.fpu);
+		save_fpregs_to_fpstate(current->thread.fpu);
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -458,7 +458,7 @@ EXPORT_SYMBOL_GPL(kernel_fpu_end);
  */
 void fpu_sync_fpstate(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu);
+	WARN_ON_FPU(fpu != current->thread.fpu);
 
 	fpregs_lock();
 	trace_x86_fpu_before_save(fpu);
@@ -543,7 +543,7 @@ void fpstate_reset(struct fpu *fpu)
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 {
 	if (fpu_state_size_dynamic()) {
-		struct fpu *src_fpu = &current->group_leader->thread.fpu;
+		struct fpu *src_fpu = current->group_leader->thread.fpu;
 
 		spin_lock_irq(&current->sighand->siglock);
 		/* Fork also inherits the permissions of the parent */
@@ -563,7 +563,7 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 	if (!ssp)
 		return 0;
 
-	xstate = get_xsave_addr(&dst->thread.fpu.fpstate->regs.xsave,
+	xstate = get_xsave_addr(&dst->thread.fpu->fpstate->regs.xsave,
 				XFEATURE_CET_USER);
 
 	/*
@@ -584,8 +584,19 @@ static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
 int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	      unsigned long ssp)
 {
-	struct fpu *src_fpu = &current->thread.fpu;
-	struct fpu *dst_fpu = &dst->thread.fpu;
+	/*
+	 * We allocate the new FPU structure right after the end of the task struct.
+	 * task allocation size already took this into account.
+	 *
+	 * This is safe because task_struct size is a multiple of cacheline size.
+	 */
+	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
+	struct fpu *src_fpu = current->thread.fpu;
+
+	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
+	BUG_ON(!src_fpu);
+
+	dst->thread.fpu = dst_fpu;
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -654,16 +665,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	return 0;
 }
 
-/*
- * Whitelist the FPU register state embedded into task_struct for hardened
- * usercopy.
- */
-void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
-{
-	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
-	*size = fpu_kernel_cfg.default_size;
-}
-
 /*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
@@ -677,7 +678,7 @@ void fpu__drop(struct fpu *fpu)
 {
 	preempt_disable();
 
-	if (fpu == &current->thread.fpu) {
+	if (fpu == current->thread.fpu) {
 		/* Ignore delayed exceptions from user space */
 		asm volatile("1: fwait\n"
 			     "2:\n"
@@ -711,7 +712,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
  */
 static void fpu_reset_fpregs(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 
 	fpregs_lock();
 	__fpu_invalidate_fpregs_state(fpu);
@@ -740,7 +741,7 @@ static void fpu_reset_fpregs(void)
  */
 void fpu__clear_user_states(struct fpu *fpu)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu);
+	WARN_ON_FPU(fpu != current->thread.fpu);
 
 	fpregs_lock();
 	if (!cpu_feature_enabled(X86_FEATURE_FPU)) {
@@ -773,7 +774,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 
 void fpu_flush_thread(void)
 {
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(current->thread.fpu);
 	fpu_reset_fpregs();
 }
 /*
@@ -814,7 +815,7 @@ void fpregs_lock_and_load(void)
  */
 void fpregs_assert_state_consistent(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		return;
@@ -826,7 +827,7 @@ EXPORT_SYMBOL_GPL(fpregs_assert_state_consistent);
 
 void fpregs_mark_activate(void)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 
 	fpregs_activate(fpu);
 	fpu->last_cpu = smp_processor_id();
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 998a08f17e33..f9412d012191 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
+		fpstate_init_soft(current->thread.fpu->fpstate->regs.soft);
 	else
 #endif
 		asm volatile ("fninit");
@@ -71,8 +71,19 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
+static struct fpu x86_init_fpu __read_mostly;
+
 static void __init fpu__init_system_early_generic(void)
 {
+	{
+		int this_cpu = smp_processor_id();
+
+		fpstate_reset(&x86_init_fpu);
+		current->thread.fpu = &x86_init_fpu;
+		per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
+		x86_init_fpu.last_cpu = this_cpu;
+	}
+
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
 		if (fpu__probe_without_cpuid())
@@ -150,11 +161,13 @@ static void __init fpu__init_task_struct_size(void)
 {
 	int task_size = sizeof(struct task_struct);
 
+	task_size += sizeof(struct fpu);
+
 	/*
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(current->thread.fpu.__fpstate.regs);
+	task_size -= sizeof(current->thread.fpu->__fpstate.regs);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -164,14 +177,9 @@ static void __init fpu__init_task_struct_size(void)
 
 	/*
 	 * We dynamically size 'struct fpu', so we require that
-	 * it be at the end of 'thread_struct' and that
-	 * 'thread_struct' be at the end of 'task_struct'.  If
-	 * you hit a compile error here, check the structure to
-	 * see if something got added to the end.
+	 * 'state' be at the end of 'it:
 	 */
 	CHECK_MEMBER_AT_END_OF(struct fpu, __fpstate);
-	CHECK_MEMBER_AT_END_OF(struct thread_struct, fpu);
-	CHECK_MEMBER_AT_END_OF(struct task_struct, thread);
 
 	arch_task_struct_size = task_size;
 }
@@ -204,7 +212,7 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(current->thread.fpu);
 }
 
 /*
@@ -213,8 +221,8 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 void __init fpu__init_system(void)
 {
-	fpstate_reset(&current->thread.fpu);
 	fpu__init_system_early_generic();
+	fpstate_reset(current->thread.fpu);
 
 	/*
 	 * The FPU has to be operational for some of the
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6bc1eb2a21bd..38bc0b390d02 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -45,7 +45,7 @@ int regset_xregset_fpregs_active(struct task_struct *target, const struct user_r
  */
 static void sync_fpstate(struct fpu *fpu)
 {
-	if (fpu == &current->thread.fpu)
+	if (fpu == current->thread.fpu)
 		fpu_sync_fpstate(fpu);
 }
 
@@ -63,7 +63,7 @@ static void fpu_force_restore(struct fpu *fpu)
 	 * Only stopped child tasks can be used to modify the FPU
 	 * state in the fpstate buffer:
 	 */
-	WARN_ON_FPU(fpu == &current->thread.fpu);
+	WARN_ON_FPU(fpu == current->thread.fpu);
 
 	__fpu_invalidate_fpregs_state(fpu);
 }
@@ -71,7 +71,7 @@ static void fpu_force_restore(struct fpu *fpu)
 int xfpregs_get(struct task_struct *target, const struct user_regset *regset,
 		struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 
 	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
@@ -91,7 +91,7 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 		unsigned int pos, unsigned int count,
 		const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 	struct fxregs_state newstate;
 	int ret;
 
@@ -133,7 +133,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	sync_fpstate(&target->thread.fpu);
+	sync_fpstate(target->thread.fpu);
 
 	copy_xstate_to_uabi_buf(to, target, XSTATE_COPY_XSAVE);
 	return 0;
@@ -143,7 +143,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 	struct xregs_state *tmpbuf = NULL;
 	int ret;
 
@@ -187,7 +187,7 @@ int ssp_active(struct task_struct *target, const struct user_regset *regset)
 int ssp_get(struct task_struct *target, const struct user_regset *regset,
 	    struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 	struct cet_user_state *cetregs;
 
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -213,7 +213,7 @@ int ssp_set(struct task_struct *target, const struct user_regset *regset,
 	    unsigned int pos, unsigned int count,
 	    const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
 	struct cet_user_state *cetregs;
 	unsigned long user_ssp;
@@ -367,7 +367,7 @@ static void __convert_from_fxsr(struct user_i387_ia32_struct *env,
 void
 convert_from_fxsr(struct user_i387_ia32_struct *env, struct task_struct *tsk)
 {
-	__convert_from_fxsr(env, tsk, &tsk->thread.fpu.fpstate->regs.fxsave);
+	__convert_from_fxsr(env, tsk, &tsk->thread.fpu->fpstate->regs.fxsave);
 }
 
 void convert_to_fxsr(struct fxregs_state *fxsave,
@@ -400,7 +400,7 @@ void convert_to_fxsr(struct fxregs_state *fxsave,
 int fpregs_get(struct task_struct *target, const struct user_regset *regset,
 	       struct membuf to)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 	struct user_i387_ia32_struct env;
 	struct fxregs_state fxsave, *fx;
 
@@ -432,7 +432,7 @@ int fpregs_set(struct task_struct *target, const struct user_regset *regset,
 	       unsigned int pos, unsigned int count,
 	       const void *kbuf, const void __user *ubuf)
 {
-	struct fpu *fpu = &target->thread.fpu;
+	struct fpu *fpu = target->thread.fpu;
 	struct user_i387_ia32_struct env;
 	int ret;
 
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f2225aa9f..6b262d0b8fc1 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -38,7 +38,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	/* Check for the first magic field and other error scenarios. */
 	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
 	    fx_sw->xstate_size < min_xstate_size ||
-	    fx_sw->xstate_size > current->thread.fpu.fpstate->user_size ||
+	    fx_sw->xstate_size > current->thread.fpu->fpstate->user_size ||
 	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
 
@@ -54,7 +54,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
 		return true;
 setfx:
-	trace_x86_fpu_xstate_check_failed(&current->thread.fpu);
+	trace_x86_fpu_xstate_check_failed(current->thread.fpu);
 
 	/* Set the parameters for fx only state */
 	fx_sw->magic1 = 0;
@@ -69,13 +69,13 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
-		struct xregs_state *xsave = &tsk->thread.fpu.fpstate->regs.xsave;
+		struct xregs_state *xsave = &tsk->thread.fpu->fpstate->regs.xsave;
 		struct user_i387_ia32_struct env;
 		struct _fpstate_32 __user *fp = buf;
 
 		fpregs_lock();
 		if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-			fxsave(&tsk->thread.fpu.fpstate->regs.fxsave);
+			fxsave(&tsk->thread.fpu->fpstate->regs.fxsave);
 		fpregs_unlock();
 
 		convert_from_fxsr(&env, tsk);
@@ -188,7 +188,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct task_struct *tsk = current;
-	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
+	struct fpstate *fpstate = tsk->thread.fpu->fpstate;
 	bool ia32_fxstate = (buf != buf_fx);
 	int ret;
 
@@ -276,7 +276,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
  */
 static bool restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 	int ret;
 
 	/* Restore enabled features only. */
@@ -336,7 +336,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 			      bool ia32_fxstate)
 {
 	struct task_struct *tsk = current;
-	struct fpu *fpu = &tsk->thread.fpu;
+	struct fpu *fpu = tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
 	bool success, fx_only = false;
 	union fpregs_state *fpregs;
@@ -456,7 +456,7 @@ static inline unsigned int xstate_sigframe_size(struct fpstate *fpstate)
  */
 bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
 	bool success = false;
@@ -503,7 +503,7 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size)
 {
-	unsigned long frame_size = xstate_sigframe_size(current->thread.fpu.fpstate);
+	unsigned long frame_size = xstate_sigframe_size(current->thread.fpu->fpstate);
 
 	*buf_fx = sp = round_down(sp - frame_size, 64);
 	if (ia32_frame && use_fxsr()) {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..df442b2df55b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -734,7 +734,7 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	 */
 	init_fpstate.xfd = 0;
 
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(current->thread.fpu);
 }
 
 /*
@@ -844,7 +844,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 
 	/* Reset the state for the current task */
-	fpstate_reset(&current->thread.fpu);
+	fpstate_reset(current->thread.fpu);
 
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
@@ -918,7 +918,7 @@ void fpu__resume_cpu(void)
 	}
 
 	if (fpu_state_size_dynamic())
-		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
+		wrmsrl(MSR_IA32_XFD, current->thread.fpu->fpstate->xfd);
 }
 
 /*
@@ -1186,8 +1186,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			     enum xstate_copy_mode copy_mode)
 {
-	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu.fpstate,
-				  tsk->thread.fpu.fpstate->user_xfeatures,
+	__copy_xstate_to_uabi_buf(to, tsk->thread.fpu->fpstate,
+				  tsk->thread.fpu->fpstate->user_xfeatures,
 				  tsk->thread.pkru, copy_mode);
 }
 
@@ -1327,7 +1327,7 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u
 int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf, &tsk->thread.pkru);
+	return copy_uabi_to_xstate(tsk->thread.fpu->fpstate, NULL, ubuf, &tsk->thread.pkru);
 }
 
 static bool validate_independent_components(u64 mask)
@@ -1421,7 +1421,7 @@ static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
 	  * The XFD MSR does not match fpstate->xfd. That's invalid when
 	  * the passed in fpstate is current's fpstate.
 	  */
-	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
+	if (fpstate->xfd == current->thread.fpu->fpstate->xfd)
 		return false;
 
 	/*
@@ -1498,7 +1498,7 @@ void fpstate_free(struct fpu *fpu)
 static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 			   unsigned int usize, struct fpu_guest *guest_fpu)
 {
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 	struct fpstate *curfps, *newfps = NULL;
 	unsigned int fpsize;
 	bool in_use;
@@ -1591,7 +1591,7 @@ static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 	 * AVX512.
 	 */
 	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
-	struct fpu *fpu = &current->group_leader->thread.fpu;
+	struct fpu *fpu = current->group_leader->thread.fpu;
 	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
 	u64 mask;
@@ -1694,7 +1694,7 @@ int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
 		return -EPERM;
 	}
 
-	fpu = &current->group_leader->thread.fpu;
+	fpu = current->group_leader->thread.fpu;
 	perm = guest_fpu ? &fpu->guest_perm : &fpu->perm;
 	ksize = perm->__state_size;
 	usize = perm->__user_state_size;
@@ -1799,7 +1799,7 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
  */
 static void avx512_status(struct seq_file *m, struct task_struct *task)
 {
-	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
+	unsigned long timestamp = READ_ONCE(task->thread.fpu->avx512_timestamp);
 	long delta;
 
 	if (!timestamp) {
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3518fb26d06b..aca8a89bea84 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -22,7 +22,7 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 
 static inline u64 xstate_get_group_perm(bool guest)
 {
-	struct fpu *fpu = &current->group_leader->thread.fpu;
+	struct fpu *fpu = current->group_leader->thread.fpu;
 	struct fpu_state_perm *perm;
 
 	/* Pairs with WRITE_ONCE() in xstate_request_perm() */
@@ -261,7 +261,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	 * internally, e.g. PKRU. That's user space ABI and also required
 	 * to allow the signal handler to modify PKRU.
 	 */
-	struct fpstate *fpstate = current->thread.fpu.fpstate;
+	struct fpstate *fpstate = current->thread.fpu->fpstate;
 	u64 mask = fpstate->user_xfeatures;
 	u32 lmask;
 	u32 hmask;
@@ -292,7 +292,7 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
 	u32 hmask = mask >> 32;
 	int err;
 
-	xfd_validate_state(current->thread.fpu.fpstate, mask, true);
+	xfd_validate_state(current->thread.fpu->fpstate, mask, true);
 
 	stac();
 	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..5f3f48713870 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -97,7 +97,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	dst->thread.vm86 = NULL;
 #endif
 	/* Drop the copied pointer to current's fpstate */
-	dst->thread.fpu.fpstate = NULL;
+	dst->thread.fpu = NULL;
 
 	return 0;
 }
@@ -106,7 +106,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	if (fpu_state_size_dynamic())
-		fpstate_free(&tsk->thread.fpu);
+		fpstate_free(tsk->thread.fpu);
 }
 #endif
 
@@ -116,7 +116,7 @@ void arch_release_task_struct(struct task_struct *tsk)
 void exit_thread(struct task_struct *tsk)
 {
 	struct thread_struct *t = &tsk->thread;
-	struct fpu *fpu = &t->fpu;
+	struct fpu *fpu = t->fpu;
 
 	if (test_thread_flag(TIF_IO_BITMAP))
 		io_bitmap_exit(tsk);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5dddfc2..7e709ae8e99a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -228,7 +228,7 @@ static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	bool stepping, failed;
-	struct fpu *fpu = &current->thread.fpu;
+	struct fpu *fpu = current->thread.fpu;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -396,14 +396,14 @@ bool sigaltstack_size_valid(size_t ss_size)
 	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
 		return true;
 
-	fsize += current->group_leader->thread.fpu.perm.__user_state_size;
+	fsize += current->group_leader->thread.fpu->perm.__user_state_size;
 	if (likely(ss_size > fsize))
 		return true;
 
 	if (strict_sigaltstack_size)
 		return ss_size > fsize;
 
-	mask = current->group_leader->thread.fpu.perm.__state_perm;
+	mask = current->group_leader->thread.fpu->perm.__state_perm;
 	if (mask & XFEATURE_MASK_USER_DYNAMIC)
 		return ss_size > fsize;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..c79e36c4071b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1148,7 +1148,7 @@ DEFINE_IDTENTRY_RAW(exc_debug)
 static void math_error(struct pt_regs *regs, int trapnr)
 {
 	struct task_struct *task = current;
-	struct fpu *fpu = &task->thread.fpu;
+	struct fpu *fpu = task->thread.fpu;
 	int si_code;
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
diff --git a/arch/x86/math-emu/fpu_aux.c b/arch/x86/math-emu/fpu_aux.c
index d62662bdd460..8087953164fc 100644
--- a/arch/x86/math-emu/fpu_aux.c
+++ b/arch/x86/math-emu/fpu_aux.c
@@ -53,7 +53,7 @@ void fpstate_init_soft(struct swregs_state *soft)
 
 void finit(void)
 {
-	fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
+	fpstate_init_soft(&current->thread.fpu->fpstate->regs.soft);
 }
 
 /*
diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
index 91c52ead1226..30400d95d9d0 100644
--- a/arch/x86/math-emu/fpu_entry.c
+++ b/arch/x86/math-emu/fpu_entry.c
@@ -641,7 +641,7 @@ int fpregs_soft_set(struct task_struct *target,
 		    unsigned int pos, unsigned int count,
 		    const void *kbuf, const void __user *ubuf)
 {
-	struct swregs_state *s387 = &target->thread.fpu.fpstate->regs.soft;
+	struct swregs_state *s387 = &target->thread.fpu->fpstate->regs.soft;
 	void *space = s387->st_space;
 	int ret;
 	int offset, other, i, tags, regnr, tag, newtop;
@@ -692,7 +692,7 @@ int fpregs_soft_get(struct task_struct *target,
 		    const struct user_regset *regset,
 		    struct membuf to)
 {
-	struct swregs_state *s387 = &target->thread.fpu.fpstate->regs.soft;
+	struct swregs_state *s387 = &target->thread.fpu->fpstate->regs.soft;
 	const void *space = s387->st_space;
 	int offset = (S387->ftop & 7) * 10, other = 80 - offset;
 
diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
index eec3e4805c75..3417337e7d99 100644
--- a/arch/x86/math-emu/fpu_system.h
+++ b/arch/x86/math-emu/fpu_system.h
@@ -73,7 +73,7 @@ static inline bool seg_writable(struct desc_struct *d)
 	return (d->type & SEG_TYPE_EXECUTE_MASK) == SEG_TYPE_WRITABLE;
 }
 
-#define I387			(&current->thread.fpu.fpstate->regs)
+#define I387			(&current->thread.fpu->fpstate->regs)
 #define FPU_info		(I387->soft.info)
 
 #define FPU_CS			(*(unsigned short *) &(FPU_info->regs->cs))
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b522933bfa56..cd73a533db69 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -111,7 +111,7 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
- * here because the FPU state of a task using the FPU (task->thread.fpu.state)
+ * here because the FPU state of a task using the FPU (task->thread.fpu->state)
  * should always be valid.  However, past bugs have allowed userspace to set
  * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
  * These caused XRSTOR to fail when switching to the task, leaking the FPU
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..069d262730b4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1550,21 +1550,14 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+	/* CPU-specific state of this task: */
+	struct thread_struct		thread;
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
 	 */
 	randomized_struct_fields_end
-
-	/* CPU-specific state of this task: */
-	struct thread_struct		thread;
-
-	/*
-	 * WARNING: on x86, 'thread_struct' contains a variable-sized
-	 * structure.  It *MUST* be at the end of 'task_struct'.
-	 *
-	 * Do not put anything below here!
-	 */
 };
 
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
-- 
2.40.1


