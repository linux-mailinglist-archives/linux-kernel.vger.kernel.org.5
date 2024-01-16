Return-Path: <linux-kernel+bounces-28256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3982FC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3771C27AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102524200;
	Tue, 16 Jan 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4gch14C"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCC1DA4E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437446; cv=none; b=hbPrHVpwTCgX5tcaX3xkbNKHG1N0BW9FxvBybs/ni8/CDkewda3WHFQtIPUwE/q1hCzoRNBwOXKliNzrdg+S4uatBbm/9ekv6UvKlO/1blohLyJ+XIv0y8br3+AEzG1SbtsAfa0P/x0UpdDCnTPBV9hRqq1omBdE5s1dVKlTA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437446; c=relaxed/simple;
	bh=NrrlgnPruqxIuzqJVz2NTv0tcguhTlVYomnnTVfur50=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=WJNgHHhGHouu1CM7wjr1TJ2OW33U+yfuV61dwdh+/qFVh23su0qundnbzWfCfyqTELQlDkK6RLEnlGfqcx5j0Wu7u+yyYrmXyMbFBXWqsSdZrMYeFvqYOCseM8KsloJvSNllxka8rYu3g9kXqoWnJEVqynW0PVkobBl7uefMFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4gch14C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-559c6b833b0so640780a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705437443; x=1706042243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlyEd1CDqQfZZbegDHe8dNpxJ3Uocf+Bvz/g7KVkMxw=;
        b=w4gch14CBLiFWCRZFqcy9BLzYVA8wKcFKPY0Fb2VO2bOmJB8O47JqePy5xgPIECOu4
         pgtNRB5P5cYxM6ShcgvtAMfpASjTJYoUVCbkvH9OowhwIxhCRxLaVqgVAI/u+XBDM+9I
         sv2rTLJFD9Pht7UvqWsNFDLzhdeEwTfKAXFYpLDzlTtm2Lh4tbH+iqMz/25eBzM91DQi
         OMQnXDD3euxqop3asQF/8xyumu1DLBF8HX0aa98MTCzRfkVPmpfhi7f0Wt5355bk05Ze
         1EqgK1ZluSxMCXRi0X9+ILwGA3cu+XdKkIDir1ZDH/qABxv8tvLEtFjHBLqgS6IvNe5S
         p8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437443; x=1706042243;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlyEd1CDqQfZZbegDHe8dNpxJ3Uocf+Bvz/g7KVkMxw=;
        b=bC5CnkWXfVCNdBjWj6QXtFQp9c6OuW70X0jYIWTlbs9oqzRMrrNtAkXwHwXcRgktPQ
         Jt0/AEZKLCqR6OqNFKxEn46WoaYCKI4f+DjN/UGDocfms6olSxeWas3EH+TI3uu0PkPK
         xbLhGRFsdzgNq+3JBT+H5EvGH1EIJQlPTJo8vAvUBHK0fuYisnU8Vuh54iHNTT8LTAOt
         CaP41ppkr/q70ns9sXh8hsOWQ/rdGtHJugtPapZt06gREuE3TMaRmpR6xu2WSwUCg0Oi
         WiiI/+v39WXiGs7Xxe0a8rfhRr0J9YN8XdB1GbTpZwGWiQu9ekjp29knHE0yeKLNpW54
         WRDA==
X-Gm-Message-State: AOJu0YwHVzF7jakKPgMk9stbXvRj/jDF14iahJ67Fu72+8W2S+MkyYc7
	RLj1ULkn0L8YBcB1U9y9FpBxJKHyDNQYSg==
X-Google-Smtp-Source: AGHT+IE+IOafwLs2xFZwYpt1+G/agj/LwR08QYceppqtcBxRIrHvYOe6w1vDRVWdW60tyU9iPXWyAw==
X-Received: by 2002:a17:907:76b4:b0:a2e:a00a:567b with SMTP id jw20-20020a17090776b400b00a2ea00a567bmr413218ejc.124.1705437443232;
        Tue, 16 Jan 2024 12:37:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id gw7-20020a170906f14700b00a27741ca951sm6869257ejb.108.2024.01.16.12.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 12:37:22 -0800 (PST)
