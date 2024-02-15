Return-Path: <linux-kernel+bounces-67835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E238571A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F4D1C2171B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57895145B13;
	Thu, 15 Feb 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyvzMMmf"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AE145B07;
	Thu, 15 Feb 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040195; cv=none; b=CeJ/6EfPYnPva/GlC+KtLCqZDEmi1raSyrYWyFRGZ/WJk1BOCgNiHiQNdch3yqb9wF7WF9C4SUYQV2VeYxhVjFoEhm+BzUQjuagtnxvPkpxLhoOL3IfFbcAoHcaT0G6VoRsyKyw7JMQbmvJz+wi4k8EMzEZdSghelAsApSnokB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040195; c=relaxed/simple;
	bh=pKC+K91bUJzoSAtPr61c8qwLlqRpkfCfln2SelYab4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJsn2585gPDqVNsq1qIzXGGQdB9N3gHr27ITV3OH7gc8FFJcqw8THrnOuCDOc2hvTPcWZJ2wmNo3tipzozhBpYzQ+pYQb7ErwC9Zwf06fEJ5YoI9Kzl4f2IJwfiCYX/0XaHkrfw9EOh+amNAukb+eP+UDrZIapHrODUzGvCdqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyvzMMmf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dc949f998fso1100656a12.3;
        Thu, 15 Feb 2024 15:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040193; x=1708644993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWjLph67i05d2ZmR3xPB1HBK7d3hYJuubbvWJnFa+U4=;
        b=FyvzMMmfZDcrw6ExVswbEujy97IHDXNeKCsGi+jMRJYVUdm2RzDnupdNvAude4OBQU
         ao38YL6uf+WCBbPKBsUlJFU5RR1V6oNDfeZJ50isCFskgOJf4GdjkSREsJ0NSR9EwV6D
         TOdcztT5RFbp2GK/jYW0KWDU4/nKZ6z9X53yd5HuZ5vQ77+hVu3iWbDbcCW4LZhG+P17
         K/VoG2qr3OXE6QRzy3k0e5dbTlWNiTRFjt8lfHwbipkR4xTA4jbZ6ND4hrlUgt49HofD
         CDWPGp+9WYibAfW1kqrsNj2H0Z7bf1cRRM5b4QrouEuh/MrSLQHc+n+BqF7u8GomLCjT
         d34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040193; x=1708644993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWjLph67i05d2ZmR3xPB1HBK7d3hYJuubbvWJnFa+U4=;
        b=okkJ3d4WsdrOppOlgc3n/vZfCvNY7yGUvWTELYA+VRO7bspWfc0pbf1sXrWItKbRwB
         H9M1bqpnavnH5V5rbSlhA/j4v+ILiQLSKnLTk6+B4EaZ9JvqYptVtpMr9eN0BxzjDYoR
         Yaw11iLTgCI8aCLf0BeDGolcMFdUJd2F2B0IOauhov6uC716lk2+9Sx8YbuJ3GhBfQhW
         3Q73a6fAWhy5ljoqc8ivv6sCiR9rMS2Ow6TZZR7RN8uyYPAsE3hzWP3wfUN1ty18bPur
         1huA1q24dQB7hfY/3SAjZ/QSnWJzyTxlBG5/s+jkN+NbhcnoRVLpG97BB2MQN64allcl
         UlIg==
X-Forwarded-Encrypted: i=1; AJvYcCVCdmmEzNHPMv4+v8eXILnlAlkm8YMoFvAmskNB3aVG/mqsSekgdL45AgZTEtxH0CoDLEijPHZqtoD/Xj9ptKv1Lq013ACUzXO7vpapChYx3tHUxZx27Bkw5VBxJEo/vw1C1LYYpOcVxtowO0xWQ0o=
X-Gm-Message-State: AOJu0Yy5XwJwfuz99L5cYxzamWw72pqdQwx7zx14ETzAC+EL2l+uD9Id
	cstyfPHpJxypdlS3/oV7ySn8KwYzWDFgCde+79+vuEitM3gWkoRdvB/JXY9dV2DvsO8pL3OCAm2
	rCvu8zoJAZHMtNh9AkQOQ5//P/Ro=
