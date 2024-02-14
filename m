Return-Path: <linux-kernel+bounces-65887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8E855352
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0121F2893E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007213B7A9;
	Wed, 14 Feb 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT3tkeG+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F486649
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939612; cv=none; b=FG+kO11jauHsztaaF3zueNfzvG4cqNRIVc2nzh+B/o/YF1UQ9taFK7QBj2VlNM0aWHjTS9EIZTwWmJhs674Q+V8UQXiNJ+0LQAhv4+9XjOpXPEtRcQo1fyPjlbVWgPJqspLatvHrMV2qhBsPYygUlEdg6/OstIviqQ8glkwXLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939612; c=relaxed/simple;
	bh=Nh/RPEGQMLbipsQ873OI9l7WmsakJphI8B81DlzeqAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4KV9g2qE+NufRUBlZwacyry60NuCmZRDjQBbiZ0RgbhQayeEnqY3Iktqvslq/XLN80NefRQYnbLLmHoKq0B69HFV2zDo/o5V6fg2/K0XIyKdqcPYwEe2oWmu2ioh1xRxYCfTS3EtKAoLCnREpfiKiei7JuHFyLpFnhC0OXx32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT3tkeG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707939609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40AE8jzoctMs/4UQVB3kZWi/SrcTMf7FmeAg9I90IS4=;
	b=AT3tkeG+jjFPvc8dernrQwOXbnwzl4BQTMhFQpwqM3tsi4fq/03/KGE+KjHvIn3pzs7fhh
	HOHNw4NaAoWoDSC1sT+ekcBY+ZAp9ekwrS2p/pcWb6qWodcXBTiaXWlfXcLZpsf6wQN8Nz
	rW8k1vYcdduQBh04sW/e7fM9mNJ0KpA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-SlEEiGEUMhWzA4KHLeK65g-1; Wed, 14 Feb 2024 14:40:08 -0500
X-MC-Unique: SlEEiGEUMhWzA4KHLeK65g-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dc64f63d768so49557276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939607; x=1708544407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40AE8jzoctMs/4UQVB3kZWi/SrcTMf7FmeAg9I90IS4=;
        b=KlepsUShQyagJGjBLAaIiBCotFCEL5VcriJmsq5Pg77zreUG7MxZ7yrO6KkNeYIM4X
         13S0VLIoZ2YffAodBJp5ajlmvqwZNiN/u9ANjLWUr5jvpA2L3JGNw0OZZJg54wYLTzVg
         Ds6au99mIMCF9PlF88ay+bKo++kajiPtHmI69/Dp1zj8fdTd8OBoksx6WzMSVncYm9Ej
         bIZqqwfxh+thUxG2g+DTuhoHXVD6sXp2+HCJRyB1mMH97BwU1TDezx+8PXJmZ1Pb4Xvm
         aZGZap3SGHfkWysdYoq6l20KckiJzo/gfpQZEW0Pm5RN7Kvk6cMCzYOsU/qJaHVkR1A3
         IstA==
X-Forwarded-Encrypted: i=1; AJvYcCVdrByEoOlKSVIAwTOi72uPYXw6FJ7MeUY9wE2vbG5HWrI0j5UX0n2WOHiexTgpPu4Uwz3k+NU44zaNlzCE0SycZ1xMFxbglI8g89wP
X-Gm-Message-State: AOJu0YzXCSmi+zJS973wAJ7Wb8Cu0jRA8CW5FFfPPVQZcTKw6GHzWkzX
	MO07mGuje7o6Q5gQq39ZqxDmlNJ+f58NXPuQfbJEPZklAljmz0mQ509LTPfOBKXdY6MLxhLF55K
	RvDRfe8B45ivPPDx/KHCgQiGKkR0pBlg/EEIZ5H+EK+yeOM6FGzJZPTf2bLZ68xcNNGiRDRLpRm
	bg8H1wfdb8uRtFqqOqd4llIg9b/8snpULUuu1l
X-Received: by 2002:a25:8391:0:b0:dcd:59e4:620c with SMTP id t17-20020a258391000000b00dcd59e4620cmr3543767ybk.49.1707939607709;
        Wed, 14 Feb 2024 11:40:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfRe7gS1Br3szsmeSRIaV1Vjr5iFP1u6aZ0i0V5KCMfqQ0Ntu2jtH9k8bI7ZqOnZmqvInJwB/MFN0YZ80FzeY=
X-Received: by 2002:a25:8391:0:b0:dcd:59e4:620c with SMTP id
 t17-20020a258391000000b00dcd59e4620cmr3543755ybk.49.1707939607473; Wed, 14
 Feb 2024 11:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com> <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
In-Reply-To: <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 14 Feb 2024 20:39:31 +0100
Message-ID: <CAJaqyWe1=eQ4eQyv+wOqbr3pfZst6gmss2SrDZSNkY_ZVXcf=Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:50=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 2/13/2024 11:10 AM, Eugenio Perez Martin wrote:
> > On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Steve Sistare <steven.sistare@o=
racle.com> wrote:
> >>
> >> Flush to guarantee no workers are running when suspend returns.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/=
vdpa_sim.c
> >> index be2925d0d283..a662b90357c3 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vd=
pasim *vdpasim,
> >>         kthread_flush_work(work);
> >>  }
> >>
> >> +static void flush_work_fn(struct kthread_work *work) {}
> >> +
> >> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
> >> +{
> >> +       struct kthread_work work;
> >> +
> >> +       kthread_init_work(&work, flush_work_fn);
> >
> > If the work is already queued, doesn't it break the linked list
> > because of the memset in kthread_init_work?
>
> work is a local variable.  It completes before vdpasim_flush_work returns=
,
> thus is never already queued on entry to vdpasim_flush_work.
> Am I missing your point?
>

No, sorry, I was the one missing that. Thanks for explaining it :)!

I'm not so used to the kthread queue, but why not calling
kthread_flush_work on vdpasim->work directly?

> >> +       kthread_queue_work(vdpasim->worker, &work);
> >> +       kthread_flush_work(&work);
> >> +}
> >> +
> >>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >>  {
> >>         return container_of(vdpa, struct vdpasim, vdpa);
> >> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdp=
a)
> >>         vdpasim->running =3D false;
> >>         mutex_unlock(&vdpasim->mutex);
> >>
> >> +       vdpasim_flush_work(vdpasim);
> >
> > Do we need to protect the case where vdpasim_kick_vq and
> > vdpasim_suspend are called "at the same time"? Correct userland should
> > not be doing it but buggy or mailious could be. Just calling
> > vdpasim_flush_work with the mutex acquired would solve the issue,
> > doesn't it?
>
> Good catch.  I need to serialize access to vdpasim->running plus the work=
er queue
> in these two functions.  vdpasim_kick_vq currently takes no locks. In cas=
e it is called
> from non-task contexts, I should define a new spinlock to be acquired in =
both functions.
>
> - Steve
>


