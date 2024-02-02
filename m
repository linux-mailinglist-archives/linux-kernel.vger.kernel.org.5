Return-Path: <linux-kernel+bounces-49951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52898471EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504DAB2B027
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497481420CB;
	Fri,  2 Feb 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLfoRWuy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90D47A4D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884150; cv=none; b=i7sG5UgaQiHAsQxGkSMvhBQMPVU/a20xdVJp0PNUpriDkY40th7E0bdVHtND2cEItYYLvk3U21PcEz8JLZunGgA9Xoxz/+PzbmcYiGZ8ILg0xU+78sDTGvGH2StQMvk8d/h0RktubOXZMoa4Wtv85aHlN1xq2iftXPOhEhD7bcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884150; c=relaxed/simple;
	bh=KmkEJoWpPZfJLl7ucyDRbsx1W5IuGT68hZZ84FvVKKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+paYjN+N6/GRW9JqiBjes+f5uLCaYk1pO2skyn93S3FDAvTAmqOdgs4J1iC8RgkwAOWxNiwvuVndaG2/K5AHz+83tiVzCws71c62wRYvqfuAQd8Ul92NvB/lSEZvySAfOrKttPDWJYCMM7NZOKSfIaRrbRH+NzyuZ6W3qOt9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLfoRWuy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so1865898a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706884146; x=1707488946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dS+eJDChsP0VAsf3BNvnQXhDaUlqagLQtm6MOX5SrVE=;
        b=pLfoRWuy5XBCuA+PJDgJXFeO7EYdAVFD1PaTOLMiJKY6cr+N4YUN3DW95WI2HCtWlH
         I9Rv7wG/mlrAWw6Wb8mJnCP/kayz1lPUTz9PuUEMxAfHty2MX1RaOl03MHmP7kKyLEG9
         l4N9QP/0eHQqLjERYByb8E4OGCL9dbOoUA2Fssd5fCFLd76hojo6YT8OWKjcbXLg1Fss
         XY2LmtwhKVNYGzinvhz2kRS1O1tYzyv2ZsyyPpC8tiLTcR99tEK98P6QboylfPlE4sKc
         Umok9bESGTgkGXqogY5poIkxQHdf5A4RjpaZJL61l1IM1Byr0JmxbdHAHMHIqPy+n2LP
         SESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884146; x=1707488946;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dS+eJDChsP0VAsf3BNvnQXhDaUlqagLQtm6MOX5SrVE=;
        b=IjEHMYjfiaxsRhGbBKfm3OEFfmZGNg0DkPHvGMgVJiLP3F+2vNp8plBemdw1EeKIY+
         IvOm85JjAgkX/z1gnp4Xr/Nrp8bcIGO1JgndhC9ezLig1xejQoihXdKIJIsSAVO8AemU
         hPdaqT/VGfv+7vD1MXdZBbf4c2iyzxAyvFoXOQg7aoIe0XyfV/+ASf5JOwv3iHIhFZ5F
         id5zUBSkhmlgnpWD4NUiVBNjAOCrWyXNnEc4P8AH5hEe7H1XuoMPOKYTnDNStjlGogDD
         VC9qdfHpWlDMQmfB+Bs+wr/5iSY4tcYnxMueHuuBzXpq4TAzkMrPJPGKf520vFTz/LyV
         TTxQ==
X-Gm-Message-State: AOJu0Yxu00YFtR+sP9l1F96mLNgO4Qo4FtB2buGdP9Gdo7Ck8JGvkpU6
	1kd9bOhZjcHRyt9sGU5NRnb21dljawwQFSwy8KUwTGxWm23kup15Xw18p29+cUo=
