Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0D75C582
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGULJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjGULIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:37 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE0F35BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:07:46 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4438f623370so766466137.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689937665; x=1690542465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5tB76GjvqrYC+DTRCo2UQKFWIgvLZ4XI2pYbsVGhys=;
        b=s8I6ZrL/nSmSOh9gkg0xEc4qZagaDjutE3xd71QcIAObHXuZykrTAcjoDNIXBituuI
         HfWx90BqkwyI2tmkd4+4t2d0qvVkPcI1SCuYhkbCYwC4t/HXUkjJS+nLT3ZsI1BdxJXg
         mzzCGAV3b64Pwwl1dViRpl330WXavnDX/B+vZqT0QTHiHBuOBE77zkRjBSeele2dVpNn
         ZYDxjjev13elrGGo9CRNfZtuWdLytrcXtf6/zgMxxjdJwCsZQm9flKvxcWws3e+iAHYX
         SVkbDdsTg5RziOdyfdZGrrsI6tqgfTCMf8oo4whzYo2tQAG+gnfTcBIz5g3q8zdfHdoD
         ribA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689937665; x=1690542465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5tB76GjvqrYC+DTRCo2UQKFWIgvLZ4XI2pYbsVGhys=;
        b=G6J/CxY9WiL/95mLIrnT0XhVvWklPkReomEYZ0y9hiPTnyp/0i1sy7sCJtuFi7Kna2
         2xfZfKNytwfUS0VjlqxE6H1SNq2++xorkg6+Bf248PYjpZrVCuk27ebKWUq1v7yo6jkp
         cOZZvDAgGWpNSzP+KuifPmm8tym+1PHLa2i2ecktOrO6H65iIeHKgv/JmeppW/7LzFyJ
         76pgZ8WekfJ7gx+/1feavUhRtsPcxQBqlWkBBg0hQaJQdhPhAyDWZwVxUP3hIQuC+iZ6
         jrZr36bhm2YaTOoYXkyKSxqR3ztFTJ4Yl2LtfrYhWxI6DhfD4ibJsTU4LO6xXZmAyce8
         /rlA==
X-Gm-Message-State: ABy/qLbFJaW+l/5reQzwdjyVrZY3jxDZICwsgrQ6pXKyN6OgipoiBUiS
        wfBHInuiPbf8+csok8OWnfJc2xJFYMkxEWxJnsf54w==
X-Google-Smtp-Source: APBJJlFUir/tUCGBKYIaKDI8tzxMysdIpDY7h5Mgngyxia5S6KeG3LorcA/vbJOB1C3s1aEGCGCbVEXRwmusmkxxOc8=
X-Received: by 2002:a67:b34a:0:b0:446:bf73:771a with SMTP id
 b10-20020a67b34a000000b00446bf73771amr659018vsm.20.1689937665364; Fri, 21 Jul
 2023 04:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230721093342.1532531-1-victor.liu@nxp.com>
In-Reply-To: <20230721093342.1532531-1-victor.liu@nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 21 Jul 2023 13:07:34 +0200
Message-ID: <CAMRc=MfPKQuEGrFXuPNOKchE_Fj+obOheDoemoF9rxtRWYiFCg@mail.gmail.com>
Subject: Re: [PATCH v4] backlight: gpio_backlight: Drop output GPIO direction
 check for initial power state
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "andy@kernel.org" <andy@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:29=E2=80=AFAM Ying Liu <victor.liu@nxp.com> wrot=
e:
>
> If GPIO pin is in input state but backlight is currently off due to
> default pull downs, then initial power state is set to FB_BLANK_UNBLANK
> in DT boot mode with phandle link and the backlight is effectively
> turned on in gpio_backlight_probe(), which is undesirable according to
> patch description of commit ec665b756e6f ("backlight: gpio-backlight:
> Correct initial power state handling").
>
> Quote:
> ---8<---
> If in DT boot we have phandle link then leave the GPIO in a state which t=
he
> bootloader left it and let the user of the backlight to configure it furt=
her.
> ---8<---
>
> So, let's drop output GPIO direction check and only check GPIO value to s=
et
> the initial power state.
>
> Fixes: 706dc68102bc ("backlight: gpio: Explicitly set the direction of th=
e GPIO")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3->v4:
> * Capitalize words 'gpio' in patch description. (Andy)
> * Capitalize word 'gpio' in patch title.
> * Quote appropriately in patch description. (Andy)
>
> v2->v3:
> * Add Fixes tag. (Daniel)
>
> v1->v2:
> * Improve patch description. (Daniel, Bartosz, Andy)
>
>  drivers/video/backlight/gpio_backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/bac=
klight/gpio_backlight.c
> index 6f78d928f054..38c46936fdcd 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -87,8 +87,7 @@ static int gpio_backlight_probe(struct platform_device =
*pdev)
>                 /* Not booted with device tree or no phandle link to the =
node */
>                 bl->props.power =3D def_value ? FB_BLANK_UNBLANK
>                                             : FB_BLANK_POWERDOWN;
> -       else if (gpiod_get_direction(gbl->gpiod) =3D=3D 0 &&
> -                gpiod_get_value_cansleep(gbl->gpiod) =3D=3D 0)
> +       else if (gpiod_get_value_cansleep(gbl->gpiod) =3D=3D 0)
>                 bl->props.power =3D FB_BLANK_POWERDOWN;
>         else
>                 bl->props.power =3D FB_BLANK_UNBLANK;
> --
> 2.37.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
