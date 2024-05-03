Return-Path: <linux-kernel+bounces-167406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2F88BA91B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A221B281B40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F014EC6A;
	Fri,  3 May 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYTKUOUF"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24BA14A097;
	Fri,  3 May 2024 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725809; cv=none; b=CI+f/tJfYQYBUEaQtqF0T+HXErIM9U7psHzsPYCn11r+sCVVhn96JHoD8NORj13e72JXc6zz5PbNwtPp2kf0W2YekA+oz3ln3ViX06rN80v9zZiquPkTAS2ERUhkqAakLWOsgttKwSg1vVjAr5DN+U7XTq9ra233xIOp55bET2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725809; c=relaxed/simple;
	bh=ky6B7j1jZiqVnGlaH7oC77c+s1BMX9Zhi2nL4Pd+gXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHxYkExEzKh1bsiOPaqAR9jNkIpUGtxKgB2FgyeUbNIMwX33yAyrMOFXJXz40ByBMgJoGT0hAJ2NHUKy3fT7yydRT2+AZ6CifCKuVVN3A58ebfPPX3aYpM6Fkuchax8Yj8npSM2AlzDRaTfH50AYK3TxlnOUdDdwRQaN8F6jPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYTKUOUF; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5171a529224so11028818e87.0;
        Fri, 03 May 2024 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714725806; x=1715330606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEs27K1gyZNt2tvtdLqSYiey4SQJpieBMRmsTHVkycI=;
        b=SYTKUOUFTvVCgsl86tIFkGPzzBUPGzBi0zEmzuHUYNdJBe1sgxTqpFhAn8xfHwA5Gu
         3P+iw5ArLox4Mb0gqcXU6lj2ASlzpSeceZgqlN44UzzvgJfpGL4enxOdRajBM8uM+L7M
         6a4A2fDxce9LBncFSmPV+A6TQHFhG+/RPM3qEAZctpuq7/0uRX+H6u0m60KNGtJOktc2
         ZdiY5LOFoiVDv6f/BBcxrMhPs41IqB23uSRB49bBsLA5lHXjSjLpYCP+JzBL6OruxvKJ
         0HXNIG13oOEWBzCz1mxRx4r2Ru7aP9jjMJQric7Ctpz7Qb9cJvaTwNAO1rDGJaLF1zK9
         Kamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725806; x=1715330606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEs27K1gyZNt2tvtdLqSYiey4SQJpieBMRmsTHVkycI=;
        b=dL+izc9MBBWbG1Mj2uQ08rPgF1YLB69xtL3TGw2j1ZPe53e1M9/MhhkXxlH14/KI8+
         yhds05TIS8n4Gb+KkIrz6WKikjbrSDnVVnN8UT+PdUcbtI5wis57DqiWg7a7cZpMYXfc
         7E5YD2jPuHlrDbzLm2TgDal0V2cVFZvqdX6EYxS2rd3cSFgf3KN3TZOIdzcJ8RreY/5H
         ovd7t9Kzb6ag730dJtLj35IOr6tEV3HAdQ/FJ/CFQKBbclk/Vr9bZO1+cZqXaYkDvPfA
         iniGzLSNNd74UiqIn6FaGv69vI+A7edHdUxlag9t0QB8kIJl/0aXfY8ZoQdeG+vHLqgC
         uWyw==
X-Forwarded-Encrypted: i=1; AJvYcCXvn0vzeoX/FyEVDiv3KqiRVPZUe9N+jF4nCVeDa85X9iwOKwlrfVxUEr/k/jfd/Hf0QekFcS/LloO2tMaJ06nWOOjbpjZNFmBXVhwmPDQ8DYzhJN6eiBoR8uM9+SaMtPozbXl+9xGAvWyeb011q0erOY/pHHs+C8WnORoNxv+dgh+F7L6pHfUc
X-Gm-Message-State: AOJu0YwsBnR+U5D2qWleOi1m93jzucToUbApxeqyWO4ExV+91FZxss+j
	brFbIPo9bZQ9qwAw0Rvf02bKwsYSKJsoar0beKIWD94KcCoAxnQM
X-Google-Smtp-Source: AGHT+IHJtyOPKkGbWYt/4KxWKHuhexeylZ6ddCi7tRF3hNigrgboeptETxqKxsVJwYXeagClBNeMrQ==
X-Received: by 2002:a05:6512:130f:b0:51f:2ae3:57b4 with SMTP id x15-20020a056512130f00b0051f2ae357b4mr1409425lfu.27.1714725805812;
        Fri, 03 May 2024 01:43:25 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j6-20020ac24546000000b0051926db8fe7sm468866lfm.228.2024.05.03.01.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 01:43:25 -0700 (PDT)
