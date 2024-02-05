Return-Path: <linux-kernel+bounces-52753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7D849C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4EFB22D7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192D22F11;
	Mon,  5 Feb 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ivlIrPTN"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CA28DD5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141262; cv=none; b=bCZUm5oZ62Hk3V6DNVD4caSVjiT885bgmlzKhKrwo9vpqVohRrZkeyKQgQfSz6qmE0vRFZeMXnF++7//oHe08v+QTlw9DdoSrE3nlVmFRTqBiVMFkjOOxP1zEslfpBA6vxCegqWvg0LLARbIdFjdOBlTOQVwoXaI85f9TT8aHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141262; c=relaxed/simple;
	bh=aux7wipqGSS/b1i8WrSVhnV8xUXmXPnaJ/RFXHy3Ln0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWZ0ADYzPdEibZaqv0IoY1dFOS99RiK7FfUVgtPks2vDj//WOjmIW+yLNP1KjeVww1tDQZI15ln+fUYHPCAWrq1nkx0qjQo8hS8phNRp3MgoJPklmMieVvlR65ETJy/oQbxo7aCvTS43DVWtI/FX0NwNfavRyyKhDBzn+gIlaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ivlIrPTN; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4bd45397c17so1399351e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707141259; x=1707746059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYs4Bp7BlQ+p0nhjl4WseQbxPovMzr8cdsX3pUyZGW8=;
        b=ivlIrPTNfuoTqQn+TYEpuZxyDNf6CL0PYdsdMkbueMxI5gyzZQrqWsmNe8mM0MzOia
         R3rXCe6Lk6IEBOV8NOrjBP34BzJDy1ew6YGfStyipJo+KpdL5MQvejYW6jJIx9NaCwrT
         MSuZHbWgRThRyzLgqOJCSHj/zvJ44MqOCmR4XY3NA4GSAW76MGiWZgKF0WCfun4IuN+h
         lzODmx3DycT/OxVqdFkdjmmL+eH/nw3S9OvXmJ5SHqJOPkHEOjm0pQvEVUqZamXcqqtO
         Hv+TxB1p4blrFBfT9qpvdgmw/uN6KHs46HQgylU+YoQ2HzarrmxMJpjA9Jb6pORj8hRo
         9oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141259; x=1707746059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYs4Bp7BlQ+p0nhjl4WseQbxPovMzr8cdsX3pUyZGW8=;
        b=hA+XdCkGULOSVoJJLzDKS9Zfl9CfQ8O5sR7rsDnlxcBM1S0Km+DyKHMH6UIE+7mYUV
         flQnJ2jN/2akJUt4IN8031nQvxslwbMxp+84SybMO5oUk65Y0EsP47YLwxdDMGmvYHzo
         BRYr15rybUCJKu/tmRanYcborVVR1t/KJnqN7XqLzIw3pFu9A9P3G5UJCKZ6wOCengyK
         RKAFf6XSNSjPLWORVdkIoLqpLyC2VB41dUYolONY4BLlX6ypIS+9378J1b07/Fop07fX
         +KgKv5RgWZ6ZXOF7wYEl523TFqCNjH5IBIJsCslmLNolsRm3KvWfYw7SaafIqjL2aVF6
         rf/Q==
X-Gm-Message-State: AOJu0YyThibBT8q0tQ2jqEeuYwZZaIYYEkWTDxL4N53+TXmT3IT1wYmH
	R+LlQDxGAyFlfDxFA0bYqd6co6sepBdIoMMJBitHNe2/1Wh5ln8z5g4e3LpF7nZeOVq+Kl6fJs+
	wTlbZrMVgohN7YYvm2gIS4AisJhtMa8xVZ9H53Q==
X-Google-Smtp-Source: AGHT+IH5D+dwNFzazeUh/VWyn8U1gEindORW7ck2av5wi5lt8qVy1Ge+sB2vfSSUy2KP0wd7wAE9dEKJlRdpubN7L6s=
X-Received: by 2002:ac5:c8b3:0:b0:4c0:3ac7:5e83 with SMTP id
 o19-20020ac5c8b3000000b004c03ac75e83mr815519vkl.3.1707141259423; Mon, 05 Feb
 2024 05:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-7-brgl@bgdev.pl>
 <ZcDRuRCT9xE48cYi@smile.fi.intel.com>
In-Reply-To: <ZcDRuRCT9xE48cYi@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 14:54:08 +0100
Message-ID: <CAMRc=Mc5=p7tp0r8-MYiHRJ1yXDJLW2Uvm5C1CyoGBAcesdZug@mail.gmail.com>
Subject: Re: [PATCH v2 06/23] gpio: add SRCU infrastructure to struct gpio_desc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 10:34:01AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Extend the GPIO descriptor with an SRCU structure in order to serialize
> > the access to the label. Initialize and clean it up where applicable.
>
> ...
>
> > +     for (i =3D 0; i < gdev->ngpio; i++)
> > +             cleanup_srcu_struct(&gdev->descs[i].srcu);
>
> for_each_gpio_desc()?

That works with chips not devices, we'd need to add a variant for
gpio_device, but see below:

>
> (It might be that the latter should be reworked a bit first, dunno)
>
> ...
>
> > +                     for (j =3D 0; j < i; j++)
> > +                             cleanup_srcu_struct(&desc->srcu);
>
> What does this loop mean?

I open-coded it because I want to store the value of i to go back and
destroy the SRCU structs on failure.

>
> > +                     goto err_remove_of_chip;
> > +             }
>
> ...
>
> > +err_cleanup_desc_srcu:
> > +     for (i =3D 0; i < gdev->ngpio; i++)
> > +             cleanup_srcu_struct(&gdev->descs[i].srcu);
>
> As per above (use existing for_each macro),
>
> ...
>
> > +     struct srcu_struct      srcu;
> >  };
>
> I am wondering if moving it to the top of the struct will give a more
> performant code.
>

Nah, that would be strictly theoretical. It could matter with
container_of() but not with a simple pointer dereference.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

