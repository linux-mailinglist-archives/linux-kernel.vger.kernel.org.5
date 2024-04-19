Return-Path: <linux-kernel+bounces-151109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B638AA932
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7458B1C20F41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50E43145;
	Fri, 19 Apr 2024 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcRoJ/dY"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA73FE28
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511800; cv=none; b=CuLzIUa3WPIHCvhyO4egKjqPR8OxfpoKsJV4zdw8BFsQE1sJ3jLqAe8KGo7FP0c780DRCeY2fkmG854k05bkFrR6LV2k6vltbO9wOrmUFvwn/PPYsJ4Ks3GF2l2+JnFxWxNlXLw4IHHk6FgxZuS4z+cWZj+dIRFNHTLneb6pl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511800; c=relaxed/simple;
	bh=ahkhUdPHAMjD3VvvBXRd4BNyb3dIuhzU4miZCmxNIpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFh0RT66hWVSC1VKUvrF5PzBUAjRGFoiDmbo/NnfKL4GWJeB+j5QN5FCwOFlCV3/dX8lX2AhYBKn+QV1MSFtepPbBNOsbVsKnmjpPk+hCYREsEJ5Jit3h5FCrc53Dvhvh2NuG1XMjXnUTQEml9ysY0z7ECq7/tCOyESgYngIusU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcRoJ/dY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1882650b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713511797; x=1714116597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0lXq+hMvVi2VAxm5JuigBCRrlENJbnYST88LTFidjI=;
        b=QcRoJ/dYUSCml0zFy7Ge9wU+TNQRTAfnmiUVMabvaIXmF7xyq4u2gpCM/EGCqSj2nk
         WJ7kQNZ8RKYaiNWlyFSoY4b5b/lNI2Ndc29ilqtJCN3jDdYZ7AVFMVupeSJIJg1kO17g
         axcGsBHk0r54vysMu81nKefOMRSUSTRasyfOGYt6Fk8WORiR0gbelfV2f2+2CTSNQXJY
         WABlQMjPd7M0IREy+0Z38LZCTA3Au8T15CNhQZjiYWzRb0/qKcBLd24enG1YLzifLzhg
         ipmhI+o35qycXY0fA9u76NTrB5GAkzktFyLKVYvVQA4G4cwUbl7N4+08ZwsLRLX992T1
         aEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511797; x=1714116597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0lXq+hMvVi2VAxm5JuigBCRrlENJbnYST88LTFidjI=;
        b=BAjfJXcU/QaGK+S+IYJQMEZlY5pPphP1oNhRiBqbrjCNjeH+SgSquRIDPJncb8I1kE
         SFDmxXvjs/xrYRA1iStg6k0TDuJz5V6Aog46tauIpf0Ll/YWyWGwGDU/OutS9Yt3uIsX
         3hxbYfEAkhff/99LaqMl2QVWGW9j97hQ2sE+rJAdLggfFrNS0hticEPceM76BYdC1HDo
         WPpXHqOZZi8eOCxx3i+T3cJS3WrOndxndRgYIlz6piNBVNoxB9y9nfcx9qaz85FXWWB0
         tFRKPTBpe5aYOU+FMIobyzJWwMTJohcaBd3nHnfgK1VMXXZrhGuADqr2cc6P2qvAqwQ9
         GiLg==
X-Forwarded-Encrypted: i=1; AJvYcCVvY+jZ8HQYM8sVw4w6AGOtlENFcjdqtydQlq81RpiV7NJThp8umC03SyjWhF+V2LggYSC1ln5mq5mkDD7xkMsxWGEVXY0b3ejmIM54
X-Gm-Message-State: AOJu0YzHozqxHpqe9ndDoLu7frd2mYHRO8H6QtAW45lz3WWH/F1LzSqN
	Xezvk9i34ShQN2hnfBh6JJpDVn6dKZrybZV1hRKR//rTsR+1VTx+DOb6u0bUvje837fz6LeKVzP
	Wn6VI08/OHe70F+vM01+arKkiKho=
X-Google-Smtp-Source: AGHT+IF9OP0WC6ChhiWw35suxXjThJcw839blgjfTAOuU3YMlbmvj84jNJxeg/ABKMfSbeV/lVRsRKtUfjZEKkIH37s=
X-Received: by 2002:a17:90b:4aca:b0:29b:c31:1fe1 with SMTP id
 mh10-20020a17090b4aca00b0029b0c311fe1mr2059650pjb.10.1713511797400; Fri, 19
 Apr 2024 00:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b24903061520f3e9@google.com> <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop> <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop> <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop> <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
 <9e12bfe8-a3c2-47b2-8a3f-5b61b0bd5c08@paulmck-laptop>
