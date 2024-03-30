Return-Path: <linux-kernel+bounces-125817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D1892C94
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41C91C216A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F682E3F9;
	Sat, 30 Mar 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKAbD/D8"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1C1FB2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823818; cv=none; b=QjpuOTQ/+up7T/p3qknq3aoLBvDo/0PkShisNM0b3f3I2F8w8nc95XuJ1UlmI8cBDgdsmxu4EjKLiHn7OMSq10GsmcONA1svVuCijA7XO46ZDgQZF1UawvYNrZpPchL6yrm/5DROtJ8TtyXGGfn/meIT7Ym/O4WxUy60qI+mAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823818; c=relaxed/simple;
	bh=mMHX/D7lliivA6UWGEQ+mSk0LY+Wg5ljj95nA7UCmE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hl/uZvayFmMKHUBk7Ni6nO+u2MO0ldmMX6Z++HFIbbIwUoDylQEJo5g3XuQLBMP3VqZEVp3Nam228EOE+2ZJIY7EgJRuzokl1Jh7F9dKBoCoAwx2wM/SIForDluTx3zWQMGZKL+kIJ5zmP5661qMTRtBmcY4VhJNEEKoAKtHFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKAbD/D8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4154464f150so14620105e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711823815; x=1712428615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2epNLcqYlDDxFlqorb7Cjat3BktL4sasPGtCRb+vLrQ=;
        b=WKAbD/D8LsQsykF1lz+B2JOa1bV1BY2jHzY2GGMZCZL56kDvVy2ZIriFySc8PQT3DJ
         w/85xXp9II8wGHoJSt2t+Oey+Hevfax1bBmAh+E7Jb+Rva038XnMW1OPjj80czHHPb1H
         JFCAhGmZOFeKGkYL9V3XMMfWIo2B0hzqWTLOx4vWAL+ZOOcvVM4GM6ihF5ACAnV/VgEk
         Oxxg16sD3SSgBQl+0zqPHBzoqePnIBp0xoW+Lu5p5GqG60e/3+1RQUHfd3WjtparFeZk
         3jwJx+VA7a01DAcWrnq61LyW7cNxyxU1LMOFxGrlWmD2D0yzQiVLrbkqhhCSumzF03SN
         mlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711823815; x=1712428615;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2epNLcqYlDDxFlqorb7Cjat3BktL4sasPGtCRb+vLrQ=;
        b=dnYQygFJuxI3n9ocToGyxPlwQCaIRGfWxeTVpK6Xg+8caFmJmK9jaGn9CR8+xdhMDf
         pH25kJPFM/G2u24K+3xHgCCv3uqSEkoE0+ldL3qtIPEB33TU7cYYAUkHFKg7hkDnFfZ0
         7ShZuCc03OpfoDcUIKaYn/tMXyupa5/ahRqibCUlNNgNo9AEzX8mixkxf9nKt5+Ts8Dv
         r/9T0lqGZ05TUCX3UzlRbicptjrHs8wvnMBQmjr725K+T30mCVqo0ToTN5jlKgwaWQfk
         c5RWRiUdQ8aigckw4Whdkt81FNVPpBYsYwAtv76ZbY3Qyn5eFdTv/fXeh806hyIvyky7
         hCZA==
X-Forwarded-Encrypted: i=1; AJvYcCVCqeJ7z//TT69L+NttTniXw+gf894SCOP8cai3TLnWYff3xlukGdBJTtj1LLfLZxffGqx8vyP5QNDEAy3fhsW3ht87Cd7TkQS2K+Ci
X-Gm-Message-State: AOJu0YwACJmmb0JDTxrLw/+YZuJttCtcLI2FrUDGFlNrPHBbeduj6MTv
	VYfxTK/1ZluvZcJdnC3hcbAxlFSNSjfJzjEwss41+6PJnLfq6WDXwXVcvCPKak8=
X-Google-Smtp-Source: AGHT+IFnVFj7i3GEZdjCS5RRUzI2AJw0B5Vjpn+qZ4xY+uoBiHeOJ0ETODeVEXt0VqNUBa9c3fyCAw==
X-Received: by 2002:a05:600c:1c27:b0:414:37f:18dc with SMTP id j39-20020a05600c1c2700b00414037f18dcmr7990830wms.1.1711823814939;
        Sat, 30 Mar 2024 11:36:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004147b824b08sm9302259wmo.7.2024.03.30.11.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 11:36:54 -0700 (PDT)
