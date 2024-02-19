Return-Path: <linux-kernel+bounces-71994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41D85AD99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BC81C21A71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA353E30;
	Mon, 19 Feb 2024 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SVmlgPhx"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2080.outbound.protection.outlook.com [40.92.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D1537F6;
	Mon, 19 Feb 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377567; cv=fail; b=hQaerfmH5EYrN5gJjZjkOkMQx5AScwvpVlFf2k2Nxj2OTKmDhQwyolEVJiUq2U5zAEJIUgjfqlHQlwUBqXrMHnMiOmIsgL87ViZuyvmd9mxXiedmjjAjf748Y9LF5BIuTsVNDVtt3pc77L1fwliyKwgpQpHLxEqjX4CBbMbtpK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377567; c=relaxed/simple;
	bh=kco784bwmc5IeJopfoeBo5L63hFZqY6r1OCM8F7x8nI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k2zfTe/KeKNU57eVov4HOsooN5oiLdi/0JEWuV3SxBp9nI4FcSyfaPzuWuDgGL/QRQO/jgdJ6rnYiHWX+jM3IUh6JyBkqawmTyyXdu3r+qc4pkrJ0V+73tXqGo10tG4yU7Oo9+9PcStfw56rb+5dddzmeCLHIr2j7QMP1B6ikoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SVmlgPhx; arc=fail smtp.client-ip=40.92.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq8DDHYg4aZVVxKtISkbC9gpOs4BPXzWRkNNd+gKcTfske5/HUBQnBmemDJcofi1hoAaN8fAExjfcdGmSR3dKutheh2qPkxSpe4FAgyNQcLAW0/SZAPzzBcDYLHBSOgfKQLAwduA4UKuHr5mkYge/YK1BS3uwzCU+fnpzXC9KgByGcPmWCwg7jlUqhyWGuirStA9NvQKYd5v//lvyasA/TNmTt0Yinr4M02ZUZnBDxP8yeyRY/gqH84qOsXuLw/7FKCNw9UwMu+4OeO31XRYoTcOQRup6cTfQysBde4hi8V+C1X+97dlWTengrdCb3sh+MGRC4/Lp3ou8bBIwvBAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sT8j9X9QzdeXjh3yfdzJjkS1zIrRfvqxO4fRirQjDc=;
 b=bgrP0i5ckb5romT+dsBEumjWMVSIxnz3mM+DbUojqBvvzGeIKiDW005rxKkIzFETGwWzsWjKuqX5DULkB2eyb1wv0IiTKpqjOBwpNAWJf4MBcLvgrauij1Y44u0xMZLhMdMezcvYQaR6f0Ejpb91dUYSs9GWkxTzVQ/Lbq8ydrcm2DcHfh9wiIYkELZ6pSm+DBAHW0AbHrvv+MoiCBuRc9wh4amCXD1o49XUUJDx24VmoJd78zvBfs/Rdjpvbe2O53tX6k/ZB6BqWYtzr4671dODzipUQx6Wmu6uWiFTma1QmS0+Z9FcNiMpn88OjbZsX+aaOSIRl0AkmldaHUgT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sT8j9X9QzdeXjh3yfdzJjkS1zIrRfvqxO4fRirQjDc=;
 b=SVmlgPhxnlC9VvmNfVzBjOsXE7j0Xz8BgjH3VQ9w9+zLfvqbG+e0PKa+FbB+Y7/uYQRS1IQ5n6OIj9J1uVLaPsL4l9MxDksxD+pdnZmao6tDBT9Kwx4jA/A6CJt3cPkLon8zSM2XhQb7QoXzAr5So/yRQEhVEkGdwL1GfTcGN2d0xBFXBQ05UZM8Og7edNN0PVYKhTwZiBMaNqMR+mRkfgZXgMBH00fhuoo7bzH/tw/EtDx3P9naysc6XTDuuZJ27KtbJb5B6q9tus32LGvDaZAzCHVH2RJbYhotiaQ7Vb30pBrCpOXmAZe3TB613irEeGiWwlOL66qKWRVtmKgHLA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by JH0PR06MB6478.apcprd06.prod.outlook.com (2603:1096:990:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 21:19:18 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 21:19:18 +0000
Message-ID:
 <SEZPR06MB6959E5BDA57AF61BFAB19FC096512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 05:19:12 +0800
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
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <5572f4dd-dcf2-42ec-99c8-51bf4d1f28ba@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [CXaB7BYLAZOaw1zf/KE9djStwrsROBC8JBvU6JhTwlOrNu9h94YDbReGLIZhspA1W1mB1EtFya4=]
X-ClientProxiedBy: TYXPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:403:a::31) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <0c2b947d-4683-4435-8000-09f26d1b1354@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|JH0PR06MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 503d6f0d-1500-4bea-aa7b-08dc31906e48
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lsb103ixgmtnI53jpYq3JasPdpKr39qzUOXXHPuxwvuP4Gaho+pBblWMyuAK7cIyQqCtQgMOvmLRsx8/e7QYnTm+hivDHNLqLFy4kSg2tujfH4ydDLaUORKYf0/KK9CuXHDXe8977FCiYj6QcxFqOeMFfJLuko15FkMGDJO/HVGXkSrcqu3My8I/p8Qp9VEADlhTcJVQ8+aRDgAmeI8h4vfCzTZRKZz6CeBxIrc4uVO1eFH8dRjXV7nSgSJMZzvaAa/NxS+vL0A/rRzkBUba5jZseC5jJYsjhkIT7y2IhnaHA/wKOrZKi/RLCOWoj1wjBcEX+uH42pHkuQDA2F0+Q3SGUAiX36WKOVw55q/RwMWxrtOukVIfMpek2bOIzdMLRad2hwWUaDLw9Ci5yXYilWL10f66R0WX8h/HmvCsIGIUYiZF3+EWcEvLATbOtnrU43ywtIbHTmqcWHArn3TzIyJHbg6bOkGLb6j+cYU8QCkl1VyWS+OEC4CPZp9UFn4Gq/C6JGO6C2V8MmDDT032g2sK3p9jo2MAvS9q/drbcVKto0gUFoz8b/c1P388llD/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGxjZS9zVzd2SVgrNDRIaTI3YmhmRWFUeXRWU0Y4WmYwTUVGYmhKVUFiTi9p?=
 =?utf-8?B?OG8zTTB4WW9mNmhrVk9ZSStZUXc1YjA2UjBPanp0cm9kVldGY0szaWo2Zkh4?=
 =?utf-8?B?TWlmaU5YK1Z1OHY5RVdjTnlVbXM5WkJqQjBXeWNjcHZNLzE3UWhOdGtDeWhi?=
 =?utf-8?B?WTZzTjM5QUVVS0JBampsUndVWjd1K2VEUzZPclVqVndNTmcvYjJDTnFTenRs?=
 =?utf-8?B?a1ExZTdacnp0enFnRGN2WWt2YXBTd0E2Q2NOUnBxS1lZNUhLRWZ5Z2RPMGFH?=
 =?utf-8?B?Yi9nM1RhVDZTQnpuWG1CL1cvbFhaUzVYNzhJakhiaWQwcGcwd0xhZ2dSWHp5?=
 =?utf-8?B?b3h6QVVmeThyejBRUFdmWkVBNlVGN0Fyd1o1THJNMmJxYk4xTFMxRmVsa3Bs?=
 =?utf-8?B?TEVtWFRjVTg5Qk16YVFWV0ZiK3lncGQzckJLTkYzSmI2aXFSSk9haTM1ZmJ1?=
 =?utf-8?B?aCtjTmVQYlpBRFJxYmNKdFVqTjNsNDcvM2VCTVRIdXR0UTlSMjQrUDYyckRp?=
 =?utf-8?B?Q29qaklMVE4xeHJBZjJiWGI3dzBNcG9sUHlVSCtMM002eUN6OEFSQnNhL3BK?=
 =?utf-8?B?TkRDbFNtSzl3QWl5S2R0U0xieDdRcTJBRlhpTzFEV1Z5M29GNHRkZWlPejY0?=
 =?utf-8?B?MEkvT0U4TjRhbUxMK1phVFp2NGJFSFNZYVRNSFRiZDdUaHJ2NGhZY1BwMkhu?=
 =?utf-8?B?Z0wyWTlYQmhXYjdnRzAyd3ZSVDMvRXorU3lYQXZMNXlOeXFoMm5NWnAvOElG?=
 =?utf-8?B?WUUrWkQ4ckJGdTgwdjNSeVR6ZmNUWFJDQWFWK3JoeU1MaW8xaWpGdEJJcWhy?=
 =?utf-8?B?dmdEblU3Z0hhNW5zMEhMekliazcyMEZ1NW83aWE0M2FKcUthTnJ1VHVTSjVM?=
 =?utf-8?B?RHY3elJOalVXQ0ZZbFZPaTlScWRYckt5QVpPTGRLWGVLdFZSSjlXNDhrOGlN?=
 =?utf-8?B?RVFjUG9KLzVaczVxNmpEd2NSaEtOSno0b2hZaTBtQzVtTHpYeUJqdWx5bytK?=
 =?utf-8?B?SVRtbWdCcEM5L29Bby8yZnpEdU5EWm9qSXRGbEdOWCtMS1F0R2FEVzA4VlRY?=
 =?utf-8?B?RnZEdWtmMTBqcTJrVkpKOUNORUtUVXIyVE9FRm9GMVlJVTlTK2Z1RjRlTXFQ?=
 =?utf-8?B?djJJYzJ4NkFMSVEyRVQ1TzFOcGtZVVE3RDNIQnUzdWgwQzZCQTQ1WFBFVGU0?=
 =?utf-8?B?d3dHWThkektJbGFkWWJKdytXTnVwcUk5ekl6K0NTeW1LcXV4RWRqYjJqbWR1?=
 =?utf-8?B?TFpKd2xJb0RvUkV0QUpLMTdXU2hnUTkvUFFnZ2ZmTENQYlYvc1VQYzVNNE0r?=
 =?utf-8?B?U3JnalZnaE1LeGQ5eFVrVTdVT1ZTL2RxZEphdGJ3N1dqN0tCdFg3b2EwS2lq?=
 =?utf-8?B?QURYSjg2MnFTbjdpbERBY1VzS0pQVmV0YmdiWkFDQ0RPa29STW9TTVUycDhR?=
 =?utf-8?B?U1psU2dvaDFwN3pWYVdlT0dDQzArc2d2enRtSnEwWUI0dU9EMkJEWEt3V2Zu?=
 =?utf-8?B?ZklPVlZhdzVUWHFKb3NrV1VsMXRTQ1BJVHlpQW0xclhOQVZCcHRwZmhhT2U0?=
 =?utf-8?B?UDc2UzBMM0NlK21neXlmOWJaSDdvUUVOUlFad2NCL00xZyt4ZHhieUJLNWNx?=
 =?utf-8?B?RWNZT3lqSnRIdzU1MUFhQnpuYnIrcUQrTkhZbDc3V1kvYnhmR3pLaE1sZktj?=
 =?utf-8?B?YnpDNC9LQkR0QUpheU8ycTN6R2Z1Z3pwUy9JbFNBTXI1dDgzVlJzdjh4Y012?=
 =?utf-8?Q?PsgUZbtKt51iKkEvrC4e6KI+0TRLaxun3lG+4rC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503d6f0d-1500-4bea-aa7b-08dc31906e48
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 21:19:17.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6478

