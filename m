Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA907DBAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjJ3NbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjJ3Na6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:30:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1BCC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qeUwGjrsfPd2MuIuq8OuKsXmBiIbvCSp2oGA6eIP244=; b=EEjoSaZbjneLoxagakZSj+AByt
        tpSbrXl9m0LZCNIp/2OegJGqgvY6AECXc+8Dpbidp6cTM9tKBW5J6S5+G0hDYi+3pdpqjYt3TY/IV
        54U88pRjlHxMhy61PKCZHL3wOpQnw40kItlMmFXwATo++syWJ4/Q+cGG0Jc3WhW9HLEtYuU3IiR3Z
        kkLzg28HkvC4EQecZsYulHM+8YEMQmGj/pn7Fq1/fh7fJ1uGgQ6E0r3QCfzgoc/0KTnpnePsw6Naq
        ehsoRMbass1UElLS2LixlBLMCZSGC0bXOTFAjqCXyWDqpSWPDw22Ouvludbqk2Jbbfer1fiZ6uiqn
        F3BVaFSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxSL0-003x3Z-23;
        Mon, 30 Oct 2023 13:29:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A97C300478; Mon, 30 Oct 2023 14:29:50 +0100 (CET)
Date:   Mon, 30 Oct 2023 14:29:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231030132949.GA38123@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
 <20231026084402.GK31411@noisy.programming.kicks-ass.net>
 <20231026091658.1dcf2106@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026091658.1dcf2106@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:16:58AM -0400, Steven Rostedt wrote:

> I said:
> 
>   If we are worried about abuse, we could even punish tasks that don't call
>   sched_yield() by the time its extended time slice is taken.

This is a user interface, ofcourse I'm worried about abuse. That's the
first thing you *should* think about.

Userspace is out to get you -- must assume hostile.

Notably, we were talking usec latencies in the Chrome thread, you're
adding 1000 usec latencies here (in the best case, delaying scheduling
until the next tick, 10000usec for the HZ=100 folks). This is quite
'unfortunate'.

On my very aged IVB-EP I can get 50us scheduling latencies on a good
day, on my brand spanking new SPR I can get 20us (more faster more
better etc..).

Ideally we don't allow userspace to extend much (if any) beyond the
granularity already imposed by the kernel's preempt/IRQ-disable regions.
Sadly we don't have a self-measure of that around.

So I had a poke at all this and ended up with the below. I still utterly
detest all this, but it appears to actually work -- although I don't
much see the improvement, the numbers are somewhat unstable. (I say it
works because I see the 'yield -- made it' trace_printk when I do it
right and the 'timeout -- force resched' when I do it 'wrong'.

This thing works across the board and gives userspace 50usec, equal to
what the kernel already imposes on (on the IVB).

I simply took a bit from the existing flags field, and userspace can use
BTR to test if the kernel cleared it -- in which case it needs yield
(and not any other syscall).

Additinally doing a syscall with the bit set will SIGSEGV (when
DEBUG_RSEQ).

---
 include/linux/sched.h     | 17 +++++++++++++
 include/uapi/linux/rseq.h |  5 ++++
 kernel/entry/common.c     | 22 +++++++++++------
 kernel/rseq.c             | 63 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/core.c       | 22 +++++++++++++++++
 5 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7f17295931de..93c0f9ac6293 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -919,6 +919,9 @@ struct task_struct {
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
+#ifdef CONFIG_RSEQ
+	unsigned			rseq_sched_delay:1;
+#endif
 
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
@@ -2451,6 +2454,20 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+#ifdef CONFIG_RSEQ
+
+extern bool rseq_delay_resched(void);
+extern void rseq_delay_resched_fini(void);
+extern void rseq_delay_resched_tick(void);
+
+#else
+
+static inline bool rseq_delay_resched(void) { return false; }
+static inline void rseq_delay_resched_fini(void) { }
+static inline void rseq_delay_resched_tick(void) { }
+
+#endif
+
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..ec3b45f32bc8 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -26,6 +26,7 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+	RSEQ_CS_FLAG_DELAY_RESCHED_BIT		= 3,
 };
 
 enum rseq_cs_flags {
@@ -35,6 +36,8 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+	RSEQ_CS_FLAG_DELAY_RESCHED		=
+		(1U << RSEQ_CS_FLAG_DELAY_RESCHED_BIT),
 };
 
 /*
@@ -128,6 +131,8 @@ struct rseq {
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
 	 *     Inhibit instruction sequence block restart on migration for
 	 *     this thread.
+	 * - RSEQ_CS_DELAY_RESCHED
+	 *     Try delay resched...
 	 */
 	__u32 flags;
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba..b969c19e29bc 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -145,7 +145,8 @@ void noinstr exit_to_user_mode(void)
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
+					    unsigned long ti_work,
+					    bool irq)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -155,8 +156,12 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
+		if (ti_work & _TIF_NEED_RESCHED) {
+			if (irq && rseq_delay_resched())
+				clear_tsk_need_resched(current);
+			else
+				schedule();
+		}
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
@@ -190,7 +195,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	return ti_work;
 }
 
