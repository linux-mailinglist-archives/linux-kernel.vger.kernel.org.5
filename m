Return-Path: <linux-kernel+bounces-33600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC8836C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740F928143C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974D94645D;
	Mon, 22 Jan 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+MnRZ6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D04644A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937383; cv=none; b=ZEpTKAJewx9s1zacDbS0txxz0as30LUaL4g6+xM7QBYDTpQLtGP9aRtYSU0pb1qsZy4/i0cTl88ouVRRG1O2qxiMTckvvu7AFj4QgdFzfLMSGQErnLCY55orfUNL1BsbeW8djeI5x7M9gB+u6zO2va0j1u5NlN6Xz8ynimRGAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937383; c=relaxed/simple;
	bh=iO8t2uvf8zKn2pqUIDEeeUGE84Y6SbECB0tNbeiWYzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qySJQwaDBrg2OQeH7DeDOFaa22fd3vY0s70Itr+dCRI0HqvxenZ8MTK4HpC0gW0USZiG+qSMHWIzd/R4QCi8KOMCdVG/wVkNQDqvdD8vcLiv62xJ53A1KL5zwhBgpk+G6kszFmaB9MfsFolzu4ULEknEsjtbF6YWjFowscz4vsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+MnRZ6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D23DC43394
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937383;
	bh=iO8t2uvf8zKn2pqUIDEeeUGE84Y6SbECB0tNbeiWYzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C+MnRZ6kGvr+BXdFvyVitkA9XOIvtUbvwNce6ihU2x7vntqpIlXbY+OGnlqAJ8yUa
	 U3hU197FCZSGcGg18ABnbM1rzlMx8mIuflY5F2Rq78Lt0+0ejtx3GlA6WGll1wjHy2
	 1Ejaoo0pC6Q52OoMEdCaq/0MgAs7NW/VUiP6KmdUrk7QBd/M7ZFh6E4n8M5kzS0mgV
	 VSzl3NUyxPL3kKH0RLieipsM9wc7LG9DcDW2wIGzEy1eAMrLWM4hyxhSguX8ol/dCv
	 Vm7RzDVAGghigNHngtiPHjPnTuXSauoRk26ZaFZhJHDoUTIV/DxZCv8aA+V/ieQ+Wa
	 KfqtLIGLUdxOg==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc261316b0dso2336639276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:29:43 -0800 (PST)
X-Gm-Message-State: AOJu0YyXvVC/vAz7XAx7OE47Xto8wwVpsa0YgwbUXl3b62l8iYrkehnd
	5kNQvUrdbWvFmz4KPx+BmpJN7+x/QjdSj4KBN/kugEVwEoF7IDdnuq/X5wzwaptZqaYkduOFHLU
	lej2HzHq6yQqhkMFX3fFaQWyy0F/MaK0VEWqy6Q==
X-Google-Smtp-Source: AGHT+IGDkPjXY6J55Up3eaXCoYwi4eRPD2F77zONKwnvklSeSI87uRBe8/O3SRG5gesV0F61grq0PuKpZH3k4Uhs7Bw=
X-Received: by 2002:a25:d0cf:0:b0:dc2:2b05:4ab1 with SMTP id
 h198-20020a25d0cf000000b00dc22b054ab1mr2175479ybg.18.1705937382611; Mon, 22
 Jan 2024 07:29:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124-adv7511-cec-edid-v2-0-f0e5eeafdfc2@bang-olufsen.dk> <20231124-adv7511-cec-edid-v2-2-f0e5eeafdfc2@bang-olufsen.dk>
In-Reply-To: <20231124-adv7511-cec-edid-v2-2-f0e5eeafdfc2@bang-olufsen.dk>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 22 Jan 2024 16:29:31 +0100
X-Gmail-Original-Message-ID: <CAN6tsi4wxfTdG+qMr2fcwkou5F1xpxeh5S7CoAUzwi4jMFP_kw@mail.gmail.com>
Message-ID: <CAN6tsi4wxfTdG+qMr2fcwkou5F1xpxeh5S7CoAUzwi4jMFP_kw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: adv7511: get edid in hpd_work to
 update CEC phys address
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 4:20=E2=80=AFPM Alvin =C5=A0ipraga <alvin@pqrs.dk> =
wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> The adv7511 driver is solely responsible for setting the physical
> address of its CEC adapter. To do this, it must read the EDID. However,
> EDID is only read when either the drm_bridge_funcs :: get_edid or
> drm_connector_helper_funcs :: get_modes ops are called. Without loss of
> generality, it cannot be assumed that these ops are called when a sink
> gets attached. Therefore there exist scenarios in which the CEC physical
> address will be invalid (f.f.f.f), rendering the CEC adapter inoperable.
>
> Address this problem by always fetching the EDID in the HPD work when we
> detect a connection. The CEC physical address is set in the process.
> This is done by moving the EDID DRM helper into an internal helper
> function so that it can be cleanly called from an earlier section of
> the code. The EDID getter has not changed in practice.
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 74 ++++++++++++++++++----=
------
>  1 file changed, 48 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 5ffc5904bd59..1f1d3a440895 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -542,6 +542,36 @@ static int adv7511_get_edid_block(void *data, u8 *bu=
f, unsigned int block,
>         return 0;
>  }
>
> +static struct edid *__adv7511_get_edid(struct adv7511 *adv7511,
> +                                      struct drm_connector *connector)
> +{
> +       struct edid *edid;
> +
> +       /* Reading the EDID only works if the device is powered */
> +       if (!adv7511->powered) {
> +               unsigned int edid_i2c_addr =3D
> +                                       (adv7511->i2c_edid->addr << 1);
> +
> +               __adv7511_power_on(adv7511);
> +
> +               /* Reset the EDID_I2C_ADDR register as it might be cleare=
d */
> +               regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR,
> +                            edid_i2c_addr);
> +       }
> +
> +       edid =3D drm_do_get_edid(connector, adv7511_get_edid_block, adv75=
11);
> +
> +       if (!adv7511->powered)
> +               __adv7511_power_off(adv7511);
> +
> +       adv7511_set_config_csc(adv7511, connector, adv7511->rgb,
> +                              drm_detect_hdmi_monitor(edid));
> +
> +       cec_s_phys_addr_from_edid(adv7511->cec_adap, edid);
> +
> +       return edid;
> +}
> +
>  /* ---------------------------------------------------------------------=
--------
>   * Hotplug handling
>   */
> @@ -595,8 +625,24 @@ static void adv7511_hpd_work(struct work_struct *wor=
k)
>                 adv7511->connector.status =3D status;
>
>                 if (adv7511->connector.dev) {
> -                       if (status =3D=3D connector_status_disconnected)
> +                       if (status =3D=3D connector_status_disconnected) =
{
>                                 cec_phys_addr_invalidate(adv7511->cec_ada=
p);
> +                       } else {
> +                               struct edid *edid;
> +
> +                               /*
> +                                * Get the updated EDID so that the CEC
> +                                * subsystem gets informed of any change =
in CEC
> +                                * address. The helper returns a newly al=
located
> +                                * edid structure, so free it to prevent
> +                                * leakage.
> +                                */
> +                               edid =3D __adv7511_get_edid(adv7511,
> +                                                         &adv7511->conne=
ctor);
> +                               if (edid)
> +                                       kfree(edid);

kfree(NULL) is safe, so the if statement can be removed.

With this fixed, feel free to add my r-b to this full series.

Reviewed-by: Robert Foss <rfoss@kernel.org>

