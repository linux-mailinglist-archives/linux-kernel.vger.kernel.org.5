Return-Path: <linux-kernel+bounces-67890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5B85726C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268A81C23AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C14A1B;
	Fri, 16 Feb 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RU49sUyr"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2106.outbound.protection.outlook.com [40.92.107.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7A28E8;
	Fri, 16 Feb 2024 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042862; cv=fail; b=cNJY61g9akAxl0Q2GCPtLtGx74DK8JUCH3klr7+jcuJmoIA/FzIm4HOVXsV0JHiQUiaAiuwQYQf5xgO/5g3iZdSF0KR3I5zNzDr4TRHNBcFfvNSDFt1eqohCTwtpNqPUeDGWdHhpuHpKvqP038k1KX8b4SCzxcHIl592EnmHH/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042862; c=relaxed/simple;
	bh=lTnLYEzm7+EmA4tHaCF0VTHX4+vxn3hVWKWRfc1FxT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ue6AI3sirB5ZJE7Zke4jvAJVFu8tSi0ItBV9hPsad5a1S+cvw5SiIzqn1AshBjJOMPAcL+ibm5vpKDVZ6yRFtLN93bs/74KvUlfZc+L+kb2o3l519/SyuW6IrBo0GC0VAqO/M3PlPmooVtE5aktqN9GYQLiekJBTBoN4Lqyaq6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RU49sUyr; arc=fail smtp.client-ip=40.92.107.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM0Ypok/waT6O3SB87JoO7moL/BQubCrlYq/ZzQv8NxpG/YtbsUkGhDvHgOAJoSt4g+JQ780roqwrfxnjw77W+Vp4L2FvdtHrf9eIC6O/+tID00JB64+uEizI2Nx3W9uqwOX4/LsLMkpVW6wDfRpRU+y5QDfWgn6sPP0AO0GKU5l34qRD/teLHjYPqw/+2jzWqwCm0ogK7NNLNwx09AsCD0vanyLnM7IUPzI6hfxtzXp3viIXYRz2LpUQ8AHMK3b50IDXBZG0oN3G/xYaPjx7Ln7qbZuEmHaLSmL7hPiOabWRI15EB+er82zu8OdfALa7MkpQ9xaeTk+2Pa2vEw25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biuyxVhb/VuIU6H+Bii18JCkQalSyc0wqmehbugDAhA=;
 b=FkaT3ZXlz48xHQgfckk5QZy9ZgOpr6aW88e8dm0rxOV4PAAhpUNf2Zd12cgm5PgHrm3mt9GyIyA2xkVgu10MZWXDvBvU5Zu4DzG9KPcO8I6JGnik0/DN8zaaQmzJL1DU2IfjoAnq385jfrFVHEprH0nhU3nyQj0Anse9aQQ2W2Dxt8dgKyw9zZ9tzC3rW3IturBdlIz06oHoC8+/Q5rswl1hKOcXXMB0A1lAOKKj7pC965gM4uRElM12FUEkBiaiGwDc0XRRZ1kOfWe5v83PBszV1ExN/aAT8Tw4EB24Jgn+yjfc5+kQ8Z8pur3bjS23eEfdklenXaSbOpc61ObibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biuyxVhb/VuIU6H+Bii18JCkQalSyc0wqmehbugDAhA=;
 b=RU49sUyrxLKzPKCk71zY6reOLQRqr6wcygSV7NGtucG27DDvCbpZ2NOkUs8XIJqgNsCHrW1mGBi7YtL4NcKKZ6Qj1BiqDj9efBiuOBng40R83UYsEH4mQlIfTclp3aPMOF45AQcY83gR8b7ZVexcRP1xEx9A/BNQG85n2h6KDB82lYXaLPB28ad7aZT1ygUr3EA0ItTvRbFFO7NppLIl8jtH+nIImV/Aab/kPGzV3H3nN0aBfHPnUnlwu/skN+7dx5A8qcBaR/P9ozKQ0mEWc+bncVSZE9kpvKz8kZS/QISF29AY0t41iqgp7UIt7qvnWZWOlWfl8clPEFWadKpWFQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5246.apcprd06.prod.outlook.com (2603:1096:101:76::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 00:20:54 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 00:20:54 +0000
Message-ID:
 <SEZPR06MB6959CC3284F21DB82856891D964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 08:20:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
 <c38f7cfd-2eca-40ac-948c-bc98478e67b2@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <c38f7cfd-2eca-40ac-948c-bc98478e67b2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [eDMrhTkgNuWH6OewSlBKm8xYYfJGB2M9on2jMBkrVFocOnkGicJs8psHJ+BGzVxnEAvBTbBMu3U=]
X-ClientProxiedBy: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <0fa92582-82c8-4e2e-b38c-db7c3a5f4aff@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f0c9a9-ec61-4060-8bc9-08dc2e85236e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PYas8Vpfqip5jc9Zzz0pwLebDN/Mohreio/WbNDJ3GCuaXYeevugH8GvEYJX/bUDAaGRM0beJMvKd/gHD+Rn1bFrUBosShzUxt7Ca+9URI6TFWRgEHUg0XFf/306PZBtATpcuF6SK+gzowOn5DOVrjXc67Sprw5IOGIVd8zYrLiRP3V5nCvKCqx1LT60rtVfMitMlSVa+HXKPMmg1hRFiXOnS/n8+bFtldzY3/yYKpBDout2gP+FWcEzvfFbDM+nPvxf/rRh4UKy8NvYYN4NGKa5rI6tZH89pXm+hDjgVZBZKe9/bLGQhLAkimVUrzulkFtloyuZi3stTXK7RQDhgUcguXxnC4BdyidVhqb3qND0UzlauSop4mEl7sY+DWy5qM9/JNbUngnFaDE6ugyWqSG8lHPbhYWfkouLK4g0Wgvib0vUc89zxF56FX9ZFwVqU1V8LuSAP22Nv4bnipcuYnOezWPbt/7P8UQvZVrCc31wkoU1rMPNsf5A0SuCGWmyTNDbDZFR65s4pAKnwk6YZ7arW5ROL7Wc5qWWrxJuszNylxoqdH15AVMbgZ9jJZxB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2k3UmJSRmxEOWZsemlaanlyR0dpcUhLQW54MkhFQUpzQ1Z1eUtka0ljeWcr?=
 =?utf-8?B?eFVyenhzTGtDbi9yN09ZcmREY25GbnhiUUY1SFhUdmtkU2hHNURQMEd1Z3py?=
 =?utf-8?B?NXIzS0JwMjZ6RzRaaWpSaWZ3cHpFeXBnT056M1lKMkpGRmgyYkhnTjhSS2JG?=
 =?utf-8?B?aFJWWTlBbFNvaW1JQjlsYk9VMzlFV2Jsb2o5K21kYklnS0NMazdkV3ZUNWhn?=
 =?utf-8?B?TS91dVJPdk1kTVRvREk0NkxGbm9UdW5YbFYyY0YzcnBQbjlMbGgxVXg1cGoz?=
 =?utf-8?B?bldrRjFKcDh5Q2JtM3ljNkpKTlpzSDcyRXA1SnVRVUt0ck45V0xhTm1wcWtC?=
 =?utf-8?B?VHErUWV6SEdHVlBsQUx1NTdsL3VqL253RisxeVh3YjJpZlNycmJPVk1PaGg5?=
 =?utf-8?B?WEJRa3NnRytBcWYyUGRacEtGTXFxa2UyWU8rd0ZCTmJIMTZMd0ZaVHFZSE9F?=
 =?utf-8?B?WEhXNzd2Z2p2L0JKR09LZWltdXA3K05CV3ZxZkoyRFpVR2tkQzF2TlIvSFRh?=
 =?utf-8?B?WGdCRFNLd1FRNmRCTFdFeUI5RTJNalZ2dmxZRVYwNnE0L0V3cngzMk1xUGl6?=
 =?utf-8?B?QUIrMXlEazY0emZLTVZFRUhaNzc1NmZWdU5GakVnY1NFdEFZQ0tXQXhnaXlu?=
 =?utf-8?B?Q3FkWkl6cVpFUDBCL0JKQk5KMXEvYzYvN1VwY211UEZ1MS9WYlViUXk5VFAw?=
 =?utf-8?B?alRPdmQ0SXpwRmxwRURXRDBWcVB6SnVaMUlzWC9JQUg0RG5IZGFLVlNwWUhr?=
 =?utf-8?B?akdaWmFWNWNFT1IyaHhMOERiaWhzWTlBVWp6S0E1WDdRRElRblVOZUd2Wkht?=
 =?utf-8?B?bXVxZlFvWlVFeGVUS1RYTmJIUWNjRnN5azBtbWxpVjJLVEFieHJ2L3NiU0tK?=
 =?utf-8?B?NnVnU1I0ZENZZ1pkV3BiYzc2QjdoZE0wUGoxU0tPK3d5SU04em91MUlFSkp5?=
 =?utf-8?B?aDFXby94cis1VngzY0Z1UXhTQVJlNlFObnBFSWV2NEE2T3BkM3NjMDY0SHVy?=
 =?utf-8?B?UW9EdVpaZGNCL3IzV2lzY3hQTWVoQmE2S01OM05CV3JldUw2cjdCdzhVc2dU?=
 =?utf-8?B?NXppRnlYWTdreTREU2JKSmRxVVVCNnMrVWl6WG15Q1RTREhiYStpaW5Ed3RR?=
 =?utf-8?B?cVBmeXQ0L2oyOVl3UmlkSEpyazBJL0N3TVBkMDI1UVptNXZBUWJvV210cUZP?=
 =?utf-8?B?YlkrOE1qZGo1Vk93TmMzNFVCNThHZVl5bDhLK2pBWlZJMm5jalJUMUlNVFhR?=
 =?utf-8?B?MVo2aXpVbGFDMFJTajFsMUdOQmN0RFFPL2JpSEtPaER4VHFqS1hFU1RXSStW?=
 =?utf-8?B?Q3MzTG9YZFdxMnNCdVdRbHRjQWxuTjhiaERnWGRUTE9NYnFCWVB2NXUvRUNr?=
 =?utf-8?B?UndXbm5YNjlQYjN1OFBhTHhlTnA3eHFxQmJqSFRabmVKTHFIUEEvbDJBTUpl?=
 =?utf-8?B?dks2YzBRUkRZV1IxbzFkdFZkUnZGb3RTTGZXdTA4aHV1T2lpSERoSDZ1SFdt?=
 =?utf-8?B?eEVtbHFvazNuNzlicTlFS0pzQ1ZTZEdhMFlFUnI5bjNTMEhtTWJvSCtOOXhw?=
 =?utf-8?B?aWtVVFR1VWwzOHppYTZrMUdObGNWKzhUNi80K1pJeHVKa2FObThLQ1E2bHp1?=
 =?utf-8?B?eC9pYytYTEsyV1RSNURNSHpQSjltVVY4K3B0MGVTSDlLcHFzQmtyd0xEem1F?=
 =?utf-8?B?VkN1ZGRBbFVyOEJpRGoyU2JFZ0JCOHFGLytoUjR5aFpFR2kvdnMwTk02RERH?=
 =?utf-8?Q?8A/dnDcRHGkpbx0yPnbh0l5lDlD4KG723QsmWZ5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f0c9a9-ec61-4060-8bc9-08dc2e85236e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:20:54.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5246

On 2/16/2024 8:06 AM, Andrew Lunn wrote:
>> +  clocks:
>> +    minItems: 3
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    items:
>> +      - const: mac
>> +      - const: macif
>> +      - const: phy
> The C code has:
>
> +enum clk_type {
> +       CLK_MAC,
> +       CLK_BUS,
> +       CLK_PHY,
> +       CLK_NUM,
> +};
>
> Could you explain BUS vs macif?
To be honest, I don't know. "macif" is used by hisi-gmac driver, but in 
the TRM it's called "bus". So I guess it's just an alias? As you 
mentioned, I'll stick to macif everywhere, to keep sync with hisi-gmac 
driver.
>
> Also, what exactly is the PHY clock?
As the name suggests, it's not part of the mac controller actually, 
rather it's the clock of the internal PHY. The SoC (or the PHY/MAC, I 
don't know exactly which) is quirky that it is mandatory to disable PHY 
CLK before MAC reset or else the PHY won't work(see 
hisi_femac_phy_reset()). I can't find a better solution. Letting the 
ethernet controller manage all clocks and resets seems the easiest way 
to handle this quirk.
>
>        Andrew


-- 
Regards,
Yang Xiwen


