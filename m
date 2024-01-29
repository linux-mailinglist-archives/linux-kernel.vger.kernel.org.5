Return-Path: <linux-kernel+bounces-43592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE2841609
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3057B2062E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49151C30;
	Mon, 29 Jan 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyQ90tP+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDF4F5ED
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568951; cv=none; b=q/RMobOoaBdLnv/cq1icV4wbSIjzoTzPPUrbXO1UOfw/PneZdhO3KTVyKvIZ6fdKRD4Js3JdbOYpfa7A8BCLDUC0oIwIC9Zm7B1qmwTB+78BhiPTYITy5mIMbPOFaN636xFaGAJwGjTwt9ABMlNXw8qnuo5R6bjbNxib7HLtvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568951; c=relaxed/simple;
	bh=XT0W0E6gjKDCCitw6VsfN2/jaVcK7tvHD8mbI+Z/1VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Usws+eRrWHC/bxgJUrfmy5hdpapeluoV3eeZiwWdUAC9mdnBF6VnJaJooU18NpOuVUw8ITVFs/DY7auEOUU21v09PI/kXZCOjN2/KGPO7UB8zIGdwkZuilA43cm6mxapt7WBE9uZ/FTD1jmZIpCEQY5GWFcIy5Z8LiXnwkMWXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyQ90tP+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51117bfd452so803328e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706568947; x=1707173747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zLOqGjvc5zAyBHVNLXc6kpkp0iyLeGdoW01AbqVVlE=;
        b=QyQ90tP+4VOJE0TUjL9lRhGpBioK30u8Iwc6acPCUOyIBNuGF5jJThciOFauMTm26j
         ECbDSQ+69uW8CUycVv0zofXE7jL0jbeTIHHG/W7XlOeQgsiy1xS++cNLHzb1KG/M/+qL
         GdYvR1avuh0/QrjHzrc6+1I2P8Iyp5gsLH3tsu4U3Enbqi/50Jcqa/efnVMbiUoSBfrj
         BxGBmSBF5h/0VaSDJxn8uWZXDCq3G9+XTq+a3A9xSYFJyzlTzO51eV8jqO2M5OLjDnWM
         7+KdzcmlRhicTapIGzBQV1Dteraskbzeohx9GhvtBCbM9fDw13gXba9iAzofC1P/PLWA
         +Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568947; x=1707173747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zLOqGjvc5zAyBHVNLXc6kpkp0iyLeGdoW01AbqVVlE=;
        b=WRSRrk9Rvbsh3/22f8A8I7gm6wgrhKzCnz35PZn7NMKG1T5BHA+hEuh6V6xJwamhkM
         Mx73/M3pkt/2jLLukw4iQ7FycJWFhXJLQSMCh7iYtk1hPp4b05hgbMQt0kd/XdcxkH+u
         PzZfvp5uY9ysz2re4zZysiKCGi0zXmesonqLr0Nag1rGTPKz6Va6t4BlE02FI7Hr5D5B
         KkvzmqskWRYxjP3rxNhy/C3oYWDGhEDfHvv2efqStTLCSUHNTutMtFkf1LRYTzImiqQ/
         lJ4NdmwGbcM9CZg6/Co8b2QEoi87PWUdUq5J06z29jbVPkgOFj4MUVfeZ6cwfvswXaHL
         Ar0A==
X-Gm-Message-State: AOJu0Ywu411DpRAZkAiFW600BThAnP+igwXLHDKtUh+BR/pAfZ9fX8uz
	ghSFIyag5cc0POsA1MqKKUvtHeo9AfN8HaCTNu5ZLTqDJlZoD4i1Ftz+YHlHOnOi7lW8GsK1e3c
	8ziHFVXNZCGnC5rBjZ+Gf2kVcxOo=
X-Google-Smtp-Source: AGHT+IEaEdMN5UVckkQ+sBbas72IcdioezGXU3mTD98Ir0V5njNzJD1Atr2bbQcUIW2EhZKNSU8ZYLPNKVan2Smh2Mk=
X-Received: by 2002:a05:6512:2f9:b0:511:19c1:8e0b with SMTP id
 m25-20020a05651202f900b0051119c18e0bmr197277lfq.54.1706568947140; Mon, 29 Jan
 2024 14:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025947.2110659-1-nunes.erico@gmail.com>
 <20240124025947.2110659-6-nunes.erico@gmail.com> <CAKGbVbsjNdnoNW2JnxCiyZg-wjU0UK+jgsG18OFaHjdkdOWRQA@mail.gmail.com>
In-Reply-To: <CAKGbVbsjNdnoNW2JnxCiyZg-wjU0UK+jgsG18OFaHjdkdOWRQA@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Mon, 29 Jan 2024 23:55:34 +0100
Message-ID: <CAK4VdL1RYHc11_bP785FYWtT7pqJzJf44QXi2kzXK=uPGwjY2g@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] drm/lima: handle spurious timeouts due to high irq latency
To: Qiang Yu <yuq825@gmail.com>
Cc: anarsoul@gmail.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:38=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Wed, Jan 24, 2024 at 11:00=E2=80=AFAM Erico Nunes <nunes.erico@gmail.c=
om> wrote:
> >
> > There are several unexplained and unreproduced cases of rendering
> > timeouts with lima, for which one theory is high IRQ latency coming fro=
m
> > somewhere else in the system.
> > This kind of occurrence may cause applications to trigger unnecessary
> > resets of the GPU or even applications to hang if it hits an issue in
> > the recovery path.
> > Panfrost already does some special handling to account for such
> > "spurious timeouts", it makes sense to have this in lima too to reduce
> > the chance that it hit users.
> >
> > Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> > ---
> >  drivers/gpu/drm/lima/lima_sched.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/l=
ima_sched.c
> > index c3bf8cda8498..814428564637 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.c
> > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> >  /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
> >
> > +#include <linux/hardirq.h>
> >  #include <linux/iosys-map.h>
> >  #include <linux/kthread.h>
> >  #include <linux/slab.h>
> > @@ -401,9 +402,35 @@ static enum drm_gpu_sched_stat lima_sched_timedout=
_job(struct drm_sched_job *job
> >         struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
> >         struct lima_sched_task *task =3D to_lima_task(job);
> >         struct lima_device *ldev =3D pipe->ldev;
> > +       struct lima_ip *ip =3D pipe->processor[0];
> > +       int i;
> > +
> > +       /*
> > +        * If the GPU managed to complete this jobs fence, the timeout =
is
> > +        * spurious. Bail out.
> > +        */
> > +       if (dma_fence_is_signaled(task->fence)) {
> > +               DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> > +               return DRM_GPU_SCHED_STAT_NOMINAL;
> > +       }
> > +
> > +       /*
> > +        * Lima IRQ handler may take a long time to process an interrup=
t
> > +        * if there is another IRQ handler hogging the processing.
> > +        * In order to catch such cases and not report spurious Lima jo=
b
> > +        * timeouts, synchronize the IRQ handler and re-check the fence
> > +        * status.
> > +        */
> > +       for (i =3D 0; i < pipe->num_processor; i++)
> > +               synchronize_irq(pipe->processor[i]->irq);
> > +
> I have a question, this timeout handler will be called when GP/PP error I=
RQ.
> If we call synchronize_irq() in the IRQ handler, will we block ourselves =
here?

If I understand correctly, this handler is only called by drm_sched in
a workqueue, not by gp or pp IRQ and it also does not run in any IRQ
context.
So I think this sort of lockup can't happen here.

I ran some additional tests with both timeouts and actual error IRQs
(locally modified Mesa to produce some errored jobs) and was not able
to cause any lockup related to this.

Erico

