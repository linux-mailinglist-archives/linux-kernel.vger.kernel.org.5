Return-Path: <linux-kernel+bounces-61253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E6D850FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A771C20F43
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB517BA8;
	Mon, 12 Feb 2024 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7B0Qg0A"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8A12B89;
	Mon, 12 Feb 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731081; cv=none; b=Lt/Ci6ic4F5E7t/uh+nFp99FTTM5SoAVmlAexEngvAiFXLsm4RtzA9LpLFrOvgh7aiisLqJm223OOvkrG0tmSoCWkX26z6gSpd6SZ1kzphRwgbmM1r9acMrhDJb23eLvTM1BbxgLkxKS4Q2oXmNd/kxq/9u+HxVUBv9l+3cPE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731081; c=relaxed/simple;
	bh=BDex9CHMPTrROryA/0/YTlMGIku/EOc2sBxwRrKcQQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLTPynaUvm2o3avpTETZlOWfqTaq91gpXY4Q+9Yx8fQR9bP0k9X19+Atu1bfMOk+Ws+4yrTJMdvyfSDml0hHolCVLh/zoDfrswPWvkXJ5r0/xDbpUF/CeqXyqa/S4xJn+8xwd13ZNai5sFcamjr3gFEnSlN+PIgFFe8YyECBvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7B0Qg0A; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso4136420a12.3;
        Mon, 12 Feb 2024 01:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731078; x=1708335878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDex9CHMPTrROryA/0/YTlMGIku/EOc2sBxwRrKcQQ8=;
        b=j7B0Qg0ATPNfl1AK7PgZA6iNisCee36vR0Al9rpEPP4xWY2LJiopN+0j+2nVZdcXDr
         KZmuktDzTVzDrggChwsLRe2xWljqc9tu0EwjqdOVXx1InMP2tF01XlpgZLvqBlJRYFWi
         XOGxd8PRWxDUWFFafksA79gpgaX+8vjWyOIoumsdYJ8w0WJD2TGRXQ77v1Oz+3q0ChsO
         pi8yeuhTS20BMcGRq6Z3ntBDA5QppZy7sIrzh57o6FBMv/bZ2eM9XrUVP4/LCSegy+KD
         WYuxY+/AvzoXmf+QHdFqqH6SAViTY/rkfFErKudJTA3JMT4f4tXPPyb1jOGriNHYmPoI
         DuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731078; x=1708335878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDex9CHMPTrROryA/0/YTlMGIku/EOc2sBxwRrKcQQ8=;
        b=EQFitoFex4jZ4Aem50sB8tU8mjif6bpbbXLAArxcSwjr93W0Ow8IBXOwHm9TEghG9u
         rEn6n5BREnZj7XYq/FMESfVFHShwjEUNTMWAn+oTWnWembthI24ji2h1jBlEoJXyuKgp
         PjX+DLOWoq08n6pMp8C1EopLv5L4J0soeJk7oh6nDlMXYdJiyXRNWMKKmmsYjWxj45o1
         8Bj7iEnUN5UCu2taEgBqXZRpmBwnxtXgQbXzNsvidVb4102NwXld69RRqBlCcS3BiP+w
         JPbs2HgQ9nG27kGV/eBs2qWIO442Pr98lDG+/GSyw0tsMF+PQxbK6uM6vQRopHAr6YYM
         GhKw==
X-Gm-Message-State: AOJu0YwefR2NvlEnt5jSlLIJzu7hVnQZKXXlaA7WEsHgV99liI3sES44
	MBvkGiVLZDL31artpa1jJNbaA7rQ3ddhlgbngjpSSbvKM1X9zQniQ6eamLmxL6LTUW0a5f+6qeu
	Gel46ch4q+kXCO/L4mVJmzBQDlU4=
X-Google-Smtp-Source: AGHT+IFd8T1a59U3HO0CTsk54hmzNyd6VOEVH0D0LsrL1/gTpXNqJD4z8Bmup7IJ6IUITT7nnM4hHMaKDEdakMUPcg0=
X-Received: by 2002:a17:906:f190:b0:a38:4ff3:773 with SMTP id
 gs16-20020a170906f19000b00a384ff30773mr4381198ejb.47.1707731078095; Mon, 12
 Feb 2024 01:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240211101421.166779-1-warthog618@gmail.com> <CAHp75VeSLvrxMOARDBHBJ5VGVR-Jv-7saxjJiN-NOPMyTwit3Q@mail.gmail.com>
 <20240211231321.GA4748@rigel> <CAHp75VddjcLaRqugKuk+eejYx_0AHVL4SjYcdh7zUKDj8SpcQw@mail.gmail.com>
In-Reply-To: <CAHp75VddjcLaRqugKuk+eejYx_0AHVL4SjYcdh7zUKDj8SpcQw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 11:44:02 +0200
Message-ID: <CAHp75VcjsVasfaZe25fWzzV-5vv7m7O0-v4j=pcvtWQGKtY5BQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl, 
	linus.walleij@linaro.org, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:28=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Feb 12, 2024 at 1:13=E2=80=AFAM Kent Gibson <warthog618@gmail.com=
> wrote:
> > On Sun, Feb 11, 2024 at 06:58:14PM +0200, Andy Shevchenko wrote:
> > > On Sun, Feb 11, 2024 at 12:14=E2=80=AFPM Kent Gibson <warthog618@gmai=
l.com> wrote:
> > > >
> > > > The documentation for default_values mentions high/low which can be
> > > > confusing, particularly when the ACTIVE_LOW flag is set.
> > > >
> > > > Replace high/low with active/inactive to clarify that the values ar=
e
> > > > logical not physical.
> > > >
> > > > Similarly, clarify the interpretation of values in struct gpiohandl=
e_data.
> > >
> > > I'm not against this particular change, but I want the entire GPIO
> > > documentation to be aligned in the terminology aspect. Is this the
> > > case after this patch? I.o.w. have we replaced all leftovers?
> >
> > Agreed. Those are the last remnants of the low/high terminolgy that I a=
m
> > aware of, certainly the last in gpio.h.
> >
> > Having a closer look to double check...
> >
> > Ah - it is still used in Documentation/userspace-api/gpio/sysfs.rst -
> > not somewhere I go very often.
> > Would you like that updated in a separate patch?
>
> Yes, please. For this one
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Also
"The values are boolean, zero for low, nonzero for high."
https://docs.kernel.org/driver-api/gpio/consumer.html

And there as well
"With this, all the gpiod_set_(array)_value_xxx() functions interpret
the parameter "value" as "asserted" ("1") or "de-asserted" ("0")."
So, should we use asserted-deasserted?


On https://docs.kernel.org/driver-api/gpio/
"get
returns value for signal "offset", 0=3Dlow, 1=3Dhigh, or negative error

..

reg_set
output set register (out=3Dhigh) for generic GPIO

reg_clr
output clear register (out=3Dlow) for generic GPIO"
(Not sure about the last two, though)

https://docs.kernel.org/driver-api/gpio/intro.html
"Output values are writable (high=3D1, low=3D0)."


A-ha, here is the section about this:
https://docs.kernel.org/driver-api/gpio/intro.html#active-high-and-active-l=
ow.


On https://docs.kernel.org/driver-api/gpio/drivers-on-gpio.html
"ledtrig-gpio: drivers/leds/trigger/ledtrig-gpio.c will provide a LED
trigger, i.e. a LED will turn on/off in response to a GPIO line going
high or low (and that LED may in turn use the leds-gpio as per
above)."

So, can you re-read all of it for high/low asserted/deasserted,
active/inactive and amend accordingly?

--=20
With Best Regards,
Andy Shevchenko

