Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFA7A8FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjITX6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITX6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:58:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81DCF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:58:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695254308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K7dnRRqNJcm/l6hrDhDtKPtKdIhinbuQ4+KsQ1sqCu4=;
        b=NyykBcVcEWzAodOgTY92sI3P8TrKHkZ1gUU1+jMKCGHC4kD4o8WUFkiilk42MZb/5q+drj
        JxvWeS7Nf6yD5AjMMcW/mE2ZQvIyalscMSVijjQ7+R5URW6khBHbzBb5n7smn5KQNAbLT6
        bQznh8/oFtgbFIexEnj+kfcPwVkNk5IPp3n9xRNKuWTTlQadCN141TpEdQ3Or+X5tcnKeQ
        wcfRQ/2O75vMz7pLPcwGkEorBL5CMk8Zv8bJogK+7tBVOX3xSqio9GnjDTJJhfuMtYRJgc
        jOOEdLI1+NZmdgCDTGpLb/GheUmXoC5w3NMK24DSjYx2GMNOoPanGOW/Wf2CwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695254308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K7dnRRqNJcm/l6hrDhDtKPtKdIhinbuQ4+KsQ1sqCu4=;
        b=pFQuJaj8VFcbTn2ZRu2cztnGWWBDnmKntk1U5crNcYia2Tf6Aw2/S7bdtrCB4UcAmVbSee
        aBRZOXP9XShed0AA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <87led2wdj0.ffs@tglx>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
Date:   Thu, 21 Sep 2023 01:58:27 +0200
Message-ID: <8734z8v1lo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 14:30, Thomas Gleixner wrote:
> On Mon, Sep 18 2023 at 18:57, Linus Torvalds wrote:
>> Anyway, I'm definitely not opposed. We'd get rid of a config option
>> that is presumably not very widely used, and we'd simplify a lot of
>> issues, and get rid of all these badly defined "cond_preempt()"
>> things.
>
> Hmm. Didn't I promise a year ago that I won't do further large scale
> cleanups and simplifications beyond printk.
>
> Maybe I get away this time with just suggesting it. :)

Maybe not. As I'm inveterate curious, I sat down and figured out how
that might look like.

To some extent I really curse my curiosity as the amount of macro maze,
config options and convoluted mess behind all these preempt mechanisms
is beyond disgusting.

Find below a PoC which implements that scheme. It's not even close to
correct, but it builds, boots and survives lightweight testing.

I did not even try to look into time-slice enforcement, but I really want
to share this for illustration and for others to experiment.

This keeps all the existing mechanisms in place and introduces a new
config knob in the preemption model Kconfig switch: PREEMPT_AUTO

If selected it builds a CONFIG_PREEMPT kernel, which disables the
cond_resched() machinery and switches the fair scheduler class to use
the NEED_PREEMPT_LAZY bit by default, i.e. it should be pretty close to
the preempt NONE model except that cond_resched() is a NOOP and I did
not validate the time-slice enforcement. The latter should be a
no-brainer to figure out and fix if required.

For run-time switching this to the FULL preemption model which always
uses TIF_NEED_RESCHED, you need to enable CONFIG_SCHED_DEBUG and then
you can enable "FULL" via:

  echo FORCE_NEED_RESCHED >/sys/kernel/debug/sched/features

and switch back to some sort of "NONE" via

  echo NO_FORCE_NEED_RESCHED >/sys/kernel/debug/sched/features

It seems to work as expected for a simple hackbench -l 10000 run:

	         	NO_FORCE_NEED_RESCHED       FORCE_NEED_RESCHED
schedule() [1] 		3646163		            2701641
preemption                12554			     927856
total                   3658717                     3629497

[1] is voluntary schedule() AND_ schedule() from return to user space. I
did not come around to account them separately yet, but for a quick
check this clearly shows that this "works" as advertised.

Of course this needs way more analysis than this quick PoC+check, but
you get the idea.

Contrary to other hot of the press hacks, I'm pretty sure it won't
destroy your hard-disk, but I won't recommend that you deploy it on your
alarm-clock as it might make you miss the bus.

