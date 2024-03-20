Return-Path: <linux-kernel+bounces-109390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6B88187E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE25E1C2358F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE284A43;
	Wed, 20 Mar 2024 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC9YAsf2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367A29CE8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965943; cv=none; b=rZc5jbnuRh2FmG7gOOo6GJirGQubzhATSnoSY0yuOpN4Y3B2BRH5GulKNOEC8W4WRRIOi8D6uom/aauZCww06UC1Cjo5Meer0BDk2iZldzZzGAQMtVKluPPL1N4OKcNsx4+VvHoSbxyayXSfgql7y0Y5QWXr0NgX0FMotwEUVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965943; c=relaxed/simple;
	bh=yvbGK7Kiiontte9NlJf6YqjSOWHEz1G5tw0/3NWkjD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMStdVDQCl3qHRjA9jBvQARkA/l2/Mm8hS7gWU92pp5PopOtXJDuSk4hLDnhtOU1QhMwopm1CQs6w5Y1fWLtv3Y1BQbBKr6+CpIbg1y+8GPdVsfVT32Ftx0/c7bzg9s59+IeU9yR4Lku66YQ7rLrq5sm6MRGbLMDS/OR2Bpqens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EC9YAsf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710965939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkevnCAXYZkWBpYTI/5KLi02bRyM5EGNUTfKZVdsAWw=;
	b=EC9YAsf2BcEZ0iLqbTL7/LvBqLH5IimdkKhVmMYlzQlFd9WpxSYE3RUQ5XFUAWgBiM9ZQ5
	Mt7gYmSMjIDQ1IK6S5U6zikmMzQhoMpBHAU6S2BN+5VWpFffwRb3s4yMTiZhhgOO1+waWl
	reI3F1Yllf5XXaOoOvAO60kxefKjKrQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-jEDC1iJqMA2FkwxM2NsQ8g-1; Wed, 20 Mar 2024 16:18:58 -0400
X-MC-Unique: jEDC1iJqMA2FkwxM2NsQ8g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29df3d9c644so240682a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965937; x=1711570737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkevnCAXYZkWBpYTI/5KLi02bRyM5EGNUTfKZVdsAWw=;
        b=RCALz48yPA25APVo46foFjzkqsTmBaGFQcC74O1oPmkk7u5/NP98pDwls2dAfCGnYg
         9IDXxXrFxGipqi0P9BeSWENlbRH+JbqIXkuJ5W40cLqqwiXIwEkb1Wb+eZXN8KssUygq
         wGfqgJ0nzQ4X2qfIzd+aN9gF5NlgtWURvjFcoFzKty0AVDiohpQmRtZsSjlEsKg3g4ru
         nktgldZhyrvSlTJpF8fXimiEl9J6PwIrzjOlg61AfJ34frCs9moIGzI/0o3+Sd3RI50W
         8qOw5ctZnGB/IZPopDQpbREyITRJV+PRDRR+kXDFoRLj74+/2fgBoPJ+2fFnM/wDabLo
         qkNA==
X-Forwarded-Encrypted: i=1; AJvYcCUmRezVeCorDyhUy3sRHQ+dqsPkKTkvSFIf20X8Xy1FjDoDvr4odSmNrGyrbcp9RI8Ra33h2KAx36jFvPU5Qlznnm4X99/fDDj3Hzf3
X-Gm-Message-State: AOJu0YwGZiCpAQBSsTZEs1xImmM1/FvQ2ONkYrt1BRKTFl49LkZTN+F7
	XYSQWSNiJdrNaxMxsVVnysalAxOk+R1WUrQpCej+Amzcn3JvLxJG+VVc5/7a0nss7kEgFTJs9HM
	OtZr9Vsk+PmiAj32kxw45Va2OqsVPC0IG1zqRXsViI9l3laWXzdmIg+RpmIzM2SQmRPWFkTPupi
	JnPQ0dPSCHGHvJK3pDxhMf9TYeSFMR68X9p+gt
