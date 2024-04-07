Return-Path: <linux-kernel+bounces-134610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1B89B397
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A314A1C214C7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C93D0AF;
	Sun,  7 Apr 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGvWNomy"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BF1F19A;
	Sun,  7 Apr 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712515556; cv=none; b=srBYcLwGkEHtfD9bRxbOcozYzX0QZsWaIZelPyDMvffxlMhDcx+ridj2XK806NQ6inPLwQ+RikdKq6pVdmv37ZzXesHEdf1R460lC8CYM+epFAN5yBWdehtl+uiEufUeD+6aliYl3P+F8QXs5eGDBhnMfHdD+/StIlEaKZYndx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712515556; c=relaxed/simple;
	bh=f5Z/OhLtHZkX2FrSXxrWl174+ll2EE0oZIlxutk3/aI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dj+xMQGBxk2fT3YGKzD+L5FTE4uykU09e9Q3J8je7GcTfiiRYq/idgTTUWHZtfN3wDAnRTFAcikx2DY21zeg7RlbPF+sVKH5XQ+i3YmywwtTYyqX1eYsZkft13/rPOHmgX0px5vnOa8IyqkTX13Ts7VDMbrj9JMVxvB+0ilrO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGvWNomy; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e68a30e6a1so1501114a34.1;
        Sun, 07 Apr 2024 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712515554; x=1713120354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgqXg60aT6MJfLtaMlnATNJXESBqIL1BHJEEWOvVlh0=;
        b=KGvWNomyjpdTAWx9bQoKZ3zl576v+jZVq5SX8xcdbE9Nzo76wC5aOpvMPxqosicCmo
         witz9LVSK3jY/FEvcVrmw2O9TQ46KmidJpFbV8Vaiewip5bApbYPLM2EZyEIFeg3NXB2
         FMft/izfMQ5rkTcZr8S+9/ZbngmrvX4OMNQAQ3YgR6z9A9Ho+hgbOL/68DaxefA/pQoO
         vELK1guOvNaXcu5BmuSlbbA1RLupPatQHq7/F0QbL2FrIha1WzEXftInxd2JHAcVbkG8
         cxstKO17cju5hrPtRdMsam9codzubny6G0kU/lpMuzfn2cOQOsmkq6UXfdB3DI1F9wIH
         DqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712515554; x=1713120354;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgqXg60aT6MJfLtaMlnATNJXESBqIL1BHJEEWOvVlh0=;
        b=nAyxX8GN0Ej91H32ALefqDx7d/HKfa/ukwp2+HU+/5OC/oEwd26IKKCOEN6jDhepBQ
         sKDEBrnwn5topBTs9uUt3kW/QpBr7VTSr+w296Z2JYk7E7VV8fruzGqAeC+3sS0CRx7k
         5PyajGFH4eq0mIiVC6v4fkqHh57+h1xwWWqCzBQJcyRqUhCjO4KQXFI9OvC3BDazwfxZ
         m2o/acWRkDYfGts9hbmfv3Y+uF6iLtyQG6Oim5jjtP7IGWnxZ+UMdG57UjHpNqxi6QyZ
         rtCfy0lItFhI1EmIfL8Vs+fq/4ODWsfJ/laaqj8FMq1s7/sidyHND/LuyTplv9tDhKOX
         oBgg==
X-Forwarded-Encrypted: i=1; AJvYcCVTBssxUkXTmXYlC3CJpk9aE9rGMT1EHWdxgTaaZHjQEKRqsmulCM2IWBcuwY2Hwj5W+eBFhW9+qkOJCypKO+k11U7l9IlvThmJlpvRcTulziy0glortwixuAsYW0G9Nszwv93zlJuxaBWnAgP4Gw5bu4sSpOulI8fXBzFGMNVJwp1nfO7TzjdLdmpV/jR9OvgPPkNHNSbQEws9mKqJDEQKcPI=
X-Gm-Message-State: AOJu0Yzf0Mw1I+w5ykqHYweI+6YWevj34wvok9lJ+/qnyi724yfuV3p9
	piW4w5qseJDZPT1dqA42Ewl6rGpnQBG9NeT+mq2hYpcUzM8hB14s
