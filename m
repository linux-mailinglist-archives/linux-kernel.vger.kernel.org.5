Return-Path: <linux-kernel+bounces-138672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E089F97D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7F6B2F45C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915D179647;
	Wed, 10 Apr 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kosRFtIz"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7917920E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756778; cv=none; b=P8/cqM45Qg6kqv6eU19HEOXulrNg+oJ5j4Ew4hMKDE7hFbvOewjftNpQ0AATQu+0DnNvpePF/G2OZVy8vo3EFU/yiEBBkQw84WeYpFndLnRFjNEx9w48UFs2GNHR7Wc2OSH9Pn4oQ17Qi5OI9rWBJdy6N/OmflxEvXfG3hBHY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756778; c=relaxed/simple;
	bh=QvOn6cvji9QTSJm7bpuEUbJNN7acKTTuonvs3yRgL0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJaYGiDJU6WazOjL7txh4OR36PM5z+G3Up0UvwqNM+Vm+sYBwYWWpSmEBjaGW5R6iJLG7j4NAs4HvU7Rs1isl7tc3IBqTbieKvrXRKytBWTOop9vHIgyUNSJGsn/tNmwG3N0WrFhPKh0839XRxlhgNWU5RofeTCRu5nBD8fUIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kosRFtIz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416a208d496so13798185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712756774; x=1713361574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNwy39mEHd5CSC3eirYZIbXLLfL+/dRw/DVFAe0gv+k=;
        b=kosRFtIzXWMOjy6UyvSE09lRqzPywlytuBuK9KZsw+HUecFw3ulP8T4Hj1atCemzXp
         fMELPqqsbOi1Oi4qEJUBGAIP/gpLrRL8oEOFfk6m3ep4wFj8laHEFqkAUQdXRNgRUhXP
         P9Kt1satLlxq1NcEE3KUZX8sQvijWC4GZ+RaoqZy+oQCJNhaYx4ARlTEc2fWy8JEBWPw
         60cTE9y2b7Ufmy06uXwZdOlv0g/J+V+f8RcHNmXnNYSNXPKLQ2QZtWjPfkwEv8++n0wd
         Ku7EhaErnD3W+KowFxvKYCdstb4uL8Arpvrd9uzVPqoxw8nhAmyITzYyDGQhin6J5akF
         vJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756774; x=1713361574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNwy39mEHd5CSC3eirYZIbXLLfL+/dRw/DVFAe0gv+k=;
        b=w51cx3+ebVmbYeyPFSd1fMVlc7C6tSkh/Xzl63ARr7Q4bMcnxRerM3fScSnx5Dek11
         igikali+Adej0qcD6kKiwtJ6cb7+rDVkqsKKFN77kTzUFoIvnKwSKDbd0DVroUeLdlbY
         5WX20bgTJgmUSefmwBx0gBL1oWdsnbxAuUcfrCCOUwLTpuuwpxHHmZOQOEwlY8XHqAnM
         SWWbfk0Hya760OkB/coxJ1L99CJa0pKmWdB/2IGoIcFvds4VyQHP3QEQpsMq/MYHOySv
         IqrlXRzek7FJBElJEmShaUqOTIBOzYUE1ZfetRXnIXMV+Pmy9jUnULHvLE8r8Sit4jso
         OxXg==
X-Forwarded-Encrypted: i=1; AJvYcCUYG2CXAmyrP10H36jShHCVDmKN0qCGe/OSYXlGVoV5Z8/HEeYFFIBu2AhVF8GITByzGcyS16DLxuAlsOgMKh+cVPaakV+W2FTsckt2
X-Gm-Message-State: AOJu0Yyu00RJtO2fS5jM7U/Ic4XjmnmApWQ9fbO5eMXGuhcf91H/7mcu
	JElBX1/tVJQn5ReXAeyvOayhNMXOmZ169PX8EhBDzxkOLTpytgdZTCfUM41WTlo=
X-Google-Smtp-Source: AGHT+IGxsQggXycRi+dm4Bw4Xi8pQLO4aefRSNITx/omDNTFi8n4uULRx1pb1qcEcpuljXdkWzOSMA==
X-Received: by 2002:a05:600c:4446:b0:416:c990:d668 with SMTP id v6-20020a05600c444600b00416c990d668mr1409845wmn.8.1712756774480;
        Wed, 10 Apr 2024 06:46:14 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b004170e0aff7asm1931574wmq.35.2024.04.10.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:46:14 -0700 (PDT)
Message-ID: <dba5a3d3-97ba-491a-9290-35ffd42c740b@baylibre.com>
Date: Wed, 10 Apr 2024 15:46:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] ASoC: mediatek: mt8195: Migrate to
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
 <20240409113310.303261-5-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
> @@ -29,6 +30,13 @@
>   #define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
>   #define MAX98390_SPEAKER_AMP_PRESENT		BIT(2)
>   
> +#define DUMB_CODEC_INIT				BIT(0)
> +#define MT6359_CODEC_INIT			BIT(1)
> +#define RT1011_CODEC_INIT			BIT(2)
> +#define RT1019_CODEC_INIT			BIT(3)
> +#define MAX98390_CODEC_INIT			BIT(4)
> +#define RT5682_CODEC_INIT			BIT(5)
> +

Why are you using defines+single variable to track inited parts in the 
probe function but do it in the different way for legacy_probe using 
bool: is5682s, init6359 ? AFAII, both can use the same method with the 
defines above.

>   #define RT1011_CODEC_DAI	"rt1011-aif"
>   #define RT1011_DEV0_NAME	"rt1011.2-0038"
>   #define RT1011_DEV1_NAME	"rt1011.2-0039"

-- 
Regards,
Alexandre

