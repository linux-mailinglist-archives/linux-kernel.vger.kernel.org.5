Return-Path: <linux-kernel+bounces-102729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA45D87B69F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273D2B21A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEB4A08;
	Thu, 14 Mar 2024 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt66jE2v"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A41841
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385204; cv=none; b=UmEUyFOhAwfyabx/AMG8fxarGz7O2iMhpc6uXF0sLMLOz2ekS9+SZIKL9+T4ZbTtkUsTL8SlDHdVGo9C20CJ51zfdlLFTHmBXEyF75NFCzIYRfC3Jh442iyIz23g0EoYb87/lrkyU/K612DFbGqpr/TdNEVVMHflZFbV5qC9H84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385204; c=relaxed/simple;
	bh=Kp1dv4vgO5RIbk2qt5RKDB95cqiwJkA4DlTfz1ooBJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVMt9e3VeoFmfw8vSET9wD7wa/wCFhjpoYUqwtgdrQU7Ce2g3GWgxnQqhCYFAaLRjzntx+LJ959yQH7ZvPCd7M7V2K6xJlkT+wzGERYvaFtOB9LbxXqlW63MnNmx44Zb5LNSDQph/PH3fTbY65zgGQTjiwtr6RXphw6JeE++trM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt66jE2v; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so697314a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710385201; x=1710990001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra9KWpescs2b4ic2C3bUzMKxFu2Uuh++R64Eac+e23s=;
        b=Dt66jE2vshbbF++0wVwCul2bZrQgNuMnq9zXlvB9ct1pHGkfF/xZyVKhQCzlqGJulc
         Wqeq312PvDaj2YhVeCjJDxTpXbg+yKADfLiOjHQsoLUNOaC1ORmUXSya9Ea24/TU9FMB
         N24GXuCPTeQV2svMBJBrE2VgjMEiD7ICG/4oD6GCfmV+KJU/yHGbtqz1oNEGBYPVk2pp
         Y/G8YVRhogTayf/omlycINaPUHqCLpXhjVCDJK76KIgKtPOjlWbiU3pwW1Ajdgdk3i0W
         zsRfC2+Co5sTN1CSrGhcdyAz6fblfzZIgOZkqhWe6uiiM9TnvHeQmZ+i2WdmtInj3jlP
         UWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710385201; x=1710990001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra9KWpescs2b4ic2C3bUzMKxFu2Uuh++R64Eac+e23s=;
        b=c/mBuvuWcbz/stUplehfeYwuGlYGUTYiNFaNSVb9wvfrphk9waQybI/w+WD4OK5hNN
         PNvwKxxT8mGQ2iPBRz8ISQzWygoFVY5MFLcl/HeXc5UEKw+NssdWT5OmEDxfIpuAM91a
         yMV1KeoEKOXoNeVA1g504Ga9hCMRrV02/6hf5J5lWQd2xgf0oTqWUmAWnBhwDnMH+FKb
         q2Gx3JkJBpufhdClG8zTAqP3xUXl92zGZtHZbC8qHX/jjypJCOyRuyEuH6pV5sbsI+AT
         yklZN9wn3ww0ymaVZc0+b33FeMFteD8fVD2jaMAHUrK5T0CUbAjATcsrIyqSgP6/w3cG
         GViQ==
X-Gm-Message-State: AOJu0YxZfbO4vu2nHiH5hVE3nIiy2WSvDMBIcCQiIfemgJDLG9OrMdJB
	VI7hN6aNWRLBaVRFpoBC/W2t21WdgvKw6sFKDnWA9GfSU2Zn1dO+/meu4c3+Nr6oIbAkeSBaung
	Jb5GraaBeNLZsZn6+IWJ54ZYC8yE=
X-Google-Smtp-Source: AGHT+IEFyc5sMzujAeUT+qcEiGWkGP3BTNTXtRfhAIFzSSKLh0l199BR9SYmkKezY1UR4JqrP/+XtEU/lDrRfPP/udc=
X-Received: by 2002:a05:6402:1599:b0:568:9d96:b2d1 with SMTP id
 ij25-20020a056402159900b005689d96b2d1mr173322edb.32.1710385200714; Wed, 13
 Mar 2024 20:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085817.48892-1-zegao@tencent.com> <d43ed111-085b-432b-ad5b-433d5031fad1@arm.com>
In-Reply-To: <d43ed111-085b-432b-ad5b-433d5031fad1@arm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 14 Mar 2024 10:59:49 +0800
Message-ID: <CAD8CoPAC0ti2=mAbP5GMN6ZidZnPV-Antf7KrjwPtEnE7gYOdg@mail.gmail.com>
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

