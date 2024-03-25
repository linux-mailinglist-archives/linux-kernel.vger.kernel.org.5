Return-Path: <linux-kernel+bounces-117343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E6488AA34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFE53417D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F910940;
	Mon, 25 Mar 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="altNUj2G"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB97101D5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379612; cv=none; b=rS8AX5RZc8u8nmPq4aTBJ1TKYoQlbCPAdvE3lV9Chwu3xDclK992wcawPju1j0ewoKk9f2xTnaCRoiarwrklAqhNvMzpReH5KAKIO51v9EYTmR4DYwlKngffBHzSnaQzoAk171Ke9d0cITsHvir1yqOf/2DawQfxwkdjPJxC+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379612; c=relaxed/simple;
	bh=whrQ/+Q1VKJca5FoygVAdZRtlfTWRu/Li+1im2l7Xic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+wNrUvzkRgL0K09qfpTb13JdO/F8I9AVYBTJ/cNZZ5mKjGSloPUDaubdyVtnlXfd6sXDf/5ak7W4WFAAeHsB7aFZsZj6Yt/gjouE8EaDz9giHOV68ugr8FYqFbrzlqdTpHvtcqEB3wXT98YP6lvXG8B7oBlOU7eHObLwIIZau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=altNUj2G; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5159e6d31a3so828502e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711379608; x=1711984408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8oFnhBBS5k79iRlRa9upKOCXpBz4y2m1TT8qoJJhkI=;
        b=altNUj2GDjQ1G6wrKvdSwSJ1llG9O79tJ5ejeec+Yrpanhb7au0Te8mHGhekD2jFA1
         9+zirgZKGtzBKqKKwIOjS7GMQZA4fnmGqvRY/7AaBqTEFvDSpgtoYtc7254gO0hU409k
         UkZj07LMVo5biZTrNUTAnublMV9942UNts/Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379608; x=1711984408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8oFnhBBS5k79iRlRa9upKOCXpBz4y2m1TT8qoJJhkI=;
        b=lnI+IkPJegac1a/MrUzKn5iaK0o/Rc9FYb5Zwndy1NFhA4r9ZhRF5PGs1Ljhyge4ns
         n3i/tp/PYECw4xkSGxXWlPdSgZbxRe52nXQdbY8U6nh555TOevankePHtpgzwShr9ADs
         KSmTIDB2mFlpKAQIvWJhyzNgfNStd90wiw/7DUprWtJo+eRHo2jUtjH2WIACRvum14eQ
         YAvkGqolSrve3DD7/lIk2zpL48WxjKJM+FQLJ049sbe1Mgo98XeCGIvlKz1umv5A9CVP
         aGRVPi+RzuLi2F+k4hO+X14u+XF8tf8ZQpoxTQbCa+eGL6sX0AuPzm032XHhCamkMHVz
         if+g==
X-Forwarded-Encrypted: i=1; AJvYcCVw6czFBD8ewwndbrf7sUyb4wwrTgcjZu55HntHnxpKsPF09XfOI9zP1WB261xL1SgfnBEWYVCb0jvtv+1HuShZ1j4SzsETBRP2ZWjZ
X-Gm-Message-State: AOJu0YwgbZQg7UJfX3RTJmtokvSM6HPvtC0GrwPe79qO2JSxd95CX+JG
	BYeekXqaJ1SzUQaYXiV18htsAVpUxa5IpgeYKCmU8Tkuu973IjYqXhHTnKFO0e8oPybHNaVOBL3
	33N+lsujDvM3Tf42NPwrlSdj/NSKUjGJbNuVj
X-Google-Smtp-Source: AGHT+IEnmZ7vsZbg6bRiVj6HFBUQkihskkzinMGN75FgHhuvf65kIyVA9RjuMYvcmMWxDdtNpP5xPKEq4+Yrs76cHSk=
X-Received: by 2002:a19:2d15:0:b0:513:d0dd:95ef with SMTP id
 k21-20020a192d15000000b00513d0dd95efmr4248346lfj.5.1711379608221; Mon, 25 Mar
 2024 08:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325060226.1540-1-kprateek.nayak@amd.com> <20240325060226.1540-2-kprateek.nayak@amd.com>
In-Reply-To: <20240325060226.1540-2-kprateek.nayak@amd.com>
From: Youssef Esmat <youssefesmat@chromium.org>
Date: Mon, 25 Mar 2024 10:13:17 -0500
Message-ID: <CA+q576OCK24VSp+s4OLD2ogO48i95y39_JO=zV=TwHSEg3_b1w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/eevdf: Skip eligibility check for current
 entity during wakeup preemption
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Tobias Huschle <huschle@linux.ibm.com>, Luis Machado <luis.machado@arm.com>, 
	Chen Yu <yu.c.chen@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 1:03=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd=
