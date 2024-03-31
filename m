Return-Path: <linux-kernel+bounces-125984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398EF892EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE7D1C20C16
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E10CAD5C;
	Sun, 31 Mar 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDLpZktB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91758F51
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711872922; cv=none; b=V9S/g20cM1mRKpPgBtE0eSi3H9cpS1E7C9uNNPCyLiWURMW3g12o/HoX7ouUY2XgZMlns4+tijH8CqefzezwWiqOKYxhPZyU5miZJwdWy4imw7miZY9ySKLRLH7zSB8KGxhUqqZCQZMR0jPq4YxcSofqVSjCP2CY3eAH3MQqCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711872922; c=relaxed/simple;
	bh=jwo6cfDvf3jFfMqcnF6otesm/6mEcOhzaNul8s+ISls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StUwQrbFeyW92haoANciLXhVdiS7V9R8K5cJNF5T7hO2uGQxkPrK9lSSIQbJlJ0D53QW8/ZKbbjYVj4hN+jxWJNzf4NhK5Ebsrw+2w4T2/jvw8+PVdTumYZyldPGADC+7NQCNnpx1RP443YYUW4YqRgTccMb5NIfbRCFTOrZg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDLpZktB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-415584360c0so5777435e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711872918; x=1712477718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GLqRhp75hqcMq70uNQSU9yQJhrD6r55MJYxRY4a6Sjc=;
        b=UDLpZktByYdTT1TcKbtqW6gT/C8Npq5seEYUnME8EetiM6zeDXpPfbEMGj1WhE0vhj
         MoMk9j9wHWQmYSUBHeMBQXb+/1ejn7ae0s1U514bLE7s0WaqAQRC6126CowP79qtKTNs
         52Tm+ZmdBQmdRopmANoLIVJHOCcqXU38YUz/58NUDsOJGJPk0dUaOwaViO0d4WM+MZSa
         hidXT8BDvulx/FU60eSL1NjToogv/BJkfGCBvtpvPI+xyuMLYhHwUC7HcVsBQmiawXS7
         bZcjlrIBqGlF/TRuAFCxqfTpmvSHezoNzHC5dTrKBszzvyHKG2LWi2zGnGSRcr05/Ab1
         gPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711872918; x=1712477718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLqRhp75hqcMq70uNQSU9yQJhrD6r55MJYxRY4a6Sjc=;
        b=eZSowK+FPMVm5Lej2UyAdr8udf3hBSyzXaiBhNX4QNYINH5OSP1l/1Bs84LL5xqFnm
         S7Hzp5UmbmQjJeIukW2/ow8CzUAHpqvQBdAyFg5+SzopDVCvrYYdvNehHoiaxYnO6pru
         oLJ23Zx6QshZ275v8LHcqI+2eRN44h2hccrG/75Ce11L5QpbH0pRIQMv1uZJUzOyo3j9
         n92Qlkceg+MCfR4+XNCYSm8S5e+EOZhpTL2ziZzpt7lfzYOvcQUwpdwAhiL95KL2ZJS7
         y6sp7zCl5cafVSWrO7731mH87B/ZrfJmETWJmXH8dJ8TfewgmJI2PX6uPAY8+Ar6JVvH
         JgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXylCmvdSl+AE4yoCIQCqBRLxmDc/ivqi14QM4lQjfYif+A09iZHtWdc06Ws8Euj/FR7UZ//njC6YwJB+sHjpuhZJdNP+0Hz38SaRrd
X-Gm-Message-State: AOJu0YzDc6TrawNUtWrPoI/NqRR4cyCkQQI/9J33zYMcv0EQoqbZBhOM
	k2towyVov00//zN0BY0mGaMigt+cbxUFx8charf1DId5aZivVgJVGpDOiiK5HGM=
X-Google-Smtp-Source: AGHT+IEj4chibXJ3nlFP7Bu9V6ZYACWLCIaWSoNnJpklJoiCR8s38a0x+aNfDean6K7brvG3wVoBsQ==
X-Received: by 2002:a05:600c:1f94:b0:415:5732:65d3 with SMTP id je20-20020a05600c1f9400b00415573265d3mr2471233wmb.37.1711872918184;
        Sun, 31 Mar 2024 01:15:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q9-20020adfab09000000b00341b9737fc5sm8411916wrc.96.2024.03.31.01.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 01:15:17 -0700 (PDT)
Message-ID: <cc7a60c3-4a1e-4f32-b6ef-4a41d5c48eaf@linaro.org>
Date: Sun, 31 Mar 2024 10:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
To: Shenghao Ding <shenghao-ding@ti.com>, linux-kernel@vger.kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, perex@perex.cz,
 tiwai@suse.com, 13916275206@139.com, mohit.chawla@ti.com, soyer@irl.hu,
 jkhuang3@ti.com, tiwai@suse.de, pdjuandi@ti.com, manisha.agrawal@ti.com,
 s-hari@ti.com, aviel@ti.com, hnagalla@ti.com, praneeth@ti.com,
 Baojun.Xu@fpt.com, Rob Herring <robh@kernel.org>
References: <20240331021835.1470-1-shenghao-ding@ti.com>
 <20240331021835.1470-5-shenghao-ding@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240331021835.1470-5-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2024 04:18, Shenghao Ding wrote:
> PCM6240 family chips are popular among audio customers, in spite of only a
> portion of the functionality of codec, such as ADC or DAC, and so on, for
> different Specifications, range from Personal Electric to Automotive
> Electric, even some professional fields. Yet their audio performance is far
> superior to the codec's, and cost is lower than codec, and much easier to
> program than codec.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> Change in v7:
>  - Rewrite the subject to match something similar to other commits.
>  - And none of them are compatible with something.
>  - minItems, then maxItems.
>  - Drop reset-gpios description
>  - Remove the repeated reg descriptions and reg constraints.
>  - Drop redundant spaces.
>  - Add missing line breaks between blocks and additionalProperties.
>  - Correct compatibility issue on adc6120 and pcm6240.
>  - All these chips have only a portion of the functionality of codec,
>    such as ADC or DAC, and so on, but their audio performance is far
>    superior to the codec's, and cost is lower than codec, and much easier
>    to program than codec. Simply one or two register settings can enable
>    them to work. Init for these chips are hardware reset or software reset.
>    As to some audio filter params for internal filters, it is up to the
>    special user cases, which can be saved into the bin file. The default
>    value also can work well.
>  - Add blank line before reg.
>  - remove unneeded items and if branches.
>  - Add missing compatible devices, such as adc6120, etc.
>  - Add necessary people into the list for DTS review
>  - correct misaligned.
>  - simplify the compatibility
>  - remove sound-name-prefix and revert back
>  - Add review information

All these changes in v7 and you still kept Rob's review? I think either
review was not given or your changelog is just incorrect.



Best regards,
Krzysztof


