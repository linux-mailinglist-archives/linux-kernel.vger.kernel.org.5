Return-Path: <linux-kernel+bounces-92799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE04872616
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9494528A9F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA31417BCD;
	Tue,  5 Mar 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyuOFdij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAB182B3;
	Tue,  5 Mar 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661529; cv=none; b=jC9m2h+eDcw3r14pbA71OWPDrzN8uCX1RnqRH/diARZgZzUFHzKy+m7NiSC5hrVkLuV/YJGg+BDBLtw4UqhyoftYXeRT9IHPoKymobwzHyJtPClBlAhCtmpBd5pSRzXrPpve835guVX3f4PxtZ4Sh6SR8cQrAb2EpWoepL6nKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661529; c=relaxed/simple;
	bh=n/toLIPHbeaoCIED5/1fJO2jWwcxruDUgbg++Dsbijk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq5YhoSgzeYonvlWsLRQHkxsBhrSHj698GUY9Hpr7gSFy72Y262VxZKHhrQ+zJJCGOmNEO3VYDKEhhKEZXzjWv6yU6dV4ptf/xndq5v4qtcdJAlmBtoLaUpRVCIkPHIwpQdTAVPBh1/GJQQP1FpPJGwp9Z3rz+xFzPuWUf1WFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyuOFdij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08BBC433C7;
	Tue,  5 Mar 2024 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709661528;
	bh=n/toLIPHbeaoCIED5/1fJO2jWwcxruDUgbg++Dsbijk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyuOFdij78BbskVgyqWFM/kzuBAvozgJDjD+TyHF7hPV9/yM2i3UYBjxrJkgZGhdJ
	 hW0lISaHBCuCz3x58q3LcNLqE0iGTM41jWlFKhXlgzZsm7d6YIn+vslueGkx6QnfSR
	 GWWKGicIcHu12H3OYH9O6JyEOP+wleGX4Ylc32EUYlgbQ5v+9gp+D5Hkroim2V4IW2
	 wOij1bmoo7i0nbyfE4LownVfl/7lY+dZvCOeF3nG8tj5rWlBvW3fZPAawsdL81QtiU
	 v2w6UlebkcHRtTMGiwSY+kewSqrytcnmtNwKciHGI3gOJ98z/1rPmc1zQ/HBtB3c7J
	 IHyTn8DDq4gew==
Date: Tue, 5 Mar 2024 09:58:46 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <20240305175846.qnyiru7uaa7itqba@treble>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
 <202403050129.5B72ACAA0D@keescook>
 <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>

> >> For the usercopy_abort function, whether '__noreturn' is added
> >> does not affect the internal behavior of the usercopy_abort function.
> >> Therefore, it is recommended that '__noreturn' be deleted
> >> so that backtrace can work properly.
> > 
> > This isn't acceptable. Removing __noreturn this will break
> > objtool's processing of execution flow for livepatching, IBT, and
> > KCFI instrumentation. These all depend on an accurate control flow
> > descriptions, and usercopy_abort is correctly marked __noreturn.

__noreturn also has the benefit of enabling the compiler to produce more
compact code for callees.

> Thank you for providing this information.
> I'll go back to further understand how __noreturn is used
> in features such as KCFI and livepatching.

Adding ARM folks -- see
https://lkml.kernel.org/lkml/1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com
for the original bug report.

This is an off-by-one bug which is common in unwinders, due to the fact
that the address on the stack points to the return address rather than
the call address.

So, for example, when the last instruction of a function is a function
call (e.g., to a noreturn function), it can cause the unwinder to
incorrectly try to unwind from the function *after* the callee.

For ORC (x86), we fixed this by decrementing the PC for call frames (but
not exception frames).  I've seen user space unwinders do similar, for
non-signal frames.

Something like the following might fix your issue (completely untested):

diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
index 360f0d2406bf..4891e38cdc1f 100644
--- a/arch/arm/include/asm/stacktrace.h
+++ b/arch/arm/include/asm/stacktrace.h
@@ -21,9 +21,7 @@ struct stackframe {
 	struct llist_node *kr_cur;
 	struct task_struct *tsk;
 #endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
 	bool ex_frame;
-#endif
 };
 
 static __always_inline
@@ -37,9 +35,8 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
 		frame->kr_cur = NULL;
 		frame->tsk = current;
 #endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
-		frame->ex_frame = in_entry_text(frame->pc);
-#endif
+		frame->ex_frame = !!regs;
+
 }
 
 extern int unwind_frame(struct stackframe *frame);
diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 620aa82e3bdd..caed7436da09 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -154,9 +154,6 @@ static void start_stack_trace(struct stackframe *frame, struct task_struct *task
 	frame->kr_cur = NULL;
 	frame->tsk = task;
 #endif
-#ifdef CONFIG_UNWINDER_FRAME_POINTER
-	frame->ex_frame = in_entry_text(frame->pc);
-#endif
 }
 
 void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