X-Google-Smtp-Source: AGHT+IG4ZEXj+p9Jo4HtkAfP65eziXRxq/kR+4m5d+LlfJQCAPYcqB/hu2liUIwiJzI/2nw5AOSdZixFpOVtCL3Z/G8=
X-Received: by 2002:a17:90a:c7c8:b0:298:e3da:70f2 with SMTP id
 gf8-20020a17090ac7c800b00298e3da70f2mr3501466pjb.10.1708040193009; Thu, 15
 Feb 2024 15:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
 <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
 <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com> <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
In-Reply-To: <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 15 Feb 2024 17:36:21 -0600
Message-ID: <CAHCN7xKffJ29zyjoJVAcy3b_d=-zkFzbL=URj4yWJWzYvRdB_Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maxime Ripard <mripard@kernel.org>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sarah Walker <sarah.walker@imgtec.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>, 
	Nishanth Menon <nm@ti.com>, Marek Vasut <marek.vasut@mailbox.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:22=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gmail.com> w=
rote:
> >
> > On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > >
> > > Hi Maxime,
> > >
> > > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard <mripard@kernel=
org> wrote:
> > > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven wrote:
> > > > > Using the Imagination Technologies PowerVR Series 6 GPU requires =
a
> > > > > proprietary firmware image, which is currently only available for=
 Texas
> > > > > Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, to
> > > > > prevent asking the user about this driver when configuring a kern=
el
> > > > > without Texas Instruments K3 Multicore SoC support.
> > > >
> > > > This wasn't making sense the first time you sent it, and now that c=
ommit
> > > > log is just plain wrong. We have firmwares for the G6110, GX6250,
> > > > GX6650, BXE-4-32, and BXS-4-64 models, which can be found on (at le=
ast)
> > > > Renesas, Mediatek, Rockchip, TI and StarFive, so across three
> > >
> > > I am so happy to be proven wrong!
> > > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g. R-Car M3-W=
.
> > >
> > > > architectures and 5 platforms. In two months.
> > >
> > > That sounds like great progress, thanks a lot!
> > >
> > Geert,
> >
> > > Where can I find these firmwares? Linux-firmware[1] seems to lack all
> > > but the original K3 AM62x one.
> >
> > I think PowerVR has a repo [1], but the last time I checked it, the
> > BVNC for the firmware didn't match what was necessary for the GX6250
> > on the RZ/G2M.  I can't remember what the corresponding R-Car3 model
> > is.  I haven't tried recently because I was told more documentation
> > for firmware porting would be delayed until everything was pushed into
> > the kernel and Mesa.  Maybe there is a better repo and/or newer
> > firmware somewhere else.
> >
> I should have doubled checked the repo contents before I sent my last
> e-mail , but it appears the firmware  [2] for the RZ/G2M, might be
> present now. I don't know if there are driver updates necessary. I
> checked my e-mails, but I didn't see any notification, or I would have
> tried it earlier.  Either way, thank you Frank for adding it.  I'll
> try to test when I have some time.
>

I don't have the proper version of Mesa setup yet, but for what it's
worth, the firmware loads without error, and it doesn't hang.

[    9.787836] powervr fd000000.gpu: [drm] loaded firmware
powervr/rogue_4.45.2.58_v1.fw
[    9.787861] powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 O=
S)


adam
> > adam
> >
> > [1] https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/pow=
ervr/powervr?ref_type=3Dheads
>
> [2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/commit/f=
ecb3caebf29f37221fe0a20236e5e1415d39d0b
>
> >
> >
> > >
> > > Thanks again!
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-fi=
rmware.git/
> > >
> > > Gr{oetje,eeting}s,
> > >
> > >                         Geert
> > >
> > > --
> > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
> > >
> > > In personal conversations with technical people, I call myself a hack=
er. But
> > > when I'm talking to journalists I just say "programmer" or something =
like that.
> > >                                 -- Linus Torvalds

