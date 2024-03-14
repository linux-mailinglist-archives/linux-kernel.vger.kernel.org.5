Return-Path: <linux-kernel+bounces-102758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B0787B6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96571F21E41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33E53A0;
	Thu, 14 Mar 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G81vP9Zc"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC951C01
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710388170; cv=none; b=XWNvddIj94QRdnxwJQajR4KO5gueg76tmxkaXqGWqTLob0VnHzYHDFIBchOe67PNpMXOO1xSIFPytMrpcvBE54va7IB6UL1pdotI7xw37qXdww2xjOyObHIuostjAdffsmI2vY3Xd8sS87nqgpei1oWvMp9r6wfDW4F74uMiEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710388170; c=relaxed/simple;
	bh=z0hPcoSw5SKOhwZh4MYap5Gn5oH5ApG+sA8IlF6m1R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brQIuliRcZV/WepgKQvjJU/WaHL5Ats+q6gCgyqa9w+0NaGCUxmGq+BBMEuip46Waz+AZV3Kp+bZHMfs91y0S6Zpxa1HR+ru91OiHAoaVL92yaQS5ovtht/aLDhzJSdY9bah71+qqy72FteZH75kGjcH3Hc3zWtukVemuSX08uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G81vP9Zc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so600978a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710388167; x=1710992967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG1Um10i0kQfwHXdox31jxXiolLQjFBuD+6AapKtvKY=;
        b=G81vP9Zci8dmPIqS601IYfoMmX2o9VjAYIA6Wr/elFydp372QVAIgXQRX7THhcDndA
         P5OsDXatFA5jmO6TbTWv+nC6NfYNC6BDIoRrieyzvJBmsfkHsyJ7mLQgt7lKUSE6TDzZ
         7+5nyZFoc3zaSbO8zmAytLZNhA1stUpZRcstC1QMrXvPdixpKVIxG1pJJSXZ5JUWid7z
         JZSAqd7IsgwupROdL/wqrZi3FpRW4LxmtAez7Dn9eQpolDi+QzgGARb7IWEWK49goDCf
         6mn9Oe1bMtpiwigTpzoRl7mmU+j7MKZbVDN9jUAAxJinJ0I63qIAw0dcKbJJFIHmgH6r
         WmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710388167; x=1710992967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG1Um10i0kQfwHXdox31jxXiolLQjFBuD+6AapKtvKY=;
        b=bvyjh4hGAe//LGiA8tZNhQJCzQ4aIZGQ9j7joKcJXi3qRUvlJkIrrA8AVxSADsb0Ef
         Ma5jibYR1NSDTEQ84KAC48sElqMevsge1GuIyIf5SK0iozhxv/mfVWt9sCn18XZ1PgwH
         IeNM9riFnGRD51Rz//woZ38GTJnI8kYx32vrKxRv8IgpYjG/EpX1SIcqqolbnDCfjPwP
         k6thqcXHVSwLLJGxMJEipi+0n+ig9vPFyARqW9EJI34+yIym5knl9P/hHt1SJHvWB0vh
         NrU56KPHiBgx3Sztzbh11XAMGphuo97gn0HHQgnfNcnMgOB/TWb6ef+BShtPdSe5M/3P
         r3Eg==
X-Gm-Message-State: AOJu0YxMsILl+oj5jYLk8XkUGZiVGPnYVtzk5JfifBnz6sjNy8dVue5I
	EqxwVD0ocs/W22nU7+ydWkiLjqBqr9TRXfrYAerX9DgwzkwyEdqnU6iUAa9EV2c8iMGtif8BSfx
	1JgNElT+TrTKth8eEM4gaeYq+l4Y=
X-Google-Smtp-Source: AGHT+IF2tDa9IXXFyiDX0QNabyiWLGaeRbuatMUZK7unqdU/nJkwvs/rJm/07CGtM9AnysgFu6AKjb39kVzOlMPS3wc=
X-Received: by 2002:a05:6402:2483:b0:568:1a8:58b with SMTP id
 q3-20020a056402248300b0056801a8058bmr317750eda.14.1710388166713; Wed, 13 Mar
 2024 20:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085817.48892-1-zegao@tencent.com> <d43ed111-085b-432b-ad5b-433d5031fad1@arm.com>
 <CAD8CoPAC0ti2=mAbP5GMN6ZidZnPV-Antf7KrjwPtEnE7gYOdg@mail.gmail.com>
