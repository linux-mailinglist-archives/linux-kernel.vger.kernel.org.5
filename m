Return-Path: <linux-kernel+bounces-137877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5DC89E8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F081C22870
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34716C13C;
	Wed, 10 Apr 2024 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK7rigyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B48F44;
	Wed, 10 Apr 2024 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722771; cv=none; b=EMY5/2CRp/uUyenW27qA0xlv+hqAI/M8LWyRItSn5vYaa+XO38Pj8ImQFLVAP113PagvWBShZx96ijqI3xBhP7T1sW9b8oa/AhPMr5dvkmxpEB6xz0Sr1L8j0Hzl6DfYFJVwyWFDfVHN4rFhGpxEzChnE6YlKUlcOUwA9xdqfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722771; c=relaxed/simple;
	bh=S4uAsvA8HSSz8X49Pmn46kPe9tLLupE0nAC6pz7jLiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaBn5XV+uFZsPuOhf5YDkN4YO6J2yU3tUZ/uLiAeDJPEDduOU8DRUdU4EoCZ076U/bGUh/OOGYE/RjeEYlk4dMHgxjVif0hOu9dogN+QFgn5Df9MgY3vSOl5a1MBq0ApMzY9aFoYiYSfoZMXjVSubEWz9QtJ5c7nv3moNAOdxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK7rigyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A04C433F1;
	Wed, 10 Apr 2024 04:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712722770;
	bh=S4uAsvA8HSSz8X49Pmn46kPe9tLLupE0nAC6pz7jLiI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eK7rigyVuKR+aXShFlDk4wQum35dyXlQ+9rZ6ka5cwEoKaQZFyO7oFVA/gI7598uz
	 rIwEGfKwO7pTnfSkOcT5Kycm3ZAk4bjrBfUhyB4VUWzI08Z8AAMQZGYCpo9XT1EUk4
	 aiYpnwOUBVQFrg9yvdb0iPRckV9PLusumMxN2o0vjc5Bq9wpeaSesH6x9YEQLnr77H
	 WiwE/YXLKCV/e5+Pws7zTRaFdOipbmxb4Ueah3zkbzfX/rkHbwWMy6X12R1k+8bEVI
	 EJ1UFEhn3RpxKu80fjb3vA+FyPyspBdtVNPMlhuG/TTpM2sk2ELd1KICI7FbvWn0eC
	 YbD6jAgWry3tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0639CE2D22; Tue,  9 Apr 2024 21:19:29 -0700 (PDT)
Date: Tue, 9 Apr 2024 21:19:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Make rcutorture support srcu double call
 test
Message-ID: <3d9f3465-dda8-44e4-9cde-3225306496a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240407112714.24460-1-qiang.zhang1211@gmail.com>
 <a511e1a5-9218-4b21-9bb4-72b285397492@paulmck-laptop>
 <CALm+0cWeZx5sZ7JJ-xdYPfxP4fs905iMmvyNPLJRj+262FpiGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cWeZx5sZ7JJ-xdYPfxP4fs905iMmvyNPLJRj+262FpiGg@mail.gmail.com>

