Return-Path: <linux-kernel+bounces-61183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C829F850E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4942850C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9A8C11;
	Mon, 12 Feb 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hHu/G79s"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF917BA5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724943; cv=none; b=tHi1OTrJQwwcIXtpSOCUgsXKixnysZWwF/7AVxviYdSNyOpo8BkpSToFEbLuNZB+pSE24kfTKq+7bG+/KOP+Zg57xq7BaZSPSpeFeYAK8lvVp57M5O0G7PGFIQeruTVvGOQKqjZKvjhzBqTGBOsWJROyImzgXzkS609Nu4HMMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724943; c=relaxed/simple;
	bh=P9ZnJPjtJi/mUWmuzkgcqSd84rmJC3JW1jKqTYKe0c8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nf5nJBFJHsDZdt913pVdi418/Tb6AgFdUYiQr/D0x9wf8/WC6k7N6bLvlQDCsJgVittNUY15umXT3Zwoog8q8k7aiKjui6oDI8TbITX4OWGMScaC6wqPHODHFG7LQ4cUo/tKqdOfG1mojO7KpBsIdEbB59CXBF7yf1f+ztB1T3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hHu/G79s; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114cd44f6aso3883558e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707724938; x=1708329738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6kTSFvoJSCAb4IlPNruLyHFuh4E6JyGL/srfT6B6AA=;
        b=hHu/G79sGcWdOu4syj9f5EcT/qWh5EAG5WLFdtF0uh2LB+GK0SJ3/SUAPfZr653Bec
         tVxQIqPwaZahefiCzUzlbeeYZUhOwF3/8Nm4gTb1zJ1o6G+LNE8sj7fYwuH6MiWWu9dt
         D+ujyZP73+NNwG0cNrPPSV54urypegRF7l3QPz/syBbjNJ0nlikV8MUTFO6AbDaK81I9
         WaMEBmoUcn6dZAjl2OTj4UAsiu6QmLSzYwb+d//z76r1BH8BhWzVVldS59wkaQfLC3Do
         SJSOvvB9kFK5CA74WEC/4Fw5acM4dx8RzAk719pAtKBxcWIBXUbhtQKyunpkCZuZ7Ikw
         jCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707724938; x=1708329738;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6kTSFvoJSCAb4IlPNruLyHFuh4E6JyGL/srfT6B6AA=;
        b=P07FVc+G+vlwOpVQbcA5jTS9NB5485NA3lHVmQrY2Xv06yGJuw4Ayd9OpR37h5nf01
         PTbAkZutTwQJMXAK/PQq5o/lIrCUxGN1jdAtetSKO8kcKK/21aRPi/9ZjcCh2wORaaKh
         0B85YQQorheCr5VOU/xgbi5PgA/Ul23To7yaI/FSwdNCZcI5o4XqNEYZxSV0Oq5lniAn
         PK2rpfJKtKFrYAMHNm4QsZmgLPbNumBgDMDD45VIZbEbGvaqmKU/mbCD99C71b4cp2ke
         KtiQvw9JtLtrNSFdu69RUNJBK3tQ6kiMox86VCzoF/wVXByTC1qJXRiZv7DlMcs8vZOk
         QbuA==
X-Gm-Message-State: AOJu0Yx497/JalmJwuTz0l06HLous477u7taKWOv2D0cvZ5n3UOZTxV3
	1AcD6XIrw0tgQfCaIw70PX1DmTOo0eBrIqXCk/spN7L/HHvaN4ru+Iio+ppa/G4=
