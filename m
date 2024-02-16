Return-Path: <linux-kernel+bounces-68211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5285774F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18B8B215BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358851CD24;
	Fri, 16 Feb 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rV87rYkC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2022.outbound.protection.outlook.com [40.92.107.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466591CD0B;
	Fri, 16 Feb 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070594; cv=fail; b=cmcJ1qiYJ+/VrNG/Hw+vUpFdUTpHPkeOWDgXypVPMv1ip0etbPYbQ1MIS3bMsejQzO+8mlmnaGSAMQNGcQ2/req+p3MQghTv0FQckVpC0bqOy1qEIJ9QCFLBhufjVkKB59EmQoy3u11/t+3UND8ipjkYJbsl0ZZC3pmyZhoiDRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070594; c=relaxed/simple;
	bh=vGMYYhcJfxqSwv1fxv3Ynp4ubt4dWHJsxQfNwOzrMYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G1254s6cXml2gb+TcLjVN+6L1CS2YDtb0ZRRjsBYhfISYTu3a7zbUZMoRFSwsLPx4sLrGTIA2XcRhz8kv32e7e4WLW3NVkHJqkddT0MrTUDoycA2vOtQEt3rvJuD0/9/t0Gqy0CYrluswkWGe7a5azTKJfstkE3BDzAQtLjT4Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rV87rYkC; arc=fail smtp.client-ip=40.92.107.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN6110ZaNW5lU7XuzAWaHFaGUI6z/U+H1jtGBVlBDjDcKvHWRuQxTIHVBPzXBibo7zvZ1X7AGaJkngNoYlN4ZWi9drj8Z2nwq+GHagv6YeEwOKAGNEbpXM1Kt/ujH38y3XKaee3/Nx/8/98LzSwlgEuc2GELyWa1sVdxtWncWUgk5mT1YxjOwVRPx+h+oCjYK2fWt87nWPlXwWETwTCjzp8Xw7MA9IG2atkKMekna+8jvwEl58kKqBIbE+uyoqU0js9ogZJTfj/Q5TdOk0SMG4Bi/PvRxg7OsHJ2feErWqZ3mYLLYL0gt77oiyruJ9KyoBI2J7Zv6Qhc+W04WJLXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j96xoxWxxG9BSsoTXyOHJjZm8ZyVGqnxn4Jmvj/Df94=;
 b=M9cxTb/dCtdUdMHFldUKptVsNO4Inht1RLj7iHob41h2SGhdqx7fYlnqVNukHyLEVUoN2p0jS9NLyf3ohXQJfXO8t6+M8dv1hp78vtHYHL7dsRLYoEnVO1QTPAVxice5H2yCuHyGB+ZbWSivJxQKxGOqnU+S3ubbOMaQ/dJNuW0DnJdtB4xNtls7SpZydR+aaI4T8hGAdboGSZZ+4b5r+VMALrq6FnE2MgoXO2vQslYL10mEPY5HxeDOo3lhL11v/Ny6jcsUpQ/Eyi9zsZPNfr3aL5StKqslo0QOyDinZCWUisExcz3VdrVAP3Xbpv7Hybtt9LpALJe/n2mVbY5IBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j96xoxWxxG9BSsoTXyOHJjZm8ZyVGqnxn4Jmvj/Df94=;
 b=rV87rYkCKDnl3QBfm8gK5RxKfuRg5YYY/ZFYv7IzxO7Dz7ML3zFEhfnLRw1FygZRccBFAuQ3gWECFfIgG1LVfxeAUh25oz56kATG7j3jsSkoiOVb/pZULaay1RKjV9CXbUp83VAqbY9AMflzwFKLpHKiOpfM6Bn9YghSGGtSFaZh9+DfPdXvRO/2vWudxumqyeVA5iRrjNt2WYlFBa9xlShhytSDNQVXqPZ/EEJiCGqoxmse1v9MUjJ869thaEoDYjnlgbEmMQoJyi/qTKODmA3DvWofdjjt0oOPq7bXj+Q6FFoVUcZZFKjjyv0dRbijmc1zyGUQ2ljBNv8AeelmOg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PSAPR06MB4360.apcprd06.prod.outlook.com (2603:1096:301:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 08:03:07 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 08:03:07 +0000
Message-ID:
 <SEZPR06MB69597BA5B7F02E0B9995131A964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 16:03:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: net: remove outdated hisilicon-femac
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
 <20240216-net-v1-3-e0ad972cda99@outlook.com>
 <86a4d31d-80e4-4c11-9c71-e14494e3c8f2@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <86a4d31d-80e4-4c11-9c71-e14494e3c8f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [5Oc4VLRNK/o4xC69BubHq9wb4dS+Q7TT0qDCgYpUnlQ+FCj4KEOQDvV41MHh7zCZaXf+WHCroiQ=]
X-ClientProxiedBy: PS1PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::22) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <55fe101f-2ee0-4b7c-949b-7646fce48b34@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PSAPR06MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6894770f-05c9-4782-55cf-08dc2ec5b566
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e6hhyOCYNqN3pNEAQ1GCmM5Jk2mwFLBMhmKNvan0goJuektKCBa1bYMvioYCkLWqdRO4vDkYy4G6gURsZTHrLA9qLz4ns6kRrlUCn1boBaAnvSjQZcc438P8eMi07K4Tu/OxfpJCyNlUzrLqnoG3SOirk54IjHtKqs0FL5qmeJX/JgHUwZJowB/E5TeosYtVnQzbQSYE7O2Id26jtY/ZpBznfgK/dviL/iXKJr7JirlZjoSgyOblI935ZtoGQCIBFZCMBa6qmWIgeiOVywEXceNJSoxRT6zlQoWWac4FhKhByQPEyRtEL9uaV+7R1PvFBzVP7gWzKcWh/lbW9uSvP5PmRX8t5LS97H0CA5TAXHclhUh/PMrCqntm2DKzNMeK/OXkPlijJhJIvU6cEDjlLLfcILNqOP72ROC1FkxIi3olQg5tYEkmVeQR8bmO0/uB5N7kmhaljWi31gU9i9F+RAiAHB/ciFzbgkeayVGdLn+LK4BqnMVDDj46RsylSEIrbEUD0CiIMjzJ9RfMoE2DXFjPl2M2sM4AVKUEaJ8tVZPr4PTZzITf6Kxza3Na8Zz3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anN4OElCbFdZamVnTTlRN0ZTVG5uWjAxMzFSM2ZNUG1XQzJnTlpIUDU4Tndt?=
 =?utf-8?B?bzhMdlpucHYzUDV6RDgxOWxreVVXUWpmUXMrckt2VFA2ZmpoK0FwM1BVd1ps?=
 =?utf-8?B?bFNXYk5mQ0gzWXpYV3hxaFVtMnByNyt3eVpUcUk4UzdZdDBPMlRXNzBGMnJV?=
 =?utf-8?B?ODR3VVpra0VuUEVJSDhlUVBWOVpsVWtwUElndzlweVFNL2lsQ01iVDJZVGxk?=
 =?utf-8?B?cUY3alU4a1FPeW9QV2hZd2laNmZZSm81REluVW5Md2tja0NNY2VMb2huRll4?=
 =?utf-8?B?RXFUZmhWYTJ2QVZSaUFVVm1MdUl1Q2N6RCthZVZCTjdBVlVPcGVmcjNVN2Fr?=
 =?utf-8?B?RW4rK3BTTnYwZkFkSDc1VUp1MFRUaWZSTzYwWmNUbW5EREdsem1BWUpmYTZk?=
 =?utf-8?B?SmdGQTNicnViRFE1TU44Y1hWcHE3MUFqSC9hS1U1L09tMHhOcDVDcG1xcmE0?=
 =?utf-8?B?dXlJY0x3T3ViMTE3K1hDakV5bEhEVG93MGtjN0ExTm9FTU82c0w1TjBmcUdC?=
 =?utf-8?B?S3JHZ20yNk1PeDlCcm5YQTZrVm9ockdwU0crM1ZzRkxMc0pFY3ZRblBUd3Fv?=
 =?utf-8?B?STYxVTBBSjB4UUJleG9HZXo0Q2IrSXdlUFNSOGNHRHJuYys2SS9BRE54cjRh?=
 =?utf-8?B?QjJpcnBZSUxZSHRuNGFiaXJGUXdsc0liVEcvOVF6QmtCL1RYdDJhMlRBSThX?=
 =?utf-8?B?bnJTcHlxSWVwZnExK3Z3Q2RxMkFOdzZFK0sraG5ZU3RDaFRlQUFlK2M4WDds?=
 =?utf-8?B?amZ3WkdmWEpjSmpSWmVodEExV1laZjdkakNWRVVSQlBWMFJ1MUV3c0pwSk4r?=
 =?utf-8?B?YlhYd1JYRkVLUFNsdUw3K2RqUWd3b2gxeDNEdzhEbUJhclNDTFRDb2txSzJW?=
 =?utf-8?B?SWhvMTRhYnIzWkFpeWp0bkhsQk4yQlZoTzROTjVUN1B5MkxwUGtEdE5ia3Bl?=
 =?utf-8?B?ZkNBdVBCZE51OUVidVRqRUljREsyTEFZcm9tZTFTZlVxTDBvK2RIZWRLMUhv?=
 =?utf-8?B?b3BvWWV4UkVDY2hjdlpObG9YNVdKS3ZVZkNWaFFNQU8ySHZGOVhheVR3VFlC?=
 =?utf-8?B?dmFKc1lVM0lhbVZGVzFLMThJbzZORHVtVXl3b3p3amJ3OWgrZzIzUkNTeXhy?=
 =?utf-8?B?a0w5cGdlSmdYbkZtOFBiNFA4dDVCTUk2ampZaVJ4YTA2dStva1poQ0ZpaUh3?=
 =?utf-8?B?bVRHNlQwV1dJRklXUklYc2xjNnBqcU9TYkVwOXpGN2J3NFY0dFVvbVZQNzZo?=
 =?utf-8?B?S1RpVE1yRzJ3a0ZOeVo3Umw5ZTVaRCszZVFlNkZLR1pRWk9uVUtHUkVNd1g5?=
 =?utf-8?B?cEdVUW9oV1pwTjYxNnZndER4aHZZZC83VDNGZWNSTHQ3TW1LaFJldyt4Wm9E?=
 =?utf-8?B?bHh1bkV3WkNxWWo3ZzBKdk04djJYUEZvd1BwbWl3RTdlaXFXNXJtMWdadGk3?=
 =?utf-8?B?VG11M1BXRXRlei9hQjRDWWRRZHRvSUo5UlZpSXFlOEpmUTFVdUdETHhLL2xH?=
 =?utf-8?B?bFdaZDJzN1pocU9aU0JZcEpvTitiUWdaZ2k3bHloT1J3dzArcXlFeFpYdjFZ?=
 =?utf-8?B?YWZiK1R1S29TTVZ3d0c3eG1sT25wT2p3b2pOaWFHTDlYZTBSWWZZUCtyaUtF?=
 =?utf-8?B?QUFVWG40WWR5RW1LNnc4UlBHdnJYSDRGSWFwR3RQd0oxUjQ5RUJXL204czdV?=
 =?utf-8?B?Z0phMkFUT2pQc3hwNW1aMUtJNUN4dVoxWGZtbFpNVnlKWHpDSmt3OVp6cG5w?=
 =?utf-8?Q?QICTBLzUmLllCiq08ZdYNZhhihb0fs1fPjzuB3x?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6894770f-05c9-4782-55cf-08dc2ec5b566
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:03:06.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4360

On 2/16/2024 3:21 PM, Krzysztof Kozlowski wrote:
> On 16/02/2024 00:48, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The user documented(Hi3516) is not found in current kernel anymore.
>> Remove this binding entirely due to recent driver changes.
> Hardware does not change because you decided to re-implement driver.

The only hardware i have is the hi3798mv200. According to downstream 
driver name, this is supposed to be a hisi-femac-v3 actually. I don't 
know much about Hi3516, but it confuses me a lot. According to the 
device tree node example in the text binding file, the MDIO bus is 
supposed to be inside the femac core (femac core is at 0x0-0x1000 & 
0x1100-0x1300 and mdio bus is at 0x1100-0x1120). So i think it's highly 
possible they are the same hardware. But according to the TRM and my 
tests, there are 3 clocks in total for femac core in hi3798mv200, one 
for mac ctrl, one for ahb bus(I'm sure this "bus" clock is not MDIO bus 
clock), and one for phy, which is very similar to the hisi-gmac driver.

Which complicates things a lot is the complex clock enabling timing 
requirements here. at least for hi3798mv200(and all SoCs with 
hisi-femac-v3 core i think according to the downstream kernel source), 
It must strictly follow the sequence in hisi_femac_phy_reset() (disable 
MAC clk and BUS clk first before asserting PHY reset), or the PHY would 
fail to work. So as said in previous reply, the simplest way is to do 
all resets and clocks management in the MAC driver, or else it'll be 
very hard to implement. I can't find an easy way to "tell" a driver to 
kindly disable its clocks remotely.

>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