Message-ID: <98a5c1b4-b508-45ed-8719-149ec960250c@linaro.org>
Date: Sat, 30 Mar 2024 19:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
To: Manojkiran Eda <manojkiran.eda@gmail.com>, patrick.rudolph@9elements.com,
 chiawei_wang@aspeedtech.com, ryan_chen@aspeedtech.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 jk@codeconstruct.com.au, openbmc@lists.ozlabs.org, broonie@kernel.org,
 linux-spi@vger.kernel.org
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
 <20240319093405.39833-5-manojkiran.eda@gmail.com>
 <bad5df79-e040-4868-9db6-701110894ea3@linaro.org>
 <a9faa9b4-9bf6-49b6-b7eb-f642e2d261c3@gmail.com>
 <f2a487c4-eba3-4a78-9a14-67c8754c8b61@linaro.org>
 <582c276c-ea2f-456c-9bf9-47e39289a0b6@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <582c276c-ea2f-456c-9bf9-47e39289a0b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 12:33, Manojkiran Eda wrote:
>>>>> +    description: Controls the flash channel of eSPI hardware
>>>> That explains nothing. Unless you wanted to use here MTD bindings.
>>>>
>>>> This binding did not improve much. I don't understand why this is not
>>>> SPI (nothing in commit msg, nothing in description), what is eSPI,
>>>
>>> eSPI uses Peripheral, Virtual Wire, Out of Band, and Flash Access
>>> channels to communicate different sets of data.
>>
>> And what are these channels? What does it mean a "channel"? Is it just
>> how you organize transfers and classes of devices? Or some sort of
>> addressable instance on the bus?
>>
> 
> Yes, an espi channel provides a means to allow multiple independent 
> flows of traffic to share the same physical bus. Each of the channels 
> has its own dedicated resources such as queue and flow control.

Resources as queue and flow-control? Where are they defined in
Devicetree? Which binding?

> 
>> The channels feel like some sort of software or logical concept, not
>> physical. Physical would be endpoint with peripheral. Or flash memory.
> 
> A channel is a logical communication pathway or interface between the 
> chipset and peripheral devices. The concept of channels in the ESPI 
> protocol helps organize and manage different types of communication 
> between the chipset and peripherals. Each channel may have its own set 
> of protocols, data transfer rates, and supported features, tailored to 
> the requirements of the devices it serves.
> 
>> How do they fit here?
> 
> I am not sure I understand, can you please elaborate ?

All this suggests channel is programming aspect of your device thus does
not have to be represented in DT. I don't know, come with any DT
property to back up your case...

So far I see only interrupts and clocks, but then I would claim these
could be part of parent node.

Rob said it last time: your split of nodes looks artificial and it all
looks like one node.

Your DTS reg like:
	reg = <0x0 0x800>,<0x0 0x4000000>;
proves it. I don't know if this is just bug in your code or some silly
DTS just to create fake children. :/

> 
>>>
>>>    * The *Peripheral* Channel is used for communication between eSPI host
>>>      bridge located on the master side and eSPI endpoints located on the
>>>      slave side. LPC Host and LPC Peripherals are an example of eSPI host
>>>      bridge and eSPI endpoints respectively.
>>>    * *Virtual Wire* Channel: The Virtual Wire channel is used to
>>>      communicate the state of sideband pins or GPIO tunneled through eSPI
>>>      as in-band messages. Serial IRQ interrupts are communicated through
>>>      this channel as in-band messages.
>>>    * *OOB* Channel: The SMBus packets are tunneled through eSPI as
>>>      Out-Of-Band (OOB) messages. The whole SMBus packet is embedded
>>>      inside the eSPI OOB message as data.
>>>    * *Flash Access* Channel: The Flash Access channel provides a path
>>>      allowing the flash components to be shared run-time between chipset
>>>      and the eSPI slaves that require flash accesses such as EC (Embedded
>>>      Controller) and BMC.
>>
>> Please make binding complete, so define all of the channels.
> 
> 
> I would like to inquire about the rationale behind this request. Based 

Rationale - writing bindings document.
https://elixir.bootlin.com/linux/v6.9-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L17


> on previous feedback received from the upstream efforts 
> [https://lore.kernel.org/openbmc/HK0PR06MB37798462D17443C697433D7191D09@HK0PR06MB3779.apcprd06.prod.outlook.com/], 
> suggestions were made to model the flash channel by utilizing the mtd 
> subsystem, the virtual wire channel by utilizing the GPIO subsystem, and 
> to consider the OOB channel as a type of i2c device, thereby allowing it 
> to be utilized by the existing in-kernel MCTP subsystem, among others. 
> My intention was to prioritize upstreaming the flash channel binding, 
> along with its driver code, before proceeding to address other channels. 

Just to clarify: I don't care about drivers and we do not talk about
them here.

> I am curious to understand if it is a strict requirement to have the 
> complete binding upstreamed before addressing the device drivers code.

What if your other "devices" or "channels" are entirely different and
binding would just not work? Or how can we understand the design if you
upstream only part of it?

Best regards,
Krzysztof


