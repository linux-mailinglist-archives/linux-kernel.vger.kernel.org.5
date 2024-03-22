Return-Path: <linux-kernel+bounces-111100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDDF8867E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110B6B22CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F015AF9;
	Fri, 22 Mar 2024 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CBrUF++O"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C003171CE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094780; cv=none; b=ARdrZEb1arUNtGEcYbeZKHm7AKmEtvJezloPyrXYuCuWTBwJumwdpc4+eCslA13ctKkWNJu4hnadDV/VK3kPEu5pWiXGRGXNlmu01XLVOIm2mgGIRpxcdWw5nUxELevHmLHc7a5TdsYull9tw/IclWZLoNUz/ipEMdPQ/2YZ6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094780; c=relaxed/simple;
	bh=yuz1DDYwwZ+Wu+hp6fEC6IuIktiCN/2dn12Wf0kXYLk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tyMcdLXxviSiZ3aCC75Qoem9iHcWBac94oWH7fMtXPPvksZ6swfxC2d5irQwdf+F5Mnl5HmApm0DzsY2vCtbW/7+Mn5u50C+Ipp2SxUklGTfVH4CEehpR6LCrJ1tjtyc8416WNfON0RpsLei7MxXIvylnmmZGKR5ffJi8lOPQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CBrUF++O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso2077376a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711094776; x=1711699576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XsZLSAJEXmeZxbFin0CImKOsNm3aXacrTABAdgCK260=;
        b=CBrUF++OF+YmwdF6X7cykeYwFFB9S4gKX91/zNupGnSducv/hPcy1m4P6tCruNlZ7S
         xas4y+D/4SCEZFHVgSY2G4pNqZUN6GPz9NfUhkb85MzcScr4YLE4FsN0PuDuwF4Iynj8
         ObSYvEe8YoMS0IjJRdo2KIYRIhK8XroE5ez5ergYLk6pqiU1G4pPriGhEHmwp7f5eF8E
         v1QKwafh/VkVEL23GO8IljWpuG2qr3GAe17GOSYuEiqDIgdO8u4TNdpS+AbLUO3uRdu/
         bOk7whClpIa/DtkJ2Vfp8s2pSM93Tk9DL/6OH+FM4VmrHSu+IyuCL5xtxkJU+tff5e8f
         LAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094776; x=1711699576;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsZLSAJEXmeZxbFin0CImKOsNm3aXacrTABAdgCK260=;
        b=Jtx0L3/MTyfIbBA0S75RiAboPtJtRhH/FP/yLoQgyP/6vDrlZcXjIrPEI7ra/CcZpb
         A5nak5iXdkpS2kqHsv5j/699SPGZ67YH6mTMO5Xl/E54QJ6FOp7ujY1+zVQ0TFyHX9fW
         FE39b42AbpcHtrjEc6rAme53yQbV9wVJ2AcWcGZwfgn+o8QNWqFSlY6NjYzEK+xZ8WyD
         J6Kq17NoxDTjQ/aQRrFreEsigQR+x4L2MfS6Hmg5p4f4wgdE0FUYOYpNCZAHhi1pz8uA
         kqm6v/BRL+80+Ecl2BhgdKWehJLrBm902mLEcrnx3HkAG865t30JmSVsej8HoMViUQVY
         ouNg==
X-Forwarded-Encrypted: i=1; AJvYcCWfxoCdAzI/fwFeQGyr0hXObxwJwxER/ttlD11iBNPAb7UnxbiB/qcJqWzOlqvR6kgZb45VW+mBNYfL7rIy2Z97zpfQvPSy0AgqciRW
X-Gm-Message-State: AOJu0YxD4QYh3i0u0zZmW7zQ9sJ1ZapPXiRlt5UNOk2uUUQG8Vf9HEsT
	WK93XZCe6h7hiTvmm96FR5bfk1AdionFTwRIf159QGhdPv76GZJfWUEPS+hl8B0=
X-Google-Smtp-Source: AGHT+IF6hLTM5QsWFB8daZv5l4Na45H7PPkkgF62jW5LxW0NpIpFh38gMORfD2MF7w/c7B8DVIGztA==
X-Received: by 2002:a50:9b44:0:b0:56b:b7f1:8094 with SMTP id a4-20020a509b44000000b0056bb7f18094mr977606edj.35.1711094775863;
        Fri, 22 Mar 2024 01:06:15 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.156])
        by smtp.gmail.com with ESMTPSA id fe8-20020a056402390800b0056bd1e71310sm743729edb.85.2024.03.22.01.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:06:15 -0700 (PDT)
Message-ID: <b473d940-0301-472d-90f0-297da6815377@baylibre.com>
Date: Fri, 22 Mar 2024 09:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC
 pinctrl and GPIO
From: Julien Panis <jpanis@baylibre.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>, linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com,
 vigneshr@ti.com, kristo@kernel.org, eblanc@baylibre.com
References: <20240320102559.464981-1-bhargav.r@ltts.com>
 <20240320102559.464981-11-bhargav.r@ltts.com>
 <775348fb-3227-4609-b4aa-c8a6eddb8953@baylibre.com>
Content-Language: en-US
In-Reply-To: <775348fb-3227-4609-b4aa-c8a6eddb8953@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/21/24 12:10, Julien Panis wrote:
> On 3/20/24 11:25, Bhargav Raviprakash wrote:
>> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>>
>> Add support for TPS65224 pinctrl and GPIOs to TPS6594 driver as they have
>> significant functional overlap.
>> TPS65224 PMIC has 6 GPIOS which can be configured as GPIO or other
>> dedicated device functions.
>>
>> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
>> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> With this patch, an issue is observed on am62a:
>
> root@am62axx-evm:~# dmesg | grep tps
> ...
> [   12.122631] tps6594-pinctrl tps6594-pinctrl.2.auto: error -EINVAL: Couldn't register 
> gpio_regmap driver
> [   12.133216] tps6594-pinctrl: probe of tps6594-pinctrl.2.auto failed with error -22
>
> Without this patch, the issue disappears. Do you observe
> the same result with your am62p ?
>
> Julien Panis
>

Hi Barghav.

I found the issue in your patch.

In probe function you handle TPS652254 and TPS6594 'switch' cases,
but you do not handle TPS6593 and LP8764 cases.
Since AM62A uses a TPS6593, it currently falls in the default case,
and as a result probe fails.

Please fix it for v5.

Julien Panis

