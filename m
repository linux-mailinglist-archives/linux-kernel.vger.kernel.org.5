Return-Path: <linux-kernel+bounces-73149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331485BE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C689B223B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D576BB20;
	Tue, 20 Feb 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ko5dDD+x"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2071.outbound.protection.outlook.com [40.92.107.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37369D0D;
	Tue, 20 Feb 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438020; cv=fail; b=j4+avhGIYVBUJXFrRJpqlVpIJucD1Qx/VDwxNhPVuZ39WKNjkJlxz5FNYmc83rPa/RTWowRbw19BATVGOEV65fEVjhOKOWVGsfYZj9jxjiQcck3CE+TO5eVdwUKQv0FNBQpTHjaRx70pYWKbTEwMQcI+qQHKQjHHCDgtEpd88ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438020; c=relaxed/simple;
	bh=4mLskrfR+uaiNfeTrMMg5bcnIT4OHOgm1y2941aBHNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sf/cbfqNzdYSiyyBIBg2G+0N49EbrrQuUiBdv6+E0QS668irkDRV56BH5zn0DSalGAG4oSwQf1aXU8yK60xyq53upZ+C8Jz//x+N1GcN7Sv1JwgNCRPX0a4ar7NCM+TxJ5C0Rq0rTPJ9QQS7QDwkxOF7DzrTMthNE8egTpHoeOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ko5dDD+x; arc=fail smtp.client-ip=40.92.107.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8rLCYhv2M0yoTw2zU6eSevhkQEZrtv8dMGKQ8QdrgzSTT6baqK9WdKfKnBe92uwF7yThqqqs2hPtX+bKKgE1GdVnafp+gTWVSjsXNjhHQlYqYFOUpZZjKoSS6zmSTY5u4/yXqAu/6bsnziacuKcGa1rb3g6yYbyuKp3jywasNBp4viZOYagKMOCXbiZwVrTfBn1qqY37l6an5Dnq4WbZPD6vPnj2WbEu/l5MqIvPlvKFePq122j6jqQS6Jnn+ITabSRvknTz5Qy2jJoFavJ4J93MkULTfseHEOnrXcQKNZpnsvcnkEsobd4wF9lM4TGy15bKmJQDf3kumbua5vzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXXWqHHfB/J9gTzI6qfC5SyY8Kcp+ZSokUn6VRBhFUA=;
 b=MnHA+k6qkB1GpfqKsmRLZi6N9Rcr+FeRHBeLkR4XoUtkeGD4JS5sJALO89+++N2GcKDBPcO/LUp6s/KF6D+kwtgWJqaRFP9wVu8tH7glkJRGYTtd5aO1A9HCP1vS0w8GsGClJ+rUC84AOSRs4YNPvYFXkDB8B+KBrWojxjrN6lzkczFFft691N0l5wn8H0ZxMEXwQxlYdn45nLuJsSmewfMt6ndaJI1Y1Bdpok9EHAW82hlMi7HiTLotbBB31/a86D/XS3lnZ7jZxiSCi2bhIyKQD0sPXQZS6BbpiCqiQH7BKBJVHLAFYvMBY3SEFF/0uJ9Bp5w9tbxlln/C9aJ7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXXWqHHfB/J9gTzI6qfC5SyY8Kcp+ZSokUn6VRBhFUA=;
 b=Ko5dDD+xXCKW0CTfUGXtsiDqEgdZD3b5a/5QE+xE9OJn5Ag4Rt7icrR3CDw/1ypZoHDlTX1lN17J6ann1wjgYRYKRcw6oMea0OvNjjvGVe9yapyQ0EBCBkDac3xjpGVBMNqiXYIU5FxkejHJ0LzowO0N9X4sBxgqfKYQOE0gCKbms6/yggvpz3kHJkiZSNNC56X26nfEW5bVh55Dy0sRVE2TbQiSe6Rp+woWP7q83GwLypCm8qAdPfTKcaPj2/Ed7vnQV2B5ZuN2F4TIx9kuaAlQlzwbJFNWaA6NwOKvboRRyHuN9CVwHk7VRJzK9WIAXCf8OybzdbwhlwHFWRTZbg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR0601MB4308.apcprd06.prod.outlook.com (2603:1096:820:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 14:06:51 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 14:06:51 +0000
Message-ID:
 <SEZPR06MB6959456E59D84C15F0C1B88396502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 20 Feb 2024 22:06:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: clock: histb-clock: Add missing
 common clock and Hi3798MV200 specific clock definition
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-1-b782e4eb66f7@outlook.com>
 <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <875b706f-801a-4a4c-8806-411a67c5a5e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [tn8y/u+QRvkIZNpt7l6pj8o2Au1Bn+ProamVa+PVLSRKYBUFms3Ncg7e0t8YKq3P]
X-ClientProxiedBy: TYCP301CA0064.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::16) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <e83e3faf-3ff0-4467-8408-b08e54ac773c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR0601MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cc4acd-8b23-46b4-a279-08dc321d2f5b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RttOD51mK8tJsXHB8WnThFmYIVydte+ExoqjzqZ+5H93lPmY0ydls6MdRHL9qW1nZWRXd5A1MT6W8pFDhoSJHTEii6fdJ/FOYXSzkqcg0wAwJUNrQ27a00qcXfk6Elo2V4hC9zgcCbjtS/Z8MPyXKumSXkbus33ZErr6FzeDuufiQ6ouplk5hqdpJSTmZmUfTSblymkn9Q4ntAF29yq3L8CR56g8rbDFQUJ7v1dWMMG18wTfWnB5Wj6hBKrG1m4qB4ZVu4pznO67se8osrlg36vUXMiq4MWNiR/9xMoND/rmn2SumeWDFdKE2CoR6Tdf5KMLUYTcP5QnX87txIKeTIl/v14ggvRL8kIFb6Q4bduFWWbDxvl54fknL0ucCLn5gzL+oyVnrhuIFTDFAATTFHjx/wdm0PCnngEuoXA1YcAwez5lP7x60Ejfu5xqkLDyxzT3aPTSu1Haw5yvDpHqeWvOVrlp1R/wI0Skc3nlPg9GYirDRWOVQ6TcDD/6LEUhIHBOZdB2eOL1VYYPkcd2DAvsWhXMIAjEVvnTzrPgaIo/PBO/Yqi/z5ITSYJ1qzeZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVJ0MHAzRGh5RmpaNWlIUWs1MmdmYnJHRHNQRkJuTVBFTTMrZkQ4ZzNUd0pt?=
 =?utf-8?B?MlBFdm9TZ0NTWkxEZEdMdXhiRFhlZURLV2E1eThZaGljMWhDajdpT0w4TWR1?=
 =?utf-8?B?TEZPMFA2MFFCWG9LcWpEVEtJM0tCQnFrcVFpYWc2RW1vd3puYnYxRG9Kdis3?=
 =?utf-8?B?WVl2YlVwSW1obmZkQWFkOEJBZVNCQzF2eStOU3ZSRDFvZTBYbmJsektZdUs5?=
 =?utf-8?B?YVUrYXNuRGVoWjRYNnBjZnYwbE94ZFoxTkx2QjB2MzlmZ20rQldIS1I1ZTNu?=
 =?utf-8?B?VFNxRzd2WklYNnR2Uk1iQk02M1FzSi80b1drMFhxR2JyekYvR2E0UlVmaFpz?=
 =?utf-8?B?bWlyd1o3dkZka214c3YzdUlrUWhPQWZ1ZFNYcy9vVzgvb1Bzckx1clNHU3ZH?=
 =?utf-8?B?R2tXOURnSG1uajhyWWE4VU1ud09selZRa09NTFp6cTNaeHJjUUtseTZSTE8x?=
 =?utf-8?B?cDI1d0JzNk1NdVpFVWhHRUljT3o4MSs1T0U3d3RKUWcyM2hDWDA4V3FXd2Nw?=
 =?utf-8?B?VFlmQ2RPNDZkYlp0TjVoSm54ZVZ4amU1ZGZjWm9reDFEdWwyb3pTZUFCSHl0?=
 =?utf-8?B?V0hoMWsyeWFuaGZRS1RoMFY0QWYwakRlT3pTQUI0VTBnRHMvK09LcE1LYVVu?=
 =?utf-8?B?NkxiY0p3Qk5UbkhXYkx5Q0d0MmRpSlhWcWdUOEpGK2RJNEJ0UFRDUGx1UGYw?=
 =?utf-8?B?SlRpWWZvdi9KRU54VVJRM2Y1ajRpTC9wUTlhaEtFRHhXcVU0NFZNU2xjNzdz?=
 =?utf-8?B?NFJrNHIranVOVTFYeXdGRVJBNHNMbkErMWlxYXppVkhiYW5kcHpWZTVLL25u?=
 =?utf-8?B?YlhaUXZselduRnRQV1VCY3JVV2NpVmpwVk80L1pLaHovckt4RUpUS1l2dTNa?=
 =?utf-8?B?a3dHVTloT1ZHZ2JVNmtodm13aFgyb1g0blpiZWtMYURQLzJHZUtoQ3pjODFT?=
 =?utf-8?B?bWdKL29wQUlzRDRTeHBWaFJuVldVbHVtUGlsYkh6TWplakg5WUt4WU0xQlJL?=
 =?utf-8?B?YlJGKzE1WndweE5Jd1FyNmtlRnJaRC9QV0xhMmR3M3FnVW5RWHNGQUgvN3B5?=
 =?utf-8?B?d05SSHgwSXZvTEpDdVVERy9mV0pMSHFNZDc0am1VRDVzTmZXdEl3TVNyNEZm?=
 =?utf-8?B?eFZMWmZ4d3VGOXBoWXBjUmJJLzB1alhjZ1Z6K05Rb21rV05UUHRqMmd6VUps?=
 =?utf-8?B?NVdYOEhQb3lXSUtIeFFWYis3cDkwM284MnRST0ZZd0kwT0E4anJMeExRUjhL?=
 =?utf-8?B?dEhKK0hJYWs2MEdJMndRK0NSV3dqTUZDS3c3aU40WDVXclRTYVNFSGFCNjdY?=
 =?utf-8?B?SFNxK1JROW0ySXZvekF6OVB0SmU1V2hTT1BjNzFkd0F5U29MQ0YyRW5iR0hx?=
 =?utf-8?B?VHhHQU5ZblRkRnc2OHNqaVlLbkFrNE1vdE1MeVpQWCtmMlA2bUxJODBMMVpY?=
 =?utf-8?B?VnJwaWJ0RnBWQml4cEdCcUJKZ3ZMb3hRSVdlb2tIZnFLTEllVGFUZWRpcDhz?=
 =?utf-8?B?dnBieXhNaGpsbXo4bEd2WXlHcGFwZjd3eGo3bHhWWkIvNXJRcjhkRVpNeVNv?=
 =?utf-8?B?UEdOZnRFSXRXUk9LVHVRMHdYVi8vSmF1WnZWNmNXNXA3OUlGM2plckhsZUd4?=
 =?utf-8?B?eDRDN3JUTjlpVnMvTUNxY0p2SCt0NFhFZUNhV2ZzYXlzaTdzb3VwZDJYWG04?=
 =?utf-8?B?aUZUbW5Ba2VGcGVCQWF3NDEyZUpsd3hhLzZlNk4ydTFQU2hDTGZhemhhcE1v?=
 =?utf-8?Q?pMaFGkHSzBHuLPKgFMg9Zuf7KEmU+LsM8b+5nWq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cc4acd-8b23-46b4-a279-08dc321d2f5b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:06:51.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4308