@@ -167,6 +164,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	if (regs) {
 		start_stack_trace(&frame, NULL, regs->ARM_fp, regs->ARM_sp,
 				  regs->ARM_lr, regs->ARM_pc);
+		frame.ex_frame = true;
 	} else if (task != current) {
 #ifdef CONFIG_SMP
 		/*
@@ -180,6 +178,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 				  thread_saved_sp(task), 0,
 				  thread_saved_pc(task));
 #endif
+		frame.ex_frame = false;
 	} else {
 here:
 		start_stack_trace(&frame, task,
@@ -187,6 +186,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 				  current_stack_pointer,
 				  (unsigned long)__builtin_return_address(0),
 				  (unsigned long)&&here);
+		frame.ex_frame = false;
 		/* skip this function */
 		if (unwind_frame(&frame))
 			return;
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3bad79db5d6e..46a5b1eb3f0a 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -84,10 +84,10 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
 		loglvl, where, from);
 #elif defined CONFIG_BACKTRACE_VERBOSE
-	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
+	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
 		loglvl, where, (void *)where, from, (void *)from);
 #else
-	printk("%s %ps from %pS\n", loglvl, (void *)where, (void *)from);
+	printk("%s %ps from %pB\n", loglvl, (void *)where, (void *)from);
 #endif
 
 	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 9d2192156087..99ded32196af 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -407,7 +407,7 @@ int unwind_frame(struct stackframe *frame)
 {
 	const struct unwind_idx *idx;
 	struct unwind_ctrl_block ctrl;
-	unsigned long sp_low;
+	unsigned long sp_low, pc;
 
 	/* store the highest address on the stack to avoid crossing it*/
 	sp_low = frame->sp;
@@ -417,19 +417,22 @@ int unwind_frame(struct stackframe *frame)
 	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
 		 frame->pc, frame->lr, frame->sp);
 
-	idx = unwind_find_idx(frame->pc);
+	pc = frame->ex_frame ? frame->pc : frame->pc - 4;
+
+	idx = unwind_find_idx(pc);
 	if (!idx) {
-		if (frame->pc && kernel_text_address(frame->pc)) {
-			if (in_module_plt(frame->pc) && frame->pc != frame->lr) {
+		if (kernel_text_address(pc)) {
+			if (in_module_plt(pc) && frame->pc != frame->lr) {
 				/*
 				 * Quoting Ard: Veneers only set PC using a
 				 * PC+immediate LDR, and so they don't affect
 				 * the state of the stack or the register file
 				 */
 				frame->pc = frame->lr;
+				frame->ex_frame = false;
 				return URC_OK;
 			}
-			pr_warn("unwind: Index not found %08lx\n", frame->pc);
+			pr_warn("unwind: Index not found %08lx\n", pc);
 		}
 		return -URC_FAILURE;
 	}
@@ -442,7 +445,7 @@ int unwind_frame(struct stackframe *frame)
 	if (idx->insn == 1)
 		/* can't unwind */
 		return -URC_FAILURE;
-	else if (frame->pc == prel31_to_addr(&idx->addr_offset)) {
+	else if (frame->ex_frame && pc == prel31_to_addr(&idx->addr_offset)) {
 		/*
 		 * Unwinding is tricky when we're halfway through the prologue,
 		 * since the stack frame that the unwinder expects may not be
@@ -451,9 +454,10 @@ int unwind_frame(struct stackframe *frame)
 		 * a function, we are still effectively in the stack frame of
 		 * the caller, and the unwind info has no relevance yet.
 		 */
-		if (frame->pc == frame->lr)
+		if (pc == frame->lr)
 			return -URC_FAILURE;
 		frame->pc = frame->lr;
+		frame->ex_frame = false;
 		return URC_OK;
 	} else if ((idx->insn & 0x80000000) == 0)
 		/* prel31 to the unwind table */
@@ -515,6 +519,7 @@ int unwind_frame(struct stackframe *frame)
 	frame->lr = ctrl.vrs[LR];
 	frame->pc = ctrl.vrs[PC];
 	frame->lr_addr = ctrl.lr_addr;
+	frame->ex_frame = false;
 
 	return URC_OK;
 }
@@ -544,6 +549,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		 */
 here:
 		frame.pc = (unsigned long)&&here;
+		frame.ex_frame = false;
 	} else {
 		/* task blocked in __switch_to */
 		frame.fp = thread_saved_fp(tsk);
@@ -554,11 +560,12 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		 */
 		frame.lr = 0;
 		frame.pc = thread_saved_pc(tsk);
+		frame.ex_frame = false;
 	}
 
 	while (1) {
 		int urc;
-		unsigned long where = frame.pc;
+		unsigned long where = frame.ex_frame ? frame.pc : frame.pc - 4;
 
 		urc = unwind_frame(&frame);
 		if (urc < 0)

