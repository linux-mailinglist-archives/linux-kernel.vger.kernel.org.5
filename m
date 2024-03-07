Return-Path: <linux-kernel+bounces-96266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBBE87597B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95315287E37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9F13B797;
	Thu,  7 Mar 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="cPmvl7mV"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9E130E4F;
	Thu,  7 Mar 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847646; cv=none; b=YHyH4c2J2N/wfJ25q2FHsRn+4nCIhORSgJY1TxRQ4wvTSE1+CJGH/B6aCL+bDXufKYj9rKTIj8K/N5qcFKIt9KEltPC8/be7/br4fEQoaXCP2Jg8/tjRN1rPZGVwsvjxaB1HYfWg+k2sV2v9y+lDQfHq2agKhAFSFCouvqJRu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847646; c=relaxed/simple;
	bh=V29WeyiDmzlG9wc1Gt1wznIUrfpQS70EtGd0OLrdV+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k244V6Oc36CfSOC4TzBibBWEnlHpyx3cEjAYk0fs4o3nVscAsffS6fE01Ut7kjPQQUmhbb7NBopiG+rV4pGVGoMopUGv9LBXwqx8yMU9SYeXtP4+YYI8kHcHwY6sR9eAFGV/BYJB4jamtcaU8N4u4FPKCO6mLC7C6TmcsDffDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=cPmvl7mV; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+0IOCCS7ZtsGhvk6qCp9C1GqMEBU/UGtoDZKNgFKWc=;
  b=cPmvl7mVjjvzBvy0L9PmLzbf4naL9yzYfIVkwIdcq/JP5S9mNTzcPPP2
   1c+Axc2JJcOuQXUsUjC9RBF+m45JwrFrWArLSzG7qC9VF8A2JMCfEfaEi
   AomOfnBoCGRtifewJ0psZurHaQqAIijhF+EspPXurC1PdsomMkwG+27Ox
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,107,1708383600"; 
   d="scan'208";a="81576971"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 22:40:38 +0100
Date: Thu, 7 Mar 2024 22:40:37 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>, 
    joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net, 
    frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org, 
    linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com, 
    quic_neeraju@quicinc.com, rcu@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
In-Reply-To: <65a9665e-22d4-4f21-a1cb-7ef1c82ed078@paulmck-laptop>
Message-ID: <alpine.DEB.2.22.394.2403072231130.3161@hadrien>
References: <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com> <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com> <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com> <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com> <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop> <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com> <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
 <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com> <65a9665e-22d4-4f21-a1cb-7ef1c82ed078@paulmck-laptop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 7 Mar 2024, Paul E. McKenney wrote:

> On Thu, Mar 07, 2024 at 12:00:44PM -0800, Linus Torvalds wrote:
> > On Thu, 7 Mar 2024 at 11:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > > - The per-thread counter (Thread-Local Storage) incremented by a single
> > > >   thread, read by various threads concurrently, is a good target
> > > >   for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
> > > >   various liburcu implementations which track read-side critical sections
> > > >   per-thread.
> > >
> > > Agreed, but do any of these use WRITE_ONCE(x, READ_ONCE(x) + 1) or
> > > similar?
> >
> > Absolutely not.
> >
> > The READ_ONCE->WRITE_ONCE pattern is almost certainly a bug.
> >
> > The valid reason to have a WRITE_ONCE() is that there's a _later_
> > READ_ONCE() on another CPU.
> >
> > So WRITE_ONCE->READ_ONCE (across threads) is very valid. But
> > READ_ONCE->WRITE_ONCE (inside a thread) simply is not a valid
> > operation.
> >
> > We do have things like "local_t", which allows for non-smp-safe local
> > thread atomic accesses, but they explicitly are *NOT* about some kind
> > of READ_ONCE -> WRITE_ONCE sequence that by definition cannot be
> > atomic unless you disable interrupts and disable preemption (at which
> > point they become pointless and only generate worse code).
> >
> > But the point of "local_t" is that you can do things that aresafe if
> > there is no SMP issues. They are kind of an extension of the
> > percpu_add() kind of operations.
> >
> > In fact, I think it might be interesting to catch those
> > READ_ONCE->WRITE_ONCE chains (perhaps with coccinelle?) because they
> > are a sign of bugs.
>
> Good point, adding Julia Lawall on CC.

