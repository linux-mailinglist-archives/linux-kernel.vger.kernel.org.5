Return-Path: <linux-kernel+bounces-77221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68DC86024C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D791C26A12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5C66AF97;
	Thu, 22 Feb 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK3BkwNQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABF14B810;
	Thu, 22 Feb 2024 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628911; cv=none; b=S0uexlfZzxUbeVDfJM4jKBixuB8bSne1sjFNyS0YSshvFpR/ihjBc4xgGrJQ9grao42nUaVwzjPvR1znSgcLQbLoUgWI3uaUmUh+kgJvXLIu+Yn2n5eoJ30QEvrSMl8pci7tfl6eVhOcnuHq/CgfldHbcFoOE+BXkwd8SaVZyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628911; c=relaxed/simple;
	bh=4D9Oe8rDV8p+ZUKWWO/XSa6tVnlPRevU5T7Tsmgr9YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StOu5eUVAnfDrtBKpTzSPf/uzShN785eQOBx3agv3u05mlM8LquDJoG2ynnQRGuejNc0coHD3wNbm4bov2w7nKLdaiON1QihJucgQxKx6mGCxNPsX4EXWoIqdl9jWhwfEvx/L2/+XlvmqXIAZmjlO13j4mumnmdo3nS4RHyHob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HK3BkwNQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so5870266b.2;
        Thu, 22 Feb 2024 11:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708628908; x=1709233708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miYXI5X8OB04A3nvBBpwERsgxft9kKmaWCdU6IfWrLc=;
        b=HK3BkwNQv9djRAPZsl8N3ZkScFuyV9tXMBgQWcYuQ3Mp4iFG3kMVu5wD+C9McWW+U4
         lyCbVidE+VZZWSEWR1lQrhI4CClAB2gUXKECPq0co+nZ/u8aanvyDal/i1lZcXfQzIee
         JoRZJxGQ1qv97IBacFuSF0M+A/8ztb6/ljPDPcUhQR7sAlXQLpZSAP2qc0RGw26HWAjk
         cAxBnWCkKpBUbcLHSykbxbLqsJdesKGUDk7ZTsL5Hy0lkk8pxPfE/XnXvPkUSfzuheQf
         CkbcAuJHE0aPrPcoTQzEibk1KIHegVwzQD1mS0ECreB02/BCvyieOndsxPU+YNZJuQi+
         /4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628908; x=1709233708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miYXI5X8OB04A3nvBBpwERsgxft9kKmaWCdU6IfWrLc=;
        b=fquNURldFU/Aur+HQqnsHYoJKlsDo9K/0B3153wfLXvCWSvb6/UZgTEOJnbknrsQhl
         hRg1Ppne1GX4ioS29K9/rfK2WR/WDqy22hzRiYHZyp10lN0Ho4LJPxyQJ5xiYA2NPRES
         qXylyitBgqZZCQ56iFzzXYZ9JnStpNNyDQ++gSFV8t2dyrxYQGJnoRg7iGybt3NogEOn
         lTxC2wg7RutiwOMaqRlSI5rXuAkJaSf7cWsQv75KT6us0iWKxrL4yvgbKlw2q5YMnm6p
         TkjZHxYFmI/+Uf1Noqf2tXmnuI7hSbSSgfeSn77Tz7VW15UywSNj+pteYN9v16slNsGM
         pLVA==
X-Forwarded-Encrypted: i=1; AJvYcCX4KZ+EMnQNub8cec7fraovZ8qYnscty7vrz35tfDwwI5b9q+MFWVOiT3jP0DCiiNgqjablyJYHcvNVmqNjFA/VDzWSGcPMgT2mgsrhhLpvl2OBoa9BXyLxZTvH0BBrPOs5gjJp2BdGSOeoOdZsDP0dsiZwo0NkAZ77V9TTyo2wVg0emPk=
X-Gm-Message-State: AOJu0Ywc3jM0mggGkhD9SyK2CCG0P/lt0O+X0z0kHUtMvTLzWueVjFpw
	PBgAy1gzj2kst1w7tcfyzP01nWtqhc4UkUQlfG7yClzMG54SG5VH
