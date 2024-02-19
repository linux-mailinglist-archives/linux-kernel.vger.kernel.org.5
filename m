Return-Path: <linux-kernel+bounces-72063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ED785AE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1583E284E42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB1056450;
	Mon, 19 Feb 2024 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J1bCiCmf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2065.outbound.protection.outlook.com [40.92.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BB54F94;
	Mon, 19 Feb 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382068; cv=fail; b=orfUqnUO0uetQiKG+sfOkw9m5grmLpLAmX0pi6JoWKP7NkqXT4ThuH9694of4EuDpO35nVCCtihx5PQJERx0WJU23XHWTO8jWngrImWwQC+8qB5cEXFPv7Yxc3RNPq4PuCak+XNWH2B9cLa8OI21XuBycnjzGLa7i1yIEJeW9II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382068; c=relaxed/simple;
	bh=TTmEiPCWpoKhPhvhaNN1aVSKpO9AEkLkUZA434sqxwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kTkY8GuFuOzboL4f7cQK3S23R+zie1J3CjizHlWqLu/zPCoZSj7vmG5VfVt+A1z8nNfxtZhAyLzJmwyI44aWJFDa56LZu2qlWx8eYhS5aIWy8D7CD7NcZ0R+5FhKPTplIPDR0L/F1RijmIvNYDW+Un6IjEijgJdDbVKL+4G6WlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J1bCiCmf; arc=fail smtp.client-ip=40.92.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbT7YxhOTL9eWNJFV4iZw7d26GgecxnoRkQGSKycQU60ctalkEjOuzMNGnPvQslRZrEcpPLnSsqZ3UO0BmfE+UKjX4dk1dUKjH5ahG9Lwr6EA+YxY0ELUAlZZXnDgnO33835xeVeZNJDOPmvt4msFUnh+zLRkAXP+usxAGldtQCTXuD0//p+LM9gljOiqsT1A1fPvBCxgyd3bkCN+66W1wWWfJ4NtW598hO8vI0j5AWCExlYkU0HM/k6yPfDJr1ahg3MTOBcXijwwLbyCRvMAUgYe3sU8Ymg8Rn49PAYgucW+LfibUEkRdZ8LWa6xlio/q615UHFi5JPHnrWz5iC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGbM3AC5SJV90fJaTlCt5tBckr/ZJADQtQ7J0uA83gk=;
 b=ZOG1Pw81UOkmsnblCJZrMK2CFbJ1OgPgjjG2SKvhEj6imx/HeLA/d+XXLIsKB5wcedZ3eRRbcUXu5cQF5LoMl/pgNfEXD7Hk9+2M/NEhsyWhDN2qukofGkLU2IClhwnAZNrb0iyfftnnCXx0DBGsDA/W30eHIrVCrmNRjnnSLdv0XQGVvfSbzwNTyY6VR9nOD2H0+9yEqr0guHU/KgIpWQQmPLpTKUt7laGZyS1pvvODKxuxYP7bIUhvGL4Llhl9DBVzbCvWF4wMAiREdJ1LFh5ApM+mhBpwuTGS7M4MORh2LthLCMMCpzhxO/mx+bh+GYdlofusdJxp29XvCCZfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGbM3AC5SJV90fJaTlCt5tBckr/ZJADQtQ7J0uA83gk=;
 b=J1bCiCmfp6aUCZ0DrVlss3yE69a1oH9u60nU7/LiPxT/xa9/V5jxbF1rUd7zAeahAp9FgzngWdGHegudk6Fi+OX9ypiZ/tMYnRPEhCx8Hl02YLTZ6LXTDa0GioYNxh0tAHijHm9lPSqRqZbXE1OD1278ZvUUuBXOvm7AFLZYG81o5tEwSjUc1dwi+BrKio9p2B3TmmtohocugAKppZXgK5P0FLlFtHEi16MtHGcVmpG7gX9MR8o5XI4d+78MoKQIbDusY0tmtvqS62HEPiibmiSgE7s2Ht1GfTWNxfLhViwKfpLsvxz26xzfirqdqH/TrwICv9YLWz82aFbq/V88xg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5958.apcprd06.prod.outlook.com (2603:1096:101:e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 22:34:21 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 22:34:21 +0000
Message-ID:
 <SEZPR06MB69594F945CDB5DB05F51C9BA96512@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 06:34:18 +0800
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
 [+1LCJbXh7vhO7eLkeYwqe1Vv//pXB4cTLMfCKz6DHOOcIIFyOwBJKAzTPRqh5X9lzrTzYwngVl8=]
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <df199a6f-a859-4ffc-a2be-04dd5f74a2dc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c68fbc-bae8-44bb-e051-08dc319aeaa4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ounD5c9q/rGVTkhm0fNLYQcMFVULPMPTYeauoM7hqRbaMRyHzBqiySXyWB68npnbituPboBGMG0bGhqd8F9RbmLWGh/w1i+/LCC6IXOnXkXDD2kHg0nGDGTZHX0BcvhYwBC3P5ifRspgJXz82ea66nl55lQK+10YDumCB96VI8R1iWQNQ1O8OtgU12iS2zhhgG9f00oYKB3TYxjN8lM81i0UPPRVSFQD5AoZiwN1DdL5aR+IunfbndEUu4e3qtBCc3sZlQrcdHWE1bw4vLsmdH9Ob7nkGe6tjtbweNeNgpAAQMa5GKS08rWGcVQpL9Wk9ViWTa+rqB+W82ReLbgGIU1mDxMFaiADcJDnp1U+aQfSavaYmKT0d8JFyxWKL7n3iqkhyNZddPacKu+ZvFdMpfyy7xF3iva4O0JWE9eCiiaeAy42qCLz4hwyDuD0J1ZpNwhhrzBa0w6m0o713vfERLNCBO2+/sCfVriFqLHHMViyjc6m6n4DOjmAe0EUgD81fs7DL3IbHsTEsHVgKQ40XkncqCiPGABY/ZYd3RlflXGxh7p3jmueAReTFy1YZzT5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEdKVG5GZ0ZyQWE2R2dvVUpWQ0xycTdacnlod2dkVjJsK3Zwd0RmQkt6YlJo?=
 =?utf-8?B?OUdBbWZ4VmdOejZUSnhiK0F1Q0xxMHE4eDhkWDZ1UERjTjNrZzJuRHpHdCsv?=
 =?utf-8?B?ZStpbzFJZG94Q2hvWTE3TTE5Y3RhSmFSdDBDVG0yZ3lkUVpUbTA1Ti9JeGdX?=
 =?utf-8?B?bFhRY2RSbTBZZ3NzTlhCcDhoNlBTSHlBQlc3czlZT0FWWmJid3c5aU1JSVpN?=
 =?utf-8?B?alBWR1ZyT2c2TTdYcmZHTW96MlJGODVKL2VoYXhmZnF5N3JrbE4ySHZ3akww?=
 =?utf-8?B?R3NibzJRSnYwYS9Yd3hwRGx2MEljZjZXdFFCRHkrOFJEUElPd1dBNDZySzI4?=
 =?utf-8?B?VGJJUVYyRU0yQlpnRlArSDhHcy9xT3VVa0tuQjFiKzM0blYyRzJNOE5EZDAr?=
 =?utf-8?B?clpDLy93UERpSW56UFNxb2hiYUYwa0xyOEt4czYxc0xHY05XWktBaGF6dDNj?=
 =?utf-8?B?LzFoVW1DNHp1MDdZYVNKT2FWSzVDeExSdEJycEdLaXQ5aVUxQmoxeUp5eXFk?=
 =?utf-8?B?WFhnT0xNZnR6Z2ZiV3VtRDhINTZzVVoyUjhmcmkrVy92WEJ6bVAzL1RObldO?=
 =?utf-8?B?YW1yd0NibjQxSHRGdHlITnB4Y1ZBMHlBK3JZMnYrc01ncmRRdUVRY0NQTzNh?=
 =?utf-8?B?VGlPY2I4V1ZqY29mazVCWTNqbUhmcWFRMTh2dU5WSzNqS3pFbkpJakR0MGRp?=
 =?utf-8?B?ditvSytWelZPemppdEFBZHNCRXhiT2VJSklxdzhwNXh2MU1Sa2dhNkFuVklP?=
 =?utf-8?B?Qnp3ZmtpaTUyeU43UHBxbkg0d3VZQ2h3QXpqV2ZwaGJrcVNSell0bStPTXZw?=
 =?utf-8?B?L1JTRmxPR1ZuQ21TY0REQk5FY3FIclhSMUdrdGt4eTMxTGp1Rkh6NTBFbXV4?=
 =?utf-8?B?ZDNnUnNnMVl5aC9hVGc5Vkc3bC9pOUkyWitUTUxNMEtqWTZBUE1IaGNBWXdk?=
 =?utf-8?B?ZlZvUlBrZDlZQVdlQmJpS2VTMVVLOXF5Sk5kTU11YXF6RC9YNHE5NzNjNGU0?=
 =?utf-8?B?aElxd29PQmlUMzlqZWFLSUhRSGhrQ1dsNXVOUWE3dlRJUGxxbkVTeXRKdXBO?=
 =?utf-8?B?enhrYUgxQjhxU0NiWGR1SHhiQVczclNPaWx3TitDNGNmNVZpTDJLQVUrNGMy?=
 =?utf-8?B?N1VNMnBNRE91NVNWOGV4eW9MMWJ1N1JKTkFacERUL3JteEhWWlozY3liWGtH?=
 =?utf-8?B?QTFCeHFOdFN4bGltNTRqKzFidVkxR01MR3E5WFZlaWVmdXNoUzhzRFZvQXdM?=
 =?utf-8?B?SklNU3B2cS9xcHJ0TTZmY1ZhTlRpb2FTOWpXMCtzUTg3dDVWZ2RydkJ4NlBq?=
 =?utf-8?B?SHBZM013bnI0TkFqSjdmQUdyVE1Sb1JSeTF6WEtmeWV1TlZrdjFOVktyV0J6?=
 =?utf-8?B?aXpjZ3lxM1Q2NUh0Mm9HMUVXcG1aOGdvR2VCWXZhdlBtR25tOExyMDgrc2s3?=
 =?utf-8?B?RHJnNllEcTJIUUg4enY2RGV1akJvRml0Vi9ETklUQnR4KzdJUkNCU0lDLzRn?=
 =?utf-8?B?SDM5TmJGYkFDazBLQjFDOGZPWk9CT0YyYXNvUHVYaEh4WDU0U3NhT3hCcmZi?=
 =?utf-8?B?ajB3WitTQkhFV0pFcnNsY3RhS0RiOU1JQmNuNW5kdjN1MnpiQjRnQTlPUVFE?=
 =?utf-8?B?ZEV6V3pRTTFMR295bThQWER6a2ZNcVdDUXpMd2FzZkxoa0hDQzQwNEwxMnQr?=
 =?utf-8?B?NUtkQW9qazlnSis5bTNrY1liQk5xL0k1bDRKNTJzeXV3T0I2TmdjQVp5T0NH?=
 =?utf-8?Q?+X1h9ALdyYObh6sTV5a/i8B8/dGuKXY7BlI0OLy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c68fbc-bae8-44bb-e051-08dc319aeaa4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 22:34:21.2466
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
I conclude that master side is working. Because when i tried to read PHY 
registers manually. It does say it completes reading(the finish bit is 
set). Though the data read out is invalid.
> of reset order. If the MDIO pins went to SoC pins, it would be simple
> to prove, a bus-pirate or similar can capture the signals and sigrok
> can decode MDIO.
>
> To me, its more likely the PHY side of the MDIO bus is broken somehow.
>
>     Andrew


-- 
Regards,
Yang Xiwen


