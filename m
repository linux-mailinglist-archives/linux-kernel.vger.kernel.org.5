Return-Path: <linux-kernel+bounces-87974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947586DBAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A5F1C2352B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241D6930E;
	Fri,  1 Mar 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L30ymP+/"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2108.outbound.protection.outlook.com [40.92.52.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79213ACC;
	Fri,  1 Mar 2024 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275785; cv=fail; b=ilY2MrB6vreviOkhRQJMufUX3tOWJGOrLo/M5cm+U7ZC9mRvc/nlUv4nT9YZx2AZb0EN8ZrQbP7d6PTmEvfKWIjmUm4OB2A1uBgUkSXBDcw1fIlfqs6w7lDAXPgVzSdGhD9fGvU78D8OTJBXpJ244lJRW+9n5rk6FnuCbQoZ6yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275785; c=relaxed/simple;
	bh=qSdUHi89SlCrJ1WLHeSUnomu4JUwjBrvFd0q/reDD+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Heko7TahwYvG8HWNIKlmwlot2krKBmTMq2PH0PZ393SOXxPVrf7LcMZQHW8YXhIHjM6zT1Xj+YKT72wkd0Ic3uEd9kqvUjJgOys188u1DQrdVdYgykDwr6GRKsg0nJkEhfvfqajfniD/p3UvyYiLdG0ldlcbY5cuvV+JiNPzRkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L30ymP+/; arc=fail smtp.client-ip=40.92.52.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3q0+U7+4MIv6ksOt3kHmXCKVrsCuMZ1PKTxolt5drKhTK5hWrgPgagLgEUHkFa2MK/BuJquSunXpnhis877NzpeSlLISsXj5a92XIgUYTq1l0WbOCvDjxiq6ZOr0m26ZKOKJI0TmejI0MB1h8KfipiopGnTfuRuys83Q55kNF3mNbuxIQC6ayrRR8TL0uhgk8wxN8vWSCbpO+y4AVIy+V7sUHJmk9li8/qcfyKyfUSsCbJnUxUEcxJG3n4R6tBlfKz9hGhYwvEq10rVeBgXS4bKw/OTldSzDLvWoD6WVyCt/bJGWL0g/3iv5MD/1HwfCVoyYXfCnSksOG8GJa3bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w+OaGNJB38Mn2TTZ8JuEkcZHUJLcAtj9+hz0jf9Y2M=;
 b=QqdK8I/fEJhJRIiW5UEGheoE26UjOcsrMzkX6ynqg3O+Vkm2lp34RD3CR2vem59Gkck7Aka5y2gWuzwBxppzfOenCHuzcnCW8miunXkvdRAkoYlkuV9QiT5jYTYNW/kQ4cjrSrwPYlpyw35ChH/HPcrViDLGZ5UJvDFpsmLN25qZOPbJPaqWn0KSudxR1AjqTCJPTuWKT/QVr7S6ny2W2ip5CZpjIbrHKS1oJ7JcgxUZBq0pGSLE1cRD2yj+xtyLb2pV8aSku7Ro8g7AS/f1WOCxbM5u5Sbl6JeUFOcfd6erqmiE7KVL2Q86qcqF9wDamOM9wy+DgVZFcOAHG9zs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w+OaGNJB38Mn2TTZ8JuEkcZHUJLcAtj9+hz0jf9Y2M=;
 b=L30ymP+/eIklzUfxLXRagY1LgqWhOnZWRGFnP5jvoknYBbkwLhaT8sNkbhcHle8jaRhOY+dxdaBP8gkhvrACLIR8eW/vxVZsZ8fCXzt5fKGlKDOgmqbCuBiv75vD6ObFz3riXfrVkDsnKUlrHYGh6CvXLtstVz3NWLKdNIifzeLcdiDjzN7XXS1CXpYBN4aosIxcZma837EXJzuO/LReLPYDztH509bVg484eZzYORSEnBqDbbtamSgpNp2VinPf9jK56kDbopVeTNvVnPKGR1K7lukXVTKN0cTk2KAwV9Bgt5qrY0kZmgdpJ8tSDdXmgnjyBgGJUQ25iLQPhUPYrA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB5940.apcprd06.prod.outlook.com (2603:1096:101:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 06:49:38 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 06:49:38 +0000
Message-ID:
 <SEZPR06MB6959D0455614D656467417A9965E2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 1 Mar 2024 14:49:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 7/9] net: hisi_femac: remove unused compatible
 strings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240301-net-v7-0-45823597d4d4@outlook.com>
 <20240301-net-v7-7-45823597d4d4@outlook.com>
 <a24320b7-5cf2-4a6d-af7f-d07dfd0dc29a@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <a24320b7-5cf2-4a6d-af7f-d07dfd0dc29a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [4ZrChT96M0/uuOb8yWs8K5kRyMj1BpjJva+XDO1TdSYk0xeQsd+ntAiVodlKQgZd]
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <74d638e6-1d36-4ac7-a44c-aeba913c2fe3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc17180-d7fb-449c-53d1-08dc39bbc365
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U+nSEz/sTIvLTMqsF1Io47GMbl473f6Mn9etkIxRRxY/2wZf5RR22c24ZTV6pU1oHvOj9mxDUjLb08W3b9HpLdaxYNQmOuAb8Uda60kvYo+Z/TLZIWjsgwoLdF8Tx5y10rsHApsF4jQxjtbLPwKbbU7cEfumi8ho1xngZA5lxpcmCd0yPTbWzHAXU5joB17DKSoOkcRc9blHvYN4XbeOIoAHx3kpX3yg418PN59m9twsKFgK6yEROSQD4OFI6W/UEvqevD2GzJTMJixKheZIUm6ewyqrCli72AkDiEK3JWyWNrTTovmMSILlVpmLiNP77PBz/Vxvzh+awavEa+CKHY2SibaP2hEAEKJVpCRVhGfGZgCyy35pDaSx1RJ61LB0J4hywe5z5nLgc7py1z4+ApT4DDcikaKfNupFGXF64GFB3Jhh/e0ravg1Dw0uI6CmwnmJBH/Gb4w33sG7sJr8CprEIcN78HG51zJcFtc3lY+bR7dmIYMqN2iNFJZHRLaWOu96SPWPREUNKVTfO8ufgXhPUsK/SAsIcsbBfsBIWMGlrD/CqQX1+vHJOIdZGaDT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2pEeDlvbzZRS0tYUHR0Q0ltdGZoV3lGNHo0M0tBZlYvZXV1RllqSld5Wk1o?=
 =?utf-8?B?NFVTNEFkRFJWZmVnZWRSd0N0WjJCQ1E2ckpQMW1yYkd3dWVEVGt0OXMwZy9O?=
 =?utf-8?B?ZjVuNlQzMUxWV0xwT0dRaWJlTGdRUy94TDU1UGdkV3ZXcVFmSk04SW96QS9Y?=
 =?utf-8?B?dUJtYlZUTUlPankxek40Y1JnYWtZT2s1SlBjNFlwTzZ5NVo4SlRvUDdOdEp5?=
 =?utf-8?B?S0dLaVJJVmlLdUVRWDl6NUpyZnd2eFcvRU5lc2NSQkgvN01yNERPSmVkVkRs?=
 =?utf-8?B?SmNrbkpzQVR1OWJ3dldKZjFRQU5peTVWRkJIZVorc3BOU0JQb21KNkswQ3BS?=
 =?utf-8?B?VXhTaVZUNlV1bi9aMVQ0UkRnUkVlRnIxY3JzUTllQ1JFNEtoeUMzZU94cTNs?=
 =?utf-8?B?Um1xVGFCcVR2ZTVEMS9ZbkNHMzJROVc1Y2lPS093VGlsdGZONXRWNytrZmJW?=
 =?utf-8?B?aS8wNnk5cjcrY0p3ZERLZ3dDaTF2SWhDeUlvRVdPaVNkM1dFd1Ftck5UaFpU?=
 =?utf-8?B?QmQ1ZzZkd3k1NDFCbmVsUnJuSnd3VlB0TC8zc1ZtVWpaVEIyalZIM2R3Z1RO?=
 =?utf-8?B?alh3Zy9Td0M2UlJsOCtYOEdsMFdLY3JCdm80dnFnNTBZM1c0cHRRdDY5MWRl?=
 =?utf-8?B?dW5HbmlvY3BSWVNmZ1hGdm4vNFZ3VTVhNFR4UnExUjNTdU5adHBNSVJsaXU4?=
 =?utf-8?B?MDY2Z3JiMU9kVit5RUd0QWM2TXpyMWpCcDJqV1lrd0JwM3lVNmZoc3lGV09W?=
 =?utf-8?B?L3ZWOHArWDRiYlpzOHNsaTh6L3pEd3YwYUJQT09yUjlTcE1CKytwR3pKdWxU?=
 =?utf-8?B?ZnBuQUR1cmJVS3YxaE5NbFZZamd2OGtVaWRvOGhaazlxREFWSmZ4bm9OK3RN?=
 =?utf-8?B?RUV5UzJ2anlPNHhMK0orOXhjQTFQREt5a2NuT0htd2NWdHJhRjBLQ2tmeStj?=
 =?utf-8?B?VnJTdjZwNHlJd3QxNUFRRldNOEF6UHI2NC82QWVyVFBVcFdCOE1SSmVzcUl3?=
 =?utf-8?B?U0hLVWlWUlMwWEtRazQ5ckRpcFVDeVRZWW5TWGEyRVpQajNFaTBWUE1MZ2pY?=
 =?utf-8?B?eG9rWmRaVE4zVFhMc3ZCR1ROSys5aHFGU2I5UEVqV2NrY3pNeTVuTGZLZ2Fx?=
 =?utf-8?B?OHJ3bjNGS3JwU1dONjBlaTIzMHB3TDNUYzdxMkZ5dEcxNm1aVVlCZ1MvUVF6?=
 =?utf-8?B?Y2RGMGpWMWJqaE5JM2Fwb1BoMUV2c1B0eUxiaGtjQnNJZEdXZlIyNWJrWjhj?=
 =?utf-8?B?UytVQ1htcmpNUHc4b3F1Z0cwU1luRDEzTDFyVGorTk1wa0puRzAwZkdMR0N4?=
 =?utf-8?B?aG9oaGlRVTQ5RjFoT3dwdmdSVDdyWVBsNUtlVzdNbmxMcXhOZzlaLzFDRzN2?=
 =?utf-8?B?N2loUjBnbXIyaVNtU04wNmpyMTdIWkZESC8zTWsxNTBIU1Nzd2J0K09QWTRK?=
 =?utf-8?B?K3JjR1kzNi9IMHpKMmVvQWhzZWc4MVdTM0dTY3pUSHJxSlZSV3p6NzljUnRl?=
 =?utf-8?B?Y2pvVVpVempjVzEwdVhmRVRWbGFQOWR1L0hXZEl6V2hIUEtJMFdpVG5iU2VU?=
 =?utf-8?B?S3kzT25nV3pKRDlXUlkxVXhvaGZnbXVieElnK0RmSnpjZ3M0WXk2Tzk4NXd4?=
 =?utf-8?B?QmhPTHRaU0NqOU1xZDVwSk9tdGtMZkNJS2ZkZFpoTkZTRFhNT1FEZHRQWlBn?=
 =?utf-8?B?OWUrMkljZkgzNTlaQUdESlJDYjNkVTFZV1JCM3ovOEo3bXJVZzc2Rm1lc3hs?=
 =?utf-8?Q?CH+32YAxaYmClkS3T/6yQc7h9k9dcUJJ3yKfS3m?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc17180-d7fb-449c-53d1-08dc39bbc365
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 06:49:38.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5940

On 3/1/2024 2:48 PM, Krzysztof Kozlowski wrote:
> On 01/03/2024 04:36, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> It's hard to get the version number for each FEMAC core and it's unknown
>> how the version can be used. Remove them until it's really needed.
>>
>> While at it, remove SoC compatibles and only use fallback compatible.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>  drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
>> index 2406263c9dd3..5a088cba7d4e 100644
>> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
>> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
>> @@ -945,9 +945,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>  #endif
>>  
>>  static const struct of_device_id hisi_femac_match[] = {
>> -	{.compatible = "hisilicon,hisi-femac-v1",},
>> -	{.compatible = "hisilicon,hisi-femac-v2",},
>> -	{.compatible = "hisilicon,hi3516cv300-femac",},
>> +	{.compatible = "hisilicon,hisi-femac",},
> 
> 
> This breaks the ABI. I explained at least twice - use SoC compatibles. ONLY.

Sorry for the misuderstanding.

> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Yang Xiwen