X-Received: by 2002:a17:90a:cb92:b0:29f:b11f:8a85 with SMTP id a18-20020a17090acb9200b0029fb11f8a85mr3123584pju.35.1710965937386;
        Wed, 20 Mar 2024 13:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKn+XkMEsicI0CFgkRRqE7m3F+bUR335681yGE2Ptu9A3XLd6Upml4UzZMTQePd5Ewe72LDN0Do8/7bLm103Y=
X-Received: by 2002:a17:90a:cb92:b0:29f:b11f:8a85 with SMTP id
 a18-20020a17090acb9200b0029fb11f8a85mr3123560pju.35.1710965936953; Wed, 20
 Mar 2024 13:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xhsmhfrwncuky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240320140344.3178785-1-neelx@redhat.com> <xhsmha5msdayv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmh4jd0da97.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh4jd0da97.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Daniel Vacek <neelx@redhat.com>
Date: Wed, 20 Mar 2024 21:18:20 +0100
Message-ID: <CACjP9X-9eJB52RG9N27W6F+rzFTux7SQprb=CYRJcJn4-X12Bw@mail.gmail.com>
Subject: Re: [PATCH] sched/core: fix affine_move_task failure case
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, stable@vger.kernel.org, 
	Bill Peters <wpeters@atpco.net>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 7:33=E2=80=AFPM Valentin Schneider <vschneid@redhat=
