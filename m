Return-Path: <linux-kernel+bounces-61397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FFB8511DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F5C283446
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BA38DDD;
	Mon, 12 Feb 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TiRxWv9Z"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15639846
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736142; cv=none; b=PNW0kCsBH4HXqI6jNp9nLDBMJmqXRRsRrNBMDmUrRMgvBcdtUqgOXCZjQd6jr7KCDker2grcsGkItg9XtSBqoSKEPFVsIvv+5hSAvTveznuOsFwJux5IgaavrrivCM+nLuzbWN+yhWabJLTkSidj6t6kjY8mBZZtw6Ip4VGVwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736142; c=relaxed/simple;
	bh=n7pGJC8iqunN1hSKHOcQpsCH8YnEcFiqx3Po50Kk0K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBok8uWm8fX3zLojTOIfFO+sjcBwQC/mjAHjFeOjlxRdHHywQmIIZQZ3ovwGPa60BnUB24KEA0cf0K/UTLyX9dCWYUdPQNgddbaTqCPUirX8UK+1K6xNF2ReoFfYUqYYiehy0q2UnPzuaxoyRjcclraNqWVWPV5Pn7KsZnAA6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TiRxWv9Z; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51168addef1so5651055e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707736138; x=1708340938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgtCKhK82z+I2PwaVcKMp99Q6wqABgNsVHzLAE9dAn0=;
        b=TiRxWv9ZUxCoPg/H+kQvn0zebUmCAYMBd+c01zE9HKLq8456MUfayXfMMCoVS7ljyr
         GHOVZG2Ma1YEUTZcMEqdKMzud0D0D3rtzUf0U6qJ/CJJl3f9Oxv7VSdLUqHkFjJZhrLU
         4v0cA+S+WZP9uHsbcy5c+5P2RbOEEYJ0fHrEGaJ4WKL8B9Ta1n3p9cFm7hYyaIxrJaeo
         /rvI/G2Uj9IRG18snZgCFfRIYWVVHbBdX9uDiG1WEU0xHvAn4V4uLChBu2TAn8FexbMV
         axQw7Uw51cTsR2Kb9kcDhcHfgFYIblIzMMEYLO4PJ45obcDsbQiz4O27p1rCHrvE/NAU
         SbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736138; x=1708340938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgtCKhK82z+I2PwaVcKMp99Q6wqABgNsVHzLAE9dAn0=;
        b=pbLCD+B9qThmQmZedVP0yXs4RlgVNAhMP//voWpUqDAIFtvTPulyDrENxpBI96m1/Q
         Wo1lPIcGswNW6gepPOsTVNqcPNDdcG8R1zFpovOuFx0DUTOXi3F5UE479yQst7HeK5Zd
         sg9swspeQnFzxNgRKqsyVula2EHBnguVDsYIM2BywEO1PqXWXCwX3z+L8xfYl35/6eVa
         yTiv8wjKJUf8WmJa1ri6p1l/SMaevO59UiMVfL/1M+zlircLSgbPd6GU5/xJRaJkCct0
         60+JYk3ZKfUC/E8CtPVStaC+HWinAWUp8Pvu35dRBeMQMc57Mx15HmotJ9USEx0uPdVI
         e50w==
X-Forwarded-Encrypted: i=1; AJvYcCWxP1t4kdskS/h4MraCKmYCt9jvuPOC0ocyHyR3SDT4TQZNeVhPWCCgAvEsVqHWW2K4joayCNO0r8NQ3i1JmBCgU319Q/ic/A6sX8qd
X-Gm-Message-State: AOJu0YxRMQQae0zjL9gam9/63IuUsaqYG3pQhH+U57xl3latniGs5dH2
	YV838saKp5hueuqnoUBsSv/1adj35mqGXtUODZEwyuzFYq29doGCs62Ug0lyw7c=
