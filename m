Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20B7DB8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjJ3LRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJ3LRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:17:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173AAB3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1QUOL/nJ4h4gWuASTi7qdoIDLikQSWZknKShY7nrJQQ=; b=fkYxr7u/JVmRmPeAP3ryi2MpzE
        Rbn/Wr3Q6ssCnwpaO+9rslqgMVy9aGyP5GTXw6G1YKdqzJCYt6YEdl5sFckvosSxPDOlEEE4aIZoy
        l5GjDd+NZaldGBAowUlpQ24dffBmQyjKF3fO/tfVOkdWdfrnzPAjOLXHyr1S2a+SrkNjGGHfj/Sul
        HsYNha+yOO3SBXAR5xGH8Q7JY/YEQ2iLrKDxq9ugsrizvvzuNPIUGW3KsElOG4JrDtbytdPzLVq4n
        X6QiYKmnlVI/iiTTO7QjwdImcrqqswzGQnneX918vMi0220IBaVjRQA3TQDZF4p4I6viVQgiCUJ/r
        V92WK5Tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxQGr-003jPK-Ax; Mon, 30 Oct 2023 11:17:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0236D300478; Mon, 30 Oct 2023 12:17:25 +0100 (CET)
Date:   Mon, 30 Oct 2023 12:17:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] lockdep: add lockdep_cleanup_dead_cpu()
Message-ID: <20231030111724.GA12604@noisy.programming.kicks-ass.net>
References: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e5ba02138c31da60daf91ce505ac3860d022332b.camel@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 12:14:02PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Add a function to check that an offlone CPU left the tracing infrastructu=
re
> in a sane state. The acpi_idle_play_dead() function was recently observed
> calling safe_halt() instead of raw_safe_halt(), which had the side-effect

Right, so all that is because the offline path needs noinstr, but nobody
got around to doing that :/

Very rought attempt below, will scream bloody murder on build...

vmlinux.o: warning: objtool: idle_task_exit+0x45: call to switch_mm() leave=
s .noinstr.text section
vmlinux.o: warning: objtool: acpi_idle_play_dead+0x40: call to trace_hardir=
qs_on() leaves .noinstr.text section
vmlinux.o: warning: objtool: cpuidle_play_dead+0x10: call to cpuidle_get_cp=
u_driver() leaves .noinstr.text section

The acpi_idle_play_dead() thing is your original issue. No quick ideas
on what to do with switch_mm(), ideally we put that before we kill RCU
dead.

---
 arch/x86/include/asm/cpuid.h  |  4 ++--
 arch/x86/include/asm/smp.h    |  4 +++-
 arch/x86/kernel/process.c     |  4 ++--
 arch/x86/kernel/smpboot.c     | 12 ++++++------
 arch/x86/kernel/tboot.c       |  9 +++++----
 drivers/acpi/processor_idle.c |  2 +-
 drivers/cpuidle/cpuidle.c     |  5 +++--
 kernel/cpu.c                  | 15 +++++++++++----
 kernel/rcu/tree.c             | 15 ++++++++++-----
 kernel/sched/core.c           |  4 ++--
 kernel/sched/idle.c           |  2 +-
 11 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 9bee3e7bf973..8417d741ce59 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -27,8 +27,8 @@ static inline int have_cpuid_p(void)
 	return 1;
 }
 #endif
-static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
-				unsigned int *ecx, unsigned int *edx)
+static __always_inline void native_cpuid(unsigned int *eax, unsigned int *=
ebx,
+					 unsigned int *ecx, unsigned int *edx)
 {
 	/* ecx is often an input as well as an output. */
 	asm volatile("cpuid"
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..41e839afba77 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -85,9 +85,11 @@ static inline void __cpu_die(unsigned int cpu)
 		smp_ops.cpu_die(cpu);
 }
=20
-static inline void __noreturn play_dead(void)
+static __always_inline void __noreturn play_dead(void)
 {
+	instrumentation_begin(); // noinstr doesn't do indirect
 	smp_ops.play_dead();
+	instrumentation_end();
 	BUG();
 }
=20
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e8399fca..c26d8f2af7bb 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -754,7 +754,7 @@ static bool x86_idle_set(void)
 }
=20
 #ifndef CONFIG_SMP
-static inline void __noreturn play_dead(void)
+static inline void __noreturn noinstr play_dead(void)
 {
 	BUG();
 }