In-Reply-To: <CAD8CoPAC0ti2=mAbP5GMN6ZidZnPV-Antf7KrjwPtEnE7gYOdg@mail.gmail.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 14 Mar 2024 11:49:15 +0800
Message-ID: <CAD8CoPCAU0OnE9R-usnyggRO5BZe3ey5=JOK8Waf3pvs7uQTtQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Mel Gorman <mgorman@suse.de>, Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Ben Segall <bsegall@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:59=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote=
:
>
> On Wed, Mar 13, 2024 at 11:16=E2=80=AFPM Pierre Gondois <pierre.gondois@a=
rm.com> wrote:
> >
> > Hello Ze,
> >
> > I am running stress-ng with the following command:
> >    stress-ng -c 1 -l 10 &
> > and migrating the process with:
> >    taskset -pc [cpus] [pid]
> >
> > The thread seems to be migrated via:
> > sched_setaffinity
> >    \-__sched_setaffinity()
> >      \-__set_cpus_allowed_ptr()
> >        \-__set_cpus_allowed_ptr_locked()
> >          \- [1]
>
>
>
> > [1]
> > /*
> >   * Picking a ~random cpu helps in cases where we are changing affinity
> >   * for groups of tasks (ie. cpuset), so that load balancing is not
> >   * immediately required to distribute the tasks within their new mask.
> >   */
> > dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
> >
> > So it seems the destination CPU chosen among the new CPU affinity mask =
is done
> > here, by picking a random CPU in the mask.
>
> IIUC, this is for running/queued/waking tasks instead of blocked tasks.
>
> Am I missing something obvious here?
>
> > Checking the cpus_ptr in select_idle_sibling() might be useful in other=
 cases,
> > but I think the experiment doesn't show that. Maybe a another small twe=
ak could
>
> The experiment is used to illustrate that the status quo does not do well
> but has to rely on select_fallback_rq() to choose a cpu for a woken task
> which turns out to be a bad choice since it's already monopolized by a
> cpu bound task, that is why a second migration happens with the help
> of the load balancer.

Btw, perf alone does not show obvious results here, you need some
other observability tools to make sure the migration is not initiated by
__set_cpus_allowed_ptr_locked (i.e., for running tasks). I achieve this
by directly adding some tracepoints to both select_fallback_rq() and
select_idle_sibling().

Regards,
        -- Ze

> Actually, we can reuse the same reasons for doing so as in
>
>     commit 46a87b3851f0("sched/core: Distribute tasks within affinity mas=
ks")
>
> > be done at [1] instead ?
>
> As for blocked tasks, check out what is commented on set_task_cpu() and
> select_task_rq(), since we never call set_task_cpu() on blocked tasks whi=
ch
> in turn, we have no way to change p->wake_cpu to dest_cpu being randomly
> chosen here, so when it's woken up, it still needs to go through the
> select_task_rq() process using the outdated p->wake_cpu.
>
>
> Thanks,
>         -- Ze
>
> > Regards,
> > Pierre
> >
> > On 3/13/24 09:58, Ze Gao wrote:
> > > We observered select_idle_sibling() is likely to return the *target* =
cpu
> > > early which is likely to be the previous cpu this task is running on =
even
> > > when it's actually not within the affinity list newly set, from where=
 after
> > > we can only rely on select_fallback_rq() to choose one for us at its =
will
> > > (the first valid mostly for now).
> > >
> > > However, the one chosen by select_fallback_rq() is highly likely not =
a
> > > good enough candidate, sometimes it has to rely on load balancer to k=
ick
> > > in to place itself to a better cpu, which adds one or more unnecessar=
y
> > > migrations in no doubt. For example, this is what I get when I move t=
ask
> > > 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> > >
> > >          swapper       0 [013]   959.791829: sched:sched_migrate_task=
: comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D13 dest_cpu=3D23
> > > kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task:=
 comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D23 dest_cpu=3D24
> > >
> > > The thing is we can actually do better if we do checks early and take=
 more
> > > advantages of the *target* in select_idle_sibling(). That is, we cont=
inue
> > > the idle cpu selection if *target* fails the test of cpumask_test_cpu=
(
> > > *target*, p->cpus_ptr). By doing so, we are likely to pick a good can=
didate,
> > > especially when the newly allowed cpu set shares some cpu resources w=
ith
> > > *target*.
> > >
> > > And with this change, we clearly see the improvement when I move task=
 3964
> > > to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> > >
> > >          swapper       0 [027]  4249.204658: sched:sched_migrate_task=
: comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D27 dest_cpu=3D26
> > >
> > > Note we do the same check for *prev* in select_idle_sibling() as well=
.
> > >
> > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > ---
> > >   kernel/sched/fair.c | 13 ++++++++-----
> > >   1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 533547e3c90a..9ef6e74c6b2a 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7511,16 +7511,19 @@ static int select_idle_sibling(struct task_st=
ruct *p, int prev, int target)
> > >        */
> > >       lockdep_assert_irqs_disabled();
> > >
> > > -     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> > > -         asym_fits_cpu(task_util, util_min, util_max, target))
> > > +     if (cpumask_test_cpu(target, p->cpus_ptr) &&
> > > +             (available_idle_cpu(target) || sched_idle_cpu(target)) =
&&
> > > +             asym_fits_cpu(task_util, util_min, util_max, target))
> > >               return target;
> > >
> > >       /*
> > >        * If the previous CPU is cache affine and idle, don't be stupi=
d:
> > >        */
> > > -     if (prev !=3D target && cpus_share_cache(prev, target) &&
> > > -         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > > -         asym_fits_cpu(task_util, util_min, util_max, prev)) {
> > > +     if (cpumask_test_cpu(prev, p->cpus_ptr) &&
> > > +             prev !=3D target &&
> > > +             cpus_share_cache(prev, target) &&
> > > +             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > > +             asym_fits_cpu(task_util, util_min, util_max, prev)) {
> > >
> > >               if (!static_branch_unlikely(&sched_cluster_active) ||
> > >                   cpus_share_resources(prev, target))

