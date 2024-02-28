Return-Path: <linux-kernel+bounces-84956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A371786AE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26BAB2778F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56373534;
	Wed, 28 Feb 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="COSUTH52"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42A73532
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120890; cv=none; b=JAb1HvW16MRDzsVxat9ASsTN5LKM/nQmkjbsr3+6MhDn5GXPcT+JaeOo9Hp0qrSKvFqrGbxmke+Ee1GiT9i5C838vDCSUtw9WKL7b9iEWZkDMLhLVVzCaAchJO/v/pDhaasLLh8EFSFhBOGu/AkeX+b0es6/Vo8KEsdeYttM/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120890; c=relaxed/simple;
	bh=efAhC9hRP8H3lGnTm4GfEFicpOrPdhSIcMulUBDXTn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muj6PrXcYTtZitoNyZVN46E9++sWhkAIZHblLTnNKXNZVHc8FdUo1hY5Jqiup9XlUPb27DnwyDwW0wuUbV60zbMzryDUPPqQURap0JpcZH6jgxEG5dc2yYFSAGWhqa0NsZ8zpaL79v0sYZad60HevUSGFNGpJwDZS9D9DmLc2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=COSUTH52; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392b12dd21so4312675f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709120886; x=1709725686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu3ewqCG+5EQn7RzZWf4wxjkdVeCPYXJSPVh/ZEGpuY=;
        b=COSUTH52myYonC9p1wVFPrp122+Ej5uX81zZb445ewbgzlXj1AbYaVKub8slgHwWhv
         jxcqhxjczBC+Q1AHXz8rdROkB2WN+8oJ87srSMU5WgfM3NrhEYm7FOLYZC0oB3WQVICx
         pWSPUyflkKpWY5SpvK5p0x2SznbJTWoyNGAhrzKuLN9tDvrxB8dWehztcZpORmWKrcoG
         b2QQOkMKRHLkIMyQJeq/7W9hfTQhc2kEpocBM4CL5BmGIiWCKDBWzk+LAiUE4UnWqPVe
         aR60oHEvSY4YfSI+WT2PMqN2GR8zeaz4TC4wWf6DY1N2C/kz+3CH94BQ9yLCJgI0uOiB
         kDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120886; x=1709725686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu3ewqCG+5EQn7RzZWf4wxjkdVeCPYXJSPVh/ZEGpuY=;
        b=iCpPjxrFgDggIN14IUTRUyC3YK1K/NGwgypfayHxW3Ol0YYwO3kTZlU88mzvre6R5H
         Q7Zp7pFox0dRottQxRr4eHqAgszVr/2ciecEJO/C6tz87hh/g5sQ0pTHg6egJcT3iPKv
         58lR3/lPHeWCxldU8y0jZy86SwrwEZUwkRgC3RKudjisn3ZDH0XJlvTIF4jYXGbb56cG
         K62YkMUDVmd5E5txcyMyoONUl4SbHZrF0JoMx+szQkGcjIU3KtQdx0DqTQ+vgnhvUnqw
         LZcL3H43ZPBUP1oyxomIAf4r7N7r5UruzC4FVD0ZRi1Kwx5bxWbcxp8S80lCZUAiBsVr
         pnUA==
X-Forwarded-Encrypted: i=1; AJvYcCX+CaP05NRumkhPriNrskn+B5iWH0jnPFrnGV+sRrXr7Tqo5XG6JPFohKJt2Cxlf3E2NMFOaUMZIiBgUtKx5hOZQvN5PNhlD/KXp/dl
X-Gm-Message-State: AOJu0YzfiSSN/1XYWH8fQHOS3O1lsaNtMpmrCKans7u4e9+9sy1u5Yis
	VHiQPuVYnkhcLIwJkeEQ/ddfWyM8kFRwdJlPse05+BkUYpJQ+ylMoFeTSoGbRW4=
