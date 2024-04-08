Return-Path: <linux-kernel+bounces-134961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6889B961
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6A1F21BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183044EB37;
	Mon,  8 Apr 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1fDBm7S"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDD3C48D;
	Mon,  8 Apr 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562610; cv=fail; b=ktb6iFmwCTfMmNki9h8vLm7QkeoosGdEjNsKwdJG2erXxJLtFckvTSreoiqbfQN4zgcfcQxb6Plv5e3qObvvyuCQMGkfK3bt8LKVD4M84tvDxUc7QSpuXFmk7kVULN6emcECZVnX9mN/bJWc0z2AyDI6nA0olOl8JtMAdrhq7mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562610; c=relaxed/simple;
	bh=R9+q49ZbvqINkWf+jGSXywn16E0VSzbn5+szbiebXfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uGM8GuLq0aoVrBZ9uEmw6R5YIb0KE2SwzroM6ymH5jPdjSN2hGpmj4qFIpHW+WD66qiqv5IIBpQd7AEVxarWuu5RyYHrcgqaF01K+QbLo0BTHqHKwTB/8eHuSkGRROeofWmwEWVMX2koPaI8cKWB4J8S9JBtizw6gOWKKRg4gYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1fDBm7S; arc=fail smtp.client-ip=40.107.20.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT4EqBLzgM7ZOKxJWwO5os0BeXiJ/5dh8X5/mBoUb0/UB8cbOFYMQgdkmkE6Bd2rGQbuQeNmVDhDyt5mUOpDsacf/fLzM6PurQS9XQmQjPgjuH9hkIWAEUmwtu6deKI8En1Rzjh4lIHaJgSX7eW6D4sGCb1nhhrWvHVtt9tecRcEo2BqVhhzYCR5KtXh6VVAdecS3VB51rbTlY4FumbZBLN3RwcAdRzXOYXTVvpsAFOjFSP1keEp8hsba7b9ZJy1DF2GGp94E/84l3k7q3X/JA7i9bebJoxJ3HFoUrfD8xdEcl+2ava6PsoeOOexs5/ia2EvHB+TgPkS6XNY7e2FaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiMWilwkmPNZge8EsTLNHRIWqbfxTe37oPlQRLv2XYg=;
 b=ih/jyGCcIv00z30VQrylA0fwbUtw0sO2kYIzi4ROh5JQf5+mrLDAcuqIh2KNxmOltHEqCjXXw47x0Wj9XOLtzpwsTJE0LpNyBSZnsOBQz4fcsH04Z2FPlUdHnAO/F3/k1hGKYFlEdK4h9DcsvmBqwdT7T2bISjGXefYpV6+6E7JOBgbw4f0wN2e60V8KI6yMbwEaEub4a2u1KQjSmVvDIMWFeXVX5lg40zt+uE/yherQRuh9ZjA0gi+n/lLgx5HQaarhDDb8aALEerWBxptCVZ7DqXxpXhUr1t4Ms0TvAknd1FWpcH3cH078nBT0h7Ly5Ak2Q8E8T1ZwSD88nzHIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiMWilwkmPNZge8EsTLNHRIWqbfxTe37oPlQRLv2XYg=;
 b=W1fDBm7S433aO3TUQyIliepNS56J1M9pRr0annj8IWiikrDPjR3st22H/zQYnRCKOsQExw4ZK0bAzd4mXBWYLItA0KVFksSaQ+zRBOxH//gSVDAYYISZDlPPXjalIFRJYJtY56fog3AG6rytBcv0ww82eAYB5rYsAB8yosMixOQ=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by DBBPR04MB7644.eurprd04.prod.outlook.com (2603:10a6:10:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 07:50:05 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:50:05 +0000
Message-ID: <58b0a77d-8bcf-4d76-82a0-15bfc1cc2e43@nxp.com>
Date: Mon, 8 Apr 2024 10:50:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v4 1/2] dt-bindings: media: imx8-jpeg: Add clocks
 entries
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 shawnguo@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 festevam@denx.de, festevam@gmail.com, alexander.stein@ew.tq-group.com,
 Frank.li@nxp.com, ming.qian@nxp.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, mchehab@kernel.org, hverkuil@xs4all.nl,
 linux-media@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240408030734.1191069-1-mirela.rabulea@nxp.com>
 <fd1d99fe-943f-4fcc-a736-9d97dba5a80e@linaro.org>