On 2/20/2024 6:10 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> According to the datasheet, some clocks are missing, add their
>> definitions first.
>>
>> Some aliases for hi3798mv200 are also introduced.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   include/dt-bindings/clock/histb-clock.h | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
>> index e64e5770ada6..68a53053586a 100644
>> --- a/include/dt-bindings/clock/histb-clock.h
>> +++ b/include/dt-bindings/clock/histb-clock.h
>> @@ -58,6 +58,27 @@
>>   #define HISTB_USB3_UTMI_CLK1		48
>>   #define HISTB_USB3_PIPE_CLK1		49
>>   #define HISTB_USB3_SUSPEND_CLK1		50
>> +#define HISTB_SDIO1_BIU_CLK		51
>> +#define HISTB_SDIO1_CIU_CLK		52
>> +#define HISTB_SDIO1_DRV_CLK		53
>> +#define HISTB_SDIO1_SAMPLE_CLK		54
>> +#define HISTB_ETH0_PHY_CLK		55
>> +#define HISTB_ETH1_PHY_CLK		56
>> +#define HISTB_WDG0_CLK			57
>> +#define HISTB_USB2_UTMI0_CLK		HISTB_USB2_UTMI_CLK
> Why? It's anyway placed oddly, the entries are ordered by number/value.


