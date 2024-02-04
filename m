Return-Path: <linux-kernel+bounces-51388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D781E848ABD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826FA283EB2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9003517F7;
	Sun,  4 Feb 2024 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5DVIbiV"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61C10F1
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707015938; cv=none; b=nz/67wipakkLM63Hze3eWIOyDw4ULEwgdxE7rEJx7m20n5kGq+nxsPwhZf3yMVfDpaPh26RNqnBlCNMhanFskQvHihCY1P4onjxVbRqorb3XSMjmPDSNrKyLYDIObFKkcQ0lYZKeCGKD7MjreriBOwy8Mh8/r4/Ch3hDjodwpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707015938; c=relaxed/simple;
	bh=fUpRvrVqzMGHonVwJIMLpWXS89N3pkGnstZUODMyxGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reQLHrWNJtGWRGOSQMNHPM5dK6UsDJ6+gLdPadNQcTtoQU8QV3EG78QG6h/bSymQrCVbCa7ExpJ2/57ueQV6QhQAhkMmeD25zbrQ18/ceVDCE9YiOefAMwwqZkut5EhzcyLxuFKZNwlHBufOJxAyikfNkm8S9l6dbmabirLPmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5DVIbiV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d09b21a8bbso7680951fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 19:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707015934; x=1707620734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NN/K7IhxXzsBHTVulwBrsBDyCVizAqr7SrV7CXrA/Y=;
        b=N5DVIbiVSZM90yyXgD3sEopNRWSBtE3qWexAVtOmqZDxWBQGdwFY9UJ7U53ne1VyZ6
         O/nJEkNWK9S7bzcNPrn8B+1hzwmVMSGgwJBt7z4iKFUwqFzG/XXbUkOT9nJElpZeObII
         u/yDj7trQ2wqs6y0vPzn8Q0TsILQIi4ycVI94d46keP1BwI27W8O3BwwyuPFwtR/W+nc
         LFaIujyZ3aPaNIuJEWeHI8sOCjuHZXJ6NJMUvRCmTHwRfZ16Tq4+H/FyCtf4tXRECxFg
         aer9cM7E7lUatfPXud0SwqlyDim3U8OqlrSWvT6/IV2wuDeJQfnB+ERAhbTeyyk2hgFk
         psxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707015934; x=1707620734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NN/K7IhxXzsBHTVulwBrsBDyCVizAqr7SrV7CXrA/Y=;
        b=JNR1ZOiCI62Lc9BhXYT2ChZy1MtIcHOIcLM0qIRsHAaI3r9wLyooy7UtUmnYvHZ38S
         cFlDTDHqFHdkcAR/N/Ex4X/2/eCFG6RbnuPboYZos/L6zKu4DVF7EmzG7aHsHaWnuSkq
         17zY0vchsHHnmmLWjmrv43v1GIoh9V+7llL2fntSahxaBxPv/nWlqIGLTsXUcwsPfDzC
         V3e6Oue5CpUXvVjhR1nmdnWaSG87GqASo/l2ukLfnVo1Xu4G1eBkYOQA/5SVE6hclBNt
         /eIr4n/L8XXvB9ljmf3CnK6Ysa/S/4BjkqIwipq995esv/s3QDKsiqWt7+e7ruHpDE7s
         gb7Q==
X-Gm-Message-State: AOJu0Yy6pg8D68UbyCyxyEgAyubpGdGAGPKkUp4YXXhUXzy8qgTBgH6Q
	r9sTtPqBxOxGIfF3XjIO+7rOaWmZ5/62YqrJogo+tXk+8rgQ3aXYPLoFRUruvtx7DZjKREFlrow
	c/IKxZb1XUY7wHyuboQ7fTOKpfyY=
