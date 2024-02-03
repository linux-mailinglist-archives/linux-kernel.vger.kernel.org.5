Return-Path: <linux-kernel+bounces-51094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010184866A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD762B2589C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F85F46F;
	Sat,  3 Feb 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nkF82VLw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22F5F46C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965250; cv=none; b=Q9nKwyrAmiMq1mExqcgU+QJ3H9VXh70jyXUi8ECvnzU7fM7AkYY0MCCXksX89jIl9xJ+lCfC/3oDy+Ky9e0VDXMLUEFGEY/1T2zgOwNJokuckQE0fXFPKEcBA/703aMf5yezUmHuXipqBL5R8ST/8BSo3nJG4Zf9L21E58urw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965250; c=relaxed/simple;
	bh=DZ7izOTxdtGukWCGE+54KXB7f8w9zmaRtpi+vj1kBgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QelMR0vR4NjaZCWqsfiQoTslGnP8NYd/q/jAOhoSmD06Kbgu4erqFD6qUeOuug6ZFg/PVbf+XPBpzGxZMXUh3c5uTuanRDdN42me8Mp/ly/MfupdztLgWGYVMfj739kI8RxZrvr9+YhcxqzBmdO43SZdPS95kbtoknsaBUQjHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nkF82VLw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a363961b96aso384381966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706965246; x=1707570046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5wAKcnw1l+yIsrTbIaRCHzqvGc5quMnbZPp+h172l4=;
        b=nkF82VLwkR6jBICDtVQvk4jR/ZIlXrhRelM7h50uCHhC+5sdhxuGJ04fnU6GtXYr7t
         Wg+pt7wMa/KUmPT6WGVkwNGYSh/uwCXMNb2fESX8qVfsu3cyZRdiYmzvl/+G3yERPMI8
         dX3yPiU7TmA+K60Gnj+Xm19HhPgopQAV9XmaTbx1qDWXGFNvpoQqHIAE24EN4z0pk5vm
         7sw7CM7ab++zhpIqn9nZdlOYGO3RjK3CzxPq3plWc0ky1E+9oYAFM1ZnKtuv0bWoYPRM
         kCnCdzJo0LF+uGDa4joeCZnNB21XzktBjnDlqarGJTBL0SS/q/1ooS4W2zbHA0DWf6+f
         ZrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706965246; x=1707570046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5wAKcnw1l+yIsrTbIaRCHzqvGc5quMnbZPp+h172l4=;
        b=ct/hISoynSdjoyxtou1HnJpnT65M7oujXgDM98stteUiLoV1trfOcYFAE5z1NCgIDj
         u6lbrQ6Zx2hSRk1iZJC49mKW6QiP6B1n8Sw6iVOrYib4U9sA2SxpFdIY/Uk1tzho7Ff0
         sDrlfC/NHQR60pRuwZaMFHfV+SK7r+DZXdigG22UKIZ5ZkD0D1Z/iGjJlUAb5HzLA4QT
         OpYO/JaIqZeBPwFUJrRTwZzyIJNik1IrsbXj4Ovudgz1L3/8W5mpzmRX7aGkg+0Qgezy
         gixvj+SrkdJe7NCZCDDreFjEI+4lfMjiq8ECysm4hf70sN7QjVjFZeaHaPtjMM6pd/jW
         ku4g==
X-Forwarded-Encrypted: i=0; AJvYcCUMZy/WsJHe5awUPB6ua7EL/0lqcxruY+lTHqNVt4igMtxk+iC+S5YAl1d/687lppGedm0swnUAxo+aoH/Hf55UUbP8U+JdY/+n72+h
X-Gm-Message-State: AOJu0YxZqhLLWn6rwyiUe+uB0JO64q/EqVVsOiWBhfDEE6wcZ3QpDM9E
	micC7PYG/4Tkpvq0qMs/JSnscffG07JUUSgHQkngRFJgPTBfUd2QusJLfhNHRjc=
