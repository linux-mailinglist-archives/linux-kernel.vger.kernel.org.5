Return-Path: <linux-kernel+bounces-43708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9A841818
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE5C1C21A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBD2EAF7;
	Tue, 30 Jan 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK6TgkVG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378D1DFD9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576759; cv=none; b=ZKRQc1QGkjrZ/os1mqVPR8V9IlM2dOEI4kUtkHeS2Qs2rkatYCbAcDZzpUBeUdAsTwFOD9VQ5VP2u2GXcKJyUFLBuj+9ZOMyP1DTbRMSu6UKd9xQT2t2em1GCiCtN0+AFg/UMOuPqtmtMpQgCYscjmryU5gWLu7++YMqrwIw6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576759; c=relaxed/simple;
	bh=3dyYYkxqXJWSPm5pu+EkoQMQVWxpezoFsFJNhuGoCIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivROLDIr5wuSDbsvCwls3aGvzDwesAG5ZjQ1S74UGDHJMG3ixcGCEqoJpd/dYv1jLoWBj0CJHvNQ0+W/9bpsJyfxymhXEQE29pRCOhjB5DE6l4dx0xwY+mzWdPPlm3DLD3xUJ99aDkvt+oMsXC6qnfdQZkC8QWzVBWNeVAgOMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK6TgkVG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-510221ab3ebso4598207e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706576755; x=1707181555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utPiESSNDR+AI47TC84EhLaybxmywBIeykLJp3N7b/8=;
        b=kK6TgkVG7qNunPxUTn2MbsvSzIMZFk6GRA/GU2wqDbCzGC6b1XscxIN34Njgmwk2d4
         0aT30iyiI1i6CS2MbJexD/5NoNzBf2us3vQRsc2Yp+pkGkkuhJ2N9mCOYB7pS1hlWXNf
         bOpD+RhPYuswplX7RWLjkDzZMsXExv4djPCNNlpeWAV1RtXJ+yS0znErmmD/WsUXCz6w
         Qu8wNQWccNLzhCPNEg8TyUXFtu47q00SamThC1aj3m/i13l+rWl7dDw5auD1ZzMHtdTp
         Vm3v1n5SMoIaz+d3dstIhE6d5XoKmQgG5KybPGFY7WK4WiM3DJIJJ+Xhl9EF2FWKbznX
         pFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576755; x=1707181555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utPiESSNDR+AI47TC84EhLaybxmywBIeykLJp3N7b/8=;
        b=lHSkogcrf/6XCtOM9odUU7xbMuFNf4WTMcpcjFTLIrbmuKUiiNnh+duA0LNR+2h1mZ
         4aG8ZiqyAWOM/clxCXNnjdVV0Qhc8GzyCj1rgvccokZrLIzpd4L12ULwgrZ+Uk3KMfqm
         ryOEn7gdGWhcn7kPcsefP8V4RzuYOUahCQNdaC7sgHFJy0X0HIXd1C13YH3XZg1d5Tjw
         22hhHlOtNdxurcSp+5sV/4gOUkR6zZhPg9cU0mK1z/io3D64L7UntbG1m5p9dT4LVTlG
         kh6uwtTf/WFnZxYxAzg5hyFlKTWM0l2F64fspJA7WEtrNMNVVy93CkN+sJZMzDWUk/LP
         WArg==
X-Gm-Message-State: AOJu0Yx+LNZRDnrkBUnEODesO8K5tONQo6GblncFTXexjJZPtA48tOMn
	arB53OowhYto9PuU9nMtexaIBWygLOx/J9+6QYmfGDppQK7DwT/zuPX6RqDeOKVo+M9B5oPcJH4
	LxbYBOczUeVfmcd6n/BbJghrYnHM=
