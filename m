Return-Path: <linux-kernel+bounces-74611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE785D6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D078B1F23251
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F973C493;
	Wed, 21 Feb 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rEBzP5gE"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2049.outbound.protection.outlook.com [40.92.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FD40BE6;
	Wed, 21 Feb 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514698; cv=fail; b=l3au+NkNfSVD9AhCTsvOnD6iQENNlQXm3QcS8P7qxN/X4UQDGg4VKLk4F54aHMz+mgljHiitRku54H6v5qldetup3/EqNDP3ydKprwbaQNqbXzzHDhFjJv4t8hNR7PC8GJrg5eix6Cplo08kpr/N67I14BvJ+KEixej3/6rRxTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514698; c=relaxed/simple;
	bh=s1zCU9hFe6fNBld2Hv30H4O9KkRWu7toirzNoI4pXGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lv3MMXYjV9uNtQNDaT6Rovf7O3ZL3b21yv4q8cUWddMDPnvyRZ9xMOkLC710EPqmtrh2c8rRtr0OjxX3gbH0QZtaN+HyZkykLAIg01PUtciokS0LoxnCNBEK8gXJdCePQnQG6XQbnHJrgoE1+OC1Dtvy+QnRtiTuy0pHoek9LKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rEBzP5gE; arc=fail smtp.client-ip=40.92.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHYc18w/GbMebgIo9I5FB2QarYntsRt+gDaZ+ZrvApLGkN5TOnWwQTPBHjn2VSl33SHV8A8LVWkvjEi6ToH3BLXcFGfM+Lm+pkiAmpbEFMQcgnah9Qzepk1GpZtB5v3O6I6Fiy4jSeAZ8ZNF5o28qDmE4bsNReWilAo/JLon+fXafMxPLsmx/pIR/NMsRHOR+AYuDI4J44bmz6Z4km/AEA8GRpYWQdgt+6eSqyKZrBixyMtkshBC3TECAmfKfJgWoNCBJwUp5veeImFEJcnFaaA+nkIRIf7/7iYPFJjMdbj8KiIFAK0r7lLAym5/v+PtBcPjF5TPWn3L4PrcrdWimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwf6kiFo3yKo7CQhSIjVxA76NVHf06mErL986OUhM7Y=;
 b=TJTsb3dMERXTw9+RsiAtAv0yJJCssZUGNTB6JAEU4xwMqS+UI4eAJhesvGj2++ycrZPaTQ2E68Fz4twiZk+o5P2HC5zSedLnH45uAdaadhSFf7XJXR/GYRok2W+1DE8fBMOqbaHF2YFga9wj366L1c1b3C4VsQ/zGWMO3ffi5fnUdpMsT1Od0l3Zkvt6EMdEB7R/GE9HbUFvc3QomjMelWatyh4P54Lcqgzy4eLMXbWIB7VzROJHYD/Wpu1ZlS/Skk8VVBqlNLmRTh7d/2Jy+j58zl7nNRg4JuS/KkTiqIEPxOfxF4bs3uY7q5qmIFzVxdwrRSDxwes43aA+bsnZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwf6kiFo3yKo7CQhSIjVxA76NVHf06mErL986OUhM7Y=;
 b=rEBzP5gEKm2awxLPmUZeok3jYUWEvBq6XH2J4+J1I2emD/GnbLeYbgTx5D6/l8gMhZwdeahPudlJISgFr9odtpUpEvXKRh/tWKQq7FiRWqhNLHX2UhIH79Pk/14uScNh0p90fsWXr0Wg3xfu45NoKSNmfc0iTF2YMY0AcVeMWV8cicSqEtkhcIPSxN6z4paULr0sXHMTlrHZeRPowXMYDi3DeuV90TyFl8elf0Xmkoteu8bzVCdt1lxobMqgxuw1W0NChL7kJQegGDZofvZ7pv1xJNWsf8PfS3orjt5R0FT3HsgY4OfBlFWUHt7vR2ry3kgxcSCfzey60yqqnH7YVw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB6192.apcprd06.prod.outlook.com (2603:1096:400:332::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41; Wed, 21 Feb
 2024 11:24:51 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:24:51 +0000
Message-ID:
 <SEZPR06MB69593804E2F62586EF6841B096572@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 21 Feb 2024 19:24:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: net: hisilicon-femac-mdio:
 convert to YAML
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
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-2-b68e5b75e765@outlook.com>
 <174b9bf7-fcdb-48e3-a6d6-5d2ea96fce58@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <174b9bf7-fcdb-48e3-a6d6-5d2ea96fce58@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [fxUeDnxd+Xf+blW2wxyl3UE5I7R5/ko7lee/nkQvrHXm+gJypEYmuJCPmRKG6st9]
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <9db93186-1c20-4d2d-83e6-826839bd38d6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 44aea263-54ff-419d-a179-08dc32cfb87e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q3+8M46jYdnfHOtEA0myfmwBwl3r4jZbFbIgHKrxka1AP1KO7zgE0zuI/WIJ7e6orQBEu2j08FQn7aJTPbrEjUnti7/FP6u10x+qXMttMyXbUQltKrRnvFreldsHaue0kGBQwmAYXmcCWrnX/u4kJ0Y05joSukgv08AFF6Hm5iWaZALIAZeYFKFa62uUsC4pIjOI1GhtgunOI+Zab1zaV80h3UlsTQKGiYOZwFyGr/3rBWTp5fW121GHhhrxGbkYpIk6sP7+oZxGeY/y+0+yWBo9YI4ffd76mIJVhln6guOtKf2KLAqImyNGl3muoemqYsDN5FeHR8O7emaIrgZTyujkw7021nuvXIJ9K6Awqyb2/89uVWsLi5Isg0S4nwV6Q1qn8hsSTjUzaWR/xblzFp1Gny+c1GgJ/kx9XcTDWeODSpHZMkS02KZNsv5s7Hy+pz7Ui4MwuPOwgA8lYbRnDhRrgNtouqhfPY+QRlKRiRTcRiMkE+ZJOPlVm3zqc2AvRtyF2uf6TCiPktOALbl4LIBmV3nItlUkzfFT0v9dwa4tyWZxYOZBP9ghEzBuWrn1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVZHZ2w1RkMxTGxTcFY2bnZaQm5HTFgyem9Ocm10VUE2OXFxeGlTTllpdC85?=
 =?utf-8?B?VmNxNWtFSFAvcWtWSWxtVENpemFMak8yWmRIVlRYNEFpZWgzZ2w5eWg3ZkJ1?=
 =?utf-8?B?K24xZEtIWmdka3Q5MkY2RzVMUTRwYUdZWDJjZDYrRWNDVDl2Q1Nkb3NnSWxU?=
 =?utf-8?B?TU9Hazd0ZlNUYURxSWVBa0ovd2NCUFV2TWw5VkwzT3hsdi9QVE5iemxVbm1Q?=
 =?utf-8?B?SmU4YWtPWWJBcXo2Rkp3S1VHZjQ4Q1hEVTFEUUViclcvNmxKazNldUVXOTVC?=
 =?utf-8?B?bVI2SllLbHhsQ01GWXNyVWovZXFLcFNNVjF1bDBJZ0NodzEvUmc0S3BZdTNU?=
 =?utf-8?B?dk9WR3hraDMwam54c1IwTEU3SS9XVVpBUitvSXp1eUV3dlQ4TXdQVWdsWmVy?=
 =?utf-8?B?Rkkza1RJdnI3d3NwKytVajROejNBa25pSEozTm5taGdSeHNRTXhTWGtvWHJZ?=
 =?utf-8?B?WlUyalR3LzZLV0hjZnJWZER0QkF6VFEwRW5ITHE5MzcwV0pxNEVpZjlKQ2dS?=
 =?utf-8?B?dm5WaUlCM2E3RzZrdU92b3Mzbkp0M2RmUldGRTA0d1ZVZWc3OW9LNEk1T0pm?=
 =?utf-8?B?c0FxSy9IekZxeWVZNHlpdUdJdThFcEpqQzUvS3hpUUhHTE90SENGU0JWUGRn?=
 =?utf-8?B?ZjUvOHVPZFdFeWtXcnp6eFgyT0E4WUxJOHpPN3VCVU9rS28yVTl3WnVNakFj?=
 =?utf-8?B?ZnNNalEvODR3T2Vlbndpc0ZqWk1hRHJHQTRkM0hiMFRicWNYT2dXOEZmOGVp?=
 =?utf-8?B?clV2eUZEWjFYVVRiY1FTYUJyTXVwTkZhMndFWkpqaXBoMU12OTlHOUJqb0J5?=
 =?utf-8?B?RkVWbjd3NlVOK2x3Mks3WlBGSmhXNDNmcWNLRVAxa3orazh2OEMrcGdvckdN?=
 =?utf-8?B?SW1iaVpjQ1RJejRlRlhJOW15QkRwcHB2RjU2K0I0cjl3S2UrTENtaVp0MnNJ?=
 =?utf-8?B?U0tuMHFOTXNENWY0VzVsdWx2T2tjRkxwOHU5ZzhraUMwd0NWR25PdkxBZVl0?=
 =?utf-8?B?U0dVYVdKbldDMUJnMmtYWFFoOXBsZVpGeGV0TlVSSlFEZ3grdXZZWEo0elNP?=
 =?utf-8?B?aFFLZjVsclFCRDVzYU5ZNXBpQ1pIdCtWSC9ST3VxK0UvWlJRUm5KWjVrSjlt?=
 =?utf-8?B?TEFZQkVWbGNRZG9ZK0JyajJwQVVFNGQ2bldlc05Sako4Y3B6OWFISVk4cHFw?=
 =?utf-8?B?MTQ0czRBMUxhdmN1OUpzVTl6amkxOXpIQlV1bExUTFp1TzVzVGJ4Wlg2OXVo?=
 =?utf-8?B?YmFNeXJpMmM1NnppK243dCsrejltVXpDSDJmWkdSdWt2Wk1QRG05c3MxTit5?=
 =?utf-8?B?RG9pS210bm5EeHV1MyszT0N2bE9xOEVSWmM2Tmd5TDJhbXl6VXV6Q01SQm41?=
 =?utf-8?B?SnFOaUx5Qk4rZ2xPcTlIVTlMUEN1SWxvVFNTQWt6Q1RPK25ZQU92OWRlcWVx?=
 =?utf-8?B?VHF4blZUcXF0WkdDakIyL244cXFEWFBUMGdtRmFiYUNwbmdSRXVlNWFiejJP?=
 =?utf-8?B?OVlZNFcya0VoREcvUmZRbHZlRnFWZXdvTmF5dCtkZTZJZ3R4aEZqcWJxMEU5?=
 =?utf-8?B?Yi9mOHFYcVdjZFNVbXlZQTdqOVAzckEvNGlJKzN5cS85M3gzMjQ1dWxKM3R3?=
 =?utf-8?B?QUh5ZFJnck9FZzQ0MWh0aUxoLzB2R3RDdlBoMHk5UWxnT21ZTG41UkQ5TURk?=
 =?utf-8?B?clpCbWZ4N2xsWVhzYXNMUklBeERTekpJbTcrTHhnQ3hSNHVMWEErYmtVU2dJ?=
 =?utf-8?Q?19PZzCKCM5+rP7vOaZ31Ru8CNPZUWxtWjE3gdT+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aea263-54ff-419d-a179-08dc32cfb87e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 11:24:51.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6192

On 2/21/2024 4:12 PM, Krzysztof Kozlowski wrote:
> On 19/02/2024 20:57, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Also mark the clock optional
> Why? Your commit msg must provide rationale. Clocks are rarely optional
> signals, so this looks wrong.


Well. I don't know too much about the hardware either. I think the clock 
can be either shared with MAC controller or completely non-existent in 
hardware.


But from the driver side, the clock must be stripped from MDIO bus node. 
The clocks must be controlled entirely within MAC controller driver. Do 
I need to mention it in this commit too?


Actually I've never seen anything like "MDIO bus clock" in the 
datasheet. The MDIO bus and MAC controller are activated simultaneously. 
So I think removing this clock entirely is also acceptable.


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