X-Google-Smtp-Source: AGHT+IF757oZyNsfZhRPBiYIla2L7JGHhUehBJ/XdiqfUTIIt0Pgj6JaMFa/vG7ie7BXq9/hZUo6ow==
X-Received: by 2002:a50:8d57:0:b0:55f:2f0a:d959 with SMTP id t23-20020a508d57000000b0055f2f0ad959mr5475763edt.37.1706884145637;
        Fri, 02 Feb 2024 06:29:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1e+rhYZBEFqu+sn8vJn5/aWHRoH6V+QjQoJOjH3xjLv4RqAlklmyGEYKivMUtWSnwbJRMytXepVMdOdr0czwDVPnBnpqIsKY6hJeoh9t+gQBQXF6gDhfsYA7n4UZcCVLArlq7NOKRKySQ4GLZ4pVdKVAhrugT90k4/8Ia/YfeDvazrGd9ur3w8zu6wYXimPpN0EKyanST7QGmZ746P63vyBibU0ctdtzRjD0krY8lJOHEL+7EKGUkifMGb2dWNtFSlZOXIpiochofOv502/LaObjUwj4gwUAfDsQuyjyrp7Lz2f2deIMsdtgNff77bvuI0Ivh6K4mQGZuKMbBifSTXLZBEc+Qbj9tO0ewzxbN+Mu92EoouYN1aaBIcF7FJcwGM639CntPi+9afw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id en12-20020a056402528c00b005598ec568dbsm850002edb.59.2024.02.02.06.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 06:29:05 -0800 (PST)
Message-ID: <ff3bfbd3-1347-4661-b2af-60951e0a8a83@linaro.org>
Date: Fri, 2 Feb 2024 15:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7192: Add properties
Content-Language: en-US
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231114200533.137995-1-alisa.roman@analog.com>
 <20231114200533.137995-2-alisa.roman@analog.com>
 <c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
 <09cc2ecb-b73f-495a-9196-dbb4899f4c85@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <09cc2ecb-b73f-495a-9196-dbb4899f4c85@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 15:14, Alisa-Dariana Roman wrote:
> On 14.11.2023 22:29, Krzysztof Kozlowski wrote:
>> On 14/11/2023 21:05, Alisa-Dariana Roman wrote:
>>> Document properties used for clock configuration.
>>
>> Some background here is missing - otherwise it looks like you are adding
>> new properties...
>>
>>>
>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>> ---
>>>   .../devicetree/bindings/iio/adc/adi,ad7192.yaml        | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> index 16def2985ab4..9b59d6eea368 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> @@ -80,6 +80,16 @@ properties:
>>>         and when chop is disabled.
>>>       type: boolean
>>>   
>>> +  adi,clock-xtal:
>>> +    description: |
>>> +      External crystal connected from MCLK1 to MCLK2.
>>
>> And this should be input clock.
>>
>>> +    type: boolean
>>> +
>>> +  adi,int-clock-output-enable:
>>> +    description: |
>>> +      Internal 4.92 MHz clock available on MCLK2 pin.
>>> +    type: boolean
>>
>> This should be clock-cells and clock provider.
>>
>> Unless you are just documenting already used interface which you do not
>> want to break...
>>
>>> +
>>>     bipolar:
>>>       description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
>>>       type: boolean
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thank you very much for the feedback!
> 
> If I understand correctly, there is already an input clock in the bindings:

You tell me...

> 
> What I wanted to accomplish with this patch is to document these boolean 
> properties (from the ad7192 driver code):

Please explain with clear words: do you mean that existing upstream
Linux driver has it? I don't care about some out of tree drivers...


> ```
> 	/* use internal clock */
> 	if (!st->mclk) {
> 		if (device_property_read_bool(dev, "adi,int-clock-output-enable"))
> 			clock_sel = AD7192_CLK_INT_CO;
> 	} else {
> 		if (device_property_read_bool(dev, "adi,clock-xtal"))
> 			clock_sel = AD7192_CLK_EXT_MCLK1_2;
> 		else
> 			clock_sel = AD7192_CLK_EXT_MCLK2;
> 	}
> ```
> 
> Please let me know how to proceed further!

Please open the datasheet of your product and add properties matching
the hardware, not driver.

I don't know what to say more except the same - you want to enable clock
provided from this device on some pin to some other devices? If yes,
then this is clock-provider, so you clock-provider bindings I mentioned
in my first reply.

Best regards,
Krzysztof


