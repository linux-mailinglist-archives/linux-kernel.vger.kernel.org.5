Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805EF7791B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjHKOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHKOWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:22:18 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072E10E4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:22:18 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4872c3dff53so540049e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691763737; x=1692368537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE+z4UQ3VnBpZJ2T2pdd3e6WHPp38j/RDjX6LFDfTuc=;
        b=r6IR1Ktc8MKNaSxYoKGQlBrMWE0aTjVlfG9r9BqV13RtcJ9V0xVxz7bBGMXZlc8RoE
         ObeV82PLvA8afQHbLGaX3WkfvGB/4yocARAJpGZ2FHerYDq9ScO8ykgU63OYpEiOcs6O
         Fae/Oky9ozcMIwdJfKYgb/Jc4LAN/Qs5BMjDmqZ0DpR4rndGt7ynpq332jTOTrYk2dWr
         8VPjt2VyTnC44IEK+Jf+8a9TCg70A1EfoZSrf1bKhzPUtbMRYLiLoZK8lC+BwtMX0Ze8
         QVvTlNWIwooa1fInzJl8ZAxHnCunQLfZF4WwhzsAELeEaussoGCjgGDyexfS+oZnX1B1
         3xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763737; x=1692368537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE+z4UQ3VnBpZJ2T2pdd3e6WHPp38j/RDjX6LFDfTuc=;
        b=WweF/M5O0obk1neu9bSF9q0fveZzAae0uoM/Kp+8gr/USkcXIvsQmkuaqNttp8jJqx
         fuF/4LNRXCV/ge3V5nw39HTg4OD678hS+ycF12xfwELh0RkcrWNGIg+bZ6nEnYWG9LOS
         jlZ67mAmNw0BMK8zv3GR+sujwd32aM5gPkXCmp4/6RCPNWNj5BrffE0STor2gVKXLU/s
         7OJjUynBdlvSieU7NAo6MC56+0hoormTFgc93ZFesZLaG7O4ONiXaYrDq9kURsXqZc6m
         /W9zYWBiIFTWhNIt2hcaGci+uoidedDHxfECNE3UflRTiFAifjetBlQXPWT0SNW/4xV/
         JkmA==
X-Gm-Message-State: AOJu0YxKjoKeX3jbc7azfkJfKHSn652WtLbGgw/5ZuQhamr0pe4pyidG
        QcBbHFEvEX1PMfrjnDn8YIi7O0DayV/sLDCCMMFGLQ==
X-Google-Smtp-Source: AGHT+IGbmfiGAdXWser5HtqUh50Rptk5gT7mof3fWfv1EeJhgnXtUkEx8cx8pKSpHaf281P6bnR+w1NFn2eM6ZSzcjc=
X-Received: by 2002:a1f:4c46:0:b0:487:2bd4:f93e with SMTP id
 z67-20020a1f4c46000000b004872bd4f93emr1039961vka.10.1691763737192; Fri, 11
 Aug 2023 07:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230810095949.123473-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230810095949.123473-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 11 Aug 2023 16:22:06 +0200
Message-ID: <CAMRc=MccHyVtv10YVbsP7x5zSsFYiPTKbTsSaqEPWKp7ewHtPA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxs: fix Wvoid-pointer-to-enum-cast warning
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>
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

On Thu, Aug 10, 2023 at 11:59=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> 'devid' is an enum, thus cast of pointer on 64-bit compile test with W=3D=
1
> causes:
>
>   gpio-mxs.c:274:16: error: cast to smaller integer type 'enum mxs_gpio_i=
d' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpio-mxs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index 8e04c9c4b5a2..024ad077e98d 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -271,7 +271,7 @@ static int mxs_gpio_probe(struct platform_device *pde=
v)
>         port->id =3D of_alias_get_id(np, "gpio");
>         if (port->id < 0)
>                 return port->id;
> -       port->devid =3D (enum mxs_gpio_id)of_device_get_match_data(&pdev-=
>dev);
> +       port->devid =3D (uintptr_t)of_device_get_match_data(&pdev->dev);
>         port->dev =3D &pdev->dev;
>         port->irq =3D platform_get_irq(pdev, 0);
>         if (port->irq < 0)
> --
> 2.34.1
>

Applied, thanks!

Bart
