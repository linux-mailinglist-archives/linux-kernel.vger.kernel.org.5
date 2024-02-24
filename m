Return-Path: <linux-kernel+bounces-79639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03705862516
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA05282C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0342056;
	Sat, 24 Feb 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MTvsP6Xi"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C442066
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708779032; cv=none; b=fH+Q2cDRQFlWtSz+uJfqg+c5akJlF12YYY5tGM9JcqjO/pG3czXETcUwyzbpl4C9Uz7mWwXIHwlbU+3vNqg3OnwzHQPst5u4ealjKKvRfkklbQjcqO8DZgivFEYsVNTYo1qY9v9rsUoEmiRm7BlPBUJtdKAJHDCSyqve/lumCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708779032; c=relaxed/simple;
	bh=z2btd+/bSQt84kgCCa861bZLEcPegkRF3AqKbmdzSVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzOUzOCzrAIVjurfCS0pgkcQHT/OWkQMMBECdx/kJem1NsWffIciFacX5QXiqXRGkts71IpeW9wZSLA5qSAxmdBut0e9yaeWFqZtI5N9Q7ERUt2qnA9vZajrxlJGyFQO1wrUC9hTiJNSSj/6sHnF/GL9GojuHWi9zkGnPSN6Eu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MTvsP6Xi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512ed314881so1125742e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708779029; x=1709383829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwlU2fVKfBCpqk6AECSpMumjycIUCrQn7X9V7zahsYI=;
        b=MTvsP6Xiqr+KfG42GL2seWBWFEdJbtTTIKMwf3QgBrZfgfvZeUCqBmfJZg6jcIkWfo
         xt6HPiW/46oscTGLhzJaj1sWojPNZjLGBQLrO9BzIeb8esJa/JbY4JeMQPsm1Wl8DMXx
         tpd2Q0rapX2zr/BNvHHaqr7DijpVEnPpLu27dirlFqvTaLGCbP+4leIVxA3mJ08iI7Kq
         G3r/OcJKvHFaWjYsyN+7W4vKdKsxThn0M5AH7kmCG/bL5FUSPtyz+fMLs0nfgNavZnff
         wdzS9QmgOXpuSefOz9icbHHLwMH9O96TSyp+6uyk3pqqi8pklMLyfncs1JVUZ0TnauJ7
         OawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708779029; x=1709383829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwlU2fVKfBCpqk6AECSpMumjycIUCrQn7X9V7zahsYI=;
        b=js4TVGynbsZSD+aaNT2kN9Oi1KR/717nMQMvWepns3YGXjzx4tDNvn3VYn+a9ZDBeH
         HNBsY/T5ygihh+TRkdm1ODQ8zv0BMPpaEDPNUVtQWlp2qpy4XN9z14T/t2BhncSBhub6
         mZaAw1r5GYrqTZkFp5BEAL1WM2D83is3Efv7eW1DBaCbzMLRffGJVkP1iJ3GAb68YNL8
         vaSQlk6zXmIBTmhVefktWFjHmrxpwahovu4+vMIzxM3vKG48BoWBlu/mk0lXYGiO9RVz
         NhDAlXRCqLClmZYSx0DMDzJLTlK8/0FZdY9KfFmw+a3sqqJ62zCtwtcXjHdudpnZqJoE
         nZig==
X-Forwarded-Encrypted: i=1; AJvYcCX/Og53RG5Eyf7qQCNY9vxKftLgcKSlPYvpzPBATP/SvsXLYuziOypK4Ea9Bi7K1/Tnib3tvgy7ZiXT+lcNL/bcUJ3e5f4+i66qKBYO
X-Gm-Message-State: AOJu0YxWyEUM3YAdP9Dasd1sM6anJo6K/H4eQmDaDQLGbUn+D5GU8Zta
	HgeGdIzerW39pjB9VG+gx2kXmotxT3BmUj3CBBJ9U28kwPZoqVaSvh9VFZ6IJ18=
