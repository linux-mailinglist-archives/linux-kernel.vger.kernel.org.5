Return-Path: <linux-kernel+bounces-86276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2486C336
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B852284E89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7704CB4B;
	Thu, 29 Feb 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SehPk17p"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2030.outbound.protection.outlook.com [40.92.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14358482C2;
	Thu, 29 Feb 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194358; cv=fail; b=mcl8q9h/vbYwe0h88JzKQefNCNi9rabqYYGJGRA+zpcoeKe4lxK/8kQR2oimZuV9jycOzCNPGWjhO7mnxOP+o8Btzx51NRwL32NCFfgj1FvDnd+M6kI/OMe2XzJ4i8fW7STQAepT1cw2nCNUvzGaH0VWX6j27j0qyefwPSRhQq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194358; c=relaxed/simple;
	bh=9mHGsGbGmiPClSfJBZA08pBwo4eVnNdwJpfO4MXhicQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UkVTFrATRYbmhZKNPZX512x83s8DLz2JfJzocl+XCeck27zwWEcx56ptwV1W3sxjk1IZrIgY8QBn5MUuFA+xoyqdojdFOBglIuQo/snOzb/mkcGpraV7kN64cKwwWywHBijYStStu06Jjxhoqeu4csTYYGDkP+XKn3B2ipyVFQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SehPk17p; arc=fail smtp.client-ip=40.92.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWgVuubjiLFvN11iWvDbXQoYtiHmNMUJqGlXwrGFLrO+8cY05Ed7MmO3OMlj/Bu9iH5ecHQn+d6Ynv+s6yYh1B9HYCPF2gYFKoTFNnu+3TRPYnOR6NbwLEc5T0bS6K8foIpBgxZjcEfP5cCHrhr0miUG0fbuJGxbxpwTvBfbjGjJ8V0nwQieijBs3FRkQhewg4n70zaHk0U/CXQuFVt7irR/LYCJaazYqbJ/2d+t8fwxgwwdnam+doBbhANnTAT+gUDaD5jCQYuaM6QKJxe5hJ0WnssadbO6HGPiG7A6f8p/JygOjRTx/CveMCHOf7sO6t/FJN4jExcDxYWyUKOJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjQQr+/l1iL/CrJpUrFN9h3SrM6wfwPXzW9wE3Lg7ZI=;
 b=oNWtRxmy9ufZs8pLJP/bU7Av9K3vykZR/xprNQ/06sVhY9ndESMcuP3mLhLC4/Venuq4CQZKRUUA+ZUS+MmCg1f8bRYqxytD9qCVX/J4jC4aR0lY1h7xpHmvB9DYoQfTeEZ4e+gISfPsZr1tE72Ci1NYhkh4l1hoZwTZFUq0KkmGOtNce46cCsx+jZ3jeCRIFcdKhMR3LCfP8PIBWKCRT+jS+AhhWG+np7hB399GHkN06SWk2KpmeNha+FQra2RwYWj7O9NAQEPkyXyATny1aBZP0FS2ieIqFiXFEJP2FiKqTJ1oWhHgG2uTgm8800jjNPfEB0XIRrADJVUTIYXh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjQQr+/l1iL/CrJpUrFN9h3SrM6wfwPXzW9wE3Lg7ZI=;
 b=SehPk17pgd0druHWHQ2XrOlwrCEYW7EBRPsSvzSSRSSdIs0Enyekv+vbz2Ny3dbvCNARRe0e58ZCk4mBrXEC01hcj08xlHGcApIwUukfdJEk8tj2ld3bTc9W/BBTgjfQynH+ez2PsIJ0BLbEzU5neWHINk9wvihX+K2E0HGw7dg9kl1Ojo5dXprN/ogR2ZFny5RWg2imlwWOx6qrPnj6IJMJO3hzfwg0mDShgFI2QpEioyjZsCsMNugycoPq2Z7DO4KmDWD8wmduApKa/5r6IT9ziXRYT2zVEhPjcmtf/wAE5Lpq28wEUUFmSEeaRGSZ16q3vw4PiPOLXgP+SUdJsw==
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com (2603:1096:820:121::11)
 by JH0PR06MB7351.apcprd06.prod.outlook.com (2603:1096:990:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 08:12:31 +0000
Received: from KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::bdb1:3c40:b3e8:1f15]) by KL1PR06MB6964.apcprd06.prod.outlook.com
 ([fe80::bdb1:3c40:b3e8:1f15%7]) with mapi id 15.20.7316.034; Thu, 29 Feb 2024
 08:12:30 +0000
