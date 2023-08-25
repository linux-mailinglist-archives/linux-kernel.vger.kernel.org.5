Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3158178857D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjHYLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbjHYLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:18:25 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E672CD1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:23 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79a10807b4fso318802241.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692962302; x=1693567102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWKrrSx4g72KNJv8vfPkVXuC0ZK0bilFToBW/WhDgH4=;
        b=wiC2b2iY2ns4+6bRTnChH6buoE3SQC2PTPoPfFYKHSRyrP57WYUj2LzIOgkbHWC/77
         3qrlGvudaR8VbqxHQ5JGD6vA3ylBcrXbpcHFQTNVbAy5eNF8ijUfISdyvDCutxTsSnjX
         CNyjqgVv1VHLAa9aLbjTYPaN2iVck3ncthrz5jaDQDI7+G3GhwcjEn2dYr1TjtVBExEj
         3Tgv0HMjIIPztYVO5iyTNsr622TnEWM7ElTf9j9vIqvb26eFcr2h8Gm+ItOzcn0oqsh2
         phpjYPBnnyrSVhQ8AH76YC8KUHa1FDQeCp9RQP9MtSHJlxBg5smcdR+uk4HO+pwIt2qd
         hFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962302; x=1693567102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWKrrSx4g72KNJv8vfPkVXuC0ZK0bilFToBW/WhDgH4=;
        b=IYORofyIn4ZqE6+fiL8o8xJ99Q/htEUklykl5U4Dn1F6anJGPMCsk4c/Nni3snNvan
         j6wKy9xVxXkVlFoe9VZ3Asb2vl7CFz0lzDfF9TTuw5WIP4UCTUsGWLindIvaZZ/4Xdfb
         LnUY9C1z6x6mU8lX0PR4esb0bI7kTojUJ23iBN3GMfeEYLbWL3pVyesLalms7txduCWa
         dQlmzS7RWutQFVE6uyqEzcWyyzbWoq0dthASy7voTTw0TwEyd1qq9zg1l9590ao8bzpK
         WNEZig3h0PiseB5KNfSSOeLC0LiQUwF+15rm7m1MY40emqn70ntkV46K/2k4/87q0RQY
         AQOg==
X-Gm-Message-State: AOJu0Yy/9VE8bWgrHf4Q60QFTcPsmILWYO4Je1areXsCagJb5Td83/NK
        Ea1L03SEcSXTFby15qlFhBUbeG/LfS477AG0LpSSeg==
X-Google-Smtp-Source: AGHT+IEgwcG3WQA8jodQelsSwZ3u6fbblw91gZ/1p6Qw3GMUPOQrKaehGcII9s0yiY9sRhqebF21IusxSGn2g8WR39I=
X-Received: by 2002:a67:fb99:0:b0:44d:626b:94da with SMTP id
 n25-20020a67fb99000000b0044d626b94damr8984206vsr.32.1692962302520; Fri, 25
 Aug 2023 04:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com> <20230824-tca9538-v1-1-ee3bf2065065@gmail.com>
In-Reply-To: <20230824-tca9538-v1-1-ee3bf2065065@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 25 Aug 2023 13:18:11 +0200
Message-ID: <CAMRc=MdmM8PgGUdaxCFQo_SJHKJ9CO3tRScY8XNcKc71BV_ZHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: pca953x: add support for TCA9538
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
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

On Fri, Aug 25, 2023 at 1:16=E2=80=AFAM Liam Beguin <liambeguin@gmail.com> =
wrote:
>
> The TCA9538 is an 8 bit version of the already supported TCA9539.
> This chip also has interrupt support.
>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index a806a3c1b801..71a750363738 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -108,6 +108,7 @@ static const struct i2c_device_id pca953x_id[] =3D {
>         { "tca6408", 8  | PCA953X_TYPE | PCA_INT, },
>         { "tca6416", 16 | PCA953X_TYPE | PCA_INT, },
>         { "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
> +       { "tca9538", 8  | PCA953X_TYPE | PCA_INT, },
>         { "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
>         { "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
>         { "xra1202", 8  | PCA953X_TYPE },
> @@ -1354,6 +1355,7 @@ static const struct of_device_id pca953x_dt_ids[] =
=3D {
>         { .compatible =3D "ti,tca6408", .data =3D OF_953X( 8, PCA_INT), }=
,
>         { .compatible =3D "ti,tca6416", .data =3D OF_953X(16, PCA_INT), }=
,
>         { .compatible =3D "ti,tca6424", .data =3D OF_953X(24, PCA_INT), }=
,
> +       { .compatible =3D "ti,tca9538", .data =3D OF_953X( 8, PCA_INT), }=
,
>         { .compatible =3D "ti,tca9539", .data =3D OF_953X(16, PCA_INT), }=
,
>
>         { .compatible =3D "onnn,cat9554", .data =3D OF_953X( 8, PCA_INT),=
 },
>
> --
> 2.39.0
>

Applied, thanks!

Bart
