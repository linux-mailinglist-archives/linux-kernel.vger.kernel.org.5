Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733B77518B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjGMGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGMGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:22:09 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E52B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689229327; x=1720765327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRD8z5/I2QiQQmKcjCasKRz8JpYpocmZfX3nkkeKWNY=;
  b=lpbjE9DEOQoh1shno6ZXdoM0fjqsFFbOdc2AWacRtEZ5TdcBpamsPwK1
   OA096g8T2bClj0hLglkHlJZyNHc1fqsFGY/L7ytCWvLM8B3KezriSjZ5Q
   vG3xpiRKNnSRpUPDAFdR1SuYmF+JOwYWU+QQy5PHDfyf+Pzy5P0Z+rJyl
   OOeJhwa35Vr9KReZaUcuSXzruCdTmwcoaDUM0d93/iALhtDvh9TotaYO3
   H3C+LywQlLUVV2WZU2zGsV0LMuN8wf1Fr5pKhgrxL5uelqediAg9+3o7r
   Kg6MpDYe9PL4qkrHkDWo7aGaMr0cPv+EeuB4ah8Csvcv7+OyjX7vHLYUp
   g==;
X-IronPort-AV: E=Sophos;i="6.01,201,1684792800"; 
   d="scan'208";a="31903351"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Jul 2023 08:22:05 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id D7DC7280078;
        Thu, 13 Jul 2023 08:22:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Frieder Schrempf <frieder@fris.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
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
Subject: Re: [PATCH v2 1/2] drm: bridge: samsung-dsim: Fix i.MX8M enable flow to meet spec
Date:   Thu, 13 Jul 2023 08:22:03 +0200
Message-ID: <15446320.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAJ+vNU2d969V1kTHpH+tPK1fm=Z2DUdKSOjwyzRO=9j43HhKgg@mail.gmail.com>
References: <20230503163313.2640898-1-frieder@fris.de> <20230503163313.2640898-2-frieder@fris.de> <CAJ+vNU2d969V1kTHpH+tPK1fm=Z2DUdKSOjwyzRO=9j43HhKgg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 13. Juli 2023, 00:34:47 CEST schrieb Tim Harvey:
> On Wed, May 3, 2023 at 9:33=E2=80=AFAM Frieder Schrempf <frieder@fris.de>=
 wrote:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >=20