com> wrote:
> On 20/03/24 19:17, Valentin Schneider wrote:
> > On 20/03/24 15:03, Daniel Vacek wrote:
> >> Hi Valentin,
> >>
> >> On Mon, Mar 18, 2024 at 6:34=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
> >>> On 18/03/24 12:17, Daniel Vacek wrote:
> >>> > Bill Peters reported CPU hangs while offlining/onlining CPUs on s39=
0.
> >>> >
> >>> > Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_=
move_task()`
> >>> > can fail when racing with off-/on-lining resulting in a deadlock wa=
iting for
> >>> > the pending migration stop work completion which is never done.
> >>> >
> >>> > Fix this by correctly handling such a condition.
> >>> >
> >>>
> >>> IIUC the problem is that the dest_cpu and its stopper thread can be t=
aken
> >>> down by take_cpu_down(), and affine_move_task() currently isn't aware=
 of
> >>> that. I thought we had tested this vs hotplug, but oh well...
> >>
> >> I'm sorry, I should have provided more context in the first place. The=
 machine
> >> is an LPAR with 2 CPUs and CPU 0 was onlining (hotplugging?) CPU 1. Th=
e traces
> >> show this scenario:
> >>
> >>             CPU 0                       |           CPU 1
> >>                                         |
> >>         cpuplugd task 1429              |
> >>  holds the `cpu_hotplug_lock`           |
> >>     for writing in _cpu_up+0x16a        |
> >> blocked on `cpuhp_state:1.done_up`      |
> >>      completion in __cpuhp_kick_ap+0x76 |
> >>                                         |
> >>                                         |       cpuhp/1 task 17
> >>                                         |supposed to complete bringup =
of the CPU
> >>                                         |     (`cpuhp_state:1.done_up`=
) in cpuhp_thread_fun+0x108
> >>                                         |blocked on `wq_pool_attach_mu=
tex`
> >>                                         |    in workqueue_online_cpu+0=
x9e
> >>                                         |
> >>         xfs-conv/dm-0 task 745          |
> >>  holds the `wq_pool_attach_mutex`       |
> >>     in worker_attach_to_pool+0x66        \
> >> blocked on `task->migration_pending->done`|
> >>      completion in affine_move_task+0x10a/
> >>
> >> ~~~
> >> crash> b 1429
> >> PID: 1429     TASK: 99398000          CPU: 0    COMMAND: "cpuplugd"
> >>  #0 [997df970] __schedule+0x34c at 3089c424
> >>  #1 [997df9e0] schedule+0x7e at 3089cafe
> >>  #2 [997dfa20] schedule_timeout+0x26e at 308a1d8e
> >>      [inlined] do_wait_for_common
> >>      [inlined] __wait_for_common
> >>  #3 [997dfad8] wait_for_common+0x14a at 3089d902
> >>     [ret call] wait_for_completion+0x1a at 3089d96a
> >>
> >>      [inlined] wait_for_ap_thread                      <<< blocked on =
`cpuhp_state:1.done_up` completion
> >>     [ret call] __cpuhp_kick_ap+0x76 at 300c610e
> >>  #4 [997dfb58] cpuhp_kick_ap+0xc4 at 300c61dc
> >>      [inlined] bringup_wait_for_ap
> >>     [ret call] bringup_cpu+0xea at 300c6402
> >>  #5 [997dfba8] cpuhp_invoke_callback+0xcc at 300c4f14
> >>  #6 [997dfc40] _cpu_up+0x16a at 300c798a               <<< holds the `=
cpu_hotplug_lock` for writing
> >>  #7 [997dfc98] do_cpu_up+0xc6 at 300c7b66
> >>  #8 [997dfcd8] cpu_subsys_online+0x58 at 305a0a00
> >>  #9 [997dfd28] device_online+0x9e at 30598e7e
> >> #10 [997dfd68] online_store+0x88 at 30598f28
> >> #11 [997dfda8] kernfs_fop_write+0xdc at 3040276c
> >> #12 [997dfdf8] vfs_write+0xa8 at 30354760
> >> #13 [997dfe58] ksys_write+0x62 at 30354a32
> >>
> >> crash> cpuhp_cpu_state.state cpuhp_state:a | paste - -
> >> [0]: 1aef424e0      state =3D CPUHP_ONLINE,               # (195)
> >> [1]: 1aef654e0      state =3D CPUHP_AP_WORKQUEUE_ONLINE,  # (159)
> >>
> >> crash> cpuhp_cpu_state.bringup,thread,done_up.done cpuhp_state:1 -d | =
paste - - - -
> >> [1]: 1aef654e0      bringup =3D true,      thread =3D 0x81134400,     =
 done_up.done =3D 0,  <<<
> >>
> >> crash> b 17
> >> PID: 17       TASK: 81134400          CPU: 1    COMMAND: "cpuhp/1"
> >>  #0 [81143b68] __schedule+0x34c at 3089c424
> >>  #1 [81143bd8] schedule+0x7e at 3089cafe
> >>  #2 [81143c18] schedule_preempt_disabled+0x2a at 3089cfba
> >>  #3 [81143c30] __mutex_lock+0x320 at 3089df60
> >>
> >>  #4 [81143cb0] workqueue_online_cpu+0x9e at 300e847e   <<< blocked on =
`wq_pool_attach_mutex`
> >>  #5 [81143d20] cpuhp_invoke_callback+0xcc at 300c4f14
> >>  #6 [81143db8] cpuhp_thread_fun+0x108 at 300c6848      <<< supposed to=
 complete the bring-up of the CPU (`cpuhp_state:1.done_up`)
> >>
> >> crash> b 745
> >> PID: 745      TASK: 82359100          CPU: 0    COMMAND: "xfs-conv/dm-=
0"
> >>  #0 [8b4bfa20] __schedule+0x34c at 3089c424
> >>  #1 [8b4bfa90] schedule+0x7e at 3089cafe
> >>  #2 [8b4bfad0] schedule_timeout+0x26e at 308a1d8e
> >>      [inlined] do_wait_for_common
> >>      [inlined] __wait_for_common
> >>  #3 [8b4bfb88] wait_for_common+0x14a at 3089d902
> >>     [ret call] wait_for_completion+0x1a at 3089d96a
> >>
> >>  #4 [8b4bfc08] affine_move_task+0x10a at 300fb51a        <<< blocked o=
n `task->migration_pending->done` completion
> >>  #5 [8b4bfd08] __set_cpus_allowed_ptr+0x12e at 300fb926
> >>     [ret call] set_cpus_allowed_ptr+0xa at 300fba32
> >>  #6 [8b4bfd78] worker_attach_to_pool+0x66 at 300e1dae    <<< holds the=
 `wq_pool_attach_mutex`
> >>  #7 [8b4bfdc8] rescuer_thread+0x12c at 300e5bac
> >>
> >> crash> rx 8b4bfea0
> >>         8b4bfea0:  [863373c0:kmalloc-192]
> >>
> >> crash> worker.task,rescue_wq 863373c0
> >>   task =3D 0x82359100,
> >>   rescue_wq =3D 0x8aa44400,
> >>
> >> crash> list -s pool_workqueue.pool pool_workqueue.mayday_node -hO work=
queue_struct.maydays 0x8aa44400 | paste - -
> >> 1fffff7f751900    pool =3D 0x1aef56a00,
> >>
> >> crash> worker_pool.attrs 0x1aef56a00
> >>   attrs =3D 0x80088180,
> >>
> >> crash> workqueue_attrs.cpumask[0].bits 0x80088180
> >>   cpumask[0].bits =3D {0x1, 0x0, ...
> >>
> >> crash> cpumask.bits __cpu_active_mask
> >>   bits =3D {0x1, 0x0, ...
> >>
> >> crash> cpumask.bits __cpu_online_mask
> >>   bits =3D {0x3, 0x0, ...
> >>
> >> crash> task_struct.migration_pending,flags 0x82359100
> >>     migration_pending =3D 0x8b4bfce8,
> >>   flags =3D 0x4208060,
> >>              ^ PF_KTHREAD
> >>
> >> crash> pd distribute_cpu_mask_prev:0
> >> per_cpu(distribute_cpu_mask_prev, 0) =3D 0
> >>
> >> crash> set_affinity_pending.refs.refs.counter,arg,stop_pending,done.do=
ne 0x8b4bfce8 -d
> >>   refs.refs.counter =3D 1
> >>   arg =3D {
> >>     task =3D 0x82359100,
> >>     dest_cpu =3D 0,
> >>     pending =3D 0x8b4bfce8
> >>   }
> >>   stop_pending =3D 1,
> >>   done.done =3D 0,
> >> ~~~
> >>
> >> In other words the `set_cpus_allowed_ptr()` is called from a worker th=
read which
> >> tries to migrate. The worker pool is only allowed on CPU 0 and that wa=
s supposed
> >> to be the destination as per the stack structure. In this case I thoug=
ht it's OK
> >> to leave the task on the old CPU
> >
> > AFAICT if a call to set_cpus_allowed_ptr() ends up in affine_move_task(=
)
> > and down to the stopper call, that means the task isn't allowed on its
> > current CPU and needs to be moved.
> >
> >> and the Bill's testing scenario was successful
> >> with the proposed patch. IIUC, it's exercising the hotplug due to load=
-balancing.
> >>
> >> This was on RHEL 8.8.z kernel. I see upstream changed a bit so I'm not=
 sure it's
> >> still reproducible. Also, I'm not sure why this only happens on s390 a=
nd not on
> >> x86. I imagine the CPU hotplug slightly differs? Anyways this seems to=
 be timing
> >> sensitive and the timing will differ greatly for sure.
> >>
> >
> > Thanks for the extra context!
> >
> > Double checking what I wrote before, I forgot RCU considers preempt-off
> > sections as read-side critical sections. __set_cpus_allowed_ptr() alrea=
dy
> > has preemption disabled all the way from reading the cpu_active_mask to=
 the
> > stop_one_cpu_nowait() call via task_rq_lock() + preempt_disable().
> >
> > IOW we have:
> >
> > __set_cpus_allowed_ptr()
> >   task_rq_lock() <-- PREEMPT OFF
> >   __set_cpus_allowed_ptr_locked()
> >     cpu_valid_mask =3D cpu_active_mask;
> >     dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->new_ma=
sk);
> >     affine_move_task()
> >       preempt_disable();
> >       task_rq_unlock();
> >       stop_one_cpu_nowait(); <-- preemption still OFF
> >
> > And, considering:
> >
> > sched_cpu_deactivate()
> >   set_cpu_active(cpu, false);
> >   synchronize_rcu();
> >
> > Then, if __set_cpus_allowed_ptr() observes a CPU as being in the
> > cpu_active_mask and uses that one as a destination CPU, said CPU cannot
> > reach CPUHP_TEARDOWN_CPU:take_cpu_down() and park the stopper thread
> > because its hotplug machinery will wait on the synchronize_rcu() in
> > CPUHP_AP_ACTIVE:sched_cpu_deactivate().
> >
> > So "in theory", this shouldn't happen upstream.
>
> Eh nevermind, in your stacktrace the relevant task is a rescuer thread
> which is a kthread, so the cpu_valid_mask in use there is
> cpu_online_mask, not cpu_valid_mask... Back to reading code :-)

I just wanted to correct you on this point but you figured it out for
yourself after all.

On the other hand the `new_mask` (which comes from the worker pool allowed =
CPUs)

~~~
2102 static void worker_attach_to_pool(struct worker *worker,
2103                                    struct worker_pool *pool)
2104 {
2105         mutex_lock(&wq_pool_attach_mutex);
--
2117         if (worker->rescue_wq)
2118                 set_cpus_allowed_ptr(worker->task,
pool_allowed_cpus(pool));

2827 static int rescuer_thread(void *__rescuer)
2828 {
2829         struct worker *rescuer =3D __rescuer;
2830         struct workqueue_struct *wq =3D rescuer->rescue_wq;
--
2856         while (!list_empty(&wq->maydays)) {
2857                 struct pool_workqueue *pwq =3D list_first_entry(&wq->m=
aydays,
2858                                         struct pool_workqueue,
mayday_node);
2859                 struct worker_pool *pool =3D pwq->pool;
--
2863                 list_del_init(&pwq->mayday_node);
2864
2865                 raw_spin_unlock_irq(&wq_mayday_lock);
2866
2867                 worker_attach_to_pool(rescuer, pool);
2868
2869                 raw_spin_lock_irq(&pool->lock);
~~~

 matches the `cpu_valid_mask` and is ANDed to the `cpu_online_mask` so
the final result is the same...

Actually double checking now, I may have pulled the wrong pool as the
right `pwq` is removed from the `maydays` list on line 2863 (the code
is similar in RHEL 8.8) and I have used whatever `pwq` was remaining
on that list, but possibly unrelated.

~~~
crash> rx 8b4bfe30
        8b4bfe30:  00000001aef56a00

crash> worker_pool.attrs 1aef56a00
  attrs =3D 0x80088180,

crash> workqueue_attrs.cpumask[0].bits 0x80088180
  cpumask[0].bits =3D {0x1, 0x0, ...

crash> set_affinity_pending.refs.refs.counter,arg,stop_pending,done.done
0x8b4bfce8
  refs.refs.counter =3D 0x1
  arg =3D {
    task =3D 0x82359100,
    dest_cpu =3D 0x0,
    pending =3D 0x8b4bfce8
  }
  stop_pending =3D 0x1,
  done.done =3D 0x0,
~~~

Nah, so not unrelated. It's the right one. The rescuer was deadlocked
for almost 3 days at the time the vmcore was collected, so it seems
the `pwq` returned to the `maydays` list in the meantime. And I guess
the pool cpumask could have changed as well. Nevertheless, the local
`affine_move_task::my_pending.arg.dest_cpu` on stack still shows CPU 0
was selected that time.

So far I don't see why upstream would not be prone to the same issue.
But I may be missing something.

--nX


