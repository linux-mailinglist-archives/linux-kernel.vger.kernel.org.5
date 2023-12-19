Return-Path: <linux-kernel+bounces-4883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2CB818349
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBF0285836
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C21411725;
	Tue, 19 Dec 2023 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZFBePNl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3812B6D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336695c4317so1872138f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702974383; x=1703579183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44tWTX/RSFAs3xTgaKfAwubj6hvu6hnjcH+agLDrfuI=;
        b=RZFBePNlvKK1/SmZLxoV0uLC3wND4aSou+pK00QdXHajnjSqDvBfImhZs9HW13G0l5
         63FDyumdA7ivqVvtgOzFA/1UmqNh/e4ZacC+kIatzicFjLQ/ZnHK0Lpr0yldn/Kj5QMa
         uZh8t4eGpEgBNKAOareAjep+3eGko73g0/O6+a/AYoGPNHr5rMdNRV6WtRiPCX/5iV9a
         9iVq2vghUkizJIr5tB7JIDs6sSEVPj7LXHsPP6eFm5Pz764AcSltwxHoeWKEyHHrEl5q
         RSc+IL1n2/JGkK8X910oLJMrNK78RSHxs3P4QWrf88fuxGBMfRSCmZGggJZb7TfA/sYN
         oY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974383; x=1703579183;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44tWTX/RSFAs3xTgaKfAwubj6hvu6hnjcH+agLDrfuI=;
        b=LHubCyJ49VQDvu+F2CAYlQN0ZUJetk/C/Z2YzfhGYyakwceJMTwL4e2TQoubRBjZjt
         hnrsCau44uIVTfFCvInB5N3wl6lDfUU4WST6B3kLn563sR/XkpVJqT75dCqlxJ9HJL1D
         7pCcJxl2xDFD8A6vT4MT2zeUdTsZ3BRoeZ3UDGr/NnqZHH3R4HepnsBAVbTyQgrDshxQ
         co6B0KPtAqPJRd9WYm8KaY9r8FhYzPzptGYgAv7DTyA9/7bGf2/DNhhwSarJYgfNIX5S
         2kNwStTKQGqXnASL74q1YNH1RppevmmV76N+pkuYI7TQUnHntAPihdgecvShlLVUBWQW
         T9Ag==
X-Gm-Message-State: AOJu0YzIQtkHQrecQSONndHjy/reuQpNJxmiT1GqMYSvAyNW9sA4Bya7
	gvRCYNe4S6MMkeD5N3Ni9dHXOA==
X-Google-Smtp-Source: AGHT+IFhixtyy2y9O5fWKScajlDY2zaXPIfDPrVd3MMvihiJ4///TFioM3EVhUMMvTdIrJts+xU3cQ==
X-Received: by 2002:a5d:6801:0:b0:336:6e12:7c62 with SMTP id w1-20020a5d6801000000b003366e127c62mr861872wru.110.1702974383315;
        Tue, 19 Dec 2023 00:26:23 -0800 (PST)