X-Google-Smtp-Source: AGHT+IHG7OGpNSz9MlIuHcO4LBN+HJoInPI5M3S3vsLEw4kJHoBn2YhvjFBlChl80qBp5evbBnMI+A==
X-Received: by 2002:a05:6512:3048:b0:511:676e:a491 with SMTP id b8-20020a056512304800b00511676ea491mr4147982lfb.18.1707724938071;
        Mon, 12 Feb 2024 00:02:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUIg9O3xUyXBEbp8LJcUWz3ubiINArcruNd79t1KPHWFs+g/LKuZCzvUtAXH3hEVkWyDXCkUwHkdnGLXp0DkYfnjwNrPVajP3shIvkwB9Si2MhbQIwjXV+J+6alE2zCSKUkT3iIZeO2C4U7UOWYKp96xX54xHAZ57qTSwkzY0PhzjotDCE5cF2f/YxiPBD/ob/FQUc3uT94vQ9+vHBmg0aK+RtQle0AxKtAbompXD/Yx9c3gTPZKt4QjWbcj6MtKf+lH3FM98D/cfpkDxHsiCxmt++mcU5MM8vIFhGSYnFXNX2Q25fgZFcLE2yQSNzFMH18QBpwDhkQSqSZFjDnNehyAYzbK88R1wO5aEwAbcdBzlo4nPJOHxmkPbp727Gg+50qzLq2HzJ9xOgtcDizf6Swin/Yh572ZiUNZArYue6PJTmTwD7O8AVQitaxunV3WIBqnlZlExKDFFzE50w21RiDDwb4E6v2gZoRvekjBjoxCbhN2gCc9rmbZWFuDVEUDe9d6tSqduFB1Ej09OY9iGzwaoQV7oYU6YmsWSQDNGrCEt7pjm1UlUHcJn4SHcybH0vcIdpqfcX4qwmJGzocoFL7Np9hurPsFsH
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b00411062c123esm390222wmo.26.2024.02.12.00.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 00:02:17 -0800 (PST)
Message-ID: <786f90f4-ba47-46cb-b5e0-e3c42b1b741a@tuxon.dev>
Date: Mon, 12 Feb 2024 10:02:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domain
 IDs
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
Content-Language: en-US
In-Reply-To: <TYCPR01MB11269015C92AA327DC6BFA76586442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 08.02.2024 21:20, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Thursday, February 8, 2024 4:53 PM
>> To: Biju Das <biju.das.jz@bp.renesas.com>; geert+renesas@glider.be;
>> mturquette@baylibre.com; sboyd@kernel.org; robh@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> magnus.damm@gmail.com; paul.walmsley@sifive.com; palmer@dabbelt.com;
>> aou@eecs.berkeley.edu
>> Cc: linux-renesas-soc@vger.kernel.org; linux-clk@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> riscv@lists.infradead.org; Claudiu Beznea
>> <claudiu.beznea.uj@bp.renesas.com>
>> Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
>> domain IDs
>>
>>
>>
>> On 08.02.2024 18:28, Biju Das wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: Thursday, February 8, 2024 3:46 PM
>>>> Subject: Re: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add
>>>> power domain IDs
>>>>
>>>> Hi, Biju,
>>>>
>>>> On 08.02.2024 16:30, Biju Das wrote:
>>>>> Hi Claudiu,
>>>>>
>>>>> Thanks for the patch.
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>>>>> Sent: Thursday, February 8, 2024 12:43 PM
>>>>>> Subject: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power
>>>>>> domain IDs
>>>>>>
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>>>>>>
>>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>> ---
>>>>>>  include/dt-bindings/clock/r9a07g043-cpg.h | 48
>>>>>> +++++++++++++++++++++++
>>>>>>  1 file changed, 48 insertions(+)
>>>>>>
>>>>>> diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h
>>>>>> b/include/dt- bindings/clock/r9a07g043-cpg.h index
>>>>>> 77cde8effdc7..eabfeec7ac37
>>>>>> 100644
>>>>>> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
>>>>>> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
>>>>>> @@ -200,5 +200,53 @@
>>>>>>  #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
>>>>>>  #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
>>>>>>
>>>>>> +/* Power domain IDs. */
>>>>>> +#define R9A07G043_PD_ALWAYS_ON		0
>>>>>> +#define R9A07G043_PD_GIC		1
>>>>>> +#define R9A07G043_PD_IA55		2
>>>>>> +#define R9A07G043_PD_MHU		3
>>>>>> +#define R9A07G043_PD_CORESIGHT		4
>>>>>> +#define R9A07G043_PD_SYC		5
>>>>>> +#define R9A07G043_PD_DMAC		6
>>>>>> +#define R9A07G043_PD_GTM0		7
>>>>>> +#define R9A07G043_PD_GTM1		8
>>>>>> +#define R9A07G043_PD_GTM2		9
>>>>>> +#define R9A07G043_PD_MTU		10
>>>>>> +#define R9A07G043_PD_POE3		11
>>>>>> +#define R9A07G043_PD_WDT0		12
>>>>>> +#define R9A07G043_PD_SPI		13
>>>>>> +#define R9A07G043_PD_SDHI0		14
>>>>>> +#define R9A07G043_PD_SDHI1		15
>>>>>> +#define R9A07G043_PD_ISU		16
>>>>>> +#define R9A07G043_PD_CRU		17
>>>>>> +#define R9A07G043_PD_LCDC		18
>>>>>> +#define R9A07G043_PD_SSI0		19
>>>>>> +#define R9A07G043_PD_SSI1		20
>>>>>> +#define R9A07G043_PD_SSI2		21
>>>>>> +#define R9A07G043_PD_SSI3		22
>>>>>> +#define R9A07G043_PD_SRC		23
>>>>>> +#define R9A07G043_PD_USB0		24
>>>>>> +#define R9A07G043_PD_USB1		25
>>>>>> +#define R9A07G043_PD_USB_PHY		26
>>>>>> +#define R9A07G043_PD_ETHER0		27
>>>>>> +#define R9A07G043_PD_ETHER1		28
>>>>>> +#define R9A07G043_PD_I2C0		29
>>>>>> +#define R9A07G043_PD_I2C1		30
>>>>>> +#define R9A07G043_PD_I2C2		31
>>>>>> +#define R9A07G043_PD_I2C3		32
>>>>>> +#define R9A07G043_PD_SCIF0		33
>>>>>> +#define R9A07G043_PD_SCIF1		34
>>>>>> +#define R9A07G043_PD_SCIF2		35
>>>>>> +#define R9A07G043_PD_SCIF3		36
>>>>>> +#define R9A07G043_PD_SCIF4		37
>>>>>> +#define R9A07G043_PD_SCI0		38
>>>>>> +#define R9A07G043_PD_SCI1		39
>>>>>> +#define R9A07G043_PD_IRDA		40
>>>>>> +#define R9A07G043_PD_RSPI0		41
>>>>>> +#define R9A07G043_PD_RSPI1		42
>>>>>> +#define R9A07G043_PD_RSPI2		43
>>>>>> +#define R9A07G043_PD_CANFD		44
>>>>>> +#define R9A07G043_PD_ADC		45
>>>>>> +#define R9A07G043_PD_TSU		46
>>>>>
>>>>> Not sure from "Table 42.3 Registers for Module Standby Mode"
>>>>>
>>>>> Power domain ID has to be based on CPG_BUS_***_MSTOP or
>>>>> CPG_CLKON_*** As former reduces number of IDs??
>>>>
>>>> If I understand correctly your point here, you want me to describe PM
>>>> domain in DT with something like:
>>>>
>>>> power-domains = <&cpg CPG_BUS_X_MSTOP>;
>>>
>>> MSTOP bits are distinct for each IP.
>>>
>>> <&cpg CPG_BUS_MCPU1_MSTOP x>; x =1..9
>>>
>>> 2=MTU IP
>>>
>>> 4= GPT
>>>
>>> etc...
>>>
>>> Is it something work??
>>
>> It might work. But:
>>
>> - you have to consider that some IPs have more than one MSTOP bit, thus,
>> do
>>   we want to uniquely identify these with all MSTOP bits (thus the 2nd
>> cell
>>   being a bitmask) or only one is enough?
> 
> We can have an encoding in that case 8:16 24 bit entries