@@ -766,7 +766,7 @@ void arch_cpu_idle_enter(void)
 	local_touch_nmi();
 }
=20
-void __noreturn arch_cpu_idle_dead(void)
+noinstr void __noreturn arch_cpu_idle_dead(void)
 {
 	play_dead();
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 222d62e84cb3..74a926ddfac5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1474,20 +1474,20 @@ int native_cpu_disable(void)
 	return 0;
 }
=20
-void play_dead_common(void)
+noinstr void play_dead_common(void)
 {
 	idle_task_exit();
=20
 	cpuhp_ap_report_dead();
=20
-	local_irq_disable();
+	lockdep_assert_irqs_disabled();
 }
=20
 /*
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
  */
-static inline void mwait_play_dead(void)
+static __always_inline void mwait_play_dead(void)
 {
 	struct mwait_cpu_dead *md =3D this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
@@ -1597,7 +1597,7 @@ void smp_kick_mwait_play_dead(void)
 	}
 }
=20
-void __noreturn hlt_play_dead(void)
+void __noreturn noinstr hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >=3D 4)
 		wbinvd();
@@ -1610,7 +1610,7 @@ void __noreturn hlt_play_dead(void)
  * native_play_dead() is essentially a __noreturn function, but it can't
  * be marked as such as the compiler may complain about it.
  */
-void native_play_dead(void)
+noinstr void native_play_dead(void)
 {
 	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS))
 		__update_spec_ctrl(0);
@@ -1629,7 +1629,7 @@ int native_cpu_disable(void)
 	return -ENOSYS;
 }
=20
-void native_play_dead(void)
+noinstr void native_play_dead(void)
 {
 	BUG();
 }
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4c1bcb6053fc..a8fb9a5a4e02 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -105,7 +105,7 @@ static struct mm_struct tboot_mm =3D {
 	.mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
 };
=20
-static inline void switch_to_tboot_pt(void)
+static __always_inline void switch_to_tboot_pt(void)
 {
 	write_cr3(virt_to_phys(tboot_pg_dir));
 }
@@ -193,7 +193,7 @@ static void add_mac_region(phys_addr_t start, unsigned =
long size)
 	}
 }
