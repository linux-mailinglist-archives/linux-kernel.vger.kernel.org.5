Return-Path: <linux-kernel+bounces-79638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90313862514
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45921C21193
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04E3F9F3;
	Sat, 24 Feb 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JFz9xnOJ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE13F9E6
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708779017; cv=none; b=sHYGtjGYEN/OKqEE7oYePqELIE/JduQcsZr6wlN93mAigGWT70kym3oqDEbXUUCgmI1NLNcMlfjF0ayZvBBP0Sps7SD+7xbfm9VSfGbY28LqHcv4Lc2aoo1vjlaO2HcJwAMtvOHB1eyTjXoTvLSW1DaQNvrT3ag3tmOVlAGPZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708779017; c=relaxed/simple;
	bh=SfKBHIjdpwGiiTmysoL+HYuTdIHiEPvN/Cwh5qWciW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF0/UTS4dGWV8HaPbhw6FPDlm/btxafzX8kX6oiysfoB9fTbmp75nAbttXS2ztMzULe2zer8hICkb6NBpKBwLF3WSgnbN2KsnfeXcvx9jEZrxU6NGHbqM0ACiZ+ZbzArOo2z82myJfIckogHdFAADr4iPmKjX3RzdNcXZYS5PRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JFz9xnOJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so599802a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708779014; x=1709383814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuTlLyUo4uFAvQcCBLpwHyaTW/5qupONRWcPbYCKFqk=;
        b=JFz9xnOJ1SAfMgDC6270hmHPQzhyNqyVdmUoOqhJymqMOAgx+RJbCLpP50knngsaZ0
         4ImC8HZYCJR9Bv1K+0+xEeREjYkzsKGsJFLlnnU0er3Cjm+TwNLDMAbln/7nsVXrLyjf
         oGqcABGBeb45xD48eKLp80jNAmbossnaeA2Tq2OwbCIMaLzYtTGXKRE8OU/uBFzKTPPK
         AWp1VbCQDdZOc7L/82tRNz8A+yZZF2WUHdQjBIGtCdY1mo5Mm155dDjkKH5QFslXk2+j
         rF0sjh/50ld7ggg6B7dbLtzEXwdsIsGtP8+0XVB2rYek7mJxFTJNQlj90jH8AH4a/jjd
         MaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708779014; x=1709383814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuTlLyUo4uFAvQcCBLpwHyaTW/5qupONRWcPbYCKFqk=;
        b=gXgJhI83ttNXAfbzLRdorPim3RNSF4ohwTsW+XtPDm6J5WHSCmvCy9V8VNs92fVqCe
         7YMblwSBHTWbYvC44ngnUpSTDXzdEfN/P3+T6oTMrc4qjs7Ozz5XNxzdHRza8qeDQVF+
         XxOdGr4gcAPRtraX/zkCo9naFUdrMqoVlG39Se+q1tszHOoHgFSa6CwEVFUVQk3xi9ya
         M26a+8A/gzEy3E/I5daYU0dhCucqlBTZDztcVYBvLXVYoRmyotXK9l8QaUPGjS44iwWn
         q8VwppT4dIVXOZDsCf1pnHuQ7Kl0G71QOQqa38b85ZtB+A67fys/XxCyuC+FbD38AJ/s
         lr2w==
X-Forwarded-Encrypted: i=1; AJvYcCVpTiASgJTlO3nW4A3tWEWfkctxmPZnhqSrmX4vUULWNiGGoNxBLXk46kUGhZ6dA2DISWgCDPGrEoV6X4Z8ckNvTRq5z8OD9Bdak7yO
X-Gm-Message-State: AOJu0Ywwvc/sAi1XLVYKCgL19qQS9ox8twOOBQZ/UbH2zuNEh+CLRBVp
	lI7N8lpVHcf2T/h9VtM3auUwuGeQduc7sj9y3XEMRqa3L4qLlSCE4Eij8dBQu9rmYBErDnfFOQ7
	1
X-Google-Smtp-Source: AGHT+IHu9FCcbF9x8feK3ItjD8KyIY7xg1PR/SM2IT2reSS+4T7JX5wS/RLW92YXM1Gsl8SwUf0kdA==
X-Received: by 2002:a05:6402:340d:b0:564:2655:f1b4 with SMTP id k13-20020a056402340d00b005642655f1b4mr1618675edc.32.1708779013863;
        Sat, 24 Feb 2024 04:50:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7d6c9000000b005646c7b9712sm507336edr.16.2024.02.24.04.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 04:50:13 -0800 (PST)