On Wed, Apr 10, 2024 at 10:57:46AM +0800, Z qiang wrote:
> On Wed, Apr 10, 2024 at 4:05 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Apr 07, 2024 at 07:27:14PM +0800, Zqiang wrote:
> > > This commit also allows rcutorture to support srcu double call test
> > > with CONFIG_DEBUG_OBJECTS_RCU_HEAD option enabled. the non-raw sdp
> > > structure's->spinlock will be acquired in call_srcu(), in Preempt-RT
> > > kernels, this spinlock is sleepable, therefore remove disable-irq and
> > > disable-preempt protection.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/rcutorture.c | 46 +++++++++++++++++++++++------------------
> > >  1 file changed, 26 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 807fbf6123a7..44cc455e1b61 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -390,6 +390,7 @@ struct rcu_torture_ops {
> > >       int extendables;
> > >       int slow_gps;
> > >       int no_pi_lock;
> > > +     int debug_objects;
> > >       const char *name;
> > >  };
> > >
> > > @@ -577,6 +578,7 @@ static struct rcu_torture_ops rcu_ops = {
> > >       .irq_capable            = 1,
> > >       .can_boost              = IS_ENABLED(CONFIG_RCU_BOOST),
> > >       .extendables            = RCUTORTURE_MAX_EXTEND,
> > > +     .debug_objects          = 1,
> > >       .name                   = "rcu"
> > >  };
> > >
> > > @@ -747,6 +749,7 @@ static struct rcu_torture_ops srcu_ops = {
> > >       .cbflood_max    = 50000,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > > +     .debug_objects  = 1,
> > >       .name           = "srcu"
> > >  };
> > >
> > > @@ -786,6 +789,7 @@ static struct rcu_torture_ops srcud_ops = {
> > >       .cbflood_max    = 50000,
> > >       .irq_capable    = 1,
> > >       .no_pi_lock     = IS_ENABLED(CONFIG_TINY_SRCU),
> > > +     .debug_objects  = 1,
> > >       .name           = "srcud"
> > >  };
> > >
> > > @@ -3455,7 +3459,6 @@ rcu_torture_cleanup(void)
> > >               cur_ops->gp_slow_unregister(NULL);
> > >  }
> > >
> > > -#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > >  static void rcu_torture_leak_cb(struct rcu_head *rhp)
> > >  {
> > >  }
> > > @@ -3473,7 +3476,6 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
> > >        */
> > >       pr_alert("%s: duplicated callback was invoked.\n", KBUILD_MODNAME);
> > >  }
> > > -#endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > >
> > >  /*
> > >   * Verify that double-free causes debug-objects to complain, but only
> > > @@ -3482,39 +3484,43 @@ static void rcu_torture_err_cb(struct rcu_head *rhp)
> > >   */
> > >  static void rcu_test_debug_objects(void)
> > >  {
> > > -#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > >       struct rcu_head rh1;
> > >       struct rcu_head rh2;
> > > +     int idx;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_DEBUG_OBJECTS_RCU_HEAD)) {
> > > +             pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_%s()\n",
> > > +                                     KBUILD_MODNAME, cur_ops->name);
> > > +             return;
> > > +     }
> > > +
> > > +     if (WARN_ON_ONCE(cur_ops->debug_objects &&
> > > +                     (!cur_ops->call || !cur_ops->cb_barrier)))
> > > +             return;
> > > +
> > >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > >
> > >       init_rcu_head_on_stack(&rh1);
> > >       init_rcu_head_on_stack(&rh2);
> > > -     pr_alert("%s: WARN: Duplicate call_rcu() test starting.\n", KBUILD_MODNAME);
> > > +     pr_alert("%s: WARN: Duplicate call_%s() test starting.\n", KBUILD_MODNAME, cur_ops->name);
> > >
> > >       /* Try to queue the rh2 pair of callbacks for the same grace period. */
> > > -     preempt_disable(); /* Prevent preemption from interrupting test. */
> > > -     rcu_read_lock(); /* Make it impossible to finish a grace period. */
> > > -     call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> > > -     local_irq_disable(); /* Make it harder to start a new grace period. */
> > > -     call_rcu_hurry(&rh2, rcu_torture_leak_cb);
> > > -     call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> > > +     idx = cur_ops->readlock(); /* Make it impossible to finish a grace period. */
> > > +     cur_ops->call(&rh1, rcu_torture_leak_cb); /* Start grace period. */
> > > +     cur_ops->call(&rh2, rcu_torture_leak_cb);
> > > +     cur_ops->call(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
> > >       if (rhp) {
> > > -             call_rcu_hurry(rhp, rcu_torture_leak_cb);
> > > -             call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> > > +             cur_ops->call(rhp, rcu_torture_leak_cb);
> > > +             cur_ops->call(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
> > >       }
> > > -     local_irq_enable();
> > > -     rcu_read_unlock();
> > > -     preempt_enable();
> > > +     cur_ops->readunlock(idx);
> > >
> > >       /* Wait for them all to get done so we can safely return. */
> > > -     rcu_barrier();
> > > -     pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
> > > +     cur_ops->cb_barrier();
> > > +     pr_alert("%s: WARN: Duplicate call_%s() test complete.\n", KBUILD_MODNAME, cur_ops->name);
> >
> > This will get us "call_srcud() test", but if there are complaints yet
> > another string can be added to the nrcu_torture_ops structure.
> >
> > So I have queued this for testing and further review.
> 
> Thanks, Paul, I think I should add my test results, the attachment
> is the test results :) .

What I will do is put a Link: to this email thread, so that these
test results can be found from the commit.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >                                                         Thanx, Paul
> >
> > >       destroy_rcu_head_on_stack(&rh1);
> > >       destroy_rcu_head_on_stack(&rh2);
> > >       kfree(rhp);
> > > -#else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > > -     pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
> > > -#endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > >  }
> > >
> > >  static void rcutorture_sync(void)
> > > --
> > > 2.17.1
> > >

> [  154.225867] torture module --- srcud:  disable_onoff_at_boot=0 ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 verbose_sleep_duration=1 random_shuffle=0
> [  154.226021] srcud-torture:--- Start of test: nreaders=7 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=4 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
> [  154.226034] srcud:  Start-test grace-period state: g0 f0x0
> [  154.226044] rcu_torture_write_types: Testing expedited GPs.
> [  154.226049] rcu_torture_write_types: Testing asynchronous GPs.
> [  154.226055] rcu_torture_write_types: Testing normal GPs.
> [  154.226060] srcud-torture: Creating rcu_torture_writer task
> [  154.226857] srcud-torture: Creating rcu_torture_fakewriter task
> [  154.226860] srcud-torture: rcu_torture_writer task started
> [  154.226866] srcud-torture: GP expediting controlled from boot/sysfs for srcud.
> [  154.227207] srcud-torture: Creating rcu_torture_fakewriter task
> [  154.227211] srcud-torture: rcu_torture_fakewriter task started
> [  154.227670] srcud-torture: rcu_torture_fakewriter task started
> [  154.227670] srcud-torture: Creating rcu_torture_fakewriter task
> [  154.228092] srcud-torture: Creating rcu_torture_fakewriter task
> [  154.228106] srcud-torture: rcu_torture_fakewriter task started
> [  154.228569] srcud-torture: rcu_torture_fakewriter task started
> [  154.228596] srcud-torture: Creating rcu_torture_reader task
> [  154.229168] srcud-torture: rcu_torture_reader task started
> [  154.229180] srcud-torture: Creating rcu_torture_reader task
> [  154.229776] srcud-torture: Creating rcu_torture_reader task
> [  154.229777] srcud-torture: rcu_torture_reader task started
> [  154.230188] srcud-torture: rcu_torture_reader task started
> [  154.230193] srcud-torture: Creating rcu_torture_reader task
> [  154.230604] srcud-torture: Creating rcu_torture_reader task
> [  154.230605] srcud-torture: rcu_torture_reader task started
> [  154.231046] srcud-torture: rcu_torture_reader task started
> [  154.231056] srcud-torture: Creating rcu_torture_reader task
> [  154.231600] srcud-torture: rcu_torture_reader task started
> [  154.231624] srcud-torture: Creating rcu_torture_reader task
> [  154.232386] srcud-torture: rcu_torture_reader task started
> [  154.232395] srcud-torture: Creating rcu_torture_stats task
> [  154.232906] srcud-torture: Creating torture_shuffle task
> [  154.233342] srcud-torture: torture_shuffle task started
> [  154.233401] srcud-torture: Creating torture_stutter task
> [  154.233939] srcud-torture: Creating rcu_torture_fwd_prog task
> [  154.234034] srcud-torture: torture_stutter task started
> [  154.234061] srcud-torture: rcu_torture_stats task started
> [  154.234435] srcud-torture: Creating rcu_torture_fwd_prog task
> [  154.234464] srcud-torture: rcu_torture_fwd_progress task started
> [  154.234878] srcud-torture: Creating rcu_torture_fwd_prog task
> [  154.234886] srcud-torture: rcu_torture_fwd_progress task started
> [  154.235301] srcud-torture: rcu_torture_fwd_progress task started
> [  154.235318] srcud-torture: Creating rcu_torture_fwd_prog task
> [  154.235696] srcud-torture: rcu_torture_fwd_progress task started
> [  154.235753] srcud-torture: Creating rcu_torture_barrier_cbs task
> [  154.236216] srcud-torture: rcu_torture_barrier_cbs task started
> [  154.236226] srcud-torture: Creating rcu_torture_barrier_cbs task
> [  154.236693] srcud-torture: rcu_torture_barrier_cbs task started
> [  154.236697] srcud-torture: Creating rcu_torture_barrier_cbs task
> [  154.237067] srcud-torture: rcu_torture_barrier_cbs task started
> [  154.237075] srcud-torture: Creating rcu_torture_barrier_cbs task
> [  154.237515] srcud-torture: rcu_torture_barrier_cbs task started
> [  154.237518] srcud-torture: Creating rcu_torture_barrier task
> [  154.237803] srcud-torture: rcu_torture_barrier task starting
> [  154.237807] srcud-torture: Creating rcu_torture_read_exit task
> [  154.238571] rcutorture: WARN: Duplicate call_srcud() test starting.
> [  154.238611] ------------[ cut here ]------------
> [  154.238623] ODEBUG: activate active (active state 1) object: 00000000cd0f4bb6 object type: rcu_head hint: 0x0
> [  154.238672] WARNING: CPU: 5 PID: 561 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  154.238689] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  154.238717] CPU: 5 PID: 561 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  154.238727] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  154.238735] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  154.238744] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  154.238752] RSP: 0018:ffff88800a1c7528 EFLAGS: 00010296
> [  154.238764] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  154.238771] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  154.238777] RBP: ffff88800a1c7580 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  154.238784] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000005
> [  154.238791] R13: ffffffff934f1a80 R14: ffff88800a1c75d8 R15: 0000000000000000
> [  154.238798] FS:  00007f8994384380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [  154.238808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  154.238815] CR2: 00007f78a53f3218 CR3: 000000000761e000 CR4: 00000000001506f0
> [  154.238822] Call Trace:
> [  154.238828]  <TASK>
> [  154.238837]  ? show_regs+0x65/0x70
> [  154.238851]  ? __warn+0xd0/0x300
> [  154.238867]  ? debug_print_object+0x1a4/0x2d0
> [  154.238881]  ? report_bug+0x23e/0x490
> [  154.238908]  ? handle_bug+0x43/0x80
> [  154.238920]  ? exc_invalid_op+0x1c/0x50
> [  154.238933]  ? asm_exc_invalid_op+0x1f/0x30
> [  154.238969]  ? debug_print_object+0x1a4/0x2d0
> [  154.238985]  ? debug_print_object+0x1a4/0x2d0
> [  154.238995]  ? debug_object_activate+0x223/0x310
> [  154.239008]  ? preempt_count_sub+0x124/0x1b0
> [  154.239029]  debug_object_activate+0x234/0x310
> [  154.239045]  ? __pfx_debug_object_activate+0x10/0x10
> [  154.239064]  ? __pfx_lock_acquire+0x10/0x10
> [  154.239074]  ? __pfx___debug_object_init+0x10/0x10
> [  154.239086]  ? _printk+0xa4/0xd0
> [  154.239107]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239146]  __call_srcu+0x2d/0xe0
> [  154.239166]  call_srcu+0x17/0x20
> [  154.239176]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239203]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239227]  ? __pfx_stack_trace_save+0x10/0x10
> [  154.239288]  ? kvm_sched_clock_read+0x11/0x30
> [  154.239319]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239370]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.239402]  ? __pfx_lock_release+0x10/0x10
> [  154.239420]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239444]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.239453]  ? __create_object+0x68/0xa0
> [  154.239457] srcud-torture: rcu_torture_read_exit: Start of test
> [  154.239464] srcud-torture: rcu_torture_read_exit: Start of episode
> [  154.239469]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.239480]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239520]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.239544]  do_one_initcall+0xdb/0x410
> [  154.239559]  ? __pfx_do_one_initcall+0x10/0x10
> [  154.239571]  ? kasan_save_alloc_info+0x3b/0x50
> [  154.239586]  ? __kasan_kmalloc+0x86/0xa0
> [  154.239595]  ? kasan_poison+0x3e/0x60
> [  154.239605]  ? kasan_unpoison+0x2c/0x60
> [  154.239616]  ? kasan_poison+0x3e/0x60
> [  154.239627]  ? __asan_register_globals+0x62/0x80
> [  154.239649]  do_init_module+0x264/0x670
> [  154.239697]  load_module+0x52ea/0x6680
> [  154.239760]  ? __pfx_load_module+0x10/0x10
> [  154.239768]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.239788]  ? __kasan_check_read+0x15/0x20
> [  154.239797]  ? rw_verify_area+0x18c/0x490
> [  154.239866]  init_module_from_file+0xf2/0x150
> [  154.239875]  ? init_module_from_file+0xf2/0x150
> [  154.239885]  ? __pfx_init_module_from_file+0x10/0x10
> [  154.239892]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.239938]  ? trace_preempt_on+0x54/0x110
> [  154.239948]  ? idempotent_init_module+0x3a6/0x830
> [  154.239957]  ? preempt_count_sub+0x124/0x1b0
> [  154.239975]  idempotent_init_module+0x3c2/0x830
> [  154.240009]  ? __pfx_idempotent_init_module+0x10/0x10
> [  154.240046]  ? __kasan_check_read+0x15/0x20
> [  154.240055]  ? __fget_light+0x58/0x1f0
> [  154.240062]  ? ns_capable_common+0x66/0xf0
> [  154.240081]  __x64_sys_finit_module+0xc9/0x140
> [  154.240095]  do_syscall_64+0x9d/0x1a0
> [  154.240110]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  154.240117] RIP: 0033:0x7f8993d20b7d
> [  154.240126] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  154.240133] RSP: 002b:00007ffc023a7e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  154.240144] RAX: ffffffffffffffda RBX: 00005624448084f0 RCX: 00007f8993d20b7d
> [  154.240150] RDX: 0000000000000000 RSI: 00005624448072a0 RDI: 0000000000000003
> [  154.240156] RBP: 00005624448072a0 R08: 0000000000000000 R09: 00005624448072a0
> [  154.240162] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  154.240167] R13: 0000000000000000 R14: 00007ffc023a8ef7 R15: 00005624448072a0
> [  154.240206]  </TASK>
> [  154.240211] irq event stamp: 19205
> [  154.240217] hardirqs last  enabled at (19211): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  154.240226] hardirqs last disabled at (19216): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  154.240234] softirqs last  enabled at (18906): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  154.240268] softirqs last disabled at (18899): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  154.240282] ---[ end trace 0000000000000000 ]---
> [  154.240327] ------------[ cut here ]------------
> [  154.240338] ODEBUG: active_state active (active state 1) object: 00000000cd0f4bb6 object type: rcu_head hint: 0x0
> [  154.240373] WARNING: CPU: 5 PID: 561 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  154.240384] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  154.240408] CPU: 5 PID: 561 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  154.240417] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  154.240423] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  154.240432] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  154.240439] RSP: 0018:ffff88800a1c7518 EFLAGS: 00010292
> [  154.240449] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  154.240455] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  154.240462] RBP: ffff88800a1c7570 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  154.240468] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000006
> [  154.240474] R13: ffffffff934f1a80 R14: ffff88800a1c75d8 R15: 0000000000000000
> [  154.240481] FS:  00007f8994384380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [  154.240505] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  154.240512] CR2: 00007f78a53f3218 CR3: 000000000761e000 CR4: 00000000001506f0
> [  154.240518] Call Trace:
> [  154.240523]  <TASK>
> [  154.240531]  ? show_regs+0x65/0x70
> [  154.240542]  ? __warn+0xd0/0x300
> [  154.240555]  ? debug_print_object+0x1a4/0x2d0
> [  154.240567]  ? report_bug+0x23e/0x490
> [  154.240591]  ? handle_bug+0x43/0x80
> [  154.240601]  ? exc_invalid_op+0x1c/0x50
> [  154.240612]  ? asm_exc_invalid_op+0x1f/0x30
> [  154.240643]  ? debug_print_object+0x1a4/0x2d0
> [  154.240657]  ? debug_print_object+0x1a4/0x2d0
> [  154.240666]  ? debug_object_active_state+0x20a/0x470
> [  154.240677]  ? preempt_count_sub+0x124/0x1b0
> [  154.240695]  debug_object_active_state+0x21b/0x470
> [  154.240704]  ? debug_object_activate+0x234/0x310
> [  154.240718]  ? __pfx_debug_object_active_state+0x10/0x10
> [  154.240735]  ? __pfx_lock_acquire+0x10/0x10
> [  154.240743]  ? __pfx___debug_object_init+0x10/0x10
> [  154.240754]  ? _printk+0xa4/0xd0
> [  154.240772]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.240795]  __call_srcu+0x46/0xe0
> [  154.240812]  call_srcu+0x17/0x20
> [  154.240821]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.240843]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.240865]  ? __pfx_stack_trace_save+0x10/0x10
> [  154.240876]  ? kvm_sched_clock_read+0x11/0x30
> [  154.240891]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.240915]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.240937]  ? __pfx_lock_release+0x10/0x10
> [  154.240948]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.240968]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.240976]  ? __create_object+0x68/0xa0
> [  154.240988]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.240997]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.241033]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.241054]  do_one_initcall+0xdb/0x410
> [  154.241067]  ? __pfx_do_one_initcall+0x10/0x10
> [  154.241077]  ? kasan_save_alloc_info+0x3b/0x50
> [  154.241089]  ? __kasan_kmalloc+0x86/0xa0
> [  154.241097]  ? kasan_poison+0x3e/0x60
> [  154.241106]  ? kasan_unpoison+0x2c/0x60
> [  154.241116]  ? kasan_poison+0x3e/0x60
> [  154.241125]  ? __asan_register_globals+0x62/0x80
> [  154.241144]  do_init_module+0x264/0x670
> [  154.241171]  load_module+0x52ea/0x6680
> [  154.241395]  ? __pfx_load_module+0x10/0x10
> [  154.241405]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.241425]  ? __kasan_check_read+0x15/0x20
> [  154.241434]  ? rw_verify_area+0x18c/0x490
> [  154.241501]  init_module_from_file+0xf2/0x150
> [  154.241509]  ? init_module_from_file+0xf2/0x150
> [  154.241519]  ? __pfx_init_module_from_file+0x10/0x10
> [  154.241525]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.241570]  ? trace_preempt_on+0x54/0x110
> [  154.241579]  ? idempotent_init_module+0x3a6/0x830
> [  154.241589]  ? preempt_count_sub+0x124/0x1b0
> [  154.241605]  idempotent_init_module+0x3c2/0x830
> [  154.241629]  ? __pfx_idempotent_init_module+0x10/0x10
> [  154.241667]  ? __kasan_check_read+0x15/0x20
> [  154.241677]  ? __fget_light+0x58/0x1f0
> [  154.241683]  ? ns_capable_common+0x66/0xf0
> [  154.241701]  __x64_sys_finit_module+0xc9/0x140
> [  154.241715]  do_syscall_64+0x9d/0x1a0
> [  154.241730]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  154.241737] RIP: 0033:0x7f8993d20b7d
> [  154.241745] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  154.241751] RSP: 002b:00007ffc023a7e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  154.241762] RAX: ffffffffffffffda RBX: 00005624448084f0 RCX: 00007f8993d20b7d
> [  154.241768] RDX: 0000000000000000 RSI: 00005624448072a0 RDI: 0000000000000003
> [  154.241774] RBP: 00005624448072a0 R08: 0000000000000000 R09: 00005624448072a0
> [  154.241780] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  154.241785] R13: 0000000000000000 R14: 00007ffc023a8ef7 R15: 00005624448072a0
> [  154.241824]  </TASK>
> [  154.241829] irq event stamp: 19835
> [  154.241834] hardirqs last  enabled at (19841): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  154.241843] hardirqs last disabled at (19846): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  154.241850] softirqs last  enabled at (19660): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  154.241859] softirqs last disabled at (19655): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  154.241866] ---[ end trace 0000000000000000 ]---
> [  154.241880] ------------[ cut here ]------------
> [  154.241885] ODEBUG: activate active (active state 1) object: 000000007d110013 object type: rcu_head hint: 0x0
> [  154.241912] WARNING: CPU: 5 PID: 561 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  154.241922] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  154.241944] CPU: 5 PID: 561 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  154.241974] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  154.241980] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  154.241989] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  154.241996] RSP: 0018:ffff88800a1c7528 EFLAGS: 00010296
> [  154.242006] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  154.242012] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  154.242018] RBP: ffff88800a1c7580 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  154.242024] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000007
> [  154.242030] R13: ffffffff934f1a80 R14: ffff88800a1c75d8 R15: 0000000000000000
> [  154.242037] FS:  00007f8994384380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [  154.242046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  154.242052] CR2: 00007f78a53f3218 CR3: 000000000761e000 CR4: 00000000001506f0
> [  154.242059] Call Trace:
> [  154.242064]  <TASK>
> [  154.242072]  ? show_regs+0x65/0x70
> [  154.242084]  ? __warn+0xd0/0x300
> [  154.242098]  ? debug_print_object+0x1a4/0x2d0
> [  154.242111]  ? report_bug+0x23e/0x490
> [  154.242136]  ? handle_bug+0x43/0x80
> [  154.242146]  ? exc_invalid_op+0x1c/0x50
> [  154.242183]  ? asm_exc_invalid_op+0x1f/0x30
> [  154.242254]  ? debug_print_object+0x1a4/0x2d0
> [  154.242321]  ? debug_print_object+0x1a4/0x2d0
> [  154.242340]  ? debug_object_activate+0x223/0x310
> [  154.242359]  ? preempt_count_sub+0x124/0x1b0
> [  154.242381]  debug_object_activate+0x234/0x310
> [  154.242395]  ? __pfx_debug_object_activate+0x10/0x10
> [  154.242413]  ? __pfx_lock_acquire+0x10/0x10
> [  154.242421]  ? __pfx___debug_object_init+0x10/0x10
> [  154.242431]  ? _printk+0xa4/0xd0
> [  154.242449]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.242473]  __call_srcu+0x2d/0xe0
> [  154.242489]  call_srcu+0x17/0x20
> [  154.242498]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.242521]  rcu_torture_init+0x296d/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.242571]  ? __pfx_stack_trace_save+0x10/0x10
> [  154.242582]  ? kvm_sched_clock_read+0x11/0x30
> [  154.242598]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.242624]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.242661]  ? __pfx_lock_release+0x10/0x10
> [  154.242672]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.242692]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.242700]  ? __create_object+0x68/0xa0
> [  154.242712]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.242721]  ? __pfx_srcu_leak_callback+0x10/0x10
> [  154.242743]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.242764]  do_one_initcall+0xdb/0x410
> [  154.242776]  ? __pfx_do_one_initcall+0x10/0x10
> [  154.242786]  ? kasan_save_alloc_info+0x3b/0x50
> [  154.242798]  ? __kasan_kmalloc+0x86/0xa0
> [  154.242806]  ? kasan_poison+0x3e/0x60
> [  154.242815]  ? kasan_unpoison+0x2c/0x60
> [  154.242825]  ? kasan_poison+0x3e/0x60
> [  154.242834]  ? __asan_register_globals+0x62/0x80
> [  154.242853]  do_init_module+0x264/0x670
> [  154.242880]  load_module+0x52ea/0x6680
> [  154.242942]  ? __pfx_load_module+0x10/0x10
> [  154.242949]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.242968]  ? __kasan_check_read+0x15/0x20
> [  154.242977]  ? rw_verify_area+0x18c/0x490
> [  154.243044]  init_module_from_file+0xf2/0x150
> [  154.243052]  ? init_module_from_file+0xf2/0x150
> [  154.243062]  ? __pfx_init_module_from_file+0x10/0x10
> [  154.243068]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.243113]  ? trace_preempt_on+0x54/0x110
> [  154.243122]  ? idempotent_init_module+0x3a6/0x830
> [  154.243132]  ? preempt_count_sub+0x124/0x1b0
> [  154.243148]  idempotent_init_module+0x3c2/0x830
> [  154.243167]  ? __pfx_idempotent_init_module+0x10/0x10
> [  154.243204]  ? __kasan_check_read+0x15/0x20
> [  154.243213]  ? __fget_light+0x58/0x1f0
> [  154.243220]  ? ns_capable_common+0x66/0xf0
> [  154.243238]  __x64_sys_finit_module+0xc9/0x140
> [  154.243274]  do_syscall_64+0x9d/0x1a0
> [  154.243289]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  154.243297] RIP: 0033:0x7f8993d20b7d
> [  154.243322] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  154.243362] RSP: 002b:00007ffc023a7e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  154.243380] RAX: ffffffffffffffda RBX: 00005624448084f0 RCX: 00007f8993d20b7d
> [  154.243387] RDX: 0000000000000000 RSI: 00005624448072a0 RDI: 0000000000000003
> [  154.243393] RBP: 00005624448072a0 R08: 0000000000000000 R09: 00005624448072a0
> [  154.243399] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  154.243405] R13: 0000000000000000 R14: 00007ffc023a8ef7 R15: 00005624448072a0
> [  154.243443]  </TASK>
> [  154.243448] irq event stamp: 20459
> [  154.243454] hardirqs last  enabled at (20465): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  154.243462] hardirqs last disabled at (20470): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  154.243470] softirqs last  enabled at (20408): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  154.243478] softirqs last disabled at (20403): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  154.243486] ---[ end trace 0000000000000000 ]---
> [  154.243493] ------------[ cut here ]------------
> [  154.243498] ODEBUG: active_state active (active state 1) object: 000000007d110013 object type: rcu_head hint: 0x0
> [  154.243525] WARNING: CPU: 5 PID: 561 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  154.243535] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  154.243558] CPU: 5 PID: 561 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  154.243565] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  154.243571] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  154.243579] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  154.243586] RSP: 0018:ffff88800a1c7518 EFLAGS: 00010292
> [  154.243595] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  154.243601] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  154.243607] RBP: ffff88800a1c7570 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  154.243613] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000008
> [  154.243618] R13: ffffffff934f1a80 R14: ffff88800a1c75d8 R15: 0000000000000000
> [  154.243624] FS:  00007f8994384380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [  154.243633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  154.243639] CR2: 00007f78a53f3218 CR3: 000000000761e000 CR4: 00000000001506f0
> [  154.243645] Call Trace:
> [  154.243650]  <TASK>
> [  154.243657]  ? show_regs+0x65/0x70
> [  154.243668]  ? __warn+0xd0/0x300
> [  154.243681]  ? debug_print_object+0x1a4/0x2d0
> [  154.243700]  ? report_bug+0x23e/0x490
> [  154.243723]  ? handle_bug+0x43/0x80
> [  154.243733]  ? exc_invalid_op+0x1c/0x50
> [  154.243744]  ? asm_exc_invalid_op+0x1f/0x30
> [  154.243775]  ? debug_print_object+0x1a4/0x2d0
> [  154.243789]  ? debug_print_object+0x1a4/0x2d0
> [  154.243798]  ? debug_object_active_state+0x20a/0x470
> [  154.243809]  ? preempt_count_sub+0x124/0x1b0
> [  154.243827]  debug_object_active_state+0x21b/0x470
> [  154.243836]  ? debug_object_activate+0x234/0x310
> [  154.243850]  ? __pfx_debug_object_active_state+0x10/0x10
> [  154.243867]  ? __pfx_lock_acquire+0x10/0x10
> [  154.243874]  ? __pfx___debug_object_init+0x10/0x10
> [  154.243885]  ? _printk+0xa4/0xd0
> [  154.243903]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.243925]  __call_srcu+0x46/0xe0
> [  154.243942]  call_srcu+0x17/0x20
> [  154.243951]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.243973]  rcu_torture_init+0x296d/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.243994]  ? __pfx_stack_trace_save+0x10/0x10
> [  154.244005]  ? kvm_sched_clock_read+0x11/0x30
> [  154.244019]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.244043]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.244066]  ? __pfx_lock_release+0x10/0x10
> [  154.244077]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.244096]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.244104]  ? __create_object+0x68/0xa0
> [  154.244116]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  154.244125]  ? __pfx_srcu_leak_callback+0x10/0x10
> [  154.244160]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  154.244178]  do_one_initcall+0xdb/0x410
> [  154.244189]  ? __pfx_do_one_initcall+0x10/0x10
> [  154.244198]  ? kasan_save_alloc_info+0x3b/0x50
> [  154.244209]  ? __kasan_kmalloc+0x86/0xa0
> [  154.244216]  ? kasan_poison+0x3e/0x60
> [  154.244224]  ? kasan_unpoison+0x2c/0x60
> [  154.244233]  ? kasan_poison+0x3e/0x60
> [  154.244261]  ? __asan_register_globals+0x62/0x80
> [  154.244302]  do_init_module+0x264/0x670
> [  154.244331]  load_module+0x52ea/0x6680
> [  154.244410]  ? __pfx_load_module+0x10/0x10
> [  154.244417]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.244434]  ? __kasan_check_read+0x15/0x20
> [  154.244442]  ? rw_verify_area+0x18c/0x490
> [  154.244533]  init_module_from_file+0xf2/0x150
> [  154.244542]  ? init_module_from_file+0xf2/0x150
> [  154.244552]  ? __pfx_init_module_from_file+0x10/0x10
> [  154.244559]  ? __this_cpu_preempt_check+0x17/0x20
> [  154.244614]  ? trace_preempt_on+0x54/0x110
> [  154.244622]  ? idempotent_init_module+0x3a6/0x830
> [  154.244630]  ? preempt_count_sub+0x124/0x1b0
> [  154.244645]  idempotent_init_module+0x3c2/0x830
> [  154.244662]  ? __pfx_idempotent_init_module+0x10/0x10
> [  154.244717]  ? __kasan_check_read+0x15/0x20
> [  154.244726]  ? __fget_light+0x58/0x1f0
> [  154.244733]  ? ns_capable_common+0x66/0xf0
> [  154.244751]  __x64_sys_finit_module+0xc9/0x140
> [  154.244766]  do_syscall_64+0x9d/0x1a0
> [  154.244781]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  154.244788] RIP: 0033:0x7f8993d20b7d
> [  154.244796] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  154.244803] RSP: 002b:00007ffc023a7e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  154.244813] RAX: ffffffffffffffda RBX: 00005624448084f0 RCX: 00007f8993d20b7d
> [  154.244819] RDX: 0000000000000000 RSI: 00005624448072a0 RDI: 0000000000000003
> [  154.244825] RBP: 00005624448072a0 R08: 0000000000000000 R09: 00005624448072a0
> [  154.244831] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  154.244837] R13: 0000000000000000 R14: 00007ffc023a8ef7 R15: 00005624448072a0
> [  154.244876]  </TASK>
> [  154.244882] irq event stamp: 21075
> [  154.244887] hardirqs last  enabled at (21081): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  154.244895] hardirqs last disabled at (21086): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  154.244903] softirqs last  enabled at (20408): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  154.244911] softirqs last disabled at (20403): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  154.244919] ---[ end trace 0000000000000000 ]---
> [  154.255482] rcutorture: WARN: Duplicate call_srcud() test complete.
> [  159.249134] srcud-torture: rcu_torture_read_exit: End of episode

