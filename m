Return-Path: <linux-kernel+bounces-77232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0900686025F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688831F2A8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD84776E;
	Thu, 22 Feb 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S46cfeLj"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527D14B82B;
	Thu, 22 Feb 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629156; cv=none; b=JqH8f4vaCE0Q7C7LYBhzktoL0Tz3KQzcfrHVgS6xTiUVZG7XbuvvOALKuJGNdT6oo4sezuid2KfBEdlh65GSl1WWCXwUtCRQKqPEUTRSftk2lrtDDKrzwm8ray8QQwNJp0rk8RvDYsTOBzMmC18mSC1Qcj2MUIvnnaoHbkBsWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629156; c=relaxed/simple;
	bh=EW5s5hgTLOrLlu9kaSmm1DDCMmvLyTW02LJkYzGXn+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0Ua0KZgJCocQY2wqVF4uZmRz2WgChbjt00fMqknvjGUgbof4cb+n1kcuIaa44QPbPUVCw6L6QpxrMcMINLXdi+1uKCXzOvHbT9pyNlwV7XcVF76WaZmoJeHXuTj0r2poWc/7usWPGGa8CQ7sMVyWb8zoUmkKGTXYMvlEnnAr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S46cfeLj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512b700c8ebso186437e87.0;
        Thu, 22 Feb 2024 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708629153; x=1709233953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ascVxuLaaMNM+iLyCaaEtYsJ/LtdyKIcDFbaaHuf7+A=;
        b=S46cfeLj8BUE0okJRZPWiGjt8EoLqW86BRmgYOLo66NTmuAAdrxlu3Y2guayJbj51p
         gt0Ab3KlFHHVULxiK9alN7/hkayO7w4zAGdMseQtiItdpBv6JzxqdAhllSpY5QuNh8RS
         E3KuWikO97v+bS21xul+FXqNByMBd65r21WPcDxH/6o4mpgr1XpkrQ40WS0jUnKADE7G
         cMAiIIYvhthhIJMt3/6BrtZ13+WHZNVA+R4tthKr5oMycinpZ88rVibfmFG42JSYQbX+
         Kic2ckCffzatcmzGX71phR0usMZzYllQhlsjUgThojixuTIGWw78/ey+oM65jKHzer1E
         /ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629153; x=1709233953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ascVxuLaaMNM+iLyCaaEtYsJ/LtdyKIcDFbaaHuf7+A=;
        b=R4S7QNCRKhriZItbQCKc8lC3hDAUEsIH5cQK60g+CidEYCgVcauzvlodbuQkDCcVZ6
         4AxOiDUc7eTZnQrqF171V39jDPa4BYr8MzUXOPbgG1+FdAvFBlrBTHkt/4P5WdEVVGJV
         Q57/fYF/CddiQDnFaBhj/jHDLLx9Yf8gqEopgHl4caOJ4uDGOpRmITAwCXgdzJTvnM4T
         rzUIigc/9DfUsj6cmKmeewC34BGSKpXGJQcgF00sG7utYBouM453ILekrX2OteVjzEA7
         r7I4CWwx0F5Vigf19n/IIvIGsNXEilCq+aKfjce0PdU70fDf3EiE4mwrasCz3oDM7dgc
         ezKg==
X-Forwarded-Encrypted: i=1; AJvYcCWtQwIK4JC5ctUbVkMqXjxGIZIpyZZXgDtcH4QYPxJhLZQvKhtor+zYIhBpYNOXnYZlwBc/l16/INFZti/LpQVf5u+GsCFa0KzPnNiWd1bBfQtzwcf1ZrebYpOjH21glrlWZMew/i2IriQag72NajWgTz9DxOC5DdtZs8+X6DNpZ8w/F44=
X-Gm-Message-State: AOJu0YwFDklKcjOlBOPuS4qgFxYEw+JnIjzpBjjUN2B5Fa6+c/JRt2k/
	B0WvEYZTv3w3fHbP7fOdNgk9NHPfGRAV/8AS9j6YbDvaxIVnIMba
X-Google-Smtp-Source: AGHT+IGu+ExwuJo5Vy53aR587PvPGA/BvgjURLqHK9mgxxEedn8hBlpN+TNPuvzQRBJx6tkns7NcdQ==
X-Received: by 2002:a05:6512:1196:b0:512:d655:9d4b with SMTP id g22-20020a056512119600b00512d6559d4bmr55318lfr.5.1708629152360;
        Thu, 22 Feb 2024 11:12:32 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id r17-20020ac25a51000000b00512bfc0c2b9sm1189234lfn.178.2024.02.22.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:12:31 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
 Sui Jingfeng <sui.jingfeng@linux.dev>
Subject:
 Re: [PATCH v7 35/36] drm/sun4i: hdmi: Consolidate atomic_check and mode_valid
