Return-Path: <linux-kernel+bounces-143265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADFB8A366C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB2D286661
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA94314F9FD;
	Fri, 12 Apr 2024 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="A3ewEelg"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A6482C1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950663; cv=none; b=pWmg4BOQQzNdzOGV4n+UW5O9ms4dMHkDcwBOTXeNL4rSemCOj2s0VhDOxfIB5Gzus77wLKnjxUVvNu4SLMkr830jv1VaoswFJ21OvLYWt7DT2kRc1u070e7czBHQTHwlxgJx6OqjcjSdNhlNCQYM4kbiS405Q2cwr6Fce5oEc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950663; c=relaxed/simple;
	bh=Tg2nVdq/d5KumhtinRqe1tZV6o/HFX1CMfhtdfIN7zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKLFopaEpvyJEz1LRihzCqIIRmTc9uxL8zIx4P96NkILiHC9tlUIDRrIq9lVIUQWapH3RFGGVKdnxbuWlDT4Oj1VKCfwCPAEB+BoWrXiRouXpZWvLOupkp48+ni/uj39/V3EuXUabDt4xVhXOsVpCQIcK25kUixtBzKelLifwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=A3ewEelg; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d718ee7344so13345001fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712950660; x=1713555460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzpKfA4Up8SgqchxhXS8pijpYP+A8wp2bHAd2wWgUdc=;
        b=A3ewEelgAqIoPpbaD5TGHi4wgH5sK5IYNII8JtVZ/FL96W1qbXuH4qqtwSZysp4Spt
         ZtSfSsjSVpmeCGx5RN7zpxp5QIOsRk3xQHs5JpN/4CjaFoA9375G2MXUL3VIdHjEKZ++
         D3+MxSVFFTyRk1b1wK1+eZEEfPMdxq40yMQC0rY1o4EgRI1hCB6SfNlIBOuXJfI8XstA
         Y77MK6fM7gZ08peQ7c2LskK59rHRtjTHbz6mMY6YB99OQ7+MxQnouEVAsKxkr+3XMDjx
         2k3i5P0d3VHGaebUhevgsV6fPNp8nYVhKKoty7B7fAs2a+cJWjO8NWFPUu92CsSgKRj0
         gZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950660; x=1713555460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzpKfA4Up8SgqchxhXS8pijpYP+A8wp2bHAd2wWgUdc=;
        b=uQgwRnxGhiIYvaKOloKKKHiRUvwz4L+8hdemFZ5h/htdiJgzxGzdc7MY701rPGrtP4
         UtN77STJ9Xnzxan1iP/V68poAIycXlo5Fh5pNUeSB0UFP3BskiR1BTDisL/tXaT76wCv
         Qs7y4O4QmrgzzkxSvMTvL21FY2BOuD9PRRRSmM9BH17/x2I2C5q+BD/K3PrFGEqs/Hdz
         UVn+utMIzIBOlZUvU/s6VbatjrwywuL//L5iWlU9jVvxCu+iwE1hO5eVm8tW6AUn9vwj
         +2gSXKRvTlF0y+DOCVbpjZXFbuJHroc/5L3TzRFTSK0eCqzGGBxbYOy343eOIIyDYEUG
         aOfg==
X-Forwarded-Encrypted: i=1; AJvYcCXYVHcML2tWS4cpCDMk2l22FP6Ejt6o5DlHVMm5zfdncsfgfJufFKRc1izNkn7Yahvsl5a3IOxgON/7xbbW3bW35GSQ2nNIyH6qyp26
X-Gm-Message-State: AOJu0YwjEoh1wZnP3/H9Q5oGKXOEVYRzoApq2DlmtNrDzivye/NvI6nq
	mBD5zXH5hFdQgfVkR82zsBhYzbj0jwuqrQSxjbFZNhiFnREKaUsHbqOGj65TfMa6wdFGGvvwiml
	7ff9fSBXsjSzf4YQ7GSDY9hIUexsw9KJjcZdN1Q==
X-Google-Smtp-Source: AGHT+IHzBG0CpKMbAHTj0jP5kpuv3o0Sf2ExiZ/Vj9JT1HlTwGCVvGG5WIKrPaUyqGpBviq7/hzAX4vDFjb6hzLumI4=
X-Received: by 2002:a2e:985a:0:b0:2d8:a98d:197 with SMTP id
 e26-20020a2e985a000000b002d8a98d0197mr2878605ljj.30.1712950659991; Fri, 12
 Apr 2024 12:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410064156.1199493-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240410064156.1199493-1-andy.shevchenko@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 12 Apr 2024 21:37:29 +0200
Message-ID: <CAMRc=Mew-w3bChf-Qy5PM00rNNtLziBa7XVP+B7t7xvgSywhAg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: pcie-idio-24: Use -ENOTSUPP consistently
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	William Breathitt Gray <william.gray@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:41=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> The GPIO library expects the drivers to return -ENOTSUPP in some cases
> and not using analogue POSIX code. Make the driver to follow this.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/gpio/gpio-pcie-idio-24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-id=
io-24.c
> index 2efd1b1a0805f..7f7f95ad4343d 100644
> --- a/drivers/gpio/gpio-pcie-idio-24.c
> +++ b/drivers/gpio/gpio-pcie-idio-24.c
> @@ -267,7 +267,7 @@ static int idio_24_reg_mask_xlate(struct gpio_regmap =
*const gpio, const unsigned
>         case IDIO_24_CONTROL_REG:
>                 /* We can only set direction for TTL/CMOS lines */
>                 if (offset < 48)
> -                       return -EOPNOTSUPP;
> +                       return -ENOTSUPP;
>
>                 *reg =3D IDIO_24_CONTROL_REG;
>                 *mask =3D CONTROL_REG_OUT_MODE;
> --
> 2.44.0
>

Applied, thanks!

Bart

