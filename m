Return-Path: <linux-kernel+bounces-143586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC268A3B27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524BD1F233CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6C1CA85;
	Sat, 13 Apr 2024 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="t9PEB40b"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7171C6AF
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712986971; cv=fail; b=kqhpJ6KZ+kwTPuv2YIpvYk7R6oyPO5Qra9DUDPV4diqVdgLgsfuNMpFTPpzN1NYjBYtYJCr5tdhbMOUilO/pieR2IkOBX2tTDTtimQK/EnFyey5Uyxy2zWR5SwkpgBMo08VXxEIlSraqZdejD121kuQpgVHQDDVGECMpF1ZOly4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712986971; c=relaxed/simple;
	bh=piPY1WoJK18eIs0n6ryxVFd+vogiXTJJj3meIE/5v7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QgMhD6VQ3AudpT+x+cQsBfLs2EyrTXLNnQhjdX5W2NoFJOwwnWlqltoEVz49r9NVGXclw8em4WGb/crtrsf2pxggpUqCS4pTyuAj4Nu5MWWz9K8LC2L4+h0YLF7FvM0uPeJn7l1busJU5lf71dXlhaKUJmnNdYfVcPqifiQAOXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=t9PEB40b; arc=fail smtp.client-ip=40.107.255.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBKZmq1LDo5RlhN5zkQOW6TcOLf4UvGBznWYqDwr3cUVsPryt2Gbow7CX4LyU1hvkKoAizSn0tG9X8voPxVCctIeQPhsFoT9mSFZbPmOWNj545uWSRDquwBN3ovyJ5jD8aB0rkpvxWNrAk5v1XGcYdwgkFvmmlotirFKPgBbcuq/REakK4rO+c9nvH9PmSTcoQxlVmSENb6r8lVtM+5QE2i4RXqiSwJN8VfxIvn/Vq3fdDg75R1KS4pjGusbCTTAXJqVUtmAYV9Hc8dWmF7zahsvaLLPOakYNgt34TCRn+CsZqWgjxq6wFy/2U1aDS8a7El9R+suq/HQFhsjHq0apg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55p/7jE+7YwLhD4CQsWzW78rvcJYNnGd5OIEF3ke6Mg=;
 b=FjG1sOdJT3OrZ7M8Zl3A6LjU/jxHG2fhKXyV9U7ncujJPMtfmLncX+DEea5UNABmhRvdLqaHiGYZ58BULsPfmjflXfGdskLx3p80LBsQY26N8jKG8RC0XwN8BIcjen3B0pL4CksZdm3UKkXp64CyusZmXK+ZM8WEOlKz6mwGf1HZNJe3x3LOJ50uHEKuPn0jPC9vLA6tdS6nsaqRfXNIV9H8VUAlZ7izvCIuVyfTRkSNaXiZdmtRox7B/ZVdZ1LeAMedz8lGpI1b47FSMaNsqZorX/CphNZ7P4IVS2aGa4U2Zf4GjZDJzYxczqhqSh9K34Blwsi/wb7rilnKtCzpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55p/7jE+7YwLhD4CQsWzW78rvcJYNnGd5OIEF3ke6Mg=;
 b=t9PEB40bTk3OtUe9lCS7HrjnomBdNYZAk51QNQvdnCpl54CcjpvAaDhanyHxLf6xaJY+MLusWpQg00RWgsSr+0ECt6Z6fbQjdZTIOW/7/MuYOzxlXLYhe4dn62rEeivu/6vFWGpggI/Yt8jMH8Ei61YUbGzMKLt5Me4S82q9DvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SI2PR02MB6117.apcprd02.prod.outlook.com (2603:1096:4:19f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 05:42:43 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%5]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 05:42:43 +0000
