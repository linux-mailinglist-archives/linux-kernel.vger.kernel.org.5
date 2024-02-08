Return-Path: <linux-kernel+bounces-58298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8A84E43D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643D428EDCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E47C0A5;
	Thu,  8 Feb 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Fzy65ssx"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBD7B3E9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407163; cv=none; b=DgRrOic77Zy6DCID/zH7jzoRaD50ER1z4qmB3UDReiDsHy74zxelXmjeUFug0gFVxLEdWSF+HRijv+E+RBbSFAvqAC+9FIfq99XJyw3PggtZtGyHQD/DzN7CGht/7vMeSW01G2Hpk+1wm4i2HHh6GjVHuIjPgOgnfl8caWzE3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407163; c=relaxed/simple;
	bh=p371nnA0MYfDfaX9oKJYZFzzxG+rpokxG+v0PXCVgjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqKg65o/YdckMxlYKTyAC258vbnYnYRE+RGV0/gHjyNFdcmyUwENj+3j06//WeATRAlyQ8orcqbryMisP93VHPh5ot8Co99VsCOiN9OKdGfztTEGQ7yDrbIAhavTHJ0j7lQhQPzSkyyLnKPZEWWWjhaoFhXFQNqSH4d2GuQ0shI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Fzy65ssx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso112585e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707407159; x=1708011959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdw1R25OH/oj1h+/23MCaEFMxMiuRqj0tdTYwVW8hgc=;
        b=Fzy65ssxGS67G1aV9oLdT1X9zr1yfxoVbAhR5jGJwqHBo7D70/xc9FwvsZqM3RRIRk
         RmeSyPU0Mqy4nmcSWaANGNqvBbYylVtprmstiPJ/C/F6GKFdBHnVHVEEwCUuhFsYD0Gq
         JdNEG2HF+ENI3BQKkUMMiNOPOeuFYv3Mx6XzVUaGkl3yyUDilJ29Kq3nMWf60HAyuukn
         82M4dgWLG8VawTWgsxKaCS9tudhV0w0VwWE4Hb49rI6p0gPtfMmB7LAf6WDwSK1UYKfO
         hg2C1e7I1WsWQHQ5IEmcH2KzdEGqfaE7zOmlveHWzTHR6fvUhckAwG8U7Ctoy+Bzh+93
         DOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407159; x=1708011959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdw1R25OH/oj1h+/23MCaEFMxMiuRqj0tdTYwVW8hgc=;
        b=nMM7fSLBKPzYN/2oUgsWBYC23JZf/3fJrRYZ71gKYx3r9PHs3U3D7BPjvOvDi6zbY3
         8eF8yGHYo/L+1D67XfiONsW+n4B/RhRn5TQhv1lgkE8HxfI8VE7/VBsEcWRAX5l5GvYl
         IYHKLYOsc5Xplh2isLjflix+wKrDKk/nCTdLmWZFBTNEsKc9tymW2GXzxr7kk2CUNpcB
         unFYRj1d1uIkcQud/FDjSFaxMePMtgU8pbU3kN/wbJqNsrvEEYb2XnMWGY1z15gATsZN
         BUWOQZTMLzLWYeYgatmDNOyJmqlWEjBaiqRhR1Qni/RoEW+z5S4Rkm5q+rBG1pcGwKkH
         SHbw==
X-Gm-Message-State: AOJu0YxFgi3NF/gETl1RyAjtcA8smky0U4akePiT4dQkYUDACszHOZq8
	DzLVnfd7q5oI2G+DDWO6HqpBSfz4C7yU4L8lvrOyU+Ls6KCAcPGUt3r/hwoFdTw=
X-Google-Smtp-Source: AGHT+IGAkVBgi2v/9rwm8yJ8TS8SQmm7MTHynY1Wd3oKB5eyxjrqqLsN0IR9u4OlbaJ/45wh27lESw==
X-Received: by 2002:a05:600c:1910:b0:40e:fb76:5344 with SMTP id j16-20020a05600c191000b0040efb765344mr7185602wmq.11.1707407159502;
        Thu, 08 Feb 2024 07:45:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcyGuyqyRlo0NUXLCGq0I6rMtLOkVAraDOwhjdq9cKgLyFxUECiO4kdkrmZ1kQaMSAvok8ZDc8xbR4uGFS8qxzrtaGNGrJd+40sHT96YHNndFupwkup/1NCh0YbMfd50pRAKhBJbtERteZ2GToMHUJ7+i/t7P2ZO3eE0/VMJGm/NiRLdo3W82kRYO2vefJ0BPjXdpJtNwFX836t6EAs2SP0XZ6HlVb+2vHEbHwqgkb62ky2kpUXdSknN6wkvgcQFkNIaOqWT8l1VxcOvAmA8AVhE/siwkfNpbo2bUM3IwCf5inwF/inAk0kt/46uc/cMNDcfYLisRDRv3V7QzVB7OfxioKLn7sWGbW51WYd7UPfTtRGiMqzI99hrCoWVVHmV9N5viwzkI7zgauTyDgXXpXRXyXBQOdbbqr5rKn9o+19lJN0RGIBMDVd1V0dOewI4Y8jmfc8NEY5QOmroUEJM/WaGmfBq9BsQOsBD23WVzvA4Ldfi1ZxJIWSDABDRGesF0zwoDujL0ntkcUHEpaEZoVdMqovSuCv9cOluPCcwjy/P718QDgIZwCET7HU+xrsvY7j608GVrctHNxaSjT6t9mC6pb42lrROg+