If this concept holds, which I'm pretty convinced of by now, then this
is an opportunity to trade ~3000 lines of unholy hacks for about 100-200
lines of understandable code :)

Thanks,

        tglx
---
 arch/x86/Kconfig                   |    1 
 arch/x86/include/asm/thread_info.h |    2 +
 drivers/acpi/processor_idle.c      |    2 -
 include/linux/entry-common.h       |    2 -
 include/linux/entry-kvm.h          |    2 -
 include/linux/sched.h              |   18 +++++++++++-----
 include/linux/sched/idle.h         |    8 +++----
 include/linux/thread_info.h        |   19 +++++++++++++++++
 kernel/Kconfig.preempt             |   12 +++++++++-
 kernel/entry/common.c              |    2 -
 kernel/sched/core.c                |   41 ++++++++++++++++++++++++-------------
 kernel/sched/fair.c                |   10 ++++-----
 kernel/sched/features.h            |    2 +
 kernel/sched/idle.c                |    3 --
 kernel/sched/sched.h               |    1 
 kernel/trace/trace.c               |    2 -
 16 files changed, 91 insertions(+), 36 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -898,14 +898,14 @@ static inline void hrtick_rq_init(struct
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
 /*
- * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
+ * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, int nr_bit)
 {
 	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+	return !(fetch_or(&ti->flags, 1 << nr_bit) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -931,9 +931,9 @@ static bool set_nr_if_polling(struct tas
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, int nr_bit)
 {
-	set_tsk_need_resched(p);
+	set_tsk_thread_flag(p, nr_bit);
 	return true;
 }
 
@@ -1038,28 +1038,42 @@ void wake_up_q(struct wake_q_head *head)
  * might also involve a cross-CPU call to trigger the scheduler on
  * the target CPU.
  */
-void resched_curr(struct rq *rq)
+static void __resched_curr(struct rq *rq, int nr_bit)
 {
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched_type(curr, nr_bit))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
-		set_preempt_need_resched();
+		set_tsk_thread_flag(curr, nr_bit);
+		if (nr_bit == TIF_NEED_RESCHED)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(curr, nr_bit)) {
+		if (nr_bit == TIF_NEED_RESCHED)
+			smp_send_reschedule(cpu);
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
+}
+
+void resched_curr(struct rq *rq)
+{
+	__resched_curr(rq, TIF_NEED_RESCHED);
+}
+
+void resched_curr_lazy(struct rq *rq)
+{
+	__resched_curr(rq, sched_feat(FORCE_NEED_RESCHED) ?
+		       TIF_NEED_RESCHED : TIF_NEED_RESCHED_LAZY);
 }
 
 void resched_cpu(int cpu)
@@ -1132,7 +1146,7 @@ static void wake_up_idle_cpu(int cpu)
 	if (cpu == smp_processor_id())
 		return;
 
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(rq->idle, TIF_NEED_RESCHED))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -8872,7 +8886,6 @@ static void __init preempt_dynamic_init(
 		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
 		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
 	}									 \
-	EXPORT_SYMBOL_GPL(preempt_model_##mode)
 
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,11 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+#ifndef CONFIG_PREEMPT_AUTO
+# define TIF_NEED_RESCHED_LAZY		TIF_NEED_RESCHED
+# define _TIF_NEED_RESCHED_LAZY		_TIF_NEED_RESCHED
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
@@ -185,6 +190,13 @@ static __always_inline bool tif_need_res
 			     (unsigned long *)(&current_thread_info()->flags));
 }
 
+static __always_inline bool tif_need_resched_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
+		arch_test_bit(TIF_NEED_RESCHED_LAZY,
+			      (unsigned long *)(&current_thread_info()->flags));
+}
+
 #else
 
 static __always_inline bool tif_need_resched(void)
@@ -193,6 +205,13 @@ static __always_inline bool tif_need_res
 			(unsigned long *)(&current_thread_info()->flags));
 }
 
