Return-Path: <linux-kernel+bounces-68251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57128577D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1D128386C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A511AACA;
	Fri, 16 Feb 2024 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HFtmRluR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2057.outbound.protection.outlook.com [40.92.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F01BDD0;
	Fri, 16 Feb 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072774; cv=fail; b=DiHDxkW4eXhtYp9jD8Pi7R7ZPPkLBNeJLEON5DoI6vbZM5PzMARnGs7o7GMA5qXw5gCW47P4eFpPQVZFBeoDXPCkgRDM/bvFXZDIOkOB5NdkV5WkPOFWH6IyrwJu8S/u9NBXwW/Pz5T/xJVGTHqj90IY2kLc43UmNRt+hZUVxgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072774; c=relaxed/simple;
	bh=d8JVWNX0ggsY6msLg3Iica0QwhgvRxHXBgj/N/+MFkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1+UJzF9BtOGHUG/QbkCEdj+lY5fvCXXVpNOyaBxC7afiDDSqg3NFjclrVp0JUND4dnAsvDMkZI8QzAk7Fpwa+tGz/A2Z6W6Ioz+yXKfx9n5eAlICWmhSTg5zc4z1cDM1L+ofjHNGs6iZio5TawH/PUmEfzhkwsFrPNh6vsNJd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HFtmRluR; arc=fail smtp.client-ip=40.92.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwAl3i5XRs6EOP9fuBRYblgDE8WzQ21g2nI9O+R361jZ+z2RGFEs7NNK4OcgUoxN8Gq7imZmhIdvOFRi21X6drsyCwTSYERxFgjP+vN8Jl7/n+LCSvC94vIomZjTXg/NPeBTBwmZ//Dwc3u9SB31XE7f347W3wBseC6FIPVw1yKzCFF9rAVgYK8+s74X9ovNLshMVYs2ZUU6UE132bG1MH9nlHMo4XYiUSyiTANvtNn7VaCPuc+IGS2mTooKrG1mRK77I0IZkmwhDXQQWJMjUiGlCePVCUnIyszZrqYA1uH4whLPA7qLR7oghKPXnOOdRxR+VHLDHkvsCJrUSugo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJG8XHS6OmFsv0RjzV4LyVJrVHZrj+PlftQRijh0jSc=;
 b=h8v5CremqV4aYDyT2PAzpExUxbXQFDcdp8cOz81FO8vUdyOIqcW0ePlqJPRHmj2kpfRnu6ZKFkO8nCTF9yNoLjL7SW6cU2Lj/Uslso19BVqLU/wpZmiub9Uzm2Uz3W8+0acyEUeBBpcohMZPhXKPbY8/o03GIXmKTasxTu6OqMPwWj3dELHwHjv5ziwXcLKFnv3FSSe4Tauf0HaztB/dxQc6JbDHs27WBd0k7roUDcBI7uSQez2v3PAjbZ3zmuYzXwHOLuG9KkcEwgG+BGNpVIfPp706GzrpVIMHkm97lkKOdVCZ54llHAh3MMO6Y4xdMmP//+jHZIOsLbJIhjVtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJG8XHS6OmFsv0RjzV4LyVJrVHZrj+PlftQRijh0jSc=;
 b=HFtmRluRFRulcu7v9YLK7yuNWMJoxlr5vEeU3WqK2UZ9wf509qBOXYgtNJ3LW3dLZadPo5i9ygOnaKxdO56z04m+ifEn8ilwfSn/73z1zbmQFHVQ7vlNguXWFSx0nUrkDz8uwKlbw/wufIooPUPn2F2gPSwwyO6pbOV3Euy6Gt/E6h6ub9921iWzzOxPRvCtM2HSYYM7dz0SCOr4KMdhKFBhIDKKppDuhIPjE6QJToWVw+8glw8SOvS8d0jS3fQ+osgaTd/G9obsETi0C0sYoFrYxqd0I4Yv+mbhFVhf0MovI+UEiRmjiQUDMQ0TAWnN2qibmim/VxSrnOMz3Io3WQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6441.apcprd06.prod.outlook.com (2603:1096:400:482::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 08:39:27 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 08:39:27 +0000
Message-ID:
 <SEZPR06MB6959592677F8F2C79BC2FBB7964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 16:39:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] net: hisi_femac: remove unused compatible strings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Yang Xiwen <forbidden405@foxmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-2-e0ad972cda99@outlook.com>
 <68c9477a-3940-4024-8c86-aa6106e8a210@linaro.org>
 <SEZPR06MB695938B228E762B9B53BAF2F964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <d77faffc-5bde-41f1-b6a2-ddd665c3ee08@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <d77faffc-5bde-41f1-b6a2-ddd665c3ee08@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [aguYaheUdooiePObLZYS+j+UBB328r4eaULICheFwojzgSqjP0r6rrcc4DzwIpyfyn60rSr5HpA=]
X-ClientProxiedBy: TYCPR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::7) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <edc6a7b6-a52d-4ec1-ba90-31dc1f8d6023@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7cbe2a-6942-4750-a8b5-08dc2ecac8ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CDEfKGcTINjIobgrQuHgCxzOE44wChpdLrQagt8fqSy60QPyrkh2FgGsVhByXZupZaNhmp9hMbg04i+JEtkfz5MBw+MvF5P610/FMGvwJYrf5JWRx1XtwT2xpvqdX47pweR7/nZuQsV3+wUMNz4d5FHma/J32EwzfOBrXv5RkMA0sY0L+GxokHdQEaFMNAd0nRlqXhRfglZiWVInNbb/RgbxVtwK5JaLvF9rmlzUM21e8e4MZgEQkeDLurXqvHwPd/Rq/ikKEMHjytIdD+B7ykPO4e3o3Vk7yZ5KtzYIKAxxviqQb8tEq7u06BJhv97r8b1NC8k/VKZKaoIOlaTQ7fmi9Filw/+nRu60O9ZMkgWmFPeUkVFLdhPRjbC3zroGg5jNMR4qrJrIs0xyGnUu7W/D1pE342wt6Uj+IstGS/mqcahidVVu8MiDU+QvjdsAsrPjXpEDm+2tTBZfBs04VwUoSFt2NVhQ/JhgPD18A0n0CThDOp6rBvm8yyg8HF8emtmuuZB58DWq5k0jqYWCswJPXqu15jGgTjVBotGoNMwHU+0CKby5lNgZOt2rk3BE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNXeCsrR2J2VUU1ZzJrZkZwZE9Eck1JT2FVUTB6VjNiUEgzRjZzUnRadTFw?=
 =?utf-8?B?dENKcXJWZWoyNW85NU5OY3p1MURnOG1Va2w5ME1xa0w2UGwxL1AyT0crdWh1?=
 =?utf-8?B?ZnVMNnJWVG02WE9tL3Iwdzhkb1FocUpvQUtNdVZ0TlpMT1ZDUHpBQXNhVkNB?=
 =?utf-8?B?MmxlM2FudVpTZkk3R3BLbWJ1VVFMbDFYL3JwbSs0azhQMDNMTVFrTnc1bjVy?=
 =?utf-8?B?U2o3MHY2VHdCRWhEMFRjVVJuYlZxNXpheERPckxaMXlhQkprZHU5anJuWUtv?=
 =?utf-8?B?VW83cWtQWHlwbU9FTTZzbUFsTU1wY0lSVUFhOG5uZ0RCemw0bXh3U3d1eU1G?=
 =?utf-8?B?Vnp5VC8waGJnMjhTbzFXUVJMV0lMU3FVOGdwZk5rbGh6L0N6TDhFZHg5VVB2?=
 =?utf-8?B?ZExwQlRUV3oyKzgvNnNBa29TTHBQS3pRZ3JUL1M5djdkQ1kwZ2RRa2NBQm9I?=
 =?utf-8?B?dmU0V3BVMGZnTXFscmRBaXBPelRWT2dNYmRmK1lVRXVSTDFwb3Fsc1NXVktu?=
 =?utf-8?B?dW11a2lmbkJCbHhtR3VZOHE2K051TGFzVEIrN1JEN25LMStYQ3c2RFZBMkVC?=
 =?utf-8?B?dEhCbGVtYVVQelc3R2h0cmtoSnZOaWVTbnc5MWJVTkRXSWZTT2VyK3NUdVJj?=
 =?utf-8?B?YWd6Zzd6YktXbFZEbDBGdUhzaHREK0JyckZMR1M5UjZ1MTF3M3AzZEFPQkpU?=
 =?utf-8?B?YmZET29mLy9XZkZGMHh0czk4SzVmWitxdmhUTFRVS2JLOU5HVHdGTklQOXBF?=
 =?utf-8?B?NU0vUGd6S01KU2dHWHV4Y3R1ZTBVSTZKdDNOellWTUhEVnpHNWt6RWtYOTRr?=
 =?utf-8?B?MkYraHM2eURhR3k2ODUyUjNQT1doYVoxWWFGbmF5amp2VHN3MlNvWEM0LzdJ?=
 =?utf-8?B?YUw1R080RjEwTWErZk1TYzZaQ1ZIeXFkcXQyS2Q2S0JwS2UrUkc0V29HSUNw?=
 =?utf-8?B?ZVMzQWFRNWFHdXV1ZUtBeG9aaVN6Q1NkSkhWeW5iWHRiKzJvZ25Na0NrOG1L?=
 =?utf-8?B?ZDh6Y2kyNU1GbFViOGQvTEFmbjJlZi83UTh3WUVwUGJZRFZBNVQydHhiNlBp?=
 =?utf-8?B?WWcwd2pLbVVteTZydmFYYkJtT3FtQ203Zlg4UFVDaEhmalFreG4yTGFqSm8y?=
 =?utf-8?B?L3ZVMnFLU0pMQzk0SnM0Vk54eDMxSU44aHB1Y09ralRXL2dJZU1KdStFazBP?=
 =?utf-8?B?eVRHWUVTcVdTOVgwekxPaEFHRExvcEg2VUtNelZ6Tzh2WW82NThLSHBjQWlL?=
 =?utf-8?B?TnBEaDdjOGVzTlgzcFNNUThyTG1qSncyUWpDMlBsNmpXNVBVcnVKNCtaUjg5?=
 =?utf-8?B?ekNwNzVYMGt5YTUzV3BXM2JuWFpDUzhleW5JcDA1K3dTYlBrdTE2OTF4OFpz?=
 =?utf-8?B?bG9VZjk0ZENQTldZcS8zdWF0eFVCemlrSThVWGovMFJXUGJ1VWVXajhuUVVy?=
 =?utf-8?B?Vkd0U1FJUEp1WWlXQ3g5Tm5GOS84MVd1NU80UHp3VFNBWmJZdFJ6cnAyWE9U?=
 =?utf-8?B?SXlsQ0NnaXYweWx6NlJ3aEdlMmk4aFdJOWNrbHd1bTIvQzZXV0FmRVcxWmwx?=
 =?utf-8?B?M0E1bHdObWY4UU9QaTQ0ZFlDdWNNLzVMRzRUVTR2Wkh1VGwrOXVzVFlZNzNj?=
 =?utf-8?B?MlhEamhsaVBNR2w4aHRLalcwVyt3Q28ydW95c25za2Z3WjNXQnpEZFRhNk9U?=
 =?utf-8?B?S2oraDV3dGJhazJmZFdReU5GVWVTNkdHSjVjSU1xSDVFR3RmSW5wN1lycEgv?=
 =?utf-8?Q?pRbo/C1h4lPio6WLLFovyYU9MzAOhNZGZ8TvVKi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7cbe2a-6942-4750-a8b5-08dc2ecac8ce
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:39:26.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6441