X-Google-Smtp-Source: AGHT+IEauO2BjrsBW9WCBRr+hofKdktz0QU8jh0z/XzfKaiSHKqE5A3FD8rNM4Gleck++V4r7kRmOw==
X-Received: by 2002:a05:6512:31c9:b0:512:f44e:1378 with SMTP id j9-20020a05651231c900b00512f44e1378mr639386lfe.51.1708779028746;
        Sat, 24 Feb 2024 04:50:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7d6c9000000b005646c7b9712sm507336edr.16.2024.02.24.04.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 04:50:28 -0800 (PST)
Message-ID: <8445b9fc-25b9-45b9-a02c-dbebc5bcfcd7@tuxon.dev>
Date: Sat, 24 Feb 2024 14:50:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] drm: atmel_hlcdc: Add support for XLCDC using IP
 specific driver ops
Content-Language: en-US
To: Manikandan Muralidharan <manikandan.m@microchip.com>, sam@ravnborg.org,
 bbrezillon@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, Balamanikandan.Gunasundar@microchip.com,
 Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
 Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
 Balakrishnan.S@microchip.com, Charan.Pedumuru@microchip.com
References: <20240221053531.12701-1-manikandan.m@microchip.com>
 <20240221053531.12701-4-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240221053531.12701-4-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.02.2024 07:35, Manikandan Muralidharan wrote:
> Add XLCDC specific driver ops and is_xlcdc flag to separate the
> functionality and to access the controller registers.
> HEO scaling, window resampling, Alpha blending, YUV-to-RGB
> conversion in XLCDC is derived and handled using additional
> configuration bits and registers. Writing one to the Enable fields
> of each layer in LCD_ATTRE is required to reflect the values set
> in Configuration, FBA, Enable registers of each layer.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> Co-developed-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> Co-developed-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  81 +++++---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |   3 +
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 182 +++++++++++++++++-
>  3 files changed, 242 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index cc5cf4c2faf7..98a98b5fca85 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -164,11 +164,13 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
>  	cfg = state->output_mode << 8;
>  
> -	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
> -		cfg |= ATMEL_HLCDC_VSPOL;
> +	if (!crtc->dc->desc->is_xlcdc) {
> +		if (adj->flags & DRM_MODE_FLAG_NVSYNC)
> +			cfg |= ATMEL_HLCDC_VSPOL;
>  
> -	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
> -		cfg |= ATMEL_HLCDC_HSPOL;
> +		if (adj->flags & DRM_MODE_FLAG_NHSYNC)
> +			cfg |= ATMEL_HLCDC_HSPOL;
> +	}
>  
>  	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
>  			   ATMEL_HLCDC_HSPOL | ATMEL_HLCDC_VSPOL |
> @@ -202,20 +204,37 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
>  
>  	pm_runtime_get_sync(dev->dev);
>  
> +	if (crtc->dc->desc->is_xlcdc) {
> +		regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_CM);
> +		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +					     !(status & ATMEL_XLCDC_CM),
> +					     10, 1000))
> +			dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
> +
> +		regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_XLCDC_SD);
> +		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +					     status & ATMEL_XLCDC_SD,
> +					     10, 1000))
> +			dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
> +	}
> +
>  	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_DISP);
> -	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
> -	       (status & ATMEL_HLCDC_DISP))
> -		cpu_relax();
> +	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +				     !(status & ATMEL_HLCDC_DISP),
> +				    10, 1000))
> +		dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");

This is different thing than what the commit states it does but if
maintainer wants to keep it like this I don't have anything against. Valid
for the rest of regmap_read_poll_timeout() additions.