X-Google-Smtp-Source: AGHT+IEB/UQwleJbf7XKW6dc1tBjhAXHjTKhYWiBK169zurfst+bdJvN4ZyFBulks3zB3QHX3zW7pQ==
X-Received: by 2002:adf:fd44:0:b0:33d:277d:a2c7 with SMTP id h4-20020adffd44000000b0033d277da2c7mr7855219wrs.16.1709120886505;
        Wed, 28 Feb 2024 03:48:06 -0800 (PST)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id bo14-20020a056000068e00b0033d6bc17d0esm15009877wrb.74.2024.02.28.03.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:48:06 -0800 (PST)
Message-ID: <a4ba6a35-cfb4-4c3d-a9c7-ccd47d4c32d8@baylibre.com>
Date: Wed, 28 Feb 2024 12:48:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] ASoC: dt-bindings: mediatek,mt8365-afe: Add audio
 afe document
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-1-4fa1cea1667f@baylibre.com>
 <ce5f71a9-1b5f-4724-89db-dae2f64e8008@linaro.org>
 <eeb3329b-0558-4237-8343-4e11f65a6a35@baylibre.com>
 <bd4bf6ae-350e-4ee6-a924-7dd31b2c6034@linaro.org>
 <66e527af-0253-4565-9822-04ed84e5817c@baylibre.com>
 <bb86b986-ecd7-416a-9036-082a3cff2176@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <bb86b986-ecd7-416a-9036-082a3cff2176@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28/02/2024 11:25, AngeloGioacchino Del Regno wrote:
> Il 28/02/24 10:57, Alexandre Mergnat ha scritto:
>> I think I got it.
>>
>> - mediatek,i2s-shared-clock: will be remove from DT
>> - mediatek,dmic-iir-on: will be remove from DT
>> - mediatek,dmic-irr-mode: will be remove from DT
>> - mediatek,dmic-two-wire-mode: rephrase description needed
>>
>> I've did abstraction (despite me) that IIR settings are runtime config 
>> because the driver implement its usage like a one-time-setup -_-'
>>
> 
> Yes but just one more thing I just noticed: 
> `mediatek,dmic-two-wire-mode` - can we
> please rename this to `mediatek,dmic-mode` ?

Sure, I wasn't aware of this property. I will do it.

Note: the description isn't consistent with the enum comments
"
0 means two wires, 1 means one wire.
..
        - 0 # one wire
        - 1 # two wires
"

