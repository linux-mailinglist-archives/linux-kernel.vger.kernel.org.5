Return-Path: <linux-kernel+bounces-86048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C87386BEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF11E287344
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A78B22325;
	Thu, 29 Feb 2024 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oUvZSpHz"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19012004.outbound.protection.outlook.com [52.103.64.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81E1DDC9;
	Thu, 29 Feb 2024 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174003; cv=fail; b=JKJpvnU7ni53ilSucdSRvNo4zErTBVM5RMq8IDpYHZAEni6OMyFtCd9DKTKwdmdkcAcl6837kCNG8qVbTuezjtcJFD9/udrUNrlAgumuZlNu+LX0yhNnYkH7g+fHHmYO9PWrpoJLuh3SnyLTUYSon98ajNHApqMhccteKt4elBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174003; c=relaxed/simple;
	bh=ffqZ+XsPy8xa/IjLGdxigdwX2aqC0iLxE1MJ7o1jVqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WL5t+3d/OYWsL+zrLHrZdvOkN+QlEBliaQqF8deq9LBl7jnwZx1G/HoW5uNWhIsVKB/rCngFn2UtFb+MFadO7grSoftcDE+dEot5fEB0qNNL5VCBK8KNrbXRgZSnIM/QuQZVAWQD9mTrAqdiiZhyIwZ30kTAFJGW8lEDbanTkwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oUvZSpHz; arc=fail smtp.client-ip=52.103.64.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVnY7HF0mJTsVwelcxfsEoKWGk0Rs+5Pl6MyNBzjDnIUi2/LNsC7AYIsAoLkJeNO1YIL1GOAj/Vg/zSJz1MFXXL2Df3mHlhfNqadRbegwU44/MKo9ZTBRl+YhZnZhqcGeBqrXCaCimDPvI5ib8jzsqkKrXcuUAPQEtGraiFcQ/CN7boF8eKgHydZJ0tfNKd6QvZbCNv+nA2tSLMjqQM7R2FgkNriZxDRtNbC6uYsrRmkUYe8+2Yzg3BMRF8e79zXv8PGX7BWlBo/7AGedGH0+pKBzUuYWtvVZBQ+t2ZB767G+TVuvvS4cRE2pSTism9gZbPZXxUfxO2QHi632iHEag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggTFQEh+XzubuhV2mt5lt91snsAx8xWCdXsVVxEhR/I=;
 b=md9Z+/P9OBDouRuStYxg3arYd455HcQ/wyRfDaocL2MzMYDtkGyHxXMUU200c2EP7slEnJ0TuYq0NHNdtW1GtTopynXflxXWr/0IKhhojEpPbMa9IwiSNwXFOmI8Pp7Emcf07HvY5yOpQyYsR1VHPOl/GTbYI2Zc72RjGmJ9h/OXzS6XaChyrV9asPewqAz3KnWOmPUJPMd++vXwKW9yoGNyB02QZjVYIeBoILMT+nCRVEbwyGwNm+lee7A8Zsg+8Ncw78U4N2Hdanm+SZjcFRliwa9gXEU/XtFv+WSRUAO5Z5yssXwlFg6F6R6keFvG1N1tKMpph1TPM2Juw1dtHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggTFQEh+XzubuhV2mt5lt91snsAx8xWCdXsVVxEhR/I=;
 b=oUvZSpHzMlr/Gvk0CMlDal+ToW4yqy2yT+25q+B9f/bWZan9sjoe2N8Igdi/kZ9SOS52mQYj6DV4K0Agf5uLtz5Yqhhry8mZ6Xs/5XHBpyy1q191jJ+Khtz0lDlKRF4MYRoSo/WptXfs2PEM1FUhfEe2mHsTdSWunKGnBpAcBFNZj4+x/zS/CDStAhItpdbhEnRZQZuXxNS2IjFiNVa/66TqZzb2k316WLOO0x8wl1HjaCc399c7HcyFh9OVxwesz7Nzg/KPtxBKKNaSRl0RnmaosYWvhh1Jgw1mjHJIgH9D0UBId5KMNAYLVL9XJpFfJt2PRCNQLZu0z5vkbxIdAw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEZPR06MB5920.apcprd06.prod.outlook.com (2603:1096:101:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 02:33:16 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::53da:a8a:83cb:b9ad%4]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 02:33:16 +0000
Message-ID:
 <SEZPR06MB69598A991B4CCF633E764CE7965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 29 Feb 2024 10:33:11 +0800
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
 <SEZPR06MB69597E78EA08D5BDF66DBEBC965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <f8bcec654f618f8639a882bf70273618.sboyd@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <f8bcec654f618f8639a882bf70273618.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [PvppSeHBfACu94ZV4QNvvg6z9ENcigJIzXsZ1lV409HXin2ZC/RYvU2u2KQ3iVC/]
