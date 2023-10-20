Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A897D0BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376745AbjJTJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376679AbjJTJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:35:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B29D5F;
        Fri, 20 Oct 2023 02:35:33 -0700 (PDT)
Date:   Fri, 20 Oct 2023 09:35:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697794531;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJBidDb/QtN17wByyp8wJnXKcC34UkVDm+skWkkNe8g=;
        b=M1xpLQHRaA+9Da5H4q3J22KQkindPDPefJ9qK4JWl+GtRgP2OQIS7b/afKCwu/sRjVR6nj
        rUESx+kImYF2HdkcRwM3OIBOd27GDpg/SMozwAD1iBO3OS496Nknx/uYV2/8VBRgTrSl6w
        DgqdpQVTE5QYCUHdLFeFhvhmrMWZeyM81AB04tKod4vqpcgInRNiBFGub34dKx/0L8Hdo5
        1V4pdUG3b/xllKiH97S+v/9VbI5fUwNX/pZz4ZUDBxgwxsFxK8aYXRiU97+zxeJdsa7HoK
        anfqq86BCEUpYyltIcMhuGwgSiCxtF/q3M2/BrGdYBZOrH4aLfGj7++aHwVH1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697794531;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJBidDb/QtN17wByyp8wJnXKcC34UkVDm+skWkkNe8g=;
        b=u6ymRRUn934Pg4b36Iue8E+RkbOgxLyUB9JRXyYyI1AvHsRSCX4Hl7BgOBi00LZQER2Bdo
        oFurvsjEx43pGaBg==
From:   "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/fpu: Clean up FPU switching in the middle of
 task switching
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231018184227.446318-1-ubizjak@gmail.com>
References: <20231018184227.446318-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169779453061.3135.15807882372245530063.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     24b8a23638cbf92449c353f828b1d309548c78f4
Gitweb:        https://git.kernel.org/tip/24b8a23638cbf92449c353f828b1d309548c78f4
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Wed, 18 Oct 2023 20:41:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 11:24:22 +02:00

x86/fpu: Clean up FPU switching in the middle of task switching

It happens to work, but it's very very wrong, because our 'current'
macro is magic that is supposedly loading a stable value.

It just happens to be not quite stable enough and the compilers
re-load the value enough for this code to work.  But it's wrong.

The whole

        struct fpu *prev_fpu = &prev->fpu;

thing in __switch_to() is pretty ugly. There's no reason why we
should look at that 'prev_fpu' pointer there, or pass it down.

And it only generates worse code, in how it loads 'current' when
__switch_to() has the right task pointers.

The attached patch not only cleans this up, it actually
generates better code too:

 (a) it removes one push/pop pair at entry/exit because there's one
     less register used (no 'current')

 (b) it removes that pointless load of 'current' because it just uses
     the right argument:

	-       movq    %gs:pcpu_hot(%rip), %r12
	-       testq   $16384, (%r12)
	+       testq   $16384, (%rdi)

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231018184227.446318-1-ubizjak@gmail.com
---
 arch/x86/include/asm/fpu/sched.h | 10 ++++++----
 arch/x86/kernel/process_32.c     |  7 +++----
 arch/x86/kernel/process_64.c     |  7 +++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index ca6e5e5..c485f19 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -37,10 +37,12 @@ extern void fpu_flush_thread(void);
  * The FPU context is only stored/restored for a user task and
  * PF_KTHREAD is used to distinguish between kernel and user threads.
  */
-static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
+static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		struct fpu *old_fpu = &old->thread.fpu;
+
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
@@ -60,10 +62,10 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Delay loading of the complete FPU state until the return to userland.
  * PKRU is handled separately.
  */
-static inline void switch_fpu_finish(void)
+static inline void switch_fpu_finish(struct task_struct *new)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU))
-		set_thread_flag(TIF_NEED_FPU_LOAD);
+		set_tsk_thread_flag(new, TIF_NEED_FPU_LOAD);
 }
 
 #endif /* _ASM_X86_FPU_SCHED_H */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 708c87b..0917c7f 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -156,13 +156,12 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev = &prev_p->thread,
 			     *next = &next_p->thread;
-	struct fpu *prev_fpu = &prev->fpu;
 	int cpu = smp_processor_id();
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-		switch_fpu_prepare(prev_fpu, cpu);
+	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
+		switch_fpu_prepare(prev_p, cpu);
 
 	/*
 	 * Save away %gs. No need to save %fs, as it was saved on the
@@ -209,7 +208,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	raw_cpu_write(pcpu_hot.current_task, next_p);
 
-	switch_fpu_finish();
+	switch_fpu_finish(next_p);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b2687..1553e19 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -562,14 +562,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev = &prev_p->thread;
 	struct thread_struct *next = &next_p->thread;
-	struct fpu *prev_fpu = &prev->fpu;
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(pcpu_hot.hardirq_stack_inuse));
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-		switch_fpu_prepare(prev_fpu, cpu);
+	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
+		switch_fpu_prepare(prev_p, cpu);
 
 	/* We must save %fs and %gs before load_TLS() because
 	 * %fs and %gs may be cleared by load_TLS().
@@ -623,7 +622,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	raw_cpu_write(pcpu_hot.current_task, next_p);
 	raw_cpu_write(pcpu_hot.top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish();
+	switch_fpu_finish(next_p);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
