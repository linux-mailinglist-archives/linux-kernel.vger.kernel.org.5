Return-Path: <linux-kernel+bounces-52080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1FD8493EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5374B28435E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2410A0F;
	Mon,  5 Feb 2024 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0vAdcnZ"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109710A01
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115008; cv=none; b=qGwdj3yJ3ZvNqToOPrwbQZKyCDBMjmOBKZ62K0nWiDktyDFKmpRiOCdHS2h8f2tzgoPdvycxwe9KwALUuf1UQV+of4txE8YjDloOHDBjtOn/VcGxxL8+5R/ZxrtlWGlJW1e2PHsgrfg/rjXj/dwZpWRLRCx16JocsWb6PKG0I/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115008; c=relaxed/simple;
	bh=/W+krNww/HnVLpqcomfJAfbmor0kQhACM5ZnnExA0/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVDnsaAP7dxAy9uIQArLR1pMZ1MmBbCQs1EjEwDe/pXKGsSfI/zGD0Jz/nAoHFo/QSFlsXkuo2viy9uBbCOwMFQKOyqi8qEYyM1spmJkzqoLNhHyfPXTEw5EHb0l/Zw1z9MUzGsXQt0or/7riAVvcdmEN1JIhuWN+5reTKMQSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0vAdcnZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-20536d5c5c7so3163731fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 22:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707115006; x=1707719806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16pnWgAL8zWtC/Tt+AS2AkFO9F9ksyPsxw/1mwJCpRg=;
        b=O0vAdcnZauInpmo5E0ort1J746hXKcTaa9qFkNNSvCL8JimTAlg8gKd42YYy8DcGW5
         lTZgoAi/LsnuphsR+Algqnx3HrnfkeSwqgCLfIh+1n4D7qo8My1NWB+qq2xM//3YxGml
         xZ72HNONnkmk8l3+iFMsnOP9qtPcmgyX/xaMNaTgNbdW11Oq9Q2yW/8a2mKl2Tpc+C2G
         oCrixciWtsmRoKPeGLYYoXBhuFzfraddTK89+CSHHQkf/TvwGJ2HKQM+6zZzL5UmGhDv
         EbE+3d58dVfMwhl1MIkguoVzZdxNk7+GVSnShCUOjfLAhDViozrrTgn6Bl8RkoBUJGKv
         h73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707115006; x=1707719806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16pnWgAL8zWtC/Tt+AS2AkFO9F9ksyPsxw/1mwJCpRg=;
        b=Q8If/UWH7jGzp1c0njQvLok3GQgsTGMcoKa4sER9ZaHxX8DZq1XuwzIU6S4SpSQqpG
         apn8Un2k5gt3Nv2Zg20yx/4VaMmh7gyv0nCwFO6eF/Ok8Wo6Oxfo1KTVVqq54qFvfqsX
         jt1FBch0Btvk+jTyXarnoSvpwky2lu9FeBI2MjxhE5sNKCzA7amBbellw7ui6Q379ylr
         XQaTv2b9sZHvLcXs8e9HU9d0szE8wyLAi0hzR9df1Ff1LCxWA/uBn+b1p89lpUuEYkAu
         7wgMHvKZH5v9h2H4dogUVrFB4uEvoOcWD+zaYwWw0OhLL1Q6KQ1HyYN5shtNfU/Pr7Y+
         dHOw==
X-Gm-Message-State: AOJu0YyMVtgdl/3Ba9SDzSHmlrI/jg1Dp+35/wByvJkzZpsY28qMyAkL
	+cvs8LZcR55cHKLXQAAF+urLuAVaaw/Msj8Y4tyFAniJffZKUeDKsvk+jGY8Co8JRqopUt+VfJz
	e6c2aibdjRcKz8A3VRtc0QNsSXV0=
X-Google-Smtp-Source: AGHT+IG7zZk43iAh6rGlyL5LSNKf7pIl2C/JE8q8fdtwPDxoyPVYk4u39kujILeiP+BCRVTSHGmpeQq5gN1039MPup0=
X-Received: by 2002:a05:6870:808d:b0:219:671d:74da with SMTP id
 q13-20020a056870808d00b00219671d74damr4268049oab.29.1707115006216; Sun, 04
 Feb 2024 22:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130080643.1828-1-xuewen.yan@unisoc.com>
