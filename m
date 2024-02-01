Return-Path: <linux-kernel+bounces-47732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1428451F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88C11C23BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F42C1586EA;
	Thu,  1 Feb 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvY/GFlm"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F481586E2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772724; cv=none; b=fkt+EKh8diBy74MfYv4KIgJwsQ6DWsJrD5K6208ytCcEU/mxZqAfFaoiHzpwTeKTZDsEbSI9xgNnSZUJU972Xib3odKgWmXAoMs8fNzztkEOevhs4w1Gx3QmoXRlrQN39hCJuDa14GzrfK3+rpUrkde9n0cPdSVLaOke4q4dqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772724; c=relaxed/simple;
	bh=Ug6VbW6scob4zyacyL7DKfYD8E3cWUv2TjZXN9c3JUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cc44wFjEwCM8/MXWwSXKRZnfa+/6BV/wUEvFWBCFObEc4+JFAg/ct1DxdSAgJkg6qR6MVdZNNCpSHMoOiwbn/6uxqg28ux7OqZr30hWefFEMHcN2cKnQJPb/1NSlqt4AKvg0aQ7oTAe9+OaPWi5VRzcaH9pQ6me7S7xpjXW2o9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XvY/GFlm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3566c0309fso67430566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706772721; x=1707377521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkihkoVp+1Q0+WMCFTmpmA5Epw3+p6C5zEBoeBY4VKg=;
        b=XvY/GFlmEu0mElawvuHfVeaF4gpg/iwaNhDHQ5+rA0OFMRCFN7An5Z7MIWL2EWdnlG
         tiLvRpnWqtvltA+ItrsAyRteMZ8zBjlomTptKaVxl52Bjf9NWC2sPR5k+wbSeemcsApi
         iizpCKgsojMnHHJbvrDUZBNaNGwFphKXIHRzN7L2w2STpyCW3M0mqShxSU9CU1x/zYz0
         +K4dZTxEEHWOLhG76ApOrqrLqpAtMdSDyz5Vl2FkbmxnVvBjhPoZmxECOAy2w/4WQoHX
         P3+4EwB/POJkBDYXRPDt0did/YzBZ0P9gkQdB/yye3IERMhNhD1yFlI5633j/kkEuGhQ
         A1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772721; x=1707377521;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkihkoVp+1Q0+WMCFTmpmA5Epw3+p6C5zEBoeBY4VKg=;
        b=oIMqqtjpT8mZng4uN/hAck0YB78uGqqrZJt7ufo8vTcaMILVNl91rZ5Bafk6Xe2LyZ
         VJlggorDUx8l3sRn+gp2SoeDfoAsh/2bMqRl17UqerXp18oA/tuun5hSx1D5+qvjn60R
         2RA6gqHzqMX5ZJezNfut9i0/LwiafMlMGyMFoeCGc8i78snHN0BiYfKV/mobx2uKqV+A
         AADFHDD95J93v+grzQs1yJ6fFe5Pvilg/bppiNcWrT2emYjbbFMPMWwEeh98OCZRZ2h2
         9CA9Jelz5dxDCbLZkxaHJYdiJCdN7psX1EvNsrZ+ulORV9NR/HZvpokDJxCXEcsuKlUw
         fMyA==
X-Gm-Message-State: AOJu0Yz1vg1/rdCQMD0ceulakekGNKy3Mda23TwiqsBqAzM6wOSdWc2j
	2qCdZPtPKaxdsDbN47d1trplp0oy553p02Jp8cSmnd6x0UyZecLNPOBXFa1KopY=
X-Google-Smtp-Source: AGHT+IHJAAKW2oakvnFSZPvrgZF3goQ3YyggDyofe9lXor6fwC2SQY7yWvc0unDHIEpZhD146f/PWg==
X-Received: by 2002:a17:906:13d3:b0:a30:fb95:9387 with SMTP id g19-20020a17090613d300b00a30fb959387mr2880569ejc.75.1706772720921;
        Wed, 31 Jan 2024 23:32:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXN/ZYgF+xQa2PwJIMR77grLNDHJg5YLLcPfXzjO9FduHf5+SsEsxfQOqBEYGB09oIeqvkL0TJYTPMv8ehZfqTlRQfeznXNprk/MEfkCcGPn/bMk5nT4Ca3MM7FcPIcR+fB39BRX+Ckk+QECNi478L17Q33pb5RY1xxNEoPEL6J+EZYaV0gGShWrbV+33Jlkdj3XjbUm3cUhyckFj7onTAYlHqAewBfPI4d78abQEPDXjLwDrtlYZWCXZqnv6QWOt+ZSLx/u9wouV4I4G+qjILkvW7Biw4NRK60jmQDGTbzabvx8Wv9Eu3T5+3i0nIj+JUmdg==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id hu17-20020a170907a09100b00a3603b49889sm2904618ejc.21.2024.01.31.23.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 23:32:00 -0800 (PST)
Message-ID: <2824fd42-d588-4a0b-b6f9-1e9cb6055d6a@linaro.org>
Date: Thu, 1 Feb 2024 08:31:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,k3-pcie-ctrl compatible
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
References: <20240131112342.1300893-1-s-vadapalli@ti.com>
 <be60e695-894e-4281-a62c-b77e45680293@ti.com>
 <91737281-8249-4fcb-b5bf-750c015b7c24@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <91737281-8249-4fcb-b5bf-750c015b7c24@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/02/2024 05:48, Siddharth Vadapalli wrote:
> Hello Andrew,
> 
> On 31/01/24 21:43, Andrew Davis wrote:
>> On 1/31/24 5:23 AM, Siddharth Vadapalli wrote:
>>> The PCIE_CTRL registers within the CTRL_MMR space of TI's K3 SoCs are
>>> used to configure the link speed, lane count and mode of operation of
>>> the respective PCIe instance. Add compatible for allowing the PCIe
>>> driver to obtain a regmap for the PCIE_CTRL register within the System
>>> Controller device-tree node in order to configure the PCIe instance
>>> accordingly.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> This patch is based on linux-next tagged next-20240131.
>>>
>>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> index 084b5c2a2a3c..da571a24e21f 100644
>>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>> @@ -73,6 +73,7 @@ properties:
>>>                 - rockchip,rv1126-qos
>>>                 - starfive,jh7100-sysmain
>>>                 - ti,am654-dss-oldi-io-ctrl
>>> +              - ti,k3-pcie-ctrl
>>
>> This might not be the same for all K3 devices, you should use
>> the name of the first device which uses this, so:
>>
>> ti,j721e-pcie-ctrl
> 
> It is the same for all K3 devices so far. However, since the convention appears
> to be the first device that it is applicable to as you pointed out, I will post
> the v2 patch for this accordingly.

This was repeated so many times... so one more. Compatibles are specific
to SoC, not to family.

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Best regards,
Krzysztof