X-Google-Smtp-Source: AGHT+IGbzx/O71WURzc122m7Jm1Hq+fce5vgcckWE4nORhLY/NO9xcDvYhPZGGE3wiR/0vUaBdaHA3FyYJQndxFxInE=
X-Received: by 2002:a2e:8e89:0:b0:2cc:d889:8d97 with SMTP id
 z9-20020a2e8e89000000b002ccd8898d97mr7804987ljk.14.1707015934213; Sat, 03 Feb
 2024 19:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111115745.62813-2-zegao@tencent.com> <Za-0HCP7WG3PIe7h@linux.ibm.com>
 <CAD8CoPAJh9ggK8ODYFiUaF2WXPG4d5ERDUdpL532N5kc=-xuSw@mail.gmail.com> <ZbzW6EuJ1gFTi80U@linux.ibm.com>
In-Reply-To: <ZbzW6EuJ1gFTi80U@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Sun, 4 Feb 2024 11:05:22 +0800
Message-ID: <CAD8CoPD1edPmqgDVS1X6G2z-k4aPnCxm=KyCaf9PteOUm=--QQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Use tunable knob sysctl_sched_base_slice
 as explicit time quanta
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 7:50=E2=80=AFPM Vishal Chourasia <vishalc@linux.ibm.=
com> wrote:
>
> On Wed, Jan 24, 2024 at 10:32:08AM +0800, Ze Gao wrote:
> > > Hi, How are you setting custom request values for process A and B?
> >
> > I cherry-picked peter's commit[1], and adds a SCHED_QUANTA feature cont=
rol
> > for testing w/o my patch.  You can check out [2] to see how it works.
> >
> Thank you sharing your setup.
>
> Built the kernel according to [2] keeping v6.8.0-rc1 as base
>
> // NO_SCHED_QUANTA
> # perf script -i perf.data.old  -s perf-latency.py
> PID 355045: Average Delta =3D 87.72726154385964 ms, Max Delta =3D 110.015=
044 ms, Count =3D 57
> PID 355044: Average Delta =3D 92.2655679245283 ms, Max Delta =3D 110.0171=
82 ms, Count =3D 53
>
> // SCHED_QUANTA
> # perf script -i perf.data  -s perf-latency.py
> PID 355065: Average Delta =3D 10.00 ms, Max Delta =3D 10.012708 ms, Count=
 =3D 500
> PID 355064: Average Delta =3D 9.959 ms, Max Delta =3D 10.023588 ms, Count=
 =3D 501
>
> #  cat /sys/kernel/debug/sched/base_slice_ns
> 3000000
>
> base slice is not being enforced.
>
> Next, Looking closing at the perf.data file
>
> # perf script -i perf.data -C 1 | grep switch
> ...
>  stress-ng-cpu 355064 [001] 776706.003222:       sched:sched_switch: stre=
ss-ng-cpu:355064 [120] R =3D=3D> stress-ng-cpu:355065 [120]
>  stress-ng-cpu 355065 [001] 776706.013218:       sched:sched_switch: stre=
ss-ng-cpu:355065 [120] R =3D=3D> stress-ng-cpu:355064 [120]
>  stress-ng-cpu 355064 [001] 776706.023218:       sched:sched_switch: stre=
ss-ng-cpu:355064 [120] R =3D=3D> stress-ng-cpu:355065 [120]
>  stress-ng-cpu 355065 [001] 776706.033218:       sched:sched_switch: stre=
ss-ng-cpu:355065 [120] R =3D=3D> stress-ng-cpu:355064 [120]
> ...
>
> Delta wait time is approx 0.01s or 10ms

You can check out your HZ, which should be 100 in your settings
in my best guess.That explains your results.

> So, switch is not happening at base_slice_ns boundary.
>
> But why? is it possible base_slice_ns is not properly used in
> arch !=3D x86 ?

The thing is  in my RFC the effective quanta is actually

   max_t(u64, TICK_NSEC, sysctl_sched_base_slice)

where sysctl_sched_base_slice is precisely a handy tunable knob
for users ( maybe i should make it loud and clear more ).

See what I do in update_entity_lag(), you will understand.

Note we have 3 time related concepts here:
1. TIME TICK: (schedule) accounting time unit.
2. TIME QUANTA =EF=BC=88not necessarily the effective one): scheduling time=
 unit
