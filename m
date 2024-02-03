Return-Path: <linux-kernel+bounces-51095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDC84866B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813C5288DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE72BAEF;
	Sat,  3 Feb 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FdO6qEHm"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B95A7AB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965263; cv=none; b=JAF1ZokyornqONW31X2xanr+JhXJuPDTF6i71zo3i30NGhvE0dWkW2T3tI5RAg7PznHPOZ39ry9odK5XXpwaeAHzPhEHDRQwVlSY9SdGcyam5FeoyOx1KAoEzOAtPoIzkpMp+eilLAawmevPARg0nZjfGo/xPJB0GuZQIBzDwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965263; c=relaxed/simple;
	bh=7rSpB0nU0b2/dNUxwrPn2AZ6DBcR1jiIE49sFSTkRPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+yQUEKrVyRayYoq8zgowHoXQ10CMqlFNjysErNtf4SKxDNYaIz2lI7OhsD/qwBfIyxXG6pxTkAhY0ISdQywS6dFC22oP/UI22d57xjXY+w52/J7Wq1dezN1SEuv/CcRYWbiB/Z3rVccC5uVWelZqbPjw1DWbaZm2tostuJsJM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FdO6qEHm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a35e9161b8cso396920466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706965260; x=1707570060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXXLhm+7PbWIgSfLKf0icn4+qsgOPzaBP/drVsTMN0k=;
        b=FdO6qEHm8lKQyP5x4NBOQhMgzNVgjPyKHGcWqpS9UpavcTZb89WBb2uBu8u1jugQXO
         CmmjwI22I8XLjSQFUls0JalVCvIwI/b4WXWyz9R7QJWJ+eGvK+UwM0sA1d9/5UAlX8+H
         9VyHGbYcVqKxK/5ExrFtc5G+RXAgpzJelQAQixBiIFVbFvVKZ+X/CtKGvnfi6sieFYQa
         QqIt8cA9V5l/ViSFLEyNlG5+SxBzR5O/znjY7cj7tcYnPH/xSGdPINx7CnOHshQfcem9
         1UapY0tJlbn6f1mTC7zxQRVUlgWS4O2QHsLvvW42XwhyCYstuhcQdbNbgHFAgP/jnmnc
         s7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706965260; x=1707570060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXXLhm+7PbWIgSfLKf0icn4+qsgOPzaBP/drVsTMN0k=;
        b=Yae+l2vjRjD25oNL7xXb1mkTKG+UixeSbaHR3jhKONFvSrdb7oku97x9PBud29sJkO
         otvipvT6iJeM2N+folOnj3cty8t/+Lbw5zCDuTLR6m9+VxemK7P3mNdHJgpJkxUt2BMY
         AA4pyiBVfKhQ+ceIJYOWjbmoEe75rVFBL8HOSOx+vU8ESSutipyeyFtWkhqisgx9EAmL
         K4tclds0zKZe65FyypxWU8sK/412GqJsL5IaURntmzEhGamqix5DtInTLVkmYjcIxW7Q
         ie+iT0Vuem2+5ONPAEWwhz6eJXOvC9AGamhW1LH0BRw1r2U5fPztARjfM8A3ohuyctPC
         hqyg==
X-Gm-Message-State: AOJu0YxWATUUjeO6eChw+j/S31xLDtIF4agjcti5IwUUaOE9FZ9d53ob
	tsquN3FXwjSlzZoNKT72GChGSf6CN6KzRgY8aSAEhZS8rqFDz8VzwCBZs1Q853s=
X-Google-Smtp-Source: AGHT+IHGv+M6iG4sCXmqfFYzPiVgB9HE0HXDRy0iQ1U6z8YbHB5KAFcEahxCiKkjzWAduKFodubbJQ==
X-Received: by 2002:a17:906:185:b0:a36:1c9e:9169 with SMTP id 5-20020a170906018500b00a361c9e9169mr3539702ejb.2.1706965260183;
        Sat, 03 Feb 2024 05:01:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4Btk0cHulKHMkWDV+2Ft479Xlu0uv+dg/qyPdW+gZQlaCKx5szLMVFDi+EahFza9LvPpYQnnauDTlzOREreFkEKEYRJ8d6A1fzcbFvb69bJHZt9oKOdayLRXnNFOyM5BObUhhGFnty3qzn8EMQYby7Jv+YBA7XEn9YklDSwhOswtQmRJcyqHLmsmPbah4iijaC6OZ2CYHZz1o3HpTWRwJiW3yJ15OuXXXVlhX64Kup+5NlahZN8LyNA6IviieU4N7UTJtqyLDKTSmtWoNDiUeMb8FwR/KoZ0q1hl41iJS31utwxs6pfg7Ie4RXgNWBPL2E1iRy45xDxaYsjHsgIaJNchvF6aAY/08/J8KD4uFUxk11Jps+IULDFBuQH6Ph5Nq/bp6L3UAnv8ryo7a84rSxzLMUbgvJWBkJbq5ZTDXoN7I7Gf+clx9JwuMDX/RU/rzwwsKzsE6oZ3UTE5D4M7J11mnmRyR1tca+hmdDeo3A9xy6hA4hWBRPHiTUPSwCPGfNJUvkONdxyCl3rvBDzuXQ7PgYOk57kawOPG5Ho4XQUnlYykCy1D59ySvgKT55PCkvmOxiYXnfoqbfeai4Yaany8BSw9r5Q0WopRP2zrLgx9FWL0xxRk3Xipy6S2q9OcYUCbi3Tpc+evPmlEWeLA9f092wq6yk9nMPfKFKIv3+7mZsuC0oQ4=
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906475400b00a353ca3d907sm1958807ejs.217.2024.02.03.05.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 05:00:59 -0800 (PST)
Message-ID: <d78559db-65c4-4a1b-9921-4c0217b5e2f7@tuxon.dev>
Date: Sat, 3 Feb 2024 15:00:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 7/7] drm: atmel-hlcdc: add support for DSI
 output formats
