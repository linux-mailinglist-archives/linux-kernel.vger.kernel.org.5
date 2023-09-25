Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015EC7AD05D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjIYGmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjIYGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:42:40 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F73CE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:42:33 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7a7d7283fe5so1231013241.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695624153; x=1696228953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltIy1nUyugevmhM0U73zYj6MpNP8ZepvnK+04omwLtg=;
        b=pq7UEdAsMpxNaGY1Ijj2enmyjlfzl1QSlEsNrmsiYOu4kqrAygymh+lS7sMci2xMM8
         X2b2mUbbAENcRCjxsiL1r/62sadvACzl64Ige5kM+LXDevkoHUxd7njXshQDaBm75dE3
         grQdymx3LwcObNCNglbA8VcVOCy+5LQ6SjqmjSThSCDwru/qrvyJui393U5n7PxXTwdH
         ieTL/PC4MFlifQNXQM+ik4PaE5lt7TzGJugE35OqRN94cpj0aZLXVrx8Y5KXBm0kuEjy
         EhJW/WhBsLlHP8ZpAAllE5N+1r6XQkjoZVSp7zhl/96r6aNuEfKfwM3//Sz6xkh6N1Oq
         xB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695624153; x=1696228953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltIy1nUyugevmhM0U73zYj6MpNP8ZepvnK+04omwLtg=;
        b=ozQf5jj5xxSivp4Rs44HTeZa1zdPMIC7HOQM/gjTrY1L2h5YjIynOYfNstPraSPfUG
         xSzz2ZXwFWc9XFHsyq9gjMRl+dHXugbKfgzttH4QfLpu8QMHpPP9fbiz2gxtBNDlqpjy
         TFnoI78eFGHmy9QTFCg6SEEfxTXXJRNeDF6hgXo35pFuhQLUb+YmrxzIE8DiSV5QiIvS
         niXLB2/TD1P4mIMFwgk19nzLM3APPSOAMOc57tmRBM/s5ZF7PZw+WT2phraBPaZCPndM
         Emzri9Ih0uDy6gJ7te1dz/yFXtiRKFyCVG8Gm3UDNygD8pM6ZGSlntsV6cSDOXYKZG6Q
         cDIA==
X-Gm-Message-State: AOJu0YxaazCZmVPjW030LWKc3ThSIDbP8K6vZYQZSz0Hr/GBn+uJOYta
        Ro7AdGtDuTu6wAHK/yJkn73h50MaBil36FO8V2Hbfw==
X-Google-Smtp-Source: AGHT+IGRgOm9LU02L4itFyCsCTiWLxKgYFBe9JX85Slqtz7zN5FMCX3u6wyB68zdM7oAz/8JdegT2Mw4SdIvnq3xD0U=
X-Received: by 2002:a67:fa10:0:b0:452:58f8:71de with SMTP id
 i16-20020a67fa10000000b0045258f871demr2053569vsq.8.1695624152848; Sun, 24 Sep
 2023 23:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230917085837.6199-1-brgl@bgdev.pl> <20230917085837.6199-3-brgl@bgdev.pl>
In-Reply-To: <20230917085837.6199-3-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Sep 2023 08:42:22 +0200
Message-ID: <CAMRc=MfvE+NeYwTTSLvZX-9=iqsMENZWec7WmxcgKDkNEPEn9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: sim: initialize a managed pointer when
 declaring it
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 10:58=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Variables managed with __free() should typically be initialized where
> they are declared so that the __free() callback is paired with its
> counterpart resource allocator. Fix the second instance of using
> __free() in gpio-sim to follow this pattern.
>
> Fixes: 3faf89f27aab ("gpio: sim: simplify code with cleanup helpers")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 4d74ea3a4269..24c19c7c50a0 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -1481,10 +1481,10 @@ static const struct config_item_type gpio_sim_dev=
ice_config_group_type =3D {
>  static struct config_group *
>  gpio_sim_config_make_device_group(struct config_group *group, const char=
 *name)
>  {
> -       struct gpio_sim_device *dev __free(kfree) =3D NULL;
>         int id;
>
> -       dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> +       struct gpio_sim_device *dev __free(kfree) =3D kzalloc(sizeof(*dev=
),
> +                                                           GFP_KERNEL);
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.39.2
>

Queued for v6.7.

Bartosz
