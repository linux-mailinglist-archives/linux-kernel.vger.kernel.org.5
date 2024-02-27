Return-Path: <linux-kernel+bounces-82809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8C8689F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15A9B26151
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D754F82;
	Tue, 27 Feb 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nbtivwBd"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2019.outbound.protection.outlook.com [40.92.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267D5467C;
	Tue, 27 Feb 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019429; cv=fail; b=HfgRI3Vlj1kcfYOg4I9CpHHCJ2Zpe598OlyfVfEq3ZkMVB5bsfbxO4WhKp3zOqyYJdYNvMvKDcL4x8dyeiBe499U87oRHg2LorOJ4nD9o2coOk2j9SiuF93zcCKDhaLmItwVR3bAjHPNt6v/PWyhVMhkSmSGOUjnvQx9CX5mk2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019429; c=relaxed/simple;
	bh=u+Mle8VTT4N9ZL6KIG7rSotW6G498NLPyi++Exsv6co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SncVXrjtwY/KJl+d4u4KRjGCrjx25nTK0rtChcyYFaZZBUOaSPkoF0+IbBeBVECHIOxAXBTvOxzEz4NTZLADNhm3MxsaxMi51J6wbw2xnDKL2mSX8/Z352hGyTW0giuwDDJmBNjc+CKpKqLaFsYfruOTMpPwjVmvGZnZnzoQPpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nbtivwBd; arc=fail smtp.client-ip=40.92.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocAACB6vsnsi8YvjkUxe458dgTqX4u7fYiVuzXSCSgy5BpbphPPTAWsrRAePwswNflY+xJ6lO/DOJukcgKZ+PmtlJtSRioJA7l9GjznkQ53NOZhxNaMmyFMJJkqjlCRyERi8GUhdYuXlvCrGWa+NqeS612Zh+rTD6ArlNzb3EHYbMjSCWgabZxCg8Av8jaKAq1SOtnywydkjkHBnjXalPTCxxIWU9BqDUlThOD9d1LylIp9SY/PRiMn7ggOqU4rMByhpPnsagM0QvOEv7kLNjXQcavJ2Yzkikv8pHmcHTnha4ZzZq2tWKsQ+z5zaOT1jRlmsLrWtURgpjU63j/1aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvJdJ2G4y+lb1IGs4+i0Fld7Scvg9xMcpifOIdNiAKc=;
 b=h8NKdBgcLrWTvIcvTwHGuc7DNfnivpJD11y8YwpUNPVtjAkEelCzGFzSBrWbKrKMjk/xyR37o7hDjq36WnvDB1xast/Ht0HcOQ4/0eTQJm5WDlhL0FJZ9wGHKQHMKhD/mbnPXejcP5e4ydRWyJRkSNTbkf4MO6feWXX3014i9arXn0d1dsCGnQ78QOBflAIdbOxsCZNIxXg1354y0MEjXnvJVz/gooZKkvgHAWI5RvpeTGny1iFXJOHTk8tm0acRpX5rsKgIxvNWJTxFA8LTNssOPwlkmRXFtEhJ60a27+ORD8djPa6IdIL79sHk5O5KcLPAaHSArAmzlJLa5pX1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvJdJ2G4y+lb1IGs4+i0Fld7Scvg9xMcpifOIdNiAKc=;
 b=nbtivwBdzmeso/UXDxgdNpk6X940FigBXqKXG9TzAjpFV8M2bHEh67tHjCRg1lSuQVxrv4nmuDvb6DYOYuxDBB7pRZR/2UHkYrEdMCzab1rmVUmdYOYaQhWrPg8NpqOM1+GOgwTosQPD8N2TwurILqiI1plql8qtivCYl86LLfD9JCY7Tk/ic+Ek1drbiHb6OzWiaNEzzlBEyqMHeVt/dJ6pauIy1V7R8QJdzDbMUrQX/b390UFWVnRc0Hu/g0s5VIK6XVY9NfCr521eomv3LMO7yGuIHr1JQ9JsoMmMaq8YIsvz1yGWASL9gpkSKPjsYEXJQbvldbRq+7N0AB1wwQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB6749.apcprd06.prod.outlook.com (2603:1096:400:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 07:36:57 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 07:36:56 +0000
Message-ID:
 <SEZPR06MB6959E3E0C16ABFA9171FC4DE96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 27 Feb 2024 15:36:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/6] net: hisi_femac: remove unused compatible
 strings
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
 <20240222-net-v4-6-eea68f93f090@outlook.com>
 <ccdcdb1b-44a9-4233-994e-18d875a99c2f@linaro.org>
 <SEZPR06MB69590A200BDDD6D3DA4CD2DA96592@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <90ab2113-f3f7-4d1f-83ca-aa57cbe63a79@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <90ab2113-f3f7-4d1f-83ca-aa57cbe63a79@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [Rxd7LbmLFGGuAFbCn3sVeFLOPZAJ6QLPIRlcZSwrvhUiZ4y1qKGerMg7sXZwh8gb]
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <c462d3a2-25a6-429e-8551-17a848ed9807@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cd76ab-2439-4b29-b4eb-08dc3766df6c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9vzw0Qsvih7RsydjKtmLYMF+psfXde4M5DvlpiixFDyOtnQH0YAr2B4nhAFZb3zUNIQtErte3m3IH+jiBndKgejrquMo/VdSXwsYrInIM3/PNX8bmGo2L4cnrOuiPWMkIxy+39dwvtBuDsr6c5Vt9iX/IOLYuXbYLv14QPPxvZUuoVOUPudrWBub1G3hqWDPxbNRyRWeYPKCdbKqQneNjwkOGgEZOXuwWComXc5qtbyEw6LoJKsiR147NTsYH8RKw4c3BWYkj+A04cLioX2C0rjm/JVDKLJhOTGf1nlMg8X0IDOgMJClaBRZ+4q3jcvJm6l/Hw2gS+8a8iiTDOnJiBxomip1b+O9ZMwaTBcmWupdosVY23R4c0OVw/Iif+DV1rQmj+kOSELDeEDrsdyaJSpFScWsNCQ3OMj4T818PTU9aw5Zx7dhIiX7QTZ5W9DJJoeCM6bCnG04VViBxvxA0nPxLkdH203t/aX/B5ujqP7S2nD33OwT22K6NFuj9ApX7jf1gssb6DUJvdquzLRDRwa40Xz4q7HN3jfVSP/PuUwSHuQUqT/fsr+E0Z/yyGU1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEV6cHVJYytyQ1VMakZHa1FjakJnSTY1cGpFRnl1SjhnNHFNYWt1Ty96Rkth?=
 =?utf-8?B?NFpRbisvRHh4ZmdoYmRVZ3RMNndncFhORVQyY1Jpb0lrVjZGTHlrUCtaQzND?=
 =?utf-8?B?SElBdXl3RS85VFlGOE5WeFA0b0xKVWpkTU14WmRkRGVTbFJ1bGdnSEZ3aGxB?=
 =?utf-8?B?S1g5enlodDdCNGZRWlRXajJXdVNaTjJCSGhKblpvTFA2WEFYemxneVB4cFVa?=
 =?utf-8?B?Um5ja0hmYndtTjVxN1oxK2xMbDV0T2wzam5KLy9pNVkvbGhqa1FlYms0aVhJ?=
 =?utf-8?B?MlVRenBiYmkyQ3BxRzc2SE1CZ2NoQXVoaGRYdFlYZkhlRTg0N0lEOUlDVWlR?=
 =?utf-8?B?bUpJRXdScE1sMENEUWowNmpJR0Vzem5WUFIvNW1OeU05eGRyOVgzbXYrMDdu?=
 =?utf-8?B?T1VBN3ExVmhJQU43QjFqRjVZM3dKTm9rTlBzL05QQTgvZjFLbW8rcjU3OGdj?=
 =?utf-8?B?T25CbVBRT1o4QmtkM1g2bFdyK2pLRlYvZEdiWG5kYTdvZXNZMXIyTVh0bmkv?=
 =?utf-8?B?L3cyQVdRZk94djNOQXFBcXdpb240b0ZqNE5JazhrajM0MEVWQldmb2hBdnR5?=
 =?utf-8?B?ZmhOaXFOci9pQVVQT08rZzJhTnE2UlcvclhzUDRmTlFUemJWU24vcmlCZWMr?=
 =?utf-8?B?UFJKOHlSL1BYaXhXZTNFUkttcm95TitTb2Nyd2JRVXBiWG9JTmVrZisxZFhm?=
 =?utf-8?B?bko0SGplVHczT1g2OWRsWlBzbEUzZWR3VDF3UDNCQU5XaUpmMzlGdGVicFhF?=
 =?utf-8?B?MGVFVXN0bG9IYlFBWEU0S2I2L2pBYXpleEJOM2ZHUCs2TU1UQW9EODI4djVO?=
 =?utf-8?B?emNBOW1pOEJGNlVtN2VsVSt3MjYrbTJLRXhNVEpIamxUTlg3bFBLUmxYbTh1?=
 =?utf-8?B?Wk9USjE2dXBCYnhkNHZJM252V05zRzBpYVlROEpvQXFBL0o1anR5YitOWm9D?=
 =?utf-8?B?SkpuZ3BaeERtcElMRzdVRDExUytSekt0MWpHOXRPNld5aXUvU1BhYTBYTlZH?=
 =?utf-8?B?dER3akpQa3BRaTVNR2QxZWxMZWp5VlBpd1NaNDJNTXhuMXFQQWs4YzdHQ24x?=
 =?utf-8?B?Vko5cDhBV3BLd0ZKeG4vUi9UMlRLVkdFWFd4MG53bWtaOWQ3TkhjeEFGSmlt?=
 =?utf-8?B?emFNeVppL2Z2ZXZyREJpQkhiVkRMUEVxYXhYQUpiVzhFK01raWFTSWd6SlVS?=
 =?utf-8?B?UTJmdXFnOXVuQ0YxWnZYbitmS3BCYStzUndZQ1dySDJwQWRzVkYvaktpaTNV?=
 =?utf-8?B?NjBjODYwTDdpTE81SVIyM0JXVGF2VjdsS25KOG45SnpncVliMjBHd3AvV3hl?=
 =?utf-8?B?eVZhdzlLbXJvN3RSeXQ0aEsyVFBEeWJVRWhRWTdVYnprN0JOYWM2UWlmSTNy?=
 =?utf-8?B?YnAwNWg3NTcrSm5rY29OMkkvc1A5WTNJS2RFT3JDZE5lNTNrZkY5My9DV1RZ?=
 =?utf-8?B?MXAzRVo5bXI5UytUUmdhRkhJbkRDRmJYSVJUWFArNnFsS3h3OURxeWUvVEJV?=
 =?utf-8?B?U3JNMGNTTHhKREdGY0lwUHQyVWVJSHh1QVhmcDNRc0kyMFd6TGZjTm9ZOW1C?=
 =?utf-8?B?OWc3VUZZU01UNlRJS0l6eEpPaGI0UEt1bTd6QXdrdG83WTJ0UmcreFB2dXly?=
 =?utf-8?B?UXVDYzN2NkphUmpvZUJLMnNXMFFFYWNteWtNWDIrSEsyenhIVWtqTExGeWhU?=
 =?utf-8?B?cFlGclJyUUdxTkpYSnN5Y3ZHM3BrcmpIQ2VRcmpNV1pLMjFQQ3lnK0xJMTRN?=
 =?utf-8?Q?yhpaiSEAd5xy6P9w/w2Sb1bBR3K5ZlUcUPcBkq3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cd76ab-2439-4b29-b4eb-08dc3766df6c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:36:55.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6749

