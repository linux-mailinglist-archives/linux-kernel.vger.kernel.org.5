Return-Path: <linux-kernel+bounces-100664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC764879B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C4E2835CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBB140E5B;
	Tue, 12 Mar 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlhZA/4g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9141DDC9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268479; cv=none; b=j1oqYOUbgENrDrTWZIwQkUMoQoAKQ2NuR3v6iG7VWOaOgdrR3En7kM+C3j+Dh5f0gx97kBg4kBdjN7W+yCELHRgpNc3AJvb9EQC8BJdVKl3RogtmHULk6uA8x2JbGmEE9PygZduwC7IH3vEpioFNbDH7Kc5uaOZ17x5ra8jDbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268479; c=relaxed/simple;
	bh=pGuULm/CHXM11bgwq9+j2y5waqyjjkr9xF1BTqDkZJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+I6wxc/E7LBxl4E9PwlzT7yhcghFZzE/KbRGTq8nLAMv/A65f6ZNMswapVTt03YYSuMu5rycwix0sI5jPGoy542kZ73ufdZID/uIsY/Ro1IA4XNcmtDSxN/wSo7R+bVL+JSRcdTF1/A5j2863hEGPyYxmuv8bighpWgYNAuetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HlhZA/4g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4132cc37e21so14653895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710268475; x=1710873275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vv4Sm7UZXVqdBGX8hplEk2uRkZer1n7N2k6G4yb6swM=;
        b=HlhZA/4grcr0v8d4aNO0PG70QRQAP9VyRhOxnzfwTQOLi0LhBi+AVFW0E/uCRwOd+h
         Rw4Iqqgn/LNya1MOTJ+nZMtJJyHWRhSULEc8Ivr6vJ0SgnaMH3NHRoJFq4xDXRMKoyGP
         nEkgQRn9NVRBapMbLB47sBsyOW4UYCyVE9bLRmEcTvrptCHsJLMRdNc97lm7Mxoc/3ye
         LMFe0LdecAHhEH+ouGZ4OEg76wBrtJY0KVapHeAZOS/y/QI5xlUmJBjWlQSyToYhwlXC
         JDEi9fvNnfHgwh6bssxHgWBh+gC06/FC3m9GYiiZd2h+pLd86X/Z7Z01bkpTSf+kxNzN
         +Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710268475; x=1710873275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv4Sm7UZXVqdBGX8hplEk2uRkZer1n7N2k6G4yb6swM=;
        b=djjeREj2KabyOoxKs60cC8ytugp3WkHpnAFNOJOZ41OERQF2AxwWdxftR1qgAOf3rG
         Avj4jF0l/dgEvl0WbDNEs1nLJD2WZRd4w0FvHoEvAFtS/6xjeHlWU+cdpPBRsB7RY4j0
         mX+zjbLTHWcYZSJCXGPe3oVCl3NCKF77LuoPtmWUNnGen7S0I3C5InrXTQm8RCvM9YHm
         iQLEmdbyRjy7xbPJiSTc0Vh2G1tRFuyp4Nuek/X+MgzzBajHBnxilhQfHiYbtg5s2bqC
         Z/J+VAWj8bW3m+3W4PbNKTVKQFpYa0g9O3/C0XilwfFlDR70YzssTTOU+gw8BshCtaYk
         dpAA==
X-Forwarded-Encrypted: i=1; AJvYcCXOcmudVPon/6uVBendRG2g1dApD9cq0BnEvErntv+uyI/XP+8t+Test7MA+71uQkMSExt961zRoBdsr/3WcTZeoZC+zp/pssl72OHA
X-Gm-Message-State: AOJu0Yy+iaJogSNZylHP7Ie4LbrBni4YlRsCANNnEyGT609N+OyOneOV
	mOuEpijekrHgExQM3wxvW8q0ZFPQThpO3mLFjLCGHHRcAcKw4W8IBBDWWJPhhbc=
X-Google-Smtp-Source: AGHT+IHYNgNP421vNaL5nXSlSaT4BZLzBe/yll6vafwoUuA66iFoHfjPfZkvNbfiFEeYo/m5gaX4uA==
X-Received: by 2002:a05:600c:5385:b0:413:2ab7:4396 with SMTP id hg5-20020a05600c538500b004132ab74396mr4743708wmb.18.1710268475495;
        Tue, 12 Mar 2024 11:34:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b0041316e91c99sm13277255wmq.1.2024.03.12.11.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 11:34:35 -0700 (PDT)
Message-ID: <3d602e0b-a49c-4281-bc51-f8c015c5606f@linaro.org>
Date: Tue, 12 Mar 2024 19:34:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240311175926.1625180-1-tanmay.shah@amd.com>
 <20240311175926.1625180-3-tanmay.shah@amd.com>
 <d498d76e-b021-4cf7-adca-63f1cd3e1542@linaro.org>
 <fdad2198-5d3a-4bce-8249-8b2f9f75f84a@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fdad2198-5d3a-4bce-8249-8b2f9f75f84a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 18:42, Tanmay Shah wrote:
> 
> 
> On 3/12/24 7:13 AM, Krzysztof Kozlowski wrote:
>> On 11/03/2024 18:59, Tanmay Shah wrote:
>>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>>
>>> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
>>> UltraScale+ platform. It will help in defining TCM in device-tree
>>> and make it's access platform agnostic and data-driven.
>>>
>>> Tightly-coupled memories(TCMs) are low-latency memory that provides
>>> predictable instruction execution and predictable data load/store
>>> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
>>> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
>>>
>>> The TCM resources(reg, reg-names and power-domain) are documented for
>>> each TCM in the R5 node. The reg and reg-names are made as required
>>> properties as we don't want to hardcode TCM addresses for future
>>> platforms and for zu+ legacy implementation will ensure that the
>>> old dts w/o reg/reg-names works and stable ABI is maintained.
>>>
>>> It also extends the examples for TCM split and lockstep modes.
>>>
>>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>> ---
>>>
>>> Changes in v13:
>>>   - Have power-domains property for lockstep case instead of
>>>     keeping it flexible.
>>>   - Add "items:" list in power-domains property
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi Krzysztof,
> 
> Thanks for RB. I provided explanation of flexible power-domains in
> previous patchset. I am happy to send new revision removing
> minItems if you dis-agree.

Thanks for the explanation, it sounds fine, thus patch LGTM.

Best regards,
Krzysztof


