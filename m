Return-Path: <linux-kernel+bounces-105827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165FC87E517
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6483281D89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC491288D7;
	Mon, 18 Mar 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im9Z2UT/"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DF2D605;
	Mon, 18 Mar 2024 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751177; cv=none; b=Dap25xApVGzXY792ClCjUvGdHO/Vpj971UCGg2SSXfeoDaWKyfkv2bP5OdTGh+5TjgkAl3wILxS9ddNFCcxW0FBT4HdpsIZrqp7a4sbHuSaQyC4PqOU6cFj2RFF17hzuA6StPwGINrG7Bzp9FezwoG1Fm05TO0sq9wtZIy00hO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751177; c=relaxed/simple;
	bh=vVRNDFTWoPtwzQ3IZjFY5VjQCSazSJ7M7SEttHV0hKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzXPmlhGLGGLHR9ijFYixVFaxFxHUvsgL848Ev+OGNusoCOD1Uu6Jjn3wIdQgLB5mo0ZcA3R9wEJGRiDKtGRex9pDUrXnSvGlK2GlV007uelTAn1GlbyT6MNv+h5UbGqaZW34OBW6LlnIYCANu4OGK6NpsL1ZC36lS7g4YCSUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im9Z2UT/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso521195a12.1;
        Mon, 18 Mar 2024 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710751175; x=1711355975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhqD0/DPJNiiogh7PLeACfknOmZrcyXgxXzcRpXuP6A=;
        b=im9Z2UT/8UIg4//cOSR96Q/CTa+q2pNj9po6mbIGTqflAVyePSOnYEaCm/0FIu+ZoX
         7iHJxV93hTy1CggPybLreA6yJjYtP0ZZzMCIFNL+dCJuSbGPVrFKJPHZKyxMju+BVm37
         gIIsSpMUXsNZnJZpcIEA8Fr4Dg+3CJtd+Lgb7DxwTG8ws5vdHC4SPFJbNrasEnMUnjSa
         yI87poqaS+369XIW7OzzJBlMfzizQeZ2eEqVIZ+VKkSoPpczJ42cudHcyJUcm2Wn0xfW
         YWGbxAx+Qm5qoBMqB+M2P3+LejdFpvyCffbwXg6WinMnmA1bBEHyF00Lx2mXg3cHwond
         BPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710751175; x=1711355975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhqD0/DPJNiiogh7PLeACfknOmZrcyXgxXzcRpXuP6A=;
        b=M82OOvXC1sPFjniVNO+gleJJw9tpBcL3SsEY62Bxn7VKgrdQWXgtENlBcr4tohQgyG
         XAXccfE5YBKk5m24RO+T1JSMlWxNrJHKFLO2jOiQm8bGfrZVQIF4YQHjMKYakYY7+3UG
         R/MduJgepus7sHdty/P4bwmasDoCBKXIsBrTwRYcrXEKsM6+MImm4seulYpUGCbBHotn
         HrAquYNOJacd9XGsgYuXOe/N9WtoVTyZS8kJHVk+MUn7p9aigRxVbS0MF54fgZtE7QkN
         HC/GEfF/Z1B1mxRsSiihFBuUGGIg6s5tM/B7yRNbqa6kO7aPvTCRY6kIgBGxe5s1XUI9
         PG5w==
X-Forwarded-Encrypted: i=1; AJvYcCWNMbr0Fhb/9yZXu2c2nBWtZ8ApRAIK+Oi3bSP8L0jSHYFLkFC8dXMsOWukyIz3psbmovy/TTh8CCj3Z7AauuPSf6kfBj0o
X-Gm-Message-State: AOJu0Yzw2ujU0PtPGV1Dt5yneuzg56ereopbAInMd5xlHaym5a9z/Rla
	KJIn74E9mfEFTGAJGKLPrYqMZySi1EUufJQ27LtImxmA+zAw+lxp9Heapp9bWruY5EsGhwE0b8k
	8Z8y+P+STaAbeV+pmsXGl2fSrNhY=
X-Google-Smtp-Source: AGHT+IE4i31LAUwvRUHVTCId5zVUOwoXPTGvQMFDx7yawo6GGCMp1hz0y9+TOB5qkAipp9NHqfdsziyK9xpfVGSrRG0=
X-Received: by 2002:a17:90a:ba81:b0:29c:7614:1cb4 with SMTP id
 t1-20020a17090aba8100b0029c76141cb4mr9794036pjr.0.1710751175017; Mon, 18 Mar
 2024 01:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311122401.6549-1-lizheng043@gmail.com> <20240311135117.GA1244788@maili.marvell.com>
In-Reply-To: <20240311135117.GA1244788@maili.marvell.com>
From: James Lee <lizheng043@gmail.com>
Date: Mon, 18 Mar 2024 16:39:21 +0800
Message-ID: <CAPCnf4zS=FN0MHM2tQV0b468zN0yqRHbaNMsk3cDQ7Vu8wiHKA@mail.gmail.com>
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nhorman@tuxdriver.com, davem@davemloft.net, jmorris@namei.org, 
	James.Z.Li@dell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loopback neigh is a special device in the neighbour system which is
used by all local communications and state is NUD_NOARP.
Any setting value of gc_thresh3 might encounter arp table be full,
manually increasing gc_thresh3 can resolve this issue for every time,
but we hope this issue automatically be resolved in Linux kernel for
all local communications whenever ARP table is full, rather than
manually operation as a workaround.


Ratheesh Kannoth <rkannoth@marvell.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=80 21:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024-03-11 at 17:54:01, Zheng Li (lizheng043@gmail.com) wrote:
> >
> > Inter-process communication on localhost should be established successf=
ully even the ARP table is full,
> > many processes on server machine use the localhost to communicate such =
as command-line interface (CLI),
> > servers hope all CLI commands can be executed successfully even the arp=
 table is full.
> > Right now CLI commands got timeout when the arp table is full.
> > Set the parameter of exempt_from_gc to be true for LOOPBACK net device =
to
> > keep localhost neigh in arp table, not removed by gc.
> >
> > the steps of reproduced:
> > server with "gc_thresh3 =3D 1024" setting, ping server from more than 1=
024 IPv4 addresses,
> > run "ssh localhost" on console interface, then the command will get tim=
eout.
> it does not look correct to me. why gc has to behave differently for loop=
back devices.
> why can't a higher gc_thresh3 value (fine tuned to your use case) wont so=
lve the issue ?
> can't you add localhost arp entry statically and get rid of gc issue ?
>
> >
> > Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
> > ---
> >  net/core/neighbour.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 552719c3bbc3..d96dee3d4af6 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -734,7 +734,10 @@ ___neigh_create(struct neigh_table *tbl, const voi=
d *pkey,
> >  struct neighbour *__neigh_create(struct neigh_table *tbl, const void *=
pkey,
> >                                struct net_device *dev, bool want_ref)
> >  {
> > -     return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
> > +     if (dev->flags & IFF_LOOPBACK)
> > +             return ___neigh_create(tbl, pkey, dev, 0, true, want_ref)=
;
> > +     else
> > +             return ___neigh_create(tbl, pkey, dev, 0, false, want_ref=
);
> >  }
> >  EXPORT_SYMBOL(__neigh_create);
> >
> > --
> > 2.17.1
> >

