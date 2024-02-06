Return-Path: <linux-kernel+bounces-54437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026D84AF35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98281F24207
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DF012A159;
	Tue,  6 Feb 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2aR3vhz"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21295129A6B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205830; cv=none; b=kiB6LJa13W3jDc7L2hXOjFdImyTKowRibxrbFIKpVnxuEsKZUwPZdxnVbDEQ7gaRJ9pJBSeoMljIXHhhWpOIv/AxbWSeJnjuzc9ain77u74VLCZN1J4jj5hdtW8LjBJPSDqg9LoH9FW0mgJs/mt3PtCfbQDhHqAr43Mbj3uJXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205830; c=relaxed/simple;
	bh=PBS4QMX4MwPwZraXF5tMjrRdcEcRkXqB1YFnsi40Zxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urCxM3Yy7UUkaRqJSOSEfbWlt+1tlRWNFYpoyjXVc3x1wrZgv8Wzz1L89QCYr3WByrc0aw817SG4nij/saI1Lqhx4RPlG1GkbnR8VivoyN4ZV/U2W7TyOtjTl2p+YFIgbsO3JK5Jdn8eWUfnGpBdQZzLl/soynEGjcXmUNxaXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2aR3vhz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so6896729a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707205826; x=1707810626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RntRiOG9cjXJ/aBK4AOnCHrohCp+7DECYbtQ5rwLGmI=;
        b=S2aR3vhzisAB1nHg30p4fls5RXMpQYnmW7RKAJSl0K7g05vmj70a4U8+XZ/VCweDfN
         phckZPlhbzOn4GOBCW8gwESXJqNKWQO29dFhGCbV9uMHWSMvdEogQf/sS6BhOY3LsSsv
         rYSh+GS1+ho2ucpSJXvZzTxoY2XGZ/fC0jvQ2xBMFnulC72b7wUal3WXofSlh5ngGpoR
         0CTKQ1f3KhSn5OMNqlWc0ZPWbWP6HV5Epj4g5OZMkJIScX33pxn8DLSLZaJEoFv3TfhT
         +NQskjua0hs23ysGyXEw5IpoeKqTxtJ7xYce62TxsgoPIkwHza06Nv6vewGleljxBBVW
         k6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205826; x=1707810626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RntRiOG9cjXJ/aBK4AOnCHrohCp+7DECYbtQ5rwLGmI=;
        b=PEydOXEG+YFf4at0ajxrBbLw42S0hynaSJAGAkg5Lg6TUIx1TLNhDHdHLoW+xJ1Ewo
         NIgalUMm6TtW9VVi34k0O/GWHCNMRB3NxItTvYzpqV46Wz7Cbk9vR4+3Mv8SzswRKyhd
         K9wcOR6GutgirzR1IU5ry30UCfbdVPYQqjWTWFq780LFL/WA25CrFU/u//Jl1f2RZ7MX
         5pISfgbfbGdswTwmIzJEH9HzMn1YpuA0rZk3SiahP9rCylFf+s+kYxBo3fqq3BAJF99F
         PqBVtyptn5LG8bqsDMW6zkPX0kHYOLBfghZ2YJEEKNoxyfN1r+AOgFZSIBOz+n5JEfvo
         DwvQ==
X-Gm-Message-State: AOJu0Yy7eHlf2MCQ3xG3OMJoWz8MsryuzMxtO0xYxWco09zQdx+etgkS
	GmwfYcz0fFziW+uQzwJvypm6HpzT+GuAoSr0qd1yIPVSHvdqHLewGFqJo1nPVD2rIkPzv7lFrCk
	Oj/jECg4IzflJQP30gLhEzykKkf8=
X-Google-Smtp-Source: AGHT+IFbtyj8AeD9PPHel/qS/rBMcWih7aBTP0VhU5RfshRfaqKr46Sjmg5f2OO4xVgmb79kQ5yyHbn+AtUb72RLSTU=
X-Received: by 2002:aa7:df0a:0:b0:55f:6a35:b541 with SMTP id
 c10-20020aa7df0a000000b0055f6a35b541mr1046680edy.14.1707205825946; Mon, 05
 Feb 2024 23:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111115745.62813-2-zegao@tencent.com> <Za-0HCP7WG3PIe7h@linux.ibm.com>
 <CAD8CoPAJh9ggK8ODYFiUaF2WXPG4d5ERDUdpL532N5kc=-xuSw@mail.gmail.com>
 <ZbzW6EuJ1gFTi80U@linux.ibm.com> <CAD8CoPD1edPmqgDVS1X6G2z-k4aPnCxm=KyCaf9PteOUm=--QQ@mail.gmail.com>
 <ZcCQJGNHgY1inVmL@linux.ibm.com>
