Return-Path: <linux-kernel+bounces-82279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B798681B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05F61C281ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC382130AFD;
	Mon, 26 Feb 2024 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tgxNnE5"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537351292FF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978077; cv=none; b=Nc0Qpp5ECj/+Tk2pqG3wEajSNC3JP+H2YsPokHrXljuLxYqZmNEoXwFCdPFFWeJ9Fb/nIJwfvKKpjbTgGfJQzzOnUOO3bMs5WCwwkb+BXuQH/SOoSwp/MHZErXJ5rM3+XMXlFP7CqU6hYRbPnqhaKKIUklBkHBGQXaLmKsmyMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978077; c=relaxed/simple;
	bh=NVjOwIixqtmKk42qqbgIIFPhIDYUsnr18xUDWVMWGnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs7F9d364P7r+aQqn3eEioIdp2fT0Bst3T2TusDbYSF8pHaC+dZvf23jARodTMTgkjgM7Zj4crV8aaDCMEfHe8GOeJyBCkkJHcAoWGKsdP9PT2CUGeoEwBfbqOoI92/9wdmnHh5qXW+QftbCbyW8+5L1L3aB+q3auCaRAqs8U30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tgxNnE5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so40304311fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708978073; x=1709582873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkR0JcijP1mDKZ3OKDiK4IA6xGHF30OgHD69+JdTurY=;
        b=4tgxNnE51uxGK7Ms/Q/vqcxuCSZCvFoLTi0voN/YWLIPJeKcXx1q7G5obJ7CPN5sRN
         QWalbSFU1wBP+kZmoIFuY09naznbOzCJRAVdsmUK73MQCv9+0NZWVUYRj+nuVBdnXte0
         lMGTXYDyQ58G60QaKJfrQ0Tv/YeCe+KLu1DDEgYLx2NCwWy4Ae4a41VAKXQX+h4EUcsc
         X1FnNzlu0vmv8u/6Hd4oYxOF6oUZ1YZHYPIZCDtlWNwz7U41Z3g5XuuoTVGAgpArzpv9
         CPxzJhQgC2QQ84N2+gQjAtaeH9xf2yG4hconSKuMEuQ9wuVj+6rwKfkFuZsfZIEtk1Sl
         YphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708978073; x=1709582873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkR0JcijP1mDKZ3OKDiK4IA6xGHF30OgHD69+JdTurY=;
        b=omB/Kaz3qS7yHYbERPqlQK4A5/EAzNOM+tILso9oRW7/R9/i0zaxXaXe1TDJhUT+o5
         98sKtph7tHeJAU0zkVcUSZdKtgHb/Lbkwiu0XiGuSiOVxpTvbekGtRhO/3GKmdiOCcTs
         z68quGA3KLRXwlR3dKJuU4yt31w9f9vNTYBv7qPyGv1WyiwY/oufhPfEKwNNamNh6MX7
         gUzPG1Txjf6CnMhRpay3qNKxFOJ7R/+Htn+eQrKs/A0gmUUNZcKx/DRx2EBp1IQUfgDQ
         2ahXwReXWIZtmjM4xJv8w1tm2k0cL/56FdSKKVqKKMUveBHDugXbsmFx2FUSt/hMB4FL
         mdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVTqJ2buNktRHVMZg6Mk7ByKMqnBxIeW000RCSNpwTOmXZuVq+2mCE4iKZMHHEJTePQY7pCzF+YdTkO8IjCvItK2REnRexi45NaVlp
X-Gm-Message-State: AOJu0Yx95MvEq1s6KUbSqfsM9XzKu0vJ2K0Ncp+8Jd0vtiY/BXN7VJvM
	GZcmg8LXL2fmxwd2pl75mdjAQewdZOSgv+QKL7gOFjp1YBjL7fF9ib0B0JAmjaZCvxY51gVF2DV
	G8+SXHLXbE2ITtzydUBOUiwmJ2j0+rcVhxb17
X-Google-Smtp-Source: AGHT+IFi1HAIVoBbDMEY52awEexfjO2i1Ye2tSZXICavfLndsuE7TCeNZAGUxhPc8dC8U389hE6TVUn1kAqYwOWRR18=
X-Received: by 2002:a05:651c:2128:b0:2d2:3fac:5fdc with SMTP id
 a40-20020a05651c212800b002d23fac5fdcmr5982350ljq.10.1708978073188; Mon, 26
 Feb 2024 12:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226194642.47530-1-ppbuk5246@gmail.com>
In-Reply-To: <20240226194642.47530-1-ppbuk5246@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 26 Feb 2024 12:07:41 -0800
Message-ID: <CAJuCfpGgvxmjbiFVUE-ETXop1D329YRoyCZba9gzYDk0tmJJFw@mail.gmail.com>
Subject: Re: [PATCH] psi: Fix avg trigger being fired unexpectedly.
To: Levi Yun <ppbuk5246@gmail.com>
Cc: hannes@cmpxchg.org, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:46=E2=80=AFAM Levi Yun <ppbuk5246@gmail.com> wro=
te:
>
> commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at initia=
l")
> fixes unexpected event fired when group->total accumlated for PSI_POLL.

s/accumlated/accumulated

> But, for PSI_AVGS, win->value should be initialized with group->total[PSI=
_AVGS].
> Moreover, to get exact initial value for win->value, it should be set
> under each trigger lock to synchronize each rtpoll/avgs_works.

That last "to synchronize each rtpoll/avgs_works." part I would
replace with "to avoid concurrent changes to group->total[]."

Other than these nits LGTM. After fixing them feel free to add:

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  kernel/sched/psi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7b4aa5809c0f..e7f66ab2ad3e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1323,9 +1323,6 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group, char *buf,
>         t->state =3D state;
>         t->threshold =3D threshold_us * NSEC_PER_USEC;
>         t->win.size =3D window_us * NSEC_PER_USEC;
> -       window_reset(&t->win, sched_clock(),
> -                       group->total[PSI_POLL][t->state], 0);
> -
>         t->event =3D 0;
>         t->last_event_time =3D 0;
>         t->of =3D of;
> @@ -1336,6 +1333,8 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group, char *buf,
>
>         if (privileged) {
>                 mutex_lock(&group->rtpoll_trigger_lock);
> +               window_reset(&t->win, sched_clock(),
> +                               group->total[PSI_POLL][t->state], 0);
>
>                 if (!rcu_access_pointer(group->rtpoll_task)) {
>                         struct task_struct *task;
> @@ -1361,6 +1360,9 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group, char *buf,
>         } else {
>                 mutex_lock(&group->avgs_lock);
>
> +               window_reset(&t->win, sched_clock(),
> +                               group->total[PSI_AVGS][t->state], 0);
> +
>                 list_add(&t->node, &group->avg_triggers);
>                 group->avg_nr_triggers[t->state]++;
>
> --
> 2.39.2