Message-ID: <6c461609-33e2-422e-a3a4-7d222ae3f7c4@gmail.com>
Date: Fri, 3 May 2024 11:43:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] mfd: support ROHM BD96801 PMIC core
Content-Language: en-US, en-GB
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <91eafc06728ebb6158d86b58ce987fc8f802a453.1714478142.git.mazziesaccount@gmail.com>
 <20240503074106.GG1227636@google.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240503074106.GG1227636@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 10:41, Lee Jones wrote:
> On Tue, 30 Apr 2024, Matti Vaittinen wrote:
> 
>> The ROHM BD96801 PMIC is highly customizable automotive grade PMIC
>> which integrates regulator and watchdog funtionalities.
>>
>> Provide INTB IRQ and register accesses for regulator/watchdog drivers.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Changelog: RFCv2 => v1:
>> - drop ERRB interrupts (for now)
>> - bd96801: Unlock registers in core driver
>>
>> Changelog: RFCv1 => RFCv2
>> - Work-around the IRQ domain name conflict
>> - Add watchdog IRQ
>> - Various styling fixes based on review by Lee
>> ---
>>   drivers/mfd/Kconfig              |  13 ++
>>   drivers/mfd/Makefile             |   1 +
>>   drivers/mfd/rohm-bd96801.c       | 278 +++++++++++++++++++++++++++++++
>>   include/linux/mfd/rohm-bd96801.h | 215 ++++++++++++++++++++++++
>>   include/linux/mfd/rohm-generic.h |   1 +
>>   5 files changed, 508 insertions(+)
>>   create mode 100644 drivers/mfd/rohm-bd96801.c
>>   create mode 100644 include/linux/mfd/rohm-bd96801.h
> 
> Still some nits, sorry.

No need to be sorry :) And, thanks for the review!

> I probably wouldn't have been so picky if I hadn't have found the unused enum.

Yeah, that's what you say ... XD
It's Ok. Besides, I like your style of providing the better alternatives 
along with your comments. (ref the print comments which I agreed with 
and dropped from this reply).

>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 4b023ee229cf..9e874453d94d 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -2089,6 +2089,19 @@ config MFD_ROHM_BD957XMUF
>>   	  BD9573MUF Power Management ICs. BD9576 and BD9573 are primarily
>>   	  designed to be used to power R-Car series processors.
>>   
>> +config MFD_ROHM_BD96801
>> +	tristate "ROHM BD96801 Power Management IC"
>> +	depends on I2C=y
>> +	depends on OF
>> +	select REGMAP_I2C
>> +	select REGMAP_IRQ
>> +	select MFD_CORE
>> +	help
>> +	  Select this option to get support for the ROHM BD96801 Power
>> +	  Management IC. The ROHM BD96801 is a highly scalable Power Management
>> +	  IC for industrial and automotive use. The BD96801 can be used as a
>> +	  master PMIC in a chained PMIC solution with suitable companion PMICs.
>> +
>>   config MFD_STM32_LPTIMER
>>   	tristate "Support for STM32 Low-Power Timer"
>>   	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index c66f07edcd0e..e792892d4a8b 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -264,6 +264,7 @@ obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>>   obj-$(CONFIG_MFD_ROHM_BD71828)	+= rohm-bd71828.o
>>   obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>>   obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
>> +obj-$(CONFIG_MFD_ROHM_BD96801)	+= rohm-bd96801.o
>>   obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>>   obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>>   obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
>> diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
>> new file mode 100644
>> index 000000000000..1e9c49c857c1
>> --- /dev/null
>> +++ b/drivers/mfd/rohm-bd96801.c

..

>> +
>> +enum {
>> +	WDG_CELL = 0,
>> +	REGULATOR_CELL,
>> +};
> 
> Dead code?

Yep. A leftover from the version with the ERRB stuff. Thanks for 
pointing it out!

..

>> +
>> +static int __init bd96801_i2c_init(void)
>> +{
>> +	return i2c_add_driver(&bd96801_i2c_driver);
>> +}
>> +
>> +/* Initialise early so consumer devices can complete system boot? */
> 
> Why the question mark?  What are you unsure about?
> 
> Why doesn't -EPROBE_DEFER work for this?

I am unsure of what kind of dependencies the real setups using these 
PMICs have at boot time. Hence the (?). I've written drivers for a few 
PMICs, and I've sometimes just done the usual:

module_i2c_driver();

This, however, tends to get converted to boilerplate + subsys_initcall() 
by customers who actually start using the drivers - so I believe there 
is a problem in getting the consumers powered if the PMIC(s) are 
initialized too late. Anyways, it's probably nicer to try making it so 
it works better on different setups out of the box :)

I'd appreciate if someone wanted to shed some more light on this though!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


