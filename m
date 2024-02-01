Return-Path: <linux-kernel+bounces-47995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7691B8455E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B411C23419
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B515B977;
	Thu,  1 Feb 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfLkkKbB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94D15B984
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785216; cv=none; b=H1ZF5pEXO6wVMXVljyOQ+slM4RQAfpEPesFCyx+qxm+qAvONLPTkY5flrXy5CLR9hjWl4j6UHsV/cuWdq/H74vnMY/Lrblu9oXi3J7/5Qdde5I19xQrYBf9Wg4NB+5PF2FH8301mMWKsU33dlFjeZeqCwIqM8QBDVECsuVbunRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785216; c=relaxed/simple;
	bh=GCPgV1kbRMfarXjYn+8SFS93BM6f5+hgEFcYP19urSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UswjrwmxnI9R6BsUdWKzZVvTZLATPWIFHO7V8epJ1YM0ZohLQIBg6rLucEfER9k1zkhiJq2JFW1hZ5q+MqZbcy+iV+fSH0jN2mLNAFqEhfBcZwNegG5Wy0I5XQ6K8Q/Cs7j3Ve473wl1MceDde3D+oCTx4tY1QMrMmMSrNRPX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LfLkkKbB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55ef4a66008so806530a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706785213; x=1707390013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lU6tkUEfkunMI939zWIvUmnCjEdtN4c8PV6t+vXkMx8=;
        b=LfLkkKbBHGuwloTDY1YEc9A+fUG5su/LRTp+vWQLEY04wEVKKe3OMvqOfeSyqpj8oj
         bF/Fuk2jYmJmlPpyduD4GXI1PE/8NnrWhkdSa72IsZBAcmiz/h7SQ6iwCPfx5eQGrtjy
         m3dBv40HXRd+QSjEn3j7MF8dPUHqNGwLbddy3VS4tUGeNwP8+r76OQ7sGd73IAo+3alI
         CdGswMhaRfFFx08iRJ78uw2u/EiEGBGFIQr/3/VJvHY6tPzDDIVEp+ch+M71cU0gcykm
         hT5nVvf2kKLXMdnrAtRl7qE8FewMSGliFPe6/PVo9CzGeZEvWNnloZKQLmotm8I9rmcX
         LyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706785213; x=1707390013;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU6tkUEfkunMI939zWIvUmnCjEdtN4c8PV6t+vXkMx8=;
        b=oyhfrhG4vLiIwFrhb/j7XxR+uI7ZOvxiuEwg6gcpcvnXbmHl4GsZieCuVh6ekOJyHw
         iUrJmjhSMXX3d+llIjgfIPRGLFN+1YVdoNRbwfHNJmz/w0zID1Wa8WZyYrMYX/RxDqFU
         R08AOsMEE5Pte98p1SNKhsYH3PoQ1tYfoyAPcNQhcKd4hDPu5YwepazX/slsvAswsOzU
         vS8qAqjaFu7kOdoPz+/4l9AZKp+qOXAYkE6zYR6JLqjMmfE9QtwQyF8B/J0pbJlsnaz1
         +79xY8FZQJezB7dbw38TLPJ57mHLTT6mwfnjgApU49CXOzvn5dY+vWp0xEb7nRxUqfbg
         lCtw==
X-Gm-Message-State: AOJu0Yz/S68j89puo3U9MQbXY38QQZzDAfKBgiKKFqVFoBYV77tumLKA
	EwD+Py381dSyZsADzLcJI085BI85eN+q8PInWSA74L8gUc8g4I58cVm/G9C3Qp8=
