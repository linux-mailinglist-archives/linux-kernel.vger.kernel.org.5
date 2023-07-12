Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3B75139E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGLWfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLWfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:35:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB91BC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:35:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b74310566cso4932601fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1689201299; x=1691793299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo+AuBazBBma5lhXFCuSEUC/eob8+XeqoZeTuSTYYhw=;
        b=v4hi5KRh5A5ELc8TWdKAsqzZDa9Yx8vwW3UODKmy5Gq8WYBBDQh16vMooOERuLMJrc
         5s8rk2gy/R63ujY6vhSQuZHuf9IztmP+LyiQLoPwsOesXYDIqXUvVh1YbpFKLXvpn1aU
         DkB7hwAs1TuZ7BoJ4+UYyKOPuOMc/FKVRxDxJRqhsuWT8D04n+luB7VrozzQ574GFvR0
         Lg08GWpkGz7uK522/sJmkCNpOdZjU4iojq2zBtylmQxVpqvyvWjfHwbLB2uOhlQVSdeb
         NKUuR46DimA82AjlEqO+BV7sOngIRbsQKcLLeAxMM7hlv9sVcKsDw5236F9UixaVx4nP
         p19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201299; x=1691793299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xo+AuBazBBma5lhXFCuSEUC/eob8+XeqoZeTuSTYYhw=;
        b=SXvr4fVRdfigsLRxz+O2Cs8TfjrmQDMjzGKpbjALQD7ZSoLVMevzguCz7yWNJFRvaN
         nRWS+KyEVXsb9FGrmnoL3y+V0yfU29hw6vWvjg+feNrjKlMhcsWGXyFuHSfaHWNXbVrS
         r2tJjUKhGYL3ouannqZLcALJdXbKGCKsqs/Pbh772tfECGywviiSLzR482Zue257IS5G
         SqFXoJQ7FRiP/WTwRIJVvGjMgiPHesv/DTRNuGO5x3iOMkWj7pbZy0lrVaQgjVJ+M4qz
         awyv9RkNt0gWXrIMsusGp+Ll0A7suD43Wxr/scas3qBGMzojw16FNLDGmSGjFpqIG3gE
         3HTw==
X-Gm-Message-State: ABy/qLapXouQrLn51+bH87LMqrbOwgYvN4PDGMHYoAu7UNYfXGXDcZcM
        CuhwSTuNapwiFcg9Pa6+KDbMWGNR+C4f8a2kuaZ3sA==
X-Google-Smtp-Source: APBJJlF+VBJNI/+IW7K9oXd8Djz5buz/FV+OFOvmCkudFD+8nGsN8IP3/+jawcUcoemYUnf2LgQyHSLlDXb4jswH8rk=
X-Received: by 2002:a2e:9f42:0:b0:2b6:d63d:cc22 with SMTP id
 v2-20020a2e9f42000000b002b6d63dcc22mr18295756ljk.29.1689201298793; Wed, 12
 Jul 2023 15:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230503163313.2640898-1-frieder@fris.de> <20230503163313.2640898-2-frieder@fris.de>
In-Reply-To: <20230503163313.2640898-2-frieder@fris.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 12 Jul 2023 15:34:47 -0700
Message-ID: <CAJ+vNU2d969V1kTHpH+tPK1fm=Z2DUdKSOjwyzRO=9j43HhKgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: bridge: samsung-dsim: Fix i.MX8M enable flow
 to meet spec