Message-ID: <00861870-5c40-4f00-b91f-fc4cfb4a780b@oppo.com>
Date: Sat, 13 Apr 2024 13:42:39 +0800
User-Agent: Mozilla Thunderbird
Reply-To: lipeifeng@oppo.com
Subject: Re: [PATCH v2] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com,
 zhengqi.arch@bytedance.com, roman.gushchin@linux.dev, muchun.song@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240413015410.30951-1-lipeifeng@oppo.com>
 <CAGsJ_4yGTcgMnK_81hMUAL0xG06Nmu0kn3bwdQHhSiDV8HQ+ZA@mail.gmail.com>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <CAGsJ_4yGTcgMnK_81hMUAL0xG06Nmu0kn3bwdQHhSiDV8HQ+ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SI2PR02MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3723653b-5c78-486c-5061-08dc5b7c8a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zejybKupki4C9T7+1bQ7RsKH6Ae0Hb3vbxXAO3qiLVNyg1Hw45w9j+BMwbizPQFVIFB4CR1iYqmm2TLX2OpExtxrOBG2xtax3fpv0x8gPgr4vNHBc5TdDiRtV31Lpoe3mezsnqOpFVXAJ+glkDQg89m+Wl9CjmsK6EvV+gKpfA+OmrMLos5cuhuikRFj0e7CITRzWDplNH1XApaC0I5qf8n4Y0kpMLztgJXEuXOICWxz/XmaRCrGRRxnNTQXf9787QK6oVAJ6ckRlATPiA5PtHT2MDiOlgTH+YWaxawwmlrlocQ+vWKkUIvoXZv9+F8BU2Hdy4kd8EKDNbdw0dhadjSp84jv8lz3t37lnx4r8hMUtVwf2vVCm/wPp8EEmzsYDoUcoIJunajLwSDo8dxopyuHUY5h9AnFdLk4eO8pQjNGyQHZVOgQaGwlgO+4rAMr+y1Z2+b0WXRynxH8gEynenYxAmqfFCJKY6fjz21+YznLU2+uEAi451LFUBDjJRe5cStySbSEBTaGCk2TRJvZwybv0kLpQGBxtBo7l47QQOUJpv4lKQvHa7mRga256dLNGiPc9S3H5YfX3ga2L9lBmptLNjf4Ri1h423rJiKg2cQX5AIltEbq0JVSChV9BUjli1bJBc6naf8k/MqJM4H/tIZddUNUSexAZPwB3RpZqzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2VmZmUvcGlEd0JGT3pDcmxWdGRaT2lDVTVtbzdUZDkvRC9ucnlzeTdzMmF2?=
 =?utf-8?B?NzUzUlJHWEd3aitTR28zSDFLTGFzSFBCR0ZnRnRqNUxtRHRYa3RuR3FNYktm?=
 =?utf-8?B?UmdnN1RkM1FORWxJbGRaTjQxcDROUDlVMzFVcy90WTJJbjVJRWNxdXdTSWNh?=
 =?utf-8?B?QllzenZNN0NnVGRiZFZ0V2w3QVN5U0ZhcERtZGxYdUl1bWJNd1R6N3BsV0wz?=
 =?utf-8?B?Q0tLNXJwcHpNRVZYYkU3Q09ERE4vazhsTTY0ZHI2cVEzUm1DeHQ5a3ZlR1Vv?=
 =?utf-8?B?aU5kMGdjN2ZFL0grTCtxaUxpZnNyNkhXdjJwNUVFN2RDeEkvMlUwRkFxdDFz?=
 =?utf-8?B?ZUZNNjJSMVpobVhkRDcrYkZrOTNPN2ZiTHU4NmtWNG9MeW41bkRRcTl5OE1r?=
 =?utf-8?B?RHZrNER0NVgxdmlxcFpOMnVlYWpiMVkrL2xpRGJRcGlpR1FkRWs1dXJvdFF3?=
 =?utf-8?B?VUh4cUE5R0thaHR0UVl4NnlmdDliQ1k5ZEs4UXFFaWRITE5pNzQwUkYrcWJi?=
 =?utf-8?B?N0lQbWdxME01ZzVjTGVxLzZFMk9tcG1XdmtTSWQ0eHBZYzhTeUlIVlppR2tR?=
 =?utf-8?B?eThUTmlxWjVLTDJlc1VDR21LakxLT0YxRGt0SnhnYjFCbFFxcUNrVWE3MlNo?=
 =?utf-8?B?RlkzNU1vVGtwenZqNHlGZEZaMzVHM3NSYlNMUXdjb0RCdlNBcDh2UTQ1WHAx?=
 =?utf-8?B?U0JRUzRPRHZVd1p1WHhIWTZ3U2Q0cXV5ZEkvTnMyaThVbVU0REZXSlE5QmdJ?=
 =?utf-8?B?SzRGL2x3em5KeE13OEpzUHl3aFpOV3JzS3ZGa3VqVkFtSUwrdlJNRnpSMUlZ?=
 =?utf-8?B?TEVNV1YzZWt2RmpzZ1cvd3ZxVzEyYW9wVW9ueEY0S0Q1S1NzWUJvM3lXVXNQ?=
 =?utf-8?B?KzgzeHJSbS9XRmpBYUN1SWo1MmtzQllzL1lxSDJPZEFTc2NqNWV1a3lXS3lm?=
 =?utf-8?B?TERiNDdpWFB4bGg0TloyaFVFbHdZSEJFbzBzNGJ5SEpXeVhNMDgwMG5EK0Vo?=
 =?utf-8?B?OU1DelgxSVVsQ05pYURIeDBmMVdwZ05NcDl6R1NHNUVncmlRUk4vcmprUVRC?=
 =?utf-8?B?djhLNngzSzV3TTF6U2l0YnR3NHo5RzUvb1k1eVQ1OEF4ZVZBWlU5ckZXOGVj?=
 =?utf-8?B?M2g1YkFacmp3WkZLQW05eXEwbHFxR00vaFlsUVYvTzYxb0xoM004QXBsQUJY?=
 =?utf-8?B?NC9WNHVVbTFVS1dkRlVUcGt6MVZBSGU1bi93SXNxTnJWMHRxVDlJRmpIdjEz?=
 =?utf-8?B?RmJkY2lzL3JnelkvdGlXZDBETDlCV3p4citYZWthcTFsV0NTMzQvNFhDVGd4?=
 =?utf-8?B?a0tMMFZCOUVUVmxlWS9UV3dENWk4OXRSaHAyOVQyUm1FVGdabzNva3BsMEtG?=
 =?utf-8?B?OU9mZ2l5ZjhwWmVDclA2YVU4ajJZdlBoM0w4OGNXTUpmejZ5NjRhbmpUNkp0?=
 =?utf-8?B?SEhIdW1nZDYyVGZGN09xOUhUZ3lFdEUxdmZWZnpMeGVUOFpKUUhwNWwvV3ZS?=
 =?utf-8?B?MTZzckEwVjlnU0N0ZjA5azVRSTJGSXhOT0YzbEttd1kzcFFkeWFaWUtlMHRt?=
 =?utf-8?B?SVRCUUtYc2tZVnRqc2VmTnIvalRwbHlSaEZEVUZ3Rld4Ykl6T00yQlRHODVa?=
 =?utf-8?B?M2E2ajZucEtlS3dTQjRYbkZEbXRNbk5kanJ6SDZqd3JmWms2U2gxR0xvb2pJ?=
 =?utf-8?B?T3pSVEI0RTRFZ1lua2dtdnNtMUhlWWRxTW5DUHc3b1N0cG4wcFlPa1dkdDdk?=
 =?utf-8?B?SG0rNVJWU1UrUjNGZTRacnVSckRVdDRvSmFRRWlQSFN6L29yRG5xY1pHdWIw?=
 =?utf-8?B?U2hjWGl2bENsN3hKdHg2QURPYjNrTkZMVG84ZG1uMzNLaUNEZ0g3L2VUd3VU?=
 =?utf-8?B?L2dQdzJZcXRhZGdFSzNYYm5EaC9QT3ViQ0N6aUxmNk9vZi9ZMjEycjNsdnhh?=
 =?utf-8?B?RStja3FoWWJSZmlGNDRuWmFSYjRuVlQza000NzRsVEtSUkt5MG4vVHNIUElJ?=
 =?utf-8?B?RmdnT3BjZGduVFg0L0JxdVJkQlZiRHIwMGVmN21KcEtwN2p2VXRWMEhhUzJm?=
 =?utf-8?B?am95VGZMSGlkZWREaUkxV096bEwvaGk2MHYyajFPK0xLSHQ4bjB2TUxhY0pG?=
 =?utf-8?Q?AcXSiqNw9DxeeHX1pP6AQACfQ?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3723653b-5c78-486c-5061-08dc5b7c8a06
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 05:42:43.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN1ic1Ywi6e0C96rZRWLM7q1bG7dMuA31ygeNneqz1eFdju6liY9/o90ojDLbYJ7UoNl+TOYUSU20SvyqlOE0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB6117


