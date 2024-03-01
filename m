Return-Path: <linux-kernel+bounces-87807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC786D948
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6EC1C22717
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16A38F84;
	Fri,  1 Mar 2024 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OgZOQFO7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2097.outbound.protection.outlook.com [40.92.53.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E82B9C1;
	Fri,  1 Mar 2024 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258321; cv=fail; b=R6HBAWlxlaLWq91OFKOvi9KzbTM3t0T8Ozmm880yCJWUbUaOve906ZBu/V0fjYMeNR6MS0ZYrB/b8CY711ybYwuxMZQibA0WJu6CVVRWLDF3fHcyuzckzleHD/NBT4jt0FcAJdz/0RocSgXvmHOm55Nd/UlcRmLEsuOl0+1CKJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258321; c=relaxed/simple;
	bh=rZvSlYV6HcCtWcv+iwRpKOw3hWixFsUzYHtHHvFWXFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsHCxd92CpeAeWUxUQ9wnzCEyp8oNrtgAUYoG9njWFnCpCJrvNTUpdoJGJtFGP24Ro9BLaNyC9GBhMp2CYz9bLD5go1gKRfNKwYsgX3hOWKHd50RWEDTOPO7mY2qqUWOJNGyhpyKXHSCQc1vyPHT9fTH+91mrZxVej6pAqcX6Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OgZOQFO7; arc=fail smtp.client-ip=40.92.53.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsV5sYPR2D07AfocgZy3a5mHr1A+HCwBvVEpxkB2TkJ7XWH36VkH2xi7D2Vppn6Hg/YW35f+HQJ5w55p4v51SmZ7iauhiTbjKEKU3/xR07ZdvRIL8JnzxwX8hz12hyRkyaKcmUpNwqM86EQSu+NR5wb0s4N1p9xYUmlckFM8CF3kQdeWsNbiS8TDhTkAGQiAHDYcmRPYkcZHcmS0rZsc8P7Enoj98MWQ0uo0GQbGA/uepm3bfiZsRBGE+7QgFRr3a644uudI3nmZVHn1VnYadDPLSneT+IjVmUcLyWWCZzkUbCVC/fc4+Crw0A6/3OtxHE5jO9dYRYxIVdrPucfHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MReEBCaK6j1eAmbr1081BBmobBSTY/ehrHO7J5aa+XA=;
 b=MJOF1LQOohsj4mp7xpPiTGWkZPJTPVgHLgLk41Q6Zl9FqneAL4LDrrrvsmYEWgPO41N3f6PKV6hCTv/3wCiAg4QcAaSUYXfUAL3zXve0CcC66j/SfESZ66DCeTaZKSkKGF2/ICkQr1Ua55vnyeySPMMgolmGX90kYhDSp3esRU/yWYwwOF+mCRMJeJNtEGtTY8/m2Q79ZBkqZBoqavFAgErNmPBFq4JrXTI4AAGyqMG19Kh+INm6pt3Z929yB35BoQUVMuuz30Ns39j9CCuRqVGlRHoa0HPG2NPeQFUG3cHTQEzOuqvgiIipwOSENIV84nfint7vqCyyXmfzlIY3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MReEBCaK6j1eAmbr1081BBmobBSTY/ehrHO7J5aa+XA=;
 b=OgZOQFO7FvtTVMUqWo8a1vBIUfkGpTWVSBYbyg1OzjPhKcg8sUr2y3j0+IaJhK6ZnA8J262dlu9bvNhnLLSwVADa6hY03dptg0TeuKalz8FM+lj+bjZVEpEQL9xFSo50FaHWZam1r/2ZnXTkLdlZ/uUQr9EW8PI1Jdqh/5mFVUjNSctJR39pSa1Zuldj6HrPL/o7Kv+ISp9uWiRnjH6L4Cqd1I/cewptY4xUb2+zFCpzKLRkW9cb8ftS6KfuHNTc49LxVsmH3vqh3VuQOrIMRFD8YEuVW0jAy2q58TLSqAZYEwcDRpf1WrNrjZDs/PxtPLtx8Wfis37c3fo5Ce2NRQ==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB7213.apcprd06.prod.outlook.com (2603:1096:405:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 01:58:35 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 01:58:35 +0000
Message-ID:
 <SEZPR06MB695999603791369002D13378965E2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 1 Mar 2024 09:58:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clk: set initial best mux parent to current parent
 when determining rate
To: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240224-mux-v1-1-608cc704ef43@outlook.com>
 <0db752d31016823ccd3799925255a74a.sboyd@kernel.org>
 <SEZPR06MB69597E78EA08D5BDF66DBEBC965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <f8bcec654f618f8639a882bf70273618.sboyd@kernel.org>
 <SEZPR06MB69598A991B4CCF633E764CE7965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <97787cc46d663b08b2e571841fb1bd6b.sboyd@kernel.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <97787cc46d663b08b2e571841fb1bd6b.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [ZINPAzGLqJcoe2rluRLX+KQJXwIOa9CSuwe3Zzj/m6lSbNkXjbh8frZUxMeuIGd6]
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <3044d405-933b-496c-bf2a-969984b72dfc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cdc4ce-bdfa-44a3-42d4-08dc39931a5b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mQ6lxzUmDOllMtqVqx1HdV/vSHEXiqROTOdNCra5eCmGMYJTOSc4kQsHbcmy0f03imAMgEjrSgcERlj94B/oVt7duGl0xuzTvvGRNtK2Hh/PZ9AlKGTQsn5VWBwL1eLUTKiqbtvUNpbNS1aVl2Nnh7C4b0DhF5nYW+9l6f9dgK7scYP4zlgeHJ7ljmUCRHeumzUsAdgSmZ9x6Lml/OMvundINPvc42rfYQWhv8HMA9xNiev7smSuwHvJZArNeg9ROEArf8BqvGGA6tifBwyfBBxjON0egf3czOjUwE/w3aaKN8jzU/COAShp8TuY4Dun09ey0B+uUuTXlMpXFSuYbYjlQiVvWwivRSuWrHXdyhHlFgEWoKkrXkfwR+EvQMde1AxLyIQkyTHQDPA7rhijzubABwHsYP1aC6DzU+j/8PC3cMgG+6IdWGFhO9vNSYMEjYCvoekq5fKRw40hahZJdy3253qqNDoe5AAiOUEY9I/hrpObfjh2IrTjlAcHPU4/wAoU9icFPLg9FJkvqyBq9I4Np5Zo9Qkp4xTKJanJy55QYHa11fHm9WitAFbjUJ9W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NElkdDVaTk9Ydmg5dGJkdVI1TGY1STJXWk1IU3JMRld5RDZPSjlxQzBnaFNL?=
 =?utf-8?B?SFZxNDhET09Hb1JJVHQ0YVRxWkpzbGtRcFc0SVM3NzQyd3UrOTE4VUo4eUpR?=
 =?utf-8?B?VTNOZVhhWGFyYUFtV0ZjL0NtM0tlRGM2L21EZkI1SUgrVFh5YldhVzdnSGpO?=
 =?utf-8?B?czdtVjhOYm1lVmtUNkxtQVBsOStCVWs1OG9JMVcwUERkWFI3dkdoU2FtQVph?=
 =?utf-8?B?NXdYWmxUZzRTU0YxL0c3bU9vSVg5K1N3M0s1VFYxc1FHbllJTEhyUHE4M0tT?=
 =?utf-8?B?YVRrcmNUM00vMG9oZkE4dTRSTVlJQUNzTDloWTgrcXVHZTJJb2plbiszL3p2?=
 =?utf-8?B?azQwMkE1RHNVSkV0bk0vdUpMVG12TEhOSmh3WUNJdzdXbi9VUU5aVkI3WFU3?=
 =?utf-8?B?WVZCakVtVFZ2UksvM0dxMnp0em9NVStEOHJFK3RmdzBOR2dyaVFjR0FzUllL?=
 =?utf-8?B?UU15SitqQkt6Rit5NDFmaEhJd3Z0OCttQ1FkSitMMFZCUUtCY1ZNbXpjbVdD?=
 =?utf-8?B?K0FNbVpiek1QdisrNkdtdldycEVVQldRQXlVWUZmNUs4NTk1YXNqWStkOW9m?=
 =?utf-8?B?U3UrbGtyTnk2dXNiMGptSW1aVTdGT2hPcWdTWG9kQXRTaWJZRkVXMmZRQWtI?=
 =?utf-8?B?TGpRVTZyZGJIaXk4Z29TRks4VlZVUFVPMHE4SEJyanI2Nm1zMHhWVHMwUE50?=
 =?utf-8?B?d3IrT2Yrb0hyaDBQamJCNlFKd1VnbStvZDF4ZVpOWFNXRXNjUnB6bmFjRDIy?=
 =?utf-8?B?c1B6VERSU1JLSXRqbXB1UmRxZWl3VUVaQlQ5YVlOMVVnOHZzQTRQWjNiMzFT?=
 =?utf-8?B?NEcxVzJXczluakhYSGk0aUtNTVZVaVBuMXJuTkQzangrWmhocWt2M01SNlpZ?=
 =?utf-8?B?MkVTVkdBbkxreHBkL0lBZUh3MDdlMlhQV1czSWg5RXZBMjBpTFNvN0RMcW1B?=
 =?utf-8?B?THVYellkeW5NcGtwVFgvUFd5ZDVFMGF0dS9peWxPbi9GM1UyRzdFcmhZN0o2?=
 =?utf-8?B?c0pnbEcvQ0dWalRVdkpydnYvWU91amFRRWpiTmNNSGo0cU5WdTBMZE5ldk4y?=
 =?utf-8?B?WHF4UURtYTQyVHZvWWZacTRETWZGTFVFdENiYXB3bURmM3VrcDk1SllMTzZO?=
 =?utf-8?B?MmZVb2p6cjZqNlh5d1lnU1hQYUcxdWVGalBKS0pkZEtXcUpEa1JDaVR2ZGtY?=
 =?utf-8?B?MUcvdktXS3pqekZidExVaUpocEs4S2FOZ1NjYVFtcWFkUDVoZDQ0RE92NHFY?=
 =?utf-8?B?UXNsT25sT1JhMlhCVzFIQVQvb1lOWUt3SlpOMXJSUVVsT0NMS2MzYmNuWlZB?=
 =?utf-8?B?bklmODAwL0YrOEFUbTVSQU5Ya3BQTVYzUi9DMWtFQkdQT3RIWW1aTW95anFX?=
 =?utf-8?B?SDZranQ3N0NNOG9sb29XYi9LajQ1NjMySW5aQjhEK0d3ODBOSnd3UElsVGVH?=
 =?utf-8?B?YXh5K0ZYOUd2SkxxN1JXOGJDM3EyQnl1cWlhbEtYSytaclI0ZjdJYkhlZkZL?=
 =?utf-8?B?QS9ISGJnQXBMQi9Ra1huZUpGQURLTWRZUXZQZ2dBYlF3VlQ2dkxQU0IxS1FO?=
 =?utf-8?B?cjdHYUlEM3pjdUh6d2FVZHBqM1NMOUw5cG40RGxTMHBzcCsxOVBnT1cwQmRT?=
 =?utf-8?B?VkpLY0lQQXFjWDhDZ0R0V2hVeTRsUlNiSys1VEUxcVVaRGlGUFdQN2taWGI5?=
 =?utf-8?B?VGRaTjhRWUw2R2lQZGJuNkEwUWs3VEh1QmJDcmp1OEc4eURYYWk3V1djSVd6?=
 =?utf-8?Q?P/NCRm44CwmfZFxzFkgzM69vkCc1FhJDJT++QtD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cdc4ce-bdfa-44a3-42d4-08dc39931a5b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:58:34.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7213

On 3/1/2024 9:42 AM, Stephen Boyd wrote:
> Quoting Yang Xiwen (2024-02-28 18:33:11)
>> On 2/29/2024 10:25 AM, Stephen Boyd wrote:
>>>>>
>>>>> Is the problem that we're not using abs_diff()?
>>>>
>>>>
>>>> No, i think. It has nothing to do with the code here. It's because of
>>>> the initial best_parent/best_parent_rate.
>>>
>>> Alright.
> 
> I will have to fix this as well in a different patch.
> 
>>>
>>>>
>>>>>
>>>>> ----8<----
>>>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>>>> index a3bc7fb90d0f..91023345595f 100644
>>>>> --- a/drivers/clk/clk.c
>>>>> +++ b/drivers/clk/clk.c
>>>>> @@ -542,7 +542,7 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
>>>>>                          unsigned long best, unsigned long flags)
>>>>>  {
>>>>>       if (flags & CLK_MUX_ROUND_CLOSEST)
>>>>> -             return abs(now - rate) < abs(best - rate);
>>>>> +             return abs_diff(now, rate) < abs_diff(best, rate);
>>>>
>>>> Without this patch, the initial `best` rate would be always 0. This is
>>>> wrong for most cases, 0Hz might (usually) be unavailable. We should use
>>>> a valid rate(i.e. current rate) initially.
>>>
>>> Ok. But you set best to the parent rate. So why not use 'core->rate'
>>> directly as 'best'?
>>
>>
>> I can't remember exactly. I just add this piece of code and found it's
>> working. Is this field already filled prior to setting rate? Anyway,
>> your suggestion is very reasonable. Maybe dear clk maintainers can fix
>> it as i'm not familiar with clk core code.
> 
> Yes the 'struct clk_rate_request' is pre-filled with many details,
> including the rate of the clk and the current parent rate and parent hw
> pointer. I'm pretty sure you're trying to fix this fixme from clk_test.c
> 
> static const struct clk_ops clk_dummy_single_parent_ops = {
> 	/*
> 	 * FIXME: Even though we should probably be able to use
> 	 * __clk_mux_determine_rate() here, if we use it and call
> 	 * clk_round_rate() or clk_set_rate() with a rate lower than
> 	 * what all the parents can provide, it will return -EINVAL.
> 	 *
> 	 * This is due to the fact that it has the undocumented
> 	 * behaviour to always pick up the closest rate higher than the
> 	 * requested rate. If we get something lower, it thus considers
> 	 * that it's not acceptable and will return an error.
> 	 *
> 	 * It's somewhat inconsistent and creates a weird threshold
> 	 * between rates above the parent rate which would be rounded to
> 	 * what the parent can provide, but rates below will simply
> 	 * return an error.
> 	 */

If CLK_MUX_ROUND_CLOSEST is not specified, I think both setting lowest
possible rate and returning -EINVAL are okay, just as documented(It will
ONLY return a rate lower or equal to the rate requested). But if
CLK_MUX_ROUND_CLOSEST is specified, the behavior would be wrong in no doubt.

I don't know which behavior consumers would expect. Maybe some consumer
code has already been relying on this (undocumented) behavior.

This patch indeed also has an influence on clocks without
CLK_MUX_ROUND_CLOSEST. So you are right, I'll have to fix doc for
clk_mux_determine_rate too.

-- 
Best regards,
Yang Xiwen


