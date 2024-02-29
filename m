Return-Path: <linux-kernel+bounces-86931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F786CD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F061C2032E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC91468EB;
	Thu, 29 Feb 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opfyu8Dk"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404013A877;
	Thu, 29 Feb 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220906; cv=none; b=D50dPyUU8xKs7/h4puCwlhbaijNciTQPEEI5TsbyeUJGpLydxh2qoZgi9jC7VhM75YqNI0hGhL2NqhpK7SMDu6Lf9ycfjGyt2TsAbjl3n6+vlTc5a2j5bd3lmPBawRSMLt6wQb50LTly4iCYzddsJQRF2cBSBUppYG8fgu2x/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220906; c=relaxed/simple;
	bh=zuPfxtCT90QQiUBaYCzb22chu+yUsCqPEAv1MWn4DQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSaHZZkBYV3hnK7igjwR8JnsEcZN93GIx3W6p3oVcAB5FTPGCHRCC9ZgLuiEMkmpQFFRipM/PtG5cEatbvrkB//kIF2uoxH0dPK1/OW+F0+xm5YYr7PN71l2KZXzevtPy834TcOaTFXXZmbw5wEaKJK5e6zMSTu4EhXsLbhHM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Opfyu8Dk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513230201b2so889882e87.1;
        Thu, 29 Feb 2024 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709220903; x=1709825703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBLOLphE3NdfOJ934nKa7KCEvPg6yDpYhupj2MVRHGE=;
        b=Opfyu8Dk8hDEsDsJKG+E+uVxezTSqYrTJ/kQXYKghJEj6NW1TS6QPRVsGfBc2D6Zsn
         BmpK/+WT8IjDPspTuojrTGSzKs+wWdKn5VSH7jqnuOv5JC1TC5bmCwHGinJBpmAzGuga
         qjMvLa7Y9hSmO1OsnHAnRIoO4Tf5/S3hGr51V+lU6AXCUL70lOVAo0xSl4EJUJleabwm
         QchJbI5u2RwzPWw/Fdc8g+UgG5VSF2RWjOYWxtVm5Equa9jhypuSHtmr0aEw8cuNyR9L
         ohfuZqRYuCq+f7TyOfns8B2Xt77L3yFTio7PELlhAFUfQribzqGBcRsdE9/47+YO5Mg3
         USmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709220903; x=1709825703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBLOLphE3NdfOJ934nKa7KCEvPg6yDpYhupj2MVRHGE=;
        b=q6AslzePoL9SbprgLvXtwCw4X/RVK4pEp/1XBzK9Ie1j2TXdnDxu8E4XqVhnElPOaE
         Kac8mSGAHuU4H9rAi6fpbku34uvi4VtKLESDKjKd1ADOK6xr+rMPdDXbhkWjukm/gN3s
         sUZqo1eGXVCXENpJ7Ar3KQ8BDEtMF9WbAMF7jLIa7JvgjZK0XAE9xSv5e7Ao3IeJyEHr
         tGgLXKlnRO1bgDBLj8jMqx/0mAKvDdRTBCCysfvnHnOLs/besJ6MWxAYQQEwFiPe28cy
         tyTYJPMqldB9bTYgKODdNL3xMojSjivjQTL6nbXoP5JxCIudPkDWA2CB/b4HaEwywgm6
         5poQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2th6vTWkRcHZYGfD49pyjKhGsUHUrlWGtSBfmeqnS1hvPa25UdJxDgAeoANlCzfPQMyHfVWTKaqnyM3gJqTmJuTtjn4A4MZRgxTLpgYTnpwsovUnhDUjtVwR4sX9GjCdV5HjAlbYPXfyQFnos6EBIXxBkdbKMZ40hOY2FC20ZQLJJPg==
X-Gm-Message-State: AOJu0YyMnEmIDMHCW3M8VovnmXvWJsvlreMuF45AFerXSCl7Jvx42lNF
	rjRBV1M/5FvYZqMUDZtScIHf5/oy5YEUOl8z0YYCJR2W3xA/07Zh