3. USER SLICE: time slice per request

To implement latency-nice while being as fair as possible, We must
carefully consider the size relationship between them, and especially
the value range of USER SLICE due to the cold fact that the lag(
unfairness) is literally subject to both time quanta and user requested
slices.


Regards,
        -- Ze

> >
> > echo NO_SCHED_QUANTA > /sys/kernel/debug/sched/features
> > test
> > sleep 2
> > echo SCHED_QUANTA > /sys/kernel/debug/sched/features
> > test
> >
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/c=
ommit/kernel/sched?h=3Dsched/eevdf&id=3D98866150f92f268a2f08eb1d884de9677eb=
4ec8f
> > [2]: https://github.com/zegao96/linux/tree/sched-eevdf
> >
> >
> > Regards,
> >         -- Ze
> >
> > > >
> > > >                       stress-ng-cpu:10705     stress-ng-cpu:10706
> > > > -------------------------------------------------------------------=
--
> > > > Slices(ms)            100                     0.1
> > > > Runtime(ms)           4934.206                5025.048
> > > > Switches              58                      67
> > > > Average delay(ms)     87.074                  73.863
> > > > Maximum delay(ms)     101.998                 101.010
> > > >
> > > > In contrast, using sysctl_sched_base_slice as the size of a 'quantu=
m'
> > > > in this patch gives us a better control of the allocation accuracy =
and
> > > > the avg latency:
> > > >
> > > >                       stress-ng-cpu:10584     stress-ng-cpu:10583
> > > > -------------------------------------------------------------------=
--
> > > > Slices(ms)            100                     0.1
> > > > Runtime(ms)           4980.309                4981.356
> > > > Switches              1253                    1254
> > > > Average delay(ms)     3.990                   3.990
> > > > Maximum delay(ms)     5.001                   4.014
> > > >
> > > > Furthmore, with sysctl_sched_base_slice =3D 10ms, we might benefit =
from
> > > > less switches at the cost of worse delay:
> > > >
> > > >                       stress-ng-cpu:11208     stress-ng-cpu:11207
> > > > -------------------------------------------------------------------=
--
> > > > Slices(ms)            100                     0.1
> > > > Runtime(ms)           4983.722                4977.035
> > > > Switches              456                     456
> > > > Average delay(ms)     10.963                  10.939
> > > > Maximum delay(ms)     19.002                  21.001
> > > >
> > > > By being able to tune sysctl_sched_base_slice knob, we can achieve
> > > > the goal to strike a good balance between throughput and latency by
> > > > adjusting the frequency of context switches, and the conclusions ar=
e
> > > > much close to what's covered in [1] with the explicit definition of
> > > > a time quantum. And it aslo gives more freedom to choose the eligib=
le
> > > > request length range(either through nice value or raw value)
> > > > without worrying about overscheduling or underscheduling too much.
> > > >
> > > > Note this change should introduce no obvious regression because all
> > > > processes have the same request length as sysctl_sched_base_slice a=
s
> > > > in the status quo. And the result of benchmarks proves this as well=
.
> > > >
> > > > schbench -m2 -F128 -n10       -r90    w/patch tip/6.7-rc7
> > > > Wakeup  (usec): 99.0th:               3028    95
> > > > Request (usec): 99.0th:               14992   21984
> > > > RPS    (count): 50.0th:               5864    5848
> > > >
> > > > hackbench -s 512 -l 200 -f 25 -P      w/patch  tip/6.7-rc7
> > > > -g 10                                         0.212   0.223
> > > > -g 20                                 0.415   0.432
> > > > -g 30                                 0.625   0.639
> > > > -g 40                                 0.852   0.858
> > > >
> > > > [1]: https://dl.acm.org/doi/10.5555/890606
> > > > [2]: https://lore.kernel.org/all/20230420150537.GC4253@hirez.progra=
mming.kicks-ass.net/T/#u
> > > >
> > > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > > ---
> > >
> >