X-Google-Smtp-Source: AGHT+IFAwJtXHRxsMlfuxZbKsBCx57OJ9WWOE6NU3SwtpJdQrrzkkNNcvjYdXKu6pBGCRHU3AulfnQ==
X-Received: by 2002:a17:906:35d3:b0:a3f:2f67:4847 with SMTP id p19-20020a17090635d300b00a3f2f674847mr3966366ejb.19.1708628908074;
        Thu, 22 Feb 2024 11:08:28 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id b5-20020a170906490500b00a3e7b8bd2d8sm4663088ejq.111.2024.02.22.11.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:08:27 -0800 (PST)
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
Subject: Re: [PATCH v7 33/36] drm/sun4i: hdmi: Move mode_set into enable
Date: Thu, 22 Feb 2024 20:08:26 +0100
Message-ID: <4868938.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-33-8f4af575fce2@kernel.org>
References:
 <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-33-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 22. februar 2024 ob 19:14:19 CET je Maxime Ripard napisal=
(a):
> We're not doing anything special in atomic_mode_set so we can simply
> merge it into atomic_enable.
>=20
> Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 38 +++++++++++++---------------=
=2D-----
>  1 file changed, 14 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index 799a26215cc2..bae69d696765 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -103,33 +103,11 @@ static void sun4i_hdmi_enable(struct drm_encoder *e=
ncoder,
>  	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
>  	struct drm_display_info *display =3D &hdmi->connector.display_info;
> +	unsigned int x, y;
>  	u32 val =3D 0;
> =20
>  	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
> =20
> -	clk_prepare_enable(hdmi->tmds_clk);
> -
> -	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
> -	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
> -	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
> -	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
> -
> -	val =3D SUN4I_HDMI_VID_CTRL_ENABLE;
> -	if (display->is_hdmi)
> -		val |=3D SUN4I_HDMI_VID_CTRL_HDMI_MODE;
> -
> -	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> -}
> -
> -static void sun4i_hdmi_mode_set(struct drm_encoder *encoder,
> -				struct drm_crtc_state *crtc_state,
> -				struct drm_connector_state *conn_state)
> -{
> -	const struct drm_display_mode *mode =3D &crtc_state->mode;
> -	struct sun4i_hdmi *hdmi =3D drm_encoder_to_sun4i_hdmi(encoder);
> -	unsigned int x, y;
> -	u32 val;
> -
>  	clk_set_rate(hdmi->mod_clk, mode->crtc_clock * 1000);
>  	clk_set_rate(hdmi->tmds_clk, mode->crtc_clock * 1000);
> =20
> @@ -181,6 +159,19 @@ static void sun4i_hdmi_mode_set(struct drm_encoder *=
encoder,
>  		val |=3D SUN4I_HDMI_VID_TIMING_POL_VSYNC;
> =20
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_TIMING_POL_REG);
> +
> +	clk_prepare_enable(hdmi->tmds_clk);
> +
> +	sun4i_hdmi_setup_avi_infoframes(hdmi, mode);
> +	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
> +	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
> +	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
> +
> +	val =3D SUN4I_HDMI_VID_CTRL_ENABLE;
> +	if (display->is_hdmi)
> +		val |=3D SUN4I_HDMI_VID_CTRL_HDMI_MODE;
> +
> +	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>  }
> =20
>  static enum drm_mode_status sun4i_hdmi_mode_valid(struct drm_encoder *en=
coder,
> @@ -206,7 +197,6 @@ static const struct drm_encoder_helper_funcs sun4i_hd=
mi_helper_funcs =3D {
>  	.atomic_check	=3D sun4i_hdmi_atomic_check,
>  	.atomic_disable	=3D sun4i_hdmi_disable,
>  	.atomic_enable	=3D sun4i_hdmi_enable,
> -	.atomic_mode_set	=3D sun4i_hdmi_mode_set,
>  	.mode_valid	=3D sun4i_hdmi_mode_valid,
>  };
> =20
>=20
>=20





