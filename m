Return-Path: <linux-kernel+bounces-52748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C0849C37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D61F24D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881BB21103;
	Mon,  5 Feb 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vPeRUGtK"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABB24A09
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141031; cv=none; b=AaaHgsFHJeAuO82YPyhCTXTBXFql4ocOfVChEgEJtZkPMkDOAGxc3Nsh0AvtDQg3Nxgs93A34opH4I0Qt0gElPXj3lYoXPzkDBwikhWWFf1dbY2Rxj/vr18wESLUmUE0Tvap7AjuLV3MuCcDaeIJImaYo2XZ7LRy+v7JZ4lSD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141031; c=relaxed/simple;
	bh=uQHSh01R3r1EPWAZ6JISTuOzTtdMjS2Jd4bfXMKyfmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFF6ixDm5psR9Z2ajzcBKXx58brkn/gVWJ7sNGMzCGvzBhT9B7nYn2k3o/H7QEikwsX+b80oopJFxR8SGTBZZU+i297iLiAhp/tICusaBsX0IuSRz0sbb9je6Ki5FXV6ea/Ecn6fVDCb3d9y2M5GXDQWKe4EzOecoSWemaiFkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vPeRUGtK; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d130979108so1692389241.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707141029; x=1707745829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLjPCWazCIOmtsuGf0hWeVlU2NTtNWdlcmPU/F3SHiI=;
        b=vPeRUGtK6PYYt8ukVwni+RgP/TCBEUOeYiPeK4rx6Yt3ArczFx69BEZFFV8jLWIcDi
         //cmsBxW+3EqhTwjpvj6qahR2utfanxcZTYDDoElgVHKIimgI1yTkPX5JkNI3OZUp9yt
         YnH44Jh4G30WSqgGq/+IIThLEAcAgHnzEHC3RotCmBkNfsaKex4fqFbUc+9Wet8ZuejP
         RLHTXppxLHp7KeqCgWf7uIJXxLWBdH/aTkI+GSq47DZbGi1VZFcQCjamz1RgELj/3eO7
         3cvr00W3PcufoKuG5S4T7j2Zj8RWxZkIHaAlH15HtohI1YO7zXUIDFqCK0X1RNVZgSsy
         m1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141029; x=1707745829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLjPCWazCIOmtsuGf0hWeVlU2NTtNWdlcmPU/F3SHiI=;
        b=RmY3J46zg/5g7rNGKewvMFTF+5kZKij1UvtpX8spQMGk6IqwoYjv6IVLJ1eJTAmwWX
         dqMznpz2zsUmo1Pm2xMEWAK69llzoKG0JVk2a/bCedd2iBu3VkYHJ9aBi6fL5Pn/E7Ux
         mfSsSRTOk8QuGPl+T/F1kZ5iDgloilCwx/T51c+mt+T7iCS70Xj3fc7nXuCrKMULC/3C
         zeAHfkwYCymlKbUb02dsQBl2VmVA4T45Ma0uYpPwE5NnmhGQUIf829xeqTSYiosykRPk
         0aCNfc46s3L1qdHyFpqzY1RyXyanarwHGDgwxGDzvfaf2UW3JorcNZJ9+/RqJr1/zm+O
         pC1A==
X-Gm-Message-State: AOJu0YxLlqYRNsiHQ8om8w1TbGdHU2uYEWLnbSZGRa9+uZhfjqWYjyvZ
	9FOiga7CihcfoF4V31S1E759c0yhx+22BthKGYstsrql7lS5YGS8weVZENVoHf9FQCrEu6Gq1j8
	nDjC09+qPTR+8U4roK9Px6pMZ3/2BVlrvC4u/JQ==
X-Google-Smtp-Source: AGHT+IFbbX1Pw+Ix7UggXSBkycALG+MWTAAHXhpFy3y5b1VyVxnQ7NYW2sal3BSdUhxznfA/b119ar92D5JE460dGyw=
X-Received: by 2002:a05:6102:9b8:b0:46d:2e77:c58b with SMTP id
 f24-20020a05610209b800b0046d2e77c58bmr2034158vsb.22.1707141029194; Mon, 05
 Feb 2024 05:50:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com> <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
 <ZcDkvOrlSRkmYIk_@smile.fi.intel.com> <CAMRc=MeiXLZ4q8MH5h_wX1rBz9-YVK6UKUdCu2nTb6+uNHGXPQ@mail.gmail.com>
 <ZcDm3ZrW1dQQAroY@smile.fi.intel.com>
In-Reply-To: <ZcDm3ZrW1dQQAroY@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 14:50:18 +0100
Message-ID: <CAMRc=Me+ETGfgjgQV+SSZenLW5MeNLVSrFKBhs707FDEqEHFJw@mail.gmail.com>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 02:39:40PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 5, 2024 at 2:38=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 05, 2024 at 02:19:10PM +0100, Bartosz Golaszewski wrote:
> > > > On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wro=
te:
>
> ...
>
> > > > > > +static int gpiofind_sysfs_register(struct gpio_chip *gc, void =
*data)
> > > > > > +{
> > > > > > +     struct gpio_device *gdev =3D gc->gpiodev;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (gdev->mockdev)
> > > > > > +             return 0;
> > > > > > +
> > > > > > +     ret =3D gpiochip_sysfs_register(gdev);
> > > > > > +     if (ret)
> > > > > > +             chip_err(gc, "failed to register the sysfs entry:=
 %d\n", ret);
> > > > >
> > > > > > +     return 0;
> > > > >
> > > > > ???
> > >
> > > What the point of function to be int if you effectively ignore this b=
y always
> > > returning 0?
> > >
> >
> > Because the signature of the callback expects an int to be returned?
>
> But why do you return 0 instead of ret?
>

Because we don't want to *find* a device really. We just want to
iterate over all of them and call a callback. Any value other than 0
will be interpreted as a match. Besides: failure to register one GPIO
sysfs entry shouldn't maybe cause a failure for all subsequent
devices?

Bart

> > > > Not sure what the ... and ??? mean? The commit message should have
> > > > read "... traverse it from gpiofind_sysfs_register()" I agree but t=
he
> > > > latter?
> > >
> > > I didn't realize this may not be obvious :-(.
> > >
> > > > > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