com> wrote:
>
> With the curr entity's eligibility check, a wakeup preemption is very
> likely when an entity with positive lag joins the runqueue pushing the
> avg_vruntime of the runqueue backwards, making the vruntime of the
> current entity ineligible. This leads to aggressive wakeup preemption
> which was previously guarded by wakeup_granularity_ns in legacy CFS.
> Below figure depicts one such aggressive preemption scenario with EEVDF
> in DeathStarBench [1]:
>
>                                 deadline for Nginx
>                    |
>         +-------+  |                    |
>     /-- | Nginx | -|------------------> |
>     |   +-------+  |                    |
>     |              |
>     |   -----------|-------------------------------> vruntime timeline
>     |              \--> rq->avg_vruntime
>     |
>     |   wakes service on the same runqueue since system is busy
>     |
>     |   +---------+|
>     \-->| Service || (service has +ve lag pushes avg_vruntime backwards)
>         +---------+|
>           |        |
>    wakeup |     +--|-----+                       |
>  preempts \---->| N|ginx | --------------------> | {deadline for Nginx}
>                 +--|-----+                       |
>            (Nginx ineligible)
>         -----------|-------------------------------> vruntime timeline
>                    \--> rq->avg_vruntime
>
> When NGINX server is involuntarily switched out, it cannot accept any
> incoming request, leading to longer turn around time for the clients and
> thus loss in DeathStarBench throughput.
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     Test          : DeathStarBench
>     Units         : Normalized latency
>     Interpretation: Lower is better
>     Statistic     : Mean
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     tip         1.00
>     eevdf       1.14 (+14.61%)
>
> For current running task, skip eligibility check in pick_eevdf() if it
> has not exhausted the slice promised to it during selection despite the
> situation having changed since. The behavior is guarded by
> RUN_TO_PARITY_WAKEUP sched_feat to simplify testing. With
> RUN_TO_PARITY_WAKEUP enabled, performance loss seen with DeathStarBench
> since the merge of EEVDF disappears. Following are the results from
> testing on a Dual Socket 3rd Generation EPYC server (2 x 64C/128T):
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     Test          : DeathStarBench
>     Units         : Normalized throughput
>     Interpretation: Higher is better
>     Statistic     : Mean
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     Pinning      scaling     tip            run-to-parity-wakeup(pct imp)
>      1CCD           1       1.00            1.16 (%diff: 16%)
>      2CCD           2       1.00            1.03 (%diff: 3%)
>      4CCD           4       1.00            1.12 (%diff: 12%)
>      8CCD           8       1.00            1.05 (%diff: 6%)
>
> With spec_rstack_overflow=3Doff, the DeathStarBench performance with the
> proposed solution is same as the performance on v6.5 release before
> EEVDF was merged.

Thanks for sharing this Prateek.
We actually noticed we could also gain performance by disabling
eligibility checks (but disable it on all paths).
The following are a few threads we had on the topic:

Discussion around eligibility:
https://lore.kernel.org/lkml/CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310=
hvRbw@mail.gmail.com/
Some of our results:
https://lore.kernel.org/lkml/CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfO=
Xtq7Q@mail.gmail.com/
Sched feature to disable eligibility:
https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium=
org/

>
> This may lead to newly waking task waiting longer for its turn on the
> CPU, however, testing on the same system did not reveal any consistent
> regressions with the standard benchmarks.
>
> Link: https://github.com/delimitrou/DeathStarBench/ [1]
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/fair.c     | 24 ++++++++++++++++++++----
>  kernel/sched/features.h |  1 +
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..a9b145a4eab0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -875,7 +875,7 @@ struct sched_entity *__pick_first_entity(struct cfs_r=
q *cfs_rq)
>   *
>   * Which allows tree pruning through eligibility.
>   */
> -static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, bool wakeu=
p_preempt)
>  {
>         struct rb_node *node =3D cfs_rq->tasks_timeline.rb_root.rb_node;
>         struct sched_entity *se =3D __pick_first_entity(cfs_rq);
> @@ -889,7 +889,23 @@ static struct sched_entity *pick_eevdf(struct cfs_rq=
 *cfs_rq)
>         if (cfs_rq->nr_running =3D=3D 1)
>                 return curr && curr->on_rq ? curr : se;
>
> -       if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> +       if (curr && !curr->on_rq)
> +               curr =3D NULL;
> +
> +       /*
> +        * When an entity with positive lag wakes up, it pushes the
> +        * avg_vruntime of the runqueue backwards. This may causes the
> +        * current entity to be ineligible soon into its run leading to
> +        * wakeup preemption.
> +        *
> +        * To prevent such aggressive preemption of the current running
> +        * entity during task wakeups, skip the eligibility check if the
> +        * slice promised to the entity since its selection has not yet
> +        * elapsed.
> +        */
> +       if (curr &&
> +           !(sched_feat(RUN_TO_PARITY_WAKEUP) && wakeup_preempt && curr-=
>vlag =3D=3D curr->deadline) &&
> +           !entity_eligible(cfs_rq, curr))
>                 curr =3D NULL;
>
>         /*
> @@ -5460,7 +5476,7 @@ pick_next_entity(struct cfs_rq *cfs_rq)
>             cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
>                 return cfs_rq->next;
>
> -       return pick_eevdf(cfs_rq);
> +       return pick_eevdf(cfs_rq, false);
>  }
>
>  static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
> @@ -8340,7 +8356,7 @@ static void check_preempt_wakeup_fair(struct rq *rq=
, struct task_struct *p, int
>         /*
>          * XXX pick_eevdf(cfs_rq) !=3D se ?
>          */
> -       if (pick_eevdf(cfs_rq) =3D=3D pse)
> +       if (pick_eevdf(cfs_rq, true) =3D=3D pse)
>                 goto preempt;
>
>         return;
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 143f55df890b..027bab5b4031 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -7,6 +7,7 @@
>  SCHED_FEAT(PLACE_LAG, true)
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
>  SCHED_FEAT(RUN_TO_PARITY, true)
> +SCHED_FEAT(RUN_TO_PARITY_WAKEUP, true)
>
>  /*
>   * Prefer to schedule the task we woke last (assuming it failed
> --
> 2.34.1
>

