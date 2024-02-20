Return-Path: <linux-kernel+bounces-72302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79585B1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4441C210D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494C453819;
	Tue, 20 Feb 2024 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="nPEr/vON"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7E64437C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401618; cv=fail; b=mCNKYsMmMzpomEB1z3ck3tahbR6eHMt/UXjCxtZQoAFMw00y7Q1t0iCFWgjapQkazZZAlqKTr9z1cjToUB+DCSENhfla87fC+YrbUnrPfleWkUWSkQOWIj9u1aUYju7D3+cYYtndouZtMpOxelkeFrKkWFzjuMbFfZICSZSCeb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401618; c=relaxed/simple;
	bh=Yh6jkcOKAeb2Gk3jMQOmEbGmZZOzzOCo2Bebi05Zc5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGzUMMJY/MgoIgryEXCgHSgmdWHBA9CCPEAV9ExBiiCoYRaIab05SpRFyoHB/mqtzDg/pZ29TWnNZGC/5PwVtOZ5/frUp+S8/PrfnRM0vz5h59XMUWWKeh0AMoMw2loe8aKH7M9eac04ESQQtT1a9Y5YdG1ZDGScdKqJaVDfEDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=nPEr/vON; arc=fail smtp.client-ip=40.107.117.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxEYc71h7eNC4DCClq0GrsA8NUr6FYrR9/HbwrI06Y6sVD7YkIdxJz3YtYpwvch5F8DE/vV2wYv/mK2VxN24v07XR+EkFdxBiFdNAemSeG0K0dsdnwb3hgc5ScuSUVUOlacGN0epMZ1RAliJtNmfvs/z6oYJuiXQ59v8HLFIePgGpS//kXAb19fkjieohmo8lm85H0uAZTaZ9MQYttGUDMOtjRn3/YytlHHf5kYubwYvyNbdfVKnibTi+U6zjgrClLZLIkvdC3HbDEXJoMdLKYyal14kBqtwg97h+85IxR6SpuY2N8P1848ZVRe9CLIQq+S/qJLYSOiNniSHnnAcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3OQKt9I6YAkIi2/lGRdBcCDqR/3NIVmqYvuwwXhLDY=;
 b=NQdHf1Nyyl8c0fa3d7xx4dx+akVcFCx5O4BMWmtTiiNefcaP7kj+qr8oPPgNvpYtl2NbeR6Yj8S5P9jtqPpe2YTxAiSKpWC8RBOFlZybfB89PnN1io30QB+DBQR0up/rlj20wLsaAbuWgZAJfAZPbV6Bav8qLf/lpoeZ2Jui1HbSbw8p1PKJfylej4FEsZhiJaHuf5TAqWYcH2CJzjV1ixZmc+MtS+Smt2xRu9kWILSAnekH7TBMwcef/NpknorlPnMBhVLdKtmdcabPX+lxkUDIKDv811NDH7Npr8u588sF3ZV9EtLE2SNVskPAZsmPt7Q2NWr0fT+5uuvQiquezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3OQKt9I6YAkIi2/lGRdBcCDqR/3NIVmqYvuwwXhLDY=;
 b=nPEr/vONPQ2t4iih0SxHtILLxtWRbitXJh5PwGn069IA460SnQDMnvJTYLrI7oMtCqfy8fSkLNuPflar98wiet5/8T3VJltDpybBnfFqchnyLyRXbgi5HdNIBiu94hNZd/oHQ5//dmBVKynHc18VcYS8c6GALXR61zKgXtO0vd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
 by TYZPR02MB6936.apcprd02.prod.outlook.com (2603:1096:405:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 04:00:11 +0000
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8]) by SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 04:00:09 +0000
Message-ID: <8ea640a1-fc2c-a6fa-cf4b-bb8c0b694b4f@oppo.com>
Date: Tue, 20 Feb 2024 12:00:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] mm/rmap: support folio_referenced to control if
 try_lock in rmap_walk
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 tkjos@google.com, surenb@google.com, gregkh@google.com, v-songbaohua@oppo.com
References: <20240219141703.3851-1-lipeifeng@oppo.com>
 <20240219141703.3851-2-lipeifeng@oppo.com>
 <7c648dac-3198-3dba-0a96-34798cfdbd99@oppo.com>
 <CAGsJ_4xPDUgcYxNu230QC--ZiKV71nJJ+v0LVR7yF1io+TiLdA@mail.gmail.com>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <CAGsJ_4xPDUgcYxNu230QC--ZiKV71nJJ+v0LVR7yF1io+TiLdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:54::22) To SI2PR02MB5612.apcprd02.prod.outlook.com
 (2603:1096:4:1ab::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5612:EE_|TYZPR02MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e6245c-89e4-4237-f34a-08dc31c86dd3
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q+xuXlTjHqOmZI6AaT91BKIN4JcwH6aJN1yC/KbwN50IUksbJ8yYZ0I5znePRVW/cZ9vfeS/BM9b1/A3mcEHoS+Pmy4CrypG2ufrhu0elGMU84pSWVw1/RE6Oha4O77Z5CoLFzuG0+NLkj3LB9KiHZrm1euYClyJexI5xX/SdnawZEeVgmu9x48HAPgqAap1A8tDfAeBCdPA/3Sl+aKIFaIPj9hRHS2KMXK9E83qa+2bIlOlN/t1mLaXn/Vqeup/8fjo5dVZJ5eRDCeNomC76WCj0vAxT46/UTsnIjUHTWszYI+8N2l5CFIxMZCSzcVVhEA5/ZZbG9HWjJiFVh3R9kt2L8/O382rNAjQcNexNFaWVls+ypkK+fIcoY2zykT1cNohWdjDRgzmQHDDwW6NVcOPYzuen3zWOgmHYx+6P0p1mzj/01MxWfYcZKNR2jy/xQO/JANsiDLdZLgh7Lm3Fpgv5I+r2hA54Np2hWljSrdFg4YviAnBCxMYktFazJ548GOrVjeLNJ2i0aboVv0R5TBv9oPqre84+iv7CGSj8TE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5612.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTlBTU5UdEhVVEdycklyYzQrMDNYWUJkNFhMN1doREtuNm1Fb2N0cFhIc1l2?=
 =?utf-8?B?Q0huYW4rQjRaT1VFcXl1T2JKciszbGlpajVpTlh5cTRuOXpuSmtUSFIvRStD?=
 =?utf-8?B?V1lZTE9ZbFpHanphUUFkZGxmN0FVNklmWW9tbmN3dUZWOWlwb21DOFh4MEli?=
 =?utf-8?B?SFZEVGxOSERZMjlsdkhqYkJzSUN5d2Uzd0l6Q0pUS2dIbGZGeXNyRENTRHdV?=
 =?utf-8?B?eHppVzZrelhyZjdxTzUzSGlRVFhOd0YwaGNOc2MzN09Ib2ZrT3FQM2hiVzFw?=
 =?utf-8?B?M3RYY0pTbUZxajMzdmFBY3NGREdhMnJRL2hwUjNmMmFqT3JRUHRESGhnYVJ3?=
 =?utf-8?B?THNwOUhVYjZzMG9sU3owN3RJaUtsV085dzZUN3BHSXF0Z2tKeXZvWU92VlFM?=
 =?utf-8?B?aHZ6S1daQk1CbHJJK2FpMDYzVXY0VFlhQkpacFYzTHdFQVErdlVIMmhvczMy?=
 =?utf-8?B?ZU5kS2dsU2hVUllKN3I1R3h4SkVSQ201OENpeVVhQ3VReVJsNDd0ai9mdnUw?=
 =?utf-8?B?ZlR0bWdkWEcvdGJzcW14cmVrb0tWL1pRM0NKc204YmU3QjR1dUxXTm9NNG8y?=
 =?utf-8?B?bVkyS0M4UFZSTkF4Z2ZsU2hOZlUwQXlCaEhGWldtM0FmeHYrblUya3RjakFh?=
 =?utf-8?B?YUZOYzFuY04rRmdhT3hVcHlZblAwQndaVzJXaDl1NkFSSFhmUGtpZXhnVGY5?=
 =?utf-8?B?OWczK2RYNGpFcFljZTNaODhlOTZqRDc0aGk5ZkxrU2orZTRHSDZYQ0RSZTM0?=
 =?utf-8?B?VlJmZnhMdXBjendVTjlrbFVxRmlrMTdIenhCTzBJVlNQRFZjeWp5V3NBNDJz?=
 =?utf-8?B?bEdWZXk4ZzJUVnNTWmd3VjFUekp6MmYzY04wdTNzU3FSZUdPR2VRMVRpQ0Ey?=
 =?utf-8?B?YUU4RXF5VXZuRkNHb2JxMU82ejhDaFN3L1dicWRhbWxIcGZPMjNTaUlzR0I3?=
 =?utf-8?B?RkQxR3pWdXRibXkvSFNDenJ4ekdYR1RiR1gxUzlGd2ZSQjA3bFhqQkdaOEM5?=
 =?utf-8?B?ZTY1OWVxOExycTBSMWJRTjBSbGEzV3dTU1RRbEtmcFZFbGhlMWV4WXRxZm9u?=
 =?utf-8?B?VXh6Z0RFNDJDakJ1WElDNmVNeEhBYVRVSUM4djFGWmFNZEc1NTdRYzF2YlhC?=
 =?utf-8?B?YXJYVG1hdk93ekVsa3hmdWlaUWZyQmlSMUlJeTAzcVRPbXNtSjVFNHNuSEVE?=
 =?utf-8?B?cSthcDhpZ1JNeFExSUNQenhIbGUzclcxZW9laWt6eTBlaVFVL1JOcnFNWlBt?=
 =?utf-8?B?aDZ2b2pUYlExK29rVlZIa3FWWllvTkFRT0h6dUJ5NUR1MUZXMHJ5WWV2blpG?=
 =?utf-8?B?Y3l1ZkJDa2IxUi9DbklpS3lvRXoxWk11aExoTlZTRlNJMUFrejRYU2NmdU0w?=
 =?utf-8?B?RGRTY2J5cUp0bzFjTWsyVzZJWU1nbFFqQlVweWtyQXNhcG5jbG90cm5OSTV1?=
 =?utf-8?B?b0tVbnYxTklueTRmeUU1ckUwMUl6S2pvWk81aHBBbk5KL2ZGT1AvZWZWMVdO?=
 =?utf-8?B?clkzMWpncFFkV0pKNXhNRXVKVVNQT2owa1Byd21rM01OQ2pPaHNzb1lIYzJC?=
 =?utf-8?B?VWlMTVJyNk5MWWtXY0t6MklKOTI5L2o5NUcvcmM2T2JsWEtZcGJPOVRxRWRW?=
 =?utf-8?B?bTlpUVUwMkZWMnpPMFRCNEt1N0YzaEIxdjhGcGc1dlZsLzBlRmpmLytvUUw1?=
 =?utf-8?B?dll2TDZ3cnVJWTNhSEJPQzJKZVdJS3ZZck9Ic01XYVJlL2dWaXc5WU8vQVJn?=
 =?utf-8?B?R3p0V0VZci9UdHlVQldHWWxRV3RCdEJyUERIa0gyZ2RKVkFXRnJlSnpYN2FS?=
 =?utf-8?B?bVQvZ25XRDNxODkzQVN3RXEvR2hrTkJkRGgrYzhxL29qbVVzQncwM3V0ZzhD?=
 =?utf-8?B?d2I3MTlNb2wrazNNWDlzWmo3MysvNkJJcFpGcUFSd1FPVDI2S0c5UzJFNlhF?=
 =?utf-8?B?ajFsZDl1QUN1dGtvSjlhcEtwUTMvaEowRG9QYk9hM3VXVnllYlIyTm1LTnc1?=
 =?utf-8?B?ZnUwY2pjKzFYRFZrM1RNVGhCQU41dnhVcDVJcWN3Z1NzNzJ6WTFDMWZCc1Zt?=
 =?utf-8?B?NGpzQmN3VjhKQ0d1R3M5SmVJQzRzZ0VUQnZRNVRHMTFFNmhBQmEzdFozT3Mz?=
 =?utf-8?B?KytJZ2cxTFp1bFNXVHllamJpQUZKOFhvaFRkdmZDVlBzS2o2QVRoclUyYnh2?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e6245c-89e4-4237-f34a-08dc31c86dd3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5612.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 04:00:09.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdfj07lJBwcqCdRv8WSRwHHx7YKfsCW6h40BYbt3bW6reer/dr1PxBnFX+j2CzRlvWplqwt1KRa42bMRm2wA/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6936


在 2024/2/20 11:01, Barry Song 写道:
> Hi peifeng,
>
> On Tue, Feb 20, 2024 at 2:43 PM 李培锋 <lipeifeng@oppo.com> wrote:
>> add more experts from Linux and Google.
>>
>>
>> 在 2024/2/19 22:17, lipeifeng@oppo.com 写道:
>>> From: lipeifeng <lipeifeng@oppo.com>
>>>
>>> The patch to support folio_referenced to control the bevavior
>>> of walk_rmap, which for some thread to hold the lock in rmap_walk
>>> instead of try_lock when using folio_referenced.
> please describe what problem the patch is trying to address,
> and why this modification is needed in commit message.

Hi Barry：

1. the patch is one of the kshrinkd series patches.

2. it is to support folio_referenced to control the bevavior of walk_rmap,

kshrinkd would call folio_referenced through shrink_folio_list but it 
doesn't

want to try_lock in rmap_walk during folio_referenced.


> btw, who is set rw_try_lock to 0, what is the benefit?

Actually, the current situation is that only shrink_folio_list will set 
try_lock to 1，

while others will be set to 0 that it would wait for rwsem-lock if 
contened in rmap_walk.


>
>>> Signed-off-by: lipeifeng <lipeifeng@oppo.com>
>>> ---
>>>    include/linux/rmap.h |  5 +++--
>>>    mm/rmap.c            |  5 +++--
>>>    mm/vmscan.c          | 16 ++++++++++++++--
>>>    3 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index b7944a8..846b261 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -623,7 +623,8 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
>>>     * Called from mm/vmscan.c to handle paging out
>>>     */
>>>    int folio_referenced(struct folio *, int is_locked,
>>> -                     struct mem_cgroup *memcg, unsigned long *vm_flags);
>>> +                     struct mem_cgroup *memcg, unsigned long *vm_flags,
>>> +                     unsigned int rw_try_lock);
>>>
>>>    void try_to_migrate(struct folio *folio, enum ttu_flags flags);
>>>    void try_to_unmap(struct folio *, enum ttu_flags flags);
>>> @@ -739,7 +740,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>>>
>>>    static inline int folio_referenced(struct folio *folio, int is_locked,
>>>                                  struct mem_cgroup *memcg,
>>> -                               unsigned long *vm_flags)
>>> +                               unsigned long *vm_flags, unsigned int rw_try_lock)
>>>    {
>>>        *vm_flags = 0;
>>>        return 0;
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index f5d43ed..15d1fba 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -952,6 +952,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
>>>     * @is_locked: Caller holds lock on the folio.
>>>     * @memcg: target memory cgroup
>>>     * @vm_flags: A combination of all the vma->vm_flags which referenced the folio.
>>> + * @rw_try_lock: if try_lock in rmap_walk
>>>     *
>>>     * Quick test_and_clear_referenced for all mappings of a folio,
>>>     *
>>> @@ -959,7 +960,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
>>>     * the function bailed out due to rmap lock contention.
>>>     */
>>>    int folio_referenced(struct folio *folio, int is_locked,
>>> -                  struct mem_cgroup *memcg, unsigned long *vm_flags)
>>> +                  struct mem_cgroup *memcg, unsigned long *vm_flags, unsigned int rw_try_lock)
>>>    {
>>>        int we_locked = 0;
>>>        struct folio_referenced_arg pra = {
>>> @@ -970,7 +971,7 @@ int folio_referenced(struct folio *folio, int is_locked,
>>>                .rmap_one = folio_referenced_one,
>>>                .arg = (void *)&pra,
>>>                .anon_lock = folio_lock_anon_vma_read,
>>> -             .try_lock = true,
>>> +             .try_lock = rw_try_lock ? true : false,
>>>                .invalid_vma = invalid_folio_referenced_vma,
>>>        };
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 4f9c854..0296d48 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -136,6 +136,9 @@ struct scan_control {
>>>        /* Always discard instead of demoting to lower tier memory */
>>>        unsigned int no_demotion:1;
>>>
>>> +     /* if try_lock in rmap_walk */
>>> +     unsigned int rw_try_lock:1;
>>> +
>>>        /* Allocation order */
>>>        s8 order;
>>>
>>> @@ -827,7 +830,7 @@ static enum folio_references folio_check_references(struct folio *folio,
>>>        unsigned long vm_flags;
>>>
>>>        referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
>>> -                                        &vm_flags);
>>> +                                        &vm_flags, sc->rw_try_lock);
>>>        referenced_folio = folio_test_clear_referenced(folio);
>>>
>>>        /*
>>> @@ -1501,6 +1504,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>>>        struct scan_control sc = {
>>>                .gfp_mask = GFP_KERNEL,
>>>                .may_unmap = 1,
>>> +             .rw_try_lock = 1,
>>>        };
>>>        struct reclaim_stat stat;
>>>        unsigned int nr_reclaimed;
>>> @@ -2038,7 +2042,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>>>
>>>                /* Referenced or rmap lock contention: rotate */
>>>                if (folio_referenced(folio, 0, sc->target_mem_cgroup,
>>> -                                  &vm_flags) != 0) {
>>> +                                  &vm_flags, sc->rw_try_lock) != 0) {
>>>                        /*
>>>                         * Identify referenced, file-backed active folios and
>>>                         * give them one more trip around the active list. So
>>> @@ -2096,6 +2100,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>>>                .may_unmap = 1,
>>>                .may_swap = 1,
>>>                .no_demotion = 1,
>>> +             .rw_try_lock = 1,
>>>        };
>>>
>>>        nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
>>> @@ -5442,6 +5447,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>>>                .may_swap = true,
>>>                .reclaim_idx = MAX_NR_ZONES - 1,
>>>                .gfp_mask = GFP_KERNEL,
>>> +             .rw_try_lock = 1,
>>>        };
>>>
>>>        buf = kvmalloc(len + 1, GFP_KERNEL);
>>> @@ -6414,6 +6420,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>>>                .may_writepage = !laptop_mode,
>>>                .may_unmap = 1,
>>>                .may_swap = 1,
>>> +             .rw_try_lock = 1,
>>>        };
>>>
>>>        /*
>>> @@ -6459,6 +6466,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>>>                .may_unmap = 1,
>>>                .reclaim_idx = MAX_NR_ZONES - 1,
>>>                .may_swap = !noswap,
>>> +             .rw_try_lock = 1,
>>>        };
>>>
>>>        WARN_ON_ONCE(!current->reclaim_state);
>>> @@ -6503,6 +6511,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>                .may_unmap = 1,
>>>                .may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>>>                .proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>>> +             .rw_try_lock = 1,
>>>        };
>>>        /*
>>>         * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
>>> @@ -6764,6 +6773,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>>>                .gfp_mask = GFP_KERNEL,
>>>                .order = order,
>>>                .may_unmap = 1,
>>> +             .rw_try_lock = 1,
>>>        };
>>>
>>>        set_task_reclaim_state(current, &sc.reclaim_state);
>>> @@ -7223,6 +7233,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>>>                .may_unmap = 1,
>>>                .may_swap = 1,
>>>                .hibernation_mode = 1,
>>> +             .rw_try_lock = 1,
>>>        };
>>>        struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>>>        unsigned long nr_reclaimed;
>>> @@ -7381,6 +7392,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>>>                .may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>>>                .may_swap = 1,
>>>                .reclaim_idx = gfp_zone(gfp_mask),
>>> +             .rw_try_lock = 1,
>>>        };
>>>        unsigned long pflags;
>>>
> Thanks
> Barry