In-Reply-To: <ZcCQJGNHgY1inVmL@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Tue, 6 Feb 2024 15:50:14 +0800
Message-ID: <CAD8CoPCQSSTMyV_LOTR6oC6vpdkeQd_v2wiRK6Q98bbQwEYZSw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Use tunable knob sysctl_sched_base_slice
 as explicit time quanta
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:37=E2=80=AFPM Vishal Chourasia <vishalc@linux.ibm.=
com> wrote:
>
> On Sun, Feb 04, 2024 at 11:05:22AM +0800, Ze Gao wrote:
> > On Fri, Feb 2, 2024 at 7:50=E2=80=AFPM Vishal Chourasia <vishalc@linux.=
ibm.com> wrote:
> > >
> > > On Wed, Jan 24, 2024 at 10:32:08AM +0800, Ze Gao wrote:
> > > > > Hi, How are you setting custom request values for process A and B=
?
> > > >
> > > > I cherry-picked peter's commit[1], and adds a SCHED_QUANTA feature =
control
> > > > for testing w/o my patch.  You can check out [2] to see how it work=
s.
> > > >
> > > Thank you sharing your setup.
> > >
> > > Built the kernel according to [2] keeping v6.8.0-rc1 as base
> > >
> > > // NO_SCHED_QUANTA
> > > # perf script -i perf.data.old  -s perf-latency.py
> > > PID 355045: Average Delta =3D 87.72726154385964 ms, Max Delta =3D 110=
015044 ms, Count =3D 57
> > > PID 355044: Average Delta =3D 92.2655679245283 ms, Max Delta =3D 110.=
017182 ms, Count =3D 53
> > >
> > > // SCHED_QUANTA
> > > # perf script -i perf.data  -s perf-latency.py
> > > PID 355065: Average Delta =3D 10.00 ms, Max Delta =3D 10.012708 ms, C=
ount =3D 500
> > > PID 355064: Average Delta =3D 9.959 ms, Max Delta =3D 10.023588 ms, C=
ount =3D 501
> > >
> > > #  cat /sys/kernel/debug/sched/base_slice_ns
> > > 3000000
> > >
> > > base slice is not being enforced.
> > >
> > > Next, Looking closing at the perf.data file
> > >
> > > # perf script -i perf.data -C 1 | grep switch
> > > ...
> > >  stress-ng-cpu 355064 [001] 776706.003222:       sched:sched_switch: =
stress-ng-cpu:355064 [120] R =3D=3D> stress-ng-cpu:355065 [120]
> > >  stress-ng-cpu 355065 [001] 776706.013218:       sched:sched_switch: =
stress-ng-cpu:355065 [120] R =3D=3D> stress-ng-cpu:355064 [120]
> > >  stress-ng-cpu 355064 [001] 776706.023218:       sched:sched_switch: =
stress-ng-cpu:355064 [120] R =3D=3D> stress-ng-cpu:355065 [120]
> > >  stress-ng-cpu 355065 [001] 776706.033218:       sched:sched_switch: =
stress-ng-cpu:355065 [120] R =3D=3D> stress-ng-cpu:355064 [120]
> > > ...
> > >
> > > Delta wait time is approx 0.01s or 10ms
> >
> > You can check out your HZ, which should be 100 in your settings
> > in my best guess.That explains your results.
> Yes. How much is it in your case? If I may ask.

Like I mentioned in the changelog: with HZ=3D1000, sysctl_sched_base_slice=
=3D3ms,
nr_cpu=3D42.

> > > So, switch is not happening at base_slice_ns boundary.
> > >
> > > But why? is it possible base_slice_ns is not properly used in
> > > arch !=3D x86 ?
> >
> > The thing is  in my RFC the effective quanta is actually
> >
> >    max_t(u64, TICK_NSEC, sysctl_sched_base_slice)
> >
> > where sysctl_sched_base_slice is precisely a handy tunable knob
> > for users ( maybe i should make it loud and clear more ).
> >
> > See what I do in update_entity_lag(), you will understand.
> Thanks. I will look into it.
> >
> > Note we have 3 time related concepts here:
> > 1. TIME TICK: (schedule) accounting time unit.
> > 2. TIME QUANTA =EF=BC=88not necessarily the effective one): scheduling =
time unit
> > 3. USER SLICE: time slice per request
> To double check,
> User slice is the request size submitted by a competing task for the time=
-shared resource (here,
> processor) against other competing tasks.
> Scheduler allocates time-shared resource (here, processor) in `q` quantum
> which is our TIME QUANTA
> TIME TICK is time period between two scheduler ticks.

Yeah, that is what I see them.

Note we don't necessarily allocate time quantum continuously to fulfil a us=
er's
request.