X-Google-Smtp-Source: AGHT+IEhO5Pv8I3a2iinvCG52x4sGo+qCsN3SnAzvpAIZjWdtZo1XUMuuYkSQYa+ZIjvPuDeQk8qNA==
X-Received: by 2002:a17:906:4154:b0:a34:b23c:2f43 with SMTP id l20-20020a170906415400b00a34b23c2f43mr3346509ejk.2.1706785212695;
        Thu, 01 Feb 2024 03:00:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCqcbK70Jmp87C4H5o8/5ZZZ4B/4bjZIg16+zVXH8Mxj8qv8sHLpzTw1lsFLKnIT9eT9FCjVNu/9PFAzSpGMOI0oZYRd8o+j3LJtEfjadHTmwn9B77M0OwQYoBFDhSakpYW0AWu/I+FxN1OBQBaXUjrrj/zun2gCxVylqHgFPaiDPnXcmEktkpRQ0B+phzYGcy45pbn08izWGPH45zPxwM08OEn5XSqRAuB4eXQGAQdG+1bjSv5L+qijugehmIHG+d3ofggl+cmHTj/5K7Ijd1IFUjmU+EBE3wUYzLl1IWrLvWdBMpXRSx61L+pVNamm/GO8INNoREGXrjLqlMuEq7xsOM5QP+oSIcqdCaO0OdAz8EyKrBHHs9tGCXynyqr5XRungS2LCwbUs8BztaOqSOKndWmWdKfYKJa/bKWSmBSu6rZ5fEznDbZr2ps7fbfjpRdm6RURZK99HWFeYafmo/y1gD0ajxRyxPZHtjGSoaCurzfpGpTHpw+LsmD4HoLZ5bfcYWTNppnSVnbdKrGdb2vtevV77oZkxZs+2T1it+drBc8xyCJr/evLYFFBrRIlkItHL/9Wwg6Sh5apci1ewPYjuhhcsWsYGARcrNBddM73kXZ12RUCnSO9y9Ytpob2YJKhpYitDQ5g==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id pw20-20020a17090720b400b00a2e9f198cffsm7037448ejb.72.2024.02.01.03.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:00:12 -0800 (PST)
Message-ID: <4e9ce766-602f-4b75-8c25-48da4d22051e@linaro.org>
Date: Thu, 1 Feb 2024 12:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
 <20240131-mbly-clk-v4-4-bcd00510d6a0@bootlin.com>
 <f6e5b748-17c4-4de1-be42-f79155be21cb@linaro.org>
 <CYTOEGEI34JQ.36CF09LNJFQHS@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CYTOEGEI34JQ.36CF09LNJFQHS@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/02/2024 11:38, Théo Lebrun wrote:
> Hello,
> 
> On Thu Feb 1, 2024 at 9:58 AM CET, Krzysztof Kozlowski wrote:
>> On 31/01/2024 17:26, Théo Lebrun wrote:
>>> Add DT schema bindings for the EyeQ5 clock controller driver.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>
>> No changelog, tags ignored, I scrolled through first two pages of cover
>> letter and also no changelog.
> 
> In this case we fit into the "If a tag was not added on purpose". Sorry
> the changelog was not explicit enough. In my mind it fits into the
> first bullet point of the cover letter changelog:
> 
>> - Have the three drivers access MMIO directly rather than through the
>>   syscon & regmap.

.. which I might not even connect to binding patches. I see only one
entry regarding bindings in your changelog, so I find it not much
informative.

For the future, please state that you ignore tags for given reason.

> 
> That change means important changes to the dt-bindings to adapt to this
> new behavior. In particular we now have reg and reg-names properties
> that got added and made required.
> 
> I wanted to have your review on that and did not want to tag the patch
> as already reviewed.

Makes sense, but how can I know it? Other people often ignore the tags,
so safe assumption is that it happened here as well.

> 
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions, under or above your Signed-off-by tag. Tag is "received", when
>> provided in a message replied to you on the mailing list. Tools like b4
>> can help here. However, there's no need to repost patches *only* to add
>> the tags. The upstream maintainer will do that for tags received on the
>> version they apply.
>>
>> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>>
>> If a tag was not added on purpose, please state why and what changed.
> 
> As an aside, what's your preference on location for this information?
> Cover letter changelog? Following '---' in the specific commit message?
> Somewhere else?

Both are accepted, but if you do it in cover letter, it should be
obvious for the reader that patches XYZ were changed. It's not.

Best regards,
Krzysztof