From: Mirela Rabulea <mirela.rabulea@nxp.com>
In-Reply-To: <fd1d99fe-943f-4fcc-a736-9d97dba5a80e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|DBBPR04MB7644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7YVKRCQt84UqsOaIb+cNgKO5T+SxAXERkogUOxmRrb/yhCQFN0rm23wgz4ONii9ZY2rmA34lRK9SOZRMowxg3baffXLgn+fYePMTBWGygCPN4bgG6S1fX+YmZxLgga8R5ksV1qo3iW7DaAFVKptwsGPPuj78IxasImp1RvD0Z1s8h2lkEBG7Drrgj8v6DB4LiPVT5yDVSwnWWc3TO0vtqlo40xvnXHS9T80q87Oe/M7EERarKTu5vaZDu7ghG3ny7VlNZcjPHXbLdTxWOMdhzH4naP78CMe7B/sdirHDN3s0GbEwhzmDxFwsZ+Pf9v8DZFXl8FbVSSjfMJ/h5Nvb+1pZyPpRrPNYyJnsc4cKS7of2t+kEOdTrazLc4z///XxHdYd3QHN14DYCjlxCf2VpM4ghKRZb3s0Me2OHwctH9AKH6YDVqPz/YuUZsXa8nPP6eM7q/pcUS5huZX/wGhvmijDvcUZM3EMepoNtVkT2ZwCK2TzyBiZnvMbpOLRfuGOeVZ3IfSv01PiUM0P7uINKxeRYoO6WLbG/UVyQx8Nld2pzQGYS3tAQnNhErWiwhWH2lsGu/eveLPiYN/GbLRB3bbhn2b1o1p8wfLB3+ICEGs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpvM25FU3FMUFVBNG42dVJRV2IyMGRLNXpEZDlYY2YwSU5oaGY2WVI5VXda?=
 =?utf-8?B?ckN6dUh0cW0zSm9DbTZta3Q2SEwwbU9kUGdnNFphWU43aHlaNTRKRCs2UkVt?=
 =?utf-8?B?TGU5UHhKaTNjQld4SkQ0TXd6cFlBN25YeUlsREt2QmhVbEZoRnNEUFFUNmhP?=
 =?utf-8?B?dlJobzJKSW5OOG9aRXVVMENFbUFOSk8zRjF1cXRJMkxlc0RlYVhiOTZSbGth?=
 =?utf-8?B?T1p6cnUrbS9LRkNMa3ZrREkrTlhKU0ZBOTM3RDcrNVNJbTk2QVFTVHpvMTJZ?=
 =?utf-8?B?VVF2dnJlY2FVcStxZ2c2NExCckg2ZCs5N01PTTBpdzg4ZnpRWGZ0WWN2dXU5?=
 =?utf-8?B?T1l2bzRVWnkvQm44aHZidjdEOEFOcEw1YnNHWG9KcHNjT1BxbzNiYi9Sb1Z6?=
 =?utf-8?B?dDE2SzA1QTB4c3AvdUN3c0RHN0lxb0RuYm5MdlN6d0YvZm9DTEppL05YSGdB?=
 =?utf-8?B?WTRsc2JBd3RtVm5TVUdyeVpManpQZ3RGMC9kS1dFeC9RbEhPRjhiOStJYkxx?=
 =?utf-8?B?VURCMjVacUlkdDhaWGtqVVNvK0RzV0pRRjd2ckNHaVBGRWVQa2lqME8vZXVR?=
 =?utf-8?B?YWRuV2JFQmM5SDVGbGV5NW14VlJTckc5Ujh6UkdZbDQ3VFlpR3BEYUZxV3Fa?=
 =?utf-8?B?UUdqMUtCSDQwTWJJMTJtV0IxaUl0dUlZeDVZeUd4OEwxVHlCMDllVTJUNE5X?=
 =?utf-8?B?SDZINWJNRHIrbDJiV2JpZGllSFkzdmRLQVVpZUl4a3o0QkdwTHYzQXBGaGxG?=
 =?utf-8?B?bEtqY28xdFFOWFk4Y2s3amdkM2ljcUg2U0NsWFc5Y0thRGFORkNRVmVnM0tz?=
 =?utf-8?B?SUNrcXFNWk5lcG5HOThyZXpVeGJiVUNXb0NEdlRzdW1vZHphS2syMm9vTC9R?=
 =?utf-8?B?ZmU1SlFMd0pSUElBakxkMTZCaElmYm1RendKUzlHOTlBYlhSSHIvMm81VzB1?=
 =?utf-8?B?UkVVdEEzYU9hVm5NUktDRlBRMnBYVDVCWTFEUWNIRkZOQ1cwTmJGWEFSc3dY?=
 =?utf-8?B?Y3gwQ092ZEdzc3NWREhjTk0rMmF4amlZSkwzS2dGVnFIb250SFIvMTNaN2ph?=
 =?utf-8?B?NkVsd2xDdFh6RHRydDhIaHNhd2kxV1VoVktqZW1rWTc5cEFGRVM3MlBVelNJ?=
 =?utf-8?B?ckdzMVpnaXV3WkVGSFF6VG5JQUNUT3ViSTZ3RERKZUNBTTNIVnlSOGZFMFpr?=
 =?utf-8?B?emJKYjFGc2MySU52WjcrbE1oOTdLcHJCb0E4ZjlTR3QyWDRpV2dDdXJiY2pW?=
 =?utf-8?B?K2NnM3IyanZvUUdCdjJMbWRVQ2hvTFhza0trL2RwVVdSZXhuOEoySGEvR3Fm?=
 =?utf-8?B?b3JCMHFKNkNsSFpoSGw4OWRwdGZxZDZjeW9IY0JNd0wxTEZrdFRQdDVpL0gv?=
 =?utf-8?B?Wm1odEZDVTBGZk1TQ1hDbUNtSW8zVGRicG9XOXZNbjZqaGlTVFlwYXdhS1cv?=
 =?utf-8?B?ck5pbGZDNzkrZy83NWZHVVVaQnhXS2sxTVFoU3lpc2ljMHhYcGhnMGJaWkdt?=
 =?utf-8?B?RVRaMnAvTGw5SUU0UTlrWUdjelhLZFRRMlNLWWM5WnY5L0d5T3huQ0tHTkVx?=
 =?utf-8?B?bmJPYmRiV3RlZTcvS1Bzd0Zmc2lhUittdCt0L3VlbzNoQTM5NWdwbDJoRDNt?=
 =?utf-8?B?UWliQzlDVVJ6a2E2K2pUcjdoYUJ1VFc0dE9kM0hoclhzaWxpdGNWcHpDcVpF?=
 =?utf-8?B?elRYS1FXSUd3NXM5QzN4TXJjZnN2cm5SOGVOdm5GVTIrbkVjdUhhcXlRa0Yy?=
 =?utf-8?B?RDhBU3ltTmRydGtBbUlpTXNZS1FTWXpxcnJ5VEM1STcrdzNEeFYyak5ORjI3?=
 =?utf-8?B?UmNkdWsydEhMQjdqYWRDMUFMSm9LNGFEQ0IrbDlneHJOZW1rNVQ2aERTVW52?=
 =?utf-8?B?b2JFYTgxaW5WY1BZeHFUQ2VEdUpUUUJBTG4reUhjWmwreFE4T1g5Qk1RL0Rs?=
 =?utf-8?B?Q3pndTErSUFoUTdZRTJLaFBydWJhaFkzUUJPQnRnd1RYWThNUnhlWDBBaXJZ?=
 =?utf-8?B?VjdNcktHaFBjYkttcEJQMWJ0YlZseG5TU3ZhM3htQXcreGFWd25qWTBvalhO?=
 =?utf-8?B?amVwajRXL1BNUUVIVnphUUdCVUZPMGdVOWdBT0E1Q3gzUHU3MmFXN2UzeEYy?=
 =?utf-8?Q?QL+AyYbnsYFdRznaRPGMei4nI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51229028-4323-46ed-c917-08dc57a0811b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:50:05.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVzEQ3tCT5WSv1B7I93D5sDUIjW+KqKbqz8td2NRGOl1AThDz2lozJdL6nOxOmVkMVyO9/+wXPRjuY2996Mh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7644

Hi Krzysztof,

On 08.04.2024 09:38, Krzysztof Kozlowski wrote:
> Please correct subject. You already got comments on this.
> https://lore.kernel.org/linux-devicetree/2fb8c43c-c079-e04e-f727-3bc1dc29996e@linaro.org/

Sorry I missed that.

I will update the prefix to "media: dt-bindings: nxp,imx8-jpeg:". as you 
suggested in v2.
>> Changes since v3:
>> - Add items for clocks (per Krzysztof's feddback)
>> - Add description for clocks (per Conor's feddback to the other similar patch from Alexander)
>> - Add "media:" to the subject
> Where? It was there before, so what did you change?

I started from v3 here: 
https://lore.kernel.org/linux-devicetree/20230912163810.1750488-1-festevam@gmail.com/

The subject was: "[PATCH v3 1/3] dt-bindings: imx8-jpeg: Add clocks 
entries", I had just added "media:". Anyways, will update it again.

>> +  clocks:
>> +    description:
>> +      The JPEG decoder/encoder requires two clocks for it's wrapper (AXI and APB),
>> +      and one clock for it's core engine (AXI, same source as for the wrapper)
> Description is now redundant, drop it.

Ok, I will do so in v5.

Thanks a lot for feedback,

Mirela



