Return-Path: <linux-kernel+bounces-84798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE1786ABC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F661F223D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D741364D2;
	Wed, 28 Feb 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pndiTzqz"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0B36AEC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114242; cv=none; b=nqpcJdLQwLOO0/eBNVk6+2F/zAjMQFG8kaHkMp1KIbr2pTDx6DUfrXKB/A0fJNoBmkzT31XFQy1PBV7riisbilxzQiBfgcIseR4k7kxUfeYJJogYwKXGqNaxEspDypgiBydggW7KL2lwCrL8ciGfzl8OJu3/CaPjjyLpC5JYDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114242; c=relaxed/simple;
	bh=5zb0cEnLWBBaB0oz5JTV/Xs/1lvchKi6jNvUzVpCoaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvLGr4J/VJOp1dwaI766LF6bzvdLppgEmYa/Xr6GFsEOetb+c2uDgr8I8gcO3sv2l6BsxdMr1eo1ifT7/Vz4ACdX7oScPU53yKJt+hFdSblTS7RlFoN5f7s6uVIXebGaDNT90I3nxxfjzbUIGBttKpXF/N2NMaX6OjNaCmD5F80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pndiTzqz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412b36b1b86so3703125e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709114239; x=1709719039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qg3bz6jhBZS7ET92hBbbxbLJcdz5hFSe7r4a1+zUYlM=;
        b=pndiTzqzKHx7fuXV0g6NZTdY8TEyqvkMIvH5MTaN7r/JCdt2/+YwX9dJqK+e9PQ/1Q
         u0wk6xayPWF4GGuViJ5sxvxNTC6tM+k4T3Gn1xLTTDUaEyTuu4cQ8IiIaOwrk7hOzYp/
         OB9sCtvIg30hK27H1bUT8TK8mszp/MJbetTrdQN+rqnwsr5eZ+gSaqFolA9Afq2+fleH
         DZ2Drz72ChMJ5qjoxiE4s0dHycJ/He4JCHAKOoWErACnKoZRj5H9o27u0gxY8e0/smnw
         9wxS4V+9oX0Ms2rYm1D39ClkzP6+y1u0lA2JbMGhOFZZJj7eZrna7YNxfXGW4c4tP76v
         laxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114239; x=1709719039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qg3bz6jhBZS7ET92hBbbxbLJcdz5hFSe7r4a1+zUYlM=;
        b=vHqO4otyXai4Lyv8uviDmDid9U2H5UCIqSyA46YRw4fkHqkBnTWiq+5Dt3kjIoSFAY
         R+91VwaVySBeyMBp4piayzAHQ1JI+VhvLOB8aCmHGlSLDrHSnG/2riLd5yTupEPYaxDV
         yvIRxBaT7TF3+L40FSfPSZoNLXe8+eDMyZC3+LBhBxUEO2VzReNVY5xIO6K/8k5OjAfh
         IQJGK1LHVJNhEyvtDajFmeGnizfuLL+HIBUQ/RGL/cXYyMQSHjbt3dpY1BoChYo8qjA/
         b/eI6i5X6//mWCc7ujTLF3qR90ReoBs3olG1h9lVcxayOgphO+tQoxKWCCBXJeVwNu1q
         1zqA==
X-Forwarded-Encrypted: i=1; AJvYcCXesRQCsLriQKKA4soq6qAGj1plHv0uRw5RI5tcVdNLIsn80oxNTkWdqM5TJYOm2uwpbSlwvuEdAyljP+bJ8RWi/Esk7PRZ4A7UDtmz
X-Gm-Message-State: AOJu0YyzVCKAQ+OKPPJ/SRTuGiATly88+nZFr6jnwbz/gY+91XtVYmpj
	+mr/W45DRmKxFzYKoT8WpuaWXKRg3iKl+qh6Tma8Fznz0tRwXw4Wd0O7o6xP5wQ=
X-Google-Smtp-Source: AGHT+IGdYYc+4l8lA19KSveVtxa+iJnXttf25DgJgoEb24NGtWPvG7/6OUbeiGefYFJlE7T6JjPt3Q==
X-Received: by 2002:a05:600c:3b9d:b0:412:b623:bbcc with SMTP id n29-20020a05600c3b9d00b00412b623bbccmr529089wms.10.1709114238861;
        Wed, 28 Feb 2024 01:57:18 -0800 (PST)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b00412b3bf811bsm1537547wmq.8.2024.02.28.01.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:57:18 -0800 (PST)
Message-ID: <66e527af-0253-4565-9822-04ed84e5817c@baylibre.com>
Date: Wed, 28 Feb 2024 10:57:16 +0100
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
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
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <bd4bf6ae-350e-4ee6-a924-7dd31b2c6034@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I think I got it.

