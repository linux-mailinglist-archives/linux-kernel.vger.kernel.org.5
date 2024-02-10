Return-Path: <linux-kernel+bounces-60369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3127E850417
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA3E2860A1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDD36B04;
	Sat, 10 Feb 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MSHE69aY"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92821376F3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707563273; cv=none; b=pAVqAmc24JqPuOFw2mrJVtqaYjGOfMXGPIwseIZEmhb3MqasE5U6Wg0wm57p5VSFQeVrgmj22UlGTzgp5XVyBn7vUNOcEJUlqcgB5bXA/2qCA5IIaDzyHDM7pAZN1e0OwZwoXVJNUyvieslLYXuaVJWrqGxgKMafR2zLKJ1oeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707563273; c=relaxed/simple;
	bh=ctXQBo58n7cMBYn+bE4PgohJoraE6MPOMpZUkB7Qw5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BM8netvpHYBNqpc7T5Xd2bX6uZ4nrOqx+Taj9xrP3K4P05n6p5IJzYvQxVYA6TrjauzF2SaqPiBvvnidMf2rLUl46byLcVp3FSsm7+fdxlx2UWDndmi3SqLij6SsnfTmKqclfbw94Oou5QVvp96pdHlCjIsNg5pHlxOr0W9rHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MSHE69aY; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso586423241.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707563270; x=1708168070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsm2tEPYKEgW6cEX68WW3Yx7RVgTbGyckgrh2z8CJ7g=;
        b=MSHE69aYn8sHF31C4u5m61AHQM7cRVNvB8reYX70GGfCiRvZs8Oe43VxEsW0PtZPHX
         Kkp2nOAKFGeuSiOr1/tpS+UmcmWtTAdwixN3A74tPM93ZhUJ1c982yM42Nl4Vtb0Ahyf
         88Gn+ejrqK5+GAvZOSDGZFYtIdf7LKYNYt+3g6w0XVr4w/hgEac453JmIx3oyoKMWObX
         StSmpWyuRvQ7pNgD+VUzhfdAOBetxblvIA5UYr+ebYXyK1mh/DFxqQbWGd1wSMcJmWJY
         YBdQ6qB4AkToOF+azYeq8GXz0Oyq97cB4b9iT0zD2AND/0RM+Fc1wnRIepmTAfxOjIZ/
         DQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707563270; x=1708168070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsm2tEPYKEgW6cEX68WW3Yx7RVgTbGyckgrh2z8CJ7g=;
        b=HaXHZ4ZeRiLn17kA0CTa0q89WV6lVJO66UJ+nonPELOpX2DUHuhYaBpoK0LkF9S2av
         /dirk4j8ZDoWcLfKzu8eLROZVPbFxRSeVXJwzTe/DxrkSshO71aGidmmiZ9jFG4H5Yxg
         +jp1f2UjT5Wtp3hHpGEbP+3U8/m3p/DtxrqhLJBMn1TN46dqpW4t0jLstrlC5uOLUr5b
         rLpD0UbfuG9kQuLznQ0TXyy1nswCOUk6RNT5ULpswFfWzrbJ600mhBSWSLW6jG+B3W8b
         gFWG8RK2YteGWnsd6pxfuWcfEPT3F6Ft5QODTmjsKA4rV9DU9wm4SQKi6G8ksYmKPBSG
         jrfw==
X-Forwarded-Encrypted: i=1; AJvYcCXg5E8PJ5XUIPWRXN705BoloDICMHoPTpdPS/BQJzDw1ViW9fe4YQNea91oonx2gW2AsgthvLphp5rtoQB19BObQc9JAfkB+vbP22mH
X-Gm-Message-State: AOJu0YxzVQiunReSOUlh9wMMpmzYuNDOFjL+gRql9vlDUydXDfnso2FA
	NsVfLeaOwoL92n5qjq35LCqsBTAkOih8wa7fEoKtFjPSJNrTWcgOihiPO2tkK7SP+o5rkTtuWZ9
	kSDL6sg3PoPmgVVdPnCzufiHi3iICDBpVl9yUEg==
X-Google-Smtp-Source: AGHT+IEAFG/Qa3AvkUwty21ETlqJzfOSzW2WTAImfTGslFJ/Gq5J2quKVu0/vPOz8BkrR2Y5/oJTwC/Tsk4Ha4OkecA=
X-Received: by 2002:a05:6102:1147:b0:46d:1f47:8a33 with SMTP id
 j7-20020a056102114700b0046d1f478a33mr1384506vsg.30.1707563270353; Sat, 10 Feb
 2024 03:07:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-2-brgl@bgdev.pl>
 <20240210110043.853-1-hdanton@sina.com>
In-Reply-To: <20240210110043.853-1-hdanton@sina.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 10 Feb 2024 12:07:39 +0100
Message-ID: <CAMRc=Mc2MjvicHyWrt813LRHqzfexUUcR49N6+JF62f5tPYt0g@mail.gmail.com>
Subject: Re: [PATCH v3 01/24] gpio: protect the list of GPIO devices with SRCU
To: Hillf Danton <hdanton@sina.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 12:01=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On Thu,  8 Feb 2024 10:58:57 +0100 Bartosz Golaszewski <bartosz.golaszews=
ki@linaro.org>
> > @@ -382,11 +389,13 @@ static int gpiodev_add_to_list_unlocked(struct gp=
io_device *gdev)
> >               /* add between prev and next */
> >               if (prev->base + prev->ngpio <=3D gdev->base
> >                               && gdev->base + gdev->ngpio <=3D next->ba=
se) {
> > -                     list_add(&gdev->list, &prev->list);
> > +                     list_add_rcu(&gdev->list, &prev->list);
> >                       return 0;
> >               }
> >       }
> >
> > +     synchronize_srcu(&gpio_devices_srcu);
> > +
> If not typo, could you shed light on why this sync is needed?
>

No it's not a typo. I'm not an expert on RCU but I figured that right
after we add the new element to the SRCU-protected list, we need to
wait for all read-only critical sections to complete before
continuing? Is that not correct?

Bart

> >       return -EBUSY;
> >  }
>

