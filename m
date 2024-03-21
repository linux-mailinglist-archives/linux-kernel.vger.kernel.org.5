Return-Path: <linux-kernel+bounces-110579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D68860DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1DF1F23327
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B769133997;
	Thu, 21 Mar 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="eePb8MhT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2100.outbound.protection.outlook.com [40.107.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB775CB5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711048090; cv=fail; b=NkvcUQBoH6LFjnamm9VLA8TEX8HfpI7XFp7XL5HFI+ppaMgJNXEZWrIL2iqvHsm+VWvKJ35JOC1StO4Dgyap5dGg07+1H3/3dLCQjahmPNtAFptL02cHEYCCDhtRRMCi4eDra/6zLiQwBqPfhHI9g41soT+3D9fbsyzwlGVVYm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711048090; c=relaxed/simple;
	bh=JFXYIsg3dmuywERTEkCsqANPj9TRu16MIEUWpZYJOEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DlPpGilmLroq3ILzrk1IrJZNSSKgu1LKBa1oC9xkWl4/A3bl7d2aUg9GldpRhwfaQzC+jqEqd76CUGQ5U4Qdsf8jj3s7FNytiUq4jl42CUlwJnoG+jJtgCgtdBwgxgtv8nzMNR2JR0fu2nzStEWRALvChyzv+1F7hMO2+vENmM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=eePb8MhT; arc=fail smtp.client-ip=40.107.93.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzoZRne/F0zKtHxzrA9ItNIa/bw5k8L/lQC3wTUVwMwq1b8O7JxNX3AGW8XxEaobxvL21g0Jm3ZcPEeO9vp2fy8TXuUZq1tjV46Zv23VTPZ+NIi5cmcLyxHwouQnfN26Stn4RPpqNuXhy2XjrMhkRFdrEzMW7b8O95OT8VW8e5zVbgNvH5ALLHg9jPG1xZkDDo7RKcnMJVswhkiW5Pyrct54LDpPr6Z6TUd6g5ULkWhN0r3rADswsLjtt9HdDJnDq6ljwmM1bCZJ5Yv2wk4C9IuT6qDW63JNxswtxXVIduLV6k50vRLZ6XJODKWaUfk6WgBoYJO23od8VSUUel28gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoApNzr/LQq5DDBgX9rakpL9wg7ul2g+0pvEW5GgUFA=;
 b=Pym9s+spD9hDpnXRUnZffAM4Kzz+f01FvOnT8Nop4uZ8uEMuCektAVZmWYISngWMzjNzEaiFn8kLX5j2+fZafR8s8SIZNTOOXIXXFmznhWx0rMLjG+7AXHeZQ7dL/uJ06vDHG77vc/C+Dcj2cbB0QEIMwcQ6jKk9d7jqrcQC9QZFv4gQC5EvGi+/uq5VTfa5JwKNhDON3Mp7M0cuNM+BrD4cF+6Bw8iN9KyPpR3WFpaGPgtjejfkkYYI6XyBVv8Rb+Q9eH4lA8EN72S0m4vj3h+WLXCUkmyA4nbCE0XveQutD0UF6E4S6xEMLMndO/29ULbtdJUmgWqyoMd2poGFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoApNzr/LQq5DDBgX9rakpL9wg7ul2g+0pvEW5GgUFA=;
 b=eePb8MhTC5/N4Ap8G8cAlGJNY22Ql8N1yCrey/tIY9DqcxxKGQIQUl+3rfwfE41PKmCa1kpiOQ4+fUyu7uOMnwq4xWRPEPoSvfw6sgAFvQbRcrqpve7NgqAL2hxIXcDxbqS0Arg+TGP6W1MzwyiJJfwI2L/ULJDqtnurB4/0zWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by PH0PR17MB5487.namprd17.prod.outlook.com (2603:10b6:510:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 19:08:04 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 19:08:04 +0000
Message-ID: <c2df31dc-185f-4bd1-9e58-b32e024241c3@memverge.com>
Date: Thu, 21 Mar 2024 12:08:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kpageflags: respect folio head-page flag placement
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gregory.price@memverge.com, wangkefeng.wang@huawei.com,
 akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
 naoya.horiguchi@linux.dev
References: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>
 <Zfs33TNtHvnjDX3J@casper.infradead.org>
 <c1425f97-0d9b-441e-a06b-ea00d75a2e73@memverge.com>
 <ZfxaZa8f0UUY0dCZ@casper.infradead.org>
Content-Language: en-US
From: Svetly Todorov <svetly.todorov@memverge.com>
In-Reply-To: <ZfxaZa8f0UUY0dCZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To IA0PR17MB6347.namprd17.prod.outlook.com
 (2603:10b6:208:435::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR17MB6347:EE_|PH0PR17MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 70203356-ed13-4153-8118-08dc49da3c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PWu4AilVmTqYpzCpbbnFjn7NgkAx0MLc93cfNE01RHDRtjxqt8WutDSUnaNueEZb3yGJ4/hKCO5Iwr9F+aDJNFa4tTculvc89ge/h35svGEP3tucwIfbI7gbQY3Aq8i58FeghNUyfjLfxFL/5HwJlMTEIc1HhOAo/cLWhFbj0W9tby+OGykCS4QGoOI3rS+xft3ECSfH5U9aUQeidRjO2Yv/4zKRcTqiE5wkDhqEPoROgRkM7bsBRsN1Bf2wXgcGiGM/HtQLYvQC43Wtl4lCVKv7sbs4Qh4Iy+J8YCFm3y/9x99wjhFqCz5xbfdhLoz9OFRTStAPg+SQJhQN5RfNMfF63UDGmkE5kovDBipLLfmcwSr0cKREI304pr1m46Ovq/QUAJ4hHhkYnTK/U+6TEkE9ViAbkaM7kqzCpHbPWec8nWa1nOJd0Jq13MM1L7kwqi+BGgs6X8CUkATbAK3WfZ4BrsJfdGbU2Er0taEtN0TCRV5aOks/HlHETyvLcsdTX0r6f59B0bPIlK0Dg6Eg04MZ/Ywj2qKOWcPOCxJmybLq0+AgytbYz1k44HdWPQo+u3ayDNJ0WwFxiAp/g8evcPjzLVSPdkyi7H8XHbOCq+y9UkA85zhe+BG2iF5/7AiwjpjOSs5LGhLP7+vo21mm8M9M8IeDP2le56IW8ElELqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TENkWEhoZVh0bkJxL2p2MXpkL3NkdldZY2swanJLQXBvQStRMGFLVmtCNThT?=
 =?utf-8?B?RGZPM0hpc1BmZ3poeTJUVmpxTlNUWTEwV0tKN0Vzcm5XdnVRWkVhK2ZHTnEr?=
 =?utf-8?B?UGJHbmJiZEY3eDI0ZGhyZ1ZFV3JzOFdVbEE0WjBQcUZIb3dtRVk5SXg5QU5x?=
 =?utf-8?B?eS9vTk04OTB1T1VUTUdYSzB5WHkxNGtlbE40Wk1TcXh0V1V0OCtnY2x4aWRE?=
 =?utf-8?B?S2h0MFlMUzBIVVhuQ2U5Q05hOUNyZFcybTIxY2IzVVlZRWVuWWVhaWxZbGtF?=
 =?utf-8?B?ZWdSVGJwVGJIb3dnVXlrYUZ1ckpKRGN1Z2d3b2ljTEZOT0p2MVpSVnJRencz?=
 =?utf-8?B?V2hEdjJLMmkxbmtmZkhjYWhidnVyc3NKYkdIbyt3Uk5BMy8wdm5BZE1UVm9M?=
 =?utf-8?B?V0pUcDJVNFhrL3NuNXgrNGwzZGNicER4b2s1NjRreERYMkQySUZGcDJ5OEpT?=
 =?utf-8?B?eHUzTXdRSkYvWE9kc1hCKzBGMHUyZ0FFYUNyTHd1TjZabXJHbnp0U09pM3I0?=
 =?utf-8?B?djZxSk5WM2ZucUZ0a2QvZDUybUcycElwL2dCTkFOMnU1cVl0YkFXVVQ3L3Vz?=
 =?utf-8?B?emdDOThTdUlMR1ZTU2N4Uzl0eEV5MUEwSkYwamxJeVZqczVsWU5YMGl1VGRM?=
 =?utf-8?B?emw1RXFpdXFYdXlPdTlaWUlkV0RoMTUzL1c1dGUyM2dJTFpjVkpXdlhaelBI?=
 =?utf-8?B?dTRxVm9qSHNBNEUvR2hLcElLR1dGaXdldjh4L0dlOEFhbkN4bm9INStyU2pI?=
 =?utf-8?B?dzFvS1ZNS2dxUVRRdDN4Y05CQ3BEWmloQjJrTHJ3MDdvLzZQaGdSU3ZEclMz?=
 =?utf-8?B?NFJDTDljTjBmZjdxejZnL3lSeEl1ME9PTE0ybnNKL0IzajI5VDNncUFqVUhF?=
 =?utf-8?B?Z1grbXQ0UjRKTFF0R3YvMEFsakgvZDM4dStaaitHTEpJSGtldWlReW95bU4z?=
 =?utf-8?B?UFFJdUs0cHlWUVVocCswaE5ycE9tOUtSREhWRklWMS9OS0lzNll4Y3hxQURt?=
 =?utf-8?B?VHVlWW9vTkYyWUVKQnFQa0dGREtsZS95eis0TzVoRG0wOUlwOXg2RkhTM1Qr?=
 =?utf-8?B?MXZvQW51ZzJPZkVYYzBkQVNpS29ONE9zZE1QMGpWbXFrRDc2cHFtTk82MzdX?=
 =?utf-8?B?ODh6bFYvbktVMzFtbkxycXgyR3pSVUpRZXNtNEJTVzl5NUtIYmtTeHV0dHV2?=
 =?utf-8?B?eTZYQVpYQys3QXN6MVlEZGpCNVhOcVdrb1pQTHdUOTRQWjdIUUx2UGRwcllY?=
 =?utf-8?B?REN4UENKbXlWTkdGc1kzUlduSWh3Rjlmb0EwUTF1QTU4RVNBT3Z5NVNDUHJn?=
 =?utf-8?B?MVA4MEJidWhVK203OFNaMDVLWkJMZlRxMmFUSktXbXJ1OXdRa0kzYXZzMkN2?=
 =?utf-8?B?NzJwRjZIaWl5Y2ozTnJ6YTQycEdZdUFnZW1ZVE1xOWI5RE9mUElCVVlCN0Vl?=
 =?utf-8?B?QnhSZkY2ZW5jeVVxK290VHcwTjZrRHhGZ015QVQ4MnBqbXJidWx6V1FLYVJ4?=
 =?utf-8?B?cmczT2x4L2pDSFk5N3dSUWJCdGo2Zk1VMUpFa05kTlVKeG83TzNOODdNTFAz?=
 =?utf-8?B?blRZU01BbTVTZjZzMnBlclVrQzI4T0t4OGtKUXpEaUZzdHE1c0VMZkppMVlK?=
 =?utf-8?B?TUp2NEg4RWtUSFVoekNQK2FFYmdGdE1HMGR3c3hMZ3JqRVIvU2F1M1ArU0Rl?=
 =?utf-8?B?M284RDdSUXBtVnI1aUt0b3prdnJHdmRMNWZVbXZPc1hWSk92UG5CbDVSNmdQ?=
 =?utf-8?B?dHZkQ1AvNDA1bExrM0wyOVhlMUZ2b01Od0llT0YvMXZNK3EvT0didUVhN2ZE?=
 =?utf-8?B?NkwvNXFTaldSTUVxd1ZrbWFmMFU4TGpyQTdrajIvTmZQTkFwSjMxbmhDNVZ6?=
 =?utf-8?B?U05kOUQranVqQTBybVJSTG5GNzhOYWZ0T0xYZ0hxSUpoWkZyb2cwdTdxYzlm?=
 =?utf-8?B?OHJYUWNyL3FEbTRMQWFsaVFjOUwyZm95RnhPWVBVK2pyaDhuZVZkbFB0a3lJ?=
 =?utf-8?B?VDN5MnhmR2grZ3BDWHlmeVpMRnpzUi82Y1lMOTZRKzZFcHZiaExNNHFzU0dN?=
 =?utf-8?B?Yi9Ncjh1d0RubHBGcUt3ejNVbFNRcm5TVk92eVFJYkN4M1hPQVFzV21oTWpC?=
 =?utf-8?B?ZUdiMVJLdTRqT3puRXdFcTlSM2hnNDZBcGg4Rnl0RnZOMy9iM3g0aHp0aW9B?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70203356-ed13-4153-8118-08dc49da3c21
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 19:08:04.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSAdq+MY8Do9tPQE8otrFjo/R6D8fK5wjPFEvgkuNPA7uFZD2oZb405FM3qJKCYsOCxBG8yls2ttfYk7X1uzqoH1OUK8a4vdRbVl59RtMpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5487

> Thanks for your careful review.
No problem!! It's a valuable learning experience for me.

>>> -	if (PageKsm(page))
>>> +	if (mapping & PAGE_MAPPING_KSM)
>>>    		u |= 1 << KPF_KSM;
>> This might need an #ifdef?
>> Say mapping is movable and anon -- then (mapping & PAGE_MAPPING_KSM) is
>> true. Before, we called PageKsm, which falls through to a PG_ksm check.
>> If !CONFIG_KSM then that flag is always false. But now, we're liable to
>> report KPF_KSM even if !CONFIG_KSM.
> 
> I'm not sure where you see a PG_ksm check:
> 
> static __always_inline bool folio_test_ksm(const struct folio *folio)
> {
>          return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
>                                  PAGE_MAPPING_KSM;
> }
> 
> static __always_inline bool PageKsm(const struct page *page)
> {
>          return folio_test_ksm(page_folio(page));
> }
My bad. What I meant was, if CONFIG_KSM is undefined, then

 > #ifdef CONFIG_KSM
 > ...
 > static __always_inline bool PageKsm(struct page *page)
 > {
 > 	return folio_test_ksm(page_folio(page));
 > }

will fall through to

 > # else
 > TESTPAGEFLAG_FALSE(Ksm, ksm)
 > #endif

And you're right -- there is no PG_ksm comparison --
but the autogenerated PageKsm will always return false:

 > #define TESTPAGEFLAG_FALSE(uname, lname) \
 > ...
 > static inline int Page##uname(const struct page *page)
 > {
 > 	return 0;
 > }

But given your comments below, I'm realizing this isn't as important
as I thought it was.

> There's no such thing as a movable anon page -- the two bits in the
> bottom of the mapping pointer mean:
> 
> 00	file (or NULL)
> 01	anon
> 10	movable
> 11	KSM
> 
> Perhaps it might be clearer to say that anon pages are inherently
> movable; the movable type really means that the reset of the mapping
> pointer refers to a movable_operations instead of a mapping or anon_vma.
I see. I misunderstood how the flags are applied.
I thought that 11 == (01 | 10) -- i.e. that KSM was an intersection of
MOVABLE and ANON. But they're more like mutually-exclusive states. And
I doubt that a page will end up in the KSM "state" if CONFIG_KSM is
disabled. So we don't need to rely on PageKsm() for the CONFIG_KSM
check.

That said, won't

	if (mapping & PAGE_MAPPING_KSM)

return true even if a mapping is ANON (01) or MOVABLE (10)
but not KSM (11)? Shouldn't this at least be

	if (mapping & PAGE_MAPPING_KSM == PAGE_MAPPING_KSM)

?

>>>    	/*
>>>    	 * compound pages: export both head/tail info
>>>    	 * they together define a compound page's start/end pos and order
>>>    	 */
>>> -	if (PageHead(page))
>>> -		u |= 1 << KPF_COMPOUND_HEAD;
>>> -	if (PageTail(page))
>>> +	if (page == &folio->page)
>>> +		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
>>> +	else
>>>    		u |= 1 << KPF_COMPOUND_TAIL;
>> This makes sense but it'd require changes to the documentation.
>> I ran a python3 memhog to see if anonymous pages are currently reported
>> as COMPOUND_HEAD or COMPOUND_TAIL and it seems to be a no on both.
>> But with this, I think every pfn will have one of the two set.
>> Unless you can have a page outside of a folio -- not sure.
> 
> I see your confusion.  We have three cases; head, tail and neither
> (obviously a page is never both head & tail).  If a page is neither,
> it's order-0 and it is the only page in the folio.  So we handle head
> or neither in the first leg of the 'if' where we set KPF_COMPOUND_HEAD
> if PG_head is set, and tail in the 'else' leg.

Dumb mistake on my part. For some reason, I thought that every
folio->page had its PG_head set.

> It's not so much the performance as it is the atomicity.  I'm doing my
> best to get an atomic snapshot of the flags and report a consistent
> state, even if it might be stale by the time the user sees it.
I see. That makes sense.

Cool! Thanks for bearing with me. Beyond the KSM stuff, my only
hangup is that this patch doesn't account for the handful of
remaining per-page flags (KPF_HWPOISON, KPF_ARCH_*). Should I
take this diff, tack those on in a second commit, and then put
up a v4? Forgive me, I'm very green to the kernel dev process...

