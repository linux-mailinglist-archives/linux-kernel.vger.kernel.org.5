Return-Path: <linux-kernel+bounces-81311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DF8673EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259961F2C31A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F51F608;
	Mon, 26 Feb 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b+S8ushs"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DB1EB5B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948328; cv=none; b=OWCMivXEfyGF9Z4AOdHLGUYGyuqEWxLrg8G79J8/o1BWu6+vgTwOWlU91zcrc5u0W4AtlAM/z6wvZ/Y2wfI0Bc1Lw/AFKvCgwZSmjI/YCq19PjhJYxxTyOJlXJpK0+LUmcQMKXGi1oqGgE0aEfkEJPkwrVoY8uxkHBBWiaqph3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948328; c=relaxed/simple;
	bh=sOzOESPSJJuKs5PAS3HZPU1TL/jbqDPulGHUi2T1kSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSLOIjdJEphErEZJeVMX2cyQEejUuiO24hr71B6HjdXhSXgqiG3oYIRjSyaFqP0wSGGYJ84TcqYmTxl3BXsjgRO186L/FQCArjifoTyK6386mUhDYfGhSy6o1DgNDHt8i+RhQcPzmVpa8MOB2YOmMMqdsQHwNH1mqUVGkT81Oqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b+S8ushs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a3371133so7270635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708948324; x=1709553124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mz1uRkxJ9UbCLdRqQYDHAKRawtBRwIdQ/FjWHaCkwJM=;
        b=b+S8ushsfvjC3dYmVdCRBizJgeMP2nlvA00iE4V7Ngk/iSoyp0xUKS1LAhId/R/+8K
         o3lgB0ikWp/TJZpTI2GoqplVdoj9LIu66X/epE4gRYpCgqFhVpHWIz0ggFH9KH9a0rGb
         cDWry9ljQS3pI6+oRIdyWzTKL2y9epGF6By9wo1LUG3Ixq6sUGlxvFEbYxD+nv8IHVcN
         n6yGuV9xsuOC5MFh9Ta6yH+2E/Xycr0KnJsc/OwH8DPRng2ZfHquU2vOpsVywwg9MyMi
         varINfdFm4Upvyf8iiGueSDR7pKE5wFybYqWkD6u/YMwc/FGDuAnqOg8kwfakVgV5vAo
         dERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948324; x=1709553124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz1uRkxJ9UbCLdRqQYDHAKRawtBRwIdQ/FjWHaCkwJM=;
        b=wpnRCE0Ste/+e6qSmMC/SeIO6vm0cADCGFCMHwzvmw/hET0kO8ABOIhiPWtvyrONkU
         UR0fW2GV2A4XGENcrkCTPEfwOIF5BcDzbxTyj5VXTfwBl4StlfA+6faOHUz96U4UBhxH
         YTdw66WaORg/08C5yIxJ0khJ7JOYsO+ypsyOwYGg6y/m3JFFDPpeizekhkrd8dF3ngnJ
         iKvj/c7OT5pk4vjC8LkWHVQXEZvW5ZxE+2+3eCSO0mUMeXFbvmRo0n1pucTxcMV0qpDp
         pIdqgvcgw4K0z6fKH6d1KJyTl0E+u2w6fVsMsS8KHX1i3UZwiyYnV4iVGzcgeBR+2jvd
         TImw==
X-Forwarded-Encrypted: i=1; AJvYcCUzeaI0woS5ztE19z67zFTQuUb2AraTJ25742WQyI8P2Ud7xsHQK+63A/CPjdqIWtSagBlhU9+R3hALBDYSJJtzkkfr0xsllk4XHilR
X-Gm-Message-State: AOJu0YykcOpienjyc2CS1b75DvWzwab2rFqQc3UmCuQzX4iB/S4zd+gZ
	Hd2oD20WeuKCGT1HDErcrtx4jz0DNDFPwhItRse/i5i0PlnWngoMOd5S2RftOwpBhztuvrVE3AZ
	u
X-Google-Smtp-Source: AGHT+IHuxCyz0aJYPuqa7jbzFzpVsMcqlrnBD87lnBA/2voj6xC84towYtJdrLWlnO4Avghcg9bmYQ==
X-Received: by 2002:a05:600c:4e86:b0:412:a21b:d5d with SMTP id f6-20020a05600c4e8600b00412a21b0d5dmr2728429wmq.29.1708948324496;
        Mon, 26 Feb 2024 03:52:04 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c234b00b00412704a0e4asm11692160wmq.2.2024.02.26.03.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:52:04 -0800 (PST)
Message-ID: <d3c579e1-1560-45a1-ab7e-59ed32986eea@baylibre.com>
Date: Mon, 26 Feb 2024 12:52:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
Content-Language: en-US
To: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 vigneshr@ti.com, kristo@kernel.org
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-7-bhargav.r@ltts.com>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240223093701.66034-7-bhargav.r@ltts.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 10:36, Bhargav Raviprakash wrote:
> Add support for TPS65224 PMIC in the TPS6594 driver as they share
> significant functional overlap.
>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>   drivers/mfd/tps6594-spi.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

This might be a nitpick, but for the next version of the series, please make
commit message description for i2c VS spi drivers more homogeneous.
Same comment for MODULE_DESCRIPTION (you changed it for i2c: why not,
but then apply the same change to spi).
With these changes,

Acked-by: Julien Panis <jpanis@baylibre.com>


