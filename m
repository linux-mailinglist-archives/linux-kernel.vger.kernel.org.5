Return-Path: <linux-kernel+bounces-77241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534CE86033F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5F5B31B44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B9548EB;
	Thu, 22 Feb 2024 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTOz1GoG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6E6AF93
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629459; cv=none; b=e4OOglpbP2YnIpZy/B3GgzQKCTHUVk9iXXqPTBQqAnGZ8MTC2mJBf8wWDCFAVh2MdzZvFNSsveyeIWrsd6Z0l4e4Nm24JZ39Wy0qVAQht7wBsLPWoNB5AZAOsNNqV2wDUTZFAVFRrW1oODfU/NqSJvSBi90tgtnoaB1HkG0PV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629459; c=relaxed/simple;
	bh=pRJe1LX+J7UwgkftQVxADfCuGzfrQFO80qx8YgR2sZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN2tms3WH/AHyDUlDBUT5yr74tXnMyWnWuOmthTzCnfZS/qv4v+UcCgl0Br3gZxo5FigtfiVQjw3qwKQWykSHMe1m+bgGqpNtHlAVHzF4vvzC8EJbR8lBrwxrJB0NgmOz50FwWcih4vy2tYujbdznoa0n0kib+GQNohiczDVDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTOz1GoG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512bde3d197so187339e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708629455; x=1709234255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXyetn+ZGaN+wj8L7+WuO+TQebmZJtVHvCLliqZtuvQ=;
        b=WTOz1GoGv3pp8q1qZkelDUaolHNF1xZeMp3ya2ue+SYq5T1eZgxBgqxHHq0hglFjAB
         yc2fTku/FsllMtmMiOSbxCL6W0XcCs6SCsMSFOa8UMNCdsxFxlb/gNg8mtIJ83tew5ep
         YU+4DmA4KCMWzXgzqFMowf7zUkBcL3fuKz2Ou/hDgwToXBTF5ew7/NPa4bTEyo3IECx6
         pI92BD4Vb8tMg7kJroWe6evdyt0IrgZWiel5N30Hwh2pjdQEWqhyJp4svjehsbhrXXdi
         9TLX9Q+GXPEKvosknkT46ZHyvZLcBTN/BHoUBnRq4MS5I8bWdVbOf7q6m+Y9ySNPTYKx
         zWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629455; x=1709234255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXyetn+ZGaN+wj8L7+WuO+TQebmZJtVHvCLliqZtuvQ=;
        b=T3HpINPObimzq9YetT4tjMaR04p6SGjHfpNIAh7YusEBjH10ESrBCfEdaBpXfnGjo0
         QhQAa0KU0vJr9CX8Eg7y5hXNin1WD50PYJFlqiIxcUOPV7uExS2/p4YsnG2UVwZYSHJo
         Uh63wMZ03+d1XKjvHO9W90wEk9DO98f/JJld+tcdkiReh3dotzMC+PyPfdBdDNjbI7JJ
         SQXLmlc2EzccCD55tU+wy7K7znaVpejYHxgrnZEPd4iKZoyQ9+gPCa/rtSU9PxxgguHr
         W+X+WxWjXvKcGkzObKoeQ5eE/olAJUCANwpETpEVtOelZygOmH7ZVBOG+7RWT2ic3PDw
         /BKA==
X-Forwarded-Encrypted: i=1; AJvYcCU3tTX+ZociiZCO/6SSbjCS7qV3IFaqwtiTGTZh0mqve2zB7q7HLcpjmbCIpVpBC52Rde55FoSe8anQeuzxuF+3jVh7NuuPCXQlqNjv
X-Gm-Message-State: AOJu0YxCfx4ncgqVvHPG0fL8oI7Tm9844jr6Cjfg+JDvy778oqd7f8KH
	L/R6WM1rh0jeAzYnXV3gVjvYheYoT75zf2RpS2WKEnWRzK+k0Bov