Message-ID: <64a35c38-38e4-486f-8a07-4aee1d14e05a@linaro.org>
Date: Tue, 16 Jan 2024 21:37:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 4/8] dt-bindings: soc: nuvoton: add binding for clock
 and reset registers
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-5-tmaimon77@gmail.com>
 <98eaac00-1e3d-4c27-89f5-0b6ec0fcb710@linaro.org>
 <CAP6Zq1hxTgJWtem4Y4_4Hv1ojy5edzGXeBGhh_gzyM4Kewsbeg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1hxTgJWtem4Y4_4Hv1ojy5edzGXeBGhh_gzyM4Kewsbeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 20:02, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your comments.
> 
> Sorry for the long explanation but I think it is necessary.
> 
> In the NPCM8XX SoC, the reset and the clock register modules are
> scrambled in the same memory register region.
> The NPCM8XX Clock driver is still in the upstream process (for a long
> time) but the NPCM8XX reset driver is already upstreamed.
> 
> One of the main comments in the NPCM8XX Clock driver upstream process
> is that the clock register is mixed with the reset register and
> therefore we can't map (ioremap) the clock register
> region because is already mapped by the reset module, therefore we
> decided to use an external syscon to handle the clock and the reset
> registers driver.
> 
>  I highly appreciate your guidance on this topic.

Linux deals with it easily, that's why we have regmaps. What's the
problem exactly?

> 
> On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/01/2024 14:54, Tomer Maimon wrote:
>>> A nuvoton,*-clk-rst node is present in nuvoton-common-npcm7xx.dtsi and
>>> will be added to nuvoton-common-npcm8xx.dtsi. It is necessary for the
>>> NPCM7xx and NPCM8xx clock and reset drivers, and may later be used to
>>> retrieve SoC model and version information.
>>>
>>
>> A nit, subject: drop second/last, redundant "bindings". The
>> "dt-bindings" prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>>
>>> This patch adds a binding to describe this node.
>>
>> Please do not use "This commit/patch/change", but imperative mood. See
>> longer explanation here:
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> ---
>>
>> How possibly could it be v22 if there is:
>> 1. No changelog
>> 2. No previous submissions
>> ?
> Should the dt-binding and dts patches be a part of the clock patch set
> (this is why it's V22) or should I open a new patch set?

You should explain what is happening here. That's why you have changelog
for.

>>
>> NAK, it's something completely new without any explanation.
>>
>> Limited review follows.
>>
>>
>>>  .../soc/nuvoton/nuvoton,npcm-clk-rst.yaml     | 40 +++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
>>> new file mode 100644
>>> index 000000000000..dfec64a8eb26
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-clk-rst.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Clock and reset registers block in Nuvoton SoCs
>>
>> This is vague. Any block? All blocks? Your SoC has only one block? I
>> doubt, although possible.
>>
>> Anyway, clocks go to clock directory, not to soc! We've been here and
>> you already received that feedback.
> Since one region handles the reset and the clock registers shouldn't I
> add the dt-binding to the SoC like the GCR and not to the clock

No, soc is not a dumping ground..

> directory?
> https://elixir.bootlin.com/linux/v6.7/source/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-gcr.yaml

Choose the main feature of the block - either clock controller or reset
controller - and put it there.

>>
>>
>>> +
>>> +maintainers:
>>> +  - Tomer Maimon <tmaimon77@gmail.com>
>>> +
>>> +description:
>>> +  The clock and reset registers are a registers block in Nuvoton SoCs that
>>> +  handle both reset and clock functionality.
>>
>> That's still vague. Say something useful.
> Will describe more
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - nuvoton,npcm750-clk-rst
>>> +          - nuvoton,npcm845-clk-rst
>>> +      - const: syscon
>>> +      - const: simple-mfd
>>
>> No, it's not a syscon and not a simple-mfd. You just said it is clock
> Yes, I understand the syscon node represents a register region
> containing a set of miscellaneous registers, but as explain above it
> is quite the case here.

Nothing in this patch was telling this.

> I will remove the simple-mfd.
>> provider and reset controller. Thus missing clock cells and reset cells.
> The reset cell and clock cell found at the clock and reset dt-binding,
> is it enough?

This is the reset and clock binding, isn't it? You called it (your title):
"Clock and reset registers block in Nuvoton SoCs"




Best regards,
Krzysztof