X-Google-Smtp-Source: AGHT+IGccFeCKNCOAifWY+0m7txwHjc7dGTJndEccNUfXyCnBYpkC6sCLHewdrlKc4W0c2UrlowHuw==
X-Received: by 2002:a17:906:3c0e:b0:a37:490a:b3d6 with SMTP id h14-20020a1709063c0e00b00a37490ab3d6mr1165820ejg.63.1706965245534;
        Sat, 03 Feb 2024 05:00:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWwiQW/Y8HHpqP1WEPmOBm2PYZN7mP3IeiChfcQtzwDywzys0t2ndSbB9sXYZsxTeJwOe/otUDHKL1Wdnrn7huSGtpjjHv2LFnOYrc4Smgl+gDQ0QdXzFhX08U0NfW7/uy4wnBC0Dufcl54tBqPV81cL+aXukMVl2tDK8xeDXNWdzoumpJGsFDX/rnAohkF4VfycmBFI2jSkXnlG/sNxThGKYkoumpJm6NciiX0G/WqZCmPOp/PCWD2WFrIDZTQApapOK4QnaAlsFwBdUbLpQNp8TA4l2rrtwJBNlAlAwXFLV98yv1NlC/bEFcCA3dlwFR1l03Yg7TGW3jIwY2WN6ZV9Nd8G8gaDCFabcQo7CMF33ou0cNCQUnK+vxG0WMMQlhTFvTuPlF5OvTH+VlwoAUUdxT7ALhb0RNJKQtMypQ0GsKbiJpp/KJqImD+skZ4JtByP+teXwB8lV4eIEFn6M5ORJWeK5uh1B9rf6eYFB2PUD6Mo7c9ieawHHuKSeU9hF4Gy3ii3ZuRXdIwthQ78qwfz1bJr87JTmV9vHXiKZjLqCDp5EyOxTIREdXxQCTkZZ3WC1my8VEUEC6tLS2H63Mvt5gkqk48flzZ1UqDFoxgeIGCqECAKu6Lo48Y/4BQnzBcFkxwHNYLKZJJdrJgTEhXfKLv8khRt8bw4mDec1K+wzszyVHe/Ho=
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906475400b00a353ca3d907sm1958807ejs.217.2024.02.03.05.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 05:00:44 -0800 (PST)
Message-ID: <ff4fdb85-f89e-4c51-a99a-79d2e18e73ab@tuxon.dev>
Date: Sat, 3 Feb 2024 15:00:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 4/7] drm: atmel_hlcdc: Add support for XLCDC in
 atmel LCD driver
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
 <20240129092319.199365-5-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240129092319.199365-5-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.01.2024 11:23, Manikandan Muralidharan wrote:
> XLCDC in SAM9X7 has different sets of registers and additional
> configuration bits when compared to previous HLCDC IP. Read/write
> operation on the controller registers is now separated using the
> XLCDC status flag and with HLCDC and XLCDC IP specific ops.
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
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |  33 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |   6 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |   3 +
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 349 +++++++++++++++---
>  4 files changed, 329 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index cc5cf4c2faf7..1ac31c0c474a 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -79,6 +79,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
>  	unsigned int cfg = 0;
>  	int div, ret;
> +	bool is_xlcdc = crtc->dc->desc->is_xlcdc;

You may want to keep reverse christmass tree order, with this, though the
mask variable breaks it.

