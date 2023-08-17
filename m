Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CA377FF57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355064AbjHQUyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355085AbjHQUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:53:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169030F6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:53:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99cce6f7de2so21949666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1692305631; x=1692910431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e89TAMIXWhcZFXR08sXDuvAu7JVEt8FXn/MAq0gJOI=;
        b=yAwALMRJb55LK+7AqVo3XTm67NmuDrUrmFBEIldRJvym/kFSOttffNbh/v4/ewUhDt
         keAElTfZl8fpeYxVY7GL+79nzuZveX78vAhV1AFBbiXV6gtn2k2Mc+G0l8Jjwuzq4/Iz
         vOZuUw644Jmfls+dzSZbtjGvywxMdlvBQa9lPhzgxBnqR1r996FLKGcVvakoxeBHMf1w
         rrQhqfywbth/z8fvcA50XFgMFbv820PfWRRp3ICEcPWR3amhs5/xxXa21P7l0VutFbfK
         gr/SvTu1rljhCwVzlSjZlzXq+SjddnM/Pa0dbcE3Qr80OcLAGQcLVoEiz8Mi4BtmHVUt
         1kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305631; x=1692910431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3e89TAMIXWhcZFXR08sXDuvAu7JVEt8FXn/MAq0gJOI=;
        b=RpMdU2v8JUqNW89hsa5gQ7v3WVelZ72kbMHqzIZr75y2roA60tgDRVv6i/5KHCvjfb
         m0G9K1Go2U+odqQs+1Nu+rUzynbDikg9m24jBXGXiLhwk5ekMn5VfMz5QnOdytKup+lU
         wB1rD0zvBC4Eq/D/MdoVeuH57yT05RYeMV966uyB7o9chrq964Zw6emUZFBQOtHPTOcZ
         Q+sFXVHWP8r6bBbeZVkqzsBV6XaSw5NSe1xRumvnan0mnytuOqZ+a42zU9ZrOw8jkJTl
         u29P+9Xc1yhPgwlo/HlJkUVlcDttl7WmYRuR7F+Z5NB74nI0bTRMD0QpyVCc9SH0xN+b
         M8Wg==
X-Gm-Message-State: AOJu0YzFQze2GD0DyESpoa1XJz7cIZ2q3NKoiZk1uMpyggJBXIPc16t7
        EdKBNLr9CBqdVLVl8J013/YT8A8Pgm3NkTFVtZHoMA==
X-Google-Smtp-Source: AGHT+IGBwRPf3LI/dHSp6P7+b5mnurUD3p7EvQbJgicflycdmh7k4igbCkMELWSKp6WeUTuERwUPNuj2RflfhewRHLY=
X-Received: by 2002:a17:906:844a:b0:99d:f53c:3aec with SMTP id
 e10-20020a170906844a00b0099df53c3aecmr441726ejy.38.1692305631123; Thu, 17 Aug
 2023 13:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230724151640.555490-1-frieder@fris.de>
In-Reply-To: <20230724151640.555490-1-frieder@fris.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 17 Aug 2023 13:53:38 -0700
Message-ID: <CAJ+vNU27A15eLWtFfHCOVn8JgawcgoGUAv2PhKmEf3wcoerPXg@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: samsung-dsim: Fix init during host transfer
To:     Frieder Schrempf <frieder@fris.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Adam Ford <aford173@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 8:16=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> In case the downstream bridge or panel uses DSI transfers before the
> DSI host was actually initialized through samsung_dsim_atomic_enable()
> which clears the stop state (LP11) mode, all transfers will fail.
>
> This happens with downstream bridges that are controlled by DSI
> commands such as the tc358762.
>
> As documented in [1] DSI hosts are expected to allow transfers
> outside the normal bridge enable/disable flow.
>
> To fix this make sure that stop state is cleared in
> samsung_dsim_host_transfer() which restores the previous
> behavior.
>
> We also factor out the common code to enable/disable stop state
> to samsung_dsim_set_stop_state().
>
> [1] https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-oper=
ation
>
> Fixes: 0c14d3130654 ("drm: bridge: samsung-dsim: Fix i.MX8M enable flow t=
o meet spec")
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes for v2:
>   * Fix reversed stop state enable/disable in samsung_dsim_set_stop_state=
()
>
> Hi Tim, could you please give this patch a try and report back if
> it fixes your problem? Thanks!
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 043b8109e64a..73ec60757dbc 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1386,6 +1386,18 @@ static void samsung_dsim_disable_irq(struct samsun=
g_dsim *dsi)
>         disable_irq(dsi->irq);
>  }
>
> +static void samsung_dsim_set_stop_state(struct samsung_dsim *dsi, bool e=
nable)
> +{
> +       u32 reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> +
> +       if (enable)
> +               reg |=3D DSIM_FORCE_STOP_STATE;
> +       else
> +               reg &=3D ~DSIM_FORCE_STOP_STATE;
> +
> +       samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> +}
> +
>  static int samsung_dsim_init(struct samsung_dsim *dsi)
>  {
>         const struct samsung_dsim_driver_data *driver_data =3D dsi->drive=
r_data;
> @@ -1445,15 +1457,12 @@ static void samsung_dsim_atomic_enable(struct drm=
_bridge *bridge,
>                                        struct drm_bridge_state *old_bridg=
e_state)
>  {
>         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> -       u32 reg;
>
>         if (samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
>                 samsung_dsim_set_display_mode(dsi);
>                 samsung_dsim_set_display_enable(dsi, true);
>         } else {
> -               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> -               reg &=3D ~DSIM_FORCE_STOP_STATE;
> -               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> +               samsung_dsim_set_stop_state(dsi, false);
>         }
>
>         dsi->state |=3D DSIM_STATE_VIDOUT_AVAILABLE;
> @@ -1463,16 +1472,12 @@ static void samsung_dsim_atomic_disable(struct dr=
m_bridge *bridge,
>                                         struct drm_bridge_state *old_brid=
ge_state)
>  {
>         struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
> -       u32 reg;
>
>         if (!(dsi->state & DSIM_STATE_ENABLED))
>                 return;
>
> -       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type)) {
> -               reg =3D samsung_dsim_read(dsi, DSIM_ESCMODE_REG);
> -               reg |=3D DSIM_FORCE_STOP_STATE;
> -               samsung_dsim_write(dsi, DSIM_ESCMODE_REG, reg);
> -       }
> +       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
> +               samsung_dsim_set_stop_state(dsi, true);
>
>         dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
>  }
> @@ -1775,6 +1780,8 @@ static ssize_t samsung_dsim_host_transfer(struct mi=
pi_dsi_host *host,
>         if (ret)
>                 return ret;
>
> +       samsung_dsim_set_stop_state(dsi, false);
> +
>         ret =3D mipi_dsi_create_packet(&xfer.packet, msg);
>         if (ret < 0)
>                 return ret;
> --
> 2.41.0
>

Frieder,

Sorry for the delay. Yes this resolves the regression I ran into. I
tested it on top of v6.5-rc6 on a gw72xx-0x with a DFROBOT DRF0678 7in
800x480 (Raspberry Pi) display which has the Toshiba TC358762
compatible DSI to DBI bridge.

Let's please get this into v6.5 as soon as possible.

Best regards,

Tim