>  
>  	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_SYNC);
> -	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
> -	       (status & ATMEL_HLCDC_SYNC))
> -		cpu_relax();
> +	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +				     !(status & ATMEL_HLCDC_SYNC),
> +				    10, 1000))
> +		dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
>  
>  	regmap_write(regmap, ATMEL_HLCDC_DIS, ATMEL_HLCDC_PIXEL_CLK);
> -	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
> -	       (status & ATMEL_HLCDC_PIXEL_CLK))
> -		cpu_relax();
> +	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +				     !(status & ATMEL_HLCDC_PIXEL_CLK),
> +				    10, 1000))
> +		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
>  
>  	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
>  	pinctrl_pm_select_sleep_state(dev->dev);
> @@ -241,20 +260,36 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  	clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
>  
>  	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PIXEL_CLK);
> -	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
> -	       !(status & ATMEL_HLCDC_PIXEL_CLK))
> -		cpu_relax();
> -
> +	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +				     status & ATMEL_HLCDC_PIXEL_CLK,
> +				     10, 1000))
> +		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
>  
>  	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_SYNC);
> -	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
> -	       !(status & ATMEL_HLCDC_SYNC))
> -		cpu_relax();
> +	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +				     status & ATMEL_HLCDC_SYNC,
> +				     10, 1000))
> +		dev_warn(dev->dev, "Atmel LCDC status register LCDSTS timeout\n");
>  
>  	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_DISP);
> -	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&
> -	       !(status & ATMEL_HLCDC_DISP))
> -		cpu_relax();
> +	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +				     status & ATMEL_HLCDC_DISP,
> +				     10, 1000))
> +		dev_warn(dev->dev, "Atmel LCDC status register DISPSTS timeout\n");
> +
> +	if (crtc->dc->desc->is_xlcdc) {
> +		regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_CM);
> +		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +					     status & ATMEL_XLCDC_CM,
> +					     10, 1000))
> +			dev_warn(dev->dev, "Atmel LCDC status register CMSTS timeout\n");
> +
> +		regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_XLCDC_SD);
> +		if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
> +					     !(status & ATMEL_XLCDC_SD),
> +					     10, 1000))
> +			dev_warn(dev->dev, "Atmel LCDC status register SDSTS timeout\n");
> +	}
>  
>  	pm_runtime_put_sync(dev->dev);
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index bc70a81b5275..777987b7873d 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -387,6 +387,7 @@ struct atmel_lcdc_dc_ops {
>  };
>  
>  extern const struct atmel_lcdc_dc_ops atmel_hlcdc_ops;
> +extern const struct atmel_lcdc_dc_ops atmel_xlcdc_ops;
>  
>  /**
>   * Atmel HLCDC Display Controller description structure.
> @@ -404,6 +405,7 @@ extern const struct atmel_lcdc_dc_ops atmel_hlcdc_ops;
>   * @conflicting_output_formats: true if RGBXXX output formats conflict with
>   *				each other.
>   * @fixed_clksrc: true if clock source is fixed
> + * @is_xlcdc: true if XLCDC IP is supported
>   * @layers: a layer description table describing available layers
>   * @nlayers: layer description table size
>   * @ops: atmel lcdc dc ops
> @@ -418,6 +420,7 @@ struct atmel_hlcdc_dc_desc {
>  	int max_hpw;
>  	bool conflicting_output_formats;
>  	bool fixed_clksrc;
> +	bool is_xlcdc;
>  	const struct atmel_hlcdc_layer_desc *layers;
>  	int nlayers;
>  	const struct atmel_lcdc_dc_ops *ops;
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 3427546cd58c..59ddd743ce92 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -331,6 +331,55 @@ void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
>  								     yfactor));
>  }
>  
> +static
> +void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_plane_state *state)
> +{
> +	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	u32 xfactor, yfactor;
> +
> +	if (!desc->layout.scaler_config)
> +		return;
> +
> +	if (state->crtc_w == state->src_w && state->crtc_h == state->src_h) {
> +		atmel_hlcdc_layer_write_cfg(&plane->layer,
> +					    desc->layout.scaler_config, 0);
> +		return;
> +	}
> +
> +	/* xfactor = round[(2^20 * XMEMSIZE)/XSIZE)] */
> +	xfactor = (u32)(((1 << 20) * state->src_w) / state->crtc_w);
> +
> +	/* yfactor = round[(2^20 * YMEMSIZE)/YSIZE)] */
> +	yfactor = (u32)(((1 << 20) * state->src_h) / state->crtc_h);
> +
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config,
> +				    ATMEL_XLCDC_LAYER_VSCALER_LUMA_ENABLE |
> +				    ATMEL_XLCDC_LAYER_VSCALER_CHROMA_ENABLE |
> +				    ATMEL_XLCDC_LAYER_HSCALER_LUMA_ENABLE |
> +				    ATMEL_XLCDC_LAYER_HSCALER_CHROMA_ENABLE);
> +
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 1,
> +				    yfactor);
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 3,
> +				    xfactor);
> +
> +	/*
> +	 * With YCbCr 4:2:2 and YCbYcr 4:2:0 window resampling, configuration
> +	 * register LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT is half
> +	 * the value of yfactor and xfactor.
> +	 */
> +	if (state->base.fb->format->format == DRM_FORMAT_YUV420) {
> +		yfactor /= 2;
> +		xfactor /= 2;
> +	}
> +
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 2,
> +				    yfactor);
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 4,
> +				    xfactor);
> +}
> +
>  static void
>  atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
>  				      struct atmel_hlcdc_plane_state *state)
> @@ -395,6 +444,40 @@ void atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>  				    cfg);
>  }
>  
> +static
> +void atmel_xlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> +					       struct atmel_hlcdc_plane_state *state)
> +{
> +	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	const struct drm_format_info *format = state->base.fb->format;
> +	unsigned int cfg;
> +
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, ATMEL_XLCDC_LAYER_DMA_CFG,
> +				    ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 | state->ahb_id);
> +
> +	cfg = ATMEL_XLCDC_LAYER_DMA | ATMEL_XLCDC_LAYER_REP;
> +
> +	if (plane->base.type != DRM_PLANE_TYPE_PRIMARY) {
> +		/*
> +		 * Alpha Blending bits specific to SAM9X7 SoC
> +		 */
> +		cfg |= ATMEL_XLCDC_LAYER_SFACTC_A0_MULT_AS |
> +		       ATMEL_XLCDC_LAYER_SFACTA_ONE |
> +		       ATMEL_XLCDC_LAYER_DFACTC_M_A0_MULT_AS |
> +		       ATMEL_XLCDC_LAYER_DFACTA_ONE;
> +		if (format->has_alpha)
> +			cfg |= ATMEL_XLCDC_LAYER_A0(0xff);
> +		else
> +			cfg |= ATMEL_XLCDC_LAYER_A0(state->base.alpha);
> +	}
> +
> +	if (state->disc_h && state->disc_w)
> +		cfg |= ATMEL_XLCDC_LAYER_DISCEN;
> +
> +	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.general_config,
> +				    cfg);
> +}
> +
>  static void atmel_hlcdc_plane_update_format(struct atmel_hlcdc_plane *plane,
>  					struct atmel_hlcdc_plane_state *state)
>  {
> @@ -461,6 +544,15 @@ static void update_hlcdc_buffers(struct atmel_hlcdc_plane *plane,
>  				    state->dscrs[i]->self);
>  }
>  
> +static void update_xlcdc_buffers(struct atmel_hlcdc_plane *plane,
> +				 struct atmel_hlcdc_plane_state *state,
> +				 u32 sr, int i)

