Return-Path: <linux-kernel+bounces-58382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E684E581
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE2B28967
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FF7EF1F;
	Thu,  8 Feb 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X8AVj6qI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFB7D406
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411193; cv=none; b=EB+7yv1jnFjoC0/h3L/0Hoordy8CAAwnnLG2oXb4xBHcpJ/TL89vho5qeQiKIEVsLo/yt7LAuKo4AX1j8EyIWd9nrjXarijkj4408McPICsXozufzjKRxsE+uK5RlAlOEa00wrfp5qBnBx+TdNEfSF2qzmRUOXp87nhbf3+22LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411193; c=relaxed/simple;
	bh=yc6Zt2hehyFqKBwoD6aZdoobJ4fIeVmjIGmLwx90QIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrFVTu/D5HhVSUohYafQIeuJxnnBc7VigkeV9BcSst3r9Y5i2xKI6NLS7ANSn2rUhZ2/YSKPjDmg3OZrSH4ikHCTfDTWGp5haAVa4kU1cplmFk//sfJRNc9maK1EzXPcdv1EDvhCoy7XSskLg7lzipxJgAQoBLYoRt58QssGSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X8AVj6qI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so682345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707411189; x=1708015989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZT1UxOiVrDHIynryw4Nlj/MmW/BLc7DWyJF67SG4DDA=;
        b=X8AVj6qIxtUh5A39tiEOM1S3akLDAyhFWKNx3eZIQ/5NKt0Sp6fo60VFIfyzzx5RJL
         RZEJCHPpJKcC3Z6YEimgYv/U9wFNXwxNmHgK7KzUcpk6e+kW1EShKHG3slSH0LzOoZFI
         vPdQt53myF+VQ6O1T2az2hPY0qQmNO3ZX8xF10cGWZPrPPx30VU/6G7+Czfk4q/zt1B2
         tT7483pyDY7bnsbaegQXVO5g/MiLkP5s3VZbCjGbr/n4UgAa84WcZv+f/uZvNW7PL9IE
         3NCv9x2U3sle3itNSaE+82szPf3Q8FB9VuWeojx8a4ytebax+KqsjgZa315LWlZiQNUe
         Bj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411189; x=1708015989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT1UxOiVrDHIynryw4Nlj/MmW/BLc7DWyJF67SG4DDA=;
        b=o2sDyScw/AWrv1hvuuXQ7mpbfZnnnlVqe5vxNw6RdMxSknms0lfJ6U4G2FDWLcFpJu
         wj+xTu5I8ex8cIFn/RLDFRWwYZWKPVAjzP63/2jbn1Og356VikJCvO+NUCxGw5S/HWkv
         Zpf8NdE32cH84W7MH1PWtiHZtoI7QCcacc04tRnH6mXgTuD3McqsWtpetuOFrll2Ptf+
         ok8jNewPCAz+qpC/OAhJU2aYJ7laiWqvljzRlOoKxorTeA0J0MSQjdJ0OjCM5AByQ4Ew
         HBCM/gzEqDyLzXEM42URdzap7yIS9C9iOPMZx3mtfR8PFtgAMfSabiixmcJMaJhYdKVQ
         U9lA==
X-Gm-Message-State: AOJu0YwxYf3T/5XJSd7Osr1PJrkT6V/71MLyd5xPD2xfWXyzxVplPaOO
	pb90/azRd2GpAwkauWM8mCQIjrOiBkzWJ749hGK1Ck10urjRtN2RBntMNfkkcUs=
X-Google-Smtp-Source: AGHT+IGBr22Z6ACQ9/w6ayyS+L6lXv2vUq3SiUpYMPUXFdY2V/aOAsEGvexJMJND+A7XxxQshZubFQ==
X-Received: by 2002:a05:600c:1c21:b0:40d:3fee:97f6 with SMTP id j33-20020a05600c1c2100b0040d3fee97f6mr7052850wms.34.1707411189516;
        Thu, 08 Feb 2024 08:53:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCgbPZZ7zko4xImgI2de22H1Di8bnfniBlBZIeaYI1LCjutMSi4sL6loFFjSpUFYZdxHJ0oybDuTKnjTzavVMSE6mMXMkjuQgSRsipSN7J6QywmpRRcH21+l184D+5wMDh9ub7KkiYhlpI5Uk6pr4l09W2TDTD1vDAptzP4tRj1AkHRkZ+5nydwjKXE8zWV5LjbRGLwaBLKhWGWjTs77OfO5DJdFiPA3pUvbDbI9xohrxZbmNdn/yAqsRAxv5VGL6agf6Xre+F0FrNhbM6dL4yzJjqrAH6dVjBQZFfEEwv2ARhDqBKmizytiyBHsDxrxSZJCHmAKNnLE2x29ylkXN6T02i1p4R1Mdu/xk1+b4weFjFHsrq3es0LrUKYWfvApdFc/Fobab4yml/rVEVmCBD0xGtXcbAG8li8mIVXywL0Kn1040Q3v69VJrHwxeZ2XhDwzotc6EljttdTaPsHG2qfeipA8D6AySJ4GVA/h/D2yBK/8Dg1k+oo6cDljTReVA6KRcp9cU9+XVXo5nuf3x+ebXVTYqOr3+uD/PDI515LRJ7Z2ys/ROQLA+9hg9dpLEt87qLjQ+4Epf8OmL6+6VZOhzlIbevgGa6
Received: from [192.168.50.4] ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b004101e93d276sm2162175wmq.14.2024.02.08.08.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:53:08 -0800 (PST)
Message-ID: <e170f5f8-f95c-4553-b088-1072345fae53@tuxon.dev>
Date: Thu, 8 Feb 2024 18:53:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domain
 IDs
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-2-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
 <TYCPR01MB112698AB206332D13105C064186442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TYCPR01MB112698AB206332D13105C064186442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08.02.2024 18:28, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Thursday, February 8, 2024 3:46 PM
>> Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
>> domain IDs
>>
>> Hi, Biju,
>>
>> On 08.02.2024 16:30, Biju Das wrote:
>>> Hi Claudiu,
>>>
>>> Thanks for the patch.
>>>
>>>> -----Original Message-----
>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>> Sent: Thursday, February 8, 2024 12:43 PM
>>>> Subject: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
>>>> domain IDs
>>>>
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>  include/dt-bindings/clock/r9a07g043-cpg.h | 48
>>>> +++++++++++++++++++++++
>>>>  1 file changed, 48 insertions(+)
>>>>
>>>> diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-
>>>> bindings/clock/r9a07g043-cpg.h index 77cde8effdc7..eabfeec7ac37
>>>> 100644
>>>> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
>>>> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
>>>> @@ -200,5 +200,53 @@
>>>>  #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
>>>>  #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
>>>>
>>>> +/* Power domain IDs. */
>>>> +#define R9A07G043_PD_ALWAYS_ON		0
>>>> +#define R9A07G043_PD_GIC		1
>>>> +#define R9A07G043_PD_IA55		2
>>>> +#define R9A07G043_PD_MHU		3
>>>> +#define R9A07G043_PD_CORESIGHT		4
>>>> +#define R9A07G043_PD_SYC		5
>>>> +#define R9A07G043_PD_DMAC		6
>>>> +#define R9A07G043_PD_GTM0		7
>>>> +#define R9A07G043_PD_GTM1		8
>>>> +#define R9A07G043_PD_GTM2		9
>>>> +#define R9A07G043_PD_MTU		10
>>>> +#define R9A07G043_PD_POE3		11
>>>> +#define R9A07G043_PD_WDT0		12
>>>> +#define R9A07G043_PD_SPI		13
>>>> +#define R9A07G043_PD_SDHI0		14
>>>> +#define R9A07G043_PD_SDHI1		15
>>>> +#define R9A07G043_PD_ISU		16
>>>> +#define R9A07G043_PD_CRU		17
>>>> +#define R9A07G043_PD_LCDC		18
>>>> +#define R9A07G043_PD_SSI0		19
>>>> +#define R9A07G043_PD_SSI1		20
>>>> +#define R9A07G043_PD_SSI2		21
>>>> +#define R9A07G043_PD_SSI3		22
>>>> +#define R9A07G043_PD_SRC		23
>>>> +#define R9A07G043_PD_USB0		24
>>>> +#define R9A07G043_PD_USB1		25
>>>> +#define R9A07G043_PD_USB_PHY		26
>>>> +#define R9A07G043_PD_ETHER0		27
>>>> +#define R9A07G043_PD_ETHER1		28
>>>> +#define R9A07G043_PD_I2C0		29
>>>> +#define R9A07G043_PD_I2C1		30
>>>> +#define R9A07G043_PD_I2C2		31
>>>> +#define R9A07G043_PD_I2C3		32
>>>> +#define R9A07G043_PD_SCIF0		33
>>>> +#define R9A07G043_PD_SCIF1		34
>>>> +#define R9A07G043_PD_SCIF2		35
>>>> +#define R9A07G043_PD_SCIF3		36
>>>> +#define R9A07G043_PD_SCIF4		37
>>>> +#define R9A07G043_PD_SCI0		38
>>>> +#define R9A07G043_PD_SCI1		39
>>>> +#define R9A07G043_PD_IRDA		40
>>>> +#define R9A07G043_PD_RSPI0		41
>>>> +#define R9A07G043_PD_RSPI1		42
>>>> +#define R9A07G043_PD_RSPI2		43
>>>> +#define R9A07G043_PD_CANFD		44
>>>> +#define R9A07G043_PD_ADC		45
>>>> +#define R9A07G043_PD_TSU		46
>>>
>>> Not sure from "Table 42.3 Registers for Module Standby Mode"
>>>
>>> Power domain ID has to be based on CPG_BUS_***_MSTOP or CPG_CLKON_***
>>> As former reduces number of IDs??
>>
>> If I understand correctly your point here, you want me to describe PM
>> domain in DT with something like:
>>
>> power-domains = <&cpg CPG_BUS_X_MSTOP>;
> 
> MSTOP bits are distinct for each IP.
> 
> <&cpg CPG_BUS_MCPU1_MSTOP x>; x =1..9
> 
> 2=MTU IP
> 
> 4= GPT
> 
> etc...
> 
> Is it something work??

It might work. But:

- you have to consider that some IPs have more than one MSTOP bit, thus, do
  we want to uniquely identify these with all MSTOP bits (thus the 2nd cell
  being a bitmask) or only one is enough?
- some HW blocks (e.g. OTFDE_DDR) have no MSTOP bits associated (as of my
  current research), so, only PWRDN
- some HW blocks have both MSTOP and PWRDN
- if future hardware implementation will spread the MSTOP bits for one IP
  to more than one register then this proposal will not work

Having a unique identified decoupled from MSTOP registers or PWRDN offers
support to use the same code base for future usage. This is what I can tell
at the moment.

> 
>>
>> where X={ACPU, PERI_CPU, PERI_CPU2, REG0, REG1} ?
>>
>> With this, I still see the necessity of a 3rd identifier that will be IP
>> specific to be able to uniquely match b/w DT description and registered
>> power domain. FMPOV, this will lead to a more complicated implementation.
>>
>> We need a unique ID that the pm domain xlate will use to xlate the DT
>> binding to driver data structures.
> 
> Ok.
> 
> Cheers,
> Biju
> 

