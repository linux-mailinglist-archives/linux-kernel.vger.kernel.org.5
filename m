Return-Path: <linux-kernel+bounces-91750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEEA87160E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404571C20D80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3135E7BAE1;
	Tue,  5 Mar 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b8NT2EeT"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2029.outbound.protection.outlook.com [40.92.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50696286A2;
	Tue,  5 Mar 2024 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621498; cv=fail; b=D+A3aZWcfCXmBftYmqMxvBg/yCo6djF74b9WIwum9M3OPMVO9b9ATw4Wy3wIH4OHxb2pQG+U9bhL02uXHh401q7vC/UKkfeTe/6qbjWpQMmLG/KOB2CVU6M3baiiDNTWBKC3btXHOg6Enk0SkewORRK9acStd+7cu52yKBeaMIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621498; c=relaxed/simple;
	bh=1Qlb0uL70RqudZIULJ2nCSI/Z5lK4F1OAKDIaViD3Oo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZAbKsK2hL44IMD4OTCm59PwJlYMXQROEQFCwupHzk9ydmCDNJOlrg/xKZBFMlX7d3K0ltOW9jqSMijG3Ys0/XRao6AyUMZOkFbV2ygmuaMQOMf94BRNmPMlIxpBXMiiTPOQELymdAWW6AtVt9MnwG4zNk2Zy/6JsKydPFpXTpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b8NT2EeT; arc=fail smtp.client-ip=40.92.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6193ZLZB8MDZVOMhXdlRkN1Ej3tTsFD7WX7vu4xwjXeOVsiMGvRVhLxTOs3NrTtvUT4ez0H67SaWN1xJG9sOmGRRLZ4Sq37XMB3yiWfmiQ3FnyL0DIJdJlG9CsLF/jkIK/zOOG13A3RcQssS3+PdrH8kdPYYyUE6RXy7OR0nJva/UKsAY/WS+QN3IZ0peugMEQ6fP6+iMcWu+3SeokuhlkyVjlk8rXNsEjqjZpsQJ3y+l3V+V55t7wuBEb19ogOXQcsaD9PYIGPej62Kka/IMyB3pj2/9FPo9gMPLG3BOyxJUqsJUKTV15m0WPkWXX/fRVwoeCd3J/zrW6YoO7dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jcB9u83F5O3ps0DyJttmXjWFR3xSbB8H0YDHKwOsS8=;
 b=WOErofaqLULugyB1wa0JDZiIub585BrDlIlHCfmicSVK9baa7mgIaIRFj9RSQBTgmAl5lisZABri/mLdiEdGoHz6PyVGbXxOijxgHnD1vtcvSovVBbv+Cdhe7rpoyVu3uh3j7Vpo1jUviIn+0Spmyf19ar5Grj8PEf+VRKOKWLPXp9ETs25LovYVJ3XdZ0gSdu5VnJT+/MZAwvktC4NZlmSv+U60PT+BZoF/dTW37iFiUKHBZ1uvocKm5AFpugDrkBQODY021Qspc1TGcTujztt/dzb9N+B4nWPUh7bfzNSDWhkr7Fb7Na+GPby04eUH/wIPvySTQGkIjBy7gDkHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jcB9u83F5O3ps0DyJttmXjWFR3xSbB8H0YDHKwOsS8=;
 b=b8NT2EeTAI6pVOkaKzcuKZZLzSgw4zfRGOQ6i4XJjxuSBuDNOMhNYjfyiQbWgOIovug4J3ys8ZXdjXOWHfcrAlShooUJdAEOfMoHsJGXteu3bAcYMSxSupG7d1sNKcvTb3kDIHmM1Klq5jM6m5UTVmwnP5aMXBF3hyfBwRkgd7yRLa4/hEW7HYDRdROgJ5X+iKyc1pswZ/G5LfF2v3hoElmdWheVD+RwyXGiDvzXlho3qC4qmHsMWtJbDG8e2gPvtwb5Kh6D4fnmYvL6Hw++YddPc0sx1IrHZp3s6VoCulWwiawD26UezpL5XI9297iuCl+yZreyHdAAC0A/GnGq3A==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SI2PR06MB5164.apcprd06.prod.outlook.com (2603:1096:4:1af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:51:29 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:51:29 +0000
Message-ID:
 <SEZPR06MB6959C96A0C09FBF47F1DDEF096222@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 5 Mar 2024 14:51:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 9/9] net: hisi_femac: remove unused
 MODULE_ALIAS()
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
 <20240301-net-v7-9-45823597d4d4@outlook.com>
 <724c1d96-6ec6-49c9-9714-502abd741252@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <724c1d96-6ec6-49c9-9714-502abd741252@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [fCFiJ2RoBR44x6pMWX6h17CZj6i8MlPQaFBoxIuzbiOscgoTQgS84dCtLohwfll7]
