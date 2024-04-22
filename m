Return-Path: <linux-kernel+bounces-153316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D208ACC66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3205B2417D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51BB146D7D;
	Mon, 22 Apr 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWRe/a2S"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E61448E5;
	Mon, 22 Apr 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787090; cv=none; b=GTcGlX4SQtVGNg2bUJ5sEs574Lsqhaqoqb75GuQdamvXZVkqUlo1/KnU0aN+LcsfSmyiQoQ1sCSMbBWGaGtyzTgxl4ylAaThOPfPyaYxgvHxmEvLzhZYOvGs7R9agI8e0MjaxcaeK0b2Ipx//9lOEksa5Oq8qKUzw3o3DyNYUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787090; c=relaxed/simple;
	bh=VipMOGIq2wHb6Q+n91B5uUyA/cw4HteNixtQ8DSmDuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgxMAVeeentGNcHASrWTRCuo7bPYA9VZO+KQPRBekz6zPnmvBUDv630eNK4sxQzBnKhAvsjHQnG+7KkL5iKS3/s+kY8YYiBZLyHCAuVxxUj6hGEYsjxoT9eM+21Klxkb+BZjdoheoxy4WW5Ph5a0qTNVetWINdt47wowShTnnQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWRe/a2S; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5720d52eb10so763871a12.0;
        Mon, 22 Apr 2024 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713787087; x=1714391887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5cT3Mjt5mWgJ6GDMQ81DpgcDSlmFscUnCMU6YJbhCw=;
        b=lWRe/a2SJLXKg5XPwMZRPN94utV0NNrbgoDEMY+bE2StB2PXzUE+q1rm3RNt6wr6wu
         xCKOsBShf6Rk6g7dYhcMpcRA3V2aj4W7EFQ0BUX92vvtQiae+6Lx1RD4iSjO9xLisZ5E
         JXbWSXA4dO425pLW+0IskFTqdjHh8gU5o7Va4zAY8/fbkbNK/sR79x4LxEkfaqCwqSD3
         JgJAxwXXQ6Flwz4Bnxkzg2KQboWXJfgFu96cBllz9LoeyotRRz1ljEF2AacmqTT4MKop
         qJ45RRIGzNCc51fgR71dYXqosQXU7vxUVRS5IZRpHElMJbHVqP0ahF2WFCevOEqtMl0m
         8Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787087; x=1714391887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5cT3Mjt5mWgJ6GDMQ81DpgcDSlmFscUnCMU6YJbhCw=;
        b=Bpz3Qul2r/tEKFyIdFHNwM2ZvdEmGRYurj2kVmBmt//oxhwPwhJ0xyLudmKYC0I0il
         tR9IrOsGsbOuUFdnQD2SA0bXSPmKAKHzkjIuSpXQQ1y50ZjR9hQzqXEEF+FzobNuuF9V
         V7laNlYZ7qozr5rb4Jzr2m5GmkjNsfuXon5zC7IR8rcap+rV6XLzjYK1GcdzNXCio31X
         R3cSwjsdfOoqLeqir8ZBgpk9VyU+56pEMkZiSlm+uewr9gF2eo/Ur6uSMwn9OLXcDBdE
         Rw5W+ACEFYWzxfmj8+MgEYOp7MOlOC8PIjANOcm9zfOuKD2PI0AmVPj3Nw177fmEqlWW
         vBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSAJCmItj9IPEzCM157l89nnmNNXy0nQs+JLDYxACebfwswnxpbYmW4RyBgrDXUA7XJEwDH6JIxNOfly+KhFsUI4uWMxlqVtxC/lLSuNkwW7+IBl8zwALhXieNrJTeDESnqhce/07V1y6E
X-Gm-Message-State: AOJu0YwSFo1TPxRFhywdNeE8+2aIrCixC8Ak+gYEl7Ear2AjfeBNX6H6
	K8Op8loQh0MjT7FMHlWRcOP7VH5v4R8mIcuqIdJUBBA0qRPOKbFCbe8Zdu3UUZ0S5q7/bbdpRz5
	OkMhikmI39X0z/jhluaYeD+eGzSM=
X-Google-Smtp-Source: AGHT+IEUsBi2dnNuzu0y32kfOfl7MQb1OlOBxXxk1146GEVgYYSUSd3929kgB0y5l3v8tbPK0j9N+CcfVu9zS3Fbgkw=
X-Received: by 2002:a17:906:d972:b0:a52:65bd:a19a with SMTP id
 rp18-20020a170906d97200b00a5265bda19amr6826211ejb.57.1713787086310; Mon, 22
 Apr 2024 04:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420182223.1153195-1-rilian.la.te@ya.ru> <20240420182223.1153195-4-rilian.la.te@ya.ru>
 <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
In-Reply-To: <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 15:00:18 +0300
Message-ID: <CAF1WSuwCdonhyzAKX6EeyWAHNX11bV+tgCLJ4vXuEXTAceVvzA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:30=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 20. 04. 24, 20:22, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > XR20M1172 register set is mostly compatible with SC16IS762, but it has
> > a support for additional division rates of UART with special DLD regist=
er.
> > So, add handling this register by appropriate devicetree bindings.
> ...
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> ...
> > @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device =
*dev, unsigned int reg)
> >       return reg =3D=3D SC16IS7XX_RHR_REG;
> >   }
> >
> > +static bool sc16is7xx_has_dld(struct device *dev)
> > +{
> > +             struct sc16is7xx_port *s =3D dev_get_drvdata(dev);
> > +
> > +             if (s->devtype =3D=3D &xr20m1172_devtype)
> > +                     return true;
> > +             return false;
>
> :) so this should simply be:
>
> return s->devtype =3D=3D &xr20m1172_devtype;
>
I especially want to avoid this construction, because it will lead to
idea than we does not have other
DLD-capable UARTS, which is simply not true, there is, for example,
XR20M1280 UART, which has roughly the same register set
(https://www.alldatasheet.com/datasheet-pdf/pdf/445109/EXAR/XR20M1280.html)=
.
I simply do not have other devices, so I do not
want to risk sending untested patches upstream.

> ...
> > @@ -1002,6 +1052,7 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >                                 const struct ktermios *old)
> >   {
> >       struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > +     bool has_dld =3D sc16is7xx_has_dld(port->dev);
> >       unsigned int lcr, flow =3D 0;
> >       int baud;
> >       unsigned long flags;
> > @@ -1084,7 +1135,7 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >       /* Get baud rate generator configuration */
> >       baud =3D uart_get_baud_rate(port, termios, old,
> >                                 port->uartclk / 16 / 4 / 0xffff,
> > -                               port->uartclk / 16);
> > +                               port->uartclk / (has_dld ? 4 : 16));
>
> Could you do this instead:
> unsigned int divisor =3D sc16is7xx_has_dld(port->dev) ? 4 : 16;
>
> ...
>
> uart_get_baud_rate(..., port->uartclk / divisor);
>
>
> I am not sure the above warrants for a new version. Just in case you are
> sending one.
>
> thanks,
> --
> js
> suse labs
>

