Return-Path: <linux-kernel+bounces-68241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2658577B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681911F2325D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3D17997;
	Fri, 16 Feb 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l4KxMFEa"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2076.outbound.protection.outlook.com [40.92.53.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DEB18AE0;
	Fri, 16 Feb 2024 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072443; cv=fail; b=FHKZYuR0KFdtauv3AERX4Cpuq6FAZbMyVxcbb9Q+CYw0uZk/5DHFz9CXxS0CZwn0pD/IqsScMGM9zV/V23k75fNZPNTmgBaWrWy1Fr42ndtK8fAjDchZMxo3A+fOeZQShEirPjqmZCqJwCC7mkd9cVH6reZpXi8vE4Naqygi4e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072443; c=relaxed/simple;
	bh=RDuvQZH0mGbJc8bxJoIBfvp3AiOhL1zxDNmuXa3z86A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oijwd9E1PxktHExWAgwhCb+sViEBk52UFYJw3/vVn10SBXFljM4k61lvByUt/CcnB1qERLDVDIdKoqTMLFHvKm71bzIkTH66qrlT/l0VuZkmQzC6rGpEuFp2zdSBaZvleh3s8yUdnEJi+j1Bl3wtV0gWHia3xFtXZjghgb14+UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l4KxMFEa; arc=fail smtp.client-ip=40.92.53.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl1Ur0YHNpF+MgA+uUMsNN+G8fco26TEe04gNiCf1FNv2XqLokwZkuPS42BiegJiAJvhmuFy95fw9xi1JVavywY62WHRHAdXfNlmjDToWXgPmSTiInD6zO9cBRcM5Nutq2ZUOLmWcjqXzSGkGqRCcWyfV8Mi0xgg+16PZc3phXfZzQYVnRyRjHzo5P78nJCpLR4qPJs9CJ/fmq9qUyBYmDz1yUPGlSYisD4AopHZGlNFSO540ADl3n7RtJVwSyxyucIPdxOMvLZAom9ghiPmx3eNbADc5Hyk3uTO4NGeh6Qeh7Pn/j0JacaEe8bj5VGy8aMdypeLLZfrpO7qqYOlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ypJJxlabLJQBMwNzUyrk4GYxv1B2cKjaO4o8Sdrx/Y=;
 b=T1uBydFx06FPpaBgCPzyQJ7ya24+VBsa0s2NY6GVBPqforjJ7hsGI4ogb55pGNZVShHQQJVF+U+FWxGJ7hXB1OHTJG0iK+W2JdeOS2gW41HpWtQGDUiQ+DvXYH9z5i6JMj7rtyJohu8vZGzrSoUD9F1hnkqQAOFzo7s4jI8gi1kMAnCqolMkS5dnB7udcBPdd3jJ07bKR7RfJIr4KgoFq/CdZuWIijG0pI9CMqLB2D512Jgj0s4wFmFZPO/weTvo0e8RGhUDI4WLxj4zN/Tz3VA52vWkUAZqaC9FNpEKNWkECHmWszd0l3df+r6N+zxZf4L2+ckrFxtY8wKMHLCZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ypJJxlabLJQBMwNzUyrk4GYxv1B2cKjaO4o8Sdrx/Y=;
 b=l4KxMFEa8LT0X6eltyxqRgP9GJK4J3hxr2OsiqdWp/pjeCQHOrPoEnGRoBTgoI4fhgGitvoLQGsG7C1PwrA2D74q6FJFe23NVrAIV3GxA42rO3TG+w10lTjCXwAwKk+SjHZwZ9PiyM/uxQrBnbpyVSDDGvru14oDJX4AsaLJuiw5QLGow0IdyL7M689WbqzNZrqjHRQeOzmPn5QHTIUI/J5fyGQzGgxasdp+gp7pCSYHULBdXUjAssGkaD6/XA36N/Njr++2nIoFQenXeTiem8nYznJO6qaHVK+BFdNZIDfgDzuJVw3iFYzAHW17DOzdQN+KHbLiupd348sTSxpHjw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7040.apcprd06.prod.outlook.com (2603:1096:405:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 08:33:57 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 08:33:56 +0000
Message-ID:
 <SEZPR06MB69592C15DB486B3EAB9D7C7F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 16:33:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: mmc: dw-mshc-hi3798cv200: convert to
 YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>,
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-b4-mmc-hi3798mv200-v1-0-7d46db845ae6@outlook.com>
 <20240216-b4-mmc-hi3798mv200-v1-2-7d46db845ae6@outlook.com>
 <b6e9a7f3-1521-47f5-b0a1-b65e79e32495@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <b6e9a7f3-1521-47f5-b0a1-b65e79e32495@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [MBjhzn2A4n6fWAyBqOlkzgHtM2HXuHTaMxnn0+4OkZxOSZeKJ6RWvUl8GyYRhTkw]
X-ClientProxiedBy: TYAPR01CA0219.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::15) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <1b8fceba-cefc-4f2e-b049-70dada650fd3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c134280-8925-4319-33c9-08dc2eca03f2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aSC20hFYYg7l66oOCTrq+eQLpkgF0u7pXJq5TVAX3s0cyJh0voqGuxhvOoCppSW5t1KsiWOCLfRL62hnCHSYHuhHvv0EN6PqmS3gX2JY4wEMtLTeayjkknzMfFRSgYq0T7XGy9aJIXJLAIXgODLZrx5fzQMOtv6TzDxUMBOpbaZAPmAyY6JTQ2Ls11C6d7Z3faq2S387Xcheo1IrcwNMcV80OyYnnFDvCNdXAqq2UWCTS1ZoWV/5s25g4kvCYPlLyfAzrjbe6xDa4MJwbCO9dlZeRmlvcsiu5Vulkna2U0RqHkzG5bFhkn0tm0dM2JvGD8ZzwQTzZYxfdzcGcD3NkVdrb2IVwSLjPvn/9+/h9d56IzG684dJTqkDLH/lk9R8Ac7KlHt1UDfPD6wQpqRnW50jKRfgpHsqe/3WDbVgcR19pk0YNH0cQcWH+bLBk0thSn4Th4FVEtTN3MMMVZYSxc5Kk6p64kzDPDjJgFv9TGx3gpU3L7YFIXyPRO1vl9d/wcxdn2I9UkRShTVLS8nsuyPzANRpbG4M+MvFJ2NGbA90LShJv/q1G0TR+nX5rda7/hn2VzWgUX94CxGlRESvfdPpAOTp58pFs4HstI3j+bpm92MV+cPiWnLigvp4HEk4QhTMgmQofp9fWKHIvYfomA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0FNcnpQK2U0eTBMcVdGSzhJcFJJQUFSRFZIWlNTMkhVeW1VMEFlcWJPQTRa?=
 =?utf-8?B?YUhwaURjNW9tNVdHYVUzQ0I4Q1BRQ1locmc4dXVYYW96d25vL2xQakNJTFE0?=
 =?utf-8?B?YWt0K3N6ekQ5UWVINDdqRjdZZGQvN1RIU0FEWGJkcjZYOXd2QnJUek54Y2J3?=
 =?utf-8?B?aHVGT0NiOGxPaUFuc1RvTkFxcVRVWXNEZXlBNHlsblYwQ1J3ZXZLMzV2NGFw?=
 =?utf-8?B?emdVbXZ3b2p1WUpwMkh4amE3Kzc0WWZ2U2xRS2FjS2Qyb0V1MGxOYlZ2bDhS?=
 =?utf-8?B?Ry95czVOSUtUVXNDSmllTUhmaElhQTJ0NmdGSmRjVXFlSXZpUWh0WFJja1Zz?=
 =?utf-8?B?a0xTb2pHSVE3T2UxanZSSktvZldweXZpVDcySFZiVGdscG9USkpIZ29nUlFP?=
 =?utf-8?B?cnYvaGVwSGxrQ0hHbzVyMDJYRUY0dmltMzVjOU5DdUl5SHlQTituVURuZjM5?=
 =?utf-8?B?Sko5VUhiemlXTUpCbmJPU2Fpc3RGNFA5R0RGOFJTSmpiVU9QQjAzM280OWdP?=
 =?utf-8?B?eElMZ2dFcGJVZjNKZ3VXOTR2Umxra0o2YlBHV1Fvajl2ZXNidVg5RE92RHI5?=
 =?utf-8?B?Qm9DbUI5OWlTK3ZTNWxqRnV6bHVqWHNPN29DL1dnVFhlcXA3eVV1VXo1dXBp?=
 =?utf-8?B?UWVmTjE1R1ZkN3lDSi9vZWJMUGV1Q3BUb3VqVHh2NjNTVmNNK2J2NXlCNVB2?=
 =?utf-8?B?WjZmSkMyQ3VTQVE2UmthN0tkQ2JtZTdrMEFlVU5ST0wzYjBEN2k1ZXZsaU1u?=
 =?utf-8?B?bk02RTBTVmNFOUQrZkZTWDJIeU04dUVHcU44U0I2N1Q4dUswY3ZpUXZ5WEpt?=
 =?utf-8?B?cjZUTkh2MjRtcUVtODRsM2R4Zk9nd0VETlB2MXUraFkwTlp2amltSnMvd1Vu?=
 =?utf-8?B?WUdIUTVMV3JZVUd1dUt6cElLOWtCSCtTT1k4cXpWcG5mRktJNC9kY25mMDUr?=
 =?utf-8?B?QTNCZ1EyYmpBSFowMlR4eG1tY0M5QnpVTlgvaGo2MmJGejVFL1NQbHdwRWFM?=
 =?utf-8?B?SHI5Tkx1aEdZVkk2WEFXQWx0elY3SkliVS9tOHFaeWtNek5JUlp3TmQ3dEJK?=
 =?utf-8?B?eDNiZXlCV3ZKWldYdWJUWXVjY0UzVkdmRzdBNkRteFc4VWNtcEJpUVlDbmUv?=
 =?utf-8?B?bkpVam8va0E3M3hEQkFvdjZ2ZVNMeHNhcUxxQ09JQUpjakJ4N3M1ZW5hM0ts?=
 =?utf-8?B?aVBjeVRSM3JWSElGQzBNa0gzeWhwRVRsbzE2YkRyRDRuTk9BeW16ZXREUFRJ?=
 =?utf-8?B?bHJQekY2UTBXdDdlZis5Y3VacDVFY2NEcnJiOFhtcjJTWnJIRUpicjhCZzNN?=
 =?utf-8?B?TFRNelNKSWc2Ylpqdm9ieTBtTVNhNklMSmViNTBMaHRNd3RMblY1cVBhMFB3?=
 =?utf-8?B?MThBVHV6c0l6bWNpbExOSHhuejhnbnBjSE0zOWJyTit0ZjZ4M2dreVp3STd6?=
 =?utf-8?B?MllnU2YyaGNDSDZCMlRJOEdzVUJtdTR3Vk9oanhPS0Y0akVLdHZLZitJQjZv?=
 =?utf-8?B?MXpCbGNlME56ekxCSDRBOHlwbDY3NXNEKzRQQWZuMTJOanlySHpCVmt5bk5Q?=
 =?utf-8?B?a1UwUFZHaHlDLzkrUHB4TjdhcXhyRXJLanQvdTVsRk1TSzNaUE9HRDVjSmZ1?=
 =?utf-8?B?b0wvcmorN3IxTGFvUVFZTGUweE1DMUEzajRDWGVLSTQxVU9OT2Zzd3gyQnVk?=
 =?utf-8?B?eDNreENHak0ySXJNckVBRDJiQTdVVU9YUWh2cjFrZ0xvQmYzTmZ1Y25HRitp?=
 =?utf-8?Q?Ksv9MzEVmx3FbeERYEAQ5E9Wz5CJ0/IE5yKUT86?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c134280-8925-4319-33c9-08dc2eca03f2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:33:56.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7040