X-ClientProxiedBy: PU1PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:803:2a::15) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <56a87fbd-e9ad-43c2-a8a4-2107b0856f17@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SI2PR06MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 025f4197-80c1-4878-2af5-08dc3ce0aec3
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFCGxI/zYMkvshTNNymXRuhs1NnaL5oKXsiSWiKElk5v9Hx9hfirO8h5M+ZpRsdOk9b/5jZybzYpks2iDHJbC/QnB2g116NZ8s1SSN4e0fvCzSM0IXZ0HGOXH+lr92Yv5QskyEciprXmPfO710WZpubX7cm4NxrHQeRA6KRoKQ5j7QbSCX/6syF8vd/bNPZNsjMDARkk8TCxC3SzOp9Lp74SNbOtMmYXaZjVIh5zOmPTJ/SbId6TZ8cRfljlKxbiI/4J3BfzcQ3/dWo1maHUlxTmsSfb2tCcTkbFH1JimflXQ6aCOWx977FCFRiCprx3X7zKjpdIjD+guDdi1dPBV9wxZxAuzUgbVqChAEwXafljOzMbqkX/BEPUQs7gmrxH6c9CLFwnqXj9kp8b68CYjl7doTkztxIS9/wOym17EYJ+AB4Yhn3taKvY1F+ljPYdL97ffwDb56gE6IifOBI4n2r1w/SgW4BK2qjEiL0O2WA6a6pvOcZTASIXdYuYJNZ0KFVA0uQj3IG6/rgIXshd4PSMR68tqNQJBmksH3qVp5aYH5lcZgrJY05zKykf4q8rwvFjZ+lerAiN2NUj5zQTv03QRj8hZQUeM5zfUpVzr5aP/H7RpbPqxWhbAVyy8KB4+5WNmXqLTsju9rQFhyaJbucDu1N+RMZXbYUDulHPrA8jQUTGDLG+UikBf1Hn9mg3pUCvtMClrc9mgP5Ru56PhND5gtOpNQgBiWUChyn9I9l4IQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LgVrlyWkBopzHp/uNiqoXuSrC0L9SKl9dWY5xE8AUQdV3vuxwfkA7FSGYiG2DF3adu/VZztfV4Pyhc9JAhNB37SM1DJwD2ix+9+IwiG/7MIjS/GYsABq7oaZwRvKmSjpKf4B3tyA5b317JP6Htjns2Kqe0C3OR3NDcITtQAtmJIFFhR9Ed62gYeUJ18FpV3PrkZp4nOklHPKF/69IsSw7kn+f+iBQkhM9rvjocgIk6PqH36XVqA5sxAHUbMrqgU+F+ILFt3xT1bzPPEKzljO5vPVGOKRPybcrcIV7CkgPZpfZTu536i0Au+Z+IokwwmJPn+MN8Yah1hhH4Ql0eKyom2/4+LDfKeGHBbLM54yFDBga2t8vS4GieC/sg/9qem2jKMYrzaNGHMVAVbqO+ZAC8hOAMANDXaFvZLFXG8n9ELmPtp3BDKGkbzQhNqtI4ghMPqwRoezz2zbX/9cyAbV+T9ShjBhY9WuLcjGx2lFuAMGuVzGpG2/GWWYn2eb+l/MBsSA2Sl37dWzX8epw0sxMisygaxDSeJIsg/OaEmBDbIi075Izj9b+ARMFR3Rlb7u
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2NPdDlkVDU5eFduck92ZURETG96NHJYTzRoeFpMelA1TU1DUkZkOFlLNTIv?=
 =?utf-8?B?SXhkdEVzVkNpMXRKV0NMQWNYcExvY3ovTnFyTU5qZ2c3Mmo3Z2Z5YStNZWpB?=
 =?utf-8?B?Q1gyYnBlcEFySi9kNUhJaVpWeWF6WnFFTWsrUjA4RU9aT1ZSQ3FvMCt5UStv?=
 =?utf-8?B?TzVOL1VLL1VkR0x4Vk0zZDhxNE1rdVB6UjVHK3VBbW9iU2hZdGRaQlI1c3dj?=
 =?utf-8?B?TGlqZjFyb0duSHNCeVVqRG4yWWd5b0sxbjRIVGdpdndMMmZsMEFvRy9UbkNU?=
 =?utf-8?B?TUJHT1l0THR4SEFnMU93TUZKSVZnMTZCR3hja211akt1QVlaV0hjbUp6Rk5h?=
 =?utf-8?B?enNzWUZlMGx3T0hPN1NSYmlzOU1UZWdxR3VOYmRrQXVEL1F6aHI1WDM1R0J2?=
 =?utf-8?B?YS80VE1zbTNub2dtc3UySWxuUkgzUk1reEtJZ0ozdGd5NFZYbytXRU9vM25Q?=
 =?utf-8?B?eG1BUUtUSlpKS203eHd4MWtweVQ0VC9iUjNuWXNIQ2ZnU1BBMUtYeWs4TnRU?=
 =?utf-8?B?OXo1SnJYZUlyTkUzUUErckEra1pUMzMxRWFHeTRmVndCWlJ5cksvYTdYbDRG?=
 =?utf-8?B?RHpuMTNmZ1JYOHE3c2NCUFArVmZKQVBGT0J5MmhnUkUwV1FJcmgrOXM0SUQy?=
 =?utf-8?B?VHFrQnk5TWo1NUxlc3dHYzMram10WEdmM0dMTENyK2RtTVVpeW5wZk96eHg2?=
 =?utf-8?B?bjFSNGYrMDRkQ25YMUNpeThsRlJESnB3K01Ra2IzbUlYT3FPcjJBakpDbGNj?=
 =?utf-8?B?djNPUXFueGRtSVVFZUlHNG9wVGRrMExNRjJjRVdlSm5GNUlCK0hLQi9SLytK?=
 =?utf-8?B?bUpBa2ptK2VOdG91NWkxbHRMUm95NHBNWW9ZS0ZHdkp5QTQ5S1AzaHdkazJM?=
 =?utf-8?B?Z3ZuYmVwUGw0MXJzYUg5NXplRWEwZjA4MG0rT3hWRi94RjRZc1RWb3ZsYmp6?=
 =?utf-8?B?MVZmSDVNajJVYUozdytmb1VQQytFTFF3ZnZCdFlJRHFFYlFwV1RScy9VcGFM?=
 =?utf-8?B?enVQUWpYQXljSUlVLzY1SE1iS1loYXJSZGdmdGdtZTVmaVdOTzErek1GY05S?=
 =?utf-8?B?V3hUSHNPYVRFeXZwVWU1MHhLQjNod3pZRkFhS1oyVDBLZEZaOVBkcGFiVmE0?=
 =?utf-8?B?bWFuQlMzdlQvQkJ0RlYxQUkvVkd1SFJXWlFQbCs1ZHhpUStwVk0zZjFDWjNU?=
 =?utf-8?B?andVT2REZ2RWM0tPS0R4Zm5VNG15ODZhKzZlUXowbUczVVN2SGRMZm1vUVY0?=
 =?utf-8?B?UFJOUGRUY296UzV5bENBMmJNd3R6eGIrTGhRdkE1RHlaOGRRbXl5NW1ieHh0?=
 =?utf-8?B?NWpVV21JWGJtSFlrMG5ydk1ZNExCZ3F6L2MrdWJLRkU4MEhyZitnd3dvNE9V?=
 =?utf-8?B?UzdIcWVEMlBiQTc5NFVOSGp4T0tZTXN4bEN4Q3pqSnEwVnJaZlM4U3diMVFr?=
 =?utf-8?B?cE50VEhBK0orVyttN0p0ZUtPMEtaQ3dzLzdxQWFSd1NlQ2RhVkNSeWQwVFQ1?=
 =?utf-8?B?ajkrWTJRR05uQ0llYkVZZzYzNllEREcweUplT1oxd2FrMjNMcGJSV0g3dHNJ?=
 =?utf-8?B?TWxRTUxnOTAzaG8wSHRQNjZYRitUMERONG9tRlNKZy9hUDNpdzBlczBMNHd4?=
 =?utf-8?B?eWZTWU5nZjU4cEhUUFJURkZBYjAzNkhBOWlHbE1uMFJlTWpScUZ5MFhFcjVu?=
 =?utf-8?B?YlFZNkFBK1g5d0JnVFBSY0lJclM1YWpwR1dhS2pOZlN0UEFjM0V3VHRvdVN2?=
 =?utf-8?Q?tUSvBLhDSGKoQtDRGiDqrp0p+pHFuKsGCXzRE79?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025f4197-80c1-4878-2af5-08dc3ce0aec3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:51:28.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5164

On 3/1/2024 2:50 PM, Krzysztof Kozlowski wrote:
> On 01/03/2024 04:36, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> We already have MODULE_DEVICE_TABLE(), so this MODULE_ALIAS() has no use
>> and should be removed.
>>
> That's not accurate. You don't have for platform IDs, so you basically
> remove ability to autoload via platform. It's fine for me, but the
> commit msg is just misleading.


I've never heard of any distro making use of this custom alias. A 
generic OF based module alias is enough.


>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


