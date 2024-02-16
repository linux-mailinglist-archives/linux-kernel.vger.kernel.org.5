Return-Path: <linux-kernel+bounces-68234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA98577A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EEB280DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641021BF5D;
	Fri, 16 Feb 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZZ3VGyvk"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF41BDD5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071859; cv=none; b=lb4qmHb0lvoU3yb5BuB8/hfmGb1vrQd66nwX73P1L8AJ0MWGB9cPNoS6D8OHEZqqITazAS8gEiJmW48JLTTjzWrBYtCcrv5fOyCuQI7cnT60ueOtc9r/9dGb+EqV5aA9Hcjn8SwSjwzObVwiYx2KIHx2TptCsIoUB0kRpxs1uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071859; c=relaxed/simple;
	bh=LRdXuS6SlWoXUj3BpsfxkRzGVkTWSDWlYOUhpIX3lB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwnyuqqeWs/khF9Co7QYMP2cJYxY3cGBa9Dc9te5G2jrpE1CCgwwmCtZffqJkuQ5lrny0dsmPF7r/gI55p1gJm7J46+Ol3EFamO74MDBt67QYfoBmX6KxwPHiSz0KfF54d9MkztXRANjl4QI/iey8LqIt/aP9FoJo2oGwKktJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZZ3VGyvk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0f1ec376bso20928181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708071854; x=1708676654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+eVmXDTn4hL2mph2w3UqRUyhBuuKz04HCEJ0eag7JE=;
        b=ZZ3VGyvkQaJOLpIP3xKVr8SVqAm8wfHHDWNvA2U0oF40bZjwKGzb+U11pfGHBaotBu
         ulZzolMWgD60xmgO4B/uym7QGdy4LmS/WpTe51lQe0/TXbySCOPt4Tgw/kldEvkl9ybS
         INzeGKH7zU8iRILJyY3GXBr36QNSIJInoAv0JPqK4kPqKeylXWHu9qNDRe0BKaGmjuAr
         TxCPufDI7IOGXgFjQQUQAI6OOmJvdFnSQgERx36Lkgt3ynrA3cm6fNtHmlpuSqeykile
         KpgYMUQqXQezu0ptfx0lK/wJ1ZaHzKo5bLgnSOA5VM6YGgQOFusDlC1nsoiRwrCBIwAJ
         Z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708071854; x=1708676654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+eVmXDTn4hL2mph2w3UqRUyhBuuKz04HCEJ0eag7JE=;
        b=jxwPOWBwR6/l9YZ57X3u0uLIu7DG/y96Ftu74fghtLIPZ5PbBtP1YXK+NDWP6BCsb6
         I7iIETyBRWKSRK8kjtys3KzWL6is3PsfFLU2kEN59UsTMN8Luiw06EtBVdPwgbOvu4FG
         wTtbK/4RH3CzHDiIyy3uK0/INIGzxFM8yjUmGL3Zw6JiZmvd7ixwj5+tecfJAE2N8OfS
         WgXouz8iLmkWk1GHKpj/GiXaf8/FuzCYBXHE0jrPWm815xwX1cXgNyNVdiBgTdBbQiJS
         vBFj/ZC+dBqGATSJ+B5geBsXp7DUZlA9nhofED8twY9ovCQAZSTCbXpPKgq/s5lfVuQN
         GDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcfuFQiE+g0qHnICjQxSY/AY/RHaZEO8PevDEeuyTMv+KVmp7IFqGIx+GMbeAtgF8WPA91mfVCMpXiojiDXf6v/JxJtaMne20PMeHc
X-Gm-Message-State: AOJu0YzAQpvXDYTTn29bIcBRS9y3d/0zBYmz+r2vsK+tRk6qQ07KpGqC
	WVZfj8wQTsRwgJFYcqUZWeaoeTy0pXetySZwWhqWliMql8s5BzPNUfI8OKH9U+Q=
X-Google-Smtp-Source: AGHT+IHzQrJBlxyQoOMailFbEvOV869uWEakGroOBQUjEOqKOCDD4o5U99JK4uGR9CI7gfM74Ydexw==
X-Received: by 2002:a2e:a228:0:b0:2cf:1ae2:dca with SMTP id i8-20020a2ea228000000b002cf1ae20dcamr2662775ljm.16.1708071854412;
        Fri, 16 Feb 2024 00:24:14 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id y19-20020a1c4b13000000b00412156abf32sm1545846wma.16.2024.02.16.00.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 00:24:14 -0800 (PST)
Message-ID: <cfafd563-1387-4775-bcb0-434ce3774827@tuxon.dev>
Date: Fri, 16 Feb 2024 10:24:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Mihai.Sain@microchip.com
Cc: conor@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com, andre.przywara@arm.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
 <20240215-lustily-flick-69cb48b123c3@spud>
 <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240216075609e58aeee4@mail.local>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240216075609e58aeee4@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.02.2024 09:56, Alexandre Belloni wrote:
> On 16/02/2024 06:58:10+0000, Mihai.Sain@microchip.com wrote:
>>> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
>>> index 269e0a3ca269..c030b318985a 100644
>>> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
>>> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
>>> @@ -958,6 +958,30 @@ i2c9: i2c@600 {
>>>  			};
>>>  		};
>>>  
>>> +		flx10: flexcom@e2820000 {
>>> +			compatible = "atmel,sama5d2-flexcom";
>>
>> My comment here was ignored:
>> https://lore.kernel.org/all/20240214-robe-pregnancy-a1b056c9fe14@spud/
>>
>> The SAMA7G5 has the same flexcom controller as SAMA5D2 MPU.
>>
> 
> Still, it needs its own compatible plus a fallback to
> atmel,sama5d2-flexcom

I agree with this. Though, flexcom documentation is subject to YAML
conversion (a patch has been re-posted these days [1] and *maybe* it will
be integrated this time). And there are multiple SoC DTs that need to be
updated with their own flexcom compatible (lan966x, sam9x60, sama7g5).

To avoid conflicting with the work at [1] and postponing this series we may
do the update after the [1] is done.

Let me know your thoughts. Either way is fine by me.

Thank you,
Claudiu Beznea

[1]
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240214-sama5d2-flexcom-yaml-v1-1-5dedd0eba08e@microchip.com/

> 
>> https://github.com/torvalds/linux/blob/master/drivers/mfd/atmel-flexcom.c#L83
>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt#L8
> 

