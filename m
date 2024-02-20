Return-Path: <linux-kernel+bounces-72795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1885B8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2141A285F36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E8612C8;
	Tue, 20 Feb 2024 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jhj7zE4G"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5060EC1;
	Tue, 20 Feb 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424048; cv=fail; b=JyX++BL67yxzby/UqsZkhgo8HfpmWY9yoQeCqpPcyhLgbQ82WwybCk2LfT8wUlS5US9bXF2JhPitpeMT40RuqQfhdCqF/389l+qyNW8bRT6VA3Dpgg0wVAltSE4o65k4osrrWJTPWQbwDCIhyUjK7jibeubNZzEDfKP/M8HTZSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424048; c=relaxed/simple;
	bh=0i7kkpGNdQx0vkXNsyHc8xRlboQroYvz5+vqc1dD/kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnA0iIdl0qqX53PfvP7f4YNqhOmrex+lt5xNVyDlCo39aorWCZ1x6R6UDOV7LWGZvpESHMFEd9CEuuSKHNqpRezoxBYTrd8zHmL6rA0tPFTlDZipuQjf2yG69R+fcVDcyf0asTfAgFnhTRRYCGc+kTZj7ZoYlIUcuPr7QXNIrbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jhj7zE4G; arc=fail smtp.client-ip=40.92.107.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKUQyJiphswAO+yFbNw/GPmLpBnkVuv0ktTFGNCerPVZHDXe14pydpRhYBNkh6CLIMIOAr3x9e3zpRvQF9cFAB9bIcvVqzvmaGE/ZTGZs/5Xha4O6l5eKnijmRt0/DPkjctSWffufGkUeAvAH/UZItl5H6CO3H61pValCMkd5RtrpNhd+7aeA02E5WvfOwoDEz2Nh4+3eKNORpQbXbQh7R6l6Jmdm19EAUCHw2SdnfjYN5cS1BEV0rBNsibzs4nC2KeWhG/eiQrwSJPLvp/OaJRPAgqR8lHiVscuKpEwuL+M24tueJRaFcEW9VsZk1cldEOUrKS5Kz1pNqxsU1prag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKyhmbPAgzh+1NEwGMLrxsSGfv/M2LT7vjcE44UOZ44=;
 b=chsH7Tc4fOufGFbFEFcLlT5PRE1bvttDvo4NEgfxIsBt/PjIN7OSJO6yb/cRe9j0ino6g82VpmB0fVKAODbn3d6sqVJ+7mts6+k2xq/Xg1oorSEjITjdj7N3097fkQ/a7JNxZL4zp6dilgwRYrGdefBoQdYXtPoRzZ0HylGhOiI9CIIncedOux2MY52JOmlj3KfGV0IBDkyneO4zo/AZI+7Q7nbMxSFaOhFBqTNjugh9UxLEb0jTdUqBuBNeo6O2HJF/klhjDEVgFK6B2iERP2KG1bucpWxxjIfPLCFxNeVorYlF7miRJKqFMCoQOWdUE6c/lfchdt0f5s0Z2d2ntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKyhmbPAgzh+1NEwGMLrxsSGfv/M2LT7vjcE44UOZ44=;
 b=jhj7zE4GEEaapiGvLkKLCAAX/eGr6sdrFgaUc0y6BJYMkodo0wDXYNcl+BoSY9QHt7ilIZ+ixgK+tAmwiQ5AsAk24qEuI0zwn2LKc7vi/RN5mjnkIlY3FUiN/0K7sMzfY4MUSGi9VwRldL3e2tHeBtd/VBKAhRFMzfmO63H5BCHePxVKqLmmrc0913nAfq2ZbecYsrQek/du1lSXGO5aHWrkTUyR583YS6GDusDJklnhSxDYQMPR/EDmiX0gfehMxC8ZGv33zONgc5zql7wz8SjnycMfcq/y1vOV2wkQBdyRm7SqAZ1jaglJSIrja7bSgGZl1LUPYluhdeMTtPbhig==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5574.apcprd06.prod.outlook.com (2603:1096:101:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:14:03 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:14:02 +0000
Message-ID:
 <SEZPR06MB6959E45F52C87C08320B7E7A96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 18:14:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/5] clk: hisilicon: add CRG driver for Hi3798MV200
 SoC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-2-b782e4eb66f7@outlook.com>
 <31188f64-7c6b-4279-a2d7-8b5133b1d485@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <31188f64-7c6b-4279-a2d7-8b5133b1d485@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [YbseZggY6QaIAkbH79uPfvj+Mhzq+y9yCKsrPQqRmzY+ciBBFXw+8Qi5MRFOpJJX]
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <bdd10f7d-827d-4a6a-acb7-61dbf523411c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab090e3-0079-4da5-e097-08dc31fca9a1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yzvafQpGYdWcOMHExSAL2YP/vwQU+w+Zwrjd8V6EUrxadb+mmyOabBp4LdCBNMJxbnWmqPMAgBVmsGrgN9IpdXlSvmO4rUQIPResZG5c23MAbx/DfiYToDkXdXYb/rrmM/uLV7RYA0lRYvAMey1PctRkNaCYVaRplH8O+lMAIBgulkvlGalQ3p4lIgvkqBtBxPNSWEz7zwn4cwZq06oG3MqwK2HsAPn29JZV0w/glAAz5PhjawYh4h8RAa0eacnmKHqxjtXy8G3GC3IWUkOgsdXiHPTA/inSbjfsi6ltvj8o9iDv/R2U3d6M9mk7Ld/OE4kxtXwB1/nL1w4jvBKTTiV5PgYk+4Z1ZcLzVNpGe5MjI7LZxdWGKtaV/1yBFkcIzrjioMjI4g5krdMCjPH4SwlCX8zPcIFIDQiNYA5Y+fHJUOnVgY5e3mkWn3E2wm2/mrcahfZq5dA4Zw6T8Fm8t36MOAadYvGBf9r/hjyE2ItfgEaYWzvLg6/bC58qLBhNqVzZhr89G99rM1X8yAd4poWSt4LfsfgmARmXCxTyrHbAJRs36wbBKhPOZWqmIthN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVF0N1Y3Mmdyd0ZZaEU2THNVaGF1cXBRSkIxeEw4eUh4NzlESGw1SURUUkVp?=
 =?utf-8?B?T2poRDhjakxvejl3Q3BRUmc1eTdCRXVZU0ZTRFRpV2d4SmtiTVRpOVJnSmg5?=
 =?utf-8?B?NjR2RWR1ek9jYVZjR2xsdVBNbEZVTXo3Tk5ieGJtV0Q3MlpFdXYrR1VXVVRo?=
 =?utf-8?B?WEhZaTcvL3hEcG13SFRDVVhwMXl0TzNwQmlFL1lmT3JCME5IVlQ3UWE2Y3U3?=
 =?utf-8?B?NjJSdE00OENvTUlEbml2cSs4YXlxTnpFcHNoMk0rTytMRVExY3YvakpRalAr?=
 =?utf-8?B?MWY2ak1sdHB2ZVpuS0RzMjh3a2VZRkhVOUhVUWtSdUpFOTIzeG5xMkVRWnVu?=
 =?utf-8?B?R0UzVXd4N0RJUEhKcWg3V01rRUpGa0U2aEU1b0dNbkxZQ3JZa3FNbkZXRHd4?=
 =?utf-8?B?TENwdnA4TUVhcnlhanA5RXluRTh3UEJpWXY2N2hZZU12TVlSNk5WaXhjckFa?=
 =?utf-8?B?anlJR0YrWmxSUGxoSmtrdEJvWUJuNUhTcVIvYlFIYjBrLzN3Z0REeFlPcWpi?=
 =?utf-8?B?eFErODFJR3M1bUYvTU50aC9IV3VwMzhqdFZqOGNUYit0OWNkQWhiVmpzOE5Q?=
 =?utf-8?B?dnFiWTh6NnpKRlJQbVVpeXFHSlYvdDlDZFZkMHpESVUvei9DbmNkNmJSUW9w?=
 =?utf-8?B?NEdGVXF5RDNFbEhTR3FldVJEYit1Q1B6Zzd6ZEFJUHY0Z3NlZjJEVEVHdUNl?=
 =?utf-8?B?aHRybktQUkZ2anQ2amRhTW9iSko2WTFXMVlXQmZWSUJZQWRvMDFXUXBNcUt5?=
 =?utf-8?B?K1dZWk5mUllvQVQ3c0p1aHp4Y3VQc2V5M2xuOVJjdDVpWEl2K05jcU9mTTRS?=
 =?utf-8?B?dUhxUkd3b3pzYjNJWXRQaGlOYUlHTG5SNithb25tYnBEN0k5SGd4aGcvUVZp?=
 =?utf-8?B?T0lpcGVpbWxFNXZweVpYeG1OMDVvVzZNUWRycERCY2NHamtNckNJYUJLamtV?=
 =?utf-8?B?Nm5QalNvdGNzYW15eXg3ckZHWGNyT0hQeUJrMnRuZXJSdmNWdjMzamJOSmRo?=
 =?utf-8?B?WGtCb1RSTGJOb1RJbzZLV3ZiVitJTUJMNDk5b0E0b2R3YWtDT2JyYmNyQXJo?=
 =?utf-8?B?WUl1ZHFvVS9PZjNoZm5obHd2VXh5aVZLVGdZWkhPMms3d281WGNyeG9IdSs1?=
 =?utf-8?B?dUxVOWNNcnF1UzYwMVo0ZGpZUU94OXRiaHZYRVF5dGhrYzlLazFQd0Iyb1BY?=
 =?utf-8?B?Q3dwTnhwOUM3T1p1K0VncTc5bVY2eVBoNWJtWEluWjk2NjA5RnVTbHJ4ZHAv?=
 =?utf-8?B?L0g3dThyY2VUcWFwU0Q1OUU2b2FCRWZ4NFJBTVhVUVVhVzNoUjJFeXJjWmVD?=
 =?utf-8?B?YVc5UFN5RFAzNlVMUnNzbE9PREJGVEFFSmU3SkNzMEozdTlMYm5SWGEySjJs?=
 =?utf-8?B?UTJZSyttYkw5OE5PVzlMeFdFbjEzSENOa1VoeE1IUEtuOFU2WFl4UFpTWm9k?=
 =?utf-8?B?bTFvQ0hCVkpkNmZ4Tk1TYUpXdUdndm03a0FGT1pYK0QyTmhHZExVdDZoRm9J?=
 =?utf-8?B?SC9UZ0lFcnpydGNlUlBiZ1hGdkF1RE95RlhvRFBsd1JremY3YjVGNXBPSWh2?=
 =?utf-8?B?eUV4TjJJNkg5RmwvVVhkdVFpYnBYSWVKeVJhNXF1YXg3RGVJVE0xSTlHOVdx?=
 =?utf-8?B?MG1yelo2Q2JnbHY2RUFtbjVmM0Y1Mjk1TC9pUXhHOTQ0R0IzQVB2NzNWNzdq?=
 =?utf-8?B?bllkY2VVYVpzR1dnaCs2UXVnLzdPVmpHQ1ljRXkwVGt1WDJyNmNsbmpCM3M1?=
 =?utf-8?Q?IHyfMwSA397VbGDAR88eFWdwQWwoUwXPyajL3fy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab090e3-0079-4da5-e097-08dc31fca9a1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:14:02.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5574

On 2/20/2024 6:11 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>> +
>> +static const struct hisi_crg_funcs hi3798mv200_sysctrl_funcs = {
>> +	.register_clks = hi3798mv200_sysctrl_clk_register,
>> +	.unregister_clks = hi3798mv200_sysctrl_clk_unregister,
>> +};
>> +
>> +static const struct of_device_id hi3798mv200_crg_match_table[] = {
>> +	{ .compatible = "hisilicon,hi3798mv200-crg",
>> +		.data = &hi3798mv200_crg_funcs },
>> +	{ .compatible = "hisilicon,hi3798mv200-sysctrl",
>> +		.data = &hi3798mv200_sysctrl_funcs },
> These are undocumented compatibles. Run checkpatch or properly order
> your patchset.
It's in patch 5. You mean binding patch first and then driver?
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