On 2/16/2024 4:19 PM, Krzysztof Kozlowski wrote:
> On 15/02/2024 18:46, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> convert the legacy txt binding to modern YAML. No semantic change.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>
>> +++ b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.yaml
> Filename like compatible.
>
>> @@ -0,0 +1,86 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/hi3798cv200-dw-mshc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:
>> +  Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
> One line please.
>
>> +
>> +maintainers:
>> +  - Yang Xiwen <forbidden405@outlook.com>
>> +
>> +description:
>> +  The Synopsys designware mobile storage host controller is used to interface
>> +  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
>> +  differences between the core Synopsys dw mshc controller properties described
>> +  by synopsys-dw-mshc.txt and the properties used by the Hisilicon Hi3798CV200
>> +  specific extensions to the Synopsys Designware Mobile Storage Host Controller.
>> +
>> +allOf:
>> +  - $ref: synopsys-dw-mshc-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - hisilicon,hi3798cv200-dw-mshc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 4
> Drop minItems
>
>> +    maxItems: 4
>> +    description: A list of phandles for the clocks listed in clock-names
> Drop description
>
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ciu
>> +      - const: biu
>> +      - const: ciu-sample
>> +      - const: ciu-drive
>> +    description:
>> +      Apart from the clock-names "biu" and "ciu" two more clocks
>> +      "ciu-drive" and "ciu-sample" are added. They are used to
>> +      control the clock phases, "ciu-sample" is required for tuning
>> +      high speed modes.
> Description should go to clocks: to individual items.
Actually copied directly from rockchip-dw-mshc.yaml. Will fix in v2.
>
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/histb-clock.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    emmc: mmc@9830000 {
> Drop label
>
>> +      compatible = "hisilicon,hi3798cv200-dw-mshc";
>> +      reg = <0x9830000 0x10000>;
>> +      interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&crg HISTB_MMC_CIU_CLK>,
>> +               <&crg HISTB_MMC_BIU_CLK>,
>> +               <&crg HISTB_MMC_SAMPLE_CLK>,
>> +               <&crg HISTB_MMC_DRV_CLK>;
>> +      clock-names = "ciu", "biu", "ciu-sample", "ciu-drive";
>> +      resets = <&crg 0xa0 4>;
>> +      reset-names = "reset";
>> +      pinctrl-names = "default";
>> +      pinctrl-0 = <&emmc_pins_1 &emmc_pins_2
>> +                   &emmc_pins_3 &emmc_pins_4>;
>> +      fifo-depth = <256>;
>> +      clock-frequency = <200000000>;
>> +      cap-mmc-highspeed;
>> +      mmc-ddr-1_8v;
>> +      mmc-hs200-1_8v;
>> +      non-removable;
>> +      bus-width = <8>;
>> +      status = "okay";
> Drop
Drop `status` property? Will fix in v2.
>
>> +    };
>>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


