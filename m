Return-Path: <linux-kernel+bounces-52703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC7849B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FA21C223EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E403C1CAA4;
	Mon,  5 Feb 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fYTEw1bj"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04541CAAF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139164; cv=none; b=d5LSZ3gRteyA1wKMDIgkdfpbpm4NoNEDd+r+YceudCLyr4iEFr2bCdcAmN191/NJFheLBMp6fU/u/2PVD//UyLLAq5PCJ9xXM903V57y6/jEqy/V5GW7Lqvpb/bH53CWdcKq2u6QriA/7z/PMBxHg/GwWWJ/TvZ7DZ5UGa+MvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139164; c=relaxed/simple;
	bh=Fn6KL2JTPAj/e4KKkofC4gbvxxwy/f7JxudlnSWfDtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8fIog2eNxg5k+R9ayPF/04k03dOedzOrdDXS6d0F+kaISMPsi3cO5lpeI/4qf5fK5VDiJGYSdyu1igJMWfi93xOprrqGoAh92Qjml3IKTdP4vbgXeeUtS+7SG1oMOxXRiS11QDZV95TdkKTtaFA7oyfESZwJJbZOsiw8leJggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fYTEw1bj; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7ce55932330so1668020241.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707139161; x=1707743961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrHNnU3Wq4ZTy5xDNrJlo+hjA5lNxxV9AGI7mRzwXKw=;
        b=fYTEw1bj/+n7yICtj5aoh5xIK02EqxZ5gXsRODM3r0TQBfPQFO2wL0hdCTQRuLDQXK
         hqi0eT1NP7z2/GD8nkeCGZ3SWgdLle+OG3q7AxsdDqDS6D3pfxMqaCdVC5Il+3CNuupB
         lozH3RqWL1H9INqvim7cTTuRpCe2QZBCHJjxiRo8y+FZDOYHi/h3Vrxzokz0wdYo3/xq
         RTb/BDlFQtwj/O6SANbSQGJV3u5xAL+TNO5TvJ6+9KSsdINNX5P7DV4FmyhDTaZsKy2W
         ErRCyxNru04hmNdgFcvGtfHUikEOPIm5n/HJIlf+N4utKY80t8bV0Ccrssjm/Jvr39UT
         X6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707139161; x=1707743961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrHNnU3Wq4ZTy5xDNrJlo+hjA5lNxxV9AGI7mRzwXKw=;
        b=cyd1YJCTKmlL6bzQ7xOJxeHUPwDZ0zu/sHYkKopXyscbs0dujf7vzutYQXxBjfqRp1
         FvKcfSRYi9ROOA8vP6yaJOjn6y/G1INV6LOkZNMt5LPYLBZzq2pgZiOtxw+HHgxD7U/f
         Hk8Vkl/sFoSlLZhr2fwVq1KyTeMkd4gTf4EpBUPxKtX+hxMhNcpfsm88VbhKTpyxfGHf
         2YqRS1C5oJKce6M9HVbke7leANwmTwsdIkkoSNsXKeWa5ALFQJJuheffy5Z9j78W7FtH
         59jDGe4v6dDNxpHI/nfgf9ZpmjtaMgbvSb7x6z64tyMcroysmm/3NVRpCQsDilE4WvIZ
         sbRA==
X-Gm-Message-State: AOJu0YxaOXJCcUMNqqU/r17KrccGV9dxjVnr79ZRhHEqx4CTXPFQeq/v
	ocSmVtmp8Mb6FeXimkcTx1KR3v1piJTdlmE6HiVMljqPdR3EB5eRJRv+zuI1xZAupLcJ7BU7pYY
	TsHNPcapiYR/2IWQqVBfQQmBPo3LlJ5MJkgNB+A==
X-Google-Smtp-Source: AGHT+IEKshpX8Kr+OhNuqCtyKE/5n8Eu2SoYHsTR0GJw+Ecu92RizEDFbZujpESpzwC14NCZkTnnFpOkTUhVK0UErBY=
X-Received: by 2002:a05:6102:9a9:b0:46d:263a:4102 with SMTP id
 f9-20020a05610209a900b0046d263a4102mr1364233vsb.28.1707139161432; Mon, 05 Feb
 2024 05:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093418.39755-1-brgl@bgdev.pl> <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com>
In-Reply-To: <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 5 Feb 2024 14:19:10 +0100
Message-ID: <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
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

On Mon, Feb 5, 2024 at 1:36=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > With the list of GPIO devices now protected with SRCU we can use
> > gpio_device_find() to traverse it from sysfs.
>
> ...
>
> > +static int gpiofind_sysfs_register(struct gpio_chip *gc, void *data)
> > +{
> > +     struct gpio_device *gdev =3D gc->gpiodev;
> > +     int ret;
> > +
> > +     if (gdev->mockdev)
> > +             return 0;
> > +
> > +     ret =3D gpiochip_sysfs_register(gdev);
> > +     if (ret)
> > +             chip_err(gc, "failed to register the sysfs entry: %d\n", =
ret);
>
> > +     return 0;
>
> ???
>

Not sure what the ... and ??? mean? The commit message should have
read "... traverse it from gpiofind_sysfs_register()" I agree but the
latter?

Bart

> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

