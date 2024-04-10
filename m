Return-Path: <linux-kernel+bounces-138709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3689F940
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BEF282ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D3177989;
	Wed, 10 Apr 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DPm3wpYw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F11917555F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757602; cv=none; b=P/o/AeYUFBnZ0QHbhgVn5TDjjoBvKJjel94caLhr+VA76wjSiLqE91c2EYskzwLyC4MMx1bg6i6cs6R1V7GSGjwArDH0RYyLBa1qTMd7V1awyHAlHgMmwdJj2DAlFXf0Xx1R4SOsryZiG/x8ey/1dRwiOpv2JG3DDy+W7uWd4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757602; c=relaxed/simple;
	bh=9VfcLjEoMTpi7xm+VUn6B0UvA2/X0m8cCVXK0p51Jw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmtmZsi5LYVnM0Tni5sAiAiRb/YW8hv1GYRvUMgxF1jiWOHs7rvFrxJoyDHq0trHHo6xnaiv0Hj9L9QyuQCW4kt6yrmXwfLSlm8Ni5I+qJta1JCzDcrcKculzH2heFzGbV6JmBmRQHx1a8/v1igWTg2V9U1YLTNL7QxRMyIwTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DPm3wpYw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-345600106d3so2840237f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712757597; x=1713362397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g67OSHlwNTDKaFrM3/uwoPsdE8uUwCxkLF5hYguHcs4=;
        b=DPm3wpYwzLFBH4up7aj4PkCtaEjUUp4IPlYcSQMWgeQO+1WBJHx1tiBaFCgfFS1pSe
         hkC5zZT/FI0S791G9HsFd1tq1oh6SRmJQgkluP0grplmHp8wjiB4kpkD+ZbkHjCQ7fX+
         C9cvPD1UCdn3g8XGN7kjTnZ3O3QQ3PlZw2I8qaO0eB1uobmTTtW+JfqC8dAYWd1HR/f2
         ZGd2YPOzvQLsl+2JOLrKv34lwB+dXuTc63Kvabjr9a3zeHu0YS8dcuaU/9I5LQZTm6QL
         xh6f87WG4v4guGr/2AgmIt5ZuNv2bEfgDkFMneXdLfaT5JVnS4wigDcvCzZ43tMpQyEg
         Z7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757597; x=1713362397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g67OSHlwNTDKaFrM3/uwoPsdE8uUwCxkLF5hYguHcs4=;
        b=gGUHfs+3ZRvJ9PARMaeF0/KMwLVIhh2lfkKaVVuYf2LzQefO8ka+Xpjln3C/jsyfni
         fv3ammXJhZFO88p1fjIfGuB9CmOp/Mw/2yJPB1lhrMLdXu5jWJ6GL9pAyv/E/mIAvUf8
         BpvJo7+xxaveCcSo6m3s636xlL/duqMwM7XBv9H4gwM/APKWsPJdEWDTH+asvFm6wMN0
         d4dAeDl3bviqfbS+aHdS6dOiSG/Fcb9JT/LX+Ayj6BQJK9Hc1gBWJwtXzto6NyjzjlpO
         mDdhSO0bV4Z1FSstytCuGByiEUleJY3ED2ZWkKUSyTFcZp51Rni+1YI6rLNJgvbBY8pG
         MOKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/WHFKGAvE2x+b2lZwlcq7IemDDViqwLEb65PQ3EOgDh8NLs06PeV0cGKFaoCestVVXer32ASNfqxWxpkAZI45Tm6QEdaFLYJkz8yE
X-Gm-Message-State: AOJu0YxUS6iNRQIyNOkOIoUjGC5VodXp5N3PpsCCOJsafAoYusmzhWIo
	cBwsOWaiACL9zpXD4qNiWVKP/wKkwEQJ2SV/4NVitSw1tCoZdJSsv1KvvqNSYLk=
X-Google-Smtp-Source: AGHT+IGRtn6DL2DEemnsBxsmvHHTd4nWEQsASvLDi6kfhHaIx+DPnIFaevFeAdtATqfu2OGeHdeMQw==
X-Received: by 2002:a5d:620c:0:b0:343:98ee:524 with SMTP id y12-20020a5d620c000000b0034398ee0524mr1624742wru.36.1712757597439;
        Wed, 10 Apr 2024 06:59:57 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b00343e825d679sm13385379wra.87.2024.04.10.06.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:59:56 -0700 (PDT)
Message-ID: <cf0184c4-2b3e-4074-9e30-bf65ec7f0aaa@baylibre.com>
Date: Wed, 10 Apr 2024 15:59:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/18] ASoC: mediatek: mt8192: Migrate to
 mtk_soundcard_common_probe
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 broonie@kernel.org
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com,
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com,
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com,
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
 <20240409113310.303261-6-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
> @@ -1211,52 +1196,85 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
>   		if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
>   		    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
>   			dai_link->ops = &mt8192_rt1015_i2s_ops;
> -
> -		if (!dai_link->platforms->name)
> -			dai_link->platforms->of_node = platform_node;
> -	}
> -
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		ret = -ENOMEM;
> -		goto err_probe;
> -	}
> -	snd_soc_card_set_drvdata(card, priv);
> -
> -	ret = mt8192_afe_gpio_init(&pdev->dev);
> -	if (ret) {
> -		dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);

I don't think __func__ is necessary.

> -		goto err_probe;
>   	}
>   
> -	ret = devm_snd_soc_register_card(&pdev->dev, card);
> -	if (ret)
> -		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);

I don't think __func__ is necessary.

> -
> -err_probe:
>   	of_node_put(headset_codec);
>   err_headset_codec:
>   	of_node_put(speaker_codec);
>   err_speaker_codec:
> -	of_node_put(platform_node);
> -err_platform_node:
> -	of_node_put(hdmi_codec);
> +	if (hdmi_codec)
> +		of_node_put(hdmi_codec);
> +
>   	return ret;
>   }
>   
> +static int mt8192_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data, bool legacy)
> +{
> +	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
> +	struct snd_soc_card *card = card_data->card;
> +	int ret;
> +
> +	if (legacy) {
> +		ret = mt8192_mt6359_legacy_probe(soc_card_data);
> +		if (ret)
> +			return ret;
> +	} else {
> +		struct snd_soc_dai_link *dai_link;
> +		int i;
> +
> +		for_each_card_prelinks(card, i, dai_link)
> +			if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
> +			    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
> +				dai_link->ops = &mt8192_rt1015_i2s_ops;
> +	}
> +
> +	ret = mt8192_afe_gpio_init(card->dev);
> +	if (ret)
> +		return dev_err_probe(card->dev, ret, "%s init gpio error\n", __func__);

I don't think __func__ is necessary.

> +
> +	return 0;
> +}

Beside that,
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

