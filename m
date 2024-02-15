Return-Path: <linux-kernel+bounces-67396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0875856AED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646A8B2D3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7113667C;
	Thu, 15 Feb 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9MNMVdx"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449A1339B2;
	Thu, 15 Feb 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017771; cv=none; b=GPbzuJitlmEImAKmHsEHhLhVDYjbw6bJTlhskXjscjt54YhMMkfxG/XyOcJn/Jo3PWc+qtFyURxw99Nji8+PDzYKv0gcInTMwATQaxVlQcn7eaAy6AR5rjqjuhzjesmIP9WKlxYh9lRXN2dU+o9t660uuTOYAE/ti4P5ytwz9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017771; c=relaxed/simple;
	bh=XcFuiZ5s56815JSxdn3FuAWZe+yYB2BkC6hNaWDLwMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSE7aTf9YelByJQi4wTR40bWqppy980R3uaFteK700sL/zLBHNcShN7MJavop3kT/JpSKfKXfBfsFKFDWfsCyi2Li35RQ3iqFTU+FmQ2GvQy5rqNAnxQDMNHYFhHfG+k+wDrdGXsCDg2OjMyeDFA8hBXAbEM6hJz8/E+fIvkDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9MNMVdx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso930477a12.0;
        Thu, 15 Feb 2024 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017769; x=1708622569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCdIxf+MdHUM0w19oPm6Hp9wHlfMiiR6Tc593XFKLQ8=;
        b=d9MNMVdxcKTJfyqeDJL27TKKytgdc7t/EV9iXws4WTmq7bI7kvEOU7o+qv+IW0tKQW
         4zG9XM/eXBV5n74ZGQdg5cKlYAi+GpXdTpQAdDtGlb3jEXA8Vi+40fd+EhGXr5+xl0xd
         mgrRm9S9nTu76r/ECKb4OmuyupcSJNSKdlqJXfBtAKYJ7AP8c75jFaaYTBBiQA/aQKC2
         +YevnVMOm9vj6UCPaduf2RWhzzu3my3ow1CWdAmDDMHQTPpuQPFiE99A6kCMUk+e/0hw
         /uKNO2QpLUogoeA/yvK70Hvqjs3izOR2AuPo14IE4yjTI+Q/MMpWrP/V1QyzuDburJJt
         KgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017769; x=1708622569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCdIxf+MdHUM0w19oPm6Hp9wHlfMiiR6Tc593XFKLQ8=;
        b=RuAJC6wq9UG9ITg2JmilNiiVq3yqcnHk30+k4vyoeWcQMJcwnXzS+5dh4GNFhz++0v
         XuzYAZIoM00COCqVYxGOn2tGRR/GHb5ZvRuC9e8RNssV/icHVcLerSKoByIhjUiIf1vZ
         aD36Ml21qzIuWtKLzaEW3o9q+Hn72sooZCRit9G5D3MyANsutaB0E4oa5TI0kpJzXD77
         lVT6unDnEVbMgAkPYzk/NhA7m/RUcuOG6PovJP3osuebPfxd8EMEstUP3mknG23e0ogv
         u3pH7Hd/+hXldyU1WjvwgESCBelVL5yCYgbkw7R7zRgGiSYlwks+E61hWzuhIadkYUcC
         Gv+A==
X-Forwarded-Encrypted: i=1; AJvYcCUDS7bIcn5nI4RLcXhd7nRS37qEH07Fj1ujSKQWea5AWxP8b2gnErNfjE9W4oxYaWrk4hHvq+lCbiEGNhNwKtssbWlSSKN9t4N4N9vxAcrbEjItRMPwD97yHIR6xGhXrvmGXh75VRZ36mb/xT+JD64=
X-Gm-Message-State: AOJu0YzebAKCTUHAGzBA3c62sPlyerz6NFlZcLruBRnfp84pr1IAfzKY
	CBmBMP3qbsDcOc3HqcamuFl+DhiztO9HFEUe4OnBBxhyAO19mw7w+w96HyPGK7REiQ+NU2uRF9x
	jXxqpbtqF8E81M4crptRCALuYFhc=
X-Google-Smtp-Source: AGHT+IF/k0/r55Dh8x6cWEdqsL08/CFLYMXa0asdRWlpnR/QDBrP/5PA5VHD9tvIkfuojErk/doTP31/d0bkOBiqvho=
X-Received: by 2002:a17:90a:c78a:b0:299:1f85:6fdc with SMTP id
 gn10-20020a17090ac78a00b002991f856fdcmr1221911pjb.48.1708017769367; Thu, 15
 Feb 2024 09:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
 <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com> <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
In-Reply-To: <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 15 Feb 2024 11:22:38 -0600
Message-ID: <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
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

On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Maxime,
> >
> > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard <mripard@kernel.o=
rg> wrote:
> > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven wrote:
> > > > Using the Imagination Technologies PowerVR Series 6 GPU requires a
> > > > proprietary firmware image, which is currently only available for T=
exas
> > > > Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, to
> > > > prevent asking the user about this driver when configuring a kernel
> > > > without Texas Instruments K3 Multicore SoC support.
> > >
> > > This wasn't making sense the first time you sent it, and now that com=
mit
> > > log is just plain wrong. We have firmwares for the G6110, GX6250,
> > > GX6650, BXE-4-32, and BXS-4-64 models, which can be found on (at leas=
t)
> > > Renesas, Mediatek, Rockchip, TI and StarFive, so across three
> >
> > I am so happy to be proven wrong!
> > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g. R-Car M3-W.
> >
> > > architectures and 5 platforms. In two months.
> >
> > That sounds like great progress, thanks a lot!
> >
> Geert,
>
> > Where can I find these firmwares? Linux-firmware[1] seems to lack all
> > but the original K3 AM62x one.
>
> I think PowerVR has a repo [1], but the last time I checked it, the
> BVNC for the firmware didn't match what was necessary for the GX6250
> on the RZ/G2M.  I can't remember what the corresponding R-Car3 model
> is.  I haven't tried recently because I was told more documentation
> for firmware porting would be delayed until everything was pushed into
> the kernel and Mesa.  Maybe there is a better repo and/or newer
> firmware somewhere else.
>
I should have doubled checked the repo contents before I sent my last
e-mail , but it appears the firmware  [2] for the RZ/G2M, might be
present now. I don't know if there are driver updates necessary. I
checked my e-mails, but I didn't see any notification, or I would have
tried it earlier.  Either way, thank you Frank for adding it.  I'll
try to test when I have some time.

> adam
>
> [1] https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/power=
vr/powervr?ref_type=3Dheads

[2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/commit/fec=
b3caebf29f37221fe0a20236e5e1415d39d0b

>
>
> >
> > Thanks again!
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firm=
ware.git/
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
 But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds

