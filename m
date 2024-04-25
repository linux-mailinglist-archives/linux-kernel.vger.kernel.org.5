Return-Path: <linux-kernel+bounces-158151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A008B1C36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F19EB219A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928546E612;
	Thu, 25 Apr 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siuKB0tU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB86D1B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031486; cv=none; b=aJT6P0zYDLNVGrwQpp0WlC9vzIR9caiUZGSb9yo/vDLNAqnt9ydOlEAIMjyhWPTz1gRWK0xlDgBTpTf3YtsfppzYDx6w0BeNO54oyLrbIS7cQ+cNruA4bqP7yKBPno6IILlXou4clTky3b+bVbmkW1A/dIadIHLmcrIr7+U4SbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031486; c=relaxed/simple;
	bh=MyC0RxC+08ID8zqZEseyJQjhpmxaNON5OToW87wAFJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTRa14gikInW9rrBy1VmKYB9nO4Js1mZDrHxHg6mbsx2X8RosSbzVIjC0zbcEC/GTyo6IJArDY1ZfbBHI1tcfZqRyLR95oVgOhMI0rb0jilqno5Qa/Yynm9qp2hp5BUdjr4iCI1FpkilSqGydGSc8f0YKUU7XDfY8y3fAgCt6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=siuKB0tU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso5316595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714031482; x=1714636282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kR1SUG/D+2Zin7SNurjDAsFGIT9KBx3Q2ZphAEB5L4I=;
        b=siuKB0tUNRMbLLzsvIOkaTT/vhbh9XazoEFAvyOY9q8ZpuyOk0wxpLgHrPdndVOhFN
         5WAfm5CMZuDXDbhZyRUCJ7L/zQiH0E4zPZvVTZo5kDbo+Af1Kc7x6kyn0drhx6SRiOUX
         s6h0BOPaoyoWgi+au/eDSS1YvI4yrTCX0CP5glVPFX9PxGaf+Iwf7c7gK1dcy5vYFu/o
         GVsYE885OFyKgmPtzfGR7SRd0bNENhNqbwqZMG5qluve7YzxVIJZvq35RbZn4tP54Ep1
         i7n2ca6UBoVfE1fEitrKIlQtY3nuSw+BlvNpCFk8dOCRtlcrMcpNU+taJXgJL0orOItf
         Qg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714031482; x=1714636282;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR1SUG/D+2Zin7SNurjDAsFGIT9KBx3Q2ZphAEB5L4I=;
        b=q7D2DVB7w7E9VnwqVtIBkA4hyeNImIKA8Vkv9zJJ8oc99YmktW4PpswiJPC9n2EVpS
         84UEuqDrLeBzGEu4wUqwZ9DXc1MQq1EbggOUKIzDkaqKOdJfkKKiRTIMo/kWliNIoAy7
         ZE2se1SjdwC8Kx65yzVNPbK42N02ozcdGCgVV4E5Z2c8UC8b2t7cTXqdwwK4dr4FgxsW
         CnIc761QouJi0F39T4Ie1UeX/Wn8jEF0crIzthnBfFTadAu03wwtsO5C/zHMBxo/TYMy
         j8PDCoSCcFt2Zr2ldjkzCgUIWmUvibWyP1XA2q8BRVQ9DheR9RvJuriMVauhvGo15PlW
         LSRA==
X-Forwarded-Encrypted: i=1; AJvYcCXl5BYSSwuORrKmMhcijlEQkZ8yjlNle45CrbRwY/0883JpxfR5IhEMVcZWMID6+r/MheEFU3T64X43ea+Zm9zBQTnIuo0R6BtH/T3I
X-Gm-Message-State: AOJu0YxMu0Wn46r/ORhf7veNzK/5V1MRWdTPGaVX7MMQJWjZotyEbNix
	UTjAo13ZpY5eh8K0DnUGlCdDVOLaccmUwvRQfu21aFNBc5uVYQsLFPOjvlA1rUU=