Message-ID:
 <KL1PR06MB6964FD1B688F1E0460E5ACF8965F2@KL1PR06MB6964.apcprd06.prod.outlook.com>
Date: Thu, 29 Feb 2024 16:12:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 07/11] dt-bindings: net: hisi-femac: replace
 deprecated phy-mode with recommended phy-connection-type
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
References: <20240228-net-v6-0-6d78d3d598c1@outlook.com>
 <20240228-net-v6-7-6d78d3d598c1@outlook.com>
 <54d3b190-c069-4165-9191-4557845cd87c@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <54d3b190-c069-4165-9191-4557845cd87c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [4Hg71diEYehOmJ7aMZfxRJDupKCJAZYSkI8epDx5BNOFLZq1eD6fA3L6QPfwyTsL]
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To KL1PR06MB6964.apcprd06.prod.outlook.com
 (2603:1096:820:121::11)
X-Microsoft-Original-Message-ID:
 <301de09f-d0d0-4179-981a-cc91ed13f3bf@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6964:EE_|JH0PR06MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0086c8-8fd7-48d2-f089-08dc38fe2cd0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UYw3XKcHIltcMf2onfsImWhTyxO1NU+khw2/QLoCpD1kS5a5EqUaNy+S7Z9IIi+Xl2seSrcHoELgMdBp2XBDWeC/qtnmUzN9sS4ZsYmdcZBe1gCBFRAdfz72seGQoiCE6cc6+kehkFVivGaHnnKvl7iMgIWFhw96v04nJa0qRXArwZDXBZifY0IyIe/Rm9S9rNDA0VrzeAysFJVCMJwc6oqqrCnPEePa2c5zTcfWkSiA9P60sQagQKWuItkTrFWyeL7YFacsoDwDbnRJpEGFRASsjEp9jAMsgf2uRPgWZJglF744bCKrvuEo3rgTt0LkiFHXidGDA+GOftC3W41YermcRACxiugIp7BAJVVZMJogmpMCRw2Vl2ktiqx/KHMfUX5gQfnDwEeyF8d8PTQfhPK+bF2ECl4eJ27Q2JJB6ctun+f16CXm3owhrspitP3raC1CYcQ5WgytyN47KjFkQ+/FbuTnQ58ro4n4wSm47Ljwz3aDP2Yl6APgoSfOsARZ04gPS+1KMcBtpj7fCV4uxSzEcFkwFqSe/SAC/4ZWMq/AQ4B+elQqOScLR3sE3xl7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGx4Z0srYTU0SGRFUUV1LzVlQko2YmF0WERrTjJldEhLaG5lbUliZ1llUUJp?=
 =?utf-8?B?RnlqSFVzaTU5aDQ2T29nWWFGNHBHUzRQSGNxRGtQVkl0ajNQMC9HbDVhYisr?=
 =?utf-8?B?d3dvK3ZkUGZEVXY3M09JNTMwMkxvL1BmSDF1RWlKdC9vdmlmbEdRbTFDWHVL?=
 =?utf-8?B?OFJhNDhLVkNOem9LVWZvdXlGQVY5a0dnZHNXdE5EYWFqSVZ0dFhMRHFva3pa?=
 =?utf-8?B?TzN0WGVCNFh3eGs3NjBTVEdCK3JnV1N6VHpqRUVWUDBOcHNFTDhrSTAwUExq?=
 =?utf-8?B?SkNkYVpuOW4yQWc4em5Sd3hvcjNtU01ETU03ZVRaWk9Oem5KSk1HY0llWjhm?=
 =?utf-8?B?eG13ek9tMlZhZmN0dEFzdWZHM1NleWtXT0lydWtxc2s0MVZaOWxkT201cjRn?=
 =?utf-8?B?aFdBSUZRY0NkM1hLL0o2M1d1TjByMENhdUtXdUxueStLTU9OOCtMZTJkbTNl?=
 =?utf-8?B?K1dHTnFVS1RPRXhIOHZ0R2ptdGFBd2ZsdUxjeHZZYXUrOTJpT1l3cllLNGc0?=
 =?utf-8?B?ZHRwRFBCVHlzdDBsdTV6UG80OFJWc3l1dFdDT29uZmlTYXBYbVFaTXFRdCt2?=
 =?utf-8?B?d3cwYUE0L1Rna1YwdG8xcnFNYnhGUGcveGZKUlhPa3BCTmhmMm9BZlpjQWVP?=
 =?utf-8?B?bnQzS0ZBN05SUzNRSCt0RXM5bjJUMWpUY3dxSDRrVSt0a1JMYkhHakxyTDhw?=
 =?utf-8?B?SXdOcndneFhwelZnQWxPd2lVRFQ0SmIxVUZ5cHp5ajFWZ1pEUWk2VThGRUp0?=
 =?utf-8?B?dFZoMW1uM3o1RytVd1lLSERnYXpsRmpWVHB6cmY5aE9rb2JVYkVLQVBFWTVL?=
 =?utf-8?B?Q2dCS0hrb3VaQ0luVk5maFR4eEI2RFVST2g4QlhXaU1Bb2hmQk01OWV0Qno4?=
 =?utf-8?B?bUgxM0lBb21LZ3NMVlJ2SEFIWlg5d1Y4cWYvUFprUkMybW4yN2hSU0xPY1Zo?=
 =?utf-8?B?MTY4WG14Qmx6UjZJSlhZNzJzUFlTUTIyMERMcDBGZW4rcXFxemFaNVQvVzIx?=
 =?utf-8?B?MDNBanZGaDNxWVVqN0Q5MkVFRjBmVUljQXFQU2d2MU92emtjV2s1MHpOdkRG?=
 =?utf-8?B?OVJRbVUvT2VVczVGTDJSb2RBTXlJRit6cUR6SG9CYmhSMmoyL0FXZUU2WTNq?=
 =?utf-8?B?TjhNalMrUW5tRDJUZmZkYlJRNldGNWFyZWthYVVCTmdFY0pnUEU3YXV6SmI3?=
 =?utf-8?B?aUE2THBuOHozTjVIM0ZycVNnc1RudFo5UkJKejBaa254SllaMnVMSjJvNFp2?=
 =?utf-8?B?MW1lK2YwenJZYzM1ZUk2ZHFYdjZhT3VtQ0FmV1VTT3BOTVJseUswcVg1UFM2?=
 =?utf-8?B?VG9NUVVadnVTRFJkcitOTkJ4SjVtMm9NTm1OekFkMVV2VWZoTWZ6MUo0MkYz?=
 =?utf-8?B?YllDQ0FlQzdYbk5YQjAwNnZxU2ZMSVZhVDd6aU5pVTJNRmNTa01XbDBmQ1V6?=
 =?utf-8?B?dGMydy95azVvaUVtNUVsTnlpVkVsclRDLzlYZU1SRGd2MzZzMnZNd2JRZW9h?=
 =?utf-8?B?SEtKVmNVd0RCdElsQkpwdmo2SEM4UXpJZXMwQ05yRnc3NGFGSTBNbk1PZDZy?=
 =?utf-8?B?NVFnU1d4eU9YMk9KL2dqU09LSHA5UmFnWmlPZHNwaEMyK2paNWJXOHRVZklR?=
 =?utf-8?B?OE9aZW1lakxzZjdSM2Y1Zk90cm85cVUvOEhzMWhoY3Njb1Q3blhCSUUzUjFS?=
 =?utf-8?B?NjUzd0l6RnlWK092RE5YQXZLL3JLZzhYTXBNa2gwMDNSdFBpQkN5WnpvZFMr?=
 =?utf-8?Q?4+FLO/p/7KkDtO4CJVhzC7YP4ENfotvrWE0nq9S?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0086c8-8fd7-48d2-f089-08dc38fe2cd0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6964.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 08:12:30.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7351

On 2/29/2024 4:08 PM, Krzysztof Kozlowski wrote:
> On 28/02/2024 10:02, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The old property "phy-mode" should be replaced with the latest
>> "phy-connection-type".
> 
> Why? The old property is not deprecated.

The old property is just a $ref to the new property. While at it, i
would like to update it as well.

Since there is no real user in mainline yet, this update does not need
to keep dts sync. I would expect it(the old property) to be deprecated
in the future.

> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Yang Xiwen