>  
>  	/* get encoder from crtc */
>  	drm_for_each_encoder(en_iter, ddev) {
> @@ -164,10 +165,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
>  	cfg = state->output_mode << 8;
>  
> -	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
> +	if (!is_xlcdc && (adj->flags & DRM_MODE_FLAG_NVSYNC))
>  		cfg |= ATMEL_HLCDC_VSPOL;
>  
> -	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
> +	if (!is_xlcdc && (adj->flags & DRM_MODE_FLAG_NHSYNC))
>  		cfg |= ATMEL_HLCDC_HSPOL;

Instead of checking 2 times the !is_xlcdc you can have on check: e.g.:

if (!is_xlcdc) {
        if (adj->flags & DRM_MODE_FLAG_NVSYNC)
 		cfg |= ATMEL_HLCDC_VSPOL;

	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
 		cfg |= ATMEL_HLCDC_HSPOL;
}

>  
>  	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
> @@ -202,6 +203,20 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
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
>  	while (!regmap_read(regmap, ATMEL_HLCDC_SR, &status) &&

Not related to this patch: it may worth implementing the same approach
accross all bits polling instructions in this function.

>  	       (status & ATMEL_HLCDC_DISP))
> @@ -256,6 +271,20 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  	       !(status & ATMEL_HLCDC_DISP))
>  		cpu_relax();
>  
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
> +
>  	pm_runtime_put_sync(dev->dev);
>  
>  }
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index d30aec174aa2..18a3a95f94be 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -58,6 +58,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9n12 = {
>  	.conflicting_output_formats = true,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9n12_layers),
>  	.layers = atmel_hlcdc_at91sam9n12_layers,
> +	.ops = &atmel_hlcdc_ops,
>  };
>  
>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9x5_layers[] = {
> @@ -151,6 +152,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9x5 = {
>  	.conflicting_output_formats = true,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9x5_layers),
>  	.layers = atmel_hlcdc_at91sam9x5_layers,
> +	.ops = &atmel_hlcdc_ops,
>  };
>  
>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d3_layers[] = {
> @@ -269,6 +271,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d3 = {
>  	.conflicting_output_formats = true,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d3_layers),
>  	.layers = atmel_hlcdc_sama5d3_layers,
> +	.ops = &atmel_hlcdc_ops,
>  };
>  
>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sama5d4_layers[] = {
> @@ -364,6 +367,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d4 = {
>  	.max_hpw = 0x3ff,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d4_layers),
>  	.layers = atmel_hlcdc_sama5d4_layers,
> +	.ops = &atmel_hlcdc_ops,
>  };
>  
>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_sam9x60_layers[] = {
> @@ -460,6 +464,7 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 = {
>  	.fixed_clksrc = true,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_sam9x60_layers),
>  	.layers = atmel_hlcdc_sam9x60_layers,
> +	.ops = &atmel_hlcdc_ops,
>  };
>  
>  static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
> @@ -553,6 +558,7 @@ static const struct atmel_hlcdc_dc_desc atmel_xlcdc_dc_sam9x75 = {
>  	.is_xlcdc = true,
>  	.nlayers = ARRAY_SIZE(atmel_xlcdc_sam9x75_layers),
>  	.layers = atmel_xlcdc_sam9x75_layers,
> +	.ops = &atmel_xlcdc_ops,
>  };
>  
>  static const struct of_device_id atmel_hlcdc_of_match[] = {
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index e6b4b0bb11b9..1ef15f2d536c 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -424,6 +424,9 @@ struct atmel_hlcdc_dc {
>  	} suspend;
>  };
>  
> +extern const struct atmel_lcdc_dc_ops atmel_hlcdc_ops;
> +extern const struct atmel_lcdc_dc_ops atmel_xlcdc_ops;
> +
>  extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
>  extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_and_yuv_formats;
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index daa508504f47..59ddd743ce92 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -282,8 +282,9 @@ atmel_hlcdc_plane_scaler_set_phicoeff(struct atmel_hlcdc_plane *plane,
>  					    coeff_tab[i]);
>  }
>  
> -static void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
> -					   struct atmel_hlcdc_plane_state *state)
> +static
> +void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_plane_state *state)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
>  	u32 xfactor, yfactor;
> @@ -330,11 +331,61 @@ static void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
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
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
>  
>  	if (desc->layout.size)
>  		atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.size,
> @@ -352,12 +403,12 @@ atmel_hlcdc_plane_update_pos_and_size(struct atmel_hlcdc_plane *plane,
>  					ATMEL_HLCDC_LAYER_POS(state->crtc_x,
>  							      state->crtc_y));
>  
> -	atmel_hlcdc_plane_setup_scaler(plane, state);
> +	dc->desc->ops->plane_setup_scaler(plane, state);
>  }
>  
> -static void
> -atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> -					struct atmel_hlcdc_plane_state *state)
> +static
> +void atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> +					       struct atmel_hlcdc_plane_state *state)
>  {
>  	unsigned int cfg = ATMEL_HLCDC_LAYER_DMA_BLEN_INCR16 | state->ahb_id;
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> @@ -393,6 +444,40 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
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
> @@ -437,36 +522,55 @@ static void atmel_hlcdc_plane_update_clut(struct atmel_hlcdc_plane *plane,
>  	}
>  }
>  
> +static void update_hlcdc_buffers(struct atmel_hlcdc_plane *plane,
> +				 struct atmel_hlcdc_plane_state *state,
> +				 u32 sr, int i)
> +{
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_HLCDC_LAYER_PLANE_HEAD(i),
> +				    state->dscrs[i]->self);
> +
> +	if (sr & ATMEL_HLCDC_LAYER_EN)
> +		return;
> +
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_HLCDC_LAYER_PLANE_ADDR(i),
> +				    state->dscrs[i]->addr);
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_HLCDC_LAYER_PLANE_CTRL(i),
> +				    state->dscrs[i]->ctrl);
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_HLCDC_LAYER_PLANE_NEXT(i),
> +				    state->dscrs[i]->self);
> +}
> +
> +static void update_xlcdc_buffers(struct atmel_hlcdc_plane *plane,
> +				 struct atmel_hlcdc_plane_state *state,
> +				 u32 sr, int i)
> +{
> +	atmel_hlcdc_layer_write_reg(&plane->layer,
> +				    ATMEL_XLCDC_LAYER_PLANE_ADDR(i),
> +				    state->dscrs[i]->addr);
> +}
> +
>  static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
> -					struct atmel_hlcdc_plane_state *state)
> +					     struct atmel_hlcdc_plane_state *state)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
>  	struct drm_framebuffer *fb = state->base.fb;
>  	u32 sr;
>  	int i;
>  
> -	sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
> +	if (!dc->desc->is_xlcdc)
> +		sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
>  
>  	for (i = 0; i < state->nplanes; i++) {
>  		struct drm_gem_dma_object *gem = drm_fb_dma_get_gem_obj(fb, i);
>  
>  		state->dscrs[i]->addr = gem->dma_addr + state->offsets[i];
>  
> -		atmel_hlcdc_layer_write_reg(&plane->layer,
> -					    ATMEL_HLCDC_LAYER_PLANE_HEAD(i),
> -					    state->dscrs[i]->self);
> -
> -		if (!(sr & ATMEL_HLCDC_LAYER_EN)) {
> -			atmel_hlcdc_layer_write_reg(&plane->layer,
> -					ATMEL_HLCDC_LAYER_PLANE_ADDR(i),
> -					state->dscrs[i]->addr);
> -			atmel_hlcdc_layer_write_reg(&plane->layer,
> -					ATMEL_HLCDC_LAYER_PLANE_CTRL(i),
> -					state->dscrs[i]->ctrl);
> -			atmel_hlcdc_layer_write_reg(&plane->layer,
> -					ATMEL_HLCDC_LAYER_PLANE_NEXT(i),
> -					state->dscrs[i]->self);
> -		}
> +		dc->desc->ops->update_lcdc_buffers(plane, state, sr, i);
>  
>  		if (desc->layout.xstride[i])
>  			atmel_hlcdc_layer_write_cfg(&plane->layer,
> @@ -712,11 +816,8 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  	return 0;
>  }
>  
> -static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
> -					     struct drm_atomic_state *state)
> +static void hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
>  {
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -
>  	/* Disable interrupts */
>  	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IDR,
>  				    0xffffffff);
> @@ -731,6 +832,70 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>  	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
>  }
>  
> +static void xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane)
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
> +static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
> +					     struct drm_atomic_state *state)
> +{
> +	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> +	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
> +
> +	dc->desc->ops->lcdc_atomic_disable(plane);
> +}
> +
> +static void hlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
> +				struct atmel_hlcdc_dc *dc)
> +{
> +	u32 sr;
> +
> +	/* Enable the overrun interrupts. */
> +	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IER,
> +				    ATMEL_HLCDC_LAYER_OVR_IRQ(0) |
> +				    ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
> +				    ATMEL_HLCDC_LAYER_OVR_IRQ(2));
> +
> +	/* Apply the new config at the next SOF event. */
> +	sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
> +	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHER,
> +				    ATMEL_HLCDC_LAYER_UPDATE |
> +				    (sr & ATMEL_HLCDC_LAYER_EN ?
> +				    ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
> +}
> +
> +static void xlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
> +				struct atmel_hlcdc_dc *dc)
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
> @@ -739,7 +904,7 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
>  	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>  	struct atmel_hlcdc_plane_state *hstate =
>  			drm_plane_state_to_atmel_hlcdc_plane_state(new_s);
> -	u32 sr;
> +	struct atmel_hlcdc_dc *dc = p->dev->dev_private;
>  
>  	if (!new_s->crtc || !new_s->fb)
>  		return;
> @@ -750,29 +915,63 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
>  	}
>  
>  	atmel_hlcdc_plane_update_pos_and_size(plane, hstate);
> -	atmel_hlcdc_plane_update_general_settings(plane, hstate);
> +	dc->desc->ops->lcdc_update_general_settings(plane, hstate);
>  	atmel_hlcdc_plane_update_format(plane, hstate);
>  	atmel_hlcdc_plane_update_clut(plane, hstate);
>  	atmel_hlcdc_plane_update_buffers(plane, hstate);
>  	atmel_hlcdc_plane_update_disc_area(plane, hstate);
>  
> -	/* Enable the overrun interrupts. */
> -	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_IER,
> -				    ATMEL_HLCDC_LAYER_OVR_IRQ(0) |
> -				    ATMEL_HLCDC_LAYER_OVR_IRQ(1) |
> -				    ATMEL_HLCDC_LAYER_OVR_IRQ(2));
> +	dc->desc->ops->lcdc_atomic_update(plane, dc);
> +}
>  
> -	/* Apply the new config at the next SOF event. */
> -	sr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
> -	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHER,
> -			ATMEL_HLCDC_LAYER_UPDATE |
> -			(sr & ATMEL_HLCDC_LAYER_EN ?
> -			 ATMEL_HLCDC_LAYER_A2Q : ATMEL_HLCDC_LAYER_EN));
> +static void hlcdc_csc_init(struct atmel_hlcdc_plane *plane,
> +			   const struct atmel_hlcdc_layer_desc *desc)
> +{
> +	/*
> +	 * TODO: declare a "yuv-to-rgb-conv-factors" property to let
> +	 * userspace modify these factors (using a BLOB property ?).
> +	 */
> +	static const u32 hlcdc_csc_coeffs[] = {
> +		0x4c900091,
> +		0x7a5f5090,
> +		0x40040890
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(hlcdc_csc_coeffs); i++) {
> +		atmel_hlcdc_layer_write_cfg(&plane->layer,
> +					    desc->layout.csc + i,
> +					    hlcdc_csc_coeffs[i]);
> +	}
> +}
> +
> +static void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
> +			   const struct atmel_hlcdc_layer_desc *desc)
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
>  }
>  
>  static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
>  
>  	if (desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
>  	    desc->type == ATMEL_HLCDC_CURSOR_LAYER) {
> @@ -796,31 +995,16 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
>  			return ret;
>  	}
>  
> -	if (desc->layout.csc) {
> -		/*
> -		 * TODO: decare a "yuv-to-rgb-conv-factors" property to let
> -		 * userspace modify these factors (using a BLOB property ?).
> -		 */
> -		atmel_hlcdc_layer_write_cfg(&plane->layer,
> -					    desc->layout.csc,
> -					    0x4c900091);
> -		atmel_hlcdc_layer_write_cfg(&plane->layer,
> -					    desc->layout.csc + 1,
> -					    0x7a5f5090);
> -		atmel_hlcdc_layer_write_cfg(&plane->layer,
> -					    desc->layout.csc + 2,
> -					    0x40040890);
> -	}
> +	if (desc->layout.csc)
> +		dc->desc->ops->lcdc_csc_init(plane, desc);
>  
>  	return 0;
>  }
>  
> -void atmel_hlcdc_plane_irq(struct atmel_hlcdc_plane *plane)
> +static void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
> +			  const struct atmel_hlcdc_layer_desc *desc)
>  {
> -	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> -	u32 isr;
> -
> -	isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
> +	u32 isr = atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
>  
>  	/*
>  	 * There's not much we can do in case of overrun except informing
> @@ -834,6 +1018,51 @@ void atmel_hlcdc_plane_irq(struct atmel_hlcdc_plane *plane)
>  			desc->name);
>  }
>  
> +static void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
> +			  const struct atmel_hlcdc_layer_desc *desc)
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
> +void atmel_hlcdc_plane_irq(struct atmel_hlcdc_plane *plane)
> +{
> +	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
> +	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
> +
> +	dc->desc->ops->lcdc_irq_dbg(plane, desc);
> +}
> +
> +const struct atmel_lcdc_dc_ops atmel_hlcdc_ops = {
> +	.plane_setup_scaler = atmel_hlcdc_plane_setup_scaler,
> +	.update_lcdc_buffers = update_hlcdc_buffers,
> +	.lcdc_atomic_disable = hlcdc_atomic_disable,
> +	.lcdc_update_general_settings = atmel_hlcdc_plane_update_general_settings,
> +	.lcdc_atomic_update = hlcdc_atomic_update,
> +	.lcdc_csc_init = hlcdc_csc_init,
> +	.lcdc_irq_dbg = hlcdc_irq_dbg,
> +};

All the changes related to HLCDC (this new object, changes in
atmel_hlcdc_dc.{c,h}, hlcdc changes in atmel_hlcdc_plane.c) should go in a
separate patch (I think patch 1 is the good candidate but remove xlcdc
specific changes from there) where you update current code to use this new
object and then the next patches will be XLCDC support.

> +
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