Message-ID: <c75bd63c-05f8-4b45-bd01-99e1240b921a@tuxon.dev>
Date: Sat, 24 Feb 2024 14:50:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] drm: atmel-hlcdc: add support for DSI output
 formats
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
 <20240221053531.12701-7-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240221053531.12701-7-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.02.2024 07:35, Manikandan Muralidharan wrote:
> Add support for the following DPI mode if the encoder type
> is DSI as per the XLCDC IP datasheet:
> - 16BPPCFG1
> - 16BPPCFG2
> - 16BPPCFG3
> - 18BPPCFG1
> - 18BPPCFG2
> - 24BPP
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> [durai.manickamkr@microchip.com: update output format using is_xlcdc flag]
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 74 +++++++++++++++++--
>  1 file changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index fdd3a6bc0f79..0dbe85686fc2 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -301,11 +301,64 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  
>  }
>  
> -#define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
> -#define ATMEL_HLCDC_RGB565_OUTPUT	BIT(1)
> -#define ATMEL_HLCDC_RGB666_OUTPUT	BIT(2)
> -#define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
> -#define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
> +#define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
> +#define ATMEL_HLCDC_RGB565_OUTPUT		BIT(1)
> +#define ATMEL_HLCDC_RGB666_OUTPUT		BIT(2)
> +#define ATMEL_HLCDC_RGB888_OUTPUT		BIT(3)
> +#define ATMEL_HLCDC_DPI_RGB565C1_OUTPUT		BIT(4)
> +#define ATMEL_HLCDC_DPI_RGB565C2_OUTPUT		BIT(5)
> +#define ATMEL_HLCDC_DPI_RGB565C3_OUTPUT		BIT(6)
> +#define ATMEL_HLCDC_DPI_RGB666C1_OUTPUT		BIT(7)
> +#define ATMEL_HLCDC_DPI_RGB666C2_OUTPUT		BIT(8)
> +#define ATMEL_HLCDC_DPI_RGB888_OUTPUT		BIT(9)
> +#define ATMEL_HLCDC_OUTPUT_MODE_MASK		GENMASK(3, 0)
> +#define ATMEL_XLCDC_OUTPUT_MODE_MASK		GENMASK(9, 0)
> +
> +static int atmel_hlcdc_connector_output_dsi(struct drm_encoder *encoder,
> +					    struct drm_display_info *info)
> +{
> +	int j;
> +	unsigned int supported_fmts = 0;
> +
> +	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +	case 0:
> +		break;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		return ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		return ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +		return ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +		return ATMEL_HLCDC_DPI_RGB888_OUTPUT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (j = 0; j < info->num_bus_formats; j++) {
> +		switch (info->bus_formats[j]) {
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +			supported_fmts |=
> +				ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;

This can fit on the above line

> +			break;
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +			supported_fmts |=
> +				ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;

Ditto

> +			break;
> +		case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +			supported_fmts |=
> +				ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;

Ditto

> +			break;
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			supported_fmts |=
> +				ATMEL_HLCDC_DPI_RGB888_OUTPUT;

Ditto

> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return supported_fmts;
> +}
>  
>  static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  {
> @@ -318,6 +371,13 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  	encoder = state->best_encoder;
>  	if (!encoder)
>  		encoder = connector->encoder;
> +	/*
> +	 * atmel-hlcdc to support DSI formats with DSI video pipeline
> +	 * when DRM_MODE_ENCODER_DSI type is set by
> +	 * connector driver component.
> +	 */
> +	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
> +		return atmel_hlcdc_connector_output_dsi(encoder, info);
>  
>  	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
>  	case 0:
> @@ -358,7 +418,7 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  
>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  {
> -	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
> +	unsigned int output_fmts;
>  	struct atmel_hlcdc_crtc_state *hstate;
>  	struct drm_connector_state *cstate;
>  	struct drm_connector *connector;
> @@ -366,6 +426,8 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  	int i;
>  
>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
> +	output_fmts = crtc->dc->desc->is_xlcdc ? ATMEL_XLCDC_OUTPUT_MODE_MASK :
> +		      ATMEL_HLCDC_OUTPUT_MODE_MASK;
>  
>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
>  		unsigned int supported_fmts = 0;