Received: from [192.168.50.4] ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b004101f27737asm1981436wmo.29.2024.02.08.07.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:45:58 -0800 (PST)
Message-ID: <67ad8052-1406-4dcb-9e35-5c42ada28797@tuxon.dev>
Date: Thu, 8 Feb 2024 17:45:57 +0200
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
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TYCPR01MB11269DEA9261CA594EECC949686442@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 08.02.2024 16:30, Biju Das wrote:
> Hi Claudiu,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Thursday, February 8, 2024 12:43 PM
>> Subject: [PATCH 01/17] dt-bindings: clock: r9a07g043-cpg: Add power domain
>> IDs
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add power domain IDs for RZ/G2UL (R9A07G043) SoC.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  include/dt-bindings/clock/r9a07g043-cpg.h | 48 +++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-
>> bindings/clock/r9a07g043-cpg.h
>> index 77cde8effdc7..eabfeec7ac37 100644
>> --- a/include/dt-bindings/clock/r9a07g043-cpg.h
>> +++ b/include/dt-bindings/clock/r9a07g043-cpg.h
>> @@ -200,5 +200,53 @@
>>  #define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
>>  #define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
>>
>> +/* Power domain IDs. */
>> +#define R9A07G043_PD_ALWAYS_ON		0
>> +#define R9A07G043_PD_GIC		1
>> +#define R9A07G043_PD_IA55		2
>> +#define R9A07G043_PD_MHU		3
>> +#define R9A07G043_PD_CORESIGHT		4
>> +#define R9A07G043_PD_SYC		5
>> +#define R9A07G043_PD_DMAC		6
>> +#define R9A07G043_PD_GTM0		7
>> +#define R9A07G043_PD_GTM1		8
>> +#define R9A07G043_PD_GTM2		9
>> +#define R9A07G043_PD_MTU		10
>> +#define R9A07G043_PD_POE3		11
>> +#define R9A07G043_PD_WDT0		12
>> +#define R9A07G043_PD_SPI		13
>> +#define R9A07G043_PD_SDHI0		14
>> +#define R9A07G043_PD_SDHI1		15
>> +#define R9A07G043_PD_ISU		16
>> +#define R9A07G043_PD_CRU		17
>> +#define R9A07G043_PD_LCDC		18
>> +#define R9A07G043_PD_SSI0		19
>> +#define R9A07G043_PD_SSI1		20
>> +#define R9A07G043_PD_SSI2		21
>> +#define R9A07G043_PD_SSI3		22
>> +#define R9A07G043_PD_SRC		23
>> +#define R9A07G043_PD_USB0		24
>> +#define R9A07G043_PD_USB1		25
>> +#define R9A07G043_PD_USB_PHY		26
>> +#define R9A07G043_PD_ETHER0		27
>> +#define R9A07G043_PD_ETHER1		28
>> +#define R9A07G043_PD_I2C0		29
>> +#define R9A07G043_PD_I2C1		30
>> +#define R9A07G043_PD_I2C2		31
>> +#define R9A07G043_PD_I2C3		32
>> +#define R9A07G043_PD_SCIF0		33
>> +#define R9A07G043_PD_SCIF1		34
>> +#define R9A07G043_PD_SCIF2		35
>> +#define R9A07G043_PD_SCIF3		36
>> +#define R9A07G043_PD_SCIF4		37
>> +#define R9A07G043_PD_SCI0		38
>> +#define R9A07G043_PD_SCI1		39
>> +#define R9A07G043_PD_IRDA		40
>> +#define R9A07G043_PD_RSPI0		41
>> +#define R9A07G043_PD_RSPI1		42
>> +#define R9A07G043_PD_RSPI2		43
>> +#define R9A07G043_PD_CANFD		44
>> +#define R9A07G043_PD_ADC		45
>> +#define R9A07G043_PD_TSU		46
> 
> Not sure from "Table 42.3 Registers for Module Standby Mode"
> 
> Power domain ID has to be based on CPG_BUS_***_MSTOP or CPG_CLKON_***
> As former reduces number of IDs??

If I understand correctly your point here, you want me to describe PM
domain in DT with something like:

power-domains = <&cpg CPG_BUS_X_MSTOP>;

where X={ACPU, PERI_CPU, PERI_CPU2, REG0, REG1} ?

With this, I still see the necessity of a 3rd identifier that will be IP
specific to be able to uniquely match b/w DT description and registered
power domain. FMPOV, this will lead to a more complicated implementation.

We need a unique ID that the pm domain xlate will use to xlate the DT
binding to driver data structures.

Thank you,
Claudiu Beznea
> 
> Cheers,
> Biju
> 
>  
> 