On 2/16/2024 4:26 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 09:21, Yang Xiwen wrote:
>> On 2/16/2024 3:20 PM, Krzysztof Kozlowski wrote:
>>> On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> These compatible strings are not found in any mainline dts, remove them.
>>> That's not a real reason. What about all other users?
>> The people who want their devices being supported should post a working
>> dts first. Having found the dts missing is strongly telling me that this
> Considering how poor HiSilicon contributions were - in numbers and
> quality - that's kind of expected. :(
>
>
>> SoC(Hi3516) is orphan and EOL already. I can't even find it in git
>> commit logs. I'll argue that the old binding is simply wrong, and does
>> not describe the hardware properly. Who knows? Could anyone tell me if
>> the driver is still working for Hi3516 or not? I'm very willing to keep
>> the backward compatibility if someone can tell me the effort i paid to
>> maintain the old binding really makes sense. But the only things i found
>> in mainline kernel about Hi3516 is an CRG(clock) driver and this femac
>> driver. And it's been 8 years since last update for this SoC.
> OK, that's fine with me, but please add parts of this explanation to the
> commit msg (SoC is EOL, driver looks buggy and might not even work,
> platform was upstreamed 8 years ago and no maintenance work happened on
> it, thus it looks abandoned etc.).

For me, it's a bit lucky to find a (partially) working driver in 
mainline. It'll take me even more time if no mainline driver is 
available. In fact, i wrote the driver for mainline u-boot from scratch 
and it has been merged. So it's good to have this binding accepted 
unmodified, or i'll have to modify u-boot side driver code to keep them 
sync.

>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