> > According to the documentation [1] the proper enable flow is:
> >=20
> > 1. Enable DSI link and keep data lanes in LP-11 (stop state)
> > 2. Disable stop state to bring data lanes into HS mode
> >=20
> > Currently we do this all at once within enable(), which doesn't
> > allow to meet the requirements of some downstream bridges.
> >=20
> > To fix this we now enable the DSI in pre_enable() and force it
> > into stop state using the FORCE_STOP_STATE bit in the ESCMODE
> > register until enable() is called where we reset the bit.
> >=20
> > We currently do this only for i.MX8M as Exynos uses a different
> > init flow where samsung_dsim_init() is called from
> > samsung_dsim_host_transfer().
> >=20
> > [1]
> > https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operat=
io
> > n
> >=20
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > ---
> > Changes for v2:
> > * Drop RFC
> > ---
> >=20
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> > b/drivers/gpu/drm/bridge/samsung-dsim.c index e0a402a85787..9775779721d9
> > 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -859,6 +859,10 @@ static int samsung_dsim_init_link(struct samsung_d=
sim
> > *dsi)>=20
> >         reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> >         reg &=3D ~DSIM_STOP_STATE_CNT_MASK;
> >         reg |=3D
> >         DSIM_STOP_STATE_CNT(driver_data->reg_values[STOP_STATE_CNT]);
> >=20
> > +
> > +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> > +               reg |=3D DSIM_FORCE_STOP_STATE;
> > +
> >=20
> >         samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> >        =20
> >         reg =3D DSIM_BTA_TIMEOUT(0xff) | DSIM_LPDR_TIMEOUT(0xffff);
> >=20
> > @@ -1340,6 +1344,9 @@ static void samsung_dsim_atomic_pre_enable(struct
> > drm_bridge *bridge,>=20
> >                 ret =3D samsung_dsim_init(dsi);
> >                 if (ret)
> >                =20
> >                         return;
> >=20
> > +
> > +               samsung_dsim_set_display_mode(dsi);
> > +               samsung_dsim_set_display_enable(dsi, true);
> >=20
> >         }
> > =20
> >  }
> >=20
> > @@ -1347,9 +1354,16 @@ static void samsung_dsim_atomic_enable(struct
> > drm_bridge *bridge,>=20
> >                                        struct drm_bridge_state
> >                                        *old_bridge_state)
> > =20
> >  {
> > =20
> >         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> >=20
> > +       u32 reg;
> >=20
> > -       samsung_dsim_set_display_mode(dsi);
> > -       samsung_dsim_set_display_enable(dsi, true);
> > +       if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> > +               samsung_dsim_set_display_mode(dsi);
> > +               samsung_dsim_set_display_enable(dsi, true);
> > +       } else {
> > +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> > +               reg &=3D ~DSIM_FORCE_STOP_STATE;
> > +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> > +       }
> >=20
> >         dsi->state |=3D DSIM_STATE_VIDOUT_AVAILABLE;
> > =20
> >  }
> >=20
> > @@ -1358,10 +1372,17 @@ static void samsung_dsim_atomic_disable(struct
> > drm_bridge *bridge,>=20
> >                                         struct drm_bridge_state
> >                                         *old_bridge_state)
> > =20
> >  {
> > =20
> >         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> >=20
> > +       u32 reg;
> >=20
> >         if (!(dsi->state & DSIM_STATE_ENABLED))
> >        =20
> >                 return;
> >=20
> > +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> > +               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> > +               reg |=3D DSIM_FORCE_STOP_STATE;
> > +               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> > +       }
> > +
> >=20
> >         dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
> > =20
> >  }
> >=20
> > --
> > 2.40.0
>=20
> Hi Frieder,
>=20
> I found this patch to break mipi-dsi display on my board which has:
>  - FocalTech FT5406 10pt touch controller (with no interrupt)
>  - Powertip PH800480T013-IDF02 compatible panel
>  - Toshiba TC358762 compatible DSI to DBI bridge
>  - ATTINY based regulator used for backlight controller and panel enable
>=20
> I enable this via a dt overlay in a pending patch
> imx8mm-venice-gw72xx-0x-rpidsi.dtso [1] which works on 6.4 but not
> 6.5-rc1 which has this patch.
>=20
> The issue appears as:
> [    6.110585] samsung-dsim 32e60000.dsi: xfer timed out: 29 06 00 00
> 64 01 05 00 00 00
> [    6.326588] tc358762 32e60000.dsi.0: error initializing bridge (-110)
>=20
> Instead of
> [    1.011729] samsung-dsim 32e10000.dsi: supply vddcore not found,
> using dummy regulator
> [    1.019829] samsung-dsim 32e10000.dsi: supply vddio not found,
> using dummy regulator
> [    5.649928] samsung-dsim 32e10000.dsi:
> [drm:samsung_dsim_host_attach] Attached tc358762 device
>=20
> I'm curious what board/panel were you needing this for and do you have
> any ideas why it broke my setup?
>=20
> I'm also curious what board/panel Alexander tested this with and if
> Adam or Jagan (or others) have tested this with their hardware?

I tested this with imx8mm and ti,sn65dsi83 DSI-LVDS bridge [1]. I don't kno=
w=20
anything about tc358762, but I was trying to get tc9595 (DSI-DP bridge)=20
running on a imx8mp based board. One of my problems was that the bridge=20
requires LP-11 before reset release, which is currently not given using=20
samsung-dsim and tc358767 driver. Maybe this is the case for you as well.
AFAICS there is a lot more to do to get this running properly.

Best regards,
Alexander

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/
arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl-lvds.dtso

> best regards,
>=20
> Tim
> [1]
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/2023071122112=
4.
> 2127186-1-tharvey@gateworks.com/


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


