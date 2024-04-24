Return-Path: <linux-kernel+bounces-157537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC98B128A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F7F1F2147D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2F18029;
	Wed, 24 Apr 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV8qAqYK"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B41798F;
	Wed, 24 Apr 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984155; cv=none; b=iHfh2VxZVJdasBy+mUPP2bn8IVfjSxP4Ez/l+ZRsuVk6Qxgf7jOLnFqgiTCKIi+3Tf51kVTJjM2XkbT2fPe31LLO2ImCljFC7JN46S9tiy7XeSIRGZOhjhZ5EcfmTyMKB1DMmxHAUnjrQ9gBPU0Xu+sVW5koxKE7J9bAI9nJbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984155; c=relaxed/simple;
	bh=Itcg+Jd23ZQ0QilHdje/jSd9t3UqWVBHp9CbQrEwRDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC0C54yC8Hu0x5615zofFcvyM7Nc3r5nqH6KhVziqZhAXVoym/FjUgjRbRmcFdWK8wUBZyrfth6FTq4kY4D2wC0b8NzlKpkFevuEk84AkPtiPzP4ZkqfGuQDIGpro3YuS6YeA2JLBis1+Cy4PllmLqd9kZYy2MKxyNoDSav7cRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV8qAqYK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so144735a12.1;
        Wed, 24 Apr 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984151; x=1714588951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol9krzBmTOyIuy1ft27l71rabBxmYrw1+e+89jby570=;
        b=OV8qAqYKs6FYeM1aPS082RnpZOD6LRwZtnA9qVkBlThnXU4fEMJo9Zf2yis0sCWjlr
         j+6/k2gdcIE6rNFmjx0Igv2Kt6Uxz11G0kt8al1YkSAPQtdUHbPii79Oco0dtOByUKzu
         anJ4mKPOQH1/0zRiFapouef7wVddUiRLv3umrYZGVThK+hywrEC/zBzBRfdICbES8TlP
         I0tDpWcaXO73m4PCHhcswjL3+QA0XDAX9oP/1zHEAtQL9HJmllPHr9ICRQz8XnAC2/cb
         Ir13LLPltbIrO7NiorjZwHOUMOMWCZ0/6Ddfrcqb1NlAlwluMo+dj7zHTP+o9Nspi/jN
         vumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984151; x=1714588951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol9krzBmTOyIuy1ft27l71rabBxmYrw1+e+89jby570=;
        b=w1JOrdF+/3Z4oKN8GjmSQEgRhURZK9HothW/dB4F2sjjMFxzuJdS5gKg/qPwaydUTN
         5O+Q8JhCNnoyWJO0qkNRqeGl3bNxTBlcm9XMdQrwGf2gLV2jmvkQnHRoyVkVHfRdHXB9
         CoPyj/04v/0OOcu5Y9B4VfV1aZXh+QoFrYc0mjFhH8SSt42TKhcOf3xvEWDfrRL0VzaD
         GeLT0uC4WZPEjs2AmUYGD0GuaScwxLSKk9zg+eil4VLsprc+qJBI7mA4p/HUZywlebpl
         bIdNEhidlxpIVLawPu3NRVHQTh942F1q1UjxnpvRRetJADWTtEmjBu031Lp1UMu/aMJS
         7rwg==
X-Forwarded-Encrypted: i=1; AJvYcCUiSrFsgVZ1pjtgQx4tOIFdc/QJI/UaX4F4LAPN4T7jY/+BP7e7OrG12Pm0Leko1ruMF09a9pOIEQO6603+pxqcuyWBsvJVj+zXNm8tYvyaRltmyCb7NVv10aZ7iYrkpqz4nA3X9AGWwZ0=
X-Gm-Message-State: AOJu0YxlR5IZTdyaJzkN0HqZ0Z3av128uv88Y2bd6GZkYlLoK5dwrP/b
	pnmLCrM36n1P41/juAC8UZ+xyeaewWuQ/CgYaCXuTU1wpbNMdngd