X-Google-Smtp-Source: AGHT+IGSn06uT5ucJhVN5SnUx0jyRnD9d8nrQg0jfAzNly2yaljheoBXT7c0SivtFbbTlY9NP236LQ==
X-Received: by 2002:a9d:6b19:0:b0:6e6:8d2f:4013 with SMTP id g25-20020a9d6b19000000b006e68d2f4013mr3139289otp.8.1712515554251;
        Sun, 07 Apr 2024 11:45:54 -0700 (PDT)
Received: from [192.168.7.110] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id y2-20020a056830208200b006e9e7c28850sm1177981otq.44.2024.04.07.11.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 11:45:53 -0700 (PDT)
Message-ID: <0c0487cb-c73d-42dd-94f8-499c29009730@gmail.com>
Date: Sun, 7 Apr 2024 13:45:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] spi: spi-qpic: Add qpic spi nand driver support
Content-Language: en-US
From: "Alex G." <mr.nuke.me@gmail.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
 daniel@makrotopia.org, arnd@arndb.de, chris.packham@alliedtelesis.co.nz,
 christophe.kerello@foss.st.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240308091752.16136-1-quic_mdalam@quicinc.com>
 <20240308091752.16136-4-quic_mdalam@quicinc.com>
 <1c803d8c-80b2-47a9-bc8c-8b13cbfc6841@gmail.com>
 <4f72048a-a764-43de-846c-3b4edc1232e3@gmail.com>
In-Reply-To: <4f72048a-a764-43de-846c-3b4edc1232e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/7/24 13:40, Alex G. wrote:
> 
> 
> On 4/7/24 12:48, Alex G. wrote:
>> On 3/8/24 03:17, Md Sadre Alam wrote:
>>> Add qpic spi nand driver support. The spi nand
>>> driver currently supported the below commands.
>>>
>>> -- RESET
>>> -- READ ID
>>> -- SET FEATURE
>>> -- GET FEATURE
>>> -- READ PAGE
>>> -- WRITE PAGE
>>> -- ERASE PAGE
>>>
>>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---
>>
>> For the entire series:
>>
>> Tested-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>
>>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>>> index bc7021da2fe9..63764e943d82 100644
>>> --- a/drivers/spi/Kconfig
>>> +++ b/drivers/spi/Kconfig
>>> @@ -882,6 +882,14 @@ config SPI_QCOM_QSPI
>>>       help
>>>         QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>>> +config SPI_QPIC_SNAND
>>> +    tristate "QPIC SNAND controller"
> 
> Also, don't tristate this. It can be set as CONFIG_QPIC_COMMON=m, which 
> will cause the build to fail because you don't have a MODULE_LICENSE().

Please disregard my idiotic suggestion here. I meant to make this 
comment on the previous patch.

>>> +    depends on ARCH_QCOM || COMPILE_TEST
>>
>> Here, it needs to 'select QPIC_COMMON`. Otherwise it can run into 
>> unresolved symbols:
>>
>> : drivers/spi/spi-qpic-snand.o: in function `snandc_set_reg':
>>   drivers/spi/spi-qpic-snand.c:56:(.text+0x484): undefined reference 
>> to `qcom_offset_to_nandc_reg'
>> ...
>>
>>> +    help
>>> +      QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
>>> +      QPIC controller supports both parallel nand and serial nand.
>>> +      This config will enable serial nand driver for QPIC controller.
>>> +
>>>   config SPI_QUP
>>>       tristate "Qualcomm SPI controller with QUP interface"
>>>       depends on ARCH_QCOM || COMPILE_TEST
>>
>> Alex
> Alex

