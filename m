Return-Path: <linux-kernel+bounces-55495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A744884BD65
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C421C24D40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0B214003;
	Tue,  6 Feb 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWMwKVzY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F36ABA;
	Tue,  6 Feb 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245430; cv=none; b=Q2rYTMRyIik6uOjwq1uIdM0TR06yQ9PgCFwqRpRXd2N3+/Mqpza/tYVIvi0Loh9fCUqm9SyRefFkVWCkoQ9VECFaBdiR7X4sJfXG0+y0juUXwhJy9QsPp/fJ3rBv95y+NS84xYMEkiXJv/C4gIZq1Uft9B+fSjji750Yr6bAgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245430; c=relaxed/simple;
	bh=39JGumuJFV1iKne13aiVpCuPKyWknv6UBw07siBgN2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dL0Hx8iy5GMrci3sAhih95jyZUkCVSxstJAcQ5UZ/Qh+UgC6HguSftzBGBJ3fuI28Vyjxi+KMFPwSSBl6I3aHwPRNMZaMybViDeef8VzJupMOx5v4BTDWJPZro8r2qp0UXOh6I/ffax6DanUPnxlpjQSHdM64R/WjN/Zuz6vQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWMwKVzY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da9c834646so4767500b3a.3;
        Tue, 06 Feb 2024 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707245428; x=1707850228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04H/P6C7O8nfc1XeC8v5p8UgUl9tQRxBxfBvOdudh+M=;
        b=PWMwKVzYMAHaNmM1qHdY/I/ZfaFoPMAdtUyP22EhQA28lC9yx1sWJ53nvwkB58h7gt
         38+Aw2GKH+9v8YTEKPCV/4QWk6leGjuqkvoNBk0wk0KWnSO2OiB/t+IwIw9iSbMkC+/K
         g8jnVf5rGK1k/emX4RhMLZc+Z7f0y7pbcVr9Q3ayzXsK3fZD/9narSYQsjufIii3DGWX
         MHkqThoTZy/gpwNz/wTkGZYsEpN4LMsa8u2ti+1+p2VaHDXJmrCa9OySwvXvQ1WnWZxO
         UFNWVFQ2CfB6XU9VPWXrZTmzR4F0KsDiyJWXgwmO1oLFr6HKvDUnxv+vDa4pn3EZpLS0
         61LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245428; x=1707850228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04H/P6C7O8nfc1XeC8v5p8UgUl9tQRxBxfBvOdudh+M=;
        b=l5SHmYEF30+1KPuX9URI0ho0qv54TVoRaHZ7MbcRAiZKH8ncHXhYegElnsh6Dkd5zR
         gMqsTYpw+ggc1CRw8jVKDvshAMpRJEBZOdepWIlR1FOb0RtJt3HmthMvzoWuqMmtvFXb
         X7Kckx9RriwH7BDTD3OlwHLkGLvHPacurewAuf2c3PSlBTxSD+7dwRRNnHY567BFhxr0
         MohIUCKYn3X3exXAvdeSuUSYmk7R80iss+eWpohCXizkvSqD/Gs/euSIBDctYIu1jMxz
         Ta+2QAUNK35NUTvzaqpIzA4hn8c3VRV0occGyRR2e4wES78WNcJzqDuGHRv+KChMIPxi
         QH0g==
X-Gm-Message-State: AOJu0YzucNdMHq6VOUhxX4b+DgLJZy9aGGmPVnPLGkWN6ZxRixyFjY8c
	WVtCjTjQYwZK/9XC66pIx4O5w4gRW6q/ggKl3LudeuSRLfZZu3F/8tROEI/8/X368B82BYkd/vO
	zx6nmmF9ell2nxEo62lw1CJL2PxU=
X-Google-Smtp-Source: AGHT+IFew76+8/ONbppJJ5WidlzjDP61Dg+kG6gaTcWUbl+84Ejsp+SlpxQLfB/R2PqIEfDeyhbfqm2nzrGeNSGeDLs=
X-Received: by 2002:a05:6a00:994:b0:6e0:3f2d:4c04 with SMTP id
 u20-20020a056a00099400b006e03f2d4c04mr433802pfg.23.1707245427825; Tue, 06 Feb
 2024 10:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-9-aford173@gmail.com>
 <20240206170632.GA2183819@dev-arch.thelio-3990X>
In-Reply-To: <20240206170632.GA2183819@dev-arch.thelio-3990X>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 6 Feb 2024 12:50:16 -0600
Message-ID: <CAHCN7x+Jt8Qfyjxg=TasUgezA3ZDk=6mFZkMyFEwk2Evt-6c5Q@mail.gmail.com>
Subject: Re: [PATCH V8 08/12] drm/bridge: imx: add driver for HDMI TX Parallel
 Video Interface
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de, 
	alexander.stein@ew.tq-group.com, frieder.schrempf@kontron.de, 
	Lucas Stach <l.stach@pengutronix.de>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Richard Leitner <richard.leitner@skidata.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Fabio Estevam <festevam@gmail.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:06=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi all,