*atmel*_update_xlcdc_buffers()

> +{
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_XLCDC_LAYER_PLANE_ADDR(i),
> +				    state->dscrs[i]->addr);
> +}
> +
>  static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
>  					     struct atmel_hlcdc_plane_state *state)
>  {
> @@ -470,7 +562,8 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
>  	u32 sr;
>  	int i;
>  
> -	sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
> +	if (!dc->desc->is_xlcdc)
> +		sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
>  
>  	for (i = 0; i < state->nplanes; i++) {
>  		struct drm_gem_dma_object *gem = drm_fb_dma_get_gem_obj(fb, i);
> @@ -739,6 +832,20 @@ static void hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
>  	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
>  }
>  
> +static void xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)

Same here: *atmel*_xlcdc_atomic_disable()

> +{
> +	/* Disable interrupts */
> +	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_IDR,
> +				    0xffffffff);
> +
> +	/* Disable the layer */
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_XLCDC_LAYER_ENR, 0);
> +
> +	/* Clear all pending interrupts */
> +	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
> +}
> +
>  static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>  					     struct drm_atomic_state *state)
>  {
> @@ -767,6 +874,28 @@ static void hlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
>  				    ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
>  }
>  
> +static void xlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
> +				struct atmel_hlcdc_dc *dc)

*atmel*_xlcdc_atomic_update()