I tried the following:

@@
expression x;
@@

*WRITE_ONCE(x,<+...READ_ONCE(x)...+>)

This gave a number of results, shown below.  Let me know if some of them
are undesirable.

I also tried:

@@
expression x,v;

*v = READ_ONCE(x)
.. when != v
*WRITE_ONCE(x,<+...v...+>)

I found the results somewhat less compelling.  Maybe the following are
interesting (note that - means this line is interesting, not a suggestion
to remove it):

479 files match
diff -u -p /home/julia/linux/net/netfilter/nf_tables_api.c /tmp/nothing/net/netfilter/nf_tables_api.c
--- /home/julia/linux/net/netfilter/nf_tables_api.c
+++ /tmp/nothing/net/netfilter/nf_tables_api.c
@@ -10026,8 +10026,6 @@ static unsigned int nft_gc_seq_begin(str
 	unsigned int gc_seq;

 	/* Bump gc counter, it becomes odd, this is the busy mark. */
-	gc_seq = READ_ONCE(nft_net->gc_seq);
-	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);

 	return gc_seq;
 }
diff -u -p /home/julia/linux/fs/xfs/xfs_icache.c /tmp/nothing/fs/xfs/xfs_icache.c
--- /home/julia/linux/fs/xfs/xfs_icache.c
+++ /tmp/nothing/fs/xfs/xfs_icache.c
@@ -2076,8 +2076,6 @@ xfs_inodegc_queue(
 	cpu_nr = get_cpu();
 	gc = this_cpu_ptr(mp->m_inodegc);
 	llist_add(&ip->i_gclist, &gc->list);
-	items = READ_ONCE(gc->items);
-	WRITE_ONCE(gc->items, items + 1);
 	shrinker_hits = READ_ONCE(gc->shrinker_hits);

 	/*
@@ -2199,9 +2197,7 @@ xfs_inodegc_shrinker_scan(
 	for_each_cpu(cpu, &mp->m_inodegc_cpumask) {
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
 		if (!llist_empty(&gc->list)) {
-			unsigned int	h = READ_ONCE(gc->shrinker_hits);

-			WRITE_ONCE(gc->shrinker_hits, h + 1);
 			mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, 0);
 			no_items = false;
 		}

In other cases, more work is done between the read and the write.  I can send themif of interest.

julia

diff -u -p /home/julia/linux/kernel/sched/fair.c /tmp/nothing/kernel/sched/fair.c
--- /home/julia/linux/kernel/sched/fair.c
+++ /tmp/nothing/kernel/sched/fair.c
@@ -3153,7 +3153,6 @@ static void reset_ptenuma_scan(struct ta
 	 * statistical sampling. Use READ_ONCE/WRITE_ONCE, which are not
 	 * expensive, to avoid any form of compiler optimizations:
 	 */
-	WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
 	p->mm->numa_scan_offset = 0;
 }

diff -u -p /home/julia/linux/net/ipv4/inet_hashtables.c /tmp/nothing/net/ipv4/inet_hashtables.c
--- /home/julia/linux/net/ipv4/inet_hashtables.c
+++ /tmp/nothing/net/ipv4/inet_hashtables.c
@@ -1109,7 +1109,6 @@ ok:
 	 * it may be inexistent.
 	 */
 	i = max_t(int, i, get_random_u32_below(8) * step);
-	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + step);

 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, tb2, port);
diff -u -p /home/julia/linux/kernel/rcu/tree.c /tmp/nothing/kernel/rcu/tree.c
--- /home/julia/linux/kernel/rcu/tree.c
+++ /tmp/nothing/kernel/rcu/tree.c
@@ -1620,8 +1620,6 @@ static void rcu_gp_fqs(bool first_time)
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
 		raw_spin_lock_irq_rcu_node(rnp);
-		WRITE_ONCE(rcu_state.gp_flags,
-			   READ_ONCE(rcu_state.gp_flags) & ~RCU_GP_FLAG_FQS);
 		raw_spin_unlock_irq_rcu_node(rnp);
 	}
 }