To quote from the paper, "by decoupling the request size from the size of a=
 time
quantum, ... gives a client possibility of trading between allocation
accuracy and
scheduling overhead". This is the very reason why this patch proposes to br=
ing
the concept of time quanta into existence.

Cheers,
        -- Ze

> Thanks,
>  -- vishal.c
> >
> > To implement latency-nice while being as fair as possible, We must
> > carefully consider the size relationship between them, and especially
> > the value range of USER SLICE due to the cold fact that the lag(
> > unfairness) is literally subject to both time quanta and user requested
> > slices.
> >
> >
> > Regards,
> >         -- Ze
> >
> > > >
> > > > echo NO_SCHED_QUANTA > /sys/kernel/debug/sched/features
> > > > test
> > > > sleep 2
> > > > echo SCHED_QUANTA > /sys/kernel/debug/sched/features
> > > > test
> > > >
> > > >
> > > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.g=
it/commit/kernel/sched?h=3Dsched/eevdf&id=3D98866150f92f268a2f08eb1d884de96=
77eb4ec8f
> > > > [2]: https://github.com/zegao96/linux/tree/sched-eevdf
> > > >
> > > >
> > > > Regards,
> > > >         -- Ze
> > > >
> > > > > >
> > > > > >                       stress-ng-cpu:10705     stress-ng-cpu:107=
06
> > > > > > ---------------------------------------------------------------=
------
> > > > > > Slices(ms)            100                     0.1
> > > > > > Runtime(ms)           4934.206                5025.048
> > > > > > Switches              58                      67
> > > > > > Average delay(ms)     87.074                  73.863
> > > > > > Maximum delay(ms)     101.998                 101.010
> > > > > >
> > > > > > In contrast, using sysctl_sched_base_slice as the size of a 'qu=
antum'
> > > > > > in this patch gives us a better control of the allocation accur=
acy and
> > > > > > the avg latency:
> > > > > >
> > > > > >                       stress-ng-cpu:10584     stress-ng-cpu:105=
83
> > > > > > ---------------------------------------------------------------=
------
> > > > > > Slices(ms)            100                     0.1
> > > > > > Runtime(ms)           4980.309                4981.356
> > > > > > Switches              1253                    1254
> > > > > > Average delay(ms)     3.990                   3.990
> > > > > > Maximum delay(ms)     5.001                   4.014
> > > > > >
> > > > > > Furthmore, with sysctl_sched_base_slice =3D 10ms, we might bene=
fit from
> > > > > > less switches at the cost of worse delay:
> > > > > >
> > > > > >                       stress-ng-cpu:11208     stress-ng-cpu:112=
07
> > > > > > ---------------------------------------------------------------=
------
> > > > > > Slices(ms)            100                     0.1
> > > > > > Runtime(ms)           4983.722                4977.035
> > > > > > Switches              456                     456
> > > > > > Average delay(ms)     10.963                  10.939
> > > > > > Maximum delay(ms)     19.002                  21.001
> > > > > >
> > > > > > By being able to tune sysctl_sched_base_slice knob, we can achi=
eve
> > > > > > the goal to strike a good balance between throughput and latenc=
y by
> > > > > > adjusting the frequency of context switches, and the conclusion=
s are
> > > > > > much close to what's covered in [1] with the explicit definitio=
n of
> > > > > > a time quantum. And it aslo gives more freedom to choose the el=
igible
> > > > > > request length range(either through nice value or raw value)
> > > > > > without worrying about overscheduling or underscheduling too mu=
ch.
> > > > > >
> > > > > > Note this change should introduce no obvious regression because=
 all
> > > > > > processes have the same request length as sysctl_sched_base_sli=
ce as
> > > > > > in the status quo. And the result of benchmarks proves this as =
well.
> > > > > >
> > > > > > schbench -m2 -F128 -n10       -r90    w/patch tip/6.7-rc7
> > > > > > Wakeup  (usec): 99.0th:               3028    95
> > > > > > Request (usec): 99.0th:               14992   21984
> > > > > > RPS    (count): 50.0th:               5864    5848
> > > > > >
> > > > > > hackbench -s 512 -l 200 -f 25 -P      w/patch  tip/6.7-rc7
> > > > > > -g 10                                         0.212   0.223
> > > > > > -g 20                                 0.415   0.432
> > > > > > -g 30                                 0.625   0.639
> > > > > > -g 40                                 0.852   0.858
> > > > > >
> > > > > > [1]: https://dl.acm.org/doi/10.5555/890606
> > > > > > [2]: https://lore.kernel.org/all/20230420150537.GC4253@hirez.pr=
ogramming.kicks-ass.net/T/#u
> > > > > >
> > > > > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > > > > ---
> > > > >
> > > >

