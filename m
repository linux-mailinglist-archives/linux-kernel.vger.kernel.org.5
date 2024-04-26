Return-Path: <linux-kernel+bounces-160200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 958918B3A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A59B3B25115
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC71148854;
	Fri, 26 Apr 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMfGfSnX"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E891E52A;
	Fri, 26 Apr 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143629; cv=none; b=LFCGBRjIkmISJ9pTHzxnFVcX7XYIhUvR8ivRQdViuQ0smQlbzlLdEwLRz+KDhWfKojF9Y5ExxYSd57GYqUTSHUN/fO1VcCGlZAVZwpyfkw4+1c58ZbnmfiN/WjtDsPUPUnzyAmHRIUSBAbdsvddPu14jlgYXSXmTzP5oJ8mMt0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143629; c=relaxed/simple;
	bh=D0JTVPMoItreQXaR98u8YlOOBXWYx6Lk1Qa1JuIAaSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKlDbrQbq3wo/pHel62V7lSLyWRGlwjYD4zzzKFVbPxisAMZGVL47QXc0gRtrMFiVGnUDbUDRmpc40OwM44ZeDLOUcneJs0qT7bO70dKg19Yts9/6Hc/qBJwjftatl5b1o/oC6V98KABPqpjbreCV0FSWTnEsEm4Bn5KLEIJY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMfGfSnX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51967f75729so2603710e87.0;
        Fri, 26 Apr 2024 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714143626; x=1714748426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI2DiQ7WK0ETjEb7x2y6HuwkQosPYs9rpRMVtAeop9s=;
        b=RMfGfSnXsAevX68ExAyv3pObRfsEdEZEI/kx/kmebLl5eNYX7HIOooBVXhS2vZrnVD
         21awBqdwaY4Sg5zO0u0YSQKglQFb+7qF4cXnhssqGi2cP4pR5MieG8zSLJx2KYk3CtaB
         KTwtZUejAXZ7Usq3Q8wYexIhQcXjeQljYenOOyZ8dsqffKUKPXGew2tQLSsKiTTILbjj
         dN7FQ1Oc8uedUADd+oH+jSSIovKZu6uDytEf4a42VKqBgPWvjB4sCiU7A9SQqcvTa8F2
         uQ79exNqGwykp1/ddF9x7YK2N1HejC5LSIxr1wid7oQV3hFp+GkExHoeIAg6zb+zB/D6
         A5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714143626; x=1714748426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI2DiQ7WK0ETjEb7x2y6HuwkQosPYs9rpRMVtAeop9s=;
        b=jEhU5byBQra2YdKDHU2VvJRZpTxt6gTGmkdg0gJCX8KXSMr4A2J1RoimqLgvcIjRqu
         NRqpWkVD4JlFGhxfbdiN/r92adnIIu9WjO/Zv5ypVnCP35EdwRkzktscu0g9miOA0vG1
         vZNDqsObh0vkQs6KRvE+jtQp6cVdTck1owBueMFwcBuCKocWfR4indinkdAmeO9i6mkS
         MNhb1VSYoCQtBkrNm4WpcAaoEbVKbkQsI3/0qoOagYsMvjfg7veqqLijW9eis7dm5nZF
         4a9U1QwznpiMdKOVMt0QBa2m8WVlCtCeb7mER0vJEUayWw8JzY+woWnxbUTUrhB2trl+
         m/HA==
X-Forwarded-Encrypted: i=1; AJvYcCVwOMO1wlDmxNZJmw+3KApagT4dUlCOx2lxoWomxaIknYPXwFwXihcfQH2ddACz4aVTG6FfD57FCU9K9DUcjQNliUmXukK6j5neP4Tv8BNpFhc80/LNHk7TP67H6RHnCkt5lixmUlaqq+5L
X-Gm-Message-State: AOJu0YxurWazZGw5L2/jNZ7pl1p3Nq6+orZYlSmMJbm2/R2s6QadbT6s
	/6YuxqB4XPlUH9/b44Grg5wihrrF7/p03fQJChUk0ItjH3X0fLQVHyRq1CcnBFfBKzi4xLzPElH
	jKr2vELGieZvqOJmWiip6o3pE+G0=
X-Google-Smtp-Source: AGHT+IEwD4iMuIADNunV7sRblpdAQlKFbRFk+5S1HncPH8Y25XFpKIsg9gfDB526o1V5pE7D74cG/adKVGl7SrTmgG4=
X-Received: by 2002:a05:6512:4012:b0:51c:bc4f:2026 with SMTP id
 br18-20020a056512401200b0051cbc4f2026mr1606484lfb.51.1714143625992; Fri, 26
 Apr 2024 08:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425183251.174412-1-rilian.la.te@ya.ru> <20240425183251.174412-2-rilian.la.te@ya.ru>
 <Ziu7DpoHGLrURI_9@smile.fi.intel.com>
In-Reply-To: <Ziu7DpoHGLrURI_9@smile.fi.intel.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 26 Apr 2024 18:02:48 +0300
Message-ID: <CAF1WSuytbkoMfRotBiQyKHGKacwicSJtkSrbLis9UVwD83WVKQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
To: Andy Shevchenko <andy@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:36=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Thu, Apr 25, 2024 at 09:32:33PM +0300, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > When specifying flag SER_RS485_RTS_ON_SEND in RS485 configuration,
> > we get the following warning after commit 4afeced55baa ("serial: core:
> > fix sanitizing check for RTS settings"):
> >
> >     invalid RTS setting, using RTS_AFTER_SEND instead
> >
> > This results in SER_RS485_RTS_AFTER_SEND being set and the
> > driver always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT=
,
> > which breaks some hardware using these chips.
> >
> > The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, so fix
> > this by announcing support for RTS_ON_SEND.
>
> Greg KH, who is maintainer of TTY/serial subsystem, usually asks to separ=
ate
> fixes from new features. So, sending this patch separately may not only h=
elp
> him, but let's move forward with your stuff.
>

Do I need to increase the version number in split send? And if I need
to do so, then how I should do it? Only on new driver? Or only on fix?
Should I CC linux-stable in fix patch?
> --
> With Best Regards,
> Andy Shevchenko
>
>