> +{
> +	/* Enable the overrun interrupts. */
> +	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_IER,
> +				    ATMEL_XLCDC_LAYER_OVR_IRQ(0) |
> +				    ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
> +				    ATMEL_XLCDC_LAYER_OVR_IRQ(2));
> +
> +	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_XLCDC_LAYER_ENR,
> +				    ATMEL_XLCDC_LAYER_EN);
> +
> +	/*
> +	 * Updating XLCDC_xxxCFGx, XLCDC_xxxFBA and XLCDC_xxxEN,
> +	 * (where xxx indicates each layer) requires writing one to the
> +	 * Update Attribute field for each layer in LCDC_ATTRE register for SAM9X7.
> +	 */
> +	regmap_write(dc->hlcdc->regmap, ATMEL_XLCDC_ATTRE, ATMEL_XLCDC_BASE_UPDATE |
> +		     ATMEL_XLCDC_OVR1_UPDATE | ATMEL_XLCDC_OVR3_UPDATE |
> +		     ATMEL_XLCDC_HEO_UPDATE);
> +}
> +
>  static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
>  					    struct drm_atomic_state *state)
>  {
> @@ -815,6 +944,30 @@ static void hlcdc_csc_init(struct atmel_hlcdc_plane *plane,
>  	}
>  }
>  
> +static void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
> +			   const struct atmel_hlcdc_layer_desc *desc)

*atmel*_xlcdc_csc_init()

> +{
> +	/*
> +	 * yuv-to-rgb-conv-factors are now defined from LCDC_HEOCFG16 to
> +	 * LCDC_HEOCFG21 registers in SAM9X7.
> +	 */
> +	static const u32 xlcdc_csc_coeffs[] = {
> +		0x00000488,
> +		0x00000648,
> +		0x1EA00480,
> +		0x00001D28,
> +		0x08100480,
> +		0x00000000,
> +		0x00000007
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(xlcdc_csc_coeffs); i++) {
> +		atmel_hlcdc_layer_write_cfg(&plane->layer,
> +					    desc->layout.csc + i,
> +					    xlcdc_csc_coeffs[i]);
> +	}
> +}
> +
>  static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> @@ -865,6 +1018,23 @@ static void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>  			desc->name);
>  }
>  
> +static void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
> +			  const struct atmel_hlcdc_layer_desc *desc)

*atmel*_xlcdc_irq_dbg()

> +{
> +	u32 isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
> +
> +	/*
> +	 * There's not much we can do in case of overrun except informing
> +	 * the user. However, we are in interrupt context here, hence the
> +	 * use of dev_dbg().
> +	 */
> +	if (isr &
> +	    (ATMEL_XLCDC_LAYER_OVR_IRQ(0) | ATMEL_XLCDC_LAYER_OVR_IRQ(1) |
> +	     ATMEL_XLCDC_LAYER_OVR_IRQ(2)))
> +		dev_dbg(plane->base.dev->dev, "overrun on plane %s\n",
> +			desc->name);
> +}
> +
>  void atmel_hlcdc_plane_irq(struct atmel_hlcdc_plane *plane)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> @@ -883,6 +1053,16 @@ const struct atmel_lcdc_dc_ops atmel_hlcdc_ops = {
>  	.lcdc_irq_dbg = hlcdc_irq_dbg,
>  };
>  
> +const struct atmel_lcdc_dc_ops atmel_xlcdc_ops = {
> +	.plane_setup_scaler = atmel_xlcdc_plane_setup_scaler,
> +	.update_lcdc_buffers = update_xlcdc_buffers,
> +	.lcdc_atomic_disable = xlcdc_atomic_disable,
> +	.lcdc_update_general_settings = atmel_xlcdc_plane_update_general_settings,
> +	.lcdc_atomic_update = xlcdc_atomic_update,
> +	.lcdc_csc_init = xlcdc_csc_init,
> +	.lcdc_irq_dbg = xlcdc_irq_dbg,
> +};
> +
>  static const struct drm_plane_helper_funcs atmel_hlcdc_layer_plane_helper_funcs = {
>  	.atomic_check = atmel_hlcdc_plane_atomic_check,
>  	.atomic_update = atmel_hlcdc_plane_atomic_update,