Received: from [192.168.2.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b0033662cf5e51sm6719841wrv.93.2023.12.19.00.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 00:26:22 -0800 (PST)
Message-ID: <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
Date: Tue, 19 Dec 2023 10:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael@walle.cc" <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15.12.2023 13:20, Mahapatra, Amit Kumar wrote:
> Hello Tudor,
> 

Hi!

>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Friday, December 15, 2023 4:03 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; pratyush@kernel.org; miquel.raynal@bootlin.com;
>> richard@nod.at; vigneshr@ti.com; sbinding@opensource.cirrus.com;
>> lee@kernel.org; james.schulman@cirrus.com; david.rhodes@cirrus.com;
>> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; michael@walle.cc;
>> linux-mtd@lists.infradead.org; nicolas.ferre@microchip.com;
>> alexandre.belloni@bootlin.com; claudiu.beznea@tuxon.dev; Simek, Michal
>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; alsa-
>> devel@alsa-project.org; patches@opensource.cirrus.com; linux-
>> sound@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
>> amitrkcian2002@gmail.com
>> Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support
>> in spi-nor
>>
>>
>>
>> On 12/15/23 10:02, Mahapatra, Amit Kumar wrote:
>>> Hello Tudor,
>>
>> Hi,
>>
>>>
>>>> -----Original Message-----
>>>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>> Sent: Friday, December 15, 2023 1:40 PM
>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>>>> broonie@kernel.org; pratyush@kernel.org; miquel.raynal@bootlin.com;
>>>> richard@nod.at; vigneshr@ti.com; sbinding@opensource.cirrus.com;
>>>> lee@kernel.org; james.schulman@cirrus.com; david.rhodes@cirrus.com;
>>>> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com
>>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> michael@walle.cc; linux-mtd@lists.infradead.org;
>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>>>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
>>>> linux- arm-kernel@lists.infradead.org; alsa-devel@alsa-project.org;
>>>> patches@opensource.cirrus.com; linux-sound@vger.kernel.org; git (AMD-
>>>> Xilinx) <git@amd.com>; amitrkcian2002@gmail.com
>>>> Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories
>>>> support in spi-nor
>>>>
>>>>
>>>>
>>>> On 15.12.2023 09:55, Mahapatra, Amit Kumar wrote:
>>>>>> Thanks! Can you share with us what flashes you used for testing in
>>>>>> the stacked and parallel configurations?
>>>>> I used SPI-NOR QSPI flashes for testing stacked and parallel.
>>>>
>>>> I got that, I wanted the flash name or device ID.
>>>
>>> N25Q00A, MX66U2G45G, IS25LP01G & W25H02JV are some of the QSPI
>> flashes
>>> on which we tested. Additionally, we conducted tests on over 30
>>> different QSPI flashes from four distinct vendors (Miron, Winbond,
>> Macronix, and ISSI).
>>>
>>
>> Great.
>>
>>>> What I'm interested is if each flash is in its own package. Are they?
>>>
>>> I'm sorry, but I don't quite understand what you mean by "if each
>>> flash in its own package."
>>>
>>
>> There are flashes that are stacked at the physical level. It's a single flash with
>> multiple dies, that are all under a single physical package.
> 
> Got it. The W25H02JV QSPI flash I mentioned earlier is a device with 
> with four dies that are stacked at the physical level.
> 
>>
>> As I understand, your stacked flash model is at logical level. You have
>> 2 flashes each in its own package. 2 different entities. Is my understanding
>> correct?
> 
> Yes, that’s correct.
> 
> I'd like to contribute to your earlier point regarding the placement of 
> the stacked layer. As you correctly highlighted, it should be in the 
> spi-mem generic layer. For instance, when a read/write operation extends 
> across multiple flashes (whether SPI-NOR or SPI-NAND), the stacked layer 
> must handle the flash crossover. This requires setting the appropriate CS 
> index in mem->spi->cs_index_mask to select the correct slave device and 
> updating the data buffer, address & data length in spi_mem_op struct 
> variable. Does this align with your understanding?
> 

This was the initial idea, yes, but we'll have to see how mtd concat
fits in. Maybe the abstraction can be made at the mtd level, which I
suspect mtd concat does. I have to read that driver, never opened it.

Something else to consider: I see that Micron has a twin quad mode:
https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25t/generation-b/mt25t_qljs_l_512_xba_0.pdf?rev=de70b770c5dc4da8b8ead06b57c03500

The micron's "Separate Chip-Select and Clock Signals" resembles the
AMD's dual parallel 8-bit.
Micron's "Shared Chip-Select and Clock Signals" differs from the AMD's
stacked mode, as Micron uses DQ[3:0] and DQ[7:4], whereas AMD considers
both as DQ[3:0].

I had a short chat with Michael and he highlighted that instead of the
parallel mode, one would be better of with an octal device. I wonder
whether the quad parallel is worth the effort. I see AMD can select
either quad (single/stacked/parallel) or octal (single/stacked). Is the
parallel mode considered obsolete for new IPs?

Cheers,
ta