X-Google-Smtp-Source: AGHT+IH8gaBRvO6QKQUrPxiD25VWApPudReK8NgbiCQc/XSlHiAxgcfJ7p7cminjrDMRArdPlCn8nA==
X-Received: by 2002:a05:6512:3b06:b0:511:83b3:a9aa with SMTP id f6-20020a0565123b0600b0051183b3a9aamr4080530lfv.6.1707736137995;
        Mon, 12 Feb 2024 03:08:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8yeUTmlC6AXe6nz+jYbF13B4T0HRNvlfOzDTAijU9nE/ugflYEEiia18f/syV5symAYoFb/2oWYh4e3d2w/nrU7iEVQfVa8FpOV+37/IrAQ5rxgS8rdSNHDr4TGQ17T54VTKN7KW9duYD5GIDo50lNRZKcUyLTYuQ7fDaDNrFmDTM8e3Wlga5PbZMv+7McplQMP4vflAjvNsxE/DeIPFBTwqTPNaANXD1tHhlKFr0ThOiH1+aX89nYu6S4kuh9GSrNKUZWqkx+si7g4qg3scnhRNFkha4ZBHWxA+hIOBpMbnouvNN/FdOJhwVxjEn32UHy8hial0CUYlH4vLAem1937X1sV6SgLa+4X10YRMNUUtNLrb+MZa/vugHqOqN5t3SdJWW+VG4ZXiXbN+s4rTOg7edeKEtZQN/C5EBb6mdKr7Tj8NMD2rmMWCvGGTBOBpJoh+Htqal3wtS5vMrZUdwAlkGkN9IsfMS8fSdXOYeXCrPGcLTOGgzKPxgpHIyrFpxhoRcLiIj2NYSxnMIPxWoiuYdy17F6gYIh0Rlev7XNYJOSNP1n1rroGj/tXHcSsNfBcDUMFr8aQOTeWgt695zTX5t6IYgLch5
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b00410cf4ee021sm2963960wmo.29.2024.02.12.03.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:08:57 -0800 (PST)
Message-ID: <4c2369c0-bcd0-47c8-aee5-3c901f7920de@tuxon.dev>
Date: Mon, 12 Feb 2024 13:08:55 +0200
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
 <e170f5f8-f95c-4553-b088-1072345fae53@tuxon.dev>
 <TYCPR01MB11269015C92AA327DC6BFA76586442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <786f90f4-ba47-46cb-b5e0-e3c42b1b741a@tuxon.dev>
 <TYCPR01MB11269A240E2EDD460D0B97B9786482@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TYCPR01MB11269A240E2EDD460D0B97B9786482@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.02.2024 10:59, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Monday, February 12, 2024 8:02 AM
>> Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
>> domain IDs
>>
>> Hi, Biju,
>>
>> On 08.02.2024 21:20, Biju Das wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: Thursday, February 8, 2024 4:53 PM
>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; geert+renesas@glider.be;
>>>> mturquette@baylibre.com; sboyd@kernel.org; robh@kernel.org;
>>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>>> magnus.damm@gmail.com; paul.walmsley@sifive.com; palmer@dabbelt.com;
>>>> aou@eecs.berkeley.edu
>>>> Cc: linux-renesas-soc@vger.kernel.org; linux-clk@vger.kernel.org;
>>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>>>> riscv@lists.infradead.org; Claudiu Beznea
>>>> <claudiu.beznea.uj@bp.renesas.com>
>>>> Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add
>>>> power domain IDs
>>>>
>>>>
>>>>
>>>> On 08.02.2024 18:28, Biju Das wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>>>> Sent: Thursday, February 8, 2024 3:46 PM
>>>>>> Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add
>>>>>> power domain IDs
>>>>>>
>>>>>> Hi, Biju,
>>>>>>
>>>>>> On 08.02.2024 16:30, Biju Das wrote:
>>>>>>> Hi Claudiu,
>>>>>>>
>>>>>>> Thanks for the patch.
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>>>>>> Sent: Thursday, February 8, 2024 12:43 PM
>>>>>>>> Subject: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add
>>>>>>>> power domain IDs
>>>>>>>>
>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>>
>>>>>>>> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>>>>>>>>
>>>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>>> ---
>>>>>>>>  include/dt-bindings/clock/r9a07g043-cpg.h | 48
>>>>>>>> +++++++++++++++++++++++
>>>>>>>>  1 file changed, 48 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h
>>>>>>>> b/include/dt- bindings/clock/r9a07g043-cpg.h index
>>>>>>>> 77cde8effdc7..eabfeec7ac37
>>>>>>>> 100644
>>>>>>>> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
>>>>>>>> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
>>>>>>>> @@ -200,5 +200,53 @@
>>>>>>>>  #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
>>>>>>>>  #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
>>>>>>>>
>>>>>>>> +/* Power domain IDs. */
>>>>>>>> +#define R9A07G043_PD_ALWAYS_ON		0
>>>>>>>> +#define R9A07G043_PD_GIC		1
>>>>>>>> +#define R9A07G043_PD_IA55		2
>>>>>>>> +#define R9A07G043_PD_MHU		3
>>>>>>>> +#define R9A07G043_PD_CORESIGHT		4
>>>>>>>> +#define R9A07G043_PD_SYC		5
>>>>>>>> +#define R9A07G043_PD_DMAC		6
>>>>>>>> +#define R9A07G043_PD_GTM0		7
>>>>>>>> +#define R9A07G043_PD_GTM1		8
>>>>>>>> +#define R9A07G043_PD_GTM2		9
>>>>>>>> +#define R9A07G043_PD_MTU		10
>>>>>>>> +#define R9A07G043_PD_POE3		11
>>>>>>>> +#define R9A07G043_PD_WDT0		12
>>>>>>>> +#define R9A07G043_PD_SPI		13
>>>>>>>> +#define R9A07G043_PD_SDHI0		14
>>>>>>>> +#define R9A07G043_PD_SDHI1		15
>>>>>>>> +#define R9A07G043_PD_ISU		16
>>>>>>>> +#define R9A07G043_PD_CRU		17
>>>>>>>> +#define R9A07G043_PD_LCDC		18
>>>>>>>> +#define R9A07G043_PD_SSI0		19
>>>>>>>> +#define R9A07G043_PD_SSI1		20
>>>>>>>> +#define R9A07G043_PD_SSI2		21
>>>>>>>> +#define R9A07G043_PD_SSI3		22
>>>>>>>> +#define R9A07G043_PD_SRC		23
>>>>>>>> +#define R9A07G043_PD_USB0		24
>>>>>>>> +#define R9A07G043_PD_USB1		25
>>>>>>>> +#define R9A07G043_PD_USB_PHY		26
>>>>>>>> +#define R9A07G043_PD_ETHER0		27
>>>>>>>> +#define R9A07G043_PD_ETHER1		28
>>>>>>>> +#define R9A07G043_PD_I2C0		29
>>>>>>>> +#define R9A07G043_PD_I2C1		30
>>>>>>>> +#define R9A07G043_PD_I2C2		31
>>>>>>>> +#define R9A07G043_PD_I2C3		32
>>>>>>>> +#define R9A07G043_PD_SCIF0		33
>>>>>>>> +#define R9A07G043_PD_SCIF1		34
>>>>>>>> +#define R9A07G043_PD_SCIF2		35
>>>>>>>> +#define R9A07G043_PD_SCIF3		36
>>>>>>>> +#define R9A07G043_PD_SCIF4		37
>>>>>>>> +#define R9A07G043_PD_SCI0		38
>>>>>>>> +#define R9A07G043_PD_SCI1		39
>>>>>>>> +#define R9A07G043_PD_IRDA		40
>>>>>>>> +#define R9A07G043_PD_RSPI0		41
>>>>>>>> +#define R9A07G043_PD_RSPI1		42
>>>>>>>> +#define R9A07G043_PD_RSPI2		43
>>>>>>>> +#define R9A07G043_PD_CANFD		44
>>>>>>>> +#define R9A07G043_PD_ADC		45
>>>>>>>> +#define R9A07G043_PD_TSU		46
>>>>>>>
>>>>>>> Not sure from "Table 42.3 Registers for Module Standby Mode"
>>>>>>>
>>>>>>> Power domain ID has to be based on CPG_BUS_***_MSTOP or
>>>>>>> CPG_CLKON_*** As former reduces number of IDs??
>>>>>>
>>>>>> If I understand correctly your point here, you want me to describe
>>>>>> PM domain in DT with something like:
>>>>>>
>>>>>> power-domains = <&cpg CPG_BUS_X_MSTOP>;
>>>>>
>>>>> MSTOP bits are distinct for each IP.
>>>>>
>>>>> <&cpg CPG_BUS_MCPU1_MSTOP x>; x =1..9
>>>>>
>>>>> 2=MTU IP
>>>>>
>>>>> 4= GPT
>>>>>
>>>>> etc...
>>>>>
>>>>> Is it something work??
>>>>
>>>> It might work. But:
>>>>
>>>> - you have to consider that some IPs have more than one MSTOP bit,
>>>> thus, do
>>>>   we want to uniquely identify these with all MSTOP bits (thus the
>>>> 2nd cell
>>>>   being a bitmask) or only one is enough?
>>>
>>> We can have an encoding in that case 8:16 24 bit entries
>>
>> I consider this complicates the bindings. I don't consider this is the way
>> going forward. But I may be wrong. I'll let Geert to give his opinion on
>> it and change it afterwards, if any.
>>
>>>
>>>> - some HW blocks (e.g. OTFDE_DDR) have no MSTOP bits associated (as of
>> my
>>>>   current research), so, only PWRDN
>>>
>>> Why do we want to add power domain support for DDR?
>>
>> To power it up (in case bootloader does any settings in this area) such
>> that the system will not block while booting.
> 
> DDR is enabled by TF_A and is not touched by linux, so why are we adding
> Power domain at all in first place. TZC DDR is not accessible in normal world.
> 
> So if you don't add DDR power domains, linux doesn't know about any thing about
> and it should work like current case.
> 
>>
>> It is explained in cover letter:
>>
>> The current DT
>> bindings were updated with module IDs for the modules listed in tables
>> with name "Registers for Module Standby Mode" (see HW manual) exception
>> being RZ/G3S where, *due to the power down functionality*, the DDR,
>> TZCDDR, OTFDE_DDR were also added, to avoid system being blocked due to
>> the following lines of code from patch 7/17.
>>
>> +       /* Prepare for power down the BUSes in power down mode. */
>> +       if (info->pm_domain_pwrdn_mstop)
>> +               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base +
>> + CPG_PWRDN_MSTOP);
>>
>>>
>>>> - some HW blocks have both MSTOP and PWRDN
>>>
>>> That will be an array right?
>>
>> I'm not sure what you want to say here.
> 
> This has to be an array PM domains(multi PM domain) like clocks?

Forgot to reply to this...

Yes, this should work for IPs having both MSTOP and PWRDN. It is an
alternative to the current implementation. I kept both MSTOP and PWRDN
under the control of the same PM domain in the current implementation.

But if future hardware implementation will spread the MSTOP bits for one IP
to more than one register (I don't know if this is likely to happen but it
may worth considering) then multiple MSTOP bits for the same power domain
cannot be handled by this approach and describing the domain with register
offset and bitmask.

> 
> Or 
> 
> It can be  handled as sibliling power domain like sibling clocks in RZ/G2L Gbether.

Kind of this implementation was proposed initially (linking the MSTOP to
the IP clocks inside the clock driver).

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju

