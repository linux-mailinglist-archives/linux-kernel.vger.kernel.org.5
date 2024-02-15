Return-Path: <linux-kernel+bounces-67383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA86856AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DFE281E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B113666F;
	Thu, 15 Feb 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OxJQGra2"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2104.outbound.protection.outlook.com [40.92.107.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CE135A52;
	Thu, 15 Feb 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017345; cv=fail; b=eL13GM8pQzyoJlI3f3QDHfUePzEl0s+1TsB8V0y4xpuq7wmHvhVaOmG783ktsh1v2mt3SPMO+HBm/d5NsiHBrE7mjkv5xu9i8TphTb16BRTLLv0qC057ez0sdIt6qszNidDVPzzNZCJPSGMmi5mkmbVQF1isrs489mZZxkT8mwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017345; c=relaxed/simple;
	bh=crcDeOOoEqk2i7I9Pq7WZ+//5JuQwOSCtN6OXNJDJ+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pAQ9E2RvIs1Rr4AiCEdLBM+vOWYBmkw/IL7Ga/5zmYx5vFPLXuEpek8dckuQiwzYNC2SrnkzFNUWqnNOZpZesHnatPT7nX4U5i3kzAKaQ7ZcM1+dIs1yu9IaMPfE1LyTyN2iV3glxgJWA/SX7AwZ5yFUAkZugSD2CbzO8dHnAz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OxJQGra2; arc=fail smtp.client-ip=40.92.107.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWNl8aTQqeY5dVCfADxq6KlCx12jtVw9HRx2UkDqRFhkuuFxwsq3lvHYPKMb8Yftavd0grPGVRfsiooNR5ijWOIyKyCpZpO8uss9u0ZloSqJi0AsV+r4TzcGSwLmzMJ8nR8ll42hODWrjMdXV4+1cYU1cLIOXN75Cw/5RGOwvrnELGNGpVP6hgOA1dTnyLHIcMxomczS/SplSkHwoh0iS5NVcHMMeH3JtMY/HRsX3+vfPx7FgZAdg6kVB3Yn7NSW9aJWVHfFlAtbuWKoN9GZsVzKm5N36Y2PrBZxLBwD5xp1jdqmAavEHeNjGIw3/zgLkNQVuUrGTLrfIckEOdrPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFkqC8JTUCBLlUa56w00iClCpmSyB4drjsXuChK63hs=;
 b=ca9P8vTq9mlnGUN9oRh4PBSLNsKF7fEeHQ4cFcuNv6x0/romH0Cmbs9fd+exVdWsGv/O3IdOscMmmq+ZTD66K7VdXrTZBmZCOBC5WGVhlMfIuzuHKji2ABni/ps8P8c8c9usvBnObVw8KhdSWEguTzoQ1H07VYMD0iQN0M5vuX5H159mzNbv5fgxyzjdpv8A1JLXVAK8lKx77i6xaUGbSxhAf53CaCn6/LxMk7JqZbsbhF9ZuqRHBhz4Uk27c+9XaTy7DG/OvItT0UpZrgRZ/0JY4hWDTqd+mTF3keUt64yJOlFP7pTVh5mTcvAtf8qZzKoaIRrRY03gJisSNEHWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFkqC8JTUCBLlUa56w00iClCpmSyB4drjsXuChK63hs=;
 b=OxJQGra2gaLf8KegioUkfSCBOfNHH0GNqt39WOSKXRS2mmNQTrh12AlnMEtKm2f6mooXIPUaqo8Gy1G7qJgTyQL01OOpqXki4PdFxAow1Ln9A7O3R2LPTA2FAud09/HW51+627o8HPi53FLNPq/e4Bs8LDyL5eDxI9WeW8pUKYqwaGtEG6zgsWMCwl+9hQBN+PYA/q/3D+WNA7us0sgqVw7jIxTGJ+bqLw8EmlupX0CYnqKoAypGKXOuNXUee6w0/uev7+121SWQ9ch2Jz2uzLawAauB4ToWFHt3I9EMPGjIgufKDy/9MvGiowDnTEwW9FVi7PEdxbXNkg03jIlSTg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by KL1PR06MB6274.apcprd06.prod.outlook.com (2603:1096:820:e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 17:15:37 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 17:15:37 +0000
Message-ID:
 <SEZPR06MB6959FF28D99A99BA2524C9D4964D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 01:15:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: host: replace 1st argument to struct device * for
 mmc_of_parse_clk_phase()
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20240215-mmc_phase-v1-1-f27644ee13e4@outlook.com>
 <CAPDyKFo9NpKSuBnrcOseuD-jDA64CMyRxpH-OUoozOQDYHj1mQ@mail.gmail.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <CAPDyKFo9NpKSuBnrcOseuD-jDA64CMyRxpH-OUoozOQDYHj1mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [2e+cQSV6Dinn6DBhf4JK/b9w04lGvgZueBsJtAagXI7B9EWrwyOt/5Q+TZ14fplwJt9L4NZMHNU=]
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <61c35aa2-d89f-428e-a865-73ed1fb07649@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|KL1PR06MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ab83b2-1f10-40ee-7710-08dc2e49b9f1
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnrdnmJi087DV7oLZnpyxoFxawPDNQFnd2L1IlM6YZZXbtD7GGnaQ8hykVoPF/f9Yu6ATm3vezIHvVPCUvVJEf2Dr+9Fnwn7Yfo+4d/WFF92yj9zbo2cgVysn912KwgCHFPcQOZfy+9wSNfr1axaeDFn3OeUeoDbDK8b9IrnZTR012vM2KIezcbIN1UUTmXdJv/Q2suONSZESVaItkvfxCb+4pOZGs2KXTKuxT+3qTQ9BXF/nBwsJAdPXOSTic9xahYgWhIModZ2fmrpV2fLHiKYxOChpiUG657t4S8zzIIczKBwMYs0NSIsppVDNiVbhrZ6ts2/lsnXZ6mmTREuaar7OXW33pA/+yvu1lRvrjpJ+AysnSi5c2HdsED3vg5F3TXi7LfFiHTtjEQm6+dPk20BN7Ga4IedAkbWCdLkU7RBdhjktBQpqufMYxSa+xqds7WuFVMC3YFIv0gGBjqY7mPyGVqZJND0g0cyw2Mm5FvG2cgc5Fj9YLo/Gh0//HPIPYvdUUt+AmhraXizbF/oZMwKNfJdzfj6h9qeH/37Aabfj6yIdXkOluUv2HJTfTZCDWtTBrK3JyqKk4UvSskVK+YrSLeZ/JGjNf8V4+kTeCV9Ex8m1kMNA127gtlsOVDoNyIVY1FXnenZbV2zOmupSqmJrqahUvXTvVt3TFy7xwgdTMceZDqs/ZrU1j6zWFEZKUyFKUpujoWgTOZ2Ak9S+sKWKqPTjlgVcVyuH07/j0G0U0Ffmwt9Gs5kRLtihvUDaYg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oVpUh8prVsWGqI+s5e5BcanErItCRSIfZfW+fJ52dynw/UAOEsldmqECN9SePSjbe+qg5Z+p/AEICm3ZCKo5Y1GctQ+RLolbJOJa8tORVJiquX9vCwJAZzhAocycrAWQbjXTV8F6mB0hVX+S/Qajr0rU7iH2woTheUL7GDJJjgUmjweu+moboMFYILsoxRn2VFkxAFsB8xwnzxZBkiuTVflIBw3KV0aSUn/hBC3gkiUq/p/7LfcNp1lqsey9dnMU6e0WKi/ctNdPdM8sTqqj7fO2rMp4JdI/yrHEa/nXZZqU/PaPrWHVrdlCNnq/cuzHWPLfh0i+r7bmheFRju8pXoJ9ghGARdjqH5Eb73l0Z5iA8wqVncZB1o8BWBP2Y50V+AV5/b5OB3MLbxPdWdPd9oggHevuXxDorNZA5xX8gZTiY9mQ2q7P0r8Z61daucGkZjBRNizNSFbURSrK4OxyTev5K/M4IGqrFPcp7SFvKeBx+oLJA86/UyfAAiUAuVrwS5tJQeOMlfscepuPyr3+vylIMUuKejjcbsTIOGB+RSdt8maJuc9SVADmfb+WLDRb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bERRdHluL0pIalVqd1F4NWZZTS9LbTc3T21uRWUzbmdlWG1EdUhDNk5JMUNw?=
 =?utf-8?B?OTdYbHZMcXFhK1RkeFRiMWtTLzU2a2UzMmxKSW9vaHVyWUpJRTVYZWhLM1g4?=
 =?utf-8?B?L0phMGV0TGZiRWxNZzR6aHE5QUhJQXNJVi9lS1lxNDE4am5keGJXbkVWUElL?=
 =?utf-8?B?ZHE0aXR4Q3JDME9MUWIxYm95ZXJ3Y1h0MTJvaHZDRjdaUUtsN1RaQlNnZVVq?=
 =?utf-8?B?NVVzSVV6Q0ZBWjlUQ001SGRoUkZBVHplRmdoVzd1Q2dwdEdHbUJXR0xzRThi?=
 =?utf-8?B?WGpFVkNwNTVXWk85clh1SklrTXZpWmw2R3dUMk5makViL0M3eGxSQmEwella?=
 =?utf-8?B?N2FWMEk0dE81RDhyN00zYWh4SERzeUxITHRCUG9mQkNGcUplRTZTckl3T0dh?=
 =?utf-8?B?MDRwNnd3Smx1YklQMTRKRVRYMHA3RE5jTkNsUXE2VkxCaUpFRCsxdTRiNnFX?=
 =?utf-8?B?S0dzSUl2UTBUNzhyeHROR1dncnpMam1wRDJDODVaa0w1R0w0OFcyRStFeXZF?=
 =?utf-8?B?dC8vU0JCK3Zna3UwOUdGMDIvaWY4cEY1WkFhY2lTMUw4RHhQYUtrMWdRMUdD?=
 =?utf-8?B?a0VMSWQxRlk3SExBZSt6dTJHbkZmV3BnNzVrRGJxblk0bTNNcHE1bElneEdL?=
 =?utf-8?B?NkxRbE5zN3FtU2lsajhrK094aURwcWc5WDRFN2Q4T3F4UUZkU0pmUG51T3Vh?=
 =?utf-8?B?aDVzOXlWNzk5c2dUNW9XdFhZMlF3NFFCNjVqM2xZVFlYWlB5dXhpQVZ5UVph?=
 =?utf-8?B?a0tUaGxhUG1POGhlTU1OS3BEbU1EMjc2c0ZXMDFyeFpJL0ZjNjJxMHYvRjlj?=
 =?utf-8?B?YzJSbVRhOXhkVzROczdhT0lBRTM1N29Kc0FHTmJkS3BVTDZwZnVvQjNLRGh1?=
 =?utf-8?B?S3RxQ1BjVlAxOTM1SmFSQzg4ZDYxakIyVm9VWiswR2ExRE1lSnZpb1ErNXkx?=
 =?utf-8?B?UjVMeXA4cDMzT0lZU2NwSDhxa3kzRll0TlI2UFlhUlpXRjNJSTN4SVBPMUh3?=
 =?utf-8?B?eVFjeE9nZjFkYm05R3FtTVlOSGpKSlVLUkhTZTdKUHhLVFJTb21SOEs3TWJH?=
 =?utf-8?B?ZTErakkxbjVBNVBMNU05NzBGUDZFaVRRRGcwRlYxQ1VRTWZLK2wvYmNvT0dz?=
 =?utf-8?B?Q0xlU3dyZ283ajl3V2dZU2ZSN3g3QStQZmhLamRhR0ZrQm4yY29VMDd2TEE0?=
 =?utf-8?B?ZXp6N3dvM1hoMng5RVJYUldTeWt1MHYzNWd6RHF2eWhqdmVLUE9pSjdaUnUx?=
 =?utf-8?B?RUhVTElwUEp0d1EwQzFqZ1VtRkp4YVZ3WjNQeGE4U2hwMUVBc0tzWHFJb2Zv?=
 =?utf-8?B?alEwSHIrYmgyQityUzVacVpkT0ZwTmFrd2EycllONG52Mk5pL2kxU0pzSENx?=
 =?utf-8?B?SjQ5N3EwQnU0SExmTHpPS0wwWi8waldWRjhqaG9ZNkNhZFpMa1J4VUxqRGN2?=
 =?utf-8?B?Z05SbWY4SWdSZ1NMNkxPMGl6djZCOG1ERkhuYm04N2Q3azNWd1c3bUIvUlJN?=
 =?utf-8?B?MmFWMHkyTTJGeWs4TXZlNlRtMDNqZitvUy9IQWtIQ0JiZ1pBZEhRTmJ2Lzd1?=
 =?utf-8?B?NkFpQVl4UUtkcVB4bGswRXVYV0tDWHJveEFwUzdXZ0cwall6VkpGck15MjVt?=
 =?utf-8?B?NXU5YXJoNWpjd3J0VzZ4UWtTR2VVQXZlL3h3SXRoQXRHYnBQaVd5QmxkUmxG?=
 =?utf-8?B?ejJoaDMrdStZOU1QRUJNNDVXZzBjeFpNK1FHSjl2ZEk3b1dVRG5kMmhEb3Bv?=
 =?utf-8?Q?6E42llNz6bn+MqlFVSskV++tcpW4+FfcI8BfTnI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ab83b2-1f10-40ee-7710-08dc2e49b9f1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:15:36.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6274

On 2/16/2024 12:47 AM, Ulf Hansson wrote:
> On Thu, 15 Feb 2024 at 12:03, Yang Xiwen via B4 Relay
> <devnull+forbidden405.outlook.com@kernel.org> wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Parsing dt usaully happens very early, sometimes even bofore struct
>> mmc_host is allocated (e.g. dw_mci_probe() and dw_mci_parse_dt() in
>> dw_mmc.c). Looking at the source of mmc_of_parse_clk_phase(), it's
>> actually not mandatory to have a initialized mmc_host first, instead we
>> can pass struct device * to it directly.
>>
>> Also fix the only current user (sdhci-of-aspeed.c).
> Is there a problem? I don't see it, can please elaborate.

My pleasure.

Just look into dw_mci_parse_dt() in dw_mmc.c, this function calls 
specific extension's .parse_dt() function. And this function is called 
very early even before struct mmc_host is allocated. Thus it'll be 
impossible to retrieve host->slot->dev right now since host->slot is 
still NULL. As a result, We are unable to call mmc_of_parse_clk_phase() 
in our own .parse_dt() because it needs an initialized struct mmc_host. 
But mmc_of_parse_clk_phase is intended to be invoked there since this is 
where the driver is supposed to parse dt. dw_mci_probe() allocates 
struct mmc_host and calls mmc_of_parse() very late(in 
dw_mci_init_slot()) and provides us no chance to insert our own dt 
parsing extensions after that.

The key is that mmc_of_parse_clk_phase() is a very simple function which 
only extracts a few dt props. It is supposed to be called early in the 
driver before struct mmc_host is allocated. Unlike mmc_of_parse() which 
fills in a lot of fields in struct mmc_host, it does not need this struct.

> Kind regards
> Uffe
>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/mmc/core/host.c            | 4 +---
>>   drivers/mmc/host/sdhci-of-aspeed.c | 2 +-
>>   include/linux/mmc/host.h           | 2 +-
>>   3 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index cf396e8f34e9..8b2844ac5dc5 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -234,10 +234,8 @@ static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
>>   }
>>
>>   void
>> -mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase_map *map)
>> +mmc_of_parse_clk_phase(struct device *dev, struct mmc_clk_phase_map *map)
>>   {
>> -       struct device *dev = host->parent;
>> -
>>          mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
>>                                    &map->phase[MMC_TIMING_LEGACY]);
>>          mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
>> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
>> index 42d54532cabe..430c1f90037b 100644
>> --- a/drivers/mmc/host/sdhci-of-aspeed.c
>> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
>> @@ -435,7 +435,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>>                  goto err_sdhci_add;
>>
>>          if (dev->phase_desc)
>> -               mmc_of_parse_clk_phase(host->mmc, &dev->phase_map);
>> +               mmc_of_parse_clk_phase(&pdev->dev, &dev->phase_map);
>>
>>          ret = sdhci_add_host(host);
>>          if (ret)
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 2f445c651742..5894bf912f7b 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -539,7 +539,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
>>   int mmc_add_host(struct mmc_host *);
>>   void mmc_remove_host(struct mmc_host *);
>>   void mmc_free_host(struct mmc_host *);
>> -void mmc_of_parse_clk_phase(struct mmc_host *host,
>> +void mmc_of_parse_clk_phase(struct device *dev,
>>                              struct mmc_clk_phase_map *map);
>>   int mmc_of_parse(struct mmc_host *host);
>>   int mmc_of_parse_voltage(struct mmc_host *host, u32 *mask);
>>
>> ---
>> base-commit: 9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
>> change-id: 20240215-mmc_phase-26e85511285d
>>
>> Best regards,
>> --
>> Yang Xiwen <forbidden405@outlook.com>
>>

-- 
Regards,
Yang Xiwen


