Return-Path: <linux-kernel+bounces-96645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1386875F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107B91C21906
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D9524A3;
	Fri,  8 Mar 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQsWYTpN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4E51009
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886164; cv=none; b=hwhBHTfHzxCjKQ8WGYaot+jjvowx3jZgcbBXHZhxe5k8yjtJ2Wv8hJx3UpNdFrt3F60MPamZDdZsFCRgZ4u/MLp/2Wlaw4y2Qics1D1LgiaJ4IIWcZ5K8T8odkYdOJnYlMPtfFlpd3F8fIszryoakRYUzwxUD+8O/eq5ih6Qgu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886164; c=relaxed/simple;
	bh=Znf+9MNwPib1lHJSsGEHjM4k057n3SI9agYFPAu9+JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7da+E5YZdRo/vBc0iSERdOy/cdXJIuKlHqoTfOhy1hnm4uBqSoHrExLdataHA5BrUkH2a1gFl89oCEGD92PheYdUEkca1H01R80uj+IbfTw56if89fww/F0+DRfUrSAjR+Lf+5877N7MDa8zgAxI8eGeSoOCLZmw8h3N0jzf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQsWYTpN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a293f2280c7so295588766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709886160; x=1710490960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBCprgFYoUn8Y+xzvtdODul06R5mYKc2lB7UpcRimLs=;
        b=iQsWYTpNWKBoMAHF+woN1WhFnafu2aEPWwrtQprT3/87dJ2uu3ZJ6TF8UY7h1mDAv/
         KTNi+ezCn+1V/swjQPy0JwWm03LXELVi4xeuXN/lyDu8vCZF3w3cBo2D+uyIQUi2GSme
         4cJ4clRqDuyiJZ0NdCg8OSht6w18mJ+pXDVe3W9ctITAknenMxeOu4oBQzXOL8/XKfHG
         gLBk0fXU6fHa2T5fQeIA7Hbb2RlsDYM3niGZXECHTqQedbUNDSeNWVkYd+51ZYyiJLL8
         8bloCJmYuBKgBRmNV20hKtlfbu7AJb0D1ZRWAGsdCK4pBiMw8I0HOcv0qM6QyWte+OcZ
         o6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709886160; x=1710490960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBCprgFYoUn8Y+xzvtdODul06R5mYKc2lB7UpcRimLs=;
        b=IKK19Gmdf8/L4exbZHH2ED54x9BBar1uNDBRKbb6bGnbG5MWtpGenXnN26Khjl2sT4
         +oYn4VMOthUlWJeD/9Xpqj5pkCnM1lDZ8RAytulTOUJSuUreDX74tAHuARRHxDh9r4mS
         WcBxiimCYsjTvpF4KOxYjIQQbsoIhyvnszrGHyNJXLBmuleYCYh9iaw09B6xE01gV0T5
         hly6hERHEFphKVxD8LwFyEzOQ8CI4GVrKb8yT3xzN0e/eJLC9c/rwBNvfFel4MQyW6Bw
         IPk00VNuddHc2XmrgMrN1NW8NldcOJtvTUswdIERkWGexgj1t3V80Sk2yZJm7qBFPVGu
         CtIA==
X-Forwarded-Encrypted: i=1; AJvYcCXO73U6PYepjgllVXxGRzXg0EnJMfZYU62KlYltq5HMLNUFVmR9TdmD1BnzGyB8H5fCFgBNxPMCgtkt9ko4DVnqpPutuiHfVy7UkDPw
X-Gm-Message-State: AOJu0Yx6KW4g+NMP4ixHKi3dcGumLm9990C/u+OF0xUDBEDxwfB8rWAq
	cy7eP8ZiFVxYG/fLLvlOWPOAsga9KeIlMpaJa+24XveK5QZMvW+U+YKPj6SuDiw=
X-Google-Smtp-Source: AGHT+IEiYBBpM8K7sbNyEwn/ldOTAjZLg1+TPM2gMFJf1c64KvlE/S9fIpTtG+jxYjLq/oiOv1dlZQ==
X-Received: by 2002:a17:906:3c4f:b0:a3e:b523:90b with SMTP id i15-20020a1709063c4f00b00a3eb523090bmr14446616ejg.14.1709886160454;
        Fri, 08 Mar 2024 00:22:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709066b9a00b00a45b81acdfbsm2703484ejr.210.2024.03.08.00.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 00:22:40 -0800 (PST)
Message-ID: <b1913db9-a8cc-4cee-b1af-7be9f8223298@linaro.org>
Date: Fri, 8 Mar 2024 09:22:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 8/9] net: hisi_femac: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240307-net-v9-0-6e0cf3e6584d@outlook.com>
 <20240307-net-v9-8-6e0cf3e6584d@outlook.com>
 <37ebeeca-e53b-445b-9fa7-53a1b7a4dcd3@linaro.org>
 <SEZPR06MB695921BD3235F62E5D37E61F96272@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <1cdbe5b8-ed3a-46a6-bc73-6bf35e3305f2@linaro.org>
 <SEZPR06MB69598718CCABAA52ADB34F0496272@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69598718CCABAA52ADB34F0496272@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 09:18, Yang Xiwen wrote:
> On 3/8/2024 4:09 PM, Krzysztof Kozlowski wrote:
>> On 08/03/2024 09:07, Yang Xiwen wrote:
>>> On 3/8/2024 4:02 PM, Krzysztof Kozlowski wrote:
>>>> On 07/03/2024 12:34, Yang Xiwen via B4 Relay wrote:
>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>
>>>>> Register the sub MDIO bus if it is found. Also implement the internal
>>>>> PHY reset procedure as needed.
>>>> ...
>>>>
>>>>>    
>>>>> @@ -946,6 +991,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>>>    
>>>>>    static const struct of_device_id hisi_femac_match[] = {
>>>>>    	{.compatible = "hisilicon,hi3516cv300-femac",},
>>>>> +	{.compatible = "hisilicon,hi3798mv200-femac",},
>>>> Why do you keep growing this table?
>>>
>>> I'm completely confused. Don't I need to keep binding and driver
>>> compatible ids sync?
>>>
>>>
>>> The FEMAC cores on 2 SoCs are compatible afaik. That's why i want to add
>>> a generic "hisilicon,hisi-femac" compatible. Though i know nothing about
>>> the mysterious version numbers (v1, v2 etc..) documented in the old
>>> binding, so i want them to be removed. Instead only keep one generic
>>> fallback compatible.
>>>
>>>
>>> Do you mean that i broke the backward compatibility for
>>> "hisilicon,hi3516cv300-femac"?
>> No. I meant, use one as fallback and only fallback needs to be in the
>> device ID table. There are dozens if not hundreds of such examples in
>> the tree.
> 
> 
> I don't think an arbitrary SoC compatible is a good name for a fallback 
> compatible. Why can't we have "hisilicon,hisi-femac" instead of the odd 

Why? Anyway, why rules for Hisilicon should be different than for
everyone else?

> "hisilicon,hi3516cv300-femac", If we are not going to keep backward 
> compatibility? Hi3516CV300 is just an old and outdated ordinary SoC 
> after all, but the FEMAC core is still being used in latest SoCs afaik. 
> I can't see the reason to relate this core to some old SoC and keep the 
> compatible forever.

Why rules for Hisilicon should be different than for everyone else?


Best regards,
Krzysztof


