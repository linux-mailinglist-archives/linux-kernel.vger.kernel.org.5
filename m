Return-Path: <linux-kernel+bounces-163757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41318B6F74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747C71F24416
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0114264A;
	Tue, 30 Apr 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vzh69BIF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648113D257
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472278; cv=none; b=QeQKrbTjN69/HY121P8VMPsdCA+GAglay89MwzGeYKhfGpu083Gy0S4e4DdAF+SMTv/aZwggvJbbOSkjNXcsc9WSelMKXvv7KBzk0BBprZpEQed89E5/XKQmoosNaklJ40IjtAlb3Yn1n6VRhY0Z7M7uee1qwKjiAM84xHUgCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472278; c=relaxed/simple;
	bh=8qqAdZ/ysBDQ0bBLx+wuMxmUlHkojWR9VO8wGD10d9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZefQT9PXUSzVJlZnnvJaKfOvjc0tvJzVk5byNXRKNVJQEfB57S1EdNCtN6/QVzNfvGWFKMyhSGr7t4+51i3JZ1Z8xliUPIWsd9exuL+U9P94yeorsQLb8q+RQd8RRnA1ntPtBbCKDDlBMenurP7K0zxFiPsKY7pn5VsO7n+MAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vzh69BIF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e9so29994995e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714472275; x=1715077075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61QGK6EE+JvUrOTegIXYCGltaVd3HNOf6mVtdZdFzzs=;
        b=vzh69BIFdd/j4CN1/ETUEwelY3PxTcrw45lGUa2P6BXqW/zk1vLiBq9v9R9xVYc6Gb
         6yCni/YKg58gbJ76HaFVA0s0Cu0lNXOW8NtfuW2Vnd/YaizkZyM5MKGf8m34fSBk08i0
         +OGzRmKRsJxOPapEkeSf8G/cmgdaFCX9ML3PK447z8oKu31sPPRyXGKxpcOOFYWwvgaU
         QDJF6AxNYca/5JHbyb4RzJ7PmeBgDTrX18RGsybPhCAxm+Yi/3jnl9dJlCuzXy7I4Qcp
         MNKXfrE+w1bDdPX8s62iWmNV6DdYZHfdB9+h44+EPVJlchQ33ZgNq39R8Ty4rVKQ81Vk
         T8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472275; x=1715077075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61QGK6EE+JvUrOTegIXYCGltaVd3HNOf6mVtdZdFzzs=;
        b=Nt7WfzwgXD4eFQGLmZUmrpa6AkHPV6zjOcYes806H4EvKPhw1TuwSiexFMtVyNsFRW
         0cGtiyLxRbP/wBJVKcS9CUq6sc4CVfMLE/TBt9tqZSHm7Gx7Xw7NBMEmujXW7EmTStO2
         jXGbm6yfjf/C7HJCS4y5wRR8hoPM7IJQdyh9jeB0uEvBG1Rt4n+w+PH9egMBgqqZ/qtu
         vGiI6NGl4IF0oRDqyTrnGVrIVeCGkj2NxS18UUOB0K/JRo67FwxwHW9rvfBFyp9PdV87
         E532J70u21kTvhrEHWJ5D4BrFDnrIzVMaLQZPUeyqptxi6tgPlYfOFtEM1vdjslP2phf
         294w==
X-Forwarded-Encrypted: i=1; AJvYcCVg66uHYsXjgEblaTLzwUbrvbKLCJRk8aVcuS+qBwj0xnzzZXPzMUttTA6Of0RdQEviN33Wnh5kaFXOSjJsqMQXBWvFOqNhMo0KsBz5
X-Gm-Message-State: AOJu0YwQaNNFI4LQgtHwZ3TNoSqCsmErY5GHPwN4ROlm4CAlBFbLv4Xk
	qZeP5oyjpaK/Ym5OZI3pqm4CMEGt7ZOtYB7iH7t8LqCn5UzQ4xNiFevK4eLAfK0=
X-Google-Smtp-Source: AGHT+IGicD8LgUlYM1L8jAIzwk7lp2yQ2IjySmGuztg67KCqJ6vLOq0P1wNOuCpEesOPQpne2u8iGQ==
X-Received: by 2002:a05:600c:1e28:b0:418:3eb7:e8c6 with SMTP id ay40-20020a05600c1e2800b004183eb7e8c6mr1897308wmb.5.1714472274834;
        Tue, 30 Apr 2024 03:17:54 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id i17-20020adfe491000000b0034cc9dcccbdsm7046219wrm.113.2024.04.30.03.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 03:17:54 -0700 (PDT)
Message-ID: <1fc23530-89ba-4e36-9e9a-a1289f56a9bc@baylibre.com>
Date: Tue, 30 Apr 2024 12:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/mediatek: Add support for OF graphs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 09/04/2024 14:02, AngeloGioacchino Del Regno wrote:
> This series was tested on MT8195 Cherry Tomato and on MT8395 Radxa
> NIO-12L with both hardcoded paths, OF graph support and partially
> hardcoded paths (meaning main display through OF graph and external
> display hardcoded, because of OVL_ADAPTOR).

Is that make sense for you to add the DTS changes of these boards into this serie ?
I asked because, IMHO, that could help to understand the serie.

-- 
Regards,
Alexandre