-static void exit_to_user_mode_prepare(struct pt_regs *regs)
+static void exit_to_user_mode_prepare(struct pt_regs *regs, bool irq)
 {
 	unsigned long ti_work;
 
@@ -201,7 +206,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	ti_work = read_thread_flags();
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
+		ti_work = exit_to_user_mode_loop(regs, ti_work, irq);
+
+	if (irq)
+		rseq_delay_resched_fini();
 
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 
@@ -282,7 +290,7 @@ static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *reg
 {
 	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare(regs, false);
 }
 
 void syscall_exit_to_user_mode_work(struct pt_regs *regs)
@@ -306,7 +314,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
+	exit_to_user_mode_prepare(regs, true);
 	instrumentation_end();
 	__exit_to_user_mode();
 }
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..fce7a939f3a9 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -339,6 +339,64 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	force_sigsegv(sig);
 }
 
+bool rseq_delay_resched(void)
+{
+	struct task_struct *t = current;
+	u32 flags;
+
+	if (!IS_ENABLED(CONFIG_SCHED_HRTICK))
+		return false;
+
+	if (!t->rseq)
+		return false;
+
+	if (t->rseq_sched_delay)
+		return false;
+
+	if (copy_from_user(&flags, &t->rseq->flags, sizeof(flags)))
+		return false;
+
+	if (!(flags & RSEQ_CS_FLAG_DELAY_RESCHED))
+		return false;
+
+	flags &= ~RSEQ_CS_FLAG_DELAY_RESCHED;
+	if (copy_to_user(&t->rseq->flags, &flags, sizeof(flags)))
+		return false;
+
+	t->rseq_sched_delay = 1;
+
+	return true;
+}
+
+void rseq_delay_resched_fini(void)
+{
+#ifdef CONFIG_SCHED_HRTICK
+	extern void hrtick_local_start(u64 delay);
+	struct task_struct *t = current;
+	/*
+	 * IRQs off, guaranteed to return to userspace, start timer on this CPU
+	 * to limit the resched-overdraft.
+	 *
+	 * If your critical section is longer than 50 us you get to keep the
+	 * pieces.
+	 */
+	if (t->rseq_sched_delay)
+		hrtick_local_start(50 * NSEC_PER_USEC);
+#endif
+}
+
+void rseq_delay_resched_tick(void)
+{
+#ifdef CONFIG_SCHED_HRTICK
+	struct task_struct *t = current;
+
+	if (t->rseq_sched_delay) {
+		set_tsk_need_resched(t);
+		trace_printk("timeout -- force resched\n");
+	}
+#endif
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 /*
@@ -353,7 +411,10 @@ void rseq_syscall(struct pt_regs *regs)
 
 	if (!t->rseq)
 		return;
-	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+
+	if (rseq_get_rseq_cs(t, &rseq_cs) ||
+	    in_rseq_cs(ip, &rseq_cs) ||
+	    rseq_cs.flags & RSEQ_CS_FLAG_DELAY_RESCHED)
 		force_sig(SIGSEGV);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ec65bc2a91e..994497fe97a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -776,6 +776,7 @@ void update_rq_clock(struct rq *rq)
 
 static void hrtick_clear(struct rq *rq)
 {
+	rseq_delay_resched_tick();
 	if (hrtimer_active(&rq->hrtick_timer))
 		hrtimer_cancel(&rq->hrtick_timer);
 }
@@ -791,6 +792,8 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
 
+	rseq_delay_resched_tick();
+
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
@@ -864,6 +867,16 @@ void hrtick_start(struct rq *rq, u64 delay)
 
 #endif /* CONFIG_SMP */
 
+void hrtick_local_start(u64 delay)
+{
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+
+	rq_lock(rq, &rf);
+	hrtick_start(rq, delay);
+	rq_unlock(rq, &rf);
+}
+
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
@@ -6709,6 +6722,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_RSEQ
+	prev->rseq_sched_delay = 0;
+#endif
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
 #endif
@@ -8607,6 +8623,12 @@ static void do_sched_yield(void)
  */
 SYSCALL_DEFINE0(sched_yield)
 {
+	if (current->rseq_sched_delay) {
+		trace_printk("yield -- made it\n");
+		schedule();
+		return 0;
+	}
+
 	do_sched_yield();
 	return 0;
 }