@@ -1882,8 +1880,6 @@ static void rcu_report_qs_rsp(unsigned l
 {
 	raw_lockdep_assert_held_rcu_node(rcu_get_root());
 	WARN_ON_ONCE(!rcu_gp_in_progress());
-	WRITE_ONCE(rcu_state.gp_flags,
-		   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
 	rcu_gp_kthread_wake();
 }
@@ -2392,8 +2388,6 @@ void rcu_force_quiescent_state(void)
 		raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 		return;  /* Someone beat us to it. */
 	}
-	WRITE_ONCE(rcu_state.gp_flags,
-		   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 	rcu_gp_kthread_wake();
 }
diff -u -p /home/julia/linux/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c /tmp/nothing/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
--- /home/julia/linux/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ /tmp/nothing/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -80,8 +80,6 @@ static int cn23xx_vf_reset_io_queues(str
 				q_no);
 			return -1;
 		}
-		WRITE_ONCE(reg_val, READ_ONCE(reg_val) &
-			   ~CN23XX_PKT_INPUT_CTL_RST);
 		octeon_write_csr64(oct, CN23XX_VF_SLI_IQ_PKT_CONTROL64(q_no),
 				   READ_ONCE(reg_val));

diff -u -p /home/julia/linux/kernel/rcu/srcutree.c /tmp/nothing/kernel/rcu/srcutree.c
--- /home/julia/linux/kernel/rcu/srcutree.c
+++ /tmp/nothing/kernel/rcu/srcutree.c
@@ -628,7 +628,6 @@ static unsigned long srcu_get_delay(stru
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
-			WRITE_ONCE(sup->srcu_n_exp_nodelay, READ_ONCE(sup->srcu_n_exp_nodelay) + 1);
 			if (READ_ONCE(sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
 				jbase = 1;
 		}
@@ -1799,7 +1798,6 @@ static void process_srcu(struct work_str
 	} else {
 		j = jiffies;
 		if (READ_ONCE(sup->reschedule_jiffies) == j) {
-			WRITE_ONCE(sup->reschedule_count, READ_ONCE(sup->reschedule_count) + 1);
 			if (READ_ONCE(sup->reschedule_count) > srcu_max_nodelay)
 				curdelay = 1;
 		} else {
diff -u -p /home/julia/linux/kernel/kcsan/kcsan_test.c /tmp/nothing/kernel/kcsan/kcsan_test.c
--- /home/julia/linux/kernel/kcsan/kcsan_test.c
+++ /tmp/nothing/kernel/kcsan/kcsan_test.c
@@ -381,7 +381,6 @@ static noinline void test_kernel_change_
 		test_var ^= TEST_CHANGE_BITS;
 		kcsan_nestable_atomic_end();
 	} else
-		WRITE_ONCE(test_var, READ_ONCE(test_var) ^ TEST_CHANGE_BITS);
 }

 static noinline void test_kernel_assert_bits_change(void)
diff -u -p /home/julia/linux/arch/s390/kernel/idle.c /tmp/nothing/arch/s390/kernel/idle.c
--- /home/julia/linux/arch/s390/kernel/idle.c
+++ /tmp/nothing/arch/s390/kernel/idle.c
@@ -43,8 +43,6 @@ void account_idle_time_irq(void)
 	S390_lowcore.last_update_timer = S390_lowcore.sys_enter_timer;

 	/* Account time spent with enabled wait psw loaded as idle time. */
-	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
-	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
 	account_idle_time(cputime_to_nsecs(idle_time));
 }

diff -u -p /home/julia/linux/mm/mmap.c /tmp/nothing/mm/mmap.c
--- /home/julia/linux/mm/mmap.c
+++ /tmp/nothing/mm/mmap.c
@@ -3476,7 +3476,6 @@ bool may_expand_vm(struct mm_struct *mm,

 void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 {
-	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);

 	if (is_exec_mapping(flags))
 		mm->exec_vm += npages;
diff -u -p /home/julia/linux/fs/xfs/libxfs/xfs_iext_tree.c /tmp/nothing/fs/xfs/libxfs/xfs_iext_tree.c
--- /home/julia/linux/fs/xfs/libxfs/xfs_iext_tree.c
+++ /tmp/nothing/fs/xfs/libxfs/xfs_iext_tree.c
@@ -618,7 +618,6 @@ xfs_iext_realloc_root(
  */
 static inline void xfs_iext_inc_seq(struct xfs_ifork *ifp)
 {
-	WRITE_ONCE(ifp->if_seq, READ_ONCE(ifp->if_seq) + 1);
 }

 void
diff -u -p /home/julia/linux/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c /tmp/nothing/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
--- /home/julia/linux/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ /tmp/nothing/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -379,8 +379,6 @@ static int cn23xx_reset_io_queues(struct
 				q_no);
 			return -1;
 		}
-		WRITE_ONCE(reg_val, READ_ONCE(reg_val) &
-			~CN23XX_PKT_INPUT_CTL_RST);
 		octeon_write_csr64(oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no),
 				   READ_ONCE(reg_val));

@@ -879,9 +877,6 @@ static void cn23xx_disable_io_queues(str
 		/* start the Reset for a particular ring */
 		WRITE_ONCE(d64, octeon_read_csr64(
 			   oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no)));
-		WRITE_ONCE(d64, READ_ONCE(d64) &
-					(~(CN23XX_PKT_INPUT_CTL_RING_ENB)));
-		WRITE_ONCE(d64, READ_ONCE(d64) | CN23XX_PKT_INPUT_CTL_RST);
 		octeon_write_csr64(oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no),
 				   READ_ONCE(d64));