In-Reply-To: <20240130080643.1828-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 5 Feb 2024 14:36:35 +0800
Message-ID: <CAB8ipk-Z=CkvbVczCpmCgmymKqWQfuKNF7xm51s_03obAen_Ew@mail.gmail.com>
Subject: Re: [PATCH] sched/eevdf: Prevent vlag from exceeding the limit value
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	wuyun.abel@bytedance.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, Jan 30, 2024 at 4:07=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> There are some scenarios here that will cause vlag to
> exceed eevdf's limit.
>
> 1. In set_next_entity, it will stash a copy of deadline
> at the point of pick in vlag, and if the task fork child,
> the child's vlag would inherit parent's vlag, as a result,
> the child's vlag is equal to the deadline. And then,
> when place_entity, because the se's vlag is wrong, it would
> cause vruntime and deadline update error.

Could anyone make some comments?

In my opinion, even if it may be ignored when reweighting, it is
better to solve the problem when forking.
Maybe we could change some settings in set_next_entity() where vlag is
equal to deadline?


Thanks!
--
BR
xuewen

>
> 2. When reweight_entity, the vlag would be recalculated,
> because the new weights are uncertain, and it may cause
> the vlag to exceed eevdf's limit.
>
> In order to ensure that vlag does not exceed the limit,
> separate the calculation of limit from the update_entity_lag
> and create a new func limit_entity_lag. When the vlag is
> updated, use this func to prevent vlag from exceeding the limit.
>
> And add check whether the se is forked in place_entity, and calc
> the curr's vlag to update the se's vlag.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..3fc99b4b8b41 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -696,15 +696,22 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   *
>   * XXX could add max_slice to the augmented data to track this.
>   */
> +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> +{
> +       s64 limit;
> +
> +       limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> +       return clamp(lag, -limit, limit);
> +}
> +
>  static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity=
 *se)
>  {
> -       s64 lag, limit;
> +       s64 lag;
>
>         SCHED_WARN_ON(!se->on_rq);
>         lag =3D avg_vruntime(cfs_rq) - se->vruntime;
>
> -       limit =3D calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se)=
;
> -       se->vlag =3D clamp(lag, -limit, limit);
> +       se->vlag =3D limit_entity_lag(se, lag);
>  }
>
>  /*
> @@ -3757,6 +3764,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, s=
truct sched_entity *se,
>         if (avruntime !=3D se->vruntime) {
>                 vlag =3D (s64)(avruntime - se->vruntime);
>                 vlag =3D div_s64(vlag * old_weight, weight);
> +               vlag =3D limit_entity_lag(se, vlag);
>                 se->vruntime =3D avruntime - vlag;
>         }
>
> @@ -3804,6 +3812,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, =
struct sched_entity *se,
>
>         update_load_set(&se->load, weight);
>
> +       if (!se->on_rq)
> +               se-vlag =3D limit_entity_lag(se, se->vlag);
> +
>  #ifdef CONFIG_SMP
>         do {
>                 u32 divider =3D get_pelt_divider(&se->avg);
> @@ -5177,6 +5188,16 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_e=
ntity *se, int flags)
>
>                 lag =3D se->vlag;
>
> +               /* When fork, the child would inherit parent's vlag,
> +                * but parent's vlag may be euqual to it's deadline.
> +                */
> +               if (flag & ENQUEUE_INITIAL) {
> +                       if (curr)
> +                               lag =3D vruntime - curr->vruntime;
> +
> +                       lag =3D limit_entity_lag(se, lag);
> +                       se->vlag =3D lag;
> +               }
>                 /*
>                  * If we want to place a task and preserve lag, we have t=
o
>                  * consider the effect of the new entity on the weighted
> @@ -5237,6 +5258,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int flags)
>                 if (WARN_ON_ONCE(!load))
>                         load =3D 1;
>                 lag =3D div_s64(lag, load);
> +               lag =3D limit_entity_lag(se, lag);
>         }
>
>         se->vruntime =3D vruntime - lag;
> --
> 2.25.1
>

