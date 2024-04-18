Return-Path: <linux-kernel+bounces-150556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACA48AA0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73BC281C39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB8171E77;
	Thu, 18 Apr 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftmCCZ+i"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0911CA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460537; cv=none; b=Qk2SYne5fvq/tYQZyPLCqQvEbJ5ICnQvnuXWwnnQH2B/x7XMFpz14y3AtV3EIxGL25M5QKFNx8XsjygvfFy8cvwvCsafG5/c6R0n+6PXqdWwKMu9r1MKldJcEUkaawQqXYp2cFNBtZKW8Bu4okExAq3CfE6TTLi0CPMK8pmopSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460537; c=relaxed/simple;
	bh=JTXMwFeW01OOs8LHe2+n/J0SrYeNHEbZD8y9gLOPC4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8vuCGO0GL8sav2W7tlTRcBD0A3oJ9XR6DGvZQ6Q7MkzvuL1i6opkuH6USwW+GxjXiuVplAFWUNp9LlqHxdIAKfmI/jg69W8dS/uir/FHlv/HtW3Xw98liabxE0aK1Hx1w3cuKcwOT2RPXVCG9NC2dgt9x2UtYcVxAUXv3RLa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ftmCCZ+i; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de4640ec49fso1184804276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713460534; x=1714065334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6pJ+RQ7vG5rhlYvkzygwnEoE0kpj8juw3ibwvL2Tm4=;
        b=ftmCCZ+iDF1+RFd7vBH7JGT7ztvkpVluxseaybxrmfN/DBKbUvKlLepTWp4uUt9aDd
         KtYoNcNB6O8di5rSgxp/VrZATpe+UdmsgvJQwp/lS5P6Z2OXXtG7keg4aSx3En5kRxOZ
         /t1dR7BJQKBdA525wQDtEFhIEfzjxAk6z8/gAWV2d5Gy6PNXw0w0kNjBL3cN4Z6P0e/j
         e/+gXQ8ivoJt0YIjePvGZ4XiJjxdt6FSIIgYe/aOx+YKl5sFFs20Ftu2yPfL+ZBIO3jn
         FTJPQCoROJs0/vM2OkTts//j6bnn4qd/kDuSYfnTEbR29aCVKilpFvvsSIOebbbpoRvT
         r/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460534; x=1714065334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6pJ+RQ7vG5rhlYvkzygwnEoE0kpj8juw3ibwvL2Tm4=;
        b=iGePioI5f0n/1P45/cZh/tSqs+ZgySicQCrQ+EEfRwMNWyXveQMV/1UmbMGmG4oQPS
         +RIW8aHApsPcF+RXbo9++06WOnxvpen4reTC2cNbKuaNazLWRdliHhUR+D3hicgtO9y3
         QUaW+t48fvhK5nJ3gUGH4oH6MEwGQcObbSRSt3nkI7PwAhx3fG7XdDCE5+vrNKHHFnU4
         qnN6OHhUcsEGm+VZZds3XU2HHNgVuWwjkUX7qL6+Av3PMrhxIHVNsR2gWiv5IYRLn5EI
         6UgcvPNrwxI09Y0RU9z5xHybtGcb3ESOEu9MT6WEgDJchggdR2KX/wL7qeAX3NpVnTVO
         jdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/tzSk8DvOlETOjfUr57JH7nNcH85fck3qVceVdSvyMVbHacdD0gkXTzp4FtP436rUpXYG/g+HrbMijBLmRMpXmv8NHcfCMAGJzAp7
X-Gm-Message-State: AOJu0YwTC33Ao5qKgbOlJZsNHcp4WarkrIPvxHDUUAj9vXG4mZvjrtPq
	Gd4WSxZJgEWYZTGvIupTNbBbTzRjQaMqhk1qwyJlp55mZYpRx9VAYXA3XNEHv5TzZQXHDgSfxjy
	3j5IxOz6j8K4QvqJa2y6kbzJoNl4U0UqbenZ/
X-Google-Smtp-Source: AGHT+IHlWUMGIipX1LvxC1GyJuJB6xEEYMf+INZVeKfznaGw3fXHiTNz9amxChHh+gOw4Jb393ic8L8iw67AkFfwlKs=
X-Received: by 2002:a25:55:0:b0:dcc:6d85:586a with SMTP id 82-20020a250055000000b00dcc6d85586amr3699602yba.49.1713460534336;
 Thu, 18 Apr 2024 10:15:34 -0700 (PDT)
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
Date: Thu, 18 Apr 2024 10:15:21 -0700
Message-ID: <CAJuCfpHpYGMT9Gpf4BxGBB3OLM6QgvifMyPADmzKakPn1-hV2A@mail.gmail.com>
Subject: Re: [PATCH v2] psi: Fix avg trigger being fired unexpectedly.
To: Ingo Molnar <mingo@kernel.org>
Cc: "levi.yun" <ppbuk5246@gmail.com>, hannes@cmpxchg.org, peterz@infradead.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
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

I heard Peter is currently unavailable. Ingo, would you please take
this patch into the scheduler tree?
Thanks,
Suren.

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

