Return-Path: <linux-kernel+bounces-74373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD1485D329
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5F1F22014
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1353D0AF;
	Wed, 21 Feb 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="P/SAc2Ra"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2121.outbound.protection.outlook.com [40.107.8.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F473D386;
	Wed, 21 Feb 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506826; cv=fail; b=it6un8x6a5X4uGbyyjFJCYqY7UAXvqteyoKgloZq05a4xGeEcoUJP7gEyP2LtyfE0ORyE85oy6Kia/5d4DfFE2DwgeBkZHpdZb7MJs2LQQZPDWJ+IO9h+9kFBfnW4maUJo/qWX9vrB1Zi3yfBIw6h1xRWI894vDN+oeNvY4qUYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506826; c=relaxed/simple;
	bh=zDnlRCXvCwoZdhaGfEfd/MscPP9r+nGxv8LlMA9hbLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsL0Kx79tfWCP996m9Qk5ZxOisW4+GNmJP7knct+uy79QLhYixf/vctkSyfUQvQ+yeOY2PnOhufP+oHaxNoLo1ivRvjKiv1ibFjRLHlCq9Ix7ox6Vd/jQBa8PTbCRml1FQ4zZ3AQQ4/KMcYMO2VwCh40qumdgtPEmpcMiUTGJ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=P/SAc2Ra; arc=fail smtp.client-ip=40.107.8.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCuSRbHe/pZVJkmJXmUWYCMIWrDq7fTwqBwN4moWww5nHFWhpDK1lXYKTbTHUYna/myG6HK8H64s/BTtwmj7ED4rtkfHiADigCPzQnm2Olay1tdJBnW39RNyvVEm+TWZejmBplRJp2YZr47MBsPipAb1wgOtTBHjpnMBb9QypkducSarMzWkx9id2/Iv7WE2KwAFo1Kamz8wmWEsCS7ESkcQrmYhCmyGf02bHOhYBXCaST+N59atf9T+ja2CXy0QwYFZBNyKP2Spv6Wrp2+4EUzHsfKaxmuQgSNevup45gC/oCQcmG9Aka2FKy1HmlYHFGqWXsasDqn0d/OuBf7ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=587H76IecIJxT33cbb45zEx3aaTR4CwiwqQD/7FGoCE=;
 b=mz4aY/rOnaiXnPK/ZSHjoYNoTWCz0V36n8RLTZTPPU02w/v/MLdgT6DSekysQgh8aeC+FPl8ab7QfAVdGzYKrCuJ7ef0rJ/fSQrV81lDgZ/CgKox+N2PDN1XclIxn8lULWgseOhLooTLYBvOcXmtBdlRmb+qtUH7OqGBqH9UO+fRdd9r75ALMHhyMnmh5D4NWGgM3jS3scxc52/Pba+s6kbJ9CyL5LRf1n8Xgl0tSTDxOq1UABhR+BHBlC1lvPVhyM5mDAP4FcryEwwjxwWCPRFzYJMIJEDFh51E+t6J413VknWghfiOIrH8n6Ku9MmUkl/DFbY5VV4Fx3ZYe3tZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=587H76IecIJxT33cbb45zEx3aaTR4CwiwqQD/7FGoCE=;
 b=P/SAc2Ra/rSo8vtpjfphyIwzX63kYaywZ96a14FqGggjjN9QrGgVAUk69rmMiunSD3W1FU4Kuow1b8ZzWzp7ez0o/lgUvtCrJWJaizYakQQCrqAM7OotS0PQ2/9iMA5jjhnMjUUZmt0T1+rpfkHyT/7fAWOG124CZsJ971pu2/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8634.eurprd04.prod.outlook.com (2603:10a6:20b:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 21 Feb
 2024 09:13:41 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:13:41 +0000
Message-ID: <a0144c5b-4095-4a0c-84b6-93dfe9631a6b@solid-run.com>
Date: Wed, 21 Feb 2024 10:13:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
To: Michael Walle <mwalle@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
 <CZAM553H2H56.2TDN36QEL90XX@kernel.org>
Content-Language: en-US
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <CZAM553H2H56.2TDN36QEL90XX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM9PR04MB8634:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e0d8d0-ce8d-4e8c-2b5b-08dc32bd6586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	guQWJu99vRn8CWTGsq+FGIvLy+67ysN5PyyW/oXhM32bm4k/e1c5DzKmnlzvLWdjIBLKSlj6cdV8Sn0fAxwkdpdCyTqgJzwuR7iocH1PCFMNNaYSainuneBqHfndFvLz1xLL1JemXgi3AcGu8QpVSHfsyGSai4vUsXKmOm8QXj7Vs/uUDHXpw8rFMWrljNOFqwIkVVyW5UduUS2XIDjDp4TT7tHLjUWS1V/Qj3ObOgqHm1xSNImC580DJyxeFNrzO6vqO6kRkJOrQbC421jILW6/c6eAIvRLdFUMqjsgQgydrMBkbCZlZs/7eUsl/wLR4QFIGm75kW+vMrTU41P0tk5/HszDBdfLietJWLh/Pqxv5zd/araktTZlun8bIoLJ8KtuWFnYfuFZgCciDHMJlUsgmv/eMWn/YjGUySmmq5NUOBWszx8n2zvLy0dqmCRISq4qTIsZRSsqBeRUGSZOEnGf9N/aLmLCJYMjjmTk/WYvehoZelW78CqBr7prsb1DK6mdYPDm4+Ler4FI+B1N6GBfDHTde7tm8UIdN1n9zYVq8z+vDMR5n8sCxnE/SQc1xItTSyYTeT6JKDYOB7KFd8S0ERuzE+lwz4i8oSjXmls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVscko4cjJVL1dmczJYQzBBeEJQaDZXTlYzY2FJbmZVaGtaaGhxb0NoUTNR?=
 =?utf-8?B?KzFKSW8vVmttY09XNFJLeWFhdGtzOTBCNklGQ0NzUTd5WWdDcEJiR3dwTGRv?=
 =?utf-8?B?cHJ4QUswOFlRRTBJZG1nVjRKc3JMZnBOTEgyUDI5cE1DVU5kMHZyQWE1NUVh?=
 =?utf-8?B?RGZXOHdmT1hyTEZLNlNDSStjdjd3SlBlZVFKTDJ6RUM4YXRZZW1lalBjRnN1?=
 =?utf-8?B?SEhPdUdYNDg3alpaK3BpMllnSGxtbVhhME9uTHZGbFdmU3dTZ3R0Q1FVZWxO?=
 =?utf-8?B?U1JqVkt6WDl3UU03RDkyS2pQLzJnc2YyUkl0cys3TXNnWTFYOUVvOEM5SEk5?=
 =?utf-8?B?anlENFRSb0VPclhmOElETDhiNlBRbzljTnhkbEM3YXcrMHFjdnF5ak9HRzdl?=
 =?utf-8?B?dXEwdkx0NlhaeER1aWlnMXNDL2trQkwxa3RJNFBGeFJscTRCd3Vkc3IyQ0lQ?=
 =?utf-8?B?Ui9tT21aZkswdWdsdlpKdDFwWEw0TFZaNVlIUXY1TFo2TmY2djNHRng0V3VO?=
 =?utf-8?B?eDRWdHYyVkx2K3BFUzY4MkJuZVdmTHZZcnZJWE91RlAydTc0dFhUQ3RSZy9a?=
 =?utf-8?B?Rm01N1dvUWp3U3JCNVcwSkcza0pKV25nY0c4Z0ZpczFHdnd3cE5yUHJXaUYw?=
 =?utf-8?B?cmRtMzNab0JTSlVSdkRZYzhtbFdTMFAweWxvM3lCSnRVdzV0VE1kTVBjbkVG?=
 =?utf-8?B?RG4zOUdaeVRJZGhOZnRjdEdablZ4U1R1L0VKQUFIbE9pUzN2NUt2U2toVUVv?=
 =?utf-8?B?dU5uTFZhOHNucmF0TTVQRDNKZk9TQjVOQXYzK25OS2lYNDBWc05XVFBCRkpQ?=
 =?utf-8?B?NWRtOHdVek95Y3pOYmkwK2I1V2w2SFR2OEhQZ2NBdkhLRkJ6RVoyTlBLK3ZY?=
 =?utf-8?B?TGNHRlZFaS9iaGRmazRWZExYRnYzeE40bjRGSE94OFhYYmdvYnN5Rmlmeit4?=
 =?utf-8?B?L2RyTGgxTkNIaWNHc1ZsRHY5bTlWYUFjMUFHUnNTbXdPYlpzd3Z3VkxncFBJ?=
 =?utf-8?B?T3ZHWk1yV0xTZy9HU2lOZC9SVnIraUFRU3EyVTNNZWJWUUluZTNCSDhROFpI?=
 =?utf-8?B?VVJXeWVXUzBSbGdrUUcvTVBIT2oreVpkQVlVYWx4WHB3UkNXYkQrYmU5L2hv?=
 =?utf-8?B?MEozVjRhMVkzRDFadGxaS2ZyRkhhSGV1UU40RFhEaWdBMzM2UkYvdHlOcW5t?=
 =?utf-8?B?RzgyOTJnTldseWlkaWNwT0lPeFZFdkgxTjRZdmdib1dBaTY4TjYzK3prV1RC?=
 =?utf-8?B?UUJCVlQ1Q243TUhyRzdTQUZpNThQYU0yZ0ZmOVlkT3FtZmIxRzB6NC92ZlQ1?=
 =?utf-8?B?T2JiOFhDdlNIT3BGanNEYi9JclZlWXhOWWlqZVk5YzBEMk92dXNUb3BWei90?=
 =?utf-8?B?cVJITzMyWEFaNWY4N0lsaG1kbzY3TW9WbTdJYWNSMi9YR3RoVXJLUjZDT1Bw?=
 =?utf-8?B?Q2M0V0d5a2huTGRXMVZUY0Qwb2Nuay82TWx6Qk0yYXNuQTJZZmJCRWQvZzRq?=
 =?utf-8?B?RytYNDF5MGZFOWJwZ1FuNXl0V3lCSFI0ckJGbEE0M3FTZnhtNWVNckZWdll0?=
 =?utf-8?B?bkxDY3RWV1o4clFrTE9ZZWN2SU1HVVlkK05XL1NoYzY3ZzRGKzVrN00vOEg2?=
 =?utf-8?B?SDlzSmFaaFVNQTJzU3gzb0tESS9zU09XTzE5aDl4L0tKK2xMbGhqQUk0cEYy?=
 =?utf-8?B?dmZjT0ZJdnBlbUdMVDNpM1owbVlTQ2p0Q0tneFZ0TGlRTUp3ZXlhcWJma3hX?=
 =?utf-8?B?S2dpR2E1R2NrTVU2MVpoUXQ0STIrdEJpTU5FLzJkc2dLTkNTRzNVc2xxSGVr?=
 =?utf-8?B?TWtNVXdIZUtvQ210d1A3QTBmWmxyOHlacFE1czJkVFo3Q1R1dTZuTVQ1QVE4?=
 =?utf-8?B?Z0lUWkZxWTJoYkhnUDBLWXBWNWx0ODJSbEU2OEZLZXlaWUp4WVNpNk9vSERX?=
 =?utf-8?B?TUNNWUJOWFJpbzBERGtCVG9NRVRpY0ZMQU9ZOFR6MjZJZW90azEyR0VGcVVh?=
 =?utf-8?B?TkgrL0JMa3NHQlRFTXhNWGRUby8vSExYaGFjZ2dqVTRGSU5kb2VONTVQWUtt?=
 =?utf-8?B?QzdqdFN4cEtkczh1OFBTVTlEWlBvQ3hzeGdDZEdJZ3RkanJhMnA1eW9YSkpR?=
 =?utf-8?Q?elmcWbxRuMOgAI/gvEpjZ4Q/b?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e0d8d0-ce8d-4e8c-2b5b-08dc32bd6586
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 09:13:41.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iydicO59NyaDEBRQ5CvmbnPhQaDeH6Quy5Sz5l18h7OCufLEd9mLwuMKj4HhL8DBwC7BDHYxiPtFCP9sKzUD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8634

Hi,

Am 21.02.24 um 09:27 schrieb Michael Walle:
> Hi,
>
> On Mon Feb 19, 2024 at 3:41 PM CET, Josua Mayer wrote:
>> Some spi flash memories have an interrupt signal which can be used for
>> signalling on-chip events such as busy status or ecc errors to the host.
> Do you have an example? Maybe one with a public datasheet?

My example is Infineon S28HS512T, however datasheet download requires 
user account.

S26HS512T has interrupt line, too, and datasheet is downloadable without 
registration:
https://www.infineon.com/cms/en/product/memories/nor-flash/semper-nor-flash-family/semper-nor-flash/#!documents

>
> -michael

