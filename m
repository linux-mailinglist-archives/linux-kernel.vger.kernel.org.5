Return-Path: <linux-kernel+bounces-119640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F004088CB73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38990B23239
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977853803;
	Tue, 26 Mar 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOh31o5D"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6E1C2AF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476084; cv=none; b=Epa6BImQTi4FafrfCnsUFqlGbPjznJfyROH6phQDT60Csu7mXRQHWJIXeDLqmtaRSA7qx2pZTO9geMFYzyVJwJGxguoa8efIQeYt2H9rRWIkeSs8A7yJgy3szMkHXd2vzf4JSrtEoqgSkzmFmE+3wAOSCgs96HKuHtMvSJik4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476084; c=relaxed/simple;
	bh=6clewCtNwrXAGDiENW7darKyKjOLpnki5JqhBB84ve0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvTzf6TK1cbRz0LmiHljDNnDnIsTsmdaYU6pUmPWzYZXBUk0im6nn7wsHWZmk793Sdzj+Cbt6NR+fOYQM3O6q16jzko2qyBUqnEvpiYy8peUgvCcr0YWtWjo8Ik+Dq/Ns4zKZbz4iZm+zyFNlO4Sb0kNiF4bZGE/9oAFJQzDQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOh31o5D; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609fc742044so62292947b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711476081; x=1712080881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XObRnJOe5x5g/XgoRchvbLOOBTbF4Ayrr8n6yojYLIc=;
        b=HOh31o5DGE0WdQzexF7jwioU7AzfFzn5mwX6RY7F4bfa681QW1yMRfAnJt+7wJvRjd
         J+mazABNuU4tczEH6cUdq0tutF1x5hH5ayiqXDsTMGv+v3K/t3SKl30ATDXsOfN/pJE9
         ZXMnR/HS6w/Pp7Weq68zydE1bV2iGJ/lrp6j7Wfb4t6fhs2ps/W59eKUp/eR8S6kc1a6
         seS1rSzQYNKCEB65DCZaWdTFVky8KsWvVDZ2hpgl+JTSb1EI2umNO6jL0vE/57c7HYpg
         JbSfk8XyTKdi64jW+KVYTmJysnkaFg7IMeJERBDraY84nQmEMkqAhy3T9ncZ+u/VXtWw
         4vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476081; x=1712080881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XObRnJOe5x5g/XgoRchvbLOOBTbF4Ayrr8n6yojYLIc=;
        b=vDZralUwha3of0OwVcfc3yCNIs/1kvWpBZnLlVFRJuakXU+icrFjsmsJMRn/I58nk/
         1kk2tXIoF9OJ73pZ9uyBh8S1esSMK+5tq2R+V+i2VWa8mYmMSKN36mZXgiJcMtueJP74
         0xgtUSN+FLa4UAR0Z5tiFjm1LAM6DI9oTzPz3AehspKxuH3ynUZDTVxGFG/7kGOBlMEW
         W/7JnY/hLM3LmUFy0Xs6XCUcqRG+WEjZLUcFTAMj0gWzO85cXPBiqxEARRnetlARJePC
         OgqQjdf7J219Q8ipkaV7ORQFpoNxzQj6HltDj7WkozMViwnO4g183s9uRkrt3XYoDrw7
         6+ww==
X-Forwarded-Encrypted: i=1; AJvYcCWS1SnWxhv5kOum/ZsbfJJ9Bh7nJUF6Q70qJSKJiRcWcRaOIcutNsi7ADJGFYwKzlUXBVh6I6Ghg1qiAYEHfvoSARYf0iU+aaeKMJX6
X-Gm-Message-State: AOJu0Yw0SkK3NyRyjSzSX6GGZ7IsiowxzYvZ191PVo0WSb9sbml9eJlq
	tQdy0M0lenl3+4QPN+I2NNVFOibhA8EsJz6bHhN6Ykke6alzLRAnUeAE1O9dzwj3jI3JOtNwgy9
	jVMr1tzjPxzR73WpmP+B49z/eMLEfQ70IpbiI
X-Google-Smtp-Source: AGHT+IGCseJIoMjDVzKMGoo7nvvK3wtQHbbHa017mImqV17QHRR7XHngt3I0u1VScWdNaaK+p7nFJk+L1dPVdJtbjgA=
X-Received: by 2002:a25:c706:0:b0:dd1:7908:3a49 with SMTP id
 w6-20020a25c706000000b00dd179083a49mr418843ybe.23.1711476081106; Tue, 26 Mar
 2024 11:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226211237.48415-1-ppbuk5246@gmail.com> <Ze_x3kovSFe4z9SO@Levi-MacBook-Pro.local>
 <CAJuCfpFdbh37qWFS8eCXk0CCQD9bA2wtpOj5BMYPNTcz-0Oxnw@mail.gmail.com>
In-Reply-To: <CAJuCfpFdbh37qWFS8eCXk0CCQD9bA2wtpOj5BMYPNTcz-0Oxnw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Mar 2024 11:01:07 -0700
Message-ID: <CAJuCfpGwnn3zuHc=iSZN60hactO+4NAiyGR51y_7X4wfS7x6tA@mail.gmail.com>
Subject: Re: [PATCH v2] psi: Fix avg trigger being fired unexpectedly.
To: peterz@infradead.org
Cc: hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, "levi.yun" <ppbuk5246@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:49=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Mar 12, 2024 at 6:10=E2=80=AFAM levi.yun <ppbuk5246@gmail.com> wr=
ote:
> >
> > Gentle ping..
> >
> > On Mon, Feb 26, 2024 at 09:12:37PM +0000, Levi Yun wrote:
> > > commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at in=
itial")
> > > fixes unexpected event fired when group->total accumulated for PSI_PO=
LL.
> > > But, for PSI_AVGS, win->value should be initialized with group->total=
[PSI_AVGS].
> > > Moreover, to get exact initial value for win->value, it should be set
> > > under each trigger lock to avoid concurrent changes to group->total[]=
.
> > >
> > > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > > Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> Hi Peter,
> Could you please pull this patch into your tree? I don't see it in any
> tree, so I think you missed it.

Forgot to set the right recipient. Fixed now.


> Thanks,
> Suren.
>
> > > ---
> > > v2: Fix commit message.
> > > ---
> > >  kernel/sched/psi.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 7b4aa5809c0f..e7f66ab2ad3e 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -1323,9 +1323,6 @@ struct psi_trigger *psi_trigger_create(struct p=
si_group *group, char *buf,
> > >       t->state =3D state;
> > >       t->threshold =3D threshold_us * NSEC_PER_USEC;
> > >       t->win.size =3D window_us * NSEC_PER_USEC;
> > > -     window_reset(&t->win, sched_clock(),
> > > -                     group->total[PSI_POLL][t->state], 0);
> > > -
> > >       t->event =3D 0;
> > >       t->last_event_time =3D 0;
> > >       t->of =3D of;
> > > @@ -1336,6 +1333,8 @@ struct psi_trigger *psi_trigger_create(struct p=
si_group *group, char *buf,
> > >
> > >       if (privileged) {
> > >               mutex_lock(&group->rtpoll_trigger_lock);
> > > +             window_reset(&t->win, sched_clock(),
> > > +                             group->total[PSI_POLL][t->state], 0);
> > >
> > >               if (!rcu_access_pointer(group->rtpoll_task)) {
> > >                       struct task_struct *task;
> > > @@ -1361,6 +1360,9 @@ struct psi_trigger *psi_trigger_create(struct p=
si_group *group, char *buf,
> > >       } else {
> > >               mutex_lock(&group->avgs_lock);
> > >
> > > +             window_reset(&t->win, sched_clock(),
> > > +                             group->total[PSI_AVGS][t->state], 0);
> > > +
> > >               list_add(&t->node, &group->avg_triggers);
> > >               group->avg_nr_triggers[t->state]++;
> > >
> > > --
> > > 2.39.2