I consider this complicates the bindings. I don't consider this is the way
going forward. But I may be wrong. I'll let Geert to give his opinion on it
and change it afterwards, if any.

> 
>> - some HW blocks (e.g. OTFDE_DDR) have no MSTOP bits associated (as of my
>>   current research), so, only PWRDN
> 
> Why do we want to add power domain support for DDR?

To power it up (in case bootloader does any settings in this area) such
that the system will not block while booting.

It is explained in cover letter:

The current DT
bindings were updated with module IDs for the modules listed in tables
with name "Registers for Module Standby Mode" (see HW manual) exception
being RZ/G3S where, *due to the power down functionality*, the DDR,
TZCDDR, OTFDE_DDR were also added, to avoid system being blocked due
to the following lines of code from patch 7/17.

+       /* Prepare for power down the BUSes in power down mode. */
+       if (info->pm_domain_pwrdn_mstop)
+               writel(CPG_PWRDN_MSTOP_ENABLE, priv->base + CPG_PWRDN_MSTOP);

> 
>> - some HW blocks have both MSTOP and PWRDN
> 
> That will be an array right?

I'm not sure what you want to say here.

> 
>> - if future hardware implementation will spread the MSTOP bits for one IP
>>   to more than one register then this proposal will not work
> 
> That will be an array right?

Same here.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju

