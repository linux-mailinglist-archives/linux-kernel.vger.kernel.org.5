Return-Path: <linux-kernel+bounces-138817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8C89FAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A201F311DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349416F0C1;
	Wed, 10 Apr 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FW+n/r2V"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C025215B0EE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760853; cv=none; b=uwIvFCumInRXdOg63Qn1r0OJdzOLQ1A2KsIE7mzqI0v8Q74GAsYkie1avV0I4ZwqO/In4bbkqyek7/uNYGz4GLmwF9RI0xLsrqXrJR9vYy8pmgiIxGI57mk8OjVSHZgnKmGom7B7gd3xR9yft0CXifgRFzFLx/1EJbzGpTIxKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760853; c=relaxed/simple;
	bh=lb+10Z0IsQP6fdKaH27sy53CFmYG4HdNoIjZt107yr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMUwOfmCzS4TKzO7LkL8twjVs9v7mYiTFXLptg5MT6Xkya03ZWK5YfRSDHNRPoVayZrq/4cGWOUtfDY2ZobdJraibiKwQzU22KuYjQh1GB5OOYiUMj/Qx/uoT4eik3Gjr9MZtQBlMluLKUrRGolXrbKm4g8vCb67eeC8KZOx/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FW+n/r2V; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4173f9e5df7so3782625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712760849; x=1713365649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UE+4Y18rqT6MP9pTdsa016UUd/maawQyVReuqUWJA2U=;
        b=FW+n/r2VNGwSr8jy6K8k0RsiZW+t6puuD93D+Rfe6YX8yRF/g3JeluzOfCDtNuznN9
         P/Mk/7kvItEmuoO4iXnubNtw9BbK87delR4UaKhXxG4qX3at5Df6CPXbT4QQrVsNylm6
         19A7n0KSEEGRXAJB4lVwjdOJWNUFchPXn1X+B+mZquecUBg6zP05e/K1Ph++QjcBbpxl
         P7F2J55ulTTXC5YpEm8HO/W/b8Ejev7JAFJmdoSMeArhS9xivH7CkzGJiTVeMAtAqq6b
         hA08HXE5Vk4NddNG32PAOiyfM3hO63t8jUse8R+36y0zimDBRFdZEHENfZOgditSLENC
         qayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760849; x=1713365649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UE+4Y18rqT6MP9pTdsa016UUd/maawQyVReuqUWJA2U=;
        b=R3D19THWWxF7KMfemTLKl3p501dmJI3uKOeoeJANR1l0scI9OaVfWtUfFYNNg7bbgf
         CPxwGMAS5myyGGi5Cg1vAz6shh+sjF2JJCplAMqE5ECIk7STHOCMTcCEJchvlh9gaZPB
         YgtO6Yf2CRRUD7uH8cm+4T5QDNo+Ux9i4+w34JkDIOfpMipSwC4ef8L9vlLwD69RnCjm
         L1pn2Jeem/xFRZp5JEA//j/NKMLoYIqLZ23iRak4S99BUg1tn8BnSR8n5YjtDa1FgxGM
         rmWucBbMpaU3NH6lliSkxPB98uU6DPUknGVOUXB9p2jLbXc9M3pnbAEqtyUJCchnDdw3
         Z7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCU5NZ4PcICfZijgSkXc545roOSEoPmqWuXn00ApmmbWoRCAwEkI4YUbqsgdQlJuz1SzuSzAIe6RtAhTzEFyY1CQtP0Rx1gji3ECoHp6
X-Gm-Message-State: AOJu0YxbIMvyeE/NmhdEu3ZcrVibCrHY6GFYeVEkw22frCaPfS2hPjsU
	1fA9iYvT7kmtQnHoaazpjUI1KQJHKI5OdsJqlqKJuOJ21tr9+NIRFsbcEdBLZPA=
X-Google-Smtp-Source: AGHT+IHCUNg5SsYHXd3cnIQYa7aR4oDCUcNCW6UqXLuavJoCReIkeODB8539jlTtqakTtMbi5H4ORw==
X-Received: by 2002:a05:600c:4f44:b0:416:6abe:2975 with SMTP id m4-20020a05600c4f4400b004166abe2975mr2002047wmq.15.1712760848874;
        Wed, 10 Apr 2024 07:54:08 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm2526850wmb.46.2024.04.10.07.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:54:08 -0700 (PDT)
Message-ID: <6506db51-121b-4579-bf14-0ab6e33fb048@baylibre.com>
Date: Wed, 10 Apr 2024 16:54:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/18] ASoC: mediatek: mt8195: Migrate to the common
 mtk_soundcard_startup
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
 <20240409113310.303261-9-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Way better with common stuff ! :p

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:33, AngeloGioacchino Del Regno wrote:
> Add a const mtk_pcm_constraints_data struct array with all of the
> (again, constant) constraints for all of the supported usecases,
> remove the duplicated functions and call mtk_soundcard_startup()
> instead in all of the .startup() callbacks.

-- 
Regards,
Alexandre

