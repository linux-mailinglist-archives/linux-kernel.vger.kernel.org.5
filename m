Return-Path: <linux-kernel+bounces-73171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DE85BE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F921F2160E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B06BB3A;
	Tue, 20 Feb 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1bGl4ldL"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74967E6E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438810; cv=none; b=cFyVbqSE+U45pBh92cLv34fTg9+xxJNh7HhoWQWTpphgY3Sr0k0r36aNO/llaspkK6Ggaji8LNA0gLdbXRUSakP54pZ+OgdzppPx1cswzCM/E40BdgvgGnBZjK7l6eVGJCVk8Z8JG/NhAn8z87HwEeyUlPxoJg5F4JFHFIw40Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438810; c=relaxed/simple;
	bh=48womPk9DGD0jZ8lhc8PlrjqWPDLdoKv+1RFlvmpOPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvz6dB+UfhUGgqHy+KqE9V6CbtCKLhZHv5q2SnUkPHiAH9Q3AJ0acti6+CUnNcfHp7R3JmR3BaiXqqowIYNkJ6gu6rYo62iEnljkP7uVv4KRxbRvAjeOxda5H7EMmkkQj5Y8uKGtlJ1DRsm1dpbL8mc0BjWY5+vNtlzBEGmJ11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1bGl4ldL; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2185739b64cso3239980fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708438808; x=1709043608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k55yQJs+Dey36k/hxT0QeaBbeXBq2IfYIGNUVHLCfU=;
        b=1bGl4ldLAe3spnfpEOdNnc1ZKZNPWETkTqeLDkHo2E5/39v7W7OecYPU4pGJuQ1z28
         HS/NXVDOQb9jb+eDsaTie5d9fh9pzepLSjBzKsCAeWVKTfCJAva4Eew4e1fgFnfqmd8x
         4DZimRjpf+8jR8DaMWxv2pbOv4medEG64Bo/w548sIYn770NYZfZpTsdP4ChCUo6PONf
         /Yr/7j02JTAANis2JAuXtA4ITId4Xj/J4n7ox8ObdRR825c6dKOhcgKBKiKkppcc8FEr
         Yy767zbhx5zBCeEnpMmXy7OAgT0tp3hhTjQ29khw/9p9879pbwVpD6w4B/q4VdDlYxZ8
         aDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438808; x=1709043608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k55yQJs+Dey36k/hxT0QeaBbeXBq2IfYIGNUVHLCfU=;
        b=Xv+9wbd1Jgro1NnxrD2NB+hFmEnJUKlTZyOhjedXk+LqQnI63je71AVkv8gfKHLB3B
         LMNBq1svxwLWKcbEWCn1bPJKNY6Rik6fm19iNg6dwZ3l9uCqYHrpx8SWO1cGbW+dguzf
         CrSxlFrWuIO8KOMHqcXw44WZXZA4twpBcHViyCt5XMidKGDH75Eci0NmX0pyDXHKBCbg
         0ViR1X7ySV4xKDt0pwTOt2MYXVFNxVrbDWJt6ClKg8Yqgka0lwaBcaYfcx6e42R4SKQq
         iHxThQq0GGSWdtRuN8aU8NBOCxTHnfWFHvblZLsA5gqAXuQ/oMpBtE0J+wFCEh9J5skg
         20dw==
X-Forwarded-Encrypted: i=1; AJvYcCXoTttiR6ZbkBphGCfQTCNxiRMM2bm1PInp4bv7vvwK0nDXQveHGMHiiYY6u3avWoOncsWBqYbAaqSFuTY0CbD/h1+cshmH4qncJtB2
X-Gm-Message-State: AOJu0Yx/9slrzoZqNMkjpBMy+kEIlNW5UQ+/2iyUtSPuc1ObUlPuHU+i
	1K7SGCBv8ZAKGdW4Ly988wXJZgK44nDoeL2n9UhzVmFfkkUbgPSf/I7wn7jjcXBpJLFpS7xKD0r
	fMUxAdun6VAgambrZnM2dgossROrQezBYw9k2mA==
X-Google-Smtp-Source: AGHT+IFMnXiKG47gNdHQm7RVwIso6YbTWdIs9HphpyCnoOP6Xb45mzpZFaUrVrOl7nB1Bxt7pQX6gzBpMMRlDVBrGho=
X-Received: by 2002:a05:6871:5b1d:b0:21e:aca4:883 with SMTP id
 op29-20020a0568715b1d00b0021eaca40883mr9346365oac.15.1708438808666; Tue, 20
 Feb 2024 06:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220133950.138452-1-herve.codina@bootlin.com>
In-Reply-To: <20240220133950.138452-1-herve.codina@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 20 Feb 2024 15:19:57 +0100
Message-ID: <CAMRc=MfWPEOHeNvAwra-JxHZBFMrQbP+273zbFLDZfxi7fx8Yg@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] leds: gpio: Add devlink between the leds-gpio
 device and the gpio used.
To: Herve Codina <herve.codina@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 2:39=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi,
>
> Note: Resent this series with Saravana added in Cc.
>
> When a gpio used by the leds-gpio device is removed, the leds-gpio
> device continues to use this gpio. Also, when the gpio is back, the
> leds-gpio still uses the old removed gpio.
>
> A consumer/supplier relationship is missing between the leds-gpio device
> (consumer) and the gpio used (supplier).
>
> This series adds an addionnal devlink between this two device.
> With this link when the gpio is removed, the leds-gpio device is also
> removed.
>
> Best regards,
> Herv=C3=A9 Codina
>
> Herve Codina (2):
>   gpiolib: Introduce gpiod_device_add_link()
>   leds: gpio: Add devlinks between the gpio consumed and the gpio leds
>     device
>
>  drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
>  drivers/leds/leds-gpio.c      | 15 +++++++++++++++
>  include/linux/gpio/consumer.h |  5 +++++
>  3 files changed, 52 insertions(+)
>
> --
> 2.43.0
>

Can you add some more context here in the form of DT snippets that
lead to this being needed?

Bartosz