So this is somewhat broken at the beginning. It named after 
histb-clock.h but actually they are all clocks for Hi3798CV200 SoC. For 
Hi3798MV200(also a HiSTB SoC), there is one additional UTMI clock.


What solution do you prefer? rename UTMI_CLK to UTMI0_CLK, add UTMI1_CLK 
after it and increment all the indexes after it? Then the diff would be 
very ugly.


>
>> +#define HISTB_USB2_UTMI1_CLK		58
>> +#define HISTB_USB3_REF_CLK		59
>> +#define HISTB_USB3_GM_CLK		60
>> +#define HISTB_USB3_GS_CLK		61
>> +
>> +/* Hi3798MV200 specific clocks */
>> +
>> +// reuse clocks of histb
> Don't mix comment styles.
>
>> +#define HI3798MV200_GMAC_CLK		HISTB_ETH0_MAC_CLK
>> +#define HI3798MV200_GMACIF_CLK		HISTB_ETH0_MACIF_CLK
>> +#define HI3798MV200_FEMAC_CLK		HISTB_ETH1_MAC_CLK
>> +#define HI3798MV200_FEMACIF_CLK		HISTB_ETH1_MACIF_CLK
>> +#define HI3798MV200_FEPHY_CLK		HISTB_ETH1_PHY_CLK
> I don't understand what do you want to achieve here. Clock IDs start
> from 0 or 1.
>
>
>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