diff -u -p /home/julia/linux/mm/kfence/kfence_test.c /tmp/nothing/mm/kfence/kfence_test.c
--- /home/julia/linux/mm/kfence/kfence_test.c
+++ /tmp/nothing/mm/kfence/kfence_test.c
@@ -501,7 +501,6 @@ static void test_kmalloc_aligned_oob_wri
 	 * fault immediately after it.
 	 */
 	expect.addr = buf + size;
-	WRITE_ONCE(*expect.addr, READ_ONCE(*expect.addr) + 1);
 	KUNIT_EXPECT_FALSE(test, report_available());
 	test_free(buf);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
diff -u -p /home/julia/linux/io_uring/io_uring.c /tmp/nothing/io_uring/io_uring.c
--- /home/julia/linux/io_uring/io_uring.c
+++ /tmp/nothing/io_uring/io_uring.c
@@ -363,7 +363,6 @@ static void io_account_cq_overflow(struc
 {
 	struct io_rings *r = ctx->rings;

-	WRITE_ONCE(r->cq_overflow, READ_ONCE(r->cq_overflow) + 1);
 	ctx->cq_extra--;
 }

@@ -2403,8 +2402,6 @@ static bool io_get_sqe(struct io_ring_ct
 			spin_lock(&ctx->completion_lock);
 			ctx->cq_extra--;
 			spin_unlock(&ctx->completion_lock);
-			WRITE_ONCE(ctx->rings->sq_dropped,
-				   READ_ONCE(ctx->rings->sq_dropped) + 1);
 			return false;
 		}
 	}
diff -u -p /home/julia/linux/security/apparmor/apparmorfs.c /tmp/nothing/security/apparmor/apparmorfs.c
--- /home/julia/linux/security/apparmor/apparmorfs.c
+++ /tmp/nothing/security/apparmor/apparmorfs.c
@@ -596,7 +596,6 @@ static __poll_t ns_revision_poll(struct

 void __aa_bump_ns_revision(struct aa_ns *ns)
 {
-	WRITE_ONCE(ns->revision, READ_ONCE(ns->revision) + 1);
 	wake_up_interruptible(&ns->wait);
 }

diff -u -p /home/julia/linux/arch/riscv/kvm/vmid.c /tmp/nothing/arch/riscv/kvm/vmid.c
--- /home/julia/linux/arch/riscv/kvm/vmid.c
+++ /tmp/nothing/arch/riscv/kvm/vmid.c
@@ -90,7 +90,6 @@ void kvm_riscv_gstage_vmid_update(struct

 	/* First user of a new VMID version? */
 	if (unlikely(vmid_next == 0)) {
-		WRITE_ONCE(vmid_version, READ_ONCE(vmid_version) + 1);
 		vmid_next = 1;

 		/*