> [   52.744716] torture module --- srcu:  disable_onoff_at_boot=0 ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 verbose_sleep_duration=1 random_shuffle=0
> [   52.744739] srcu-torture:--- Start of test: nreaders=7 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=4 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
> [   52.744749] srcu:  Start-test grace-period state: g0 f0x0
> [   52.744758] rcu_torture_write_types: Testing expedited GPs.
> [   52.744763] rcu_torture_write_types: Testing asynchronous GPs.
> [   52.744767] rcu_torture_write_types: Testing normal GPs.
> [   52.744772] srcu-torture: Creating rcu_torture_writer task
> [   52.745472] srcu-torture: rcu_torture_writer task started
> [   52.745486] srcu-torture: Creating rcu_torture_fakewriter task
> [   52.745487] srcu-torture: GP expediting controlled from boot/sysfs for srcu.
> [   52.745967] srcu-torture: rcu_torture_fakewriter task started
> [   52.745975] srcu-torture: Creating rcu_torture_fakewriter task
> [   52.746486] srcu-torture: Creating rcu_torture_fakewriter task
> [   52.746495] srcu-torture: rcu_torture_fakewriter task started
> [   52.746964] srcu-torture: rcu_torture_fakewriter task started
> [   52.747164] srcu-torture: Creating rcu_torture_fakewriter task
> [   52.747679] srcu-torture: rcu_torture_fakewriter task started
> [   52.747718] srcu-torture: Creating rcu_torture_reader task
> [   52.748201] srcu-torture: Creating rcu_torture_reader task
> [   52.748202] srcu-torture: rcu_torture_reader task started
> [   52.748677] srcu-torture: Creating rcu_torture_reader task
> [   52.748680] srcu-torture: rcu_torture_reader task started
> [   52.749185] srcu-torture: rcu_torture_reader task started
> [   52.749197] srcu-torture: Creating rcu_torture_reader task
> [   52.749666] srcu-torture: rcu_torture_reader task started
> [   52.749686] srcu-torture: Creating rcu_torture_reader task
> [   52.750117] srcu-torture: rcu_torture_reader task started
> [   52.750140] srcu-torture: Creating rcu_torture_reader task
> [   52.750525] srcu-torture: rcu_torture_reader task started
> [   52.750537] srcu-torture: Creating rcu_torture_reader task
> [   52.751545] srcu-torture: Creating rcu_torture_stats task
> [   52.751552] srcu-torture: rcu_torture_reader task started
> [   52.752498] srcu-torture: rcu_torture_stats task started
> [   52.752529] srcu-torture: Creating torture_shuffle task
> [   52.753222] srcu-torture: Creating torture_stutter task
> [   52.753387] srcu-torture: torture_shuffle task started
> [   52.756610] srcu-torture: torture_stutter task started
> [   52.756919] srcu-torture: Creating rcu_torture_fwd_prog task
> [   52.757400] srcu-torture: Creating rcu_torture_fwd_prog task
> [   52.757461] srcu-torture: rcu_torture_fwd_progress task started
> [   52.757759] srcu-torture: rcu_torture_fwd_progress task started
> [   52.757778] srcu-torture: Creating rcu_torture_fwd_prog task
> [   52.758125] srcu-torture: Creating rcu_torture_fwd_prog task
> [   52.758137] srcu-torture: rcu_torture_fwd_progress task started
> [   52.758545] srcu-torture: rcu_torture_fwd_progress task started
> [   52.758589] srcu-torture: Creating rcu_torture_barrier_cbs task
> [   52.758868] srcu-torture: Creating rcu_torture_barrier_cbs task
> [   52.758898] srcu-torture: rcu_torture_barrier_cbs task started
> [   52.759227] srcu-torture: Creating rcu_torture_barrier_cbs task
> [   52.759232] srcu-torture: rcu_torture_barrier_cbs task started
> [   52.759582] srcu-torture: Creating rcu_torture_barrier_cbs task
> [   52.759582] srcu-torture: rcu_torture_barrier_cbs task started
> [   52.759881] srcu-torture: rcu_torture_barrier_cbs task started
> [   52.759884] srcu-torture: Creating rcu_torture_barrier task
> [   52.760384] srcu-torture: Creating rcu_torture_read_exit task
> [   52.760384] srcu-torture: rcu_torture_barrier task starting
> [   52.760961] srcu-torture: rcu_torture_read_exit: Start of test
> [   52.760972] srcu-torture: rcu_torture_read_exit: Start of episode
> [   52.761009] rcutorture: WARN: Duplicate call_srcu() test starting.
> [   52.761153] ------------[ cut here ]------------
> [   52.761178] ODEBUG: activate active (active state 1) object: 00000000bf20720c object type: rcu_head hint: 0x0
> [   52.761344] WARNING: CPU: 5 PID: 431 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [   52.761372] Modules linked in: rcutorture(+) torture
> [   52.761414] CPU: 5 PID: 431 Comm: insmod Not tainted 6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [   52.761426] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [   52.761434] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [   52.761444] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [   52.761452] RSP: 0018:ffff888006b5f528 EFLAGS: 00010296
> [   52.761468] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [   52.761475] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [   52.761482] RBP: ffff888006b5f580 R08: ffffed100ca3f182 R09: ffffed100ca3f182
> [   52.761489] R10: ffffed100ca3f181 R11: ffff8880651f8c0b R12: 0000000000000001
> [   52.761495] R13: ffffffff934f1a80 R14: ffff888006b5f5d8 R15: 0000000000000000
> [   52.761502] FS:  00007fcb84861380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [   52.761511] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.761518] CR2: 00007f9a690bbf70 CR3: 0000000003ca8000 CR4: 00000000001506f0
> [   52.761525] Call Trace:
> [   52.761531]  <TASK>
> [   52.761540]  ? show_regs+0x65/0x70
> [   52.761558]  ? __warn+0xd0/0x300
> [   52.761575]  ? debug_print_object+0x1a4/0x2d0
> [   52.761589]  ? report_bug+0x23e/0x490
> [   52.761618]  ? handle_bug+0x43/0x80
> [   52.761636]  ? exc_invalid_op+0x1c/0x50
> [   52.761649]  ? asm_exc_invalid_op+0x1f/0x30
> [   52.761687]  ? debug_print_object+0x1a4/0x2d0
> [   52.761702]  ? debug_print_object+0x1a4/0x2d0
> [   52.761712]  ? debug_object_activate+0x223/0x310
> [   52.761724]  ? preempt_count_sub+0x124/0x1b0
> [   52.761747]  debug_object_activate+0x234/0x310
> [   52.761762]  ? __pfx_debug_object_activate+0x10/0x10
> [   52.761781]  ? __pfx_lock_acquire+0x10/0x10
> [   52.761793]  ? __pfx___debug_object_init+0x10/0x10
> [   52.761805]  ? _printk+0xa4/0xd0
> [   52.761825]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.761859]  __call_srcu+0x2d/0xe0
> [   52.761881]  call_srcu+0x17/0x20
> [   52.761891]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.761916]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.761940]  ? __pfx_stack_trace_save+0x10/0x10
> [   52.761957]  ? kvm_sched_clock_read+0x11/0x30
> [   52.761973]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.762000]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.762025]  ? __pfx_lock_release+0x10/0x10
> [   52.762037]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.762074]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.762083]  ? __create_object+0x68/0xa0
> [   52.762100]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.762125]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.762185]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.762209]  do_one_initcall+0xdb/0x410
> [   52.762224]  ? __pfx_do_one_initcall+0x10/0x10
> [   52.762236]  ? kasan_save_alloc_info+0x3b/0x50
> [   52.762250]  ? __kasan_kmalloc+0x86/0xa0
> [   52.762260]  ? kasan_poison+0x3e/0x60
> [   52.762451]  ? kasan_unpoison+0x2c/0x60
> [   52.762465]  ? kasan_poison+0x3e/0x60
> [   52.762476]  ? __asan_register_globals+0x62/0x80
> [   52.762500]  do_init_module+0x264/0x670
> [   52.762544]  load_module+0x52ea/0x6680
> [   52.762682]  ? __pfx_load_module+0x10/0x10
> [   52.762700]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.762724]  ? __kasan_check_read+0x15/0x20
> [   52.762736]  ? rw_verify_area+0x18c/0x490
> [   52.762816]  init_module_from_file+0xf2/0x150
> [   52.762826]  ? init_module_from_file+0xf2/0x150
> [   52.762837]  ? __pfx_init_module_from_file+0x10/0x10
> [   52.762845]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.762899]  ? trace_preempt_on+0x54/0x110
> [   52.762917]  ? idempotent_init_module+0x3a6/0x830
> [   52.762929]  ? preempt_count_sub+0x124/0x1b0
> [   52.762949]  idempotent_init_module+0x3c2/0x830
> [   52.762971]  ? __pfx_idempotent_init_module+0x10/0x10
> [   52.763034]  ? __kasan_check_read+0x15/0x20
> [   52.763046]  ? __fget_light+0x58/0x1f0
> [   52.763073]  ? ns_capable_common+0x66/0xf0
> [   52.763093]  __x64_sys_finit_module+0xc9/0x140
> [   52.763110]  do_syscall_64+0x9d/0x1a0
> [   52.763126]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [   52.763134] RIP: 0033:0x7fcb84120b7d
> [   52.763144] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [   52.763151] RSP: 002b:00007fff73ccd1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   52.763164] RAX: ffffffffffffffda RBX: 000056358ae104f0 RCX: 00007fcb84120b7d
> [   52.763171] RDX: 0000000000000000 RSI: 000056358ae0f2a0 RDI: 0000000000000003
> [   52.763178] RBP: 000056358ae0f2a0 R08: 0000000000000000 R09: 000056358ae0f2a0
> [   52.763184] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [   52.763191] R13: 0000000000000000 R14: 00007fff73ccdef7 R15: 000056358ae0f2a0
> [   52.763233]  </TASK>
> [   52.763239] irq event stamp: 21749
> [   52.763274] hardirqs last  enabled at (21757): [<ffffffff9311055e>] irqentry_exit+0x3e/0xa0
> [   52.763286] hardirqs last disabled at (21762): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [   52.763295] softirqs last  enabled at (21542): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [   52.763319] softirqs last disabled at (21493): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [   52.763327] ---[ end trace 0000000000000000 ]---
> [   52.763335] ------------[ cut here ]------------
> [   52.763340] ODEBUG: active_state active (active state 1) object: 00000000bf20720c object type: rcu_head hint: 0x0
> [   52.763368] WARNING: CPU: 5 PID: 431 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [   52.763378] Modules linked in: rcutorture(+) torture
> [   52.763396] CPU: 5 PID: 431 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [   52.763404] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [   52.763410] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [   52.763418] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [   52.763424] RSP: 0018:ffff888006b5f518 EFLAGS: 00010292
> [   52.763448] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [   52.763453] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [   52.763479] RBP: ffff888006b5f570 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [   52.763485] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000002
> [   52.763491] R13: ffffffff934f1a80 R14: ffff888006b5f5d8 R15: 0000000000000000
> [   52.763496] FS:  00007fcb84861380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [   52.763505] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.763511] CR2: 00007f9a690bbf70 CR3: 0000000003ca8000 CR4: 00000000001506f0
> [   52.763517] Call Trace:
> [   52.763522]  <TASK>
> [   52.763529]  ? show_regs+0x65/0x70
> [   52.763540]  ? __warn+0xd0/0x300
> [   52.763552]  ? debug_print_object+0x1a4/0x2d0
> [   52.763564]  ? report_bug+0x23e/0x490
> [   52.763587]  ? handle_bug+0x43/0x80
> [   52.763596]  ? exc_invalid_op+0x1c/0x50
> [   52.763608]  ? asm_exc_invalid_op+0x1f/0x30
> [   52.763638]  ? debug_print_object+0x1a4/0x2d0
> [   52.763651]  ? debug_print_object+0x1a4/0x2d0
> [   52.763660]  ? debug_object_active_state+0x20a/0x470
> [   52.763671]  ? preempt_count_sub+0x124/0x1b0
> [   52.763689]  debug_object_active_state+0x21b/0x470
> [   52.763698]  ? debug_object_activate+0x234/0x310
> [   52.763711]  ? __pfx_debug_object_active_state+0x10/0x10
> [   52.763728]  ? __pfx_lock_acquire+0x10/0x10
> [   52.763736]  ? __pfx___debug_object_init+0x10/0x10
> [   52.763746]  ? _printk+0xa4/0xd0
> [   52.763763]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.763787]  __call_srcu+0x46/0xe0
> [   52.763804]  call_srcu+0x17/0x20
> [   52.763813]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.763834]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.763855]  ? __pfx_stack_trace_save+0x10/0x10
> [   52.763866]  ? kvm_sched_clock_read+0x11/0x30
> [   52.763880]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.763903]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.763924]  ? __pfx_lock_release+0x10/0x10
> [   52.763935]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.763954]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.763962]  ? __create_object+0x68/0xa0
> [   52.763974]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.763983]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.764016]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.764037]  do_one_initcall+0xdb/0x410
> [   52.764049]  ? __pfx_do_one_initcall+0x10/0x10
> [   52.764059]  ? kasan_save_alloc_info+0x3b/0x50
> [   52.764071]  ? __kasan_kmalloc+0x86/0xa0
> [   52.764094]  ? kasan_poison+0x3e/0x60
> [   52.764102]  ? kasan_unpoison+0x2c/0x60
> [   52.764111]  ? kasan_poison+0x3e/0x60
> [   52.764120]  ? __asan_register_globals+0x62/0x80
> [   52.764138]  do_init_module+0x264/0x670
> [   52.764164]  load_module+0x52ea/0x6680
> [   52.764235]  ? __pfx_load_module+0x10/0x10
> [   52.764242]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.764276]  ? __kasan_check_read+0x15/0x20
> [   52.764285]  ? rw_verify_area+0x18c/0x490
> [   52.764371]  init_module_from_file+0xf2/0x150
> [   52.764380]  ? init_module_from_file+0xf2/0x150
> [   52.764389]  ? __pfx_init_module_from_file+0x10/0x10
> [   52.764396]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.764453]  ? trace_preempt_on+0x54/0x110
> [   52.764462]  ? idempotent_init_module+0x3a6/0x830
> [   52.764471]  ? preempt_count_sub+0x124/0x1b0
> [   52.764486]  idempotent_init_module+0x3c2/0x830
> [   52.764503]  ? __pfx_idempotent_init_module+0x10/0x10
> [   52.764538]  ? __kasan_check_read+0x15/0x20
> [   52.764546]  ? __fget_light+0x58/0x1f0
> [   52.764552]  ? ns_capable_common+0x66/0xf0
> [   52.764572]  __x64_sys_finit_module+0xc9/0x140
> [   52.764586]  do_syscall_64+0x9d/0x1a0
> [   52.764599]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [   52.764620] RIP: 0033:0x7fcb84120b7d
> [   52.764627] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [   52.764632] RSP: 002b:00007fff73ccd1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   52.764641] RAX: ffffffffffffffda RBX: 000056358ae104f0 RCX: 00007fcb84120b7d
> [   52.764647] RDX: 0000000000000000 RSI: 000056358ae0f2a0 RDI: 0000000000000003
> [   52.764652] RBP: 000056358ae0f2a0 R08: 0000000000000000 R09: 000056358ae0f2a0
> [   52.764657] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [   52.764662] R13: 0000000000000000 R14: 00007fff73ccdef7 R15: 000056358ae0f2a0
> [   52.764695]  </TASK>
> [   52.764699] irq event stamp: 22361
> [   52.764705] hardirqs last  enabled at (22367): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [   52.764715] hardirqs last disabled at (22372): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [   52.764725] softirqs last  enabled at (21542): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [   52.764736] softirqs last disabled at (21493): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [   52.764747] ---[ end trace 0000000000000000 ]---
> [   52.764755] ------------[ cut here ]------------
> [   52.764762] call_srcu(): Leaked duplicate callback
> [   52.764774] WARNING: CPU: 5 PID: 431 at kernel/rcu/srcutree.c:1344 __call_srcu+0xc1/0xe0
> [   52.764782] Modules linked in: rcutorture(+) torture
> [   52.764798] CPU: 5 PID: 431 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [   52.764805] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [   52.764811] RIP: 0010:__call_srcu+0xc1/0xe0
> [   52.764817] Code: 4c 89 f7 e8 31 ef ff ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 c7 c7 c0 33 4f 93 c6 05 2d cb 3a 05 01 e8 7f 4f de ff <0f> 0b eb b2 e8 46 9c 6b 00 eb 9a e8 3f 9c 6b 00 eb b9 0f 1f 00 66
> [   52.764823] RSP: 0018:ffff888006b5f660 EFLAGS: 00010286
> [   52.764831] RAX: 0000000000000000 RBX: ffff888006b5f7d0 RCX: 0000000000000000
> [   52.764836] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [   52.764841] RBP: ffff888006b5f688 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [   52.764846] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000001
> [   52.764851] R13: 00000000ffffffea R14: ffffffffc047cda0 R15: ffffffffc04689c0
> [   52.764856] FS:  00007fcb84861380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [   52.764864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.764869] CR2: 00007f9a690bbf70 CR3: 0000000003ca8000 CR4: 00000000001506f0
> [   52.764874] Call Trace:
> [   52.764879]  <TASK>
> [   52.764885]  ? show_regs+0x65/0x70
> [   52.764894]  ? __warn+0xd0/0x300
> [   52.764900]  ? __wake_up_klogd.part.25+0x7d/0xb0
> [   52.764911]  ? __call_srcu+0xc1/0xe0
> [   52.764921]  ? report_bug+0x23e/0x490
> [   52.764941]  ? handle_bug+0x43/0x80
> [   52.764949]  ? exc_invalid_op+0x1c/0x50
> [   52.764959]  ? asm_exc_invalid_op+0x1f/0x30
> [   52.764965]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.765020]  ? __call_srcu+0xc1/0xe0
> [   52.765041]  call_srcu+0x17/0x20
> [   52.765049]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.765070]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.765110]  ? __pfx_stack_trace_save+0x10/0x10
> [   52.765122]  ? kvm_sched_clock_read+0x11/0x30
> [   52.765136]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.765161]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.765184]  ? __pfx_lock_release+0x10/0x10
> [   52.765196]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.765217]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.765225]  ? __create_object+0x68/0xa0
> [   52.765237]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.765247]  ? __pfx_srcu_leak_callback+0x10/0x10
> [   52.765290]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.765313]  do_one_initcall+0xdb/0x410
> [   52.765327]  ? __pfx_do_one_initcall+0x10/0x10
> [   52.765337]  ? kasan_save_alloc_info+0x3b/0x50
> [   52.765350]  ? __kasan_kmalloc+0x86/0xa0
> [   52.765358]  ? kasan_poison+0x3e/0x60
> [   52.765368]  ? kasan_unpoison+0x2c/0x60
> [   52.765392]  ? kasan_poison+0x3e/0x60
> [   52.765420]  ? __asan_register_globals+0x62/0x80
> [   52.765441]  do_init_module+0x264/0x670
> [   52.765471]  load_module+0x52ea/0x6680
> [   52.765550]  ? __pfx_load_module+0x10/0x10
> [   52.765558]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.765589]  ? __kasan_check_read+0x15/0x20
> [   52.765597]  ? rw_verify_area+0x18c/0x490
> [   52.765656]  init_module_from_file+0xf2/0x150
> [   52.765663]  ? init_module_from_file+0xf2/0x150
> [   52.765672]  ? __pfx_init_module_from_file+0x10/0x10
> [   52.765678]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.765718]  ? trace_preempt_on+0x54/0x110
> [   52.765726]  ? idempotent_init_module+0x3a6/0x830
> [   52.765734]  ? preempt_count_sub+0x124/0x1b0
> [   52.765749]  idempotent_init_module+0x3c2/0x830
> [   52.765766]  ? __pfx_idempotent_init_module+0x10/0x10
> [   52.765799]  ? __kasan_check_read+0x15/0x20
> [   52.765807]  ? __fget_light+0x58/0x1f0
> [   52.765813]  ? ns_capable_common+0x66/0xf0
> [   52.765829]  __x64_sys_finit_module+0xc9/0x140
> [   52.765842]  do_syscall_64+0x9d/0x1a0
> [   52.765876]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [   52.765904] RIP: 0033:0x7fcb84120b7d
> [   52.765913] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [   52.765920] RSP: 002b:00007fff73ccd1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   52.765933] RAX: ffffffffffffffda RBX: 000056358ae104f0 RCX: 00007fcb84120b7d
> [   52.765940] RDX: 0000000000000000 RSI: 000056358ae0f2a0 RDI: 0000000000000003
> [   52.765946] RBP: 000056358ae0f2a0 R08: 0000000000000000 R09: 000056358ae0f2a0
> [   52.765953] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [   52.765975] R13: 0000000000000000 R14: 00007fff73ccdef7 R15: 000056358ae0f2a0
> [   52.766014]  </TASK>
> [   52.766034] irq event stamp: 22915
> [   52.766038] hardirqs last  enabled at (22921): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [   52.766046] hardirqs last disabled at (22926): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [   52.766052] softirqs last  enabled at (21542): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [   52.766059] softirqs last disabled at (21493): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [   52.766066] ---[ end trace 0000000000000000 ]---
> [   52.766078] ------------[ cut here ]------------
> [   52.766083] ODEBUG: activate active (active state 1) object: 00000000e4a843c6 object type: rcu_head hint: 0x0
> [   52.766127] WARNING: CPU: 5 PID: 431 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [   52.766136] Modules linked in: rcutorture(+) torture
> [   52.766170] CPU: 5 PID: 431 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [   52.766177] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [   52.766183] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [   52.766192] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [   52.766198] RSP: 0018:ffff888006b5f528 EFLAGS: 00010296
> [   52.766208] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [   52.766214] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [   52.766220] RBP: ffff888006b5f580 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [   52.766227] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000003
> [   52.766233] R13: ffffffff934f1a80 R14: ffff888006b5f5d8 R15: 0000000000000000
> [   52.766239] FS:  00007fcb84861380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [   52.766288] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.766296] CR2: 00007f9a690bbf70 CR3: 0000000003ca8000 CR4: 00000000001506f0
> [   52.766303] Call Trace:
> [   52.766309]  <TASK>
> [   52.766317]  ? show_regs+0x65/0x70
> [   52.766330]  ? __warn+0xd0/0x300
> [   52.766345]  ? debug_print_object+0x1a4/0x2d0
> [   52.766359]  ? report_bug+0x23e/0x490
> [   52.766386]  ? handle_bug+0x43/0x80
> [   52.766397]  ? exc_invalid_op+0x1c/0x50
> [   52.766410]  ? asm_exc_invalid_op+0x1f/0x30
> [   52.766446]  ? debug_print_object+0x1a4/0x2d0
> [   52.766462]  ? debug_print_object+0x1a4/0x2d0
> [   52.766472]  ? debug_object_activate+0x223/0x310
> [   52.766484]  ? preempt_count_sub+0x124/0x1b0
> [   52.766528]  debug_object_activate+0x234/0x310
> [   52.766546]  ? __pfx_debug_object_activate+0x10/0x10
> [   52.766606]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.766633]  __call_srcu+0x2d/0xe0
> [   52.766652]  call_srcu+0x17/0x20
> [   52.766662]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.766688]  rcu_torture_init+0x296d/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.766713]  ? __pfx_stack_trace_save+0x10/0x10
> [   52.766725]  ? kvm_sched_clock_read+0x11/0x30
> [   52.766742]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.766769]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.766795]  ? __pfx_lock_release+0x10/0x10
> [   52.766808]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.766837]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.766846]  ? __create_object+0x68/0xa0
> [   52.766860]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.766870]  ? __pfx_srcu_leak_callback+0x10/0x10
> [   52.766896]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.766920]  do_one_initcall+0xdb/0x410
> [   52.766934]  ? __pfx_do_one_initcall+0x10/0x10
> [   52.766946]  ? kasan_save_alloc_info+0x3b/0x50
> [   52.766960]  ? __kasan_kmalloc+0x86/0xa0
> [   52.766970]  ? kasan_poison+0x3e/0x60
> [   52.766980]  ? kasan_unpoison+0x2c/0x60
> [   52.766991]  ? kasan_poison+0x3e/0x60
> [   52.767033]  ? __asan_register_globals+0x62/0x80
> [   52.767073]  do_init_module+0x264/0x670
> [   52.767105]  load_module+0x52ea/0x6680
> [   52.767183]  ? __pfx_load_module+0x10/0x10
> [   52.767191]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.767211]  ? __kasan_check_read+0x15/0x20
> [   52.767221]  ? rw_verify_area+0x18c/0x490
> [   52.767335]  init_module_from_file+0xf2/0x150
> [   52.767345]  ? init_module_from_file+0xf2/0x150
> [   52.767356]  ? __pfx_init_module_from_file+0x10/0x10
> [   52.767378]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.767424]  ? trace_preempt_on+0x54/0x110
> [   52.767434]  ? idempotent_init_module+0x3a6/0x830
> [   52.767444]  ? preempt_count_sub+0x124/0x1b0
> [   52.767461]  idempotent_init_module+0x3c2/0x830
> [   52.767480]  ? __pfx_idempotent_init_module+0x10/0x10
> [   52.767519]  ? __kasan_check_read+0x15/0x20
> [   52.767529]  ? __fget_light+0x58/0x1f0
> [   52.767535]  ? ns_capable_common+0x66/0xf0
> [   52.767554]  __x64_sys_finit_module+0xc9/0x140
> [   52.767569]  do_syscall_64+0x9d/0x1a0
> [   52.767584]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [   52.767612] RIP: 0033:0x7fcb84120b7d
> [   52.767621] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [   52.767628] RSP: 002b:00007fff73ccd1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   52.767640] RAX: ffffffffffffffda RBX: 000056358ae104f0 RCX: 00007fcb84120b7d
> [   52.767647] RDX: 0000000000000000 RSI: 000056358ae0f2a0 RDI: 0000000000000003
> [   52.767654] RBP: 000056358ae0f2a0 R08: 0000000000000000 R09: 000056358ae0f2a0
> [   52.767660] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [   52.767667] R13: 0000000000000000 R14: 00007fff73ccdef7 R15: 000056358ae0f2a0
> [   52.767745]  </TASK>
> [   52.767752] irq event stamp: 23509
> [   52.767758] hardirqs last  enabled at (23515): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [   52.767767] hardirqs last disabled at (23520): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [   52.767776] softirqs last  enabled at (21542): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [   52.767800] softirqs last disabled at (21493): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [   52.767808] ---[ end trace 0000000000000000 ]---
> [   52.767816] ------------[ cut here ]------------
> [   52.767821] ODEBUG: active_state active (active state 1) object: 00000000e4a843c6 object type: rcu_head hint: 0x0
> [   52.767849] WARNING: CPU: 5 PID: 431 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [   52.767859] Modules linked in: rcutorture(+) torture
> [   52.767877] CPU: 5 PID: 431 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [   52.767886] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [   52.767893] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [   52.767922] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [   52.767929] RSP: 0018:ffff888006b5f518 EFLAGS: 00010292
> [   52.767940] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [   52.767947] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [   52.767954] RBP: ffff888006b5f570 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [   52.767961] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000004
> [   52.767967] R13: ffffffff934f1a80 R14: ffff888006b5f5d8 R15: 0000000000000000
> [   52.767974] FS:  00007fcb84861380(0000) GS:ffff888065000000(0000) knlGS:0000000000000000
> [   52.767984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   52.767991] CR2: 00007f9a690bbf70 CR3: 0000000003ca8000 CR4: 00000000001506f0
> [   52.767998] Call Trace:
> [   52.768004]  <TASK>
> [   52.768012]  ? show_regs+0x65/0x70
> [   52.768025]  ? __warn+0xd0/0x300
> [   52.768039]  ? debug_print_object+0x1a4/0x2d0
> [   52.768053]  ? report_bug+0x23e/0x490
> [   52.768080]  ? handle_bug+0x43/0x80
> [   52.768091]  ? exc_invalid_op+0x1c/0x50
> [   52.768104]  ? asm_exc_invalid_op+0x1f/0x30
> [   52.768140]  ? debug_print_object+0x1a4/0x2d0
> [   52.768156]  ? debug_print_object+0x1a4/0x2d0
> [   52.768182]  ? debug_object_active_state+0x20a/0x470
> [   52.768214]  ? preempt_count_sub+0x124/0x1b0
> [   52.768234]  debug_object_active_state+0x21b/0x470
> [   52.768245]  ? debug_object_activate+0x234/0x310
> [   52.768261]  ? __pfx_debug_object_active_state+0x10/0x10
> [   52.768332]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.768356]  __call_srcu+0x46/0xe0
> [   52.768373]  call_srcu+0x17/0x20
> [   52.768382]  srcu_torture_call+0x1f/0x30 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.768406]  rcu_torture_init+0x296d/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.768438]  ? __pfx_stack_trace_save+0x10/0x10
> [   52.768471]  ? kvm_sched_clock_read+0x11/0x30
> [   52.768493]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.768520]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.768544]  ? __pfx_lock_release+0x10/0x10
> [   52.768556]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.768577]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.768585]  ? __create_object+0x68/0xa0
> [   52.768598]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [   52.768608]  ? __pfx_srcu_leak_callback+0x10/0x10
> [   52.768632]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [   52.768654]  do_one_initcall+0xdb/0x410
> [   52.768667]  ? __pfx_do_one_initcall+0x10/0x10
> [   52.768678]  ? kasan_save_alloc_info+0x3b/0x50
> [   52.768713]  ? __kasan_kmalloc+0x86/0xa0
> [   52.768723]  ? kasan_poison+0x3e/0x60
> [   52.768733]  ? kasan_unpoison+0x2c/0x60
> [   52.768745]  ? kasan_poison+0x3e/0x60
> [   52.768755]  ? __asan_register_globals+0x62/0x80
> [   52.768779]  do_init_module+0x264/0x670
> [   52.768811]  load_module+0x52ea/0x6680
> [   52.768884]  ? __pfx_load_module+0x10/0x10
> [   52.768893]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.768916]  ? __kasan_check_read+0x15/0x20
> [   52.768927]  ? rw_verify_area+0x18c/0x490
> [   52.769006]  init_module_from_file+0xf2/0x150
> [   52.769016]  ? init_module_from_file+0xf2/0x150
> [   52.769027]  ? __pfx_init_module_from_file+0x10/0x10
> [   52.769035]  ? __this_cpu_preempt_check+0x17/0x20
> [   52.769089]  ? trace_preempt_on+0x54/0x110
> [   52.769100]  ? idempotent_init_module+0x3a6/0x830
> [   52.769111]  ? preempt_count_sub+0x124/0x1b0
> [   52.769131]  idempotent_init_module+0x3c2/0x830
> [   52.769153]  ? __pfx_idempotent_init_module+0x10/0x10
> [   52.769213]  ? __kasan_check_read+0x15/0x20
> [   52.769224]  ? __fget_light+0x58/0x1f0
> [   52.769232]  ? ns_capable_common+0x66/0xf0
> [   52.769252]  __x64_sys_finit_module+0xc9/0x140
> [   52.769269]  do_syscall_64+0x9d/0x1a0
> [   52.769308]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [   52.769317] RIP: 0033:0x7fcb84120b7d
> [   52.769326] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [   52.769333] RSP: 002b:00007fff73ccd1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   52.769345] RAX: ffffffffffffffda RBX: 000056358ae104f0 RCX: 00007fcb84120b7d
> [   52.769352] RDX: 0000000000000000 RSI: 000056358ae0f2a0 RDI: 0000000000000003
> [   52.769359] RBP: 000056358ae0f2a0 R08: 0000000000000000 R09: 000056358ae0f2a0
> [   52.769366] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [   52.769373] R13: 0000000000000000 R14: 00007fff73ccdef7 R15: 000056358ae0f2a0
> [   52.769417]  </TASK>
> [   52.769423] irq event stamp: 24103
> [   52.769429] hardirqs last  enabled at (24109): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [   52.769439] hardirqs last disabled at (24114): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [   52.769448] softirqs last  enabled at (21542): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [   52.769457] softirqs last disabled at (21493): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [   52.769466] ---[ end trace 0000000000000000 ]---
> [   52.773518] rcutorture: WARN: Duplicate call_srcu() test complete.
> [   57.768971] srcu-torture: rcu_torture_read_exit: End of episode
> [   68.853254] workqueue: srcu_invoke_callbacks hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [   70.352060] EXT4-fs error (device vdb): ext4_validate_inode_bitmap:106: comm sh: Corrupt inode bitmap - block_group = 0, inode_bitmap = 134
> [   70.352908] EXT4-fs error (device vdb): ext4_validate_inode_bitmap:106: comm sh: Corrupt inode bitmap - block_group = 1, inode_bitmap = 135

