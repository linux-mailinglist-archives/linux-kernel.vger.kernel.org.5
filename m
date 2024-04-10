Return-Path: <linux-kernel+bounces-138859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1B89FB49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C2A1C224C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49F16F0CE;
	Wed, 10 Apr 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cMKkbVm/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD515B137
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762035; cv=none; b=TR9drFJaM7Phd7myUTajjSUDm/fHOmTkfmS1moa7FzQvbShTMKBr65+0Pln77EfOUfPjrq/g52jEyOa28BqC+ioiKCUWh2iizY/n0Sg5q/zMnCuJcZGtd29CSqEA5TuM7XrbbPWq+0nV0S16SSivlQpMlEkjlNqOOyLUQGoK5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762035; c=relaxed/simple;
	bh=n4JrkSorhynZmSYFDegpGZt7tneK34MYTFY2bPGDfD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntB7u/K+yL8Gxum4zvTOC9fNohAGHGN6gf/H3OVG5afbMyozg/FREqY/cY7iWZx3p7sQO23NCAxQ1Ohji5J4vooO4FxennK61KaGnu/UO49BU6hHzwslIERpCrpSJgwnxr/VGlWG2B5i7yFAWoo62G06M/ForEf8cjwxGYRTd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cMKkbVm/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3462178fbf9so899864f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712762030; x=1713366830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xb0tDuasjSNlJsy4sDFiJMtEhz1/MxQR3B46cvvCuH4=;
        b=cMKkbVm/23Ha/TQXmdyWLBng44TIPvbuAYM8asMLC5kscwXiUZh+8oEK2bWXWCL7Gd
         KOUKBc9/qyafWryXHGLLCOwpKHz+rk2uOeoSb1hEtPnC7R50GuZ+EKulDWK8tFsrvVp0
         RA2vpBKK8kd3qNcNFoszqtIzsg64ITx+nZDwLMRETIXW89df6GprhAXeaQUFQcTon2Fp
         OfZ5EkVpRY36NYtoDQlWlJ0iVmFQwhxxqzAEXclL6S5ZcS12+aqgb3n04c2F6iom4KWV
         F1nWjE9b0d5bNc84DF+R5+GocGLNwesbNZSiwGfOWZg0QORiN3v/FoRhEiY7ign0J5P3
         icbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762030; x=1713366830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb0tDuasjSNlJsy4sDFiJMtEhz1/MxQR3B46cvvCuH4=;
        b=pE25L3QpqMLRoXkgtDiwuUq30gY3S0Mhx55qlDki9mANyXdQbq+02Tb08UW1cszHA+
         E0NOfsQz1QHYWYQ9/M/+uwUux+31j5gSfR196GrqtzS7/bxft0IFQYu/D6AM4bXJ8Kqk
         Bly1Q4BTup4IY8sIUAUtDNnQeC6RFV1quRL/aKlmvpkcEZCIHzjQClheTJD+a+n5kdVV
         uxfFWUNuPobfEx07708y8Np6cFG99gEqQPwroHsa5FWBmR8uyAzGBQkYwKbj53dNdWaP
         Abt4eust0Rv7oQyJkPt5+SRlMSx9Sst7TPAh/mthpx9bLtQOpMhaEt/qm7e4RAw0uMFp
         +9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTZxwoQNufpfD9KfxHm5gY34J/O0eN3kYrr/v3yRyijOvmL79IghejmXGRSIz7N7I9r0BJiY3I6Tq5rEbc7Dw0oEocRoi4pcRKIwTU
X-Gm-Message-State: AOJu0YxNci2/OOqinWqzrDC88OnqeUrdv/Eqq2OD1SRtfOrQkPNtNzqM
	+gjYfvDLAaKxvyw20SVAGJY1v/1koet/tkY/Nv4gh6vcu50QAeWapaYGLMa51z4=
X-Google-Smtp-Source: AGHT+IGoier3Sm8gMlqmjZALBvxdoG/1vWwzVX851wh99fQXUyteeMA3kD8B7Fgl7bkM9Q+1QuTWTQ==
X-Received: by 2002:a05:6000:186b:b0:343:6b76:251f with SMTP id d11-20020a056000186b00b003436b76251fmr3201804wri.42.1712762030404;
        Wed, 10 Apr 2024 08:13:50 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm1118117wmr.25.2024.04.10.08.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:13:50 -0700 (PDT)
Message-ID: <fd7cc1d7-f293-47f9-9ff6-98b78150d61e@baylibre.com>
Date: Wed, 10 Apr 2024 17:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/18] ASoC: mediatek: Add common
 mtk_afe_component_probe callback
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
 <20240409113310.303261-12-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:33, AngeloGioacchino Del Regno wrote:
> Multiple MediaTek AFE PCM component drivers are using their own .probe()
> callback, but most of those are simply duplicated functions as they are
> doing exactly the same thing over and over.
> 
> Add a common probe callback for this component to reduce duplication.

-- 
Regards,
Alexandre