Content-Language: en-US
To: Manikandan Muralidharan <manikandan.m@microchip.com>, sam@ravnborg.org,
 bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, Balamanikandan.Gunasundar@microchip.com,
 Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
 Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
 Balakrishnan.S@microchip.com
References: <20240129092319.199365-1-manikandan.m@microchip.com>
 <20240129092319.199365-8-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240129092319.199365-8-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.01.2024 11:23, Manikandan Muralidharan wrote:
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
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 123 +++++++++++++-----
>  1 file changed, 88 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 1899be2eb6a3..6f529769b036 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -295,11 +295,18 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
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
>  
>  static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  {
> @@ -313,53 +320,99 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
>  	if (!encoder)
>  		encoder = connector->encoder;
>  
> -	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> -	case 0:
> -		break;
> -	case MEDIA_BUS_FMT_RGB444_1X12:
> -		return ATMEL_HLCDC_RGB444_OUTPUT;
> -	case MEDIA_BUS_FMT_RGB565_1X16:
> -		return ATMEL_HLCDC_RGB565_OUTPUT;
> -	case MEDIA_BUS_FMT_RGB666_1X18:
> -		return ATMEL_HLCDC_RGB666_OUTPUT;
> -	case MEDIA_BUS_FMT_RGB888_1X24:
> -		return ATMEL_HLCDC_RGB888_OUTPUT;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	for (j = 0; j < info->num_bus_formats; j++) {
> -		switch (info->bus_formats[j]) {
> -		case MEDIA_BUS_FMT_RGB444_1X12:
> -			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;

To generate less diff here and have a cleaner code you can move all this
DSI specific code in a different function and have here something like:

	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
		return atmel_hlcdc_connector_output_dsi();

> +	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI) {
> +		/*
> +		 * atmel-hlcdc to support DSI formats with DSI video pipeline
> +		 * when DRM_MODE_ENCODER_DSI type is set by
> +		 * connector driver component.
> +		 */
> +		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +		case 0:
>  			break;
>  		case MEDIA_BUS_FMT_RGB565_1X16:
> -			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> -			break;
> +			return ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
>  		case MEDIA_BUS_FMT_RGB666_1X18:
> -			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> -			break;
> +			return ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +			return ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
>  		case MEDIA_BUS_FMT_RGB888_1X24:
> -			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> -			break;
> +			return ATMEL_HLCDC_DPI_RGB888_OUTPUT;
>  		default:
> +			return -EINVAL;
> +		}
> +
> +		for (j = 0; j < info->num_bus_formats; j++) {
> +			switch (info->bus_formats[j]) {
> +			case MEDIA_BUS_FMT_RGB565_1X16:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB565C1_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X18:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB666C1_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB666C2_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB888_1X24:
> +				supported_fmts |=
> +					ATMEL_HLCDC_DPI_RGB888_OUTPUT;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	} else {
> +		switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
> +		case 0:
>  			break;
> +		case MEDIA_BUS_FMT_RGB444_1X12:
> +			return ATMEL_HLCDC_RGB444_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +			return ATMEL_HLCDC_RGB565_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +			return ATMEL_HLCDC_RGB666_OUTPUT;
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			return ATMEL_HLCDC_RGB888_OUTPUT;
> +		default:
> +			return -EINVAL;
>  		}
> -	}
>  
> +		for (j = 0; j < info->num_bus_formats; j++) {
> +			switch (info->bus_formats[j]) {
> +			case MEDIA_BUS_FMT_RGB444_1X12:
> +				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB565_1X16:
> +				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB666_1X18:
> +				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> +				break;
> +			case MEDIA_BUS_FMT_RGB888_1X24:
> +				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
>  	return supported_fmts;
>  }
>  
>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  {
> -	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
> +	unsigned int output_fmts;
>  	struct atmel_hlcdc_crtc_state *hstate;
>  	struct drm_connector_state *cstate;
>  	struct drm_connector *connector;
> -	struct atmel_hlcdc_crtc *crtc;
> +	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);

Previous code uses reverse christmass tree order for variable, thus, try to
keep it the same.

>  	int i;
> +	bool is_xlcdc = crtc->dc->desc->is_xlcdc;
>  
> -	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
> +	output_fmts = is_xlcdc ? ATMEL_XLCDC_OUTPUT_MODE_MASK :
> +		      ATMEL_HLCDC_OUTPUT_MODE_MASK;
>  
>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
>  		unsigned int supported_fmts = 0;
> @@ -380,7 +433,7 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  
>  	hstate = drm_crtc_state_to_atmel_hlcdc_crtc_state(state);
>  	hstate->output_mode = fls(output_fmts) - 1;
> -	if (crtc->dc->desc->is_xlcdc) {
> +	if (is_xlcdc) {
>  		/* check if MIPI DPI bit needs to be set */
>  		if (fls(output_fmts) > 3) {
>  			hstate->output_mode -= 4;

