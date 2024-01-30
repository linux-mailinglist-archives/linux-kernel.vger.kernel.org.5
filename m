Return-Path: <linux-kernel+bounces-44511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0405884230F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA6C1C21F76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAF66B5F;
	Tue, 30 Jan 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wy16m9er"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CF66B32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614196; cv=none; b=uX/baGzdSJBsqYZTXuXJCqhD3O1u+vPfr2bhYbeRYoUgDKRKYaV9oPB65wU+y4p0/qa/BSfQVNAflMBz2zkGeV6RgdO6gvM2oEqK53rKI6Bydu44XST4Q2GHfLLEQSvRjXIZDeQewnrBDDVTiLjjsD47xxi/lBg2+Q7BfhURnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614196; c=relaxed/simple;
	bh=bEZaVbI/55/p2JhCoFmNg8hi8M3r2EWGCwp//vS2n7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFvyxk4IbBhqQVFzmo80arEu23wAoTySQb/zvBUIJc18hJ1k7fOBGbUl0nFUdaBWDKK7TLnfHB6566XiXVz+1c7xoX7G1cosMTskMtqcPE8K/XU90eJs9xc6B5AY2/bA+gsGbdCM7NYCe56RbtnT9NgJu2MMq4yBb+QL5M9TI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wy16m9er; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28a6cef709so493255266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706614192; x=1707218992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/wXdJkdUpdjl28e5HU6avCM/qUEYOQurqc08XxIzuY=;
        b=wy16m9erfB73gW1/sXMTNNUq1FwkVYtYE/9c34X851/Fex+e+vHiKam4ezQkZJDuou
         aaGnMC/GXwjpOxFnEkL8lePRLhjeDte5bMoohVoepo5ojlxyBL+njlr+i2qKAycokdow
         FbV1R8a/rnWxxXx8OUylZqBdJmqHuNGeZLTjy3N/R3dENjMGGSGhiRL9X2IafxW/i/6u
         b1rA0MuCyk/+LGGI/ZZsuSHdclcL+t2RQGqsogyUk/+Z+bInZpyg+/0Dn7sVBrycTQ3D
         e8D3f6GQGBsbDWAUDNxdl7e/dwprwGwFe/iRhqqhWisR1nZNZTQKR4nyyvSngjYRLuur
         iCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614192; x=1707218992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/wXdJkdUpdjl28e5HU6avCM/qUEYOQurqc08XxIzuY=;
        b=Yl/+rgS7Lz2la320CcQIpXe0ywZ+8J7bes3g2JI3ivm8MNEQBQkp9MUa3tSXnchtyp
         gPrXQvz1C7Km9MvKTDXMgvL5Wkl3XeqgfXtwWDXTyLCm7tBHdCtfJdmpg7Wkyc00ySvZ
         yHKVPh1fjPo/z3e0l7HuW5PBrZvoILUajiihWNbFIuuoShImcB2iDu5CYswGrdFuOAv/
         WCmcfgqtf6dDIJiMKq0ObXzfu71mu5gZpbSNOgYVW3Xu6aCdPjPJ2Hc08TvQyLAjQL3D
         IMFjGg3FGhHNoaGq5lygtpryTCccAZdrmQvrc9Cl+cVOSxCU/z17dH4c289AmwXqiOpy
         XmJw==
X-Gm-Message-State: AOJu0Yz5PU9Ic8aE8NOBNGxmoxmsooPll8BiPP1vfrHP2QweiFXeH5LH
	OIkDs4sNcuLI96YeBlajBTlWRydiyNE3qKQxoIDI0ogElrRvIXg6pEtnoklmOjQ=
X-Google-Smtp-Source: AGHT+IGGGfr0XvFUuvHuuLaJCf1MJdt2eW/CUK2jQNR3scemlW/zU8DuoIM7kB8yEJWWFjFCw17w+A==
X-Received: by 2002:a17:906:ae51:b0:a35:76ce:8b4 with SMTP id lf17-20020a170906ae5100b00a3576ce08b4mr5414684ejb.45.1706614191970;
        Tue, 30 Jan 2024 03:29:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id gy14-20020a170906f24e00b00a28f51adc39sm5007205ejb.61.2024.01.30.03.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:29:51 -0800 (PST)
Message-ID: <d490aa68-c0b2-4741-aed1-2b97766bb7e9@linaro.org>
Date: Tue, 30 Jan 2024 12:29:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Content-Language: en-US
To: "Cvetic, Dragan" <dragan.cvetic@amd.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Kiernan, Derek" <derek.kiernan@amd.com>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, "Erim, Salih"
 <Salih.Erim@amd.com>, Conor Dooley <conor+dt@kernel.org>
References: <20240129171854.3570055-1-dragan.cvetic@amd.com>
 <170656680094.3132.1588315626789249618.robh@kernel.org>
 <BY5PR12MB424124B020E2B20741993288E27D2@BY5PR12MB4241.namprd12.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BY5PR12MB424124B020E2B20741993288E27D2@BY5PR12MB4241.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 12:07, Cvetic, Dragan wrote:
> Hi Rob, 
> 
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: Monday, January 29, 2024 10:21 PM
>> To: Cvetic, Dragan <dragan.cvetic@amd.com>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Rob Herring
>> <robh+dt@kernel.org>; Simek, Michal <michal.simek@amd.com>; open
>> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
>> <devicetree@vger.kernel.org>; Jonathan Corbet <corbet@lwn.net>; Kiernan,
>> Derek <derek.kiernan@amd.com>; moderated list:ARM/ZYNQ ARCHITECTURE
>> <linux-arm-kernel@lists.infradead.org>; open list:DOCUMENTATION <linux-
>> doc@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>; Erim, Salih
>> <Salih.Erim@amd.com>; Conor Dooley <conor+dt@kernel.org>
>> Subject: Re: [PATCH v2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
>> yaml
>>
>>
>> On Mon, 29 Jan 2024 17:18:51 +0000, Dragan Cvetic wrote:
>>> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
>>> dt-entries as well as any future additions to yaml.
>>> Change in clocks is due to IP is itself configurable and
>>> only the first two clocks are in all combinations. The last
>>> 6 clocks can be present in some of them. It means order is
>>> not really fixed and any combination is possible.
>>> Interrupt may or may not be present.
>>> The documentation for sd-fec bindings is now YAML, so update the
>>> MAINTAINERS file.
>>> Update the link to the new yaml file in xilinx_sdfec.rst.
>>>
>>> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
>>> ---
>>> Changes in v2:
>>> ---
>>> Drop clocks description.
>>> Use "contains:" with enum for optional clock-names and update
>>> comment explaining diference from the original DT binding file.
>>> Remove trailing full stops.
>>> Add more details in sdfec-code description.
>>> Set sdfec-code to "string" not "string-array"
>>> ---
>>>  .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
>>>  .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 136 ++++++++++++++++++
>>>  Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
>>>  MAINTAINERS                                   |   2 +-
>>>  4 files changed, 138 insertions(+), 60 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-
>> fec.txt
>>>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-
>> fec.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m
>> dt_binding_check'
> 
> 
> Accepted, will do it.

There is nothing to accept here, but instead please test your patches
*before* sending them.

Best regards,
Krzysztof