> [  211.813513] torture module --- rcu:  disable_onoff_at_boot=0 ftrace_dump_at_shutdown=0 verbose_sleep_frequency=0 verbose_sleep_duration=1 random_shuffle=0
> [  211.813556] rcu-torture:--- Start of test: nreaders=7 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/1 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=4 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000 test_nmis=0
> [  211.813597] rcu:  Start-test grace-period state: g28845 f0x0
> [  211.813609] rcu_torture_write_types: Testing conditional GPs.
> [  211.813637] rcu_torture_write_types: Testing conditional expedited GPs.
> [  211.813646] rcu_torture_write_types: Testing conditional full-state GPs.
> [  211.813676] rcu_torture_write_types: Testing expedited GPs.
> [  211.813699] rcu_torture_write_types: Testing asynchronous GPs.
> [  211.813708] rcu_torture_write_types: Testing polling GPs.
> [  211.813716] rcu_torture_write_types: Testing polling full-state GPs.
> [  211.813725] rcu_torture_write_types: Testing polling expedited GPs.
> [  211.813734] rcu_torture_write_types: Testing polling full-state expedited GPs.
> [  211.813742] rcu_torture_write_types: Testing normal GPs.
> [  211.813751] rcu-torture: Creating rcu_torture_writer task
> [  211.814666] rcu-torture: Creating rcu_torture_fakewriter task
> [  211.814670] rcu-torture: rcu_torture_writer task started
> [  211.814680] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
> [  211.815285] rcu-torture: rcu_torture_fakewriter task started
> [  211.815392] rcu-torture: Creating rcu_torture_fakewriter task
> [  211.815946] rcu-torture: Creating rcu_torture_fakewriter task
> [  211.815954] rcu-torture: rcu_torture_fakewriter task started
> [  211.816406] rcu-torture: Creating rcu_torture_fakewriter task
> [  211.816416] rcu-torture: rcu_torture_fakewriter task started
> [  211.817033] rcu-torture: rcu_torture_fakewriter task started
> [  211.817058] rcu-torture: Creating rcu_torture_reader task
> [  211.817602] rcu-torture: rcu_torture_reader task started
> [  211.817612] rcu-torture: Creating rcu_torture_reader task
> [  211.818085] rcu-torture: rcu_torture_reader task started
> [  211.818086] rcu-torture: Creating rcu_torture_reader task
> [  211.818602] rcu-torture: Creating rcu_torture_reader task
> [  211.818667] rcu-torture: rcu_torture_reader task started
> [  211.818966] rcu-torture: rcu_torture_reader task started
> [  211.818975] rcu-torture: Creating rcu_torture_reader task
> [  211.819400] rcu-torture: rcu_torture_reader task started
> [  211.819428] rcu-torture: Creating rcu_torture_reader task
> [  211.819906] rcu-torture: rcu_torture_reader task started
> [  211.819908] rcu-torture: Creating rcu_torture_reader task
> [  211.823630] rcu-torture: rcu_torture_reader task started
> [  211.823659] rcu-torture: Creating rcu_torture_stats task
> [  211.824916] rcu-torture: rcu_torture_stats task started
> [  211.824944] rcu-torture: Creating torture_shuffle task
> [  211.825475] rcu-torture: Creating torture_stutter task
> [  211.826028] rcutorture: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.
> [  211.826288] rcu-torture: Creating rcu_torture_fwd_prog task
> [  211.826739] rcu-torture: Creating rcu_torture_fwd_prog task
> [  211.827147] rcu-torture: torture_shuffle task started
> [  211.827205] rcu-torture: rcu_torture_fwd_progress task started
> [  211.827394] rcu-torture: rcu_torture_fwd_progress task started
> [  211.827457] rcu-torture: torture_stutter task started
> [  211.827575] rcu-torture: Creating rcu_torture_fwd_prog task
> [  211.828069] rcu-torture: Creating rcu_torture_fwd_prog task
> [  211.828072] rcu-torture: rcu_torture_fwd_progress task started
> [  211.828780] rcu-torture: rcu_torture_fwd_progress task started
> [  211.828799] rcu-torture: Creating rcu_torture_barrier_cbs task
> [  211.829178] rcu-torture: rcu_torture_barrier_cbs task started
> [  211.829182] rcu-torture: Creating rcu_torture_barrier_cbs task
> [  211.829781] rcu-torture: Creating rcu_torture_barrier_cbs task
> [  211.829787] rcu-torture: rcu_torture_barrier_cbs task started
> [  211.830220] rcu-torture: Creating rcu_torture_barrier_cbs task
> [  211.830232] rcu-torture: rcu_torture_barrier_cbs task started
> [  211.830808] rcu-torture: rcu_torture_barrier_cbs task started
> [  211.830812] rcu-torture: Creating rcu_torture_barrier task
> [  211.831172] rcu-torture: Creating rcu_torture_read_exit task
> [  211.831172] rcu-torture: rcu_torture_barrier task starting
> [  211.831627] rcu-torture: rcu_torture_read_exit: Start of test
> [  211.831637] rcu-torture: rcu_torture_read_exit: Start of episode
> [  211.831650] rcutorture: WARN: Duplicate call_rcu() test starting.
> [  211.831692] ------------[ cut here ]------------
> [  211.831751] ODEBUG: activate active (active state 1) object: 00000000a042d4fb object type: rcu_head hint: 0x0
> [  211.831795] WARNING: CPU: 2 PID: 642 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  211.831811] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  211.831844] CPU: 2 PID: 642 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  211.831855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  211.831864] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  211.831876] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  211.831885] RSP: 0018:ffff888006b7f478 EFLAGS: 00010292
> [  211.831899] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  211.831907] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  211.831916] RBP: ffff888006b7f4d0 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  211.831924] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 0000000000000009
> [  211.831932] R13: ffffffff934f1a80 R14: ffff888006b7f528 R15: 0000000000000000
> [  211.831940] FS:  00007f3da5fc8380(0000) GS:ffff888064400000(0000) knlGS:0000000000000000
> [  211.831952] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  211.831961] CR2: 00007fa5a1449218 CR3: 000000000468e000 CR4: 00000000001506f0
> [  211.831969] Call Trace:
> [  211.831977]  <TASK>
> [  211.831987]  ? show_regs+0x65/0x70
> [  211.832004]  ? __warn+0xd0/0x300
> [  211.832022]  ? debug_print_object+0x1a4/0x2d0
> [  211.832039]  ? report_bug+0x23e/0x490
> [  211.832071]  ? handle_bug+0x43/0x80
> [  211.832085]  ? exc_invalid_op+0x1c/0x50
> [  211.832100]  ? asm_exc_invalid_op+0x1f/0x30
> [  211.832158]  ? debug_print_object+0x1a4/0x2d0
> [  211.832174]  ? debug_print_object+0x1a4/0x2d0
> [  211.832184]  ? debug_object_activate+0x223/0x310
> [  211.832197]  ? preempt_count_sub+0x124/0x1b0
> [  211.832218]  debug_object_activate+0x234/0x310
> [  211.832234]  ? __pfx_debug_object_activate+0x10/0x10
> [  211.832285]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.832296]  ? lockdep_hardirqs_on+0xc7/0x150
> [  211.832307]  ? call_rcu+0x12/0x20
> [  211.832331]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832372]  __call_rcu_common.constprop.74+0x86/0x12a0
> [  211.832384]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.832410]  ? __pfx___call_rcu_common.constprop.74+0x10/0x10
> [  211.832427]  ? __pfx__printk+0x10/0x10
> [  211.832439]  ? __kasan_kmalloc+0x86/0xa0
> [  211.832470]  call_rcu+0x12/0x20
> [  211.832481]  call_rcu_hurry+0xd/0x20 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832507]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832532]  ? filter_irq_stacks+0x61/0xc0
> [  211.832545]  ? kvm_sched_clock_read+0x11/0x30
> [  211.832561]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832589]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.832614]  ? __pfx_lock_release+0x10/0x10
> [  211.832628]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832651]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.832660]  ? __create_object+0x68/0xa0
> [  211.832675]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.832685]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832726]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.832750]  do_one_initcall+0xdb/0x410
> [  211.832764]  ? __pfx_do_one_initcall+0x10/0x10
> [  211.832776]  ? kasan_save_alloc_info+0x3b/0x50
> [  211.832791]  ? __kasan_kmalloc+0x86/0xa0
> [  211.832800]  ? kasan_poison+0x3e/0x60
> [  211.832810]  ? kasan_unpoison+0x2c/0x60
> [  211.832821]  ? kasan_poison+0x3e/0x60
> [  211.832832]  ? __asan_register_globals+0x62/0x80
> [  211.832854]  do_init_module+0x264/0x670
> [  211.832886]  load_module+0x52ea/0x6680
> [  211.832956]  ? __pfx_load_module+0x10/0x10
> [  211.832965]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.832987]  ? __kasan_check_read+0x15/0x20
> [  211.832997]  ? rw_verify_area+0x18c/0x490
> [  211.833079]  init_module_from_file+0xf2/0x150
> [  211.833089]  ? init_module_from_file+0xf2/0x150
> [  211.833105]  ? __pfx_init_module_from_file+0x10/0x10
> [  211.833112]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.833164]  ? trace_preempt_on+0x54/0x110
> [  211.833174]  ? idempotent_init_module+0x3a6/0x830
> [  211.833185]  ? preempt_count_sub+0x124/0x1b0
> [  211.833205]  idempotent_init_module+0x3c2/0x830
> [  211.833226]  ? __pfx_idempotent_init_module+0x10/0x10
> [  211.833291]  ? __kasan_check_read+0x15/0x20
> [  211.833302]  ? __fget_light+0x58/0x1f0
> [  211.833310]  ? ns_capable_common+0x66/0xf0
> [  211.833331]  __x64_sys_finit_module+0xc9/0x140
> [  211.833348]  do_syscall_64+0x9d/0x1a0
> [  211.833365]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  211.833373] RIP: 0033:0x7f3da5920b7d
> [  211.833383] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  211.833391] RSP: 002b:00007fff67a2f3e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  211.833404] RAX: ffffffffffffffda RBX: 00005581692e24f0 RCX: 00007f3da5920b7d
> [  211.833411] RDX: 0000000000000000 RSI: 00005581692e12a0 RDI: 0000000000000003
> [  211.833418] RBP: 00005581692e12a0 R08: 0000000000000000 R09: 00005581692e12a0
> [  211.833425] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  211.833432] R13: 0000000000000000 R14: 00007fff67a2fef7 R15: 00005581692e12a0
> [  211.833475]  </TASK>
> [  211.833482] irq event stamp: 19037
> [  211.833488] hardirqs last  enabled at (19043): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  211.833499] hardirqs last disabled at (19048): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  211.833508] softirqs last  enabled at (18288): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  211.833517] softirqs last disabled at (18247): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  211.833526] ---[ end trace 0000000000000000 ]---
> [  211.833535] ------------[ cut here ]------------
> [  211.833541] ODEBUG: active_state active (active state 1) object: 00000000a042d4fb object type: rcu_head hint: 0x0
> [  211.833572] WARNING: CPU: 2 PID: 642 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  211.833584] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  211.833611] CPU: 2 PID: 642 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  211.833620] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  211.833626] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  211.833636] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  211.833643] RSP: 0018:ffff888006b7f468 EFLAGS: 00010296
> [  211.833655] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  211.833661] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  211.833668] RBP: ffff888006b7f4c0 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  211.833678] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 000000000000000a
> [  211.833688] R13: ffffffff934f1a80 R14: ffff888006b7f528 R15: 0000000000000000
> [  211.833697] FS:  00007f3da5fc8380(0000) GS:ffff888064400000(0000) knlGS:0000000000000000
> [  211.833706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  211.833713] CR2: 00007fa5a1449218 CR3: 000000000468e000 CR4: 00000000001506f0
> [  211.833720] Call Trace:
> [  211.833726]  <TASK>
> [  211.833734]  ? show_regs+0x65/0x70
> [  211.833748]  ? __warn+0xd0/0x300
> [  211.833763]  ? debug_print_object+0x1a4/0x2d0
> [  211.833777]  ? report_bug+0x23e/0x490
> [  211.833805]  ? handle_bug+0x43/0x80
> [  211.833816]  ? exc_invalid_op+0x1c/0x50
> [  211.833829]  ? asm_exc_invalid_op+0x1f/0x30
> [  211.833864]  ? debug_print_object+0x1a4/0x2d0
> [  211.833880]  ? debug_print_object+0x1a4/0x2d0
> [  211.833891]  ? debug_object_active_state+0x20a/0x470
> [  211.833903]  ? preempt_count_sub+0x124/0x1b0
> [  211.833923]  debug_object_active_state+0x21b/0x470
> [  211.833934]  ? debug_object_activate+0x234/0x310
> [  211.833950]  ? __pfx_debug_object_active_state+0x10/0x10
> [  211.833975]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.833984]  ? lockdep_hardirqs_on+0xc7/0x150
> [  211.833995]  ? call_rcu+0x12/0x20
> [  211.834011]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834038]  __call_rcu_common.constprop.74+0x9f/0x12a0
> [  211.834049]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.834074]  ? __pfx___call_rcu_common.constprop.74+0x10/0x10
> [  211.834085]  ? __pfx__printk+0x10/0x10
> [  211.834093]  ? __kasan_kmalloc+0x86/0xa0
> [  211.834122]  call_rcu+0x12/0x20
> [  211.834133]  call_rcu_hurry+0xd/0x20 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834158]  rcu_torture_init+0x28ec/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834183]  ? filter_irq_stacks+0x61/0xc0
> [  211.834195]  ? kvm_sched_clock_read+0x11/0x30
> [  211.834212]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834261]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.834288]  ? __pfx_lock_release+0x10/0x10
> [  211.834300]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834323]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.834332]  ? __create_object+0x68/0xa0
> [  211.834346]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.834357]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834397]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.834421]  do_one_initcall+0xdb/0x410
> [  211.834435]  ? __pfx_do_one_initcall+0x10/0x10
> [  211.834447]  ? kasan_save_alloc_info+0x3b/0x50
> [  211.834461]  ? __kasan_kmalloc+0x86/0xa0
> [  211.834470]  ? kasan_poison+0x3e/0x60
> [  211.834481]  ? kasan_unpoison+0x2c/0x60
> [  211.834491]  ? kasan_poison+0x3e/0x60
> [  211.834502]  ? __asan_register_globals+0x62/0x80
> [  211.834524]  do_init_module+0x264/0x670
> [  211.834556]  load_module+0x52ea/0x6680
> [  211.834626]  ? __pfx_load_module+0x10/0x10
> [  211.834635]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.834657]  ? __kasan_check_read+0x15/0x20
> [  211.834667]  ? rw_verify_area+0x18c/0x490
> [  211.834743]  init_module_from_file+0xf2/0x150
> [  211.834753]  ? init_module_from_file+0xf2/0x150
> [  211.834772]  ? __pfx_init_module_from_file+0x10/0x10
> [  211.834780]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.834831]  ? trace_preempt_on+0x54/0x110
> [  211.834842]  ? idempotent_init_module+0x3a6/0x830
> [  211.834853]  ? preempt_count_sub+0x124/0x1b0
> [  211.834871]  idempotent_init_module+0x3c2/0x830
> [  211.834893]  ? __pfx_idempotent_init_module+0x10/0x10
> [  211.834936]  ? __kasan_check_read+0x15/0x20
> [  211.834947]  ? __fget_light+0x58/0x1f0
> [  211.834954]  ? ns_capable_common+0x66/0xf0
> [  211.834975]  __x64_sys_finit_module+0xc9/0x140
> [  211.834991]  do_syscall_64+0x9d/0x1a0
> [  211.835008]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  211.835016] RIP: 0033:0x7f3da5920b7d
> [  211.835025] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  211.835033] RSP: 002b:00007fff67a2f3e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  211.835045] RAX: ffffffffffffffda RBX: 00005581692e24f0 RCX: 00007f3da5920b7d
> [  211.835052] RDX: 0000000000000000 RSI: 00005581692e12a0 RDI: 0000000000000003
> [  211.835059] RBP: 00005581692e12a0 R08: 0000000000000000 R09: 00005581692e12a0
> [  211.835066] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  211.835072] R13: 0000000000000000 R14: 00007fff67a2fef7 R15: 00005581692e12a0
> [  211.835119]  </TASK>
> [  211.835128] irq event stamp: 19677
> [  211.835134] hardirqs last  enabled at (19683): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  211.835144] hardirqs last disabled at (19688): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  211.835152] softirqs last  enabled at (18288): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  211.835162] softirqs last disabled at (18247): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  211.835171] ---[ end trace 0000000000000000 ]---
> [  211.835178] rcu: __call_rcu_common(): Double-freed CB 00000000a042d4fb->rcu_torture_leak_cb+0x0/0x20 [rcutorture]()!!!   non-slab/vmalloc memory
> [  211.835598] ------------[ cut here ]------------
> [  211.835606] ODEBUG: activate active (active state 1) object: 00000000f6dad71c object type: rcu_head hint: 0x0
> [  211.835639] WARNING: CPU: 2 PID: 642 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  211.835651] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  211.835677] CPU: 2 PID: 642 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  211.835687] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  211.835694] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  211.835703] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  211.835711] RSP: 0018:ffff888006b7f478 EFLAGS: 00010292
> [  211.835722] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  211.835729] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  211.835736] RBP: ffff888006b7f4d0 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  211.835743] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 000000000000000b
> [  211.835749] R13: ffffffff934f1a80 R14: ffff888006b7f528 R15: 0000000000000000
> [  211.835756] FS:  00007f3da5fc8380(0000) GS:ffff888064400000(0000) knlGS:0000000000000000
> [  211.835766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  211.835773] CR2: 00007fa5a1449218 CR3: 000000000468e000 CR4: 00000000001506f0
> [  211.835780] Call Trace:
> [  211.835787]  <TASK>
> [  211.835795]  ? show_regs+0x65/0x70
> [  211.835813]  ? __warn+0xd0/0x300
> [  211.835836]  ? debug_print_object+0x1a4/0x2d0
> [  211.835860]  ? report_bug+0x23e/0x490
> [  211.835887]  ? handle_bug+0x43/0x80
> [  211.835898]  ? exc_invalid_op+0x1c/0x50
> [  211.835911]  ? asm_exc_invalid_op+0x1f/0x30
> [  211.835947]  ? debug_print_object+0x1a4/0x2d0
> [  211.835962]  ? debug_print_object+0x1a4/0x2d0
> [  211.835973]  ? debug_object_activate+0x223/0x310
> [  211.835985]  ? preempt_count_sub+0x124/0x1b0
> [  211.836006]  debug_object_activate+0x234/0x310
> [  211.836022]  ? __pfx_debug_object_activate+0x10/0x10
> [  211.836047]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.836056]  ? lockdep_hardirqs_on+0xc7/0x150
> [  211.836067]  ? call_rcu+0x12/0x20
> [  211.836083]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.836110]  __call_rcu_common.constprop.74+0x86/0x12a0
> [  211.836121]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.836147]  ? __pfx___call_rcu_common.constprop.74+0x10/0x10
> [  211.836158]  ? __pfx__printk+0x10/0x10
> [  211.836165]  ? __kasan_kmalloc+0x86/0xa0
> [  211.836194]  call_rcu+0x12/0x20
> [  211.836205]  call_rcu_hurry+0xd/0x20 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.836231]  rcu_torture_init+0x296d/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.836335]  ? filter_irq_stacks+0x61/0xc0
> [  211.836348]  ? kvm_sched_clock_read+0x11/0x30
> [  211.836365]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.836393]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.836418]  ? __pfx_lock_release+0x10/0x10
> [  211.836431]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.836454]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.836463]  ? __create_object+0x68/0xa0
> [  211.836476]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.836487]  ? __pfx_rcu_leak_callback+0x10/0x10
> [  211.836512]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.836536]  do_one_initcall+0xdb/0x410
> [  211.836550]  ? __pfx_do_one_initcall+0x10/0x10
> [  211.836562]  ? kasan_save_alloc_info+0x3b/0x50
> [  211.836576]  ? __kasan_kmalloc+0x86/0xa0
> [  211.836586]  ? kasan_poison+0x3e/0x60
> [  211.836596]  ? kasan_unpoison+0x2c/0x60
> [  211.836607]  ? kasan_poison+0x3e/0x60
> [  211.836617]  ? __asan_register_globals+0x62/0x80
> [  211.836640]  do_init_module+0x264/0x670
> [  211.836672]  load_module+0x52ea/0x6680
> [  211.836741]  ? __pfx_load_module+0x10/0x10
> [  211.836750]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.836772]  ? __kasan_check_read+0x15/0x20
> [  211.836783]  ? rw_verify_area+0x18c/0x490
> [  211.836859]  init_module_from_file+0xf2/0x150
> [  211.836868]  ? init_module_from_file+0xf2/0x150
> [  211.836880]  ? __pfx_init_module_from_file+0x10/0x10
> [  211.836887]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.836939]  ? trace_preempt_on+0x54/0x110
> [  211.836949]  ? idempotent_init_module+0x3a6/0x830
> [  211.836960]  ? preempt_count_sub+0x124/0x1b0
> [  211.836979]  idempotent_init_module+0x3c2/0x830
> [  211.837000]  ? __pfx_idempotent_init_module+0x10/0x10
> [  211.837043]  ? __kasan_check_read+0x15/0x20
> [  211.837054]  ? __fget_light+0x58/0x1f0
> [  211.837061]  ? ns_capable_common+0x66/0xf0
> [  211.837082]  __x64_sys_finit_module+0xc9/0x140
> [  211.837098]  do_syscall_64+0x9d/0x1a0
> [  211.837130]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  211.837137] RIP: 0033:0x7f3da5920b7d
> [  211.837145] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  211.837151] RSP: 002b:00007fff67a2f3e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  211.837162] RAX: ffffffffffffffda RBX: 00005581692e24f0 RCX: 00007f3da5920b7d
> [  211.837168] RDX: 0000000000000000 RSI: 00005581692e12a0 RDI: 0000000000000003
> [  211.837174] RBP: 00005581692e12a0 R08: 0000000000000000 R09: 00005581692e12a0
> [  211.837180] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  211.837186] R13: 0000000000000000 R14: 00007fff67a2fef7 R15: 00005581692e12a0
> [  211.837224]  </TASK>
> [  211.837229] irq event stamp: 20383
> [  211.837235] hardirqs last  enabled at (20389): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  211.837243] hardirqs last disabled at (20394): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  211.837267] softirqs last  enabled at (20078): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  211.837276] softirqs last disabled at (20033): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  211.837283] ---[ end trace 0000000000000000 ]---
> [  211.837291] ------------[ cut here ]------------
> [  211.837296] ODEBUG: active_state active (active state 1) object: 00000000f6dad71c object type: rcu_head hint: 0x0
> [  211.837322] WARNING: CPU: 2 PID: 642 at lib/debugobjects.c:517 debug_print_object+0x1a4/0x2d0
> [  211.837332] Modules linked in: rcutorture(+) torture [last unloaded: rcutorture]
> [  211.837355] CPU: 2 PID: 642 Comm: insmod Tainted: G        W          6.9.0-rc1-yoctodev-standard+ #38 75b7359f8c0069a92c959ca7da83ac99f7c8b627
> [  211.837363] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  211.837368] RIP: 0010:debug_print_object+0x1a4/0x2d0
> [  211.837376] Code: 38 c7 93 49 89 fa 49 c1 ea 03 41 80 3c 12 00 0f 85 e5 00 00 00 48 8b 14 dd 60 38 c7 93 50 48 c7 c7 e0 2a c7 93 e8 4c 31 90 fe <0f> 0b 58 83 05 e6 39 f3 03 01 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41
> [  211.837383] RSP: 0018:ffff888006b7f468 EFLAGS: 00010296
> [  211.837393] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> [  211.837398] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffffff96853680
> [  211.837404] RBP: ffff888006b7f4c0 R08: fffffbfff291fa9c R09: fffffbfff291fa9c
> [  211.837410] R10: fffffbfff291fa9c R11: 0000000000000003 R12: 000000000000000c
> [  211.837416] R13: ffffffff934f1a80 R14: ffff888006b7f528 R15: 0000000000000000
> [  211.837422] FS:  00007f3da5fc8380(0000) GS:ffff888064400000(0000) knlGS:0000000000000000
> [  211.837430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  211.837436] CR2: 00007fa5a1449218 CR3: 000000000468e000 CR4: 00000000001506f0
> [  211.837442] Call Trace:
> [  211.837448]  <TASK>
> [  211.837455]  ? show_regs+0x65/0x70
> [  211.837466]  ? __warn+0xd0/0x300
> [  211.837479]  ? debug_print_object+0x1a4/0x2d0
> [  211.837491]  ? report_bug+0x23e/0x490
> [  211.837514]  ? handle_bug+0x43/0x80
> [  211.837524]  ? exc_invalid_op+0x1c/0x50
> [  211.837535]  ? asm_exc_invalid_op+0x1f/0x30
> [  211.837566]  ? debug_print_object+0x1a4/0x2d0
> [  211.837580]  ? debug_print_object+0x1a4/0x2d0
> [  211.837589]  ? debug_object_active_state+0x20a/0x470
> [  211.837600]  ? preempt_count_sub+0x124/0x1b0
> [  211.837618]  debug_object_active_state+0x21b/0x470
> [  211.837627]  ? debug_object_activate+0x234/0x310
> [  211.837641]  ? __pfx_debug_object_active_state+0x10/0x10
> [  211.837663]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.837671]  ? lockdep_hardirqs_on+0xc7/0x150
> [  211.837680]  ? call_rcu+0x12/0x20
> [  211.837695]  ? __pfx_rcu_torture_err_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.837717]  __call_rcu_common.constprop.74+0x9f/0x12a0
> [  211.837727]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.837749]  ? __pfx___call_rcu_common.constprop.74+0x10/0x10
> [  211.837758]  ? __pfx__printk+0x10/0x10
> [  211.837765]  ? __kasan_kmalloc+0x86/0xa0
> [  211.837790]  call_rcu+0x12/0x20
> [  211.837799]  call_rcu_hurry+0xd/0x20 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.837821]  rcu_torture_init+0x296d/0x3ff0 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.837843]  ? filter_irq_stacks+0x61/0xc0
> [  211.837854]  ? kvm_sched_clock_read+0x11/0x30
> [  211.837868]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.837892]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.837920]  ? __pfx_lock_release+0x10/0x10
> [  211.837932]  ? __pfx_rcu_torture_leak_cb+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.837952]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.837959]  ? __create_object+0x68/0xa0
> [  211.837971]  ? _raw_spin_unlock_irqrestore+0x4a/0x80
> [  211.837980]  ? __pfx_rcu_leak_callback+0x10/0x10
> [  211.838003]  ? __pfx_rcu_torture_init+0x10/0x10 [rcutorture 14d8de1bcd65425491ea224ca28da4724a15e3b7]
> [  211.838024]  do_one_initcall+0xdb/0x410
> [  211.838036]  ? __pfx_do_one_initcall+0x10/0x10
> [  211.838047]  ? kasan_save_alloc_info+0x3b/0x50
> [  211.838059]  ? __kasan_kmalloc+0x86/0xa0
> [  211.838067]  ? kasan_poison+0x3e/0x60
> [  211.838076]  ? kasan_unpoison+0x2c/0x60
> [  211.838085]  ? kasan_poison+0x3e/0x60
> [  211.838095]  ? __asan_register_globals+0x62/0x80
> [  211.838114]  do_init_module+0x264/0x670
> [  211.838141]  load_module+0x52ea/0x6680
> [  211.838202]  ? __pfx_load_module+0x10/0x10
> [  211.838210]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.838229]  ? __kasan_check_read+0x15/0x20
> [  211.838257]  ? rw_verify_area+0x18c/0x490
> [  211.838324]  init_module_from_file+0xf2/0x150
> [  211.838332]  ? init_module_from_file+0xf2/0x150
> [  211.838342]  ? __pfx_init_module_from_file+0x10/0x10
> [  211.838349]  ? __this_cpu_preempt_check+0x17/0x20
> [  211.838393]  ? trace_preempt_on+0x54/0x110
> [  211.838402]  ? idempotent_init_module+0x3a6/0x830
> [  211.838412]  ? preempt_count_sub+0x124/0x1b0
> [  211.838428]  idempotent_init_module+0x3c2/0x830
> [  211.838447]  ? __pfx_idempotent_init_module+0x10/0x10
> [  211.838485]  ? __kasan_check_read+0x15/0x20
> [  211.838494]  ? __fget_light+0x58/0x1f0
> [  211.838501]  ? ns_capable_common+0x66/0xf0
> [  211.838519]  __x64_sys_finit_module+0xc9/0x140
> [  211.838533]  do_syscall_64+0x9d/0x1a0
> [  211.838547]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
> [  211.838554] RIP: 0033:0x7f3da5920b7d
> [  211.838562] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b f2 0c 00 f7 d8 64 89 01 48
> [  211.838569] RSP: 002b:00007fff67a2f3e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [  211.838579] RAX: ffffffffffffffda RBX: 00005581692e24f0 RCX: 00007f3da5920b7d
> [  211.838585] RDX: 0000000000000000 RSI: 00005581692e12a0 RDI: 0000000000000003
> [  211.838591] RBP: 00005581692e12a0 R08: 0000000000000000 R09: 00005581692e12a0
> [  211.838597] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
> [  211.838602] R13: 0000000000000000 R14: 00007fff67a2fef7 R15: 00005581692e12a0
> [  211.838641]  </TASK>
> [  211.838646] irq event stamp: 21025
> [  211.838651] hardirqs last  enabled at (21031): [<ffffffff8ff6dd01>] console_unlock+0x1a1/0x1b0
> [  211.838659] hardirqs last disabled at (21036): [<ffffffff8ff6dce6>] console_unlock+0x186/0x1b0
> [  211.838667] softirqs last  enabled at (20078): [<ffffffff9314f23a>] __do_softirq+0x43a/0x7fd
> [  211.838675] softirqs last disabled at (20033): [<ffffffff8fdcde0d>] irq_exit_rcu+0x1ad/0x220
> [  211.838683] ---[ end trace 0000000000000000 ]---
> [  211.838689] rcu: __call_rcu_common(): Double-freed CB 00000000f6dad71c->rcu_torture_leak_cb+0x0/0x20 [rcutorture]()!!!   slab kmalloc-16 start ffff8880066eca20 pointer offset 0 size 16
> [  211.857014] rcutorture: WARN: Duplicate call_rcu() test complete.


