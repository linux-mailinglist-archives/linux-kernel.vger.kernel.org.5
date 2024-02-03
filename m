Return-Path: <linux-kernel+bounces-51093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB0848668
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC361C220B7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7055EE80;
	Sat,  3 Feb 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m2Td4mlu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CE5EE66
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965241; cv=none; b=WwnR3UsYBINNnVtLYUn/EbmA0AKI5Q8j/P1EOHO4tuI1BEgGpcUoFV5NEsp1FcyUCJFMcabzILcsF9knEc321S82e6RUJaue3Diq/RrzYNGGuNys6+MamWwKtP0rfehr+9LgosTu1pJVVZHreBMPMsC0r30cbKQ70bPjXuYMWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965241; c=relaxed/simple;
	bh=GMeRts1Z1uIeld5NYbnlsmzkbkeX6E4tjkgetl9Jdug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofqc3Zpfee9cz20ZqhD7c2btthP2YkhBhtuquox4tIAqPtnkcfGjBgknIZTsQTFNEKoSNcnSOhw3URGdtDpqjF7CUX01BJ5hNl+6NldeDxDk/mqiPEOtIkAk2HZgv1smtxY6zeHnXLtnZ2zwlRkZ45NKVwkbvOrPI6tTVLnhbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m2Td4mlu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26f73732c5so448824166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706965237; x=1707570037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/knouVfmu2O6HKWIkN4QLW0HPNxmrcNHEzX5pnbWez0=;
        b=m2Td4mluf/MnpfTiTwvLGTallDvzqhevX3V5E3CNRMK+EPmjNOxiSISpHZUFHdxkMY
         cYq0TkUVITfj9I26PmMoH7UnsuZJOH1n3u1LI8qJkorkfFttD1TsNYUjkC1sc2MmKYIt
         1tPKUHU15rcx0a9D2WyWujFAZ3AqcLV2AqmdqeEo+F717ywx7S8/01+iN4XxqvE98dLI
         vfp+D7AEkLkLe94QFWm6ecY0I84OeHWPdBP2uFTEy+HuAEVEV6ttO+DOPVEyckjD0ntp
         wdW+h1ZxHJ5+IfEwnQ7zX050GEkDQKFYnSZjYXesNiycXYt2PdryILCcOLs4ewchqNfZ
         +hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706965237; x=1707570037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/knouVfmu2O6HKWIkN4QLW0HPNxmrcNHEzX5pnbWez0=;
        b=TvQPsGhsrfwLMk3Pj4R0St9vWv1wW7z7jmog18slQ9DS2nBGRNJCXb5BykbpKyLhqY
         /Rd86DjWmYy2nXrPLYgf7bqBn+AAm4XMK/lSLpgt9t9RuGQFBsRMvwvfWJ1XhUY0+Ppl
         CHxXFtV3aKtG8irvJxLr3C+9F9NEb6hX1lGM0XMXbTiU8ttl+6nfWCv86X/2yNNcbdbq
         Ysy96gRGy05s1h6lnoGDRpR4Y59CJdWT0izXxcKhdZPyQny6/6WNqF9TESI++p+rWdVd
         SjkKoukDBmXzJdAuVwOy2HgU+/8WzCPzJkXxDtAcz7HELJbN5T5Jq0ZKONclXDwPAzJX
         it9w==
X-Gm-Message-State: AOJu0YxSF1QGmrlcSugiRIJnBGD2VoFEqCG+BrtWpGYeV0pw9PjiJViH
	AZicJNc59wlz/TEmlHX14+IogwrcwcsUVrjFc2xlGWwJ953FhEm4NIiJ/k1hHCk=
X-Google-Smtp-Source: AGHT+IGcqzSYhDb0vBtztqAQum5kNZ6be4LcMVRFNOgC7L1qc3DpRQIhwo4gWJZM0mZXHqYrIfVm4A==
X-Received: by 2002:a17:907:7746:b0:a36:f811:44f5 with SMTP id kx6-20020a170907774600b00a36f81144f5mr3169564ejc.47.1706965237199;
        Sat, 03 Feb 2024 05:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX4mfY1aeG51v6exRdlFHfaH4DKgOjFMUPYuFvbwhTZ96TA9Nt1ozweHFZzFQypMezx2e7PDLei2Aqi6hHhPqHMDJYJEZb4r2MSeI62aFoEsF12Mcfc87HlTUXvqAzCHufQbfAgO7u4oKMwf2iVD21SuyE3Gdrggsp0UtcFlOvw/WYFsK7HA1YrxCMMMKysSmpIKFfvYHqQ17nvBoHM0gIHjZYPgEQXj92aNUF1JITTnxgsZtKPbsopHH4Pb2UKnrznLO3V31Ybp04cNwFvccMPsV0dXheal1QStWlBB+jlfFVNFEqEYpKKNtO4dj2X7hQ4IQ4LwbkeK4WMNLNotnKV8WfqEm8vUUv1pIZ5ja12763L+6fAvQCLGgX9+54TT16InSNJV8xJ0sRaXn7liTYmI9wKbtzfgC5NqAgXJve04xw2S2V/AqJXU+q1W6TustbU8Q9UcXe91ZgHGRWQfH1q0i2GCxYyXqBEUWyvJu7CTNo+OcIg4nRwUeBOwXONKgnXKrza/cvBNQPzmYaTmvtOoBquOzN4km2pxbbMOorC5ogOkxmi8iKvlJRcbrxmRfBkyT/KfZ3Lx5gKGZFTmccmFR1sOp4iut1rbJfK46ej/tSKSC8GvZfOkFGOPKNfj7dY21Ts0GhwsddiNwCZSEZNW2+twpfkNs0PehTMMciD3RQ2NhX3cQQ=
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906475400b00a353ca3d907sm1958807ejs.217.2024.02.03.05.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 05:00:36 -0800 (PST)
Message-ID: <a6e3f9b7-2ff4-4c07-ad4c-675a7e1a0ae1@tuxon.dev>
Date: Sat, 3 Feb 2024 15:00:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 2/7] drm: atmel-hlcdc: add LCD controller layer
 definition for sam9x75
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
 <20240129092319.199365-3-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240129092319.199365-3-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.01.2024 11:23, Manikandan Muralidharan wrote:
