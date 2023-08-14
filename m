Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554C77BDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjHNQOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjHNQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:13:57 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D1106
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:13:56 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-78f36f37e36so1043979241.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692029635; x=1692634435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wobTCP4mDcNRbtaclHipsq07yTZIrInXGgJ6gzY66Ww=;
        b=ypjeUMTXTWp/swT5vJKJEWntgM7woXZr85Zklcq7eZe6owlQGhsZNSPE2J0X0CbTs2
         6ZFzuEZvl1RZhtBCK3LKrnYRXDDIS/o99i22pkqQxYNJNTX/nm5+Z7oZwEYQBIbuiPZv
         sULc2MlJBocMOPwr8EZ0pTK0e6iPjjP5kjmEx6miAcjIV4/aUMPuZYSeynji95jXARa4
         usIt9eMnkqJ3WK61m5vuQuAP//FT9IHICQ2kzfrkZYAgZV5WrnrzlOnqAgxypP1nteiT
         WhaIZuMzjQrAShrKhRdTPCZ+sx6Y4bp8EdiQVK5vkrx+2FFRrxEa9kDkNlIqlmmh3Ecq
         /O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692029635; x=1692634435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wobTCP4mDcNRbtaclHipsq07yTZIrInXGgJ6gzY66Ww=;
        b=bQ7JJPXNwRJDOhzgwfld5JbaMOqcD49LwPl3sn/sT1LFjkAaiF3uR1LdxXs05lpgRw
         x+2dFxB6jMxlJSHrZ1JU8cQlJM6z2bKroRTcrcdbEBGYbns6zScgJZjmKe7VU/R9a587
         s940Au0hzQg3GXnj9t5k1j1l6s6EeFUkbu5mKEajuIzJ5R+oJTzm+2qlr7bn6+wYeimO
         Ix8uSOAim/GrZnMQ0FBdlivcvTVMQKcTv64RXghPYgTWreu7ncywUUZGgcsLadn+MpE4
         TTpiRs9A9zpXi2rYrxz3u2+szjBGexsSpKSDCchsQZnUMODQIhjSjuZj3xnVDWlD7sQP
         wy9Q==
X-Gm-Message-State: AOJu0Yzbm96n1JQGFPRovmjevmnrUDKGuk+KxbZ6BhaSMJT3S8tk05GD
        3yX+ek5Cxi1rUIYl8BcmpPYx9mkKT/iwVM2gkDPlqi4+6Zr0n8d6zPK0aw==
X-Google-Smtp-Source: AGHT+IFtRUCzdTXPrBCH2nMD8vl1QgR+QxO9dyXsZbvfAfj0HNlPGqLe2vyydMXzRuK11vrCzIkaqfNNc/y21oe5kyA=
X-Received: by 2002:a67:f9cd:0:b0:447:7dc0:e15 with SMTP id
 c13-20020a67f9cd000000b004477dc00e15mr10161281vsq.28.1692029635516; Mon, 14
 Aug 2023 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230814112615.42448-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Aug 2023 18:13:44 +0200
Message-ID: <CAMRc=MfhoeMfC7gAcKioKpkCA1jykyqGSH4vg7Hpu9bb=yeGaA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: sysfs: Do unexport GPIO when user asks
 for it
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 1:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It seems that sysfs interface implicitly relied on the gpiod_free()
> to unexport the line. This is not good and prone to regressions.
> Fix it by explicitly calling gpiod_unexport().
>

I wouldn't say it's prone to regressions, it's literally just that
gpiod_free() should not deal with sysfs.

How about that for commit message (I can change it when applying):

It seems that sysfs interface implicitly relied on the gpiod_free()
to unexport the line. This is logically incorrect as core gpiolib should
not deal with sysfs so instead of restoring it, let's call gpiod_unexport()
from sysfs code.

Bart

> Fixes: b0ce9ce408b6 ("gpiolib: Do not unexport GPIO on freeing")
> Reported-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Closes: https://lore.kernel.org/r/20230808102828.4a9eac09@dellmb
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 530dfd19d7b5..50503a4525eb 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -515,8 +515,9 @@ static ssize_t unexport_store(const struct class *cla=
ss,
>          * they may be undone on its behalf too.
>          */
>         if (test_and_clear_bit(FLAG_SYSFS, &desc->flags)) {
> +               gpiod_unexport(desc);
> +               gpiod_free(desc);
>                 status =3D 0;
> -               gpiod_free(desc);
>         }
>  done:
>         if (status)
> @@ -781,8 +782,10 @@ void gpiochip_sysfs_unregister(struct gpio_device *g=
dev)
>         mutex_unlock(&sysfs_lock);
>
>         /* unregister gpiod class devices owned by sysfs */
> -       for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS)
> +       for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS) {
> +               gpiod_unexport(desc);
>                 gpiod_free(desc);
> +       }
>  }
>
>  static int __init gpiolib_sysfs_init(void)
> --
> 2.40.0.1.gaa8946217a0b
>