> 
> That'd be for consistency check mt6359.yaml and mt6358.txt
> 
>    mediatek,dmic-mode:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
>        Indicates how many data pins are used to transmit two channels of 
> PDM
>        signal. 0 means two wires, 1 means one wire. Default value is 0.
>      enum:
>        - 0 # one wire
>        - 1 # two wires
> 
> Cheers,
> Angelo
> 
> 
> 
>> Thanks for the explanations, that help.
>>
>> Regards,
>> Alexandre
>>
>> On 28/02/2024 08:28, Krzysztof Kozlowski wrote:
>>> On 27/02/2024 16:18, Alexandre Mergnat wrote:
>>>>>
>>>>>> +    type: boolean
>>>>>> +
>>>>>> +  mediatek,dmic-iir-on:
>>>>>> +    description:
>>>>>> +      Boolean which specifies whether the DMIC IIR is enabled.
>>>>>> +      If this property is not present the IIR is disabled.
>>>>>
>>>>> "is enabled" or "enable it"?
>>>>>
>>>>> You described the desired Linux feature or behavior, not the actual
>>>>> hardware. The bindings are about the latter, so instead you need to
>>>>> rephrase the property and its description to match actual hardware
>>>>> capabilities/features/configuration etc.
>>>>
>>>> I will rephrase:
>>>>
>>>> True to enable the Infinite Impulse Response (IIR) filter
>>>> on the digital microphone inputs.
>>>
>>> I still don't know why this is DT-specific. You still tell driver what
>>> to do...
>>>
>>>>
>>>>>
>>>>>> +    type: boolean
>>>>>> +
>>>>>> +  mediatek,dmic-irr-mode:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description:
>>>>>> +      Selects stop band of IIR DC-removal filter.
>>>>>> +      0 = Software programmable custom coeff loaded by the driver.
>>>>>
>>>>> Bindings are for hardware, not drivers. Why is this a property of 
>>>>> board DTS?
>>>>
>>>> Actually this is a hardware feature. Mode 1 t 5 are predefined filters.
>>>> Mode 0, the HW will read some "coef filter registers" to setup the
>>>> custom filter. the "coef filter regs" are written by the driver.
>>>> Currently the coef values are hardcoded in the driver.
>>>
>>> You don't get the point. Just because you choose some mode it does not
>>> mean is hardware feature for DT. Sampling frequency done by hardware is
>>> also "hardware feature", but do you put it to DT? No.
>>>
>>> Explain why this is board-specific, not runtime configuration.
>>>
>>>>
>>>>>
>>>>>> +      1 = 5Hz if 48KHz mode.
>>>>>> +      2 = 10Hz if 48KHz mode.
>>>>>> +      3 = 25Hz if 48KHz mode.
>>>>>> +      4 = 50Hz if 48KHz mode.
>>>>>> +      5 = 65Hz if 48KHz mode.
>>>>>
>>>>> Use proper unit suffixes - hz.
>>>>>
>>>>>
>>>>>> +    enum:
>>>>>> +      - 0
>>>>>> +      - 1
>>>>>> +      - 2
>>>>>> +      - 3
>>>>>> +      - 4
>>>>>> +      - 5
>>>>>> +
>>>>>> +  mediatek,dmic-two-wire-mode:
>>>>>> +    description:
>>>>>> +      Boolean which turns on digital microphone for two wire mode.
>>>>>> +      If this property is not present the two wire mode is disabled.
>>>>>
>>>>> This looks like hardware property, but the naming looks like SW. Again
>>>>> you instruct what driver should do. Standard disclaimer:
>>>>>
>>>>> You described the desired Linux feature or behavior, not the actual
>>>>> hardware. The bindings are about the latter, so instead you need to
>>>>> rephrase the property and its description to match actual hardware
>>>>> capabilities/features/configuration etc.
>>>>
>>>> Actually this is a hardware feature. This is ALL I have to describe the
>>>> HW behavior from the datasheet:
>>>> "
>>>> bit name: ul_dmic_two_wire_ctl
>>>> Turns on digital microphone for two wire mode.
>>>> 0: Turn off
>>>> 1: Turn on
>>>
>>> That's rather suggestion it is not a description of hardware but you
>>> want driver to do something...
>>>
>>>> "
>>>>
>>>> On the board schematic, SoC and DMIC and linked by 3 pins:
>>>> - clk
>>>> - data0
>>>> - data1
>>>>
>>>> IMHO, "two-wire-mode" means the HW use 2 pins for data, and the SoC 
>>>> must
>>>> be aware of that by reading the register value written by the driver,
>>>> using the value found in the DTS.
>>>
>>> So this depends on type of connection of DMIC? Then rephrase description
>>> property like this.
>>>
>>>>
>>>> I don't get why you think it wouldn't be hardware behavior.
>>>
>>> Because telling what to write to the registers which is typical sign of
>>> people stuffing to DT whatever they need to configure the hardware.
>>>
>>>>
>>>> Rephrase description:
>>>> "True to enable the two wire mode of the digital microphone"
>>>> Is it better ?
>>>
>>> No, because again you describe some sort of mode. If you insist on such
>>> description, then my answer is: it's runtime, so not suitable for DT.
>>> Instead describe what is the hardware problem/configuration, e.g. "DMIC
>>> is connected with only CLK and DATA0, without third pin" etc.
>>>
>>>>
>>>> About the property name, "mediatek,dmic-two-wire-ctl" sound better 
>>>> for you ?
>>>
>>> To sound more like a register less like physical characteristic of the
>>> board? No. The name can stay, I don't have better ideas.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 

-- 
Regards,
Alexandre

