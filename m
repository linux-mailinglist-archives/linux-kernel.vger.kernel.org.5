Return-Path: <linux-kernel+bounces-58607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42ED84E8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A20D28E770
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635237152;
	Thu,  8 Feb 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MeJMWp5q"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0936AF5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419848; cv=none; b=BJBMt+8mACkGNdLnw7xLTG2du7pcio/hFrfqSCRwxJr2vjhx+O6eRJ3en/ueeauAALCAYgGHZSehvKgq8qSuQZMq+ocmKYU7sE23WNvAcBobgck53M699qMNUGc4npNNPB+Xn1brHFr1hUFoxKVi8PCe+/j+XqJZpbG2askAxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419848; c=relaxed/simple;
	bh=9UoBOpbhu6eV2y4H7sdW5gvSf3svH9MoKhKbdBUQGAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXbu02Dj0AbC80iB7nkqJIAn3jAARDe08he6NDtGAjuuojwOqrAY9Ea5m3TD9hYVuHbqtTA24rtncCSpR/o9nGmjVr755HtW+RDHRhBLm58ITQT3zyuza3pjLUh/dgqSDCsVjZIYOR7W6Ea9DdQqAKbyuAiiSMpBHOM6PzujBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MeJMWp5q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso153538276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707419845; x=1708024645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtXydcUrYcRHvyIMxGgFSNKHU7B+Ylsdr0/kUFS+KNE=;
        b=MeJMWp5q2U4P6ozyPu694UmQEyyNMlk/8uhRQsdliSAraxCtSu6ODQjNCuPUKhzDyZ
         FiAJymeQ5XLDlwZr9qH3a0imGINyLIw6xz0eL0OBkchb/yUlxhMQMECTR/9LNnjWd0pE
         GcyGBs3psnV1k6ms9c+hpCKL5pSTgmCA7ARgtVO+B8HSZOy2pCEoWwOIzou67jraOutl
         1hanLY8qsWRItCfkoL0QaHyFd8+ccsmtQBtKOqWbWDl14dzNcFMG5luMBp7QyGj3g+fP
         9IyCdU26AmQObywGSPcqAQiASYGLeJFzO5EuJ6AXn4e9r1Rarp8S7X18K88cYa7rjXMC
         CpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419845; x=1708024645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtXydcUrYcRHvyIMxGgFSNKHU7B+Ylsdr0/kUFS+KNE=;
        b=ttiaTXx1QicTl++BQWxzFiP3K4D7xnAYsDXMNeHDIzmFaQ+jYuQERCPpjk5rH7O6rU
         UDWSlQXXV+4AEK+z0kV1EVm3EHOYeYOq4us1qCDL2rBrr+hvjGqKLYAYUAyKL1ZMdf57
         WcRQWME6pO9GU7Iv0j21Bm7l6NvMJvm2og5NYHJzOVZzbyR3elDQ0A+rlzYe/b+kO+Pa
         v/F+KjwqqOvs6Z9mGlvw6+7uWP8i6cMOy1w/CyuhHC5RbBsASWL1jNexnCPhprlHv1lT
         2cvHSs56+pwiLwxA2CRASGOcqnr4HI/6ZXSv50F0Zm69WkoT0QMIL/70XsdM47q7uLiM
         7sZA==
X-Forwarded-Encrypted: i=1; AJvYcCVlBO0WX0vEfM2hxRJClvwCD7vn6RAuilW6bL/glGmJ7wPp6xCOzlTc2elKp/htHhCPZ19Sqj6WrVScm/YqQlNEZogHg+CpnOue1Qk/
X-Gm-Message-State: AOJu0Yz/WEl911488mwe3EIw3+r1crxb0IqpJdqK2I09uH/IcxLdc8/2
	yo0RJlyadNkD+yFN6OSuHbSE1ChV2IjWpR554jUTqERiRifKR0frf+Z0gRRQWbeS/PmIVo9/zTK
	nG52/cEmxEEpmIghUnS2Yxux0v8bh/Qg5D27tKQ==
X-Google-Smtp-Source: AGHT+IG84ooN06FJ9VL6zD13n18pXA6f/HZwrVXzaApnmbUPjN9NZLwKVvv8AHc3zTz9ucWQ2V1kc1FFV35kgMLdHEo=
X-Received: by 2002:a05:6902:2402:b0:dc7:43d3:f8ad with SMTP id
 dr2-20020a056902240200b00dc743d3f8admr506111ybb.17.1707419845567; Thu, 08 Feb
 2024 11:17:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-20-brgl@bgdev.pl>
 <ZcURtLZoEftBDpsy@smile.fi.intel.com>
In-Reply-To: <ZcURtLZoEftBDpsy@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Feb 2024 20:17:14 +0100
Message-ID: <CAMRc=MdaxrjKVoBe92ci+4U-VbxyuxMVu30-m2E3My0k7KN65A@mail.gmail.com>
Subject: Re: [PATCH v3 19/24] gpio: remove unnecessary checks from gpiod_to_chip()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 10:59:15AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We don't need to check the gdev pointer in struct gpio_desc - it's
> > always assigned and never cleared. It's also pointless to check
> > gdev->chip before we actually serialize access to it.
>
> ...
>
> >  struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
> >  {
> > -     if (!desc || !desc->gdev)
> > +     if (!desc)
>
> Wondering if it makes sense to align with the below and use IS_ERR_OR_NUL=
L() check.
>

Nah, it's not supposed to be used with optional GPIOs anyway as it's
not a consumer facing API.

> >               return NULL;
> >       return desc->gdev->chip;
>
> ...
>
> > -     if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
> > +     if (!desc || IS_ERR(desc))
>
> IS_ERR_OR_NULL()
>

Ah, good point. It's a small nit though so I'll fix it when applying
barring some major objections for the rest.

Bart

> >               return -EINVAL;
> >
> >       gc =3D desc->gdev->chip;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

