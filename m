Return-Path: <linux-kernel+bounces-47092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C60844901
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC541F23455
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE3720DE0;
	Wed, 31 Jan 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMAsZ8uK"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4F1EEF7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733335; cv=none; b=blQo6lrd/8YTS0tyEyYGMQF4+jao7gaKGn0HghQJW02M0HDTE47pp1NzL5pxMXsgD+1EsAT9gNq+aC2ad9/iLH4FUSso+nOfLhAZRTUG9k6w2gUm200MSjTsRERWwhkXuruJxkCT7ZY7rBAq31ZiSGXGKXKJf4KWaK9ZoVFtoqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733335; c=relaxed/simple;
	bh=4gg8MbtxuOETWbvcXiewSjW4cU46Po/YgSI564WePkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQVDCfE9Z9hVGhY1IOkP6dFKG+xlRd4v9/bAxJOhMKI2tu0NU4FajVksSHUZrPXiqkrNU/gNjaDEZOnKJZpG99hYuiSSCotiZA8qvUjdm2aE32WbfXpN2STGYbR1GbNA6SzH0SkkjitGa0cnhi3/hd71obqQJu2/GoJaphE9ayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hMAsZ8uK; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6c3902a98so132381276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706733333; x=1707338133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMfiUtPGMigs+21v9CDoWEN6MSzp/nh2CeG2gULaMUI=;
        b=hMAsZ8uKkL8vao/AhE9ePytRcSf6il4JautAGzPkr7Szti/By/qaK+VHWsvdLRkO8+
         MABkeru4f2M2KyDnjr+46lXhGENLdHPN8k6yZBcvF9gweBCcv9u2veaj7lpi9+vWpAvg
         dUZnlWod9ZsjIyZehRAUYmCjzLBdXTnFk3Vh1Abml5fToMv4HRQIp5WdJnfM8vEhVDJK
         //A5I7XdcX/F7Xet6Wv79T3868HUySBczb5kIt106NqQUkU6KsSBLJBtYhxaXAX1646c
         A2cJdpdR0/H57GZKM3/aTsfbuAbY6k8T+imp4CHDb6KOj16dXlBp1M5nygOIpOXnEmOV
         OjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733333; x=1707338133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMfiUtPGMigs+21v9CDoWEN6MSzp/nh2CeG2gULaMUI=;
        b=VQGb72Tb5E8mphNpzX/Bk1c3y6TUP7GHWcY6oYL9A/MDnqggI/NyG6vkd3kWgf/3F9
         EkDVtsk4XMoe/6aEVyGDXNqKOernx/Uju0V/Mo+zopdOjvMoHVEMvFyQECU5C8l2Miw4
         3Sxty3qq6giebrv4gUMYfEHDIKxZ+5lQGsmLqoYTHkSPQL2CJPxs334KUtJ5LfcW7PRG
         APmVPDicHdmIP6zAKpSZ5PbEnl7Cdsb4nzVxRIW4NuMGwaAmF06G8H+g9m/CHjvyIkO/
         RflJYt6Uc/dWRgGreTYM1S6MNP5MhIisGI2zD0Gr6xbY/bTgyRICKZBEKFtjQFBKESN3
         hSMQ==
X-Gm-Message-State: AOJu0Yxd1eAPovPKHHJveK/ZHiA8306oa3KZvgdby8OWPYfblO1hqB0Q
	993pQhb7DW3UASlYmW8ht2m2s40fw/0GXRL48ZB5wkGfBqcPwY08dx8wDDwI6FApNoBkHjqmo8I
	A6UPVyMl8ukNhTDsp6HufeGos4Fs/agC0JWfT5XVxRTjts4CvYlo=
X-Google-Smtp-Source: AGHT+IEqJ9sBaBkXpIaCG+AofpCmulz/CZSXwInm0MfNy+ZLOymRBzmQmyfpCyJag/wOVEVDYnjEaZEc+ygMXSysPNA=
X-Received: by 2002:a25:bdcb:0:b0:dc6:4b0a:7b35 with SMTP id
 g11-20020a25bdcb000000b00dc64b0a7b35mr266792ybk.12.1706733332939; Wed, 31 Jan
 2024 12:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-11-brgl@bgdev.pl>
 <CACRpkdZyaqwbxvsLtXPHSX=6jyFPYSxA9n+qWakdhGKmo+L9fw@mail.gmail.com>
In-Reply-To: <CACRpkdZyaqwbxvsLtXPHSX=6jyFPYSxA9n+qWakdhGKmo+L9fw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 21:35:21 +0100
Message-ID: <CACRpkdZ9M=SapefrMX24=H5xGG91FNMN5TS63n3GdpegS_JAZQ@mail.gmail.com>
Subject: Re: [PATCH 10/22] gpio: reinforce desc->flags handling
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:01=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
> On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We now removed the gpio_lock spinlock and modified the places
> > previously protected by it to handle desc->flags access in a consistent
> > way. Let's improve other places that were previously unprotected by
> > reading the flags field of gpio_desc once and using the stored value fo=
r
> > logic consistency. If we need to modify the field, let's also write it
> > back once with a consistent value resulting from the function's logic.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> (...)
>
> I have a trouble with this one:
>
> gpiochip_find_base_unlocked()
> > +       unsigned long flags;
> (...)
> > +       flags =3D READ_ONCE(desc->flags);
> (...)
> > +       if (test_bit(FLAG_OPEN_DRAIN, &flags) &&
> > +           test_bit(FLAG_IS_OUT, &flags))
> >                 return 0;
> (...)
> > +       assign_bit(FLAG_IS_OUT, &flags, !ret);
> > +       WRITE_ONCE(desc->flags, flags);
>
> I unerstand the atomicity of each operation here, but ... if what you wan=
t
> to protect is modifications from other CPUs, how do we know that another
> CPU isn't coming in and reading and modifying and assigning
> another flag inbetween these operations while the value is only
> stored in the CPU-local flags variable?
>
> Same with gpiod_direction_output().
>
> To me it seems like maybe you need to actually protect the desc->flags
> with the SRCU struct in these cases? (and not only use it for the
> label protection then).
>
> An alternative is maybe to rewrite the code with test_and_set().
>
> But as you say it is currently unprotected, I just wonder if this really
> adds any protection.

After re-reading the cover letter I'm fine with this, but I still wonder
if it buys us anything.

Maybe some words looped back from the
commit message that we are not really protecting the callbacks
because access is [predominantly] exclusive?

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