>
> On Sat, Feb 03, 2024 at 10:52:48AM -0600, Adam Ford wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This IP block is found in the HDMI subsystem of the i.MX8MP SoC. It has=
 a
> > full timing generator and can switch between different video sources. O=
n
> > the i.MX8MP however the only supported source is the LCDIF. The block
> > just needs to be powered up and told about the polarity of the video
> > sync signals to act in bypass mode.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v7)
> > Tested-by: Marek Vasut <marex@denx.de> (v1)
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v7)
> > Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> (v2)
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> (v3)
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Tested-by: Fabio Estevam <festevam@gmail.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> <snip>
>
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu=
/drm/bridge/imx/imx8mp-hdmi-pvi.c
> > new file mode 100644
> > index 000000000000..a76b7669fe8a
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> ...
> > +static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
> > +                                       struct drm_bridge_state *bridge=
_state)
> > +{
> > +     struct drm_atomic_state *state =3D bridge_state->base.state;
> > +     struct imx8mp_hdmi_pvi *pvi =3D to_imx8mp_hdmi_pvi(bridge);
> > +     struct drm_connector_state *conn_state;
> > +     const struct drm_display_mode *mode;
> > +     struct drm_crtc_state *crtc_state;
> > +     struct drm_connector *connector;
> > +     u32 bus_flags, val;
> > +
> > +     connector =3D drm_atomic_get_new_connector_for_encoder(state, bri=
dge->encoder);
> > +     conn_state =3D drm_atomic_get_new_connector_state(state, connecto=
r);
> > +     crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state->c=
rtc);
> > +
> > +     if (WARN_ON(pm_runtime_resume_and_get(pvi->dev)))
> > +             return;
> > +
> > +     mode =3D &crtc_state->adjusted_mode;
> > +
> > +     val =3D FIELD_PREP(PVI_CTRL_MODE_MASK, PVI_CTRL_MODE_LCDIF) | PVI=
_CTRL_EN;
> > +
> > +     if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> > +             val |=3D PVI_CTRL_OP_VSYNC_POL | PVI_CTRL_INP_VSYNC_POL;
> > +
> > +     if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> > +             val |=3D PVI_CTRL_OP_HSYNC_POL | PVI_CTRL_INP_HSYNC_POL;
> > +
> > +     if (pvi->next_bridge->timings)
> > +             bus_flags =3D pvi->next_bridge->timings->input_bus_flags;
> > +     else if (bridge_state)
> > +             bus_flags =3D bridge_state->input_bus_cfg.flags;
> > +
> > +     if (bus_flags & DRM_BUS_FLAG_DE_HIGH)
> > +             val |=3D PVI_CTRL_OP_DE_POL | PVI_CTRL_INP_DE_POL;
> > +
> > +     writel(val, pvi->regs + HTX_PVI_CTRL);
> > +}
>
> Apologies if this has already been reported or fixed, I searched lore
> and did not find anything. Clang warns (or errors with CONFIG_WERROR=3Dy)
> for this function:
>
>   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:81:11: error: variable 'bu=
s_flags' is used uninitialized whenever 'if' condition is false [-Werror,-W=
sometimes-uninitialized]
>      81 |         else if (bridge_state)
>         |                  ^~~~~~~~~~~~
>   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:84:6: note: uninitialized =
use occurs here
>      84 |         if (bus_flags & DRM_BUS_FLAG_DE_HIGH)
>         |             ^~~~~~~~~
>   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:81:7: note: remove the 'if=
' if its condition is always true
>      81 |         else if (bridge_state)
>         |              ^~~~~~~~~~~~~~~~~
>      82 |                 bus_flags =3D bridge_state->input_bus_cfg.flags=
;
>   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c:60:15: note: initialize th=
e variable 'bus_flags' to silence this warning
>      60 |         u32 bus_flags, val;
>         |                      ^
>         |                       =3D 0
>   1 error generated.
>
> This seems legitimate. If bridge_state can be NULL, should bus_flags be
> initialized to zero like it suggests or should that 'else if' be turned
> into a plain 'else'? I am happy to send a patch with that guidance.

I don't think we can turn the else-if into a blind else, because in
order to make bus_flags point to bridge_state->input_bus_cfg.flags,
bridge_state must not be NULL, but we could add an additional else to
set bus_flags to 0, but I think the simplest thing to do would be to
set bus_flags =3D 0 at the initialization on line 60 as it suggests.

If you agree, I can submit a patch later tonight.  I need to fix
another issue found by the build-bot [1]  to make line 113 return NULL
instead of 0 anyway.  I figured I could just fix them both at the same
time.

adam

[1] - https://lore.kernel.org/oe-kbuild-all/202402062134.a6CqAt3s-lkp@intel=
com/

>
> Cheers,
> Nathan