+static __always_inline bool tif_need_resched_lazy(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
+		test_bit(TIF_NEED_RESCHED_LAZY,
+			 (unsigned long *)(&current_thread_info()->flags));
+}
+
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -11,6 +11,9 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
+config HAVE_PREEMPT_AUTO
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
@@ -67,6 +70,13 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
+config PREEMPT_AUTO
+	bool "Automagic preemption mode with runtime tweaking support"
+	depends on HAVE_PREEMPT_AUTO
+	select PREEMPT_BUILD
+	help
+	  Add some sensible blurb here
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
@@ -95,7 +105,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT && !PREEMPT_AUTO
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -60,7 +60,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -18,7 +18,7 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -155,7 +155,7 @@ static unsigned long exit_to_user_mode_l
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,3 +89,5 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(HZ_BW, true)
+
+SCHED_FEAT(FORCE_NEED_RESCHED, false)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2435,6 +2435,7 @@ extern void init_sched_fair_class(void);
 extern void reweight_task(struct task_struct *p, int prio);
 
 extern void resched_curr(struct rq *rq);
+extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2046,17 +2046,17 @@ static inline void update_tsk_thread_fla
 	update_ti_thread_flag(task_thread_info(tsk), flag, value);
 }
 
-static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
@@ -2069,13 +2069,21 @@ static inline void set_tsk_need_resched(
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
 	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
+		clear_tsk_thread_flag(tsk, TIF_NEED_RESCHED_LAZY);
 }
 
-static inline int test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk)
 {
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
+static inline bool test_tsk_need_resched_type(struct task_struct *tsk,
+					      int nr_bit)
+{
+	return unlikely(test_tsk_thread_flag(tsk, 1 << nr_bit));
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
@@ -2252,7 +2260,7 @@ static inline int rwlock_needbreak(rwloc
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(tif_need_resched_lazy() || tif_need_resched());
 }
 
 /*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -985,7 +985,7 @@ static void update_deadline(struct cfs_r
 	 * The task has consumed its request, reschedule.
 	 */
 	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr_lazy(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
 	}
 }
@@ -5267,7 +5267,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
 	 * validating it and just reschedule.
 	 */
 	if (queued) {
-		resched_curr(rq_of(cfs_rq));
+		resched_curr_lazy(rq_of(cfs_rq));
 		return;
 	}
 	/*
@@ -5413,7 +5413,7 @@ static void __account_cfs_rq_runtime(str
 	 * hierarchy can be throttled
 	 */
 	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
-		resched_curr(rq_of(cfs_rq));
+		resched_curr_lazy(rq_of(cfs_rq));
 }
 
 static __always_inline
@@ -5673,7 +5673,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
-		resched_curr(rq);
+		resched_curr_lazy(rq);
 }
 
 #ifdef CONFIG_SMP
@@ -8073,7 +8073,7 @@ static void check_preempt_wakeup(struct
 	return;
 
 preempt:
-	resched_curr(rq);
+	resched_curr_lazy(rq);
 }
 
 #ifdef CONFIG_SMP
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -108,7 +108,7 @@ static const struct dmi_system_id proces
  */
 static void __cpuidle acpi_safe_halt(void)
 {
-	if (!tif_need_resched()) {
+	if (!need_resched()) {
 		raw_safe_halt();
 		raw_local_irq_disable();
 	}
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 #else
@@ -85,11 +85,11 @@ static inline void __current_clr_polling
 
 static inline bool __must_check current_set_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 static inline bool __must_check current_clr_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 #endif
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,8 +57,7 @@ static noinline int __cpuidle cpu_idle_p
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!tif_need_resched() &&
-	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
+	while (!need_resched() && (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
 
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2720,7 +2720,7 @@ unsigned int tracing_gen_ctx_irq_test(un
 	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
 		trace_flags |= TRACE_FLAG_BH_OFF;
 
-	if (tif_need_resched())
+	if (need_resched())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -271,6 +271,7 @@ config X86
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
+	select HAVE_PREEMPT_AUTO
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -83,6 +83,7 @@ struct thread_info {
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_LAZY	6	/* Lazy rescheduling */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -106,6 +107,7 @@ struct thread_info {
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
