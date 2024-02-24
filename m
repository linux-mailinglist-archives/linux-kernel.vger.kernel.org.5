Return-Path: <linux-kernel+bounces-79620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008938624C8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A661C219A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240DF3BB3A;
	Sat, 24 Feb 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mn2aiat4"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2081.outbound.protection.outlook.com [40.92.52.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763E18E2A;
	Sat, 24 Feb 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776103; cv=fail; b=U9Bxsffk3kU4ydqIs+U8Qs5p3dnaYX3FaRB+EuFnD9g0pXY0ZNt0Do+xmpj5jQdNVngBnI1UZkDm0Umch3d+VA5shoHYw30revtq5xqUpSwA0vW0CeNgd3sft0gHOK3ZZ2ehgjWLAL+ajGbkCelcz799RIEuHCfEb65/GRk0YIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776103; c=relaxed/simple;
	bh=Ee88mkDWMHfbx2frl3TPj/ECIEMpO6zFM9sId///5CA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkLR+mj/8rU7FY2wqhK3PcEqceUoBGv7LaUPQfRbpnP7fx5V95hIJ8op8DxlUMusa1aRAz9kg3bSAtf0luDI5AKKQcp6rIPi1ISbhk1FepMy57SdV4i9weUFtcEdTXzPYbuSHAxf0EHeK3uhfyw/NTc/qwG76CmqAm2HO+Qgibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mn2aiat4; arc=fail smtp.client-ip=40.92.52.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHuw928pPM/h5oyi3rSZwG62JUbZy8oysiDzL6wwynl2IpAnwnyyRuhyJoccQ1q2ueYKbbtCKjKJAdzjESbIFe/87crOn3jEom2gWoFy16aRIhtwhdUZIc+za6/j/uG/DWVgUATQdujN/gYk6Fi/MtUorJW9XVYHP1KbCBoiuGSjEK7YAu2t3AULVS+kR6YlEUWUgg9fUjrfaZXX8ONbe7MmL1FQ7XAxmca5ZAhHGh7k7QNbse+zv1/vNfItehjw6kMCMXKRkskltIKfXPxbSvj5zcesEWBcdeAh/4lABdHhHs9OEsszDa+HFFtndL11Wj74lCVFUFSpzOcfVE9c6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6qXhS6V6YBC5FVzXEC2gnWAJ4XVga7wwsPZYNDyLlM=;
 b=KLRTpJzv4SCzbo4+FBpoW7yalNSrvMb3qzchTUfQ1wymwjK6yCOEUSc2g/Rurj8XTYQ56vffZBbTOFpyRmG5D01ctloEZ02B6OSj6a6jiHvImZbipkHgY4tjV0yA84wS52G98QwAUH+NXmjUzAiuqyscKdi/LF8yt9xXuCyjhE/0Wm5pnkjPnhBb1HFJ6SaTkUxRqtBSZM56zcVpi8/dsmT6WNrpRppoxbOcUd1f66d//XKOCYJT7UvEvbaH99YdXQpAIlwybmItaGLFuptumZxi88lhf6WvDMi5DWKKOYs8RvoZrPBflya7//Tj06ycoV13QTDaghXotSQi3EObCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6qXhS6V6YBC5FVzXEC2gnWAJ4XVga7wwsPZYNDyLlM=;
 b=Mn2aiat4+coTI8Mu1Z2812Hra7cV0yhF0SFCZtARYuBXy2tE1Ac369pr3EtpcxyfAi3WhsidaR0EjRa7sj69AGdqmpB29/LJuVYzh0ljZufI6W1fY7YzP+0DTqqAAWT65E4n5UPdwMCeo4D6LFnKA75LhfSE97HXfSjbzGJurCxVkReehJOiOdvOyKH06ELFTY9Ku76XG4pGHm4qKpzDAD8MUa4m2exDLgpEKlMGeDtd5qkn551SGOcKCtmfkQLsubRnPRzweWgPlxr6P1vHlUveKb3HpwNQ8mioRNiUSm4w07U4Z7KB4sfUCzjteD2m+rQ36C5q8VbyshJkXsWa9g==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by JH0PR06MB6631.apcprd06.prod.outlook.com (2603:1096:990:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Sat, 24 Feb
 2024 12:01:34 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 12:01:32 +0000
Message-ID:
 <SEZPR06MB69592DF3646F66B3153E16E296542@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 24 Feb 2024 20:01:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] dt-bindings: net: hisilicon-femac-mdio:
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
References: <20240222-net-v4-0-eea68f93f090@outlook.com>
 <20240222-net-v4-1-eea68f93f090@outlook.com>
 <e053448f-2b58-408a-af22-d7b464c52781@linaro.org>
 <SEZPR06MB6959B0A21A1B601644E2836496562@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <eb772e32-7ecb-433a-a449-0aaae067963a@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <eb772e32-7ecb-433a-a449-0aaae067963a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [LnELuGYmV2gZNJlPEF/nrXGV6/gvDBNADdl3QshZc7+C7ynKB92BrnYgbG2Ik4WJOaYITrKvqn4=]