X-ClientProxiedBy: KL1PR01CA0099.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::15) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <d3db4190-c1e3-4b58-8376-5fcd10a22035@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEZPR06MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fb2bbb-2439-486b-be6f-08dc38cec8ef
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m/L0h7uDk+v3GJAGbbryFNvWe7SzwN3wqLSr9UkUyAjeOJ4yBRHeVfxGR6YyYhqvSv/Cqso3UvSFmcRR2LwLaCDnOC+ZgpBtE9DlNAwyXmOqZ1td4jxqVbr47YiQiQxOe5yfe23vYX96HpsMdcL/rQD5AyoT/RgKa7hKUIMq+WdJLsdjHYtzZnrRBv09lbFfH7SUjARMPF14MNVmY3QAX1ZKco9/Cf3znULCQ1UIiMGWdU5Q4OcNzwyUUVQfbjGJgmRL5/6L0JH1Bag7syeU5i40FZ9JTNy/lAHFCRakTC6S0JV6lWrVfJmN5hBO2ezVfXFtXRQpXDwsr34McWpiL6sxdmddZZvYgmVBt/IUMHiJim6fUhOhemb2K8Ag/ui3ibpqzyELg8E4WCLUfRM4tKnbOZW52JSA9s+UxW76YZcylPpXN4F4K0eoIjGg/kXSdZ5aJFaQyUQNjc8PTVlUDrI4K0xK7PUyqVeY2bJHyWyU+Cqd4LK6JnCs7o+cZoRNkHajBG/5pdqff71SkQUV0TCmfdDUFpWuW07yF4ZU3NrRfRY4o7FmYELUCp6AaHWOnua4KIS1WsFyU3Gxs+nUo3nAoindHXVI0/XiOcAwqikbNV/sSQcker1ThTMTMxGqs96eTHLPyI2LBHukWXlRjX7e+G8mi737UkS8ZW0djLc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qjdqb1l6ZUFacHdnWFRNYm5VQW1CUU9aa2NVZjJSSnJxRzlvbUpNd1BZQWpS?=
 =?utf-8?B?WjFGV3lyM3Qra24ySGptNDJ4c1VHcmxnZFZOcXZlSUgrTjgrai81UHNwTGpq?=
 =?utf-8?B?OW85My9VUTNrUHRNYWJ1ZGwwS2ZreGtCQmpWUDJ0L2c0RnkyUXplYW90VXF1?=
 =?utf-8?B?R3E3a3lqWTdqYURiMEhJMXVVc0RnQ1JYU3EzSHlWN2lvTlVpbGd4cGxoaExG?=
 =?utf-8?B?Si9MLzdZeUFINHhtTE9kWTYyS0NLcTAyaHhZTG5GQmpobHVoM2k1UXNCZ0Qr?=
 =?utf-8?B?ellHOTRyMzBaRFZpK2Ryc0ZVcDJmL1RxRWtrTW1qaEszdGF1ejU1OFF1eENI?=
 =?utf-8?B?YUU5SXRkY3pUTHBMRHhlb2dXeDFoTVBBS2pVVTdqL3dCZ01FVXhYZTlnNTdk?=
 =?utf-8?B?amhJRWZlSHVIT1JBdWVoWTh4aUx5SmhEVFBibjE3OFZGNHpxT20xUElGbWpm?=
 =?utf-8?B?OWsyWDQ1dVQzU3JKN282NUdMMGhIL3g4UEpVOEVORDNxbkN2Zk15ME9TaldF?=
 =?utf-8?B?S2dPYnJUNVNPN1hkYnpKYWdacUNmLzZENkxpeUVZY2RLVUxHS2hrMC9hMW5J?=
 =?utf-8?B?a2pucHJpY204eDRLY1hOUG9yN0lsdWFZTVNHckh5S3VnbC80UWMrRGg3NFk5?=
 =?utf-8?B?Z2Vrb0F4QU1EUXYva3h0a3BRclB4WmFkMzlOUU5iYWRrTkM4R3NuK0p3cjhl?=
 =?utf-8?B?ZXN0ZTZpSFFsUjU3b0RFQnBiam0zNUhWTUl0dnhDcndGTUtNZGxXRThwMG0z?=
 =?utf-8?B?M21IcXJMY3g5SXcrT3RPNHU2bnljaHBSa2hSL0NwRUY3VGFuQlJzS3RBZ3Nh?=
 =?utf-8?B?U1o1czZZMFd5c2xxdXZUT2ZJekNSOUtHNXBRelN6ZDZvYWhVWm16dVFQN2ht?=
 =?utf-8?B?RXVEc2NQOXhpMm9zblQ5RDdJUDNFakxDZDV1Ty9pRUJ1TGpwR0drYjZNWDAv?=
 =?utf-8?B?TTdYZ0p5UVh2SzdMNkR5MHZJNFd0UzFUU0dtSTFFVDRHMGQ5ZGd6Zjd1cjFl?=
 =?utf-8?B?azNkeUw2RlBKQXZqZWJwSzRHZFordFUwejdBNzI4cWl6bXpMNmVZY0pKRGsr?=
 =?utf-8?B?TWF1cldadVNTYUszMUl2VG01RFcxWDRPK25PWG45a1lSVGN2Zno4MTJCdzhH?=
 =?utf-8?B?bEZzUkFIcys4MFVvVDdHSmN2MUw2RThXZXMxcjF3KzNwd256YnU3S0U0SndJ?=
 =?utf-8?B?djk5NmlpNFh2N1VRR3htZXU1cU5UMFk3MFBZUzRhZmZQbEVnRTNiL0hxTndI?=
 =?utf-8?B?QXR6SWZwVWI4NFRoVEJoMGtBRkx4TDhuWGdFb1M3akhwNzlDZm9PZ3p6NSs4?=
 =?utf-8?B?cFhkZUdicVo2emdkbTdWRU9YL0MvZmxnTmRsTnJ4T3luQWc0aytkZVZJUEhi?=
 =?utf-8?B?RlJlSzRJT2JvMEliUWVnUFVkbzhLd2dBWms3dlFieHNmYVVUd29DelFnWndX?=
 =?utf-8?B?NVRFVmtLM3ZzRE9jL3pRcWVpUGYvS1JOZVhoMjFNQ2UvbkNNRVJsUzJ1cGc1?=
 =?utf-8?B?dkRSZi9VWG9EdUJnVm1zTEdZa3orZy8zWm5iN2ZxS0lveExlWEpqSmk1VWZm?=
 =?utf-8?B?QnVpbnlLeHQvbmNKMnZXZEU4bEZmL3VNcngvN2VGaFlMdEZNVDJnVTg4TGtp?=
 =?utf-8?B?NlpiR25wdjdCYzRyMHpOeGxSZENRczVCRWlTcmFlUS90OG91TzB4anZUMWF1?=
 =?utf-8?B?VytFdHg4b09VQzM2YkdPbEtieUpkM2tLYnRKMy9xc01wYk5KeG5NMkxMcjAv?=
 =?utf-8?Q?pD8ob/d0kDkDeyXOruSAq6yjZ8DfcCMcR3/r/pH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fb2bbb-2439-486b-be6f-08dc38cec8ef
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 02:33:16.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5920

