Return-Path: <linux-kernel+bounces-72521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A231785B4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D60282AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6405C611;
	Tue, 20 Feb 2024 08:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agWys5jj"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC235535D0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417022; cv=none; b=oL57BlnkAEmqNCAjUFNazr7PPkO/WohpJYHru6VsI/N4RoU5cq13S5x5nC6Xl5o/iqUaTEUPGoJf3fc3pXwLwYnmlFAZLJ6V6baQkEOkG4gFQuRZEYDEMj1lVdShuOLTgZw3g/H4/kPElL41g0Z42qLl3oI99A+W7v8dvDCzjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417022; c=relaxed/simple;
	bh=XMY4tDptxbgfTL874aU0e1jAkTWTmhv9MQOUZIRP8N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiMSAtdUCNiWuwpc3MyFB+U1JiKLKNLu0jDK3EjH1xa/i6KNUZ4n4tV2UCaqe0YuzoyktNkvBmE+hPuw02TaQzPSX+7XsQmfqIaJSI1MwhVaKwVO2SeDCKJtc0oYJ/2WI8NUm7jZDWbWo5IdbmOQd7rS7yG2m/ZXUk7TjrkG77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=agWys5jj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d109e7bed2so67912461fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708417019; x=1709021819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2s9snNCdmson1o/B85ImsqEy6xXo5/r33ShXsHFKVVU=;
        b=agWys5jjHZSwUSWIT9g3fg3B0mv8NUOwQVz4Ed6Uv3lQ36ECU7igol8p9p4ho/raV1
         3TkApBJQ/RbYbZCEjd8P5f1rPSqHPOhEk0nFNaW1Q3C6dfScWpB09t8WyrquViZOF4s0
         /RWRnlH4d9Si30QRkSpoqLZTcimJ5WmB9A0EKAmsuVCFdyfRcCOS8B3bPc6w4n6X5npY
         QJ1OKHo5953Sa4XQHtEy+y9PopL2jMD/a6cKH3CDV3eoXXGIiDtDm6T622eRwlRVjPFx
         wlQwZ6YbgtAO1exfOWgELBXaywZTbw1dlpTwwWZCVufDv5QDCHPiz4JSj6BewTnzBsjz
         Np3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417019; x=1709021819;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2s9snNCdmson1o/B85ImsqEy6xXo5/r33ShXsHFKVVU=;
        b=RToqdcIBvt6s5OZ6DpuJMIC3f8YoYHo8S1ihYhV6f/pmGUui6YmvbhuWj7GDU8ApSC
         e9XU96g0/QsBlUM57WZCIh8spqK1qiH4AJnbGlp4KT3a0uk8PbH74jzQs66xxmktSu/B
         WSFKDx1kdAwxiwcAee7txAGhh+sykMew7jNiJ+VIAt7EHDqN8Y2qqlbTBM94K1/NQiaN
         2qBmskOeQpIQrKRSjmelVPfhk8S9aI3/7WaEEEFf/ecn6yMSu+ZEZiEvx2madwhulf4U
         K/gndFyDXC9YffHuNrXEZ7ntyG5pncRvvI5EUn3ScRZhF1opLg6H2o0JtDC3osaTKi6W
         vH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdbh1Tg3SEobrXDBuJXZ7U18tYUWBqOnvPioZI1olQG6os7MEiz0Uz/EfewS2S+SKMbrTcCnUzG2tjvbYT5hZD2kSMjwkoBNrmBq8s
X-Gm-Message-State: AOJu0YyBHdJnRvpQoriwUtUlNCLhRccq4hKTiiUDEqvq0Zn7Im2/cuTR
	ncNe4v/nWI1u/ds2PL841MTfHygQPFNFb2qMK+pJBHQ9DqDhRttwDsJ8ApduBCQ=
X-Google-Smtp-Source: AGHT+IFpLOBR3vSEm1r1J6jmg6PvF5rfZq6Prwjcx3Mow3d1UkP8CPQM50ZwtvOsTyksTiFaIVtHhQ==
X-Received: by 2002:a05:651c:1a0c:b0:2d2:3987:36b0 with SMTP id by12-20020a05651c1a0c00b002d2398736b0mr4057981ljb.43.1708417018906;
        Tue, 20 Feb 2024 00:16:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b0033d449f5f65sm7000414wrb.4.2024.02.20.00.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:16:58 -0800 (PST)
Message-ID: <9a5e9363-79eb-416c-89ae-c826062350b5@linaro.org>
Date: Tue, 20 Feb 2024 09:16:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
 <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
 <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
 <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 22:49, Yang Xiwen wrote:
> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>
>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>> list due to prior driver change.
>>>>>
>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>> compatible lists.
>>>>>
>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>> ---
>>>>>    .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>    .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>    2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..1b57e0396209
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>> @@ -0,0 +1,95 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>> +
>>>>> +maintainers:
>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>> +      - const: hisilicon,inno-usb2-phy
>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>> hisilicon,inno-usb2-phy are not compatible.
>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>> We don't talk here about driver, although I used the driver as proof or
>> argument, because I don't have access to hardware datasheet (and no
>> intention to look there).
>>
>> What I claim is these are not compatible, so respond to this argument,
>> not some other one.
> 
> Why not? Of course they are compatible. All 3 SoCs are using 

Why? Because...

> inno-usb2-phy. The only difference here is the method to access the 

.. here! Different programming interface means not compatible.

Please provide instead any argument that they are compatible, in the
meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
used for hi3798mv100 and it will work fine?

> registers. They are all enabled by `writing BIT(2) to address 0x6`. In 
> the cover letter, I said the driver is actually doing things wrong. 

Cover letter does not matter, I don't even read them. Your commits matter.

> Especially the commit adding PHY_TYPE enums, the name is confusing and 
> conveys the wrong info. It's not PHY which are not compatible, it's the 
> bus. I'll fix the driver, but still the PHY hardwares are compatible 
> between these 3 SoCs.

Provide any argument.

> 
> I'll say the driver is broken from the beginning. They should move 
> write_reg function to a separate regmap driver and only left `write 
> BIT(2) to addr 0x6` to the PHY driver.
> 

Best regards,
Krzysztof


