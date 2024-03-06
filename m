Return-Path: <linux-kernel+bounces-93396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E5872F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF301F23BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964E5C5F0;
	Wed,  6 Mar 2024 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wD9skDEm"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F15B5D8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708631; cv=none; b=fyWQBJ87ya7xYTwtFJAriIcbfW4u5+AuUaL+OM15taf/PE2Y5zTlKIncfBG2ZbWL/c6K6cq6jCK4PFGZdrNwZZDZr2LQTgskHuDQCApKS/cs2FPosruzVHUM1HPHi8aWQDUMfkwQt3q9FWiqiXLDakRxtHbtl5b3EssH3iz5Bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708631; c=relaxed/simple;
	bh=3DgUBNgy8sLkRZnLFBw+6zn+YkX5r3/rzipx1Cj3Vt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e0R3HpWn/osT1YvHoXANGfVPa4icIOkQ9f3Zme3OBJgyV1aI6Jsxd1/kdQxz4sx5GMBpYLwUfYXxAl3kRteBJ1JIFigbmYqRmEnHdMWqzo3S7YkYi0hpKiiXPYE3y4Mjs+kXxF3HS8Gccc9ZhcWmbjGoXRvqYLMuWkGBLmhqT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wD9skDEm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso813326966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709708628; x=1710313428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhnFBnPzaxodTQ6vhaknSsP2PbK8X0N4l9zrnxNioqw=;
        b=wD9skDEmDFFXkRGNb8CbvwccXQdkRj3RtTr4Q332qY76Tixt8GWwQSRVEnkgBpb1QZ
         eaZxx2HQ0KkSTRJ4mfzvU06y3cVFqHRSnIWGO400hRJDa2IQulWlfvsuud4sJyWIZ2JF
         fL128FyLmTduRs85hIY8WZuAD7f/E8h2fAHAzv+DDWQoc4uJIZk4T32XrlwEKtq6Ok/r
         Lx8ekhFeUJfPhglxtjJGkDgYY13Wyt+kQEXN/019nHQVB4ZcERWRyrVSSuDGDFVgphZs
         hz3VkFvxPO2mZCYKwuBQCptKOP3VGlwrAFfT3PDSp9kLlxiKfoZfPzDf1wm+djDb1tWC
         bdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709708628; x=1710313428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhnFBnPzaxodTQ6vhaknSsP2PbK8X0N4l9zrnxNioqw=;
        b=XCtleSaDpcu6iQMXz/K95GNVoot6JeSD/Z3nNKvQa/NLiWqLI+FJReZP6S6nEoeq3i
         1x6WPC+50DV5zG5YrMBrn35JSQn/rp5D8SP4t6rJNFbzf5KzW6eowKaHioXFOqbqVf06
         jbo7Q9eM3dLOhCEmRBkk+uNQB+EXY7oX/A0ZQc2RoqkegjShJ09yF/isycKEeYWXz2LN
         5bNRMWxmH8wqZiHEn95Qk+GXzTEY61/EakYmJIqdkaj2V/8urIZ1vMR0Avtq6idoZ0hU
         7DKsi5aRGV/6C7nfc1Ce83cnLJ+gWJOPVcl9a4isWKOFFqoqVagKalf8N2o+S9Bw1Bka
         yUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXTxQeyjSO81oMquI2KRShgIA+vTJ6fVIrLSPtJql5TQauwyflYP1uyLwyAyWHIQh5vBJuJqRY7PhP//aeZmYRzETyh1PX6zWhcvyO
X-Gm-Message-State: AOJu0Yyu3OVNSsEObKL0UDE4VH4f+WPo4knoRBZNhIhzspJozWaIg5tv
	34J2+a3JvxcHt8a3UOUjgVIMD6eOZI5LDgWgigrPtTYQympsL/WLxvBQHT304Es=
X-Google-Smtp-Source: AGHT+IHBUFG4vaVkrZTCL++ZGIbSnrkj5dTluWVEb+OutidlFYwjzpZQLRoECfVKQrGi5X47hf9IcQ==
X-Received: by 2002:a17:906:c7cc:b0:a44:7a34:e620 with SMTP id dc12-20020a170906c7cc00b00a447a34e620mr9668751ejb.4.1709708627717;
        Tue, 05 Mar 2024 23:03:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090670c700b00a45ad52d510sm1128717ejk.139.2024.03.05.23.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 23:03:46 -0800 (PST)