> Add the LCD controller layer definition and descriptor structure for
> sam9x75 for the following layers:
> - Base Layer
> - Overlay1 Layer
> - Overlay2 Layer
> - High End Overlay
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 97 ++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index fa0f9a93d50d..d30aec174aa2 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -462,6 +462,99 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sam9x60 = {
>  	.layers = atmel_hlcdc_sam9x60_layers,
>  };
>  
> +static const struct atmel_hlcdc_layer_desc atmel_xlcdc_sam9x75_layers[] = {
> +	{
> +		.name = "base",
> +		.formats = &atmel_hlcdc_plane_rgb_formats,
> +		.regs_offset = 0x60,
> +		.id = 0,
> +		.type = ATMEL_HLCDC_BASE_LAYER,
> +		.cfgs_offset = 0x1c,
> +		.layout = {
> +			.xstride = { 2 },
> +			.default_color = 3,
> +			.general_config = 4,
> +			.disc_pos = 5,
> +			.disc_size = 6,
> +		},
> +		.clut_offset = 0x700,
> +	},
> +	{
> +		.name = "overlay1",
> +		.formats = &atmel_hlcdc_plane_rgb_formats,
> +		.regs_offset = 0x160,
> +		.id = 1,
> +		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> +		.cfgs_offset = 0x1c,
> +		.layout = {
> +			.pos = 2,
> +			.size = 3,
> +			.xstride = { 4 },
> +			.pstride = { 5 },
> +			.default_color = 6,
> +			.chroma_key = 7,
> +			.chroma_key_mask = 8,
> +			.general_config = 9,
> +		},
> +		.clut_offset = 0xb00,
> +	},
> +	{
> +		.name = "overlay2",
> +		.formats = &atmel_hlcdc_plane_rgb_formats,
> +		.regs_offset = 0x260,
> +		.id = 2,
> +		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> +		.cfgs_offset = 0x1c,
> +		.layout = {
> +			.pos = 2,
> +			.size = 3,
> +			.xstride = { 4 },
> +			.pstride = { 5 },
> +			.default_color = 6,
> +			.chroma_key = 7,
> +			.chroma_key_mask = 8,
> +			.general_config = 9,
> +		},
> +		.clut_offset = 0xf00,
> +	},
> +	{
> +		.name = "high-end-overlay",
> +		.formats = &atmel_hlcdc_plane_rgb_and_yuv_formats,
> +		.regs_offset = 0x360,
> +		.id = 3,
> +		.type = ATMEL_HLCDC_OVERLAY_LAYER,
> +		.cfgs_offset = 0x30,
> +		.layout = {
> +			.pos = 2,
> +			.size = 3,
> +			.memsize = 4,
> +			.xstride = { 5, 7 },
> +			.pstride = { 6, 8 },
> +			.default_color = 9,
> +			.chroma_key = 10,
> +			.chroma_key_mask = 11,
> +			.general_config = 12,
> +			.csc = 16,
> +			.scaler_config = 23,
> +		},
> +		.clut_offset = 0x1300,
> +	},
> +};
> +
> +static const struct atmel_hlcdc_dc_desc atmel_xlcdc_dc_sam9x75 = {
> +	.min_width = 0,
> +	.min_height = 0,
> +	.max_width = 2048,
> +	.max_height = 2048,
> +	.max_spw = 0xff,
> +	.max_vpw = 0xff,
> +	.max_hpw = 0x3ff,
> +	.fixed_clksrc = true,
> +	.is_xlcdc = true,
> +	.nlayers = ARRAY_SIZE(atmel_xlcdc_sam9x75_layers),
> +	.layers = atmel_xlcdc_sam9x75_layers,
> +};
> +
>  static const struct of_device_id atmel_hlcdc_of_match[] = {
>  	{
>  		.compatible = "atmel,at91sam9n12-hlcdc",
> @@ -487,6 +580,10 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
>  		.compatible = "microchip,sam9x60-hlcdc",
>  		.data = &atmel_hlcdc_dc_sam9x60,
>  	},
> +	{
> +		.compatible = "microchip,sam9x75-xlcdc",
> +		.data = &atmel_xlcdc_dc_sam9x75,

Will SAM9X75 XLCDC work only with this patch and the previous one? If not
then, organize the patches such that the SAM9X75 will work when introduced.

> +	},
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);

