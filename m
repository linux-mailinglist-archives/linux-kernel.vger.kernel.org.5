Return-Path: <linux-kernel+bounces-86033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FC86BEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E982288632
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743A036AFF;
	Thu, 29 Feb 2024 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H8KxVPLe"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19012005.outbound.protection.outlook.com [52.103.64.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21251364D2;
	Thu, 29 Feb 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172796; cv=fail; b=sQeegtwSkOwKUJbXE9YMvlmXhTckrx7J6i8s4c+C9kViPjgfiv3wrR2YxZ+d2NeOU+AWrU3p9GELQLnJO5qF75icIavhO2OSa01GrRLPGsiuLMnYF7cJhO24LcM1pDbYw/IQp6jiVnexjKJVzUXhsmrqq0bJuzoifYiR/d7nx48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172796; c=relaxed/simple;
	bh=wbi4srXdKHrjmv14pdnng9DUZlWPOnDlrYoVMA1M4Jo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tSGDMbO01N+RiCkoETxDcaQC8UeKiI4fmz+VRdAiu9IBstCIsp6w/+BfACU41+hFoIyF5yZom+fnrT123KNGAq3qgsOS7gnWAJoQ2xHeQPZhosssqyDsvPcn5i3XinhDDgVRAfbzEJMdXMhEoadgjh9EvuFRIwp7bZsPtxD16Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H8KxVPLe; arc=fail smtp.client-ip=52.103.64.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4vX3Ip5EDSWlYj84GOntbZJQX6dp6ugzohjMcjhcRhvaxnY5itQfa6cToWpvONPzJndyrucQv2LkJ2Y9rAhAy0QE/iekVudrC1w7UMNOrVkMhZEV1J5yP5/Ib/WPWXQVpi/HSoaGLPdJuGuKOwN9S0zNDuF8sDxqBt9F7qPFhkd+152+NcLqHqsAailC3BQZyXmoLJ67nLl5XNQdDSGKv6XF2FNSsXdFwTETSG+u7uw4GgVw1k0nOsqKYZwczoYn9gvgmeNti+RFbCjFUgfstK1y8TqvQLhcY9s9/3hCk6ohBzPzpijyHoYizP/zQkfObcef24g0P1ZAR/8B3GDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqBYaFC5VZzEwZ6JjvrVcXpOLfE04WcvcEvHIG0mrtA=;
 b=BfFRjTgsxyPd6sMOLNH/iFJyT16ViVLBg+yGs2L4y38mDkVDp6X6GQ1Y1L3an0CON6jAHjCbZseg0xtGxs3tBYoLNwlvGFQpCP0mcjOuqWuJ8g0fYJDI+k2Qlbnm17WfrLrIUlCkb+GDuslHddJon0xPn1WS3pO4wJ4yBWYf0ovE5LPmm0T/aZz1O4T3rs8NMOFlqtkZEgcvYbD/u6dBvh/t9yObzCHOTeoq1AQPtXUK5/0P77bGQRHVo4U7u3iq2nHJd8JpTaTJIpThzZwyy01vFeiaxeQsFSChFMq9Bj72sHrnCwEFe14VoijPmkq9TM3ndn6XWR0T5V1/SbLrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqBYaFC5VZzEwZ6JjvrVcXpOLfE04WcvcEvHIG0mrtA=;
 b=H8KxVPLe4Co4rkYnzQBpSsCK3V9hrleLKML93EaBmjKjrcEmrGvMA480ioE0XlYTSw2wVMi6N9nei5Q1SlfnNcRrZNajrcXA8GGkdFgd1Yuxnz8hCBp/rm+17MTmIr2sioGfvfUCtGCa85Mp5vnSbcMtVy1d2TzNGjnIvzCCFTcvZ8ihOAcHx2CiX8q5yzGeKXV6/FU0MwFkHxgclryqPSD3r5SNqtMULaJVzRw8J6gsLHTJl83/B3/VZezdDBO2BZXFoY6NUpCQh67Zi50DcIydbgmyGgUYNjVFyMDnXPBqBqo5GtIlp3Xnch60CDKMwVEi9h5akK+e+5cIdh9RVw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB6874.apcprd06.prod.outlook.com (2603:1096:101:18d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 02:13:10 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 02:13:10 +0000
Message-ID:
 <SEZPR06MB69597E78EA08D5BDF66DBEBC965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 29 Feb 2024 10:13:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clk: set initial best mux parent to current parent
 when determining rate
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240224-mux-v1-1-608cc704ef43@outlook.com>
 <0db752d31016823ccd3799925255a74a.sboyd@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <0db752d31016823ccd3799925255a74a.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [6su2EQ3dWBncFc+3eQ9kVG5T8raO4FBGT4BrUSzE2msZNvijy5tkdg96tPHEN7H9]
X-ClientProxiedBy: KL1P15301CA0063.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::21) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <f6589fbe-a861-47b8-b1cc-221df9be3da3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd0150-c678-4aa2-4290-08dc38cbf98a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tzoF4E5crxx5D+9uCcNWiFgZjadLwxFfixniygDxM18Y76rhcBm0F8w05w6dsg11csde1MQg0WI6+90NnzOc66MWBoUe+1ilbwEpdxnqhdNy8JOlyTExItOavOlX/28qqAIyrKW/9S3QdV2HVZXMOEyHadV7wvtELbAO+sSZG/aMTRIH+LkiCaOuGMEm7WBS+DIGLg9TP4VhbVlaxNbNulmGX4d+9xuURdjXU3iEThkpiKEjMLs0G5A3f/JSJoBgtO2lwI48LpGYd3hsJgBE+qqVZeo9x72q4IieHAILxWB+cZHqysybeKGXX0UwAWG0cP1VRnUy9A3kLGDW+at/4zJJelywQfDRYmU6mdXc1/4Rp5hKzL7kh8DIGuiOfmsesZfg799OnGtTygRGdUZlb1MLZkZUwQnrRPCk70TbtPG/2SwjlZN0KQnJOzh0U+3Ikw0Ei6fFPDj1VUGBhy1nrdExs3P/yqYs/zgTLJwKGKWHsgHJPYdcqhcUtakxKUkXirRnK29fQ6NZ/c9L1MlOoAbd2C3NuCmUzS1kRtFXplBz/ykO/KpRW1oI2Pw56gJSEWyAorrcsHVcrR1YoNrBMkFD6/eJsvLIPZA3weO048ikAXGeqi74U0nwddK3vbl94HytL0topse+5tBFqIFdaht/GgSYL0iMjrcma9qJPdU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDF2TDcxZ2wva1JReE1yQmxvZm5icnBFSmEySllOMFRNVkZzb05SblIxbDNN?=
 =?utf-8?B?czRYMk02Q1hkbUczakYycXllWXRXZ3BVTGpyVTBIb1hQdkoybTVXOE9KTnZP?=
 =?utf-8?B?MlJ2KzNLYWpXblJyMkpPTFg1THpxSzUrcTNmdmIyYnNJODYxM2lOYUZZeGxE?=
 =?utf-8?B?aThFSmNiczA5WjdXQTZWM2NoVDlEZEFEbHVhVzRpRENBUDcyT2xjRGlQcmky?=
 =?utf-8?B?TUVqSWZEbkVKM3NoNnZxaTNnQVI1VXl1NE1UNmtScE9pOEplVnJkWU5vWWtM?=
 =?utf-8?B?ZWdBWUJYZ2pESWgwRHZ1S1hBQ1k3Tk1ObkJ2enNNeHVaWWZFeVpWU0dMWGlq?=
 =?utf-8?B?c2FIazJla2tySXhiaTk3aW9DTGlOQnFkd3J1R3NESjNGb2NRVzB0SGlEMmN3?=
 =?utf-8?B?YkNFc1RsS2hSYzJURVhZS3MrSVorMm9pdHVYVVgyaFlJazk0cWhudmRiangy?=
 =?utf-8?B?NjV1bU1jODV5QTA1c2RUV3RXOENPczFlVjBHZnZHZWdmeE9VTWg2eGxRbS9G?=
 =?utf-8?B?a3VLcVRlMjRBay9zWHZ0MGNMTVg2N1RhQ0VtWmxEbnMwM2gxcVFuc29NajVo?=
 =?utf-8?B?Vm9aUVowK25pbVUveHZGR01wcEhjLzIwVWUyYThyTWthaE0rS1k3V0lIenlF?=
 =?utf-8?B?b1dTZ1I2STM0TjRzbzJCdzYzVnBQdmFpNGhVUDZDZi9pSFBUMWpDeHg3SG1Z?=
 =?utf-8?B?UmRlbjZXNy8veHV0RUZDaU1qaXp5TjNhMHI0OEQ5Rm94ai9vTUx2SFZxTEpI?=
 =?utf-8?B?QkdRWU1vL2I4LzgwaUJ0MGxFUHVtRXJnS3pTem5UY0NDWVM1MDF4MnE5TzJx?=
 =?utf-8?B?bFJ6ZUNUR0RGUTkwRU01NkJqWHIwTWtmd21NNzBsTHVSaW96MHRwT3BwVGdq?=
 =?utf-8?B?bGRrUWhFNmRhMzJrNDdEdW5MNU1CdUlpei9LbkpUUml4Y2ZvUUZDUnpUb3VJ?=
 =?utf-8?B?YTRyOFQ4NlJwMS81VHZMTzBMazdVbkxIZUs3YkQzM3ZpUXBMcHNoaEZ4cWh4?=
 =?utf-8?B?QVJ0bnE4blAzWGY5azlOd0ZacHAvTU95cGQyUnpLaU5ha2RHaUNIM0Z6YTBS?=
 =?utf-8?B?TnZVeFZaMjFqUEwyY2R0TXBYN3JlejZtdFdPNE0zQ3VVVUlDYnFZeGxERWw4?=
 =?utf-8?B?L0ZRNkR6cWl5UVduNmliZWdZK05lRitJQUtsWmJrODBnWmQyUTI4WkYvUmFx?=
 =?utf-8?B?U2k2cFhEazB0S0J2TzZKY3doOVZlWkVjd0lpV1hEdW9FWDdtcUR0TW9GQThw?=
 =?utf-8?B?di9veGpoakovRUxqU1ltdTBoSzdTeXhjN292bE9XNVJvV0xoNjRWRHhVY21x?=
 =?utf-8?B?SnRROVV0eEtUY3dBczU3UGdBQUNOMGw2NVJDQWp1MkxDK3dMZzFadjNxaTkv?=
 =?utf-8?B?anpML1ZhTnFCaWVCNGFLZHJMdFpTZ0FNTEFLWVpMTlg2MUJhQnpkVDNqOFlW?=
 =?utf-8?B?aVNyeG41dzlwS3BadndNZHBUdDhGbWFIVVg2dWxDVlJWRXNZUGdRQ1VWMXEv?=
 =?utf-8?B?MThEakVOMWVwRnIwT3U0amV5QWY3REpPZ2kzTnBGUnFZVUtlVmpzTHRIeTFL?=
 =?utf-8?B?dzBPL1dYSnBzWTZudVVEVHVMc0hHSVk2Nk03WVBSNEswQy81NXdtY2JxOUph?=
 =?utf-8?B?N0JXTzRoSFgzdnYxNzZWTE1jajQ0Q0h6MDEvY2t6WEdsa1pTdTFndEhvWUhs?=
 =?utf-8?B?Tm5RNXhYdStGNWV6ekZOdGFsMXdadzZJOXdZKzg5aElxTjFRNTdCL25kRzFR?=
 =?utf-8?Q?JPcLGSfRfMTfHF9SwpGcCcpGXp0uoJlwB16cF4Z?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd0150-c678-4aa2-4290-08dc38cbf98a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 02:13:09.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6874

