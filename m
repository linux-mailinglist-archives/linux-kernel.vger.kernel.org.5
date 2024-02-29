Return-Path: <linux-kernel+bounces-86720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C186C99B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DF428A2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE737E0F8;
	Thu, 29 Feb 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg4hl8an"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3EE76F1B;
	Thu, 29 Feb 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211537; cv=none; b=XEUUZmL/qnKlSmc0OOjhJfpOcM58vYVVVu8kr4KGvPvv46Tj5K6bi5npt6DVQzhXE1BqTD350KX0GJbG9eYt3t2wtJfRyMgfBJqQrybXU3hwRdHsEcL9odB1FZcnFOYbo3LNaGicSvSjHjeDQWg1u/fnaxGgziJJ/B3F8JhEhPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211537; c=relaxed/simple;
	bh=KOh+phYAIWqtdZQzCphp0ougyGQMtiMNT0muex48X4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrzLfFdN6Gr43B/fjCbBS1xl03F2lbB/3Z0BmegniadyFKXDoyJ3kwweeI93qOD53e1cYEklQ92BhiXzGzwyLH4VGctenhSDyCuopL6pAFgMAGC6TYcP+DTfYUQ6fRCsqvKjjltcjxYJlkdj4KH6HZbllS2avgABvfHtgmP1lcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg4hl8an; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131d0c3517so806963e87.1;
        Thu, 29 Feb 2024 04:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709211534; x=1709816334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgYtYGuZfV84qaENov2D/kXc9sJYLcl1APfQ6CZvyjs=;
        b=Kg4hl8anpl1ZUcAM7jTypq3XFbtYc0EVCr/r6NTDJLOC+C8HHAaDj17LH90vtSBL9c
         NtUHpJXbRVogZ4A6NwStK28PmUaogrJW1f09n+nVgYwPN0SPVhLaHNUhTpqjs9srg878
         nYBVL8tFJejpkEYfoSrOC2lD8rNn/ZreUn+8OMF4ebLJ/soCrLUKlWEFxfnqeAs0xH7X
         5g+mraOKtCMk/3KmpJxoZHEefK9QQ58RRCCz8rhd6znBub2nJbPU4P56ort3sF75kD8x
         v6wCLVAASaw8KET+Q9Nl+5X9GapxZTD1WGZrW9DBArkVCPqOjqlK7EB7qJDnW04MxgwN
         JKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211534; x=1709816334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgYtYGuZfV84qaENov2D/kXc9sJYLcl1APfQ6CZvyjs=;
        b=Bz3iwhTLJHYOxaYMkefynX9SwFrx1PPRtpx+ysLMkAEbYE0PO8HuuwNH1HonxyQgUO
         1z3fIyKCesPkRwYxzNSwZGuRU89MDbswMtbIJ5GDWwBL0saV7W2RviGtGwllL/fPXjxV
         uIjY3Y6o4pZOvDtKH0bjuBOIxAse4/RSlmmzhhfRsdblSNcX7XugtZeIp4wMfhTASj+B
         dgcYjfCBsKQeOI+sXJHdvu2Nxw/QAM0+U2n1rA9xO2k9pHoohJ8sJgkUE9GDg/+VfZpU
         o360sdWnOiL+E0f6SEQDsFguWxYWJQMJdJoFUJQbsaTK6tbUa/72GfR1vlxBi+8SajBf
         uHSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDY98ghT3aESLWwbBxrryKPbbWeHyh6ytfoaRAyICVmhPku9vQla8nbB6gpTo/J65lfkPxed1qZRbwynDmY/DBlofz8KiJAt2nSP8m55DfNha5IJ0PyBAymxJnXjcjxm4ryyy9KXWiTVx2ebfXcEKqOHYhHyQyTylzGEi9kmCVV8sPQw==
X-Gm-Message-State: AOJu0Yz0a60jldBkLvxB4VlkpRfjddlSAIQM0J2sz8vdIgbfJ8CDC552
	o2j6O/rsA6nuLWNoyh8D8irH1KxFbLI99KAH1omcXg1WLrZtKp2G
X-Google-Smtp-Source: AGHT+IEyW1m/9YnwrYDfRxrRjunohQlk0TK2UjwpkcF/N0Ps8ohrRdOYDH3ntrIr48zQjavH9UAbig==
X-Received: by 2002:ac2:5923:0:b0:513:1a45:b1bf with SMTP id v3-20020ac25923000000b005131a45b1bfmr771259lfi.16.1709211533857;
        Thu, 29 Feb 2024 04:58:53 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id s22-20020a197716000000b00513201eeab5sm243830lfc.123.2024.02.29.04.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 04:58:53 -0800 (PST)
Message-ID: <21ecfb62-30b7-4073-bad6-46a9e08e08b0@gmail.com>
Date: Thu, 29 Feb 2024 14:58:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
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
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <45386f39-a034-4d70-a6d4-8804c27aadce@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/29/24 14:34, Subhajit Ghosh wrote:
> On 29/2/24 03:57, Andy Shevchenko wrote:
>> On Wed, Feb 28, 2024 at 03:08:56PM +0200, Matti Vaittinen wrote:
>>> On 2/28/24 14:24, Subhajit Ghosh wrote:
>>
>> ...
>>
>>>> +    ret = iio_gts_find_new_gain_by_old_gain_time(&data->gts, gain_old,
>>>> +                             intg_old, val2, &gain_new);
>>>
>>> You don't use the 'ret' here, so maybe for the clarity, not assign it.
>>> Or, maybe you wan't to try to squeeze out few cycles for succesful 
>>> case and
>>> check the ret for '0' - in which case you should be able to omit the 
>>> check
>>> right below as well as the call to iio_find_closest_gain_low(). OTOH, 
>>> this
>>> is likely not a "hot path" so I don't care too much about the extra 
>>> call if
>>> you think code is clearer this way.
>>>
>>>> +    if (gain_new < 0) {
>>>> +        dev_err_ratelimited(dev, "Unsupported gain with time\n");
>>>> +        return gain_new;
>>>> +    }
>>
>> What is the difference between negative response from the function 
>> itself and
>> similar in gain_new?
>>
> -ve response form the function is an error condition.
> -ve value in gain_new means - no valid gains could be computed.
> In case of error conditions from the function, the gain_new is also set 
> to -1.
> My use case is valid hardware gain so I went for checking only gain_new.
> Matti will be the best person to answer on this.

I now rely on the kerneldoc for the
iio_gts_find_new_gain_by_old_gain_time() as it seems reasonable to me:

* Return: 0 if an exactly matching supported new gain was found. When a
* non-zero value is returned, the @new_gain will be set to a negative or
* positive value. The negative value means that no gain could be computed.
* Positive value will be the "best possible new gain there could be". There
* can be two reasons why finding the "best possible" new gain is not deemed
* successful. 1) This new value cannot be supported by the hardware. 2) 
The new
* gain required to maintain the scale would not be an integer. In this case,
* the "best possible" new gain will be a floored optimal gain, which may or
* may not be supported by the hardware.

Eg, if ret is zero, there is no need to check validity of the gain_new 
but it is guaranteed to be one of the supported gains.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