In-Reply-To: <9e12bfe8-a3c2-47b2-8a3f-5b61b0bd5c08@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Fri, 19 Apr 2024 15:29:45 +0800
Message-ID: <CALm+0cX2o-o1FGvbuNLeL+Y-mWBUTYBzXYvcebgyT1N-t7or6g@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
To: paulmck@kernel.org
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 3:12=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Apr 19, 2024 at 01:50:02PM +0800, Z qiang wrote:
> > >
> > > On Thu, Apr 18, 2024 at 05:49:38PM +0800, Z qiang wrote:
> > > > >
> > > > > On Wed, Apr 17, 2024 at 10:25:01AM +0800, Z qiang wrote:
> > > > > > >
> > > > > > > On Tue, Apr 16, 2024 at 04:44:54PM +0800, Z qiang wrote:
> > > > > > > > On Tue, Apr 16, 2024 at 4:10=E2=80=AFPM Z qiang <qiang.zhan=
g1211@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Cc: Paul
> > > > > > > > > >
> > > > > > > > > > Hello,
> > > > > > > > > >
> > > > > > > > > > syzbot found the following issue on:
> > > > > > > > > >
> > > > > > > > > > HEAD commit:    c0b832517f62 Add linux-next specific fi=
les for 20240402
> > > > > > > > > > git tree:       linux-next
> > > > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt=
?x=3D15f64776180000
> > > > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config=
?x=3Dafcaf46d374cec8c
> > > > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=
=3Ddce04ed6d1438ad69656
> > > > > > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GN=
U Binutils for Debian) 2.40
> > > > > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.s=
yz?x=3D10f00471180000
> > > > > > > > > >
> > > > > > > > > > Downloadable assets:
> > > > > > > > > > disk image: https://storage.googleapis.com/syzbot-asset=
s/0d36ec76edc7/disk-c0b83251.raw.xz
> > > > > > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6=
f9bb4e37dd0/vmlinux-c0b83251.xz
> > > > > > > > > > kernel image: https://storage.googleapis.com/syzbot-ass=
ets/2349287b14b7/bzImage-c0b83251.xz
> > > > > > > > > >
> > > > > > > > > > IMPORTANT: if you fix the issue, please add the followi=
ng tag to the commit:
> > > > > > > > > > Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.apps=
potmail.com
> > > > > > > > > >
> > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > WARNING: suspicious RCU usage
> > > > > > > > > > 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> > > > > > > > > > -----------------------------
> > > > > > > > > > kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU r=
ead-side critical section!
> > > > > > > > > >
> > > > > > > > > > other info that might help us debug this:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > rcu_scheduler_active =3D 2, debug_locks =3D 1
> > > > > > > > > > 1 lock held by ksoftirqd/0/16:
> > > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}=
, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> > > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}=
, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
> > > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}=
, at: pfn_valid include/linux/mmzone.h:2019 [inline]
> > > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}=
, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65
> > > > > > > > > >
> > > > > > > > > > stack backtrace:
> > > > > > > > > > CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-=
next-20240402-syzkaller #0
> > > > > > > > > > Hardware name: Google Google Compute Engine/Google Comp=
ute Engine, BIOS Google 03/27/2024
> > > > > > > > > > Call Trace:
> > > > > > > > > >  <IRQ>
> > > > > > > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > > > > > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > > > > > > > > >  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lock=
dep.c:6712
> > > > > > > > > >  rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
> > > > > > > > > >  __do_softirq+0x5fd/0x980 kernel/softirq.c:568
> > > > > > >
> > > > > > > Huh.  This statement is supposed to prevent this call to __do=
_softirq()
> > > > > > > from interrupt exit::
> > > > > > >
> > > > > > >         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > > > > >             __this_cpu_read(ksoftirqd) =3D=3D current)
> > > > > > >
> > > > > > > So was the ksoftirqd kthread interrupted at a point where it =
happens to
> > > > > > > have softirq enabled?
> > > > > >
> > > > > > It should look like this:
> > > > > > schedule()
> > > > > > switch_to ksoftirqd/0
> > > > > > finish_task_switch
> > > > >
> > > > > So this CPU's ksoftirqd task is running.
> > > > >
> > > > > > ->put_task_struct_rcu_user
> > > > > >    ->call_rcu(&task->rcu, delayed_put_task_struct)
> > > > > >       ->__kasan_record_aux_stack
> > > > > >          ->pfn_valid
> > > > > >             ->rcu_read_lock_sched
> > > > > >                 <interrupt>
> > > > > >                  __irq_exit_rcu
> > > > > >                  ->__do_softirq
> > > > > >                     -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > > > >                              __this_cpu_read(ksoftirqd) =3D=3D =
current)
> > > > >
> > > > > But we are also running __do_softirq() from return from interrupt=
  While