X-Google-Smtp-Source: AGHT+IEDxxSeAadkSFnQClyzKYCtAlVzK9Sx4hhJT7SiTBNbpUvycxKD9VsgDu9vSyrA1+yF2bKzKw==
X-Received: by 2002:a05:600c:5601:b0:41a:3b4f:822a with SMTP id jr1-20020a05600c560100b0041a3b4f822amr4050506wmb.29.1714031481944;
        Thu, 25 Apr 2024 00:51:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k29-20020a05600c1c9d00b00418948a5eb0sm30385746wms.32.2024.04.25.00.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:51:21 -0700 (PDT)
Message-ID: <66a8efac-518d-48e4-a8dd-f05d4102b148@linaro.org>
Date: Thu, 25 Apr 2024 09:51:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/2] dt-bindings: make sid and broadcast reg optional
To: Thierry Reding <thierry.reding@gmail.com>, Sumit Gupta
 <sumitg@nvidia.com>, robh@kernel.org, conor+dt@kernel.org, maz@kernel.org,
 mark.rutland@arm.com, treding@nvidia.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-2-sumitg@nvidia.com>
 <d26f9661-3e50-4a72-9097-fe63a27503f1@linaro.org>
 <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0SHRQVCGJBY.2DPLX9K6VXEYM@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 18:26, Thierry Reding wrote:
> On Mon Apr 22, 2024 at 9:02 AM CEST, Krzysztof Kozlowski wrote:
>> On 12/04/2024 15:05, Sumit Gupta wrote:
>>> MC SID and Broadbast channel register access is restricted for Guest VM.
>>
>> Broadcast
>>
>>> Make both the regions as optional for SoC's from Tegra186 onwards.
>>
>> onward?
>>
>>> Tegra MC driver will skip access to the restricted registers from Guest
>>> if the respective regions are not present in the memory-controller node
>>> of Guest DT.
>>>
>>> Suggested-by: Thierry Reding <treding@nvidia.com>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>  .../nvidia,tegra186-mc.yaml                   | 95 ++++++++++---------
>>>  1 file changed, 49 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> index 935d63d181d9..e0bd013ecca3 100644
>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>> @@ -34,11 +34,11 @@ properties:
>>>            - nvidia,tegra234-mc
>>>  
>>>    reg:
>>> -    minItems: 6
>>> +    minItems: 4
>>>      maxItems: 18
>>>  
>>>    reg-names:
>>> -    minItems: 6
>>> +    minItems: 4
>>>      maxItems: 18
>>>  
>>>    interrupts:
>>> @@ -151,12 +151,13 @@ allOf:
>>>  
>>>          reg-names:
>>>            items:
>>> -            - const: sid
>>> -            - const: broadcast
>>> -            - const: ch0
>>> -            - const: ch1
>>> -            - const: ch2
>>> -            - const: ch3
>>> +            enum:
>>> +              - sid
>>> +              - broadcast
>>> +              - ch0
>>> +              - ch1
>>> +              - ch2
>>> +              - ch3
>>
>> I understand why sid and broadcast are becoming optional, but why order
>> of the rest is now fully flexible?
> 
> The reason why the order of the rest doesn't matter is because we have
> both reg and reg-names properties and so the order in which they appear
> in the list doesn't matter. The only thing that matters is that the
> entries of the reg and reg-names properties match.

No, that's not true. Client/implementation can pick up by indices and
order always matters, at least as much as possible.

If the reason is "we have reg-names", then the answer is: no. That's not
valid argument. The reason could be that entries are so
fragmented/randomly distributed that order by indices is impossible.

> 
>> This does not even make sid/broadcast optional, but ch0!
> 
> Yeah, this ends up making all entries optional, which isn't what we
> want. I don't know of a way to accurately express this in json-schema,
> though. Do you?

I think oneOf: with two cases. Depends what is exactly optional. The
commit msg is quite poor here. I expect proper rationale and description
of driver. Is sid optional? broadcast? Both? Any? And what does it mean
optional? The address is reserved or address is not existing? Or maybe
address is there, but can be ignored?

> 
> If not, then maybe we need to resort to something like this and also
> mention explicitly in some comment that it is sid and broadcast that are
> optional.
> 
> Thierry

Best regards,
Krzysztof


