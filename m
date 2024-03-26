Return-Path: <linux-kernel+bounces-119625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C238988CB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37861C6510A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4FB1F934;
	Tue, 26 Mar 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RObLNjfE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554A1B28D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475401; cv=none; b=LNczjH0NuHkF/7aTQicd3OOLASMMmF5WIhX1m9xck7BFgbrdsGrYNsIh04lPbAKzBbl6i159I3In+X6+tA5zweKNVCIDQpLAm8mQwdQf0RqMjxNSELK7Hn+SugnP9tJmnxP/R8NOyYJw27x7VjSfXcWRAp9ajJWl8MXM+CLm+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475401; c=relaxed/simple;
	bh=ZZ4JGbZMnbMz3Qe3+LhesVzd/Xs2LOOplkm4GhjpEIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgS7gcRs+ENAbVNM7CKs0dQd5XAmrwAg1sPg4oXoTkRDv6AyLEuFor1iXLnNv+SJZuepydq4kgL6aojApPcvozDN0pfFEJgRrajj5lP5Vq04/zhtNejHm05+FLc8EAFaJmh6h9bt6G5cC+wGVXA65T/eZ45SGlt/AF7BcTRZpT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RObLNjfE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341d381d056so1009645f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711475398; x=1712080198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLrCBIdk4WOKYgFZ4chKh/YnWYEeWF54LzBE4o5yT7o=;
        b=RObLNjfE5BK5Th8blUuSm3XX80C5xLFPcQWUfh9PIXdA1o0Hz62IZiF48vfOldONYF
         6Wza7ivM4F6EREvGLmjm/l5P6ITkE+trKOHjQqQUXVXUgz3i8DcNxQKNZwWS1/KKS0gK
         lQxMTdirHCXI2+gAuXi1TUOpqb8ElcFBOSSCxkIe5++q9PhhIqoNusLMcM7eI7YF831Z
         koMzGpkc1mbQwCCFoDLB/bAPLBLgpw1BlAc0gehxT4P2hx02bR0Cp9DKG3OkxfOi0Owh
         KpHSKlpazPEWNXS99UrCoFy5DGRJFZzacHNE8+uizhrXGPGEeyAmYvTjGCcE0ZrRwwhN
         JJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475398; x=1712080198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLrCBIdk4WOKYgFZ4chKh/YnWYEeWF54LzBE4o5yT7o=;
        b=XVeQMVRYKuE+cWpYRX2I0akrTxMzzOmNVm1hqXfFRyJmjyPHUB6oq9PUCdzml63uiy
         QgEJmmRzooOyd5ZQOzK1ElQXtw3i6Ec8urOC64xImhpZf3O8huyMqmxa/NEJM2eam9Me
         1d5ewq/ToGSLayP0P0y7cKGnAEIgKxNcBMoUHkO4F47pNhlfHiqE0QXBQMA15aAQkNY9
         VI0lZ2E5QTLJSoxiOFyfunUX2ieLjIqMbG0RicNCd88vZblwdOKDFT/XZe3fgtOcX8gN
         VaLA+/jvBzCJkCZ4Cjhh36uieHKVEH5Lq4sqZP5DzaOZcsbj9uE6MySkgKjaPRycTiUs
         MY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2uXSRty3cG6tXEdQf6Y4+W8Y2p0A5FD/k6ZvRVkZHg58frfn6WVvP2Taj5ZqANUTKwaO1ea5mfmEj3YghqAAT58Fa5iS8+MAF1bp8
X-Gm-Message-State: AOJu0YxPXz1AJHmSqAXapmoOY9a2ZfCYmyxeq+LTQ+CVfP39UVZFxlxN
	dvEV+rgNi+o7wXbBUDYxNi8NKc4QRl8Iyui2m37T0/l5IEeUIDdYIl/P6aG/iI0a3pFM8CsageI
	lDsg2RI1sSaxdlPgyG0uGfllb7CzNkvdQmTaKHJboZpG9kFjmrQ==
X-Google-Smtp-Source: AGHT+IEOUmyVJTuAFSy4qsdKVI8IgXkJJYjFTicu6eeLjxlDHJXRBcZ1vljdIHHqcV+h0VhgDbMHoXRJPG/rqlYOPnE=
X-Received: by 2002:a05:6000:d85:b0:33b:62c0:6181 with SMTP id
 dv5-20020a0560000d8500b0033b62c06181mr7093858wrb.42.1711475398145; Tue, 26
 Mar 2024 10:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226211237.48415-1-ppbuk5246@gmail.com> <Ze_x3kovSFe4z9SO@Levi-MacBook-Pro.local>
In-Reply-To: <Ze_x3kovSFe4z9SO@Levi-MacBook-Pro.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Mar 2024 17:49:45 +0000
Message-ID: <CAJuCfpFdbh37qWFS8eCXk0CCQD9bA2wtpOj5BMYPNTcz-0Oxnw@mail.gmail.com>
Subject: Re: [PATCH v2] psi: Fix avg trigger being fired unexpectedly.
To: "levi.yun" <ppbuk5246@gmail.com>
Cc: hannes@cmpxchg.org, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:10=E2=80=AFAM levi.yun <ppbuk5246@gmail.com> wrot=
e:
>
> Gentle ping..
>
> On Mon, Feb 26, 2024 at 09:12:37PM +0000, Levi Yun wrote:
> > commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at init=
ial")
> > fixes unexpected event fired when group->total accumulated for PSI_POLL=
.
> > But, for PSI_AVGS, win->value should be initialized with group->total[P=
SI_AVGS].
> > Moreover, to get exact initial value for win->value, it should be set
> > under each trigger lock to avoid concurrent changes to group->total[].
> >
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > Acked-by: Suren Baghdasaryan <surenb@google.com>

Hi Peter,
Could you please pull this patch into your tree? I don't see it in any
tree, so I think you missed it.
Thanks,
Suren.

> > ---
> > v2: Fix commit message.
> > ---
> >  kernel/sched/psi.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 7b4aa5809c0f..e7f66ab2ad3e 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1323,9 +1323,6 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group, char *buf,
> >       t->state =3D state;
> >       t->threshold =3D threshold_us * NSEC_PER_USEC;
> >       t->win.size =3D window_us * NSEC_PER_USEC;
> > -     window_reset(&t->win, sched_clock(),
> > -                     group->total[PSI_POLL][t->state], 0);
> > -
> >       t->event =3D 0;
> >       t->last_event_time =3D 0;
> >       t->of =3D of;
> > @@ -1336,6 +1333,8 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group, char *buf,
> >
> >       if (privileged) {
> >               mutex_lock(&group->rtpoll_trigger_lock);
> > +             window_reset(&t->win, sched_clock(),
> > +                             group->total[PSI_POLL][t->state], 0);
> >
> >               if (!rcu_access_pointer(group->rtpoll_task)) {
> >                       struct task_struct *task;
> > @@ -1361,6 +1360,9 @@ struct psi_trigger *psi_trigger_create(struct psi=
_group *group, char *buf,
> >       } else {
> >               mutex_lock(&group->avgs_lock);
> >
> > +             window_reset(&t->win, sched_clock(),
> > +                             group->total[PSI_AVGS][t->state], 0);
> > +
> >               list_add(&t->node, &group->avg_triggers);
> >               group->avg_nr_triggers[t->state]++;
> >
> > --
> > 2.39.2