On 2/29/2024 10:25 AM, Stephen Boyd wrote:
> Quoting Yang Xiwen (2024-02-28 18:13:04)
>> On 2/29/2024 9:58 AM, Stephen Boyd wrote:
>>> Quoting Yang Xiwen via B4 Relay (2024-02-23 09:18:52)
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> Originally, the initial clock rate is hardcoded to 0, this can lead to
>>>> some problem when setting a very small rate with CLK_MUX_ROUND_NEAREST.
>>>
>>> Did you mean CLK_MUX_ROUND_CLOSEST?
>>
>> You are right :).
>>
>>>
>>>>
>>>> For example, if the lowest possible rate privided by the mux is 1000Hz,
>>>
>>> s/privided/provided/
>>>
>>>> setting a rate below 500Hz will fail, because no clock can provide a
>>>> better rate than the non-existant 0. But it should succeed with 1000Hz
>>>> being set.
>>>>
>>>> Setting the initial best parent to current parent could solve this bug
>>>> very well.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>> This is actually a v2 of [1], but seems too simple to have a unittest.
>>>> It's tested in a mmc host driver.
>>>
>>> It's not too simple for a unittest.
>>>
>>>>
>>>> [1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@outlook.com/
>>>
>>> In that thread I asked you to please Cc Maxime. Please do that.
>>>
>>>> ---
>>>>  drivers/clk/clk.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>>> index 2253c154a824..d98cebd7ff03 100644
>>>> --- a/drivers/clk/clk.c
>>>> +++ b/drivers/clk/clk.c
>>>> @@ -649,6 +649,10 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
>>>>  
>>>>         /* find the parent that can provide the fastest rate <= rate */
>>>>         num_parents = core->num_parents;
>>>> +       if (core->parent) {
>>>> +               best_parent = core->parent;
>>>> +               best = clk_core_get_rate_nolock(best_parent);
>>>> +       }
>>>
>>> Is the problem that we're not using abs_diff()?
>>
>>
>> No, i think. It has nothing to do with the code here. It's because of
>> the initial best_parent/best_parent_rate.
> 
> Alright.
> 
>>
>>>
>>> ----8<----
>>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>>> index a3bc7fb90d0f..91023345595f 100644
>>> --- a/drivers/clk/clk.c
>>> +++ b/drivers/clk/clk.c
>>> @@ -542,7 +542,7 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
>>>                          unsigned long best, unsigned long flags)
>>>  {
>>>       if (flags & CLK_MUX_ROUND_CLOSEST)
>>> -             return abs(now - rate) < abs(best - rate);
>>> +             return abs_diff(now, rate) < abs_diff(best, rate);
>>
>> Without this patch, the initial `best` rate would be always 0. This is
>> wrong for most cases, 0Hz might (usually) be unavailable. We should use
>> a valid rate(i.e. current rate) initially.
> 
> Ok. But you set best to the parent rate. So why not use 'core->rate'
> directly as 'best'?


I can't remember exactly. I just add this piece of code and found it's
working. Is this field already filled prior to setting rate? Anyway,
your suggestion is very reasonable. Maybe dear clk maintainers can fix
it as i'm not familiar with clk core code.

-- 
Best regards,
Yang Xiwen