- mediatek,i2s-shared-clock: will be remove from DT
- mediatek,dmic-iir-on: will be remove from DT
- mediatek,dmic-irr-mode: will be remove from DT
- mediatek,dmic-two-wire-mode: rephrase description needed

I've did abstraction (despite me) that IIR settings are runtime config 
because the driver implement its usage like a one-time-setup -_-'

Thanks for the explanations, that help.

Regards,
Alexandre

On 28/02/2024 08:28, Krzysztof Kozlowski wrote:
> On 27/02/2024 16:18, Alexandre Mergnat wrote:
>>>
>>>> +    type: boolean
>>>> +
>>>> +  mediatek,dmic-iir-on:
>>>> +    description:
>>>> +      Boolean which specifies whether the DMIC IIR is enabled.
>>>> +      If this property is not present the IIR is disabled.
>>>
>>> "is enabled" or "enable it"?
>>>
>>> You described the desired Linux feature or behavior, not the actual
>>> hardware. The bindings are about the latter, so instead you need to
>>> rephrase the property and its description to match actual hardware
>>> capabilities/features/configuration etc.
>>
>> I will rephrase:
>>
>> True to enable the Infinite Impulse Response (IIR) filter
>> on the digital microphone inputs.
> 
> I still don't know why this is DT-specific. You still tell driver what
> to do...
> 
>>
>>>
>>>> +    type: boolean
>>>> +
>>>> +  mediatek,dmic-irr-mode:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      Selects stop band of IIR DC-removal filter.
>>>> +      0 = Software programmable custom coeff loaded by the driver.
>>>
>>> Bindings are for hardware, not drivers. Why is this a property of board DTS?
>>
>> Actually this is a hardware feature. Mode 1 t 5 are predefined filters.
>> Mode 0, the HW will read some "coef filter registers" to setup the
>> custom filter. the "coef filter regs" are written by the driver.
>> Currently the coef values are hardcoded in the driver.
> 
> You don't get the point. Just because you choose some mode it does not
> mean is hardware feature for DT. Sampling frequency done by hardware is
> also "hardware feature", but do you put it to DT? No.
> 
> Explain why this is board-specific, not runtime configuration.
> 
>>
>>>
>>>> +      1 = 5Hz if 48KHz mode.
>>>> +      2 = 10Hz if 48KHz mode.
>>>> +      3 = 25Hz if 48KHz mode.
>>>> +      4 = 50Hz if 48KHz mode.
>>>> +      5 = 65Hz if 48KHz mode.
>>>
>>> Use proper unit suffixes - hz.
>>>
>>>
>>>> +    enum:
>>>> +      - 0
>>>> +      - 1
>>>> +      - 2
>>>> +      - 3
>>>> +      - 4
>>>> +      - 5
>>>> +
>>>> +  mediatek,dmic-two-wire-mode:
>>>> +    description:
>>>> +      Boolean which turns on digital microphone for two wire mode.
>>>> +      If this property is not present the two wire mode is disabled.
>>>
>>> This looks like hardware property, but the naming looks like SW. Again
>>> you instruct what driver should do. Standard disclaimer:
>>>
>>> You described the desired Linux feature or behavior, not the actual
>>> hardware. The bindings are about the latter, so instead you need to
>>> rephrase the property and its description to match actual hardware
>>> capabilities/features/configuration etc.
>>
>> Actually this is a hardware feature. This is ALL I have to describe the
>> HW behavior from the datasheet:
>> "
>> bit name: ul_dmic_two_wire_ctl
>> Turns on digital microphone for two wire mode.
>> 0: Turn off
>> 1: Turn on
> 
> That's rather suggestion it is not a description of hardware but you
> want driver to do something...
> 
>> "
>>
>> On the board schematic, SoC and DMIC and linked by 3 pins:
>> - clk
>> - data0
>> - data1
>>
>> IMHO, "two-wire-mode" means the HW use 2 pins for data, and the SoC must
>> be aware of that by reading the register value written by the driver,
>> using the value found in the DTS.
> 
> So this depends on type of connection of DMIC? Then rephrase description
> property like this.
> 
>>
>> I don't get why you think it wouldn't be hardware behavior.
> 
> Because telling what to write to the registers which is typical sign of
> people stuffing to DT whatever they need to configure the hardware.
> 
>>
>> Rephrase description:
>> "True to enable the two wire mode of the digital microphone"
>> Is it better ?
> 
> No, because again you describe some sort of mode. If you insist on such
> description, then my answer is: it's runtime, so not suitable for DT.
> Instead describe what is the hardware problem/configuration, e.g. "DMIC
> is connected with only CLK and DATA0, without third pin" etc.
> 
>>
>> About the property name, "mediatek,dmic-two-wire-ctl" sound better for you ?
> 
> To sound more like a register less like physical characteristic of the
> board? No. The name can stay, I don't have better ideas.
> 
> 
> Best regards,
> Krzysztof
> 