X-Google-Smtp-Source: AGHT+IGREGNsgmXHr1yjEAArZqwnrmx0HadMKZoc0HPzLr+gTXApnJj7dhow2tE9gy/RWC2y/h6Bnw==
X-Received: by 2002:a05:6512:2f1:b0:512:f1a5:709 with SMTP id m17-20020a05651202f100b00512f1a50709mr1562593lfq.41.1709220902833;
        Thu, 29 Feb 2024 07:35:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id u15-20020ac243cf000000b0051321818dc8sm284628lfl.259.2024.02.29.07.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:35:02 -0800 (PST)
Message-ID: <a5aa10f3-e487-4e70-8010-1604bea3a936@gmail.com>
Date: Thu, 29 Feb 2024 17:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
 <20240228122408.18619-6-subhajit.ghosh@tweaklogic.com>
 <a828e77c-b3d4-49bb-b0bb-b9fd6cb7d114@gmail.com>
 <Zd9tApJClX7Frq20@smile.fi.intel.com>
 <45386f39-a034-4d70-a6d4-8804c27aadce@tweaklogic.com>
 <21ecfb62-30b7-4073-bad6-46a9e08e08b0@gmail.com>
 <ZeCJ3T8HVaQZC1Ps@smile.fi.intel.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZeCJ3T8HVaQZC1Ps@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/29/24 15:42, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 02:58:52PM +0200, Matti Vaittinen wrote:
>> On 2/29/24 14:34, Subhajit Ghosh wrote:
>>> On 29/2/24 03:57, Andy Shevchenko wrote:
>>>> On Wed, Feb 28, 2024 at 03:08:56PM +0200, Matti Vaittinen wrote:
>>>>> On 2/28/24 14:24, Subhajit Ghosh wrote:
> 
> ...
> 
>>>>>> +    if (gain_new < 0) {
>>>>>> +        dev_err_ratelimited(dev, "Unsupported gain with time\n");
>>>>>> +        return gain_new;
>>>>>> +    }
>>>>
>>>> What is the difference between negative response from the function
>>>> itself and
>>>> similar in gain_new?
>>>>
>>> -ve response form the function is an error condition.
>>> -ve value in gain_new means - no valid gains could be computed.
>>> In case of error conditions from the function, the gain_new is also set
>>> to -1.
>>> My use case is valid hardware gain so I went for checking only gain_new.
>>> Matti will be the best person to answer on this.
>>
>> I now rely on the kerneldoc for the
>> iio_gts_find_new_gain_by_old_gain_time() as it seems reasonable to me:
>>
>> * Return: 0 if an exactly matching supported new gain was found. When a
>> * non-zero value is returned, the @new_gain will be set to a negative or
>> * positive value. The negative value means that no gain could be computed.
>> * Positive value will be the "best possible new gain there could be". There
>> * can be two reasons why finding the "best possible" new gain is not deemed
>> * successful. 1) This new value cannot be supported by the hardware. 2) The
>> new
>> * gain required to maintain the scale would not be an integer. In this case,
>> * the "best possible" new gain will be a floored optimal gain, which may or
>> * may not be supported by the hardware.
> 
>> Eg, if ret is zero, there is no need to check validity of the gain_new but
>> it is guaranteed to be one of the supported gains.
> 
> Right, but this kernel doc despite being so verbose does not fully answer my
> question. What is the semantic of that "negative value"? 

Current approach is to always investigate the function return value as 
error if the 'new_gain' is negative. Or, caller specific error if 
new_gain is unsuitable in some other way. When this is done, the 
absolute value of the negative 'new_gain' does not matter.

> I would expect to have
> the error code there (maybe different to what the function returns), but at
> least be able to return it to the upper layers if needed.

I am not sure I see the benefit of returning the new_gain over returning 
the error returned by the function. Well, maybe the benefit to be able 
to not evaluate the value returned by the 
iio_gts_find_new_gain_by_old_gain_time() - although I'm not sure I love it.

> Hence 2 ARs I see:
> 1) clarify the kernel documentation there;
> 2) update the semantic of the gain_new to simplify caller's code.

Yes, I agree. Patches welcome :) By the very least the kerneldoc can be 
improved. I'm undecided on benefits of having the error code in 'new_gain'.

The GTS API fixes shouldn't be required in the context of this driver 
series though.

Yours,
	--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