> > > > > running in this mode, we are not supposed to invoke rcu_softirq_q=
s().
> > > > > But the "__this_cpu_read(ksoftirqd) =3D=3D current" check yields =
"true",
> > > > > so we do call rcu_softirq_qs() anyway.  That is a bug.
> > > > >
> > > > > We need to upgrade or replace that check to something that return=
s true
> > > > > only if called at process level from ksoftirqd.
> > > > >
> > > > > Any thoughts on a good way to do that?  For example, would adding=
 "&&
> > > > > in_task()" do the trick, or are there other unfortunate corner ca=
ses?
> > > >
> > > > The rcu_softirq_qs() is invoked in softirq_handle_begin/end() criti=
cal section,
> > > > in softirqd/0 task context,  the "in_task()" should return false, w=
ill miss
> > > > qs report in softirqd/0 task context.
> > > >
> > > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > > index b315b21fb28c..9b8f0c0f7675 100644
> > > > --- a/kernel/softirq.c
> > > > +++ b/kernel/softirq.c
> > > > @@ -563,10 +563,6 @@ asmlinkage __visible void __softirq_entry
> > > > __do_softirq(void)
> > > >                 pending >>=3D softirq_bit;
> > > >         }
> > > >
> > > > -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > > -           __this_cpu_read(ksoftirqd) =3D=3D current)
> > > > -               rcu_softirq_qs();
> > > > -
> > > >         local_irq_disable();
> > > >
> > > >         pending =3D local_softirq_pending();
> > > > @@ -915,6 +911,8 @@ static int ksoftirqd_should_run(unsigned int cp=
u)
> > > >
> > > >  static void run_ksoftirqd(unsigned int cpu)
> > > >  {
> > > > +       unsigned long last_qs =3D jiffies;
> > > > +
> > > >         ksoftirqd_run_begin();
> > > >         if (local_softirq_pending()) {
> > > >                 /*
> > > > @@ -923,6 +921,7 @@ static void run_ksoftirqd(unsigned int cpu)
> > > >                  */
> > > >                 __do_softirq();
> > > >                 ksoftirqd_run_end();
> > > > +               rcu_softirq_qs_periodic(last_qs);
> > >
> > > Unfortunately, we need the quiescent state to be within __do_softirq(=
).
> > >
> > > >                 cond_resched();
> > > >                 return;
> > > >         }
> > > >
> > > > Any thoughts?
> > >
> > > Can we mask the return value from preempt_count(), for example, as sh=
own
> > > in the CONFIG_PREEMPTION=3Dn version of rcu_flavor_sched_clock_irq()?
> > >
> > > The trick is that we should be able to ignore SOFTIRQ_MASK because
> > > __do_softirq() should not be invoked when softirqs are disabled.
> > > Emphasis on "should".  ;-)
> >
> >
> >
> > Does it mean this?
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index b315b21fb28c..315b717ec944 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -517,6 +517,8 @@ asmlinkage __visible void __softirq_entry __do_soft=
irq(void)
> >         bool in_hardirq;
> >         __u32 pending;
> >         int softirq_bit;
> > +       bool preempt_enabled =3D (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> > +                                       !(preempt_count() & PREEMPT_MAS=
K));
> >
> >         /*
> >          * Mask out PF_MEMALLOC as the current task context is borrowed=
 for the
> > @@ -564,7 +566,8 @@ asmlinkage __visible void __softirq_entry __do_soft=
irq(void)
> >         }
> >
> >         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > -           __this_cpu_read(ksoftirqd) =3D=3D current)
> > +           __this_cpu_read(ksoftirqd) =3D=3D current &&
> > +           preempt_enabled && !rcu_preempt_depth())
> >                 rcu_softirq_qs();
> >
> >         local_irq_disable();
> >
> > For built with CONFIG_PREEMPTION=3Dn and CONFIG_COUNT=3Dn kernels,
> > the preempt_enabled is always  false.
>
> Assuming that this works, it is preferred over the next one.

But for built with CONFIG_PREEMPTION=3Dn and CONFIG_COUNT=3Dn kernels,
will miss invoke rcu_softirq_qs(), even if in the ksoftirqd task context.

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > or how about this?
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index b315b21fb28c..80b9fb4ee562 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -66,6 +66,8 @@ const char * const softirq_to_name[NR_SOFTIRQS] =3D {
> >         "TASKLET", "SCHED", "HRTIMER", "RCU"
> >  };
> >
> > +static DEFINE_PER_CPU(bool, ksoftirqd_work);
> > +
> >  /*
> >   * we cannot loop indefinitely here to avoid userspace starvation,
> >   * but we also don't want to introduce a worst case 1/HZ latency
> > @@ -404,10 +406,12 @@ static inline void softirq_handle_end(void)
> >  static inline void ksoftirqd_run_begin(void)
> >  {
> >         local_irq_disable();
> > +       per_cpu(ksoftirqd_work, smp_processor_id()) =3D true;
> >  }
> >
> >  static inline void ksoftirqd_run_end(void)
> >  {
> > +       per_cpu(ksoftirqd_work, smp_processor_id()) =3D false;
> >         local_irq_enable();
> >  }
> >
> > @@ -564,7 +568,7 @@ asmlinkage __visible void __softirq_entry __do_soft=
irq(void)
> >         }
> >
> >         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > -           __this_cpu_read(ksoftirqd) =3D=3D current)
> > +           __this_cpu_read(ksoftirqd) =3D=3D current && ksoftirqd_work=
)
> >                 rcu_softirq_qs();
> >
> >         local_irq_disable();
> > @@ -970,6 +974,10 @@ static struct smp_hotplug_thread softirq_threads =
=3D {
> >
> >  static __init int spawn_ksoftirqd(void)
> >  {
> > +       int cpu;
> > +
> > +       for_each_possible_cpu(cpu)
> > +               per_cpu(ksoftirqd_work, cpu) =3D false;
> >         cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", N=
ULL,
> >                                   takeover_tasklets);
> >         BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
> >
> >
> > Thanks
> > Zqiang
> >
> >
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks
> > > > Zqiang
> > > >
> > > >
> > > > >
> > > > > (And good job tracking this down, by the way!)
> > > > >
> > > > >                                                         Thanx, Pa=
ul
> > > > >
> > > > > >                               rcu_softirq_qs
> > > > > >                                ->
> > > > > > RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))
> > > > > >
> > > > > > Thanks
> > > > > > Zqiang
> > > > > >
> > > > > >
> > > > > > >
> > > > > > >                                                         Thanx=
, Paul
> > > > > > >
> > > > > > > > > >  invoke_softirq kernel/softirq.c:428 [inline]
> > > > > > > > > >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> > > > > > > > > >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> > > > > > > > > >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic=
/apic.c:1043 [inline]
> > > > > > > > > >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/=
apic/apic.c:1043
> > > > > > > > > >  </IRQ>
> > > > > > > > > >  <TASK>
> > > > > > > > > >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/inc=
lude/asm/idtentry.h:702
> > > > > > > > > > RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu=
/update.c:320
> > > > > > > > > > Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 0=
0 <74> 1e 83 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
> > > > > > > > > > RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
> > > > > > > > > > RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 000000=
0000000001
> > > > > > > > > > RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffff=
ff8c1f7ec0
> > > > > > > > > > RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1fffff=
fff25e74a4
> > > > > > > > > > R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 000000=
0029373578
> > > > > > > > > > R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88=
813fff90a0
> > > > > > > > > >  rcu_read_lock_sched include/linux/rcupdate.h:934 [inli=
ne]
> > > > > > > > > >  pfn_valid include/linux/mmzone.h:2019 [inline]
> > > > > > > > > >  __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:6=
5
> > > > > > > > > >  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
> > > > > > > > > >  __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:=
526
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > This should be caused by the following commit:
> > > > > > > > > d818cc76e2b4 ("kasan: Record work creation stack trace wi=
th interrupts enabled")
> > > > > > > > >
> > > > > > > > > Is it possible to make the rcu_softirq_qs() run only in k=
softirqd task?
> > > > > > > >
> > > > > > > > use rcu_softirq_qs_periodic() in run_ksoftirqd().
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > > Zqiang
> > > > > > > > >
> > > > > > > > > >  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
> > > > > > > > > >  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
> > > > > > > > > >  context_switch kernel/sched/core.c:5412 [inline]
> > > > > > > > > >  __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
> > > > > > > > > >  __schedule_loop kernel/sched/core.c:6823 [inline]
> > > > > > > > > >  schedule+0x14b/0x320 kernel/sched/core.c:6838
> > > > > > > > > >  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
> > > > > > > > > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > > > > > > > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > > > > > > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:=
243
> > > > > > > > > >  </TASK>
> > > > > > > > > > ----------------
> > > > > > > > > > Code disassembly (best guess):
> > > > > > > > > >    0:   f5                      cmc
> > > > > > > > > >    1:   90                      nop
> > > > > > > > > >    2:   0f 0b                   ud2
> > > > > > > > > >    4:   90                      nop
> > > > > > > > > >    5:   90                      nop
> > > > > > > > > >    6:   90                      nop
> > > > > > > > > >    7:   eb c6                   jmp    0xffffffcf
> > > > > > > > > >    9:   0f 1f 40 00             nopl   0x0(%rax)
> > > > > > > > > >    d:   90                      nop
> > > > > > > > > >    e:   90                      nop
> > > > > > > > > >    f:   90                      nop
> > > > > > > > > >   10:   90                      nop
> > > > > > > > > >   11:   90                      nop
> > > > > > > > > >   12:   90                      nop
> > > > > > > > > >   13:   90                      nop
> > > > > > > > > >   14:   90                      nop
> > > > > > > > > >   15:   90                      nop
> > > > > > > > > >   16:   90                      nop
> > > > > > > > > >   17:   90                      nop
> > > > > > > > > >   18:   90                      nop
> > > > > > > > > >   19:   90                      nop
> > > > > > > > > >   1a:   90                      nop
> > > > > > > > > >   1b:   90                      nop
> > > > > > > > > >   1c:   90                      nop
> > > > > > > > > >   1d:   f3 0f 1e fa             endbr64
> > > > > > > > > >   21:   31 c0                   xor    %eax,%eax
> > > > > > > > > >   23:   83 3d c7 0f 28 04 00    cmpl   $0x0,0x4280fc7(%=
rip)        # 0x4280ff1
> > > > > > > > > > * 2a:   74 1e                   je     0x4a <-- trappin=
g instruction
> > > > > > > > > >   2c:   83 3d 26 42 28 04 00    cmpl   $0x0,0x4284226(%=
rip)        # 0x4284259
> > > > > > > > > >   33:   74 15                   je     0x4a
> > > > > > > > > >   35:   65 48 8b 0c 25 c0 d3    mov    %gs:0x3d3c0,%rcx
> > > > > > > > > >   3c:   03 00
> > > > > > > > > >   3e:   31 c0                   xor    %eax,%eax
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > This report is generated by a bot. It may contain error=
s.
> > > > > > > > > > See https://goo.gl/tpsmEJ for more information about sy=
zbot.
> > > > > > > > > > syzbot engineers can be reached at syzkaller@googlegrou=
ps.com.
> > > > > > > > > >
> > > > > > > > > > syzbot will keep track of this issue. See:
> > > > > > > > > > https://goo.gl/tpsmEJ#status for how to communicate wit=
h syzbot.
> > > > > > > > > >
> > > > > > > > > > If the report is already addressed, let syzbot know by =
replying with:
> > > > > > > > > > #syz fix: exact-commit-title
> > > > > > > > > >
> > > > > > > > > > If you want syzbot to run the reproducer, reply with:
> > > > > > > > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > > > > > > > If you attach or paste a git patch, syzbot will apply i=
t before testing.
> > > > > > > > > >
> > > > > > > > > > If you want to overwrite report's subsystems, reply wit=
h:
> > > > > > > > > > #syz set subsystems: new-subsystem
> > > > > > > > > > (See the list of subsystem names on the web dashboard)
> > > > > > > > > >
> > > > > > > > > > If the report is a duplicate of another one, reply with=
:
> > > > > > > > > > #syz dup: exact-subject-of-another-report
> > > > > > > > > >
> > > > > > > > > > If you want to undo deduplication, reply with:
> > > > > > > > > > #syz undup
> > > > > > > > > >

