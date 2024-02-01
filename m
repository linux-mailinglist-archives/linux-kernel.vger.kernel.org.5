Return-Path: <linux-kernel+bounces-47838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE8845386
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D8528ED36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9C15AAD5;
	Thu,  1 Feb 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="he4ttPdG"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97E15B109
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778859; cv=none; b=BdF1a3xr9Ns38e4GejW+KtswSoShmKDyFdjkx8YnlA09AskQnRg3O//GaeEJUdI13s9VbUAtAL0vnwRd5DKXCNK22aJSzW/QUe4AuK6nGM2Jg60ufQvK9rz7lWcM721nwcCRdfr1rsUJhRm7yiT60JuE38OJc87lO/HvEmAIP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778859; c=relaxed/simple;
	bh=yDXrbp855wVPNQCVbu3gBpaAVyKIZnAfba8LENbTSj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTx2mJPyhtL/rJ/mzPz1xz4JFlRWsq9WAyig2eE59xOm4Xmrqw7x9V0PLMaAHBheEMOXDOd7xqT1bsUbD6hGC28jVrhxnCXoeiZXzoXTxCWGZhPmExLtNH4nwK330XNf5+YNG29QooK1QSsTNVh5v49hrkDk3nomBWMCEMZMIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=he4ttPdG; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46b1a355f5bso241168137.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706778857; x=1707383657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2M8CObh05KFyd6vJfEPgy2eG/m/Dqz0MRtnX5ztlp/Y=;
        b=he4ttPdGGZIfOPhJdwzobV6VRX1EJsgUhwtXjbTNTClqFEnTf12XN6t9mx+O7/YgSq
         Ax/FB4BMvs0Z+W966Jthxhz1fOltCmKA260LwT/ztgLvQfRuqfOaoibHiloPGJC+pIU7
         oAQ9ej3FRpn7I9oIFrSK+ctbZu+dlPzV5FnjwSkB6oe45My/AIejgoZv1BobJNUDonRS
         c/JVJQu7aHutV8zsUJVSJFi53SNOeDqETCjMbbmr57XICd3ICQlj0abpGdhxPkwOZfd2
         YuE9oYnOJgDv3IUYZJc7vrofbF3oxiMIl0DasqsFNnO8p8ma120r5wDPmjiV2shW4o3+
         +8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778857; x=1707383657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2M8CObh05KFyd6vJfEPgy2eG/m/Dqz0MRtnX5ztlp/Y=;
        b=TBm2nmTiKEjWUrzycMO59tht1i71++sg+9dBCjFMRbFyD7sWnrqraWVHoTDZX7cT0+
         iJrPFcM2s6EBqHy2DiiuLTt2eLeN1TNF0l7smSMc2k4UcXT1oFTAohF+UmrgdwwJ4Uew
         u6BjJ0Hc/z2CJVOtQ88vfBL6a1oUHthCT1Vfjf2GxCnngSIalp8JFzbM/x8UM9l8bIcZ
         TPOEYEaYzTZg/Lmp5vbZfCXGo7u6iSlP2KTfMlhElm94Ffs+mawiSS/QEQ77vtnS6wfU
         yOSmhnM0UOgALOy+8RjZi8I6KPV0E9tzkkc44E4x1ndoytyZk4RqvAr3/3yEqllphYLP
         t9QA==
X-Gm-Message-State: AOJu0Yzj2nXNOjTVasSHE0j100oxJHXuyAfPeUpvH5O45z5ZoG5Yn/CN
	ZdpnARA1UK2HVMvNDmLsaSY0NhQ5JpaIKTDp9TIIfnP3utKnx4PbJ888hhbIT4eibEFwoI5dHCr
	P8YUjWsQcHfLcNdNRVp8zFAFpe1299XkmfjhciA==
X-Google-Smtp-Source: AGHT+IGQUmbskM6uPy1OXP/tccwvL9fBXlAAuj8OOS24NtA0C5BxChgK5gpd9MTLg2EjxRZ6b9IV8vH5aZ1X3SA4FiM=
X-Received: by 2002:a05:6102:80f:b0:46b:ebe:c24a with SMTP id
 g15-20020a056102080f00b0046b0ebec24amr1250558vsb.30.1706778856803; Thu, 01
 Feb 2024 01:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-23-brgl@bgdev.pl>
 <CACRpkdaZBMZX5=ygwG0pxbZHJ80w4Z=9-zJ6zV0P2rWXajxP+g@mail.gmail.com>
In-Reply-To: <CACRpkdaZBMZX5=ygwG0pxbZHJ80w4Z=9-zJ6zV0P2rWXajxP+g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 1 Feb 2024 10:14:06 +0100
Message-ID: <CAMRc=Mdz1aBSc6sxe5L0z=8R36O6r6EfJ_ZoFWbJzUv44V9p2Q@mail.gmail.com>
Subject: Re: [PATCH 22/22] gpio: mark unsafe gpio_chip manipulators as deprecated
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:29=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> On Tue, Jan 30, 2024 at 1:49=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We still have some functions that return the address of the GPIO chip
> > associated with the GPIO device. This is dangerous and the users should
> > find a better solution. Let's add appropriate comments to the kernel
> > docs.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I'm not sure it's very easy to find a better solution for gpiod_to_chip()=
,
> but perhaps also add this as a work item to the TODO file? We can certain=
ly
> try to get rid of <linux/gpio.h> before we need to look into fixing this.=
.

I will get to revising the TODO at some point hopefully.

>
> gpiod_device_get_label() should be easy to fix:

This is gone already! Check v6.8-rc1.

Bart

> linus@lino:~/linux$ git grep gpio_device_get_label
> drivers/gpio/gpiolib.c: * gpio_device_get_label() - Get the label of
> this GPIO device
> drivers/gpio/gpiolib.c:const char *gpio_device_get_label(struct
> gpio_device *gdev)
> drivers/gpio/gpiolib.c:EXPORT_SYMBOL(gpio_device_get_label);
> drivers/pinctrl/core.c:                            gpio_device_get_label(=
gdev));
> include/linux/gpio/driver.h:const char *gpio_device_get_label(struct
> gpio_device *gdev);
>
> We only created that problem for ourselves... It should be removed
> from <linux/gpio/driver.h>.
>
> Anyway:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