X-Google-Smtp-Source: AGHT+IGVJwMcq24ZF8Ebpo5tftKhvL3M0wvGVhfFgolHxmrCildGsWDM6qvoySHLbKiVC58dP2WqFg==
X-Received: by 2002:ac2:5464:0:b0:512:a95a:8308 with SMTP id e4-20020ac25464000000b00512a95a8308mr70236lfn.2.1708629454909;
        Thu, 22 Feb 2024 11:17:34 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id wp12-20020a170907060c00b00a3eb953335esm3843240ejb.44.2024.02.22.11.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:17:34 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/sun4i: Unify sun8i_*_layer structs
Date: Thu, 22 Feb 2024 20:17:33 +0100
Message-ID: <3789585.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20240216190430.1374132-2-megi@xff.cz>
References:
 <20240216190430.1374132-1-megi@xff.cz> <20240216190430.1374132-2-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne petek, 16. februar 2024 ob 20:04:24 CET je Ond=C5=99ej Jirman napisal(a=
):
> From: Ondrej Jirman <megi@xff.cz>
>=20
> These structs are identical, use a single struct to represent private
> data for the DRM plane. This is a preparation for configuring layer
> routing from the CRTC (mixer) instead of current approach of setting
> up routing from individual layer's atomic_update callback.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    |  4 ++--
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    | 14 ++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 14 +++++++-------
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 20 ++++----------------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 14 +++++++-------
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 20 ++++----------------
>  6 files changed, 38 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
> index 01382860aaee..1e681314e379 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -271,7 +271,7 @@ static struct drm_plane **sun8i_layers_init(struct dr=
m_device *drm,
>  		return ERR_PTR(-ENOMEM);
> =20
>  	for (i =3D 0; i < mixer->cfg->vi_num; i++) {
> -		struct sun8i_vi_layer *layer;
> +		struct sun8i_layer *layer;
> =20
>  		layer =3D sun8i_vi_layer_init_one(drm, mixer, i);
>  		if (IS_ERR(layer)) {
> @@ -284,7 +284,7 @@ static struct drm_plane **sun8i_layers_init(struct dr=
m_device *drm,
>  	}
> =20
>  	for (i =3D 0; i < mixer->cfg->ui_num; i++) {
> -		struct sun8i_ui_layer *layer;
> +		struct sun8i_layer *layer;
> =20
>  		layer =3D sun8i_ui_layer_init_one(drm, mixer, i);
>  		if (IS_ERR(layer)) {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
> index 85c94884fb9a..5a610ee30301 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -9,6 +9,7 @@
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <drm/drm_plane.h>
> =20
>  #include "sunxi_engine.h"
> =20
> @@ -185,6 +186,19 @@ struct sun8i_mixer {
>  	struct clk			*mod_clk;
>  };
> =20
> +struct sun8i_layer {
> +	struct drm_plane	plane;
> +	struct sun8i_mixer	*mixer;
> +	int			channel;
> +	int			overlay;
> +};
> +
> +static inline struct sun8i_layer *
> +plane_to_sun8i_layer(struct drm_plane *plane)
> +{
> +	return container_of(plane, struct sun8i_layer, plane);
> +}
> +
>  static inline struct sun8i_mixer *
>  engine_to_sun8i_mixer(struct sunxi_engine *engine)
>  {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index ca75ca0835a6..248fbb606ede 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -232,7 +232,7 @@ static int sun8i_ui_layer_atomic_check(struct drm_pla=
ne *plane,
>  {
>  	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state,
>  										 plane);
> -	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> +	struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>  	struct drm_crtc *crtc =3D new_plane_state->crtc;
>  	struct drm_crtc_state *crtc_state;
>  	int min_scale, max_scale;
> @@ -264,7 +264,7 @@ static void sun8i_ui_layer_atomic_disable(struct drm_=
plane *plane,
>  {
>  	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(st=
ate,
>  									   plane);
> -	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> +	struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>  	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
> @@ -279,7 +279,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_p=
lane *plane,
>  									   plane);
>  	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate,
>  									   plane);
> -	struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plane);
> +	struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>  	unsigned int zpos =3D new_state->normalized_zpos;
>  	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> @@ -345,13 +345,13 @@ static const uint64_t sun8i_layer_modifiers[] =3D {
>  	DRM_FORMAT_MOD_INVALID
>  };
> =20
> -struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
> -					       struct sun8i_mixer *mixer,
> -					       int index)
> +struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
> +					    struct sun8i_mixer *mixer,
> +					    int index)
>  {
>  	enum drm_plane_type type =3D DRM_PLANE_TYPE_OVERLAY;
>  	int channel =3D mixer->cfg->vi_num + index;
> -	struct sun8i_ui_layer *layer;
> +	struct sun8i_layer *layer;
>  	unsigned int plane_cnt;
>  	int ret;
> =20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.h
> index e3e32ee1178d..83892f6ff211 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
> @@ -47,21 +47,9 @@
>  #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED	((2) << 1)
> =20
>  struct sun8i_mixer;
> +struct sun8i_layer;
> =20
> -struct sun8i_ui_layer {
> -	struct drm_plane	plane;
> -	struct sun8i_mixer	*mixer;
> -	int			channel;
> -	int			overlay;
> -};
> -
> -static inline struct sun8i_ui_layer *
> -plane_to_sun8i_ui_layer(struct drm_plane *plane)
> -{
> -	return container_of(plane, struct sun8i_ui_layer, plane);
> -}
> -
> -struct sun8i_ui_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
> -					       struct sun8i_mixer *mixer,
> -					       int index);
> +struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
> +					    struct sun8i_mixer *mixer,
> +					    int index);
>  #endif /* _SUN8I_UI_LAYER_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index f9c0a56d3a14..0c0f1ac80517 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -366,7 +366,7 @@ static int sun8i_vi_layer_atomic_check(struct drm_pla=
ne *plane,
>  {
>  	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state,
>  										 plane);
> -	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> +	struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>  	struct drm_crtc *crtc =3D new_plane_state->crtc;
>  	struct drm_crtc_state *crtc_state;
>  	int min_scale, max_scale;
> @@ -398,7 +398,7 @@ static void sun8i_vi_layer_atomic_disable(struct drm_=
plane *plane,
>  {
>  	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(st=
ate,
>  									   plane);
> -	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> +	struct sun8i_layer *layer =3D plane_to_sun8i_vi_layer(plane);
>  	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> =20
> @@ -413,7 +413,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_p=
lane *plane,
>  									   plane);
>  	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate,
>  									   plane);
> -	struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plane);
> +	struct sun8i_layer *layer =3D plane_to_sun8i_layer(plane);
>  	unsigned int zpos =3D new_state->normalized_zpos;
>  	unsigned int old_zpos =3D old_state->normalized_zpos;
>  	struct sun8i_mixer *mixer =3D layer->mixer;
> @@ -539,14 +539,14 @@ static const uint64_t sun8i_layer_modifiers[] =3D {
>  	DRM_FORMAT_MOD_INVALID
>  };
> =20
> -struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
> -					       struct sun8i_mixer *mixer,
> -					       int index)
> +struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
> +					    struct sun8i_mixer *mixer,
> +					    int index)
>  {
>  	enum drm_plane_type type =3D DRM_PLANE_TYPE_OVERLAY;
>  	u32 supported_encodings, supported_ranges;
>  	unsigned int plane_cnt, format_count;
> -	struct sun8i_vi_layer *layer;
> +	struct sun8i_layer *layer;
>  	const u32 *formats;
>  	int ret;
> =20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.h
> index 48c399e1c86d..655440cdc78f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> @@ -52,21 +52,9 @@
>  #define SUN8I_MIXER_CHAN_VI_DS_M(x)			((x) << 0)
> =20
>  struct sun8i_mixer;
> +struct sun8i_layer;
> =20
> -struct sun8i_vi_layer {
> -	struct drm_plane	plane;
> -	struct sun8i_mixer	*mixer;
> -	int			channel;
> -	int			overlay;
> -};
> -
> -static inline struct sun8i_vi_layer *
> -plane_to_sun8i_vi_layer(struct drm_plane *plane)
> -{
> -	return container_of(plane, struct sun8i_vi_layer, plane);
> -}
> -
> -struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
> -					       struct sun8i_mixer *mixer,
> -					       int index);
> +struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
> +					    struct sun8i_mixer *mixer,
> +					    int index);
>  #endif /* _SUN8I_VI_LAYER_H_ */
>=20





