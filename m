Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8397B0293
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjI0LP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjI0LPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:15:53 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B3F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:15:52 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-495d687b138so3887155e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695813351; x=1696418151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVfAkzwv7s6SJ5GID4gdrqme1d05OJyLXXoD6QHFoE8=;
        b=JnSF+GrfmmRO07uHO1RaW598bSPFK1uwYXWwCpiCQYiOo0gW0F7N5h0qAYPrJ6M/Xc
         Jt/BP2Z52BYZjsv6oRGuDrE11wu72ykDovpKsFBhOtcSNznOzwX2CNbtt7SWDlp3GjWe
         OvgdtsH5UPXLxkKIn3GO2s6sE1vj+YATEIEdNST1FRcYv/d/H/eNl+DcRSZpqMD7vdQt
         1DAB8BlQvL7NNttkY3uRfia5cFFs8qCHIwnlX2JgjdGhdKp7MfLlN4/DAnhhAZK4NKkA
         SVO9mqWFon6e/cCjInyuFWCcftEzIbAlzT5xthZztCyHEcVWN6w+ZpnAavMD9ELYKz4v
         +Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813351; x=1696418151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVfAkzwv7s6SJ5GID4gdrqme1d05OJyLXXoD6QHFoE8=;
        b=VYcRlwA7mHZnIH/ToODLrwU6GEjqZteEBcLKit/74WN4SToaWKYX7jPATIDV6TjOeH
         Oxip8rvw8IOvFLgtB4SRXa4cO8qynplOsUvKk2lDqWUD/LD5hwWcvbVoDWYpzDCvjdrJ
         iqvZnCuCyLp3XUW+iMHWg2/19DsD8IA63xY1Y15SOnIkBs7Ja0VmynFncr5oVvi9Rxge
         /xBtCiEnWQGIoLSE6av4p9VaHq2hm2VupZn/wmplMHe4iiLtKKhISjsCrA4PhxFsbKLa
         Szdk0rn3haCLIAnbrxEOhMnuHBW8AyHvR6VCHU1rfCVM8AYQWdOJV2dsfymRVkbzK6s1
         IHIg==
X-Gm-Message-State: AOJu0YyVx1a8aoer9XsO4tJhCTSQYmsvE4ztuMJE9ALkuT84VPbttBrS
        rAu1rO/LxIoi/eKLw6p+rm6h1VkEOgaEDayZdJBjOA==
X-Google-Smtp-Source: AGHT+IHymKUFP4V3u5zhIDCTbBIqfdNCPcdLUQ8dxI2lTBCq3GJGEzPmhnfIbSU1Z5436i/FSr8W7g7HAbyWn6VcKok=
X-Received: by 2002:a67:fa05:0:b0:44d:3d29:4940 with SMTP id
 i5-20020a67fa05000000b0044d3d294940mr1020879vsq.35.1695813351573; Wed, 27 Sep
 2023 04:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230926090623.35595-1-brgl@bgdev.pl>
In-Reply-To: <20230926090623.35595-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 13:15:40 +0200
Message-ID: <CAMRc=MdAZEGWDK5O5siAsub3qjhx0-MAgzrt6E_eR1rFdBfAFg@mail.gmail.com>
Subject: Re: [RFT PATCH] mtd: rawnand: ingenic: move the GPIO quirk to gpiolib-of.c
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-mips@vger.kernel.org,
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

On Tue, Sep 26, 2023 at 11:06=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have a special place for OF polarity quirks in gpiolib-of.c. Let's
> move this over there so that it doesn't pollute the driver.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This is an alternative to the previous patch that instead of replacing
> one active-low setter with another, just moves the quirk over to
> gpiolib-of.c
>
>  drivers/gpio/gpiolib-of.c                       |  9 +++++++++
>  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 12 ------------
>  2 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 5515f32cf19b..58c0bbe9d569 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -192,6 +192,15 @@ static void of_gpio_try_fixup_polarity(const struct =
device_node *np,
>                  */
>                 { "himax,hx8357",       "gpios-reset",  false },
>                 { "himax,hx8369",       "gpios-reset",  false },
> +               /*
> +                * The rb-gpios semantics was undocumented and qi,lb60 (a=
long with
> +                * the ingenic driver) got it wrong. The active state enc=
odes the
> +                * NAND ready state, which is high level. Since there's n=
o signal
> +                * inverter on this board, it should be active-high. Let'=
s fix that
> +                * here for older DTs so we can re-use the generic nand_g=
pio_waitrdy()
> +                * helper, and be consistent with what other drivers do.
> +                */
> +               { "qi,lb60",            "rb-gpios",     true },
>  #endif
>         };
>         unsigned int i;
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mt=
d/nand/raw/ingenic/ingenic_nand_drv.c
> index 6748226b8bd1..c816dc137245 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> @@ -380,18 +380,6 @@ static int ingenic_nand_init_chip(struct platform_de=
vice *pdev,
>                 return ret;
>         }
>
> -       /*
> -        * The rb-gpios semantics was undocumented and qi,lb60 (along wit=
h
> -        * the ingenic driver) got it wrong. The active state encodes the
> -        * NAND ready state, which is high level. Since there's no signal
> -        * inverter on this board, it should be active-high. Let's fix th=
at
> -        * here for older DTs so we can re-use the generic nand_gpio_wait=
rdy()
> -        * helper, and be consistent with what other drivers do.
> -        */
> -       if (of_machine_is_compatible("qi,lb60") &&
> -           gpiod_is_active_low(nand->busy_gpio))
> -               gpiod_toggle_active_low(nand->busy_gpio);
> -
>         nand->wp_gpio =3D devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LO=
W);
>
>         if (IS_ERR(nand->wp_gpio)) {
> --
> 2.39.2
>

Queued for v6.7.

Bartosz