On Wed, Mar 13, 2024 at 11:16=E2=80=AFPM Pierre Gondois <pierre.gondois@arm=
com> wrote:
>
> Hello Ze,
>
> I am running stress-ng with the following command:
>    stress-ng -c 1 -l 10 &
> and migrating the process with:
>    taskset -pc [cpus] [pid]
>
> The thread seems to be migrated via:
> sched_setaffinity
>    \-__sched_setaffinity()
>      \-__set_cpus_allowed_ptr()
>        \-__set_cpus_allowed_ptr_locked()
>          \- [1]



> [1]
> /*
>   * Picking a ~random cpu helps in cases where we are changing affinity
>   * for groups of tasks (ie. cpuset), so that load balancing is not
>   * immediately required to distribute the tasks within their new mask.
>   */
> dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
>
> So it seems the destination CPU chosen among the new CPU affinity mask is=
 done
> here, by picking a random CPU in the mask.

IIUC, this is for running/queued/waking tasks instead of blocked tasks.

Am I missing something obvious here?

> Checking the cpus_ptr in select_idle_sibling() might be useful in other c=
ases,
> but I think the experiment doesn't show that. Maybe a another small tweak=
 could

The experiment is used to illustrate that the status quo does not do well
but has to rely on select_fallback_rq() to choose a cpu for a woken task
which turns out to be a bad choice since it's already monopolized by a
cpu bound task, that is why a second migration happens with the help
of the load balancer.

Actually, we can reuse the same reasons for doing so as in

    commit 46a87b3851f0("sched/core: Distribute tasks within affinity masks=
")

> be done at [1] instead ?

As for blocked tasks, check out what is commented on set_task_cpu() and
select_task_rq(), since we never call set_task_cpu() on blocked tasks which
in turn, we have no way to change p->wake_cpu to dest_cpu being randomly
chosen here, so when it's woken up, it still needs to go through the
select_task_rq() process using the outdated p->wake_cpu.


Thanks,
        -- Ze

> Regards,
> Pierre
>
> On 3/13/24 09:58, Ze Gao wrote:
> > We observered select_idle_sibling() is likely to return the *target* cp=
u
> > early which is likely to be the previous cpu this task is running on ev=
en
> > when it's actually not within the affinity list newly set, from where a=
fter
> > we can only rely on select_fallback_rq() to choose one for us at its wi=
ll
> > (the first valid mostly for now).
> >
> > However, the one chosen by select_fallback_rq() is highly likely not a
> > good enough candidate, sometimes it has to rely on load balancer to kic=
k
> > in to place itself to a better cpu, which adds one or more unnecessary
> > migrations in no doubt. For example, this is what I get when I move tas=
k
> > 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> >
> >          swapper       0 [013]   959.791829: sched:sched_migrate_task: =
comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D13 dest_cpu=3D23
> > kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D23 dest_cpu=3D24
> >
> > The thing is we can actually do better if we do checks early and take m=
ore
> > advantages of the *target* in select_idle_sibling(). That is, we contin=
ue
> > the idle cpu selection if *target* fails the test of cpumask_test_cpu(
> > *target*, p->cpus_ptr). By doing so, we are likely to pick a good candi=
date,
> > especially when the newly allowed cpu set shares some cpu resources wit=
h
> > *target*.
> >
> > And with this change, we clearly see the improvement when I move task 3=
964
> > to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> >
> >          swapper       0 [027]  4249.204658: sched:sched_migrate_task: =
comm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D27 dest_cpu=3D26
> >
> > Note we do the same check for *prev* in select_idle_sibling() as well.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >   kernel/sched/fair.c | 13 ++++++++-----
> >   1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 533547e3c90a..9ef6e74c6b2a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7511,16 +7511,19 @@ static int select_idle_sibling(struct task_stru=
ct *p, int prev, int target)
> >        */
> >       lockdep_assert_irqs_disabled();
> >
> > -     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> > -         asym_fits_cpu(task_util, util_min, util_max, target))
> > +     if (cpumask_test_cpu(target, p->cpus_ptr) &&
> > +             (available_idle_cpu(target) || sched_idle_cpu(target)) &&
> > +             asym_fits_cpu(task_util, util_min, util_max, target))
> >               return target;
> >
> >       /*
> >        * If the previous CPU is cache affine and idle, don't be stupid:
> >        */
> > -     if (prev !=3D target && cpus_share_cache(prev, target) &&
> > -         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > -         asym_fits_cpu(task_util, util_min, util_max, prev)) {
> > +     if (cpumask_test_cpu(prev, p->cpus_ptr) &&
> > +             prev !=3D target &&
> > +             cpus_share_cache(prev, target) &&
> > +             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> > +             asym_fits_cpu(task_util, util_min, util_max, prev)) {
> >
> >               if (!static_branch_unlikely(&sched_cluster_active) ||
> >                   cpus_share_resources(prev, target))

