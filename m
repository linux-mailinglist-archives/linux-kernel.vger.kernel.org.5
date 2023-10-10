Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D17BF999
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJJLXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJJLXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:23:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E30A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:23:10 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d77ad095f13so5701413276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696936990; x=1697541790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POL8IbM7Vi2ralIIYuoAFWFBsY0Txlw06bqhpyC2YkY=;
        b=Xw3yJ6/F1BhHKbldcfrLnTTbZSJYyz7dOI7Bj3ZSgGY7PFyO9aVIFrR6373nRHK5Ts
         kG5jEzPW4XVTlsc2okptZQShL91cW/4bCRwxmHWlgFT1ooD/JLXfk0BljXq6lTI4dpUX
         /WIcFYMmgNbLZQn5Tan6hD9Edt7aU9vc2leZUqJ65G+DEC5jjyNLjgVaMuBh9rGI7/wR
         nnJirDE/0RezCgMjXJsd1I0JoCPyXxxDI4LQQt3nD7QQ1BmRn7L3m0Lx8PF2JMsBWrOi
         vvu9B+Uic22gv3M6bN7buo/hGx2YnLv0hy+SaQhl22TUU4mp0iwYWox5VLh2dz4eDpnS
         ZzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936990; x=1697541790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POL8IbM7Vi2ralIIYuoAFWFBsY0Txlw06bqhpyC2YkY=;
        b=d+AzUdl+Cl2mfsyaG06t8IsFpxsizhlxvnTaISWFAbRDJLQFyFqc0n119bKHdnZmi5
         OL+vTsDdDx2ZSKF2Re4YUc48VP4FHDeMOxEIUriJ3XrTuGxM5pOP0X4q7ihNOz9dTNv1
         uN2koyrIR1627miREOE1+nTRr48go5lPirfg8cAeka1yQEQ7adKISyWUt54PssaYzmjT
         sI0G719vWAcRBo5gOAOxRHIgugkxl6uvPRbZ1jNjJyxZDwP/76Nf8Bg79yiuMRB9AHmX
         XKr0buWQhMvjyoHQeUgj1sldXwbmVRq67p++IEqiP7GtkvxB1RR8KF/pbxMwAWD34dKp
         f0qQ==
X-Gm-Message-State: AOJu0Yw8DeFlbElZDAX/+Dy5UwHfAXR9sT6MUUrPM1uAsKb0RXD/URz/
        nXwTpduwrU5dBLtlOHTpnqEnPX2jk/LW+tjmcwXA0A==
X-Google-Smtp-Source: AGHT+IFbe/BR4rGJZ9CNDr1L7sum4DGjtasG+J3vWK5cy1rKo91hDdGB2Ve+4cAMZUoNWzW7lzEuUTAz+PjWx9MaA/U=
X-Received: by 2002:a25:d650:0:b0:bfe:e383:6297 with SMTP id
 n77-20020a25d650000000b00bfee3836297mr17630043ybg.19.1696936990135; Tue, 10
 Oct 2023 04:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231006224614.444488-1-robh@kernel.org>
In-Reply-To: <20231006224614.444488-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 13:22:33 +0200
Message-ID: <CAPDyKFpi9SBkmzWx10bjSNVUJoTQxTrbmzAy=i78tnmDqQ5sUw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 at 00:46, Rob Herring <robh@kernel.org> wrote:
>
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/actions/owl-sps.c     | 16 +++++-----------
>  drivers/pmdomain/imx/gpc.c             |  7 +++----
>  drivers/pmdomain/rockchip/pm-domains.c | 13 ++++---------
>  3 files changed, 12 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/pmdomain/actions/owl-sps.c b/drivers/pmdomain/action=
s/owl-sps.c
> index 73a9e0bb7e8e..3a586d1f3256 100644
> --- a/drivers/pmdomain/actions/owl-sps.c
> +++ b/drivers/pmdomain/actions/owl-sps.c
> @@ -8,8 +8,10 @@
>   * Copyright (c) 2017 Andreas F=C3=A4rber
>   */
>
> +#include <linux/mod_devicetable.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/pm_domain.h>
>  #include <linux/soc/actions/owl-sps.h>
>  #include <dt-bindings/power/owl-s500-powergate.h>
> @@ -96,24 +98,16 @@ static int owl_sps_init_domain(struct owl_sps *sps, i=
nt index)
>
>  static int owl_sps_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *match;
>         const struct owl_sps_info *sps_info;
>         struct owl_sps *sps;
>         int i, ret;
>
> -       if (!pdev->dev.of_node) {
> -               dev_err(&pdev->dev, "no device node\n");
> -               return -ENODEV;
> -       }
> -
> -       match =3D of_match_device(pdev->dev.driver->of_match_table, &pdev=
->dev);
> -       if (!match || !match->data) {
> +       sps_info =3D device_get_match_data(&pdev->dev);
> +       if (!sps_info) {
>                 dev_err(&pdev->dev, "unknown compatible or missing data\n=
");
>                 return -EINVAL;
>         }
>
> -       sps_info =3D match->data;
> -
>         sps =3D devm_kzalloc(&pdev->dev,
>                            struct_size(sps, domains, sps_info->num_domain=
s),
>                            GFP_KERNEL);
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 90a8b2c0676f..114f44ca07dd 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -7,9 +7,10 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>
> @@ -403,9 +404,7 @@ static int imx_gpc_old_dt_init(struct device *dev, st=
ruct regmap *regmap,
>
>  static int imx_gpc_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id =3D
> -                       of_match_device(imx_gpc_dt_ids, &pdev->dev);
> -       const struct imx_gpc_dt_data *of_id_data =3D of_id->data;
> +       const struct imx_gpc_dt_data *of_id_data =3D device_get_match_dat=
a(&pdev->dev);
>         struct device_node *pgc_node;
>         struct regmap *regmap;
>         void __iomem *base;
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index d5d3ecb38283..9b76b62869d0 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -9,11 +9,13 @@
>  #include <linux/iopoll.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_clock.h>
>  #include <linux/pm_domain.h>
> +#include <linux/property.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_clk.h>
> -#include <linux/of_platform.h>
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
> @@ -857,7 +859,6 @@ static int rockchip_pm_domain_probe(struct platform_d=
evice *pdev)
>         struct device_node *node;
>         struct device *parent;
>         struct rockchip_pmu *pmu;
> -       const struct of_device_id *match;
>         const struct rockchip_pmu_info *pmu_info;
>         int error;
>
> @@ -866,13 +867,7 @@ static int rockchip_pm_domain_probe(struct platform_=
device *pdev)
>                 return -ENODEV;
>         }
>
> -       match =3D of_match_device(dev->driver->of_match_table, dev);
> -       if (!match || !match->data) {
> -               dev_err(dev, "missing pmu data\n");
> -               return -EINVAL;
> -       }
> -
> -       pmu_info =3D match->data;
> +       pmu_info =3D device_get_match_data(dev);
>
>         pmu =3D devm_kzalloc(dev,
>                            struct_size(pmu, domains, pmu_info->num_domain=
s),
> --
> 2.40.1
>