X-ClientProxiedBy: TYCP286CA0223.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::11) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c10404c7-9cce-4dbb-9752-ae78fdd7e435@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|JH0PR06MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e1f523-d3f4-42e5-c9e2-08dc3530577b
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6fptDIq1MKF35LdOG0vGEYFXnbkbsBMi2Qxr/u6AEP/BPil8ApDpaQ+A2JRodt4Mgdeijbx//d4YiTe/IaE6rcUFgap2LFWlHo2ODAh54Sr80fuFI/zPhhad4mVrclu9T4IzXH19tXboAKS6rIDgHBKTUL287vzqHR3w7LKuEWqAtDc1QXK2tSDYpO+T0puVj3xoNNu0iSvuI4ATIjVG+2AHif2bW/y8+l8yk1Ei/pjBUyVOiyHYj3QhDs8TESxIBpPJ5n/d053Cs7PPhgArS1Gf5dW90Ow5w0H8NTetxyaZ6Bt0ZtyFTeD2FMXYt9Nx444yCcLAWeXikGK8dJpFZ/2JRrh31mm1Q/0F77UoM3cuaQ1bDIhjTpRbMN0DOgXnUW/hp6Cqg/lWCILyOnWvw9qoE2SK0GhlWFqh3MXBEpeEi9fqWc+Z4qLi9mrhFrEJxpkQ50QKbkvGbis+MKNLpufUdC9sIQy7wfN9kz7kyFfVlzCVJQpHSXSqDnM2qsvhTlTk0NIVZzR0D5/pyMR+Hlv/6ahJGVP2Px5yJhzVXWYWG68i98qpXcCoQSZlzEd6GlswXnhhIIDdFNrO/8uDQySrY5WqF9KDg4wySIYwoGyuUGuDD/0WVtAlfNkeIw7Ga687+JFftlKVY4a0wz1NliLxGD3nhTcplytFa5cH0f44q9u9ns3Yn7BQMS717maRmhg5zMN2zp3lPcOahVPgp+zDJKL5E/rzxsucq/H0Cr108aWl1L9jkMTBktjW/51EME=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pwdVYkglQMUKqAzOHThjY3AVAut6GFhOxR2nDdck50anRayhPprw9sPDRCgIzu1ld3f7xZt/zioyIXVzTUg0IOh+tyNCvPP+3ekIW14ZBkcLfbvx2t7s3hHZ9U8NAilKJvP8nyO+F0Kb9z115i2oBVq91sWAjMSfm9TMdN5qfRndONYeYQLhwBp9mg9pkL+geBoyP/PKf8X1Tyvljub2X24E1zWPBoNJPbpetpbrd1IpDWe1wNbujTyh/0IexTKmucHncPJVuf1eQCT5p+C0khaD4olH4Ga3CykSu3IcNwV0w69l5gnFCLTI7eTSigE/29371UCKGULQJHtl2Uq+7IPrglv623TxQONlPdMGOiZvToBBEWD8jADkohryS4ChG/baoQ2TTQS+vVYiSKmbhBnC8/smEyz8eEh2Jih0L/8GI0tG3SX8Pf7LKPjLFjMHZ0xpdpQ8q5vDdhT1BDqXKTVV24gjdXVDoTiNEAnpBWOKyiaORbpu9rUkym+Vdnb6Otqd5d2WXoZBnTmrYoYHyXBD3F2uWi2IP76NtrJNjJ4YNvIeemNU3fDIH5Z8FY1+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJRQkhWK25aNU5QWDdRK1FzUXhJTmlRb2NsbnZFRVYvUDkyWlEwRW9tWE1v?=
 =?utf-8?B?OFY0RFdQNWdjaEV3U2d2YTh5OVZmZjhGZkpnK0piR0txcXBsZHlVTFo3TkR3?=
 =?utf-8?B?TXhTeThOeWp6WTB6OTFoWitiMCtCSUpoTHNSdkxpUytPdTR3N09ZbXJlaWZZ?=
 =?utf-8?B?NC9VTUFjc3EzdklTZ3hMNkdQeXRNK2xzand3dWlyNTZJZFhYVlUwTzgwQ2tw?=
 =?utf-8?B?RlRPeWdxamlQU2tpemx1eldZQk5xd3hxSkhZWnV0aUY4eE9DY0VKZ1ZrSkJi?=
 =?utf-8?B?N0t2NkhDaTg0MWJ6cGxzMlpqL3FBWUk0cTlKd0d5MThkbGpUMWtoTVJLU1Vy?=
 =?utf-8?B?eDAzRUZqME45Q0VCRHNya2NZL2h5VEkyNnFRU1pGaEM2NDdsUFpwdzljNlpL?=
 =?utf-8?B?Q2ZIU1M4Z1hyWGhldEsraVlINmFXZFA1WUpPNGZCVTdJbGQwSE1aaEJZQUdz?=
 =?utf-8?B?TVp1UU5LeDE0VUhZcFF6SHBEeS80VGFScU9oa0lUVHlDdW80RjcvdDVnUlEz?=
 =?utf-8?B?VTZKaEpZK1hZZllhZExvNURvcnp4QW1DU1Q3SnpyTlNHRGZmVDY5UzZhbGhr?=
 =?utf-8?B?SEtRcGN3TlliaFdrQzlWOU9IRTI4eVZSa0ExRmNRWlUvUC9wTGZyS0w0aGZk?=
 =?utf-8?B?S2pzVDdPM3hUZTFjbVppaFNqa0lOT2htNWFXeWlncERjcy9UUmRTOE5McEY4?=
 =?utf-8?B?QTlLS2tEWkNZSzNSY2RlNVE5QkQ5aVpnT0pkcUlaazlkaEZwYXU1UUlGYUJJ?=
 =?utf-8?B?cmduZmo0emp0WlppUWhoQ0RsMFpqZ1NFZ1huMjZ5VUVMUXJlQU0xc1Y1N3hY?=
 =?utf-8?B?UDNwaEdOQ3UzNE1DcGlHOEJjVkQzYmw1MitLOXBUNG9wQ0FmS3N3TWNGcVVF?=
 =?utf-8?B?MjBpb3lrVUVWWEQzR05LWXduVGFtMVlkM1VvWEViV1RVd3pCaWpGUk15dzlr?=
 =?utf-8?B?aUdyMHQza2M5c25VenlPb0xEZ29NeFlaaXhCVllpMkRRNlNwOHJVQjVuTVVV?=
 =?utf-8?B?bUhkUksxY05BRnBIZkRLbGVxbzh3d0Y5QlkvVEpvbUZwUzdsUDIxYWpXUDc5?=
 =?utf-8?B?dEFFSlhLY3FnSU1BRGd4VW1GVENkSSt6aXVZTzJMTmZKL2VhQU81d0pQdzdF?=
 =?utf-8?B?eWZRdTZidUlYcjRMKytsZEh6b3lmanBtbGpUd1krWWh5OGVaNGNDV1ZpNER1?=
 =?utf-8?B?M01iMCtGZFlUMm9hZVZobDlBSGFPbzVWdTQvQ3lHL2JZQ1pvNktnWnBGb0Nv?=
 =?utf-8?B?ZEtyaWZ3TzJKTmk0dWV6THNkb2pBbVh2MDI1V25EbTl4MnVaNlhpZWNzV08w?=
 =?utf-8?B?MzM0RjVPdStpbUo4eExvTEk3NG1Uak5aM2VEZ1RJOUlod3l6Z2U3Q1NZL2RS?=
 =?utf-8?B?NHBFRk11RE5OaUtaZ3AwTCtCM00wVWpYQVFDVWx0Rmh0WEdYa2N4Z0NIeC9L?=
 =?utf-8?B?UkdYRDk4QmpJNkNDQUJ4Z29mUXRueGdhV01PdVRhbC92QUxkWFl0OHcxUG5n?=
 =?utf-8?B?dkFrR1ZUWEhZSGFOQ29LMDNZMlh3WklIbVJxWUoyOUFsZ0JDVTVxNVlxQlBh?=
 =?utf-8?B?c21nazhXQ0lFcTg4RFlVMGwvQU1TbzFpNkc0SG1GTHE3M2s4SGgydlUzSFhO?=
 =?utf-8?B?b09MSWkxeWlBRmlCYWlLc2J4SktxeHZNb0V2RTJFSTVpREhaYXJoaFRtZW41?=
 =?utf-8?B?cExBRmowTEMxcWZ2dm42RDFYcUthakNweGp2Z3pGaG0wMllISzRYazltditm?=
 =?utf-8?Q?F9TYCLPmMBkCER3Ip/CqvLVplRJVpjQHPJ3cgDY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e1f523-d3f4-42e5-c9e2-08dc3530577b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 12:01:32.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6631

On 2/24/2024 6:01 PM, Krzysztof Kozlowski wrote:
> On 22/02/2024 19:19, Yang Xiwen wrote:
>> On 2/23/2024 2:14 AM, Krzysztof Kozlowski wrote:
>>> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> For some FEMAC cores, MDIO bus is integrated to the MAC controller. So
>>>> We don't have a dedicated MDIO bus clock.
>>> Hm, this means you miss compatibles for these different cores.
>>
>> So you mean adding a new compatible like
>> "hisilicon,hisi-femac-mdio-integrated" for these ones without dedicated
>> clocks?
> This is a part of a SoC, right? So compatibles should be SoC specific,
> thus I expect some hisilicon,SoC-femac-mdio.


Now i'm very sure the old binding is incorrect. I've downloaded TRM for 
Hi3516DV300. And found that it is, in fact, very similar to Hi3798MV200. 
There is no dedicated MDIO bus clock. the MDIO bus clock is always 
provided by the MAC controller. So here i can say MDIO bus is always 
integrated into the FEMAC Ethernet controller, not the SoC.


Maybe someday we can merge these two drivers together later. We don't 
need a MDIO bus node at all!


>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


