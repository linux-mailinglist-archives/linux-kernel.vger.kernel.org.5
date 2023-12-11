Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8684180D3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbjLKRcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344543AbjLKRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:32:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B52C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:32:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2283C433CB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702315977;
        bh=Lj2UpbE5cpbZnGKwwOZBgJWBP/YWAZRvQhiZ+6k83ls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W16uTtUlG7SeFPGRm3CCuc2Oop+KBJQ6Xa5b5H8u1/HtQCIrREB7vbPN8RFi4Ne/R
         dh4RQAj86qlua0L9ifnnCt6Jgi/RZs9IS9FSCCCsuV9qN3pcBBNiTEBCdGXHDmeV8s
         3T5UKB/OTm42v3NsQsRGldKHFubiR9Ct2lPAcN4vekjjsfX8jHRcX7VnhD/vhEpe9h
         1H1Xa6jvsa3+z5F5GuYdve0PfKUXKGIow/BufN63sgw981QMNzBaRhmr8jrnqXmDoB
         suAgIjxEzLhJJg8UZcZoK8Km88nv7iYHBhFcslOtjLocUTIkVsal0pHln9Rd1PQA+H
         5w83OwhCENHGQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso5385374e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:32:57 -0800 (PST)
X-Gm-Message-State: AOJu0YzCoIinKQIUprd21RwFlAb61XjDEkHjEBitKprA/LfWMA69oBLq
        lyDMXbaQB7dTFxZwnVTIZ8rG6BKsGFJ54VuNzw==
X-Google-Smtp-Source: AGHT+IHGvwmqfinxE26puG6zIXyk2PdfJU9Mt+NHOHO99VlGx42Q/aTIbEFneEOi/1zV/FWLbUqT2tbQZNunVP6uGd4=
X-Received: by 2002:a05:6512:b20:b0:50d:f81e:6872 with SMTP id
 w32-20020a0565120b2000b0050df81e6872mr1480473lfu.10.1702315975908; Mon, 11
 Dec 2023 09:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com> <20231207141723.108004-9-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231207141723.108004-9-dario.binacchi@amarulasolutions.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Dec 2023 11:32:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLeONsA_JOa9D8cpCwfwv16sBy5Tr3GAChboJekKuvm2w@mail.gmail.com>
Message-ID: <CAL_JsqLeONsA_JOa9D8cpCwfwv16sBy5Tr3GAChboJekKuvm2w@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] drm/panel: Add Ilitek ILI9805 panel driver
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        michael@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 8:17=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> The GPM1790A0 panel is based on the Ilitek ILI9805 Controller.
> Add a driver for it.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - Remove duplicated code for prepare/unprepare callbacks
>
>  MAINTAINERS                                  |   6 +
>  drivers/gpu/drm/panel/Kconfig                |   9 +
>  drivers/gpu/drm/panel/Makefile               |   1 +
>  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 353 +++++++++++++++++++
>  4 files changed, 369 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9805.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b82dc141d209..4dccc72a0ed6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6646,6 +6646,12 @@ T:       git git://anongit.freedesktop.org/drm/drm=
-misc
>  F:     Documentation/devicetree/bindings/display/ilitek,ili9486.yaml
>  F:     drivers/gpu/drm/tiny/ili9486.c
>
> +DRM DRIVER FOR ILITEK ILI9805 PANELS
> +M:     Michael Trimarchi <michael@amarulasolutions.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/display/panel/ilitek,ili9805.ya=
ml
> +F:     drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> +
>  DRM DRIVER FOR JADARD JD9365DA-H3 MIPI-DSI LCD PANELS
>  M:     Jagan Teki <jagan@edgeble.ai>
>  S:     Maintained
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfi=
g
> index d018702be3dc..dad938cf6dec 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -194,6 +194,15 @@ config DRM_PANEL_ILITEK_ILI9341
>           QVGA (240x320) RGB panels. support serial & parallel rgb
>           interface.
>
> +config DRM_PANEL_ILITEK_ILI9805
> +       tristate "Ilitek ILI9805-based panels"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE
> +       help
> +         Say Y if you want to enable support for panels based on the
> +         Ilitek ILI9805 controller.
> +
>  config DRM_PANEL_ILITEK_ILI9881C
>         tristate "Ilitek ILI9881C-based panels"
>         depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index f267d932c2b5..d94a644d0a6c 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) +=3D pa=
nel-feiyang-fy07024di26a30d
>  obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) +=3D panel-himax-hx8394.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) +=3D panel-ilitek-ili9322.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9341) +=3D panel-ilitek-ili9341.o
> +obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9805) +=3D panel-ilitek-ili9805.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) +=3D panel-ilitek-ili9881c.o
>  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9882T) +=3D panel-ilitek-ili9882t.o
>  obj-$(CONFIG_DRM_PANEL_INNOLUX_EJ030NA) +=3D panel-innolux-ej030na.o
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/d=
rm/panel/panel-ilitek-ili9805.c
> new file mode 100644
> index 000000000000..e36984b46e14
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 BSH Hausgerate GmbH
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fb.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

Rob