On 2/20/2024 5:05 AM, Andrew Lunn wrote:
> On Tue, Feb 20, 2024 at 04:14:36AM +0800, Yang Xiwen wrote:
>> On 2/20/2024 4:03 AM, Andrew Lunn wrote:
>>>> Note it's unable to put the MDIO bus node outside of MAC controller
>>>> (i.e. at the same level in the parent bus node). Because we need to
>>>> control all clocks and resets in FEMAC driver due to the phy reset
>>>> procedure. So the clocks can't be assigned to MDIO bus device, which is
>>>> an essential resource for the MDIO bus to work.
>>> What PHY driver is being used? If there a specific PHY driver for this
>>> hardware? Does it implement soft reset?
>> I'm using generic PHY driver.
>>
>> It implements IEEE C22 standard. So there is a soft reset in BMCR register.
>>
>>> I'm wondering if you can skip hardware reset of the PHY and only do a
>>> software reset.
>> There must be someone to deassert the hardware reset control signal for the
>> PHY. We can't rely on the boot loader to do that. And here even we choose to
>> skip the hardware reset procedure, the sequence of deasserting the reset
>> signals is also very important. (i.e. first PHY, then MAC and MACIF).
>> Opposite to the normal sequence. (we normally first register MAC driver, and
>> then PHY).
> There are a few MACs which require the PHY to provide a clock to the
> MAC before they can use their DMA engine. The PHY provides typically a
> 25MHz clock, which is used to driver the DMA. So long as you don't
> touch the DMA, you can access other parts of the MAC before the PHY is
> generating the clock.
>
> So it might be possible to take the MAC and MACIF out of reset, then
> create the MDIO bus, probe the PHY, take it out of reset so its
> generating the clock, and then complete the rest of the MAC setup.

It's not MAC which behaves wrongly, it's the MDIO bus. If we don't 
follow the reset procedure properly. The MDIO bus fails to respond to 
any write/read commands. But i believe MAC controller and PHY are still 
working. I recalled that it can still transfer network packets, though 
it fails to read PHY registers from MDIO bus so only 10Mbps is available 
(And the phy id read out is always 0x0, normally it's 0x20669853).

Maybe during initialization, PHY sent some garbage to MDIO bus and 
killed it.

>
> 	Andrew
>

-- 
Regards,
Yang Xiwen