X-Google-Smtp-Source: AGHT+IFJqfBO5mQOjDTG16NEhTc1tvbEXpcR5UL3y/xbDmPZLBWl1fVr9z9AG8k1xyje5QaUGr0gWw==
X-Received: by 2002:a50:9e64:0:b0:566:2f24:b063 with SMTP id z91-20020a509e64000000b005662f24b063mr2220945ede.23.1713984150928;
        Wed, 24 Apr 2024 11:42:30 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7de82000000b005720e083878sm3644714edv.49.2024.04.24.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:42:30 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Ban Tao <fengzheng923@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Joao Schim <joao@schimsalabim.eu>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] ASoC: sunxi: DMIC: Add controls for adjusting the mic gains
Date: Wed, 24 Apr 2024 20:42:29 +0200
Message-ID: <5772237.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20240422150213.4040734-1-joao@schimsalabim.eu>
References: <20240422150213.4040734-1-joao@schimsalabim.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Joao,

Dne ponedeljek, 22. april 2024 ob 17:02:13 GMT +2 je Joao Schim napisal(a):
> The AllWinner H6 and later SoCs that sport a DMIC block contain a set of registers to control
> the gain (left + right) of each of the four supported channels.
> 
> Add ASoC controls for changing each of the stereo channel gains using alsamixer and alike

Add SoB tag.

> ---
>  sound/soc/sunxi/sun50i-dmic.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
> index c76628bc86c6..f8613d8c3462 100644
> --- a/sound/soc/sunxi/sun50i-dmic.c
> +++ b/sound/soc/sunxi/sun50i-dmic.c
> @@ -14,6 +14,7 @@
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> +#include <sound/tlv.h>
>  
>  #define SUN50I_DMIC_EN_CTL			(0x00)
>  	#define SUN50I_DMIC_EN_CTL_GLOBE			BIT(8)
> @@ -43,6 +44,17 @@
>  	#define SUN50I_DMIC_CH_NUM_N_MASK			GENMASK(2, 0)
>  #define SUN50I_DMIC_CNT				(0x2c)
>  	#define SUN50I_DMIC_CNT_N				(1 << 0)
> +#define SUN50I_DMIC_D0D1_VOL_CTR		(0x30)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0R			(0)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_0L			(8)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1R			(16)
> +	#define SUN50I_DMIC_D0D1_VOL_CTR_1L			(24)
> +#define SUN50I_DMIC_D2D3_VOL_CTR                (0x34)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2R                     (0)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_2L                     (8)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3R                     (16)
> +        #define SUN50I_DMIC_D2D3_VOL_CTR_3L                     (24)
> +
>  #define SUN50I_DMIC_HPF_CTRL			(0x38)
>  #define SUN50I_DMIC_VERSION			(0x50)
>  
> @@ -273,8 +285,30 @@ static const struct of_device_id sun50i_dmic_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
>  
> +static const DECLARE_TLV_DB_SCALE(sun50i_dmic_vol_scale, -12000, 75, 1);

DECLARE_TLV_DB_SCALE is old name, SNDRV_CTL_TLVD_DECLARE_DB_SCALE should be
used instead.

Other than that, it looks fine.

Best regards,
Jernej

> +
> +static const struct snd_kcontrol_new sun50i_dmic_controls[] = {
> +
> +        SOC_DOUBLE_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
> +                       SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_VOL_CTR_0R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +        SOC_DOUBLE_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
> +                       SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_VOL_CTR_1R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +        SOC_DOUBLE_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
> +                       SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_VOL_CTR_2R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +        SOC_DOUBLE_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
> +                       SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_VOL_CTR_3R,
> +                       0xFF, 0, sun50i_dmic_vol_scale),
> +
> +
> +};
> +
>  static const struct snd_soc_component_driver sun50i_dmic_component = {
>  	.name           = "sun50i-dmic",
> +	.controls	= sun50i_dmic_controls,
> +	.num_controls	= ARRAY_SIZE(sun50i_dmic_controls),
>  };
>  
>  static int sun50i_dmic_runtime_suspend(struct device *dev)
> 





