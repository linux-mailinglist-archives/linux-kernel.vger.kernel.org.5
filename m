Return-Path: <linux-kernel+bounces-109496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD390881A35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345AF28399F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C38615E;
	Wed, 20 Mar 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="sA9b+3ay"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EAD8613E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978053; cv=fail; b=VNdfz5l8xujLF2t9RI/LU05gHVj7qmdRn8RCdFxSmhrz6k47/KT2XdWA9RC5wtOlMW3HIc8txJ9JKzBfhsDSUFVt32Dd3n+hg62lSZQCWgP79Xl5oCMbBdHeB/KgYAjTt+bEHO8SKGuQZ5aL15blmMwmfVmPnjoKhhccaWwzydw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978053; c=relaxed/simple;
	bh=rJaFbxQIuGgTyDmD1cQfHbj1icPahg1FaCHZ4+6SA/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p7YIuLtYBy2BC19IWYMjjN+kQt/poCiidGTePIByuHTgKnlOdZoRU+O7zFi/3MmqSWrFRkfX8yHGJBcDzhc+5eozRZDGCJFp92EGPzWKNvOShLMHDKIFrFaa6ZIXalauRtDENgzsGRBjwIKd8Z/iAx+fjFe1Bi5XAsuV2mUc8DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=sA9b+3ay; arc=fail smtp.client-ip=40.107.243.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZnWvRfoqQKO/jrcHzAPUEpmaBA5+pco3C+170l/bHI6cuasxm8GG17/p3L/7h3HsQziw6AYleXu1ts+1q8fXjkKoTl3CCxdkHMKpg8bx9nSUMddfMfdN2QhnFJZgPaj1Q/6VEH8o6gpFka+aDT2cpyXFx+nnURZaY+4cx9DeDw7xXZU+8EfKpWtvM9RPydyBBMyCIypWDB/6V20UQGGQEKtis6xPNgGaW04rS3Ryrwy7vmU7YP21VOXZWLPaZToUcZew8+OXqoXSGHsUtQM02oYkt6VIIjpkMaQB80eB1gLORhW2RPXKtuoIJAjNxm4yp4aHlR/WVnkglHN5AXc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAfLZYSFziAJ4tIWNa5kaGJvkbyGt4ndz+oOEwGNCh4=;
 b=D0hW+fAOIAJPuQvmRSYNV5wRG2HpDDkXBguEpX0Ryi7fw4jsjyr6HKnJTjAgRdq1ijNzyxDpc2kHH6rcBqKAuVhytlfqAUkwQgUOObrft2YjWj/FZ9nYQDP1ztcGMYyDN+TOl7s6DRjBBzpBC/V0xfkMuNEppTQQXl8tz+kQG5B/Meqt27gLVGRcAbI2HT/3Io7zGxJlwqg25PWe0TfeYm18kZSA3IsOfTOl7ZdRCSidtug/I/4g3pCPRl1E75bTayyHA9dUnIvURBpJIIg4jMTxWIt3eTkXWSm0e0MKvKcQjYSrY51q3y5jCUKqieuL6FqQ5pBnKjUiOvCrny7G8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAfLZYSFziAJ4tIWNa5kaGJvkbyGt4ndz+oOEwGNCh4=;
 b=sA9b+3ay/r7vg7qOUZEJ0lvbz5BWOpEO1ixxKvbZaW0pBMOgtcVgMPnPVzEJmiRDSBTTBeUe1UVcCDXS3uHi0pSx+ONPPbzkvRtCRqRG79b+la93ia1RoTLrM+Euoosnb0YiZT4x2s98Y+ti7pPT4xmc/SV5ByNHA+vO1+mmJpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by MN2PR17MB3902.namprd17.prod.outlook.com (2603:10b6:208:208::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 23:40:47 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 23:40:47 +0000
Message-ID: <c1425f97-0d9b-441e-a06b-ea00d75a2e73@memverge.com>
Date: Wed, 20 Mar 2024 16:40:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kpageflags: respect folio head-page flag placement
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gregory.price@memverge.com, wangkefeng.wang@huawei.com,
 akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
 naoya.horiguchi@linux.dev
References: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>
 <Zfs33TNtHvnjDX3J@casper.infradead.org>
Content-Language: en-US
From: Svetly Todorov <svetly.todorov@memverge.com>
In-Reply-To: <Zfs33TNtHvnjDX3J@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To IA0PR17MB6347.namprd17.prod.outlook.com
 (2603:10b6:208:435::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR17MB6347:EE_|MN2PR17MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec94c30-c025-4df9-1fdd-08dc49372afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9DlikLOszMpvKWSQmfGhR+fMweMxTQGhW7OT+wjntJEuKr0rPP2w5xpRM8fVPl7R/D5vTzrbJy93FpVVlFwxzwizHT3cDTFsMxHx+4AUtBPMwPAZmiC+8l/2lfOFYAfbwubTii4ZxNPbS3pN48a+Id5GnaXWXbNlvG177VUqu3Cl0OTHRPhLw4CeFvEqUtuE0K+vtR88PaPj/iMSQcUl4BrQdlovdl49LS4Y+5O3EFl/reu7Bbm7jqdZrGs5OWj74ooZUN9ZKJU56Mvn2DMI44j0cuPX7XC1A3p5cCB4DjJp7Q5Qc8hfUcYw9iiNOrbJ0slQ72Nr/g2tD8BB62tcCZmfRvgxcBf7SdgMfpitRL4XNT5VZ+w8J/Iq6VxKRSP9Mi2afeuKndqetp8d8FaWcZ5OKU8kP7kunvv16vUS7Qxfyq0FXbBChOvVOY7IREh6Qj10IrOrsKFLM89M7CanvNLZrs066I3GOCJHPsiCURPZQ3zps+xSTXRFLEZE/y8tQ9YjikoN7vlAFw1B3iHXkMWD+VG6Z8vL1ViHTO5USD4dJNSIk/3DBYd9nhf1VZc3scqmKcZhpaDHlD8Af1q4/mXxaf7PzJosbTyGoqBPaLXbpjCI0Kznh/JcTN068xOLx8E2xNb1e1kC/gaGJdutMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGxVdW5renc2YkpDbHRaT3hjZDhtQ2s3NER2OTlSb3IvMXJxSUN2RVBmSlhF?=
 =?utf-8?B?eVBpcWhTN2h3c3Z0VnF3V3NnVzVyNWV0clAydVhYSndWeW9qZ2hTbG9Ea2Iw?=
 =?utf-8?B?anNLU09VcGRJTzhJY3pJeVA5aVdHazVEaDkzbDdZbmVEeEtGcjM4eFBrQ2dx?=
 =?utf-8?B?OFBVTDBxNU5Ma0huWmNIakhOVnNoYno4Nk01SW44cDBlbi9uMFlFM2FDMGs4?=
 =?utf-8?B?MXh6eVN3cnA2ckZJOGQ2MENJSGRXUElmR0IzYkc5SldYdHNQSzErei9mbFRS?=
 =?utf-8?B?b29NMmxYUExXL3Z3bFVYV3gyZnpJcjFjRG15eGkrVm1zR1QwMEJhbmZheVN2?=
 =?utf-8?B?Q2lOaVVTRlNxa3ErK045bEhHOExnUWlpOVJvbldRVzZrMTFHZEcyeS8vU2g3?=
 =?utf-8?B?MWdLTnN5U3lHVWNzelFOSmpzVXV3WWRVTWlTUENKSmZFRjF2eTJGYWZ1M0dy?=
 =?utf-8?B?Yy9JMlRBRTB5ZjNnOTJhbURZSWNxRHlyR2FDbGRpc1g1K0NaaFc4UDllVVVD?=
 =?utf-8?B?TVp3Z0RZMnRRWENDaWZucGR3UUorbjlsVEhYcFJwNWlKVnU4dnZnWTFzczRx?=
 =?utf-8?B?RExWdy9uSHpEWDhtMld4WnNCZmU5VjdSeTRWdmFUTVltWWwxOW5CZXZSdjNw?=
 =?utf-8?B?bmd5QmFoWTcxQ1Q0WEFNalNjdGEydGZzQUpnWEw5amhuYzRvVUhvZkpDbG1G?=
 =?utf-8?B?dkw1ZjhNVDErbEJBU1Y0ZEh0TW9zVmNFM3BDZldxR2ovS0hsZmRPYzZQaUZS?=
 =?utf-8?B?d25NSU1nV2lsSEYvMGtpZnY2NFZNK3Nyd0t2SmM3TERjSTZqdUUyTFVOTnZM?=
 =?utf-8?B?M1RrR2JuaDR1SXg4VWRuOFhxeFQ2Q09DNXlMczgxUDMxL2plaXl2UHp5c0JL?=
 =?utf-8?B?Tndic2VCRmlsY3h2Z0lXdElLSk9mRFZIZUVSQ05xZlpHdkFiYWtVSVlDams1?=
 =?utf-8?B?TllLRHZTeno2N3BtSjZveUVmN3A5ekhHa1hKQThCc2MxSjdnb1hyYW01Z000?=
 =?utf-8?B?Y2toN2FUNCtmWmtqc281clFyZjR3MW8zRWhjMlIyYWR4bDZTdThBMkhBYVMr?=
 =?utf-8?B?UzJaa2k2VWtRVlR4b0w1VHgrZWpnSTFIamY4WS9SSU5Uand6L2lISUF1Q0Iw?=
 =?utf-8?B?YytkTVlPeW1FWFhTK0JGWUpUNUh5K1d3aWcvdVFZMUxqUGlQdmdIZE93NzB1?=
 =?utf-8?B?a003STI1eGRnaWNUVG9xWjBsNmpTSjdvRWhQby9ETnFVMEdUNEloa0tvSjVG?=
 =?utf-8?B?a25ocXh5VXRQMFpFSmtaYW82d1NYMy9ETVhXOXBWNFJRMHc0QkVCSm81RjMz?=
 =?utf-8?B?dGFERnNaeHd1TFRUWDAzQ2RmVHlCZWNTMHdWZjdTUVNMUDFERGI3b29YUUFQ?=
 =?utf-8?B?V2h6NFFTT3NhdmhmdmFYZVZBNFVVQ2pXVURWeGJTaGFsMUl3TjR4TEdOR2tZ?=
 =?utf-8?B?U25sR3E0WFdmaVRrUFQ2V2NvUG80RkxrcmRkS1MxaGVzVVBWemZJcHJJYjd2?=
 =?utf-8?B?TXRMY2NidmV3cjdlT3h6VU1GbTk0TEtYU3VOM3Jjd0gxQjMydnUrZXVmcUg0?=
 =?utf-8?B?RW8zRC9CWHJJM2kyTGZXUW5UR1NXVGlOcytsWm1sQy9kREczQjFXbkNUbFQv?=
 =?utf-8?B?MlErMWxleFR2WHJtaVNxUkROamdIbi9aL0c1Q2k1K2s2ODE2a2RqTDVKeUtw?=
 =?utf-8?B?cHBXNks2VEpWaDNWYzk5OFgzbHliVlk4RUVhQlg5b08wMUEvaFhscHlxMGFV?=
 =?utf-8?B?MHB0ZGw2eGFPMmJnTE9ISThrTHJLMncxSDZHMWhMYTRTL2cvaEI5Z3I3Q1dD?=
 =?utf-8?B?azdKRjV2VnJmdDQ3WjZJb0xXcmd4aHA5dXVJb3FKdEZxb0hOV0ZlUFpuZFVP?=
 =?utf-8?B?TmlZL3FaM1hrL2FqRURqNFExbE5hZzZ5NHdsOEZsYjJLS1JMS3JZOVJzbHRr?=
 =?utf-8?B?M2N0TG93TWpSQ3BkZkthWHZoNjloWkhKV3JDUjlVR3RPWlJCUjNnbWFRVEdz?=
 =?utf-8?B?M2JuU0Fnb0hxWlN5bzNCTk4xVE4rRGVIR2xQcHkvK0JUcU1vRXM2VDhPNjls?=
 =?utf-8?B?OXV1VjMwTFFnSU5zMWFPQ1l0dEdpUm5tUFhwSWJwYWlWUkdIT3BhMkR4aHI1?=
 =?utf-8?B?RnJwLzdrUnFLVjZwdVlsUFdQcTQramxGNVFLT2FFYVkxSE91eFh0L2NWMWlm?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec94c30-c025-4df9-1fdd-08dc49372afb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 23:40:47.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Wx/9rUZlp/HIOy5elwhuwcILPEdTHexEmvS1hRXiD2HUPebkF0navoe4KZIIIbk+v04eiYh5x9XONXwi3oIM/KxGyqEIw9wv01Hj2YzQuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3902


Hi Matthew,

> I have a somewhat different patch for this.  Let me know what you think.
> It depends on a few other patches in my tree, so probably won't compile
> for you.
I don't have extensive experience with folios or anything but on the
whole it looks good to me. I like the use of `mapping` to dodge the
compound_head() checks. Beyond that, only a few things caught my eye.

> -	if (PageKsm(page))
> +	if (mapping & PAGE_MAPPING_KSM)
>   		u |= 1 << KPF_KSM;
This might need an #ifdef?
Say mapping is movable and anon -- then (mapping & PAGE_MAPPING_KSM) is
true. Before, we called PageKsm, which falls through to a PG_ksm check.
If !CONFIG_KSM then that flag is always false. But now, we're liable to
report KPF_KSM even if !CONFIG_KSM.

>   	/*
>   	 * compound pages: export both head/tail info
>   	 * they together define a compound page's start/end pos and order
>   	 */
> -	if (PageHead(page))
> -		u |= 1 << KPF_COMPOUND_HEAD;
> -	if (PageTail(page))
> +	if (page == &folio->page)
> +		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
> +	else
>   		u |= 1 << KPF_COMPOUND_TAIL;
This makes sense but it'd require changes to the documentation.
I ran a python3 memhog to see if anonymous pages are currently reported
as COMPOUND_HEAD or COMPOUND_TAIL and it seems to be a no on both.
But with this, I think every pfn will have one of the two set.
Unless you can have a page outside of a folio -- not sure.

Also, in
> -	if (page_is_idle(page))
> +#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
> +	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
> +#else
> +	if (folio_test_idle(folio))
>   		u |= 1 << KPF_IDLE;
> +#endif
> 
and
> -	if (PageSwapCache(page))
> +#define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
> +	if ((k & SWAPCACHE) == SWAPCACHE)
>   		u |= 1 << KPF_SWAPCACHE;
>   	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
it seems to me like the #ifdef/#define could be supplanted by
folio_test_idle and folio_test_swapcache. But I guess those would
require extra folio_flags queries and an #include <page_idle.h>.
So if this is more performant, I can understand the design.

Best,
Svetly