=20
-static int tboot_setup_sleep(void)
+static noinstr int tboot_setup_sleep(void)
 {
 	int i;
=20
@@ -224,7 +224,7 @@ static int tboot_setup_sleep(void)
=20
 #endif
=20
-void tboot_shutdown(u32 shutdown_type)
+noinstr void tboot_shutdown(u32 shutdown_type)
 {
 	void (*shutdown)(void);
=20
@@ -240,9 +240,10 @@ void tboot_shutdown(u32 shutdown_type)
 		return;
=20
 	/* if this is S3 then set regions to MAC */
-	if (shutdown_type =3D=3D TB_SHUTDOWN_S3)
+	if (shutdown_type =3D=3D TB_SHUTDOWN_S3) {
 		if (tboot_setup_sleep())
 			return;
+	}
=20
 	tboot->shutdown_type =3D shutdown_type;
=20
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 3a34a8c425fe..ad13fe635204 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -583,7 +583,7 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_pr=
ocessor_cx *cx)
  * @dev: the target CPU
  * @index: the index of suggested state
  */
-static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
+static noinstr int acpi_idle_play_dead(struct cpuidle_device *dev, int ind=
ex)
 {
 	struct acpi_processor_cx *cx =3D per_cpu(acpi_cstate[index], dev->cpu);
=20
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 737a026ef58a..67e66646912e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -60,7 +60,7 @@ bool cpuidle_not_available(struct cpuidle_driver *drv,
  *
  * Returns in case of an error or no driver
  */
-int cpuidle_play_dead(void)
+noinstr int cpuidle_play_dead(void)
 {
 	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
@@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
 		return -ENODEV;
=20
 	/* Find lowest-power state that supports long-term idle */
-	for (i =3D drv->state_count - 1; i >=3D 0; i--)
+	for (i =3D drv->state_count - 1; i >=3D 0; i--) {
 		if (drv->states[i].enter_dead)
 			return drv->states[i].enter_dead(dev, i);
+	}
=20
 	return -ENODEV;
 }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1a189da3bdac..5ca00bac6650 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -297,7 +297,7 @@ enum cpuhp_sync_state {
  * No synchronization point. Just update of the synchronization state, but=
 implies
  * a full barrier so that the AP changes are visible before the control CP=
U proceeds.
  */
-static inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_state state)
+static __always_inline void cpuhp_ap_update_sync_state(enum cpuhp_sync_sta=
te state)
 {
 	atomic_t *st =3D this_cpu_ptr(&cpuhp_state.ap_sync_state);
=20
@@ -347,7 +347,7 @@ static inline void cpuhp_ap_update_sync_state(enum cpuh=
p_sync_state state) { }
  *
  * No synchronization point. Just update of the synchronization state.
  */
-void cpuhp_ap_report_dead(void)
+noinstr void cpuhp_ap_report_dead(void)
 {
 	cpuhp_ap_update_sync_state(SYNC_STATE_DEAD);
 }
@@ -1391,19 +1391,26 @@ static void cpuhp_complete_idle_dead(void *arg)
 	complete_ap_thread(st, false);
 }
=20
-void cpuhp_report_idle_dead(void)
+noinstr void cpuhp_report_idle_dead(void)
 {
-	struct cpuhp_cpu_state *st =3D this_cpu_ptr(&cpuhp_state);
+	struct cpuhp_cpu_state *st;
=20
+	instrumentation_begin();
+	st =3D this_cpu_ptr(&cpuhp_state);
 	BUG_ON(st->state !=3D CPUHP_AP_OFFLINE);
 	rcu_report_dead(smp_processor_id());
+	// instrumentation_end(); // RCU is dead here
+
 	st->state =3D CPUHP_AP_IDLE_DEAD;
 	/*
 	 * We cannot call complete after rcu_report_dead() so we delegate it
 	 * to an online cpu.
+	 *
+	 * XXX strictly speaking this should be noinstr, there's no RCU anymore
 	 */
 	smp_call_function_single(cpumask_first(cpu_online_mask),
 				 cpuhp_complete_idle_dead, st, 0);
+	instrumentation_end();
 }
=20
 static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *=
st,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..6c577a6d3581 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4474,13 +4474,17 @@ void rcu_cpu_starting(unsigned int cpu)
  * from the outgoing CPU rather than from the cpuhp_step mechanism.
  * This is because this function must be invoked at a precise location.
  */
-void rcu_report_dead(unsigned int cpu)
+noinstr void rcu_report_dead(unsigned int cpu)
 {
-	unsigned long flags, seq_flags;
+	unsigned long flags;
 	unsigned long mask;
 	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp =3D rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
=20
+	lockdep_assert_irqs_disabled();
+
+	instrumentation_begin();
+
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
=20
@@ -4488,7 +4492,7 @@ void rcu_report_dead(unsigned int cpu)
=20
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask =3D rdp->grpmask;
-	local_irq_save(seq_flags);
+
 	arch_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order gu=
arantee. */
 	rdp->rcu_ofl_gp_seq =3D READ_ONCE(rcu_state.gp_seq);
@@ -4500,9 +4504,10 @@ void rcu_report_dead(unsigned int cpu)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags); // XXX RCU already dead =
?!
 	arch_spin_unlock(&rcu_state.ofl_lock);
-	local_irq_restore(seq_flags);
+
+	instrumentation_end();
=20
 	rdp->cpu_started =3D false;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81885748871d..4447e75e9275 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9371,7 +9371,7 @@ void sched_setnuma(struct task_struct *p, int nid)
  * Ensure that the idle task is using init_mm right before its CPU goes
  * offline.
  */
-void idle_task_exit(void)
+noinstr void idle_task_exit(void)
 {
 	struct mm_struct *mm =3D current->active_mm;
=20
@@ -9379,7 +9379,7 @@ void idle_task_exit(void)
 	BUG_ON(current !=3D this_rq()->idle);
=20
 	if (mm !=3D &init_mm) {
-		switch_mm(mm, &init_mm, current);
+		switch_mm(mm, &init_mm, current); // XXX bugger ! properly broken
 		finish_arch_post_lock_switch();
 	}
=20
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 565f8374ddbb..bf39ee9e5334 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -75,7 +75,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
-void __weak __noreturn arch_cpu_idle_dead(void) { while (1); }
+void __weak __noreturn noinstr arch_cpu_idle_dead(void) { while (1); }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll =3D 1;