在 2024/4/13 13:19, Barry Song 写道:
> On Sat, Apr 13, 2024 at 1:54 PM <lipeifeng@oppo.com> wrote:
>> From: Peifeng Li <lipeifeng@oppo.com>
>>
>> In the case of insufficient memory, threads will be in direct_reclaim to
>> reclaim memory, direct_reclaim will call shrink_slab to run sequentially
>> each shrinker callback. If there is a lock-contention in the shrinker
>> callback,such as spinlock,mutex_lock and so on, threads may be likely to
>> be stuck in direct_reclaim for a long time, even if the memfree has reached
>> the high watermarks of the zone, resulting in poor performance of threads.
>>
>> Example 1: shrinker callback may wait for spinlock
>> static unsigned long mb_cache_shrink(struct mb_cache *cache,
>>                                       unsigned long nr_to_scan)
>> {
>>          struct mb_cache_entry *entry;
>>          unsigned long shrunk = 0;
>>
>>          spin_lock(&cache->c_list_lock);
>>          while (nr_to_scan-- && !list_empty(&cache->c_list)) {
>>                  entry = list_first_entry(&cache->c_list,
>>                                           struct mb_cache_entry, e_list);
>>                  if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
>>                      atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
>>                          clear_bit(MBE_REFERENCED_B, &entry->e_flags);
>>                          list_move_tail(&entry->e_list, &cache->c_list);
>>                          continue;
>>                  }
>>                  list_del_init(&entry->e_list);
>>                  cache->c_entry_count--;
>>                  spin_unlock(&cache->c_list_lock);
>>                  __mb_cache_entry_free(cache, entry);
>>                  shrunk++;
>>                  cond_resched();
>>                  spin_lock(&cache->c_list_lock);
>>          }
>>          spin_unlock(&cache->c_list_lock);
>>
>>          return shrunk;
>> }
>> Example 2: shrinker callback may wait for mutex lock
>> static
>> unsigned long kbase_mem_evictable_reclaim_scan_objects(struct shrinker *s,
>>                  struct shrink_control *sc)
>> {
>>          struct kbase_context *kctx;
>>          struct kbase_mem_phy_alloc *alloc;
>>          struct kbase_mem_phy_alloc *tmp;
>>          unsigned long freed = 0;
>>
>>          kctx = container_of(s, struct kbase_context, reclaim);
>>
>>          // MTK add to prevent false alarm
>>          lockdep_off();
>>
>>          mutex_lock(&kctx->jit_evict_lock);
>>
>>          list_for_each_entry_safe(alloc, tmp, &kctx->evict_list, evict_node) {
>>                  int err;
>>
>>                  err = kbase_mem_shrink_gpu_mapping(kctx, alloc->reg,
>>                                  0, alloc->nents);
>>                  if (err != 0) {
>>                          freed = -1;
>>                          goto out_unlock;
>>                  }
>>
>>                  alloc->evicted = alloc->nents;
>>
>>                  kbase_free_phy_pages_helper(alloc, alloc->evicted);
>>                  freed += alloc->evicted;
>>                  list_del_init(&alloc->evict_node);
>>
>>                  kbase_jit_backing_lost(alloc->reg);
>>
>>                  if (freed > sc->nr_to_scan)
>>                          break;
>>          }
>> out_unlock:
>>          mutex_unlock(&kctx->jit_evict_lock);
>>
>>          // MTK add to prevent false alarm
>>          lockdep_on();
>>
>>          return freed;
>> }
>>
>> In mobile-phone,threads are likely to be stuck in shrinker callback during
>> direct_reclaim, with example like the following:
>> <...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
>>                          dynamic_mem_shrink_scan+0x0/0xb8 ... priority 2
>> <...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
>>                          dynamic_mem_shrink_scan+0x0/0xb8 ...
>>
>> For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM that
>> allows driver to set shrinker callback not to be called in direct_reclaim
>> unless sc->priority is 0.
>>
>> The reason why sc->priority=0 allows shrinker callback to be called in
>> direct_reclaim is for two reasons:
>> 1.Always call all shrinker callback in drop_slab that priority is 0.
>> 2.sc->priority is 0 during direct_reclaim, allow direct_reclaim to call
>> shrinker callback, to reclaim memory timely.
>>
>> Note:
>> 1.shrinker_register() default not to set SHRINKER_NO_DIRECT_RECLAIM, to
>> maintain the current behavior of the code.
>> 2.Logic of kswapd and drop_slab to call shrinker callback isn't affected.
>>
>> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
>> ---
>> -v2: fix the commit message
>>   include/linux/shrinker.h |  5 +++++
>>   mm/shrinker.c            | 38 +++++++++++++++++++++++++++++++++++---
>>   2 files changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 1a00be90d93a..2d5a8b3a720b 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -130,6 +130,11 @@ struct shrinker {
>>    * non-MEMCG_AWARE shrinker should not have this flag set.
>>    */
>>   #define SHRINKER_NONSLAB       BIT(4)
>> +/*
>> + * Can shrinker callback be called in direct_relcaim unless
>> + * sc->priority is 0?
>> + */
>> +#define SHRINKER_NO_DIRECT_RECLAIM     BIT(5)
>>
> My point is, drivers won't voluntarily stay unreclaimed during direct
> reclamation. Hence, this approach is unlikely to succeed. Those
> drivers can't be trusted. Had they been aware of their slowness,
> they wouldn't have written code in this manner.

Actually, we hope there is a way for us to solve the block of shrinker 
callback,

Because many drivers can't remove their lock in shrinker callback 
timely, with

the flags, we can tell drivers to add it.

> Detecting problematic driver shrinkers and marking them as skipped
> might prove challenging. I concur with Zhengqi; the priority should
> be fixing the driver whose shrinker is slow. Do you have a list of
> slow drivers?

Most of slow drivers hadn't been upstreamed, so that we can not gather

a list of slow drivers.

I am curious if executing do_shrink_slab() asynchronously could be accepted

in Linux? or executing part of shrinker callbacks asynchronously?

In my mind, if the memory-reclaim-path of the kernel would be affected by

the driver, the robustness of the kernel will be greatly reduced.

>
>
>>   __printf(2, 3)
>>   struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..7a5dffd166cd 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -4,7 +4,7 @@
>>   #include <linux/shrinker.h>
>>   #include <linux/rculist.h>
>>   #include <trace/events/vmscan.h>
>> -
>> +#include <linux/swap.h>
>>   #include "internal.h"
>>
>>   LIST_HEAD(shrinker_list);
>> @@ -544,7 +544,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>                          if (!memcg_kmem_online() &&
>>                              !(shrinker->flags & SHRINKER_NONSLAB))
>>                                  continue;
>> -
>> +                       /*
>> +                        * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
>> +                        * should not be called in direct_reclaim unless priority
>> +                        * is 0.
>> +                        */
>> +                       if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
>> +                                       !current_is_kswapd()) {
>> +                               /*
>> +                                * 1.Always call shrinker callback in drop_slab that
>> +                                * priority is 0.
>> +                                * 2.sc->priority is 0 during direct_reclaim, allow
>> +                                * direct_reclaim to call shrinker callback, to reclaim
>> +                                * memory timely.
>> +                                */
>> +                               if (priority)
>> +                                       continue;
>> +                       }
>>                          ret = do_shrink_slab(&sc, shrinker, priority);
>>                          if (ret == SHRINK_EMPTY) {
>>                                  clear_bit(offset, unit->map);
>> @@ -658,7 +674,23 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>>                          continue;
>>
>>                  rcu_read_unlock();
>> -
>> +               /*
>> +                * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
>> +                * should not be called in direct_reclaim unless priority
>> +                * is 0.
>> +                */
>> +               if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
>> +                               !current_is_kswapd()) {
>> +                       /*
>> +                        * 1.Always call shrinker callback in drop_slab that
>> +                        * priority is 0.
>> +                        * 2.sc->priority is 0 during direct_reclaim, allow
>> +                        * direct_reclaim to call shrinker callback, to reclaim
>> +                        * memory timely.
>> +                        */
>> +                       if (priority)
>> +                               continue;
>> +               }
>>                  ret = do_shrink_slab(&sc, shrinker, priority);
>>                  if (ret == SHRINK_EMPTY)
>>                          ret = 0;
>> --
>> 2.34.1
> Thanks
> Barry

