Return-Path: <linux-kernel+bounces-93516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DCA8730E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1C3B28A66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16855D901;
	Wed,  6 Mar 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TnLSS4vr"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620435D48E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714322; cv=none; b=nE1dA7/XFtid7iu2nNi1/BFxKOlt+OINdC0LKvo7XTFs921/7gEu8SsX4g0wWI4Lxb2KrkywDQCpO5ulgerV/9jEcvFrUwkjJtF7wTUXdhuJHGsw1uP4DZ7xWjarAjCrpArnQJ0Q4HqC5ykvDNjR63tvEcVXhPUXVTB3mYoI8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714322; c=relaxed/simple;
	bh=1j7FVYWOl4e4ea+0P/SG0uIg0cAbesMlIJniqXAFIOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ETKa9sVeXjfZkGbXGwtzK5kpRal3QW1g0ERE/mD90tht4BgC2eyU0/TBvG6a9amgZ0s15oKtEASyQefjeCtVbLYfNao6swBb6IZYdqKlH9SrZfR8zWNQOfwOWBM9i/Wm3YGD8iMQpeEjSQo2oYq7AaUIao37NnuxG8poKIb6xCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TnLSS4vr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso1807307a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709714318; x=1710319118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7AhbRz6OtQJVItGlMtQVOqS/HRoKaHG5JWZSZ3Yc8g=;
        b=TnLSS4vrdsswQxChnR4LphJAE5fx9KlN4KezKDf0JBM0fMJBM0k82fS87N9l1VTwYe
         oKZnp5w4D3TEGvXKoEECUco40/9t0UaItp59div/v4U492l1/dUSnPKn9rqKX4afSQ7c
         JYeTVR+Fhn783sO+6SHGjSQ+VpVfm+5QQEktzZvIaOjd9+TRtNips2vs7jSIQKLWSncC
         yTJM8s2baLEII1QMfdcEe+nsojYyDxHgEyqANgwXeEp44W//bmR7cMrGIDXX8q9CmZ5d
         wVsDu7HXg+1ZkiFPlgyWt6cN9DAV0PK8GetBvVn/qTTtIIExGtZyyexgFhsWPoCUXPcs
         5K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714318; x=1710319118;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7AhbRz6OtQJVItGlMtQVOqS/HRoKaHG5JWZSZ3Yc8g=;
        b=vSShlkpS2TCFlOOLDje8KsIqJ001B66c0zKscKsp6MQJUWI8uLZqAzzP4GiMWeYF7F
         h7SneAcUOyKKGK2dPo354mz+/e7aPfGQYxKDDqrjZkLtCoY4qrlxSGd23Xjcaml9h+R2
         OQgVRG4b92FQHHTpqxrvty1CPmP70xo1gCxoMIm0XZlxK8nH2VtTVCQVhUXnatvBF0ht
         ipOlT7hBkL3Q0ZTzoFlp08u6nWRu298blb4WJ0R5RVTTSTjMs2L+GSc6Ltwvf8fv2kzv
         mzbve+9yFilZCMY6A53RZPPv6A/XEzD2+LUlF16LTQDHb/0Lyhg+7EdQjNqoHmzuU6So
         +nqw==
X-Forwarded-Encrypted: i=1; AJvYcCUfmOSkzMm+rmFtVLYeOS77k4WkcQwubTCSjtVr8mr+X15BjMTFay7lfa0yiKKJR+wmdJT01tpq9D8SyL26264NhOl/JAlivgElic0w
X-Gm-Message-State: AOJu0Yw4waJmsaB6RPbS/Hx7aC42qGKPbBeDGqdI22SxGjWXCGRHW2+L
	j5W5YGB9omcdcqlmmpcARkbWkYgLqIzS0D1Opr6WBiLXhkWPiHXTFuHnkTwitGc=
X-Google-Smtp-Source: AGHT+IE2g9PqQGFjWHN2nFj43dtlU1h78UFJwGeGQAKRgBRTVUB8WbBGclSqQnfU7K/3jY0zazqNBg==
X-Received: by 2002:a17:906:34c9:b0:a45:1d32:ac7 with SMTP id h9-20020a17090634c900b00a451d320ac7mr5749166ejb.42.1709714318517;
        Wed, 06 Mar 2024 00:38:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id yk1-20020a17090770c100b00a42f4678c95sm6873403ejb.59.2024.03.06.00.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:38:38 -0800 (PST)
