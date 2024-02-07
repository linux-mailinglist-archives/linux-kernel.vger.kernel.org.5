Return-Path: <linux-kernel+bounces-56474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AB484CA9A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD710B24458
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BA59B76;
	Wed,  7 Feb 2024 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fCFXyLqJ"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5B59B74
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308391; cv=none; b=nom8oJMb8x439CUBvgwzrMfhsT36LEWuTF/TzJ+PiQiy3KkRnEPcdbLYwQgt3R6dR0PMFNi/zYESaB1KQPtflFrwZUngHMGQFOfzbnK+Lldxz6W0SAIR6+2lwUOC7P/5ysTIyGh/M3AY9TabzgQj8wM9qzJAHx1l1pUviMsQ7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308391; c=relaxed/simple;
	bh=lGAcMND2NaDdmDU9b141DrAfpaiW5UmgS8bsTQ/HMhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUkMXYGx+GfW/Ydl1+IOWNEk0a3zgR/8urLHq/U1SpIcaNSlialZ2PEZDY6Ixip+5PaZ0baW7HPPj8kxokJP6Z2XdC897D4HeVHiB8km3b6zAZxzcDW35V4mD5k6GMwtmuMuKOUkt1B7apG9QBMuV/4aQYC8/zV561XLGDFgEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fCFXyLqJ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so251610241.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707308388; x=1707913188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEPUwWtoIq4EHAceeg/KJzDbLqtV6kKvWuN/Pm0FSrQ=;
        b=fCFXyLqJbXzGZIT988peHJyVmc6Qe4Pnuk9kYAl6+RXSbX91XtTblayHJidwX1AFoo
         0i5nHfSPWLLhxn44aInQuLtO+HkzIQRnPnVEbn37N6Md/Qs/lDotvuYRIgqQyb2N5NAn
         emkdOa1vRcBwy91C43hENlGEB5wgJdm8FBXnv1/mzPRLZC5Odha6Jk3TxH9y0F1aM5y3
         szqAgyni1UwhVyd4AlvC3ZNwWl/A5+wOwmGF9Tt8pTz1Ngcr5DOQeyWEpBGjb9Z7bAga
         NvPBGzhI9x1d0Q4JpibsEjwuY9eSEk/CBf1F3sxmHsuZobVE4j56RpfzJ2l9leAbRBLW
         IFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707308388; x=1707913188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEPUwWtoIq4EHAceeg/KJzDbLqtV6kKvWuN/Pm0FSrQ=;
        b=fjh0D+7RTy0th6Jx+BxfJN8xvEvBKUFMSkbooHD5U9KYbe15pYfGbhJdPrUmFzE6Qs
         8QUacNKcOI/pm+ymdiLkIWA46pPCaiaFL0GhQ2ns3fNFlta+Axnf9jPMsUjnYy3h96Ov
         s280aUmSKVIe/LACbdL2lf0XyqNdn1yIVssPURCp6uDc24bkOtIekmkLM0WEIxYnHQBC
         0uEWEVXgt/Q5tTAxQTa7p+xYaMBq7tLj9XIt284NapifwZFsgN4jaQiF2r8EQhbJRRvV
         QSVtaKf3PexMaLqgKEwO0SlWySVcNwc4DmGjxu8n4vNdxPUFV0QLDn5TCmGvfzG3R9KW
         lH7A==
X-Gm-Message-State: AOJu0YxvFH79j+ohPPvX+LwAJGt2BaGXzbzhf1afRkPWr5z2a/yjTKZy
	CYgX5tCXKa1wztkUOXZs2G0Ks7+SWGLdrmuH0pRYJqk6AILfA4Aw+7OXOxvG5AEtpyqRv7cYmPb
	29FhKX8KqTHUkV9L5sbTrxNVBxlG1P48tjA0Rtg==
X-Google-Smtp-Source: AGHT+IGn7YFHyXZ8ClynY1G1aKTCs/KL7ktljkC1ocYeF/oqDMUfq0IduSYo2+RYfwQpVbIezMdJ8iVYR0bQgyd/Fvc=
X-Received: by 2002:a67:cd95:0:b0:46d:2fcd:3522 with SMTP id
 r21-20020a67cd95000000b0046d2fcd3522mr1973497vsl.22.1707308388173; Wed, 07
 Feb 2024 04:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201162758.50733-1-brgl@bgdev.pl> <CACRpkdbAw5NfSr8GSNiQhOzSi-tERyn=-ZroLfF-FRbsW2JviQ@mail.gmail.com>
 <2024020732-duchess-husband-8b1b@gregkh>
In-Reply-To: <2024020732-duchess-husband-8b1b@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 7 Feb 2024 13:19:37 +0100
Message-ID: <CAMRc=MeWD-4xx9Y=P3ajO37XJAsBrZ2TyqNeCE8vkxXW1yXWVQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: set device type for GPIO chips
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:49=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Feb 07, 2024 at 11:45:39AM +0100, Linus Walleij wrote:
> > On Thu, Feb 1, 2024 at 5:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > It's useful to have the device type information for those sub-devices
> > > that are actually GPIO chips registered with GPIOLIB. While at it: us=
e
> > > the device type struct to setup the release callback which is the
> > > preferred way to use the device API.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > (...=3D
> > > +static struct device_type gpio_dev_type =3D {
>
> Can you make this structure const please?
>

I have, there's a v2 on the list already.

Thanks
Bart

> > > +       .name =3D "gpio_chip",
> > > +       .release =3D gpiodev_release,
> > > +};
> > > +       gdev->dev.type =3D &gpio_dev_type;
> > >         gdev->dev.bus =3D &gpio_bus_type;
> > >         gdev->dev.parent =3D gc->parent;
> >
> > Looks good to me (TM) but we should run this by Greg so he get the chan=
ce
> > to chime in, I doubt he will see it on LKML.
>
> Yes thanks, I wouldn't have caught it...
>
> greg k-h