Date: Thu, 22 Feb 2024 20:12:29 +0100
Message-ID: <2921783.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-35-8f4af575fce2@kernel.org>
References:
 <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-35-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 22. februar 2024 ob 19:14:21 CET je Maxime Ripard napisal=
(a):
> atomic_check and mode_valid do not check for the same things which can
> lead to surprising result if the userspace commits a mode that didn't go
> through mode_valid. Let's merge the two implementations into a function
> called by both.
>=20
> Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 74 +++++++++++++++++++++-------=
=2D-----
>  1 file changed, 47 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index c276d984da6b..b7cf369b1906 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -62,18 +62,6 @@ static int sun4i_hdmi_setup_avi_infoframes(struct sun4=
i_hdmi *hdmi,
>  	return 0;
>  }
> =20
> -static int sun4i_hdmi_atomic_check(struct drm_encoder *encoder,
> -				   struct drm_crtc_state *crtc_state,
> -				   struct drm_connector_state *conn_state)
> -{
> -	struct drm_display_mode *mode =3D &crtc_state->mode;
> -
> -	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static void sun4i_hdmi_disable(struct drm_encoder *encoder,
>  			       struct drm_atomic_state *state)
>  {
> @@ -166,31 +154,61 @@ static void sun4i_hdmi_enable(struct drm_encoder *e=
ncoder,
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>  }
> =20
> -static enum drm_mode_status sun4i_hdmi_mode_valid(struct drm_encoder *en=
coder,
> -					const struct drm_display_mode *mode)
> +static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs =3D=
 {
> +	.atomic_disable	=3D sun4i_hdmi_disable,
> +	.atomic_enable	=3D sun4i_hdmi_enable,
> +};
> +
> +static enum drm_mode_status
> +sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
> +				 const struct drm_display_mode *mode,
> +				 unsigned long long clock)
>  {
> -	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
> -	unsigned long rate =3D mode->clock * 1000;
> -	unsigned long diff =3D rate / 200; /* +-0.5% allowed by HDMI spec */
> +	const struct sun4i_hdmi *hdmi =3D drm_connector_to_sun4i_hdmi(connector=
);
> +	unsigned long diff =3D clock / 200; /* +-0.5% allowed by HDMI spec */
>  	long rounded_rate;
> =20
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> +		return MODE_BAD;
> +
>  	/* 165 MHz is the typical max pixelclock frequency for HDMI <=3D 1.2 */
> -	if (rate > 165000000)
> +	if (clock > 165000000)
>  		return MODE_CLOCK_HIGH;
> -	rounded_rate =3D clk_round_rate(hdmi->tmds_clk, rate);
> +
> +	rounded_rate =3D clk_round_rate(hdmi->tmds_clk, clock);
>  	if (rounded_rate > 0 &&
> -	    max_t(unsigned long, rounded_rate, rate) -
> -	    min_t(unsigned long, rounded_rate, rate) < diff)
> +	    max_t(unsigned long, rounded_rate, clock) -
> +	    min_t(unsigned long, rounded_rate, clock) < diff)
>  		return MODE_OK;
> +
>  	return MODE_NOCLOCK;
>  }
> =20
> -static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs =3D=
 {
> -	.atomic_check	=3D sun4i_hdmi_atomic_check,
> -	.atomic_disable	=3D sun4i_hdmi_disable,
> -	.atomic_enable	=3D sun4i_hdmi_enable,
> -	.mode_valid	=3D sun4i_hdmi_mode_valid,
> -};
> +static int sun4i_hdmi_connector_atomic_check(struct drm_connector *conne=
ctor,
> +					     struct drm_atomic_state *state)
> +{
> +	struct drm_connector_state *conn_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_crtc *crtc =3D conn_state->crtc;
> +	struct drm_crtc_state *crtc_state =3D crtc->state;
> +	struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
> +	enum drm_mode_status status;
> +
> +	status =3D sun4i_hdmi_connector_clock_valid(connector, mode,
> +						  mode->clock * 1000);
> +	if (status !=3D MODE_OK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static enum drm_mode_status
> +sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
> +				struct drm_display_mode *mode)
> +{
> +	return sun4i_hdmi_connector_clock_valid(connector, mode,
> +						mode->clock * 1000);
> +}
> =20
>  static int sun4i_hdmi_get_modes(struct drm_connector *connector)
>  {
> @@ -236,6 +254,8 @@ static struct i2c_adapter *sun4i_hdmi_get_ddc(struct =
device *dev)
>  }
> =20
>  static const struct drm_connector_helper_funcs sun4i_hdmi_connector_help=
er_funcs =3D {
> +	.atomic_check	=3D sun4i_hdmi_connector_atomic_check,
> +	.mode_valid	=3D sun4i_hdmi_connector_mode_valid,
>  	.get_modes	=3D sun4i_hdmi_get_modes,
>  };
> =20
>=20
>=20





