Return-Path: <linux-kernel+bounces-72060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8483085AE75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B3284DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0555E7F;
	Mon, 19 Feb 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UI4l7sN3"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2031.outbound.protection.outlook.com [40.92.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259620335;
	Mon, 19 Feb 2024 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381925; cv=fail; b=S+4K/ZRupF7j5clcckvQsftWJnVf2OtFP3dTBBRD/DOqdS9t/dqW23Jn2nBNEgz2iq5qiP2ubnSdUvuse+TMwFpnuPZROqK2akF0Rmrv6tVdFzDABhMxlAziuNIEOK3nSqkZ/Nneb1Ev+83lLfR+sKml1dyGB2cLuygeL4VkOf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381925; c=relaxed/simple;
	bh=xUsebm1ec0UtYUswG+zt5OVp6dfKzoP5MFd+T7emom0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJb7jLHLd37XKZYYmknZVnCtS4EFYcyPnc0283kSoqMDl71hq6Ea5LIQGJzMcjAibA6tSuLhPrOxOAk4bsGwthk/mddSN1nWJgwIMbyfvd1ibaoKvtm4EmJn9uaS9MOYejRNXn5GfKRek8Yrre+HHpMy3qaPAp6PrCXHrqQsA/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UI4l7sN3; arc=fail smtp.client-ip=40.92.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eulVKpdKw9oDi00xK0VscXkJbb8y00TYFOcZYqFWwBAOau4nU+s0yEHL11xxpDaHkhK682f+H2aH00fWgYaVm2URYCus27xufmAnu6MIQe2R3lYyUOQVCU/Stz/N61SXz36zD/E+XyYEdqwRniNcaeJZYZD+vfYhnjLOgoWgF045yIzOk1GmxqtiqCotjn1L/3xNg9EF6unrl27nhbe5sc+Bq0tJUZvjA5fPz2YD7Mo2YJw6G2sS9aw0rwKoc1VkXI89s3zxYH6BFiDO/3B66aTGx6BWbE9wwBArnWiU0ARWNHhmstYlDvFJP+pwNhyVXO8SbY6qk3MQ2ukAZpukeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpKl62wVKnisNKRcN0KJrKT8zc0WaNK7bdKvdebx3HI=;
 b=YX2UGvM2qFeZWVTxLL1Jlro9Eta7MPovkWI+1NwSZDwepC1KJGMMRGVxZ43VIqUwoVl+vLUNWtZTK48taFPM9x21SaY/S3xt6HYL16jSxrIi5MBcqIabaS72Ku4p11+ZFLO1Bu2NV0+Pt541+t9T1Mm0yVLHnuYEcMTevsKz5zVFAbzbc48He5Miyn4zidD7t0FQouvRGn7F1yTaMTDyiCeNm4FcfLzZwrFUj3RslGUf4iXpqCjoMawuWCScVaRTJ0BQkVq2m06AW6fPKym+CEoyQs4Qw92KnzWHuwAQVn0d/JetdVj2ZgQJYdo0fw2kNutkaDncch6ylKvl2awXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpKl62wVKnisNKRcN0KJrKT8zc0WaNK7bdKvdebx3HI=;
 b=UI4l7sN3mAYlX6FoKA50FK0YKHIr0omYXg26vSsBunFXaOXGqybEtG6cnBy8tuscqmN3isee7O7lAosTqRxQMxPQbk1juMnX/6BjK+a0PIMCQ5V7q7HUprfWoKwEP0aRDUaKim1oj5F8Av69Qk7kc6uluR6cPtFfsaBcb0ONEbDPP3eOJ0zUR+PngctDBLiKf8jG+NBnwMN/HS1sXBRq98Cn4fFc+Wyuah4u+QBpA9PpI1x1aG0+pAt4W5hQ1zP19GQorMrblGvNGyWnD/5Y3tDlM/4r8Z8O+v17NlqD6u0fmNwl18CNlSy2dzkY9zpfsv67seGHiSm5lSlcWqkJPg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5958.apcprd06.prod.outlook.com (2603:1096:101:e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 22:31:58 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 22:31:58 +0000
Message-ID:
 <SEZPR06MB695926ACA91530EB8642A30F96512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 06:31:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: hisilicon: add support for
 hisi_femac core on Hi3798MV200
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240220-net-v3-0-b68e5b75e765@outlook.com>
 <20240220-net-v3-3-b68e5b75e765@outlook.com>
 <29fc21f0-0e46-4d0f-8d4b-c4dbd1689c55@lunn.ch>
 <SEZPR06MB695901E7D4BEABE1B6F319D096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <5572f4dd-dcf2-42ec-99c8-51bf4d1f28ba@lunn.ch>
 <SEZPR06MB6959E5BDA57AF61BFAB19FC096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <0beab72d-2919-447f-88ff-fb7c92b28b61@lunn.ch>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <0beab72d-2919-447f-88ff-fb7c92b28b61@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [haGMHqRo7V5+MPHwr5ctdGFuvHeNObt4OH1ItYxDtypP28DXPdKYJc69SrMlsuF34ISbms9uC8c=]
X-ClientProxiedBy: TY2PR01CA0021.jpnprd01.prod.outlook.com
 (2603:1096:404:a::33) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <fd34e82f-8f0a-4c45-9be3-d6b1bfae152c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: e403f00d-d0cb-4d96-679d-08dc319a955c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aIXfUUPJMq6DDtBRfTz0bAkXMAbm4UG3YMCDlTJLBPDUDuQVomG/WFJde320tyt5MAY4dRK5Uhuh+cvUgM3vhgZj5d9tUxB4Z1uvEkSt4Ry6UGc+fgbj2MoUa23eZj5tQBJIkEyjZq3GLdnJmITWVQpCpEWLzfzq0qn75lTgKIGWdK1Gqs85E+it5RLdd/Dhz4MH/02U1ENrkhjKTD4ZnqWtZgTOBbfdvZnqC/pmMplXu061drV3Skwu5MAhDP5C1RYS0QfFzcKKHVZrDmcdslVysdq3uj4X7dsOkpPuER3iUwMkVW1xgCUaVy3Pm/SygNHaQJ+tUuWxzm0uT5I+KufEAiBf2sFzWzab0hcz64MnUgVES/Fof8WplpuyOKqneA7PerQo2M4RinNCWsL0COPSaBwJbpR3DSSG6q7NCzC313lPqlAerN+odtxv4t5FhfSm35RTT6Mzh+dUld0Qwrmu6r0gf0bOuv4XWSYo2MGMSwy4reUIWkv3LzguvoSPjsWeAdkimuqFGsdkMRFAF23B1sykkexzSE6ARrEGeOpfurx92l52cTTNdwGeMiJs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNNK0lPaFpid0tYUzhvbk40ZkZhb1Nhb2xJblIraWRFd3ZYb25ZU09ncXZN?=
 =?utf-8?B?SXNZK3M2bVk2d3U1eVVvVnFTSEFjSG8xQ0xKcEYyamxvR3M2cXVVUDNYcy9Q?=
 =?utf-8?B?aXY5R0lnaWprbDNVZkZwdVpLTVJvR0NuUjlnekdtemVBd2NSbEs3Rkt1VFE2?=
 =?utf-8?B?RTh5VmFmTzBldGhDTUR5RkxPMnRPY3IxWkZnSnYwTXYyaWh6Tlg5eTBNaHRM?=
 =?utf-8?B?b3lOUldwVTBLaHJsK2N3bStXUDl6b0Y1OVJHODBHVTVIVno1bldCaUFjZ2pO?=
 =?utf-8?B?WWVGUlpLN1RKVDJ2WFE4MEZ0NW1FaHVlRlIybERWSDZKOFdmZEdUT25NYmRG?=
 =?utf-8?B?VlZ4Y1hhZEIzSXgyc1R5RmcxeXpDRWswbHJzd3FhbXpybDhWU3hMd1BTcXZG?=
 =?utf-8?B?ZEtvdFh5cGd4TUI1cVgvZ0lpNFhUOTRxbmxCV0d3aWVoUnZMV2toRVoxVUpW?=
 =?utf-8?B?UHNjeUowblFFbTh2YVAyZDdHVHh1eGg1RTJQdDZCYUwzU2dGYjU5MkVjY3Nx?=
 =?utf-8?B?NUkzb054d1BPS003cnEraFhPU0pIeTNHbVVTSUpjVll1ZHM5ZStpQnhEVnIw?=
 =?utf-8?B?SlE1Mlp5SW5taU1yVkdFbUJOdEtrTmdyV253ZEZhbzlZYWxaQ1daNmVmQkxt?=
 =?utf-8?B?MnE3R1lkQi9NeGZwaDlObEtjRk1hR2lGcUhPeDA1U1QvdS9aeUVqRC9TREhu?=
 =?utf-8?B?TStGM1cwR00vM0hNTnd5UE01RnkzLzhpaGlubElUR3JxTUNtYWhtUkRuSjgv?=
 =?utf-8?B?NE9XNEdkUUN1TDlPUWUvVUEvODVMU01qSkQrbUZLSlNtVCs4NHdVbnlwZnNL?=
 =?utf-8?B?VjlaUzRwckNLZ2Vsa2VMcDV0SFMvcEY3TjZieHpqUXdPWXRURkFraUoxSW96?=
 =?utf-8?B?VERvRThBRTRtYUhxczllKzR1S3oySFNmTFB2ditCdmpxNkhhOTY2U002U1ZB?=
 =?utf-8?B?TThxcmJ0MlEyWElqWHFXR2FYUDA1aEppdWZoRmdDLzNQR3lsQndxRU5VV2dT?=
 =?utf-8?B?RnV2cm05UDNyUm51NEhRNUFHM05nNXBiUFdFdExSSmpFcjBHUUF6TFkweVhS?=
 =?utf-8?B?T2EvUUV4WDMwWTNFMnpSZDFIcHdLMStaVm16Y2Zqblo4Zmg5dGZZZXdia2R6?=
 =?utf-8?B?SEE0Q2RKdTFxWk4rSWZiYTJNeEtycldmRnBEMm5xdTRUaFRxTG1JMXk1djQr?=
 =?utf-8?B?emU2ckljV1g1aGhqdzVqMVc5VzZheUcvWk9xMzA0bXJXZnpueUhvellLV3BJ?=
 =?utf-8?B?RllnWUxaY0EzSXFRNDRKZXhJR3B0OWxCZEt2YTJxYjdzSVlMQ01pdFIyN3lu?=
 =?utf-8?B?T1dybno1MVBhN1dmcGl0dWxjb0t1OGZ1QWkvNjRmQ0Nwbk9ONXdLYm4rbTNa?=
 =?utf-8?B?RXBaaTRuYjIrK2JTY2lxLzhQaE1KSlBnNkxMZ2xrc0dSNHh4OFBNZUNrS29B?=
 =?utf-8?B?cVVKcElqcXJWeFkzMGRGQmpyaWhkTHlBdzg5VGdPMmxObEhkN1c1QmhpbVNP?=
 =?utf-8?B?L1ZNYW5VQktxNm5BczdRa2xDbXl0alNwOG9YbUZyd1RVcVJYYnlFU093ZE1u?=
 =?utf-8?B?NVZhVUVkd09UZEExUGt0eW5tYjVoWjdFL3Y5cktqZXpiQlVBK0szWkRzTi9L?=
 =?utf-8?B?L2V3cnl4ZXl2UWRvaGt1TXVuVC9oNGhyVnpUdmRheSs1KzJCdjZ3RVhRL096?=
 =?utf-8?B?d2lZNGdyUmR2NHluL3ZGUWhIUHVoL3pzMEZDRmI4SFE0ZWd4T2Z0emdmUzlJ?=
 =?utf-8?Q?raDfM/gxWKia4ev1w8nv8b4sXZJEjuOB0HLPfJ6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e403f00d-d0cb-4d96-679d-08dc319a955c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 22:31:58.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5958

On 2/20/2024 6:05 AM, Andrew Lunn wrote:
>> It's not MAC which behaves wrongly, it's the MDIO bus. If we don't follow
>> the reset procedure properly. The MDIO bus fails to respond to any
>> write/read commands. But i believe MAC controller and PHY are still working.
>> I recalled that it can still transfer network packets, though it fails to
>> read PHY registers from MDIO bus so only 10Mbps is available (And the phy id
>> read out is always 0x0, normally it's 0x20669853).
>>
>> Maybe during initialization, PHY sent some garbage to MDIO bus and killed
>> it.
> MDIO bus masters are really simple things, not much more than a shift
> register. I find it hard to believe the MDIO bus master breaks because
> of reset order. If the MDIO pins went to SoC pins, it would be simple
> to prove, a bus-pirate or similar can capture the signals and sigrok
> can decode MDIO.
>
> To me, its more likely the PHY side of the MDIO bus is broken somehow.

The MDIO pins are not accessible from outside, only PHY pins are exported.

Maybe. I've tried many different approaches before i sent this patch. 
This is almost the only simple way i can implement to make it work. The 
downstream is also not telling us why it is needed to disable MAC 
controller before PHY reset. But it is mandatory. All i can do is to 
guess, unless HiSilicon people can join this conversion and tell us why. 
So the conclusion i got from trial and error is that MAC controller MUST 
be disabled during PHY reset, no matter what the reason is. I hope we 
can have the framework providing utilities for me to resolve this (e.g. 
provide a custom callback for PHY reset, in mdio_device_reset() function).

Also it's very strange that, if the PHY is reset in a wrong order, (i.e. 
Now we can not operate MDIO bus), we have to do the PHY reset procedure 
once again, simply resetting MAC does not work. So it might also be the 
PHY which is broken (partially).

>
>     Andrew


-- 
Regards,
Yang Xiwen


