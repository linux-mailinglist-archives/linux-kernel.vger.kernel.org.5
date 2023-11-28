Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85A7FC1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjK1Qpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjK1Qp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:45:28 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74791D62
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:45:34 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4629afba9acso1777451137.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701189933; x=1701794733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahP72vGF/z2SVVNy+HP+Vo4YpFZClknMh1TjcUEInCw=;
        b=izBVUVjBf3tbpYQjLw1BnM6Sm4Q+C0/VLgEAgzcZn2PEwVoEmNWNvis2jUP6vEcJbC
         zdx/DwtbvMfpM9KvX3fw69dZevxMPhawFv+5PBDx74rd+uSHqIqK5PHwBGwsk4/n2wp2
         oZ7RleBkToH4kkvgyJ84sGe/zHR8Z39TLWyHgkG/6OkaQfptUoYRWls9EHSGF5VyQgFx
         BYUvv7u7YOGayd3zdULN12V6627fMrXAwVFxVvOzb0Brbp77TdP8/J0g7bYBLhaMscB5
         T6ifRLywafr7FU7uYV6mprwj88ZgN5YTQp7eRFEenD1eKS9VmApZ4KdM5Cgu9ZVID6+M
         XTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189933; x=1701794733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahP72vGF/z2SVVNy+HP+Vo4YpFZClknMh1TjcUEInCw=;
        b=AZ0gQ81M+ki5AmqyRAvZoqVQ0Hy9SmW1AuFJBC4tY/WvUnq84elt8W7a/8bwcmAa1p
         ygtK1HZ9rGdVYAVlc6U4AHptQLtxJk1UBXOGQ/GX+tj3HzjsdvlaC6Vd7iQQiSe22OVL
         SSq1+C5QSrO7XiEZ2BJCOC+0ZmJ3dd4+hNOJWpI/bHuUi+EMlp2dpFUBVOw157zaAUl7
         qRqmkybBHkQwvH4OykXVO0qn3uCPlYTaS5tXy99FhREAeBJ52X23B+HWGZbM9plZFAYC
         4AarBUKU0Uz4iAp1gIzrGY/PW3QgqM9ZsA2Izr0v40wqj5fCN7KoIqdk4TqAyFWfmYdO
         TPVw==
X-Gm-Message-State: AOJu0YxUpBAEYoZhwacTyKlH2KdCVvCBzlRQz90ZeiUTdZCihPTvgrlc
        rKpMc5+JA3K4DcudFdJxdrZ1vFSA9YW2eIgNipPjEQ==
X-Google-Smtp-Source: AGHT+IFnot74kFB1veZb9ps6KuKkZEz8SgPqmiLHRLNSHAH+Ekxr3lOm0ylmqvdn9tGDjz8lnKY7oEI9u6UKnMQla3Y=
X-Received: by 2002:a05:6102:1611:b0:462:aaf0:7c98 with SMTP id
 cu17-20020a056102161100b00462aaf07c98mr11387095vsb.19.1701189933242; Tue, 28
 Nov 2023 08:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20231127193716.63143-1-brgl@bgdev.pl>
In-Reply-To: <20231127193716.63143-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 28 Nov 2023 17:45:22 +0100
Message-ID: <CAMRc=MfCh5V7TE-kq1bP92QzUmv_NU_qfqKtBusrX2p161mGtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: sysfs: fix forward declaration of struct gpio_device
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 8:37=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The forward declaration for struct gpio_device should be provided for
> both branches of the #ifdef.
>
> Fixes: 08a149c40bdb ("gpiolib: Clean up headers")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-sysfs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
> index 0f213bdb4732..b794b396d6a5 100644
> --- a/drivers/gpio/gpiolib-sysfs.h
> +++ b/drivers/gpio/gpiolib-sysfs.h
> @@ -3,10 +3,10 @@
>  #ifndef GPIOLIB_SYSFS_H
>  #define GPIOLIB_SYSFS_H
>
> -#ifdef CONFIG_GPIO_SYSFS
> -
>  struct gpio_device;
>
> +#ifdef CONFIG_GPIO_SYSFS
> +
>  int gpiochip_sysfs_register(struct gpio_device *gdev);
>  void gpiochip_sysfs_unregister(struct gpio_device *gdev);
>
> --
> 2.40.1
>

I applied this. I'll make patch 2/2 part of the upcoming locking rework.

Bart