On 2/29/2024 9:58 AM, Stephen Boyd wrote:
> Quoting Yang Xiwen via B4 Relay (2024-02-23 09:18:52)
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Originally, the initial clock rate is hardcoded to 0, this can lead to
>> some problem when setting a very small rate with CLK_MUX_ROUND_NEAREST.
> 
> Did you mean CLK_MUX_ROUND_CLOSEST?

You are right :).

> 
>>
>> For example, if the lowest possible rate privided by the mux is 1000Hz,
> 
> s/privided/provided/
> 
>> setting a rate below 500Hz will fail, because no clock can provide a
>> better rate than the non-existant 0. But it should succeed with 1000Hz
>> being set.
>>
>> Setting the initial best parent to current parent could solve this bug
>> very well.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> This is actually a v2 of [1], but seems too simple to have a unittest.
>> It's tested in a mmc host driver.
> 
> It's not too simple for a unittest.
> 
>>
>> [1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@outlook.com/
> 
> In that thread I asked you to please Cc Maxime. Please do that.
> 
>> ---
>>  drivers/clk/clk.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 2253c154a824..d98cebd7ff03 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -649,6 +649,10 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
>>  
>>         /* find the parent that can provide the fastest rate <= rate */
>>         num_parents = core->num_parents;
>> +       if (core->parent) {
>> +               best_parent = core->parent;
>> +               best = clk_core_get_rate_nolock(best_parent);
>> +       }
> 
> Is the problem that we're not using abs_diff()?


No, i think. It has nothing to do with the code here. It's because of
the initial best_parent/best_parent_rate.

> 
> ----8<----
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a3bc7fb90d0f..91023345595f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -542,7 +542,7 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
>  			   unsigned long best, unsigned long flags)
>  {
>  	if (flags & CLK_MUX_ROUND_CLOSEST)
> -		return abs(now - rate) < abs(best - rate);
> +		return abs_diff(now, rate) < abs_diff(best, rate);

Without this patch, the initial `best` rate would be always 0. This is
wrong for most cases, 0Hz might (usually) be unavailable. We should use
a valid rate(i.e. current rate) initially.

>
>  	return now <= rate && now > best;
>  }

-- 
Best regards,
Yang Xiwen