Message-ID: <84618a4a-be20-4c59-badc-15fa65debf4c@linaro.org>
Date: Wed, 6 Mar 2024 08:03:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] dt-bindings: usb: qcom,dwc3: Add support for multiple
 power-domains
To: Sriram Dash <quic_sriramd@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, quic_wcheng@quicinc.com,
 Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, quic_psodagud@quicinc.com,
 quic_nkela@quicinc.com, manivannan.sadhasivam@linaro.org,
 ulf.hansson@linaro.org, sudeep.holla@arm.com, quic_shazhuss@quicinc.com
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-2-git-send-email-quic_sriramd@quicinc.com>
 <86371fc0-ef49-4dc9-b98c-7c5131cd1227@linaro.org>
 <986b49f5-6a4a-430d-ba6a-2f387f2a262a@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <986b49f5-6a4a-430d-ba6a-2f387f2a262a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 19:03, Sriram Dash wrote:
> On 3/5/2024 10:37 PM, Krzysztof Kozlowski wrote:
>> On 05/03/2024 17:57, Sriram Dash wrote:
>>> Some target systems allow multiple resources to be managed by firmware.
>>> On these targets, tasks related to clocks, regulators, resets, and
>>> interconnects can be delegated to the firmware, while the remaining
>>> responsibilities are handled by Linux.
>>>
>>> To support the management of partial resources in Linux and leave the rest
>>> to firmware, multiple power domains are introduced. Each power domain can
>>> manage one or more resources, depending on the specific use case.
>>>
>>> These power domains handle SCMI calls to the firmware, enabling the
>>> activation and deactivation of firmware-managed resources.
>>>
>>> Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
>>> ---
>>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 74 ++++++++++++++++------
>>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 49 ++++++++++++--
>>>   .../devicetree/bindings/usb/qcom,dwc3.yaml         | 37 ++++++++++-
>>>   3 files changed, 130 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> index 1e2d4dd..53b9ba9 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> @@ -44,7 +44,32 @@ properties:
>>>       maxItems: 5
>>>   
>>>     power-domains:
>>> -    maxItems: 1
>>> +    description: specifies a phandle to PM domain provider node
>>
>> Please drop all redundant descriptions. Adding them is not even related
>> to this patch.
>>
> 
> Thanks Krzysztof for the super quick response !
> Sure. will drop the description for power-domain
> and power-doamin-names.
> 
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  power-domain-names:
>>> +    description:
>>> +      A list of power domain name strings sorted in the same order as the
>>> +      power-domains property.
>>> +
>>> +      For platforms where some resource are firmware managed, the name
>>> +      corresponding to the index of an SCMI domain provider can be
>>> +      "usb_core" or "usb_transfer".
>>> +    items:
>>> +      - const: usb_core
>>> +      - const: usb_transfer
>>
>> How is this related to fw-managed? I fail to see it. Don't mix
>> independent problems in one patch.
>>
> 
> Some of the the resources like clocks, regulators, etc will be 
> controlled by the firmware instead of OS. However, some resources
> still will be controlled by OS (interrupts for example).
> 
> So, to support the management of partial resources in Linux, and
> offload the other resource management to firmware, multiple power 
> domains are introduced. They will be corresponding to different
> hw blocks.
> 
> Do you suggest splitting the addition of power-domain-names and
> addition of fw-managed property in separate patches for bindings!
> 
>>> +
>>> +  qmp,fw-managed:
>>
>> Please do not upstream vendor code directly, but perform basic
>> adjustment to upstream Linux kernel. There is no such company as gmp.
>>
>> Run this first through your internal review process.
>>
> 
> This property is newly introduced for the qmp superspeed phy and
> similar dt properties are introduced for hsphy and dwc3 qcom
> controller glue layer driver. It will govern the suspend/ resume
> of the resources (by firmware or OS) as required.

So that's your answer to "there is no such company as gmp"? It's not
relevant at all.

Please run it through internal review first.


Best regards,
Krzysztof