X-Google-Smtp-Source: AGHT+IEN1tQ9S5IOdm+qmGt+etuGABXHJCkeBOCMHd7t8G9FGNh0YipjMQzXu53+lJf/Yr40gE+/K1jIGrE2j7eq5IQ=
X-Received: by 2002:ac2:519a:0:b0:511:1b89:1a30 with SMTP id
 u26-20020ac2519a000000b005111b891a30mr74110lfi.63.1706576754843; Mon, 29 Jan
 2024 17:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025947.2110659-1-nunes.erico@gmail.com>
 <20240124025947.2110659-6-nunes.erico@gmail.com> <CAKGbVbsjNdnoNW2JnxCiyZg-wjU0UK+jgsG18OFaHjdkdOWRQA@mail.gmail.com>
 <CAK4VdL1RYHc11_bP785FYWtT7pqJzJf44QXi2kzXK=uPGwjY2g@mail.gmail.com>
In-Reply-To: <CAK4VdL1RYHc11_bP785FYWtT7pqJzJf44QXi2kzXK=uPGwjY2g@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 30 Jan 2024 09:05:42 +0800
Message-ID: <CAKGbVbumNMYXTCDoSbWBj3NnODPZuWi4mV1QgqoadnV-X1PVBA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] drm/lima: handle spurious timeouts due to high irq latency
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:55=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> On Wed, Jan 24, 2024 at 1:38=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote=
:
> >
> > On Wed, Jan 24, 2024 at 11:00=E2=80=AFAM Erico Nunes <nunes.erico@gmail=
com> wrote:
> > >
> > > There are several unexplained and unreproduced cases of rendering
> > > timeouts with lima, for which one theory is high IRQ latency coming f=
rom
> > > somewhere else in the system.
> > > This kind of occurrence may cause applications to trigger unnecessary
> > > resets of the GPU or even applications to hang if it hits an issue in
> > > the recovery path.
> > > Panfrost already does some special handling to account for such
> > > "spurious timeouts", it makes sense to have this in lima too to reduc=
e
> > > the chance that it hit users.
> > >
> > > Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> > > ---
> > >  drivers/gpu/drm/lima/lima_sched.c | 31 ++++++++++++++++++++++++++++-=
--
> > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima=
/lima_sched.c
> > > index c3bf8cda8498..814428564637 100644
> > > --- a/drivers/gpu/drm/lima/lima_sched.c
> > > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> > >  /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
> > >
> > > +#include <linux/hardirq.h>
> > >  #include <linux/iosys-map.h>
> > >  #include <linux/kthread.h>
> > >  #include <linux/slab.h>
> > > @@ -401,9 +402,35 @@ static enum drm_gpu_sched_stat lima_sched_timedo=
ut_job(struct drm_sched_job *job
> > >         struct lima_sched_pipe *pipe =3D to_lima_pipe(job->sched);
> > >         struct lima_sched_task *task =3D to_lima_task(job);
> > >         struct lima_device *ldev =3D pipe->ldev;
> > > +       struct lima_ip *ip =3D pipe->processor[0];
> > > +       int i;
> > > +
> > > +       /*
> > > +        * If the GPU managed to complete this jobs fence, the timeou=
t is
> > > +        * spurious. Bail out.
> > > +        */
> > > +       if (dma_fence_is_signaled(task->fence)) {
> > > +               DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
> > > +               return DRM_GPU_SCHED_STAT_NOMINAL;
> > > +       }
> > > +
> > > +       /*
> > > +        * Lima IRQ handler may take a long time to process an interr=
upt
> > > +        * if there is another IRQ handler hogging the processing.
> > > +        * In order to catch such cases and not report spurious Lima =
job
> > > +        * timeouts, synchronize the IRQ handler and re-check the fen=
ce
> > > +        * status.
> > > +        */
> > > +       for (i =3D 0; i < pipe->num_processor; i++)
> > > +               synchronize_irq(pipe->processor[i]->irq);
> > > +
> > I have a question, this timeout handler will be called when GP/PP error=
 IRQ.
> > If we call synchronize_irq() in the IRQ handler, will we block ourselve=
s here?
>
> If I understand correctly, this handler is only called by drm_sched in
> a workqueue, not by gp or pp IRQ and it also does not run in any IRQ
> context.
> So I think this sort of lockup can't happen here.
>
Oh, right. I miss understand the drm_sched_fault() which still call the tim=
eout
handler in work queue instead of caller thread.

> I ran some additional tests with both timeouts and actual error IRQs
> (locally modified Mesa to produce some errored jobs) and was not able
> to cause any lockup related to this.
>
> Erico

