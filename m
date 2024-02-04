Return-Path: <linux-kernel+bounces-51692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E015A848E4B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393A91F21C0E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6A225CB;
	Sun,  4 Feb 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="MFv5cMT4"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20712260B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056060; cv=none; b=EQoj0FNFdGdsKO5zCm5MSu0umA/XID8KY44cX2S1wS5cYspPuyrGcSNy6c0jySS9psHorx2ka8T5MiA0f+ap9W8tJoEQQjPPtdndBRnzPEVbb8t0ccAX4FeH+TspRskZc85OoBvZayJIu02e+TdySOR0rgZRlw+AlnBxmAQmSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056060; c=relaxed/simple;
	bh=BBLc71fjdtvjI+LHH+sGQ5Vidu2XDxsETNSSU/puJh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oeezf4zkXw5Iyu4buPu/eiGJmSW/NA4L5Z53LQxtUCTvPqSnYAxTaV0N2389HjQ6dgHT+z8Vj+8nOZFeOnZCLPO44E4Mvsq9crO3/vnXiAhddVCnffS25viMW9YJBSsRIU4XqVm1lP3dMcBtfy+4a837Ad8u/on34Bv8Vq3JH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=MFv5cMT4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29041136f73so2392103a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707056058; x=1707660858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvruvwi3jJvlBp5XCxcLwwth2C60wtK6IXqcvX/W5c8=;
        b=MFv5cMT4+lOsFPLt00xbAYt5LOW1Beot4SJJ+ssD4XNPINeF6dNbuCM1CtV5CB0wqS
         C+6OZQYNriIP7Zccg8MuyRk3182JpUfbuv1I0Qa417r7sPYgJ39kEx5qafjFrtIFGFG/
         yEH6A1ss6IJWhEjTrIhR3xo8Wym1EGnWH8DIIqAtmPysGxlBsFVmG1LlhlhBCXw98qsA
         lMMqqirva0aap7xpBK1PXuXb7LAFkqP5n+wWmBQM51SgQX3LFtqdDLZJK+F9tkICzP1b
         nm1mUusrNn4OMoTzdnseTtHbHKTn1t77NXiDnDlWc5uSL4Is3DbyNoDGtesfVpPdNx6e
         GlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056058; x=1707660858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvruvwi3jJvlBp5XCxcLwwth2C60wtK6IXqcvX/W5c8=;
        b=YnrmZLpy6p4UXHWkD21BE1jzCgcA1kskadcQ14llfplLgXdPNMEZt18xQ6Rk/n6/xK
         pv4CvfWCSh9undEQuISzscJN9ZeRgzhA8s1JlpDfCJBpxz4OAAh/g1lX1Cml8kNzoffL
         yaZy+UohqDGxqkBfv+4G1WnR7I3pfKw3dVI/o6LuZvWARbLgiDfcnlEazqs2ZViMhvfV
         ZjClLP2SBeodLeTFOHbetvkz9CX5cqKnY5LpoV/OBXagI3d6umOX+zmk+TrTCXXwWfjA
         QYH60Da/7+rCPzDwal+3u9mFayci9gv5HSbmcHCr5ouFAVq7nX5D5SZfgGfzhYJRwkJK
         qaLw==
X-Gm-Message-State: AOJu0YwLAMxToM7O0ZFTqVZPTIuQnVjmnpBGG0PoR3jz7F972+cP3rm0
	i0dk9pO4pENQPuRPdwigfEsUpDNyf7s2VV2YsPw+/Ov+MGP/Zuyhoki7IyT+f3k=
X-Google-Smtp-Source: AGHT+IHQCyx3BOTmJwdxzIp3ersB5xq94ZNGRrBIsyJ2R1e4/JlWkELmciRxr0v94oSgGOmrthmQyg==
X-Received: by 2002:a17:90a:eb88:b0:296:3eb:d028 with SMTP id o8-20020a17090aeb8800b0029603ebd028mr5164916pjy.42.1707056058050;
        Sun, 04 Feb 2024 06:14:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaQxGWnXuJVptN1Ne5cxuzAcma+jSMr2hVfj/PcuunxTuH3g6nKlRrOcbwuNoH0+oEHvEqpnerePnypJDkx4gbZmO7V/inCHQN6CQXpkRQMvR9BCsZcczX0GKwGvi1StVUV9DmauDdJzQUtgFlbvP9UM9HNK9g96Na5pVJexVQ2zqhixB+iKHxyy/giU2BEQSboM0FCxRgUarpp0i3axMS1MHrVxrM1ratEuK0UiLLizXJ5Fxm2ixmOWpGknFspUuSZdadpREwj7ZwMr8MOO15WiPL2Af8hmnB84WMZj9fYor/EsYa1FC6HJdUXO2uRAOgUkkXcZOoY4yuP/hAFfLfsDJ6EtJ7rp0HfV/04fVUUAtHIp2cQY/w/VSuVmXoMnlt/eQbwAan1W2YXY3caHf6oU/lzxjA9i6FOZFmiVWx8QAFo1JOglC0WspwKPopy4cZFilI8elbbGSQpuSpDqki060zRt0AWGY63vniTsUUYt6Jmn5RUybcVa+vyu5877WjAQg=
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902c99200b001d91b617718sm4685818plc.98.2024.02.04.06.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:14:17 -0800 (PST)
Message-ID: <ad24703e-a1b8-4027-90df-bb6aef62058d@tweaklogic.com>
Date: Mon, 5 Feb 2024 00:43:13 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <20240121152332.6b15666a@jic23-huawei>
 <757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
 <fd404067-bc24-449c-94b4-f59a54c3f532@tweaklogic.com>
 <20240204134056.5dc64e8b@jic23-huawei>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240204134056.5dc64e8b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/24 00:10, Jonathan Cameron wrote:
> On Sun, 4 Feb 2024 21:53:55 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Hi Jonathan,
>>>>   
>>>>> +
>>>>> +static struct iio_event_spec apds9306_event_spec_als[] = {
>>>>> +    {
>>>>> +        .type = IIO_EV_TYPE_THRESH,
>>>>> +        .dir = IIO_EV_DIR_RISING,
>>>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>>>>> +    }, {
>>>>> +        .type = IIO_EV_TYPE_THRESH,
>>>>> +        .dir = IIO_EV_DIR_FALLING,
>>>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
>>>>> +    }, {
>>>>> +        .type = IIO_EV_TYPE_THRESH,
>>>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
>>>>> +    }, {
>>>>> +        .type = IIO_EV_TYPE_THRESH_ADAPTIVE,
>>>>> +        .mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
>>>>> +            BIT(IIO_EV_INFO_ENABLE),
>>>>> +    }, {
>>>>> +        .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>>>
>>>> What's the intent of this final entry?
>>>> The type will default to IIO_EV_TYPE_THRESH anyway but if that
>>>> the intent you should specify it.   There isn't an 'obvious'
>>>> default for type in the same way there sort of is for dir
>>>> (as it's either direction).
>>> Understood, let me experiment and see the ABI difference, if any and get back to you.
>>>    
>> This device has two channels - ALS and CLEAR. One interrupt enable option and
>> one Channel selection option (Clear or ALS). According to our previous discussions:
>> https://lore.kernel.org/all/20230415183543.6d5e3392@jic23-huawei/
>> the event_spec was updated to have two interrupt enable attributes - one for CLEAR and
>> one for ALS. (Intensity channel and Illuminance channel)
>>
..
>>
>> Please let me know if this sounds ok to you.
> Looks like coincidence of enum values being 0.
> It's really
> {
> 	.type = IIO_EV_TYPE_THRESH, /* Value 0 */
> 	.dir = IIO_EV_DIR_EITHER, /* value 0 */
> 	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> 
> Dropping 'defaults' for these things is fine if they are the obvious default
> or other parameters mean they aren't used, but that isn't the case here so
> please be explicit for all the values that are used.
> 
> You can put this final mask a few lines earlier as the other fields match
> anyway.
> 	{
>          	.type = IIO_EV_TYPE_THRESH,
> 		.dir = IIO_EV_DIR_EITHER,
>          	.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> 	},..
>
Thank you Jonathan. The above works as intended.

Regards,
Subhajit Ghosh


