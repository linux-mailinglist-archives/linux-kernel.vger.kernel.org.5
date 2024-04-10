Return-Path: <linux-kernel+bounces-138714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7489F973
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A4228CD45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4117965E;
	Wed, 10 Apr 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bxm8SVkL"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EF179206
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757740; cv=none; b=OMII60e5wQ9ahGGhEZrpZm1cXf02cpKiZHWIrxpkxpcUplAHUvqLknT191TdmJWLzoYyjlVNwwqKEP/JtoiK30ULTsHq0QO4DzjDhGKwgiXMtl09RrGKICjUaEVu/qkOSkERF0AmjTrT9Ca80uL92aDvyj2i6agOIw2faMUVdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757740; c=relaxed/simple;
	bh=rJB6/4cV26EW5syN+P1RUCaw8vdLd265D4NK23+6Ks8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf8dyeQS4f/IU4GdkzE9LYrhfZNUXZjrrqTEOtHaeh/VPpcOtYeZXQSdCqDJUdNk6oWy0PG2BiXv2U9jOMq2vfxsQ/H/IU0q5pmYBcOlagL7pJHLzU4ArCOT9AiRbCGE/tq1ikRTehRdy8tnRHK7w6SRSi18Flb5pnaIXRSEoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bxm8SVkL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-416c4767ae6so5342175e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712757737; x=1713362537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMjbesMdn+qtLdaftXdet62uuV9p5A/VNrKt/cHgu0g=;
        b=Bxm8SVkLt8V36Vy+qPdCoVsGbq9onluD++i9UlC0k2P8w4r/FFGDMPR+ClIR0LkDDl
         15G4ToDULozD/4YGdYw63Q+nTRwlKR0/n/1rDVP4qphIPOhNbT+zdVOAgL8Of7Y3X5VJ
         ggE4Kd3s9sTtOs91uYPdcBNi1yWqQF+DEgTXvmUZjbBXC30PF3UvvfcAQdFF7eMtgGGV
         mbDgI27FZuFdV4w3IOY/brgHrlDYqzE5AmuYcXxnDpNFjGzfmx79Yl2P6gNVXd5W9VQ1
         xXGURW257FRpiY8gmwgBC79tXJMlFYDzamYePmwxa1IU9Id3GnhHX85b2eggQAukIKMJ
         c/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757737; x=1713362537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMjbesMdn+qtLdaftXdet62uuV9p5A/VNrKt/cHgu0g=;
        b=sgPexaD5ZUGEWDmcV04J0r3Af+sdT4FGfoN2sydKjzDKAJTV1T5JjUePB4KrV3NcTx
         95gHPBhCVlClmxFL0he0mGnXuymnQYvqAiIVcsiY9rV85EkN5uWadYOk1WpE4nGidRtF
         KFOaFhiW3JhY8X9Kg3JjIOFmNA4x/QPuQiQuIX0JcPYYL1avoSnxsTJcPrE6BLEf1AfZ
         9qXYr4s+3yvtwvCW0WBk6WQvsorBKLB+FeQxvep7dXZI9REf/zo+pNfj8lq1/1JObblX
         wQ4H/COJb1+7w022HEefqECiStp7IFl/4/3z2d93DXIPeJOYrX+9y27sYOPE7Z8yi0rA
         Ztgg==
X-Forwarded-Encrypted: i=1; AJvYcCXOHoVCNU0fKYy4U/mT1rQdquU5tc3Q0pk3obtMrGuHt0vRpDyRs/xwOV3qjkeRY3+5uRH0/V4pVk9beorLf2c2QoCtmYQX42DJUgp9
X-Gm-Message-State: AOJu0Yyyqry0vdOInd0lL5R2EeI3wZ3ghy3Xk4VCMABrxr9lo5wy1xY8
	5mZw6euRkpDQkRSjhjDB2gp6oKKu8+9SnnRzDrgblCS3alECMPu8169ycEQ4MMc=
X-Google-Smtp-Source: AGHT+IHDRsDMr0SXIA1BZFJa3MxdxnnQmiYZftYqYOsfFpe40vWDa1uC6IrsGh3VJIa1HBNRB3jl0Q==
X-Received: by 2002:a5d:628d:0:b0:343:bccb:dbbb with SMTP id k13-20020a5d628d000000b00343bccbdbbbmr1888712wru.12.1712757736649;
        Wed, 10 Apr 2024 07:02:16 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b003439d2a5f99sm13761613wrv.55.2024.04.10.07.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:02:16 -0700 (PDT)
Message-ID: <50bf4fb6-7ad8-40b7-ad95-c1fc5e292149@baylibre.com>
Date: Wed, 10 Apr 2024 16:02:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/18] ASoC: mediatek: mt8186: Migrate to
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
 <20240409113310.303261-7-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
> Add mtk_soundcard_pdata platform data for the MediaTek common sound card
> probe mechanism, including a driver/soc-specific probe extension (used
> for bits that cannot be commonized  hence specific to this driver), and
> change the probe function to mtk_soundcard_common_probe.
> 
> This is also adding the possibility of specifying the links and routing
> with the audio-routing property and (x)-dai-link nodes in device trees
> to stop hardcoding machine specific links in the card driver assupported
> by the common probe function, but support for legacy device trees is
> retained with a legacy_probe function, which is used only in case the
> new properties are not found.

-- 
Regards,
Alexandre

