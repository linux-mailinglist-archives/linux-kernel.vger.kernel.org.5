Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268F77BEB42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378534AbjJIUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjJIUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:07:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F526A4;
        Mon,  9 Oct 2023 13:07:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED050C433CB;
        Mon,  9 Oct 2023 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696882049;
        bh=y8nYBzb8SPqMzIHYyddRCAQEALLJLFzpyJS1VbgJt7c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gAgicaXsGMetOX+2cAzCr1ZDf9orx8u/GJQL3F4rcPLpHLvzOR/PGXNfn7SOQ9vQ9
         JLTkHDdeu1L0cnPTR3rKed/bs7/Dgf5lT5zU6208jUc8St9qjZGxg+XJXQa76b+iLB
         KNXgmG4mXqMVOkTmp3g4exxMpK5EDF6QdNhLjE2L4ZeAuDS5ZOUSJwxQEJB604w4dr
         eaeeqBVWF9/1vhGnYWa3tbEKbsop3St/bOU1VQR91sa6loMesDbXpia5KJ/2XCz4Jv
         Nf6jIoJfry+AuRb2HALqYX6Pr3kLLMRdO2JJbaWriDNUOtZvv6Vmg46cY9mxdS+dtf
         AcewgnPLpx/gg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bfea381255so59335121fa.3;
        Mon, 09 Oct 2023 13:07:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzzVOsVSRMX1xlpu0K20Q7hQHwD8iqsv2lCb4BuaoYeSrSo1wwa
        Lkz3SpD/pL1JikO5nEGn+HWDnOmRBOPuyT2kTQ==
X-Google-Smtp-Source: AGHT+IHKjUyuFKZUV3KbEld3Xl4R229DZi+wcFRkw3EpsoO+IoRrvgDyFFIOJZHsBOVYGJmnkIhjkpG+JqQT70tktSQ=
X-Received: by 2002:a05:6512:e96:b0:500:b3fe:916e with SMTP id
 bi22-20020a0565120e9600b00500b3fe916emr18579107lfb.2.1696882047070; Mon, 09
 Oct 2023 13:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231009172923.2457844-21-robh@kernel.org> <20231009193032.y7vn2bnluqhrfmmy@pengutronix.de>
In-Reply-To: <20231009193032.y7vn2bnluqhrfmmy@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Oct 2023 15:07:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKi8PXVqHgVxqMN+mbX8U-ZGsCMUFqbxmjeFmj1xKTrjw@mail.gmail.com>
Message-ID: <CAL_JsqKi8PXVqHgVxqMN+mbX8U-ZGsCMUFqbxmjeFmj1xKTrjw@mail.gmail.com>
Subject: Re: [PATCH] pwm: Use device_get_match_data()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 2:30=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Oct 09, 2023 at 12:29:16PM -0500, Rob Herring wrote:
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pwm/pwm-img.c      | 8 ++------
> >  drivers/pwm/pwm-rockchip.c | 9 ++-------
> >  2 files changed, 4 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > index 326af85888e7..e32b5e8c203d 100644
> > --- a/drivers/pwm/pwm-img.c
> > +++ b/drivers/pwm/pwm-img.c
> > @@ -13,9 +13,9 @@
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> >  #include <linux/pwm.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > @@ -261,7 +261,6 @@ static int img_pwm_probe(struct platform_device *pd=
ev)
> >       u64 val;
> >       unsigned long clk_rate;
> >       struct img_pwm_chip *imgchip;
> > -     const struct of_device_id *of_dev_id;
> >
> >       imgchip =3D devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL=
);
> >       if (!imgchip)
> > @@ -273,10 +272,7 @@ static int img_pwm_probe(struct platform_device *p=
dev)
> >       if (IS_ERR(imgchip->base))
> >               return PTR_ERR(imgchip->base);
> >
> > -     of_dev_id =3D of_match_device(img_pwm_of_match, &pdev->dev);
> > -     if (!of_dev_id)
> > -             return -ENODEV;
> > -     imgchip->data =3D of_dev_id->data;
> > +     imgchip->data =3D device_get_match_data(&pdev->dev);
>
> Is this a semantical change? If there is a match, the code is
> equivalent. Otherwise it was:
>
>         return -ENODEV;
>
> before and now it's
>
>         imgchip->data =3D NULL;
>
> isn't it?

As this driver only does DT matching, then of_match_device will never
return NULL if we've gotten to probe().

Will update the commit log.

Rob