To:     Frieder Schrempf <frieder@fris.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Marek Vasut <marex@denx.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 9:33=E2=80=AFAM Frieder Schrempf <frieder@fris.de> w=
rote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> According to the documentation [1] the proper enable flow is:
>
> 1. Enable DSI link and keep data lanes in LP-11 (stop state)
> 2. Disable stop state to bring data lanes into HS mode
>
> Currently we do this all at once within enable(), which doesn't
> allow to meet the requirements of some downstream bridges.
>
> To fix this we now enable the DSI in pre_enable() and force it
> into stop state using the FORCE_STOP_STATE bit in the ESCMODE
> register until enable() is called where we reset the bit.
>
> We currently do this only for i.MX8M as Exynos uses a different
> init flow where samsung_dsim_init() is called from
> samsung_dsim_host_transfer().
>
> [1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-oper=
ation
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
> * Drop RFC
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e0a402a85787..9775779721d9 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -859,6 +859,10 @@ static int samsung_dsim_init_link(struct samsung_dsi=
m *dsi)
>         reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
>         reg &=3D ~DSIM_STOP_STATE_CNT_MASK;
>         reg |=3D DSIM_STOP_STATE_CNT(driver_data->reg_values[STOP_STATE_C=
NT]);
> +
> +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> +               reg |=3D DSIM_FORCE_STOP_STATE;
> +
>         samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
>
>         reg =3D DSIM_BTA_TIMEOUT(0xff) | DSIM_LPDR_TIMEOUT(0xffff);
> @@ -1340,6 +1344,9 @@ static void samsung_dsim_atomic_pre_enable(struct d=
rm_bridge *bridge,
>                 ret =3D samsung_dsim_init(dsi);
>                 if (ret)
>                         return;
> +
> +               samsung_dsim_set_display_mode(dsi);
> +               samsung_dsim_set_display_enable(dsi, true);
>         }
>  }
>
> @@ -1347,9 +1354,16 @@ static void samsung_dsim_atomic_enable(struct drm_=
bridge *bridge,
>                                        struct drm_bridge_state *old_bridg=
e_state)
>  {
>         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> +       u32 reg;
>
> -       samsung_dsim_set_display_mode(dsi);
> -       samsung_dsim_set_display_enable(dsi, true);
> +       if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> +               samsung_dsim_set_display_mode(dsi);
> +               samsung_dsim_set_display_enable(dsi, true);
> +       } else {
> +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> +               reg &=3D ~DSIM_FORCE_STOP_STATE;
> +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> +       }
>
>         dsi->state |=3D DSIM_STATE_VIDOUT_AVAILABLE;
>  }
> @@ -1358,10 +1372,17 @@ static void samsung_dsim_atomic_disable(struct dr=
m_bridge *bridge,
>                                         struct drm_bridge_state *old_brid=
ge_state)
>  {
>         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> +       u32 reg;
>
>         if (!(dsi->state & DSIM_STATE_ENABLED))
>                 return;
>
> +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> +               reg |=3D DSIM_FORCE_STOP_STATE;
> +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> +       }
> +
>         dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
>  }
>
> --
> 2.40.0
>

Hi Frieder,

I found this patch to break mipi-dsi display on my board which has:
 - FocalTech FT5406 10pt touch controller (with no interrupt)
 - Powertip PH800480T013-IDF02 compatible panel
 - Toshiba TC358762 compatible DSI to DBI bridge
 - ATTINY based regulator used for backlight controller and panel enable

I enable this via a dt overlay in a pending patch
imx8mm-venice-gw72xx-0x-rpidsi.dtso [1] which works on 6.4 but not
6.5-rc1 which has this patch.

The issue appears as:
[    6.110585] samsung-dsim 32e60000.dsi: xfer timed out: 29 06 00 00
64 01 05 00 00 00
[    6.326588] tc358762 32e60000.dsi.0: error initializing bridge (-110)

Instead of
[    1.011729] samsung-dsim 32e10000.dsi: supply vddcore not found,
using dummy regulator
[    1.019829] samsung-dsim 32e10000.dsi: supply vddio not found,
using dummy regulator
[    5.649928] samsung-dsim 32e10000.dsi:
[drm:samsung_dsim_host_attach] Attached tc358762 device

I'm curious what board/panel were you needing this for and do you have
any ideas why it broke my setup?

I'm also curious what board/panel Alexander tested this with and if
Adam or Jagan (or others) have tested this with their hardware?

best regards,

Tim
[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230711221=
124.2127186-1-tharvey@gateworks.com/