Message-ID: <2f5ee8f2-9d07-471a-92e5-d547fdb9454d@tuxon.dev>
Date: Wed, 6 Mar 2024 10:38:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 37/39] ARM: dts: at91: sam9x7: add device tree for SoC
Content-Language: en-US
To: Varshini.Rajendran@microchip.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Nicolas.Ferre@microchip.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223173051.673490-1-varshini.rajendran@microchip.com>
 <9b5cf569-bbff-4520-8815-70b6f4c41625@tuxon.dev>
 <e4e0aba6-9ee4-45b6-80c5-02c430af9e10@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e4e0aba6-9ee4-45b6-80c5-02c430af9e10@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04.03.2024 18:33, Varshini.Rajendran@microchip.com wrote:
> Hi Claudiu,
> 
> Thanks for your time in reviewing this patch. I will address all your 
> comments in the next version. There are some clarifications provided 
> inline below.
> 
> On 03/03/24 5:54 pm, claudiu beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 23.02.2024 19:30, Varshini Rajendran wrote:
>>> Add device tree file for SAM9X7 SoC family.
>>>
>>> Co-developed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>> ---
>>> Changes in v4:
>>> - Added pwm node support
>>> - Added microchip,nr-irqs to the interrupt-controller node for the
>>>    driver to fetch the NIRQs
>>> - Dropped USB nodes owing to the discussion here
>>>   https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
>>> (Explained elaborartely in the cover letter)
>>> ---
>>>   arch/arm/boot/dts/microchip/sam9x7.dtsi | 1214 +++++++++++++++++++++++
>>>   1 file changed, 1214 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip

[ ... ]

>>> +             reset_controller: reset-controller@fffffe00 {
>>> +                     compatible = "microchip,sam9x7-rstc", "microchip,sam9x60-rstc";
>>> +                     reg = <0xfffffe00 0x10>;
>>> +                     clocks = <&clk32k 0>;
>>> +             };
>>> +
>>> +             power_management: power-management@fffffe10 {
>>
>> Usually the node name for this is poweroff. Any reason you changed it like
>> this?
>>
> Yes Claudiu. Based on the comment given for the version 2.

I think poweroff fits better. Documentation is also using poweroff for node
name. The rest of at91 device uses it. And poweroff is what this controller
does (it is named shutdown controller).

> 
> https://patches.linaro.org/project/linux-mmc/patch/20230623203056.689705-44-varshini.rajendran@microchip.com/#:~:text=Usually%20power%2Dmanagement%20or%20reset%2Dcontroller%20or%20something%20like%20this.
> 
>>> +                     compatible = "microchip,sam9x7-shdwc", "microchip,sam9x60-shdwc";
>>> +                     reg = <0xfffffe10 0x10>;
>>> +                     clocks = <&clk32k 0>;
>>> +                     #address-cells = <1>;
>>> +                     #size-cells = <0>;
>>> +                     atmel,wakeup-rtc-timer;
>>> +                     atmel,wakeup-rtt-timer;
>>> +                     status = "disabled";
>>> +             };
>>> +
>>> +             rtt: rtc@fffffe20 {
>>> +                     compatible = "microchip,sam9x7-rtt", "atmel,at91sam9260-rtt";
>>> +                     reg = <0xfffffe20 0x20>;
>>> +                     interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>>> +                     clocks = <&clk32k 0>;
>>> +             };
>>> +
>>> +             clk32k: sckc@fffffe50 {
>>
>> Node name should be generic, e.g. clock-controller
>>
>>> +                     compatible = "microchip,sam9x7-sckc", "microchip,sam9x60-sckc";
>>> +                     reg = <0xfffffe50 0x4>;
>>> +                     clocks = <&slow_xtal>;
>>> +                     #clock-cells = <1>;
>>> +             };
>>> +
>>> +             gpbr: syscon@fffffe60 {
>>> +                     compatible = "microchip,sam9x7-gbpr", "atmel,at91sam9260-gpbr", "syscon";
>>
>> microchip,sam9x7-gbpr seems undocummented.
> 
> The patch that adds support is already applied.
> https://lore.kernel.org/linux-arm-kernel/169226306696.928678.2345448260460546641.b4-ty@kernel.org/

Ok, then there is a typo in this patch:
s/microchip,sam9x7-gbpr/microchip,sam9x7-gpbr

