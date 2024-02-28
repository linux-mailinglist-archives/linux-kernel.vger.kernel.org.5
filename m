Return-Path: <linux-kernel+bounces-84779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31FB86AB78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19ECCB2405E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1236103;
	Wed, 28 Feb 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVi3yfe+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71C31A83
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113104; cv=none; b=OY717gpldjFcIdbi9EuBClzGsP9zCWuQN2CxNKpAozHPqcWz+L7pFwKq+YInhaGtkmTJqV7VQIwPeO8i4XC7vFMVXJfA6/eu7sSSOKZdTS5ELbhgZ6moqgv5ORu7Ok03XpfUaPZOcXkgJOz8qVEK02k6Vy2atX26qZlSlFV79EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113104; c=relaxed/simple;
	bh=PsR1pfhQj1+YctW/5hj7cA5FYtAGn3Ht2yBzNPBY4EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AHBvYPEsj1wYbaN2Q2ZsV1YXuy6efCDP4HOwDCOEGRygXu0HVTMVvTJB+51IKymYdwpsnTCKddaTNhokgtxFlEEylepgMZQj0CEGA7HKCyi8IB1+srYXxrwjM1uIs4GeUvc48fdnhdV5fPMNnnw7xbPBT/wqONAVlfWyxVIh31s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gVi3yfe+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412b3f88132so3090005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709113100; x=1709717900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4+AKRmkmBFEoLIViqECwVqYHAu9t9L66Ay6/6CX5qk=;
        b=gVi3yfe+1CPYCHnSX5oOnMw9+afsQSsePxQoXFmUVM8+A9WuU73DJES0ZMQbo2Gyvp
         r6zv7Z2tnKpfu6cFCi0sofVQWVywqqOEPkzwsrKs10GSGz2NveIux/Q9ifDDpnsglPhS
         gew3zqnGI1EfjhLDi9WrJT2MdEN5HXPCcuV2Kpqh2r+jkg1Bqui5fPNqmC6LmVSf5z7L
         /6kfGH3Wmxxaowb+zQYntrgHRK1MZpYG5LsAzl8tSTGJuH4sDr9HWmGPokSHDnb/2D3U
         lnwDiHYc1vR7/hSsekFnK7uO+L1ylq+srkn+B+hEt7sy5kIwzBCvy1fmW0ecDy4qfbTc
         +28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113100; x=1709717900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4+AKRmkmBFEoLIViqECwVqYHAu9t9L66Ay6/6CX5qk=;
        b=Q0Zr8CQ00DV+jMPJTRkbL2MbEsgShh1iHNTndWXtsuDcOzuOCJmb+hyA/ukOoEFhvo
         0XKST95HlI5FJrJHZMpwD5uBbTNoi+1/J16GWMSK3wRV5tW8wk47WkvHY53hTVy1qPGb
         2QPgczbj03Ub3j0q5zwl2AL6aWVW5qnrcUD+DdVtdyZOkLFBpQVCnLLxeWGZ26e2CP/E
         QOwtCcRQutKdMI8AJjxis0oDkqdVNG3gDbpO2R+aeM7KbTGgrmPGSgcRSOq0EaborXbO
         uxnTfrtCRvWisL1kuWktv6KhUyk2yH5LEXVx3QFJnEq97h42J43t2fqjeH7z6w9VKg6R
         ITsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdjqSRaNBtYOspzmQuybR1FNW3g7y2S6VDMMrHOEbi14oul9RGsIU+20YoakAHU8hCr3UVg7Y4iUgnNqMpe2aBPAdazX87PMbh0Ih+
X-Gm-Message-State: AOJu0YxH9+fvlzITE8ZBi98BXDywFy9zsAbJssTzxo+NbtnOw6Lu4rap
	zJPRalWaxrtlNszlfPaoKnxrHc+BocYYtYxPSoNduHMDWLYdflQ89BGyKUfGgBk=
X-Google-Smtp-Source: AGHT+IHOp1pxzWYsSZdgMk9fzN4/wRCtOOeXX9R3/XcarEOcYQuEj1WE1Pi4WYyJuSqwQHpUbVzypA==
X-Received: by 2002:a05:600c:a4c:b0:412:77cb:ae28 with SMTP id c12-20020a05600c0a4c00b0041277cbae28mr10799118wmq.11.1709113100097;
        Wed, 28 Feb 2024 01:38:20 -0800 (PST)
Received: from [172.20.10.10] ([213.233.108.239])
        by smtp.gmail.com with ESMTPSA id o8-20020a056000010800b0033d202abf01sm13843461wrx.28.2024.02.28.01.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:38:19 -0800 (PST)
Message-ID: <557f369c-e6f9-4794-8d80-bda5c149db5e@linaro.org>
Date: Wed, 28 Feb 2024 09:38:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/39] spi: dt-bindings: atmel,at91rm9200-spi: remove
 9x60 compatible from list
To: Varshini.Rajendran@microchip.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172638.672366-1-varshini.rajendran@microchip.com>
 <19da0e57-379b-4db3-ba8e-db7efe336e15@linaro.org>
 <98fedd3f-b55d-4ad1-b2ca-1efef0a19505@microchip.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <98fedd3f-b55d-4ad1-b2ca-1efef0a19505@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 09:28, Varshini.Rajendran@microchip.com wrote:
> Hi Tudor,
> 
> On 26/02/24 2:39 pm, Tudor Ambarus wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 23.02.2024 19:26, Varshini Rajendran wrote:
>>> Remove microchip,sam9x60-spi compatible from the list as the driver used
>>> has the compatible atmel,at91rm9200-spi and sam9x60 devices also use the
>>> same compatible as fallback. So removing the microchip,sam9x60-spi
>>> compatible from the list since it is not needed.
>>>
>>
>> I find this wrong. I though we shall add compatibles for each SoC. Are
>> the registers and fields the same for the SPI IPs in these 2 SoCs? Even
>> if they are the same, are you sure the IPs are integrated in the same way?
> 
> Which two SoCs are you referring to ?
> I am not removing the device specific compatible. I am only removing the 
> additional fallback compatible.
> 

ah, I read it wrong, sorry
> As in,
> 
> compatible = "microchip,sam9x7-spi", "atmel,at91rm9200-spi";
> 
> instead of,
> 
> compatible = "microchip,sam9x7-spi", "microchip,sam9x60-spi", 
> "atmel,at91rm9200-spi";
> 
> for the sam9x7 devices.
> 
> Hope this is clear. If I have it wrong please let me know.

it's clear now, thanks.

I see in the driver that microchip,sam9x60-spi compatible is not yet
used, thus removing the fallback to "microchip,sam9x60-spi" brings no
functional change. Would have made a difference if sam9x60-spi
implemented additional support that sam9x7-spi could have used as a
fallback. If you think that sam9x7-spi will not fallback to sam9x60-spi
in the future then:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> 
>>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>> Changes in v4:
>>> - Elaborated the explanation in the commit message to justify the patch
>>> ---
>>>   Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>>> index 58367587bfbc..32e7c14033c2 100644
>>> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>>> @@ -22,7 +22,6 @@ properties:
>>>             - const: atmel,at91rm9200-spi
>>>         - items:
>>>             - const: microchip,sam9x7-spi
>>> -          - const: microchip,sam9x60-spi
>>>             - const: atmel,at91rm9200-spi
>>>
>>>     reg:
> 

