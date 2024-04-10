Return-Path: <linux-kernel+bounces-138821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F82E89FAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50361F2819E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A9175546;
	Wed, 10 Apr 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1DX2RzVs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B43174EE4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760947; cv=none; b=Vn9LsBGWKQ23P2+ML+6x84bejSh86jWloexhoVbUn/UBArPaKeOo0ING7m0qxKxgdHD+ENbueiBnIA0vv9pzah+GO7IVNkXbOQdQyDNUdia826MtnyCVxXFhU++7JZV2yOWd7yUuljYkQjymL7CAtoq7Q1D/tN8LejKpr6WsPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760947; c=relaxed/simple;
	bh=UKOOA8/7HQj4e+/LtfW4BZ4tyj66iZmzmBjEbudutfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJNwHCorMs4XSj0g3H8ihPVZIGHsNXGrecOuI9SxWcI0q1HAeWHcS38nix3/LNYKShpSAB+419b4rZDMOsKMUkw7EFdJdUUtoci0lFqqS8i3surJz6SttMKDaASLkeCNafz4GrweVR5VEpZrQTZWcydmdm00VinZ0T7GA5buOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1DX2RzVs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41745acb8f4so4438815e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712760943; x=1713365743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkM79gW6w0NVDaaTQoSffcdoou57mwLCTgADK37diJ0=;
        b=1DX2RzVshblQ96T0M9228b6U7oj5m0wslbjMdhsS8VzclEzlK/XXI1LSvnFv5BjESF
         cB7CRok4aFWDyB23YFA61iZIzTx8lA2TecHfZzCIMpi+vvIy/FFW7AHXetURShSodPp6
         lVV6WoLof2QYVNFAU4VqjWRxXv0MdRfGrHlEEDUi1vFyLCsOVXNsxR6dx9xpWntz+dnv
         /tRhezyeFWQBmK3irrjPWxuM9o1TPQcN6vBK+K4StsfZPAiCWpHZ5173A5E9pKAift4S
         pOac36TY7FtrdBIpRVBfy7Rb344t5t4bHgNcW8lIUCZmjonesbQPOn8mPw+ZtoB8vr3J
         78Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712760943; x=1713365743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkM79gW6w0NVDaaTQoSffcdoou57mwLCTgADK37diJ0=;
        b=deu9iIJKFDQ2diSeO0xsHwc54NXPF1AZKhuyfPRng69PGyCNrnMPwRpNDgwXWo9x43
         1u5I9ijHUV+r7Whd+Hxi0gHYt1SU5+gjMzAn8LNs7Qr7nnYrIpRl8srszYL5Qs3xL0Wo
         3kfqL7Zrm/QcD2JqvDoxw/RDBGlTdFjtQPpR5nutsjKQqqqj+BKlQsBjxIDrcSCAJRJp
         LwaG9izv/vC/Uhn4lmksHKCe093p7ea7dm1LTP3N/zdD+EFkR7LbPxP/KwHOV1INpLG+
         0ePtOOT/D5V5ge0bY8WdswX0J6NV5A6gEZrONXuFe4w5586yKZpgSJCsTxe4YyLjK9tj
         xw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUufz+kq9YMmQLnIfJDxCW5OfgFXIcTNo0H3RKb6Pq9DU2/5F6GiEI2WUoQTRJHGMr26+3IRDOO2RlKrO9AjCp4DVP3/VBdPoOnjH76
X-Gm-Message-State: AOJu0YzgVPl4hKR2BgEJKIJXfU/pUPpiQS5udcRlY0vcBC7halbYymoy
	u0Eli5xEM5XGulAkRcS36V1mMmjIbqshQSRpjFTmT0i61ZMDqUF1uQM7u3RRIdk=
X-Google-Smtp-Source: AGHT+IGNeLxOaiscREzifrbAz46PPEQrwOJh5pOyr0RZ/5W5R5nlpeialGLWcsM4T9o9oxKaQqjncg==
X-Received: by 2002:a05:600c:4511:b0:415:8651:9b8e with SMTP id t17-20020a05600c451100b0041586519b8emr2356050wmo.39.1712760943089;
        Wed, 10 Apr 2024 07:55:43 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm2523860wmb.21.2024.04.10.07.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:55:42 -0700 (PDT)
Message-ID: <c86fb571-fc66-4549-9592-9ea984f3e49b@baylibre.com>
Date: Wed, 10 Apr 2024 16:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/18] ASoC: mediatek: mt8192: Migrate to the common
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
 <20240409113310.303261-10-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:33, AngeloGioacchino Del Regno wrote:
> Add a const mtk_pcm_constraints_data struct array with all of the
> (again, constant) constraints for all of the supported usecases,
> remove the duplicated functions and call mtk_soundcard_startup()
> instead in all of the .startup() callbacks.

-- 
Regards,
Alexandre