On 2/27/2024 2:53 PM, Krzysztof Kozlowski wrote:
> On 27/02/2024 02:51, Yang Xiwen wrote:
>> On 2/26/2024 3:55 PM, Krzysztof Kozlowski wrote:
>>> On 22/02/2024 13:43, Yang Xiwen via B4 Relay wrote:
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> The only documented SoC Hi3516DV300 does not receive any updates from 8
>>>> years ago. With the recent driver changes, it unlikely works for this
>>>> SoC anymore. Remove the binding for this SoC.
>>>>
>>>> Also it's hard to get the version number and it's unknown how the
>>>> version can be used. Remove them until it's really needed.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>>  drivers/net/ethernet/hisilicon/hisi_femac.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
>>>> index eab91e011d11..9466ca9da2bb 100644
>>>> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
>>>> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
>>>> @@ -990,9 +990,7 @@ static int hisi_femac_drv_resume(struct platform_device *pdev)
>>>>  #endif
>>>>  
>>>>  static const struct of_device_id hisi_femac_match[] = {
>>>> -	{.compatible = "hisilicon,hisi-femac-v1",},
>>>> -	{.compatible = "hisilicon,hisi-femac-v2",},
>>>> -	{.compatible = "hisilicon,hi3516cv300-femac",},
>>>> +	{.compatible = "hisilicon,hisi-femac",},
>>>
>>> What is happening here? Removal could be justified, but then order of
>>> your patches is totally wrong. But that hisi-femac is a no-go or provide
>>> proper rationale.
>>
>> I don't understand exactly... In dts, we commonly have a SoC specific
>> compatible string first, generic compatible string the second. e.g.
>>
>> compatible = "hisilicon,hi3798mv200-perictrl", "syscon", "simple-mfd".
> 
> There is no generic compatible here. hi3798mv200 is soc.
> 
>>
>> So i think this is recommended. Or does it mean we only need them in
> 
> It is allowed for certain cases and recommended for even fewer ones. Do
> you want to say you have fully discoverable features here and you do not
> need any properties? Or you want to say that all possible hardware will
> have exactly the same programming interface (registers etc)?

Of course not. Take FEMAC for example. The FEMAC core on Hi3516 and
Hi3798 can programmed in the same way. They use the same
resources(resets and clocks). Though still a bit different in hardware,
basically the fifo depth etc..

Hi3516 FEMAC is not special enough to have a new compatible string, nor
do hi3798 FEMAC. Nor do i think we need those undocumented version
numbers, i.e. "hisilicon,hisi-femac-v1/2". As i observed, this driver is
generic enough to handle all the FEMAC cores i know, no matter which
version nor which SoC. This can also be concluded from the driver, the
driver defined 3 compatibles but they are all treated the same.

Should I remove all of them, and only leave a generic
"hisilicon,hisi-femac" instead?
> 
> Best regards,
> Krzysztof
> 

-- 
Best regards,
Yang Xiwen


