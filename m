Return-Path: <linux-kernel+bounces-55138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A065E84B849
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ED11F252A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905913328C;
	Tue,  6 Feb 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ug2QfmNg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB5132C35
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230844; cv=none; b=KDnOY/ChDqk+N6Kx7pbpBhFp5Bg9RkBlYGfdWpbDssoaC2ZXLClfBvAOH1KC1TzgkPld/3mlm37DRHgp5oHoWQ8hPjHk5wk80I7zLGEOgoAFp3EJCPgeMw8RHEYPA9U/jB7/n6VOCf0yEMJXxYYxbHazBpsapwJdFdjhuNKPQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230844; c=relaxed/simple;
	bh=83RjN6vQgURuaQvhOFAWdZAe1qAxq3kAxl4+Qgu/uYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIQR5yg9UabfoOGWIz6ja4z9KwOzjjjeQUPE8gBi5f1ek89sPpVleRH6Gvfye45Of8UHNA2vqpul6iDQo8Kr4XqSFzjtqMOZxgiRFMJR/EjmSSL+7YD4Ub2R7732U4Y0JrWtG96843MMkexOG6dRp0Mv3p+mfIXe5u80xDz4cFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ug2QfmNg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eac018059so7074946e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707230840; x=1707835640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZR/yId0zMdb1VoBg8Axbya9oTLCK591PyMAG4SS2OxY=;
        b=Ug2QfmNgsnWXVMUZM97h7fo3qKiOYPlrU9WBAIQHV2aALt+vdmAKGVrNf74G0qKKE2
         JP2NBheiEn4iQ8nXpHZoWiqvZNh7syKkx9lO6wOuV65QKn5fazBrAS3tDlY18chJprcM
         BCz2InHtov88hH5aP/dakOzcfeN2Tbu9l1YP/Egu82hWg+gWdfxPrzkUVAzpd4AfWabp
         /g0lXEegK1uSHfSn1zWBDgCCB4K9OWuaoX30geHbCJ+/DhzYAI/p1D8wufMwGN7yTXQB
         kHAfTXdtIe0wFO+Q09DoFfjel2iEA3WiP9SdUV2C2DAZTOme5tM/qiNCLlidA9pBUvu4
         8LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230840; x=1707835640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR/yId0zMdb1VoBg8Axbya9oTLCK591PyMAG4SS2OxY=;
        b=tBQLlMfwibf3AlMMpN8FUsvqZIm7/0rt/r04s6HLEi75EpSVhFQy3IQiGkAvPcZRms
         FyZ4UsIAfS0YbCzvqfbb9HG2PyFFQYoSonxjnt05inQcmhrC8JVnBkwaLc4RVFyfZbJo
         FI04mw6OzcTJlZDK6sa992/cjiyPn2fZtzSbqWPn8vJr4FqhNJcUdPS2DtMenMR0XF2k
         Nba7NdnHbs04AWNg0o1sM+hsFfiU7mo6q7g+RZw2Xd71Qso4Kau/JdR2t12KByNKWckk
         4JEwZGXd0N58tnoEOCqn5aBYDs/fpHOECx2daNxiYOhN8ExeJ608sok5KIeZDWVniSm1
         NVTQ==
X-Gm-Message-State: AOJu0YxeOWrONelAvYe9NGFvUU31fevAhhwPNJ0MgqqAhrQJ4GNieFEg
	nCMDEbSZ1SSVizLGs4JUh/TVyx0czJiwZOSXJu52orn0/AsiWDVALeYezsQUxrw=
X-Google-Smtp-Source: AGHT+IEuhUD5eEWwYbifjJ3zWOk3sSzNHHGTGTW2BHb978uMI+o0AKo+LWqCNLoEZRgptvn09UAaog==
X-Received: by 2002:ac2:48a8:0:b0:511:52b7:43a6 with SMTP id u8-20020ac248a8000000b0051152b743a6mr2076508lfg.38.1707230840037;
        Tue, 06 Feb 2024 06:47:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6O0p8yRFvWA2LcJJ0ltpkPfQ6vI5AikUNA/cAWawwZbgnjphw4M/VshE8gahHAIgGIZF7Gmld/JviR0PfLBno5DT+YgCwcNnuN7vQaRicDacIJWmeRvUbJ1sCX4QWKdBM4n9nUGwV1qEMw9d9+cAvxvrNnAI5xtGAVYSBLVu8+q45icoQe6aCIh4XOniP3CD6AskEtnKkHpJZgLF/DbiIrw+pHt0XHYGHknPi0wvZ4u5FHUi3696dcPv/g7lBtAxJrNBCXE5Dxn/b+Kst7uQVcsUqYgSBCAheYws7ANgNgjFdh+fS3HZL/AUL5RVKJUD2kck/AhPd1dHj3q3Zr07tE0qbl4W4UiN0XBJRU3ECzwAVdklLD+aezRUXcYqgh5aY+T3C1Szf48N/dN7+Ix4loSxCY98GZHzbKw==
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c5-20020ac25305000000b005112ae5fd93sm255854lfh.244.2024.02.06.06.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:47:19 -0800 (PST)
Message-ID: <f91db779-ad94-4c18-9a06-1029da4edaab@baylibre.com>
Date: Tue, 6 Feb 2024 15:47:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] drm/mediatek: dsi: Use GENMASK() for register mask
 definitions
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240206120748.136610-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
> Change magic numerical masks with usage of the GENMASK() macro
> to improve readability.
> 
> While at it, also fix the DSI_PS_SEL mask to include all bits instead
> of just a subset of them.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dsi.c | 45 +++++++++++++++---------------
>   1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index a2fdfc8ddb15..3b7392c03b4d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -58,18 +58,18 @@
>   

..snip...

>   #define DSI_PSCTRL		0x1c
> -#define DSI_PS_WC			0x3fff
> -#define DSI_PS_SEL			(3 << 16)
> +#define DSI_PS_WC			GENMASK(14, 0)
> +#define DSI_PS_SEL			GENMASK(19, 16)

0011 0000 0000 0000 0000 => GENMASK(17, 16)

>   #define PACKED_PS_16BIT_RGB565		(0 << 16)
>   #define LOOSELY_PS_18BIT_RGB666		(1 << 16)
>   #define PACKED_PS_18BIT_RGB666		(2 << 16)
> @@ -109,26 +109,26 @@
>   #define LD0_WAKEUP_EN			BIT(2)

-- 
Regards,
Alexandre

