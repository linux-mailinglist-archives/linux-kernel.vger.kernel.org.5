Return-Path: <linux-kernel+bounces-143493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FE8A3A26
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889D51F228BF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA9810962;
	Sat, 13 Apr 2024 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="IIGLAvDi"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483A101DB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972305; cv=fail; b=nnYwSH3m/zWDfPNx18x/uqkzVWW21c+vrahUPCvwEVOzyAidnF4oe/DJ3WR7aSeffTYVuJxy/XSqD0FPLN4+O6UjjAeupEGWaI85wgUG61Sh65jHsxGcxiEtlTFDUEkkecQo21X4etCeW5dCRmaRapJaZEigKCgkecgON5kBh1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972305; c=relaxed/simple;
	bh=diSnx4hUw/OkiNYrbiCBGlGVcVBKeFeQAzYBjNS4AAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kFxuGETMcU6Yc8CG95RmvSC85lCrR+LXJxmRIbhegXxCvBMuYXNMEZ+/XdPADwmqfq9YlED3k8LZq2XcfEHCTdkqBUr613nWBZwMtz0kpsW63EeQM0IHP/88A6vIWootS83sJgs7ri+vMkEXsa2qNM1RXPE7zgm6Vo94IjMXVGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=IIGLAvDi; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRrI62q9EJ8AQxVGvOLE3IFxBNQZfAa4xjNV4QWkBhJMhC79gW8Y1rw5Mde4VrsFu2fg7H3zSQcAqJpDs9Vk9yWLZzOa1UgWeSpOAHOWp3saUxeIDGoTRXfmI62pJH57lCriIKX69ze0McRXLbpdvIE4KxPsJsQj0L8nfXTVUi9b2AMPXFxGjIsvzEwxu4gdXmlrsPDGB7jUK4n2+YodIMybbUkpINFFy+2bDFfmlPPb/XIMcIWSa6Jf8EIa+SH+w1lX++3LC6n6SK8tElQkTaU2W5su7N7f8c5bqyBM2r4MBFLzxEWe3+VluG6tE+gHFZlUmD6nRMXD/1nWgN4C2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18RviH9HWCxGx3oT8pg2Blte3tv/n+nKMl3ih88tikM=;
 b=LfhyphCjfXdBaq8lduSmZWba/pgScoCCRminqPmgCz5lTxVEO7HH5CsTFpYjnb100qiKVV1QDFuZ30+sNwPQ5XHtuC8A2eHRpydCWFi52MUEyOwJnu6IQ9P3mN9ljelkZJ5h2jT4QPGFnOPp83oA/avkX3N06oF9a6GbkOgW2x5pOfzO0YGEjZW0XVksKyOqzs00+Z1pMeTVHcZTiktHD4m4NXUZTPyM9GmJu2YSB0RCKMlHN7/JZS30EVhI0gKvonyG2Nt4xBgMPuRIoql79ZyMI95butGWeh9ZzGKVjuruZogffpzU1i3kmIttZ8lI0lBGzYUqLiriK/uddDMXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18RviH9HWCxGx3oT8pg2Blte3tv/n+nKMl3ih88tikM=;
 b=IIGLAvDi2ow8umR+Iu0neBARoAXK3USmVb9eJ3AUrp4efW0LVs6WVgoDEGFLaBIoHubxeFQeSNYOGwWXBDSxWL2JHF83nnadOH+vfeDtSGolaiFWJk7oToh8h+7DuLLDCkslV0CkwzIR6/BKkq2VcIZ+J031v3VLIAagedboeXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by TYZPR02MB5867.apcprd02.prod.outlook.com (2603:1096:400:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 13 Apr
 2024 01:38:19 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%5]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 01:38:18 +0000
Message-ID: <ecf21a58-bc2e-444c-bf89-ad3539a9d325@oppo.com>
Date: Sat, 13 Apr 2024 09:38:15 +0800
User-Agent: Mozilla Thunderbird
Reply-To: lipeifeng@oppo.com
Subject: Re: [PATCH] mm/shrinker: add SHRINKER_NO_DIRECT_RECLAIM
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, david@fromorbit.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <21cnbao@gmail.com>
References: <20240412080706.744-1-lipeifeng@oppo.com>
 <d78ec9ea-006a-4317-b0df-99ad31994b0d@bytedance.com>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <d78ec9ea-006a-4317-b0df-99ad31994b0d@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:404:29::19) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|TYZPR02MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d1c27a-72cf-42c6-a7e3-08dc5b5a653f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FWYrx5EPS90jbRUFJ4w1kWx3RBXg7vX4g1KRkOho9BZ5WteD7ZRqCHUhu7nrNYSGIgEtbq6BbUFUGWwDv4mG2cko+gkIDGAc5At0Isuk906w3O7rMFwl2lLJTSU+IpAdHIY6dikh3Pz/ufOvs9qhN7r7Ar6GvZ2/xXP47zg615ciwJ/BY3NyBk6fbQ8IC4bvPA3Mxz6BoeDq/7pif9HtBywk1JJIorqvC11v34OEqPK2hfHLYQxb3E1Y0uv8XtrBoAW+UMAXm7dTYO1Kq9G9yLE55YfjZGU1oubrM4mPtAOI+IU9nXm+HDMhrdaUPZN5G+sb0rxDrirTrobCQivSG6y7n5eTrvD3R2W8fjqgewe/E7o6J1jeHsah+bjFdW3uO/R5o2dLlVrX57X6W+OiPl/GBNNl0a324GIAdoB3zi/FwkjhOXRe3ohlo3jyqdMMADOUVQ+SDrqYfb3GYCZcb4Re4ce+TKlzfTSaoUQkEtVi9JCR3kkny1K8lwzfwPEQu52VzGShq2SENCAT9LbuZqmH82JnRVOrDrgscFx97L1BJMhHkmKIdMLCTKGkLBO6VST8anQRrBSwaGS2dQp0Sxu/ew8k3EoR4PRU4iCZXwbxeFM6tD+D89CBGgdXDFWL8VHOnjz7gKXt3iDr0dmXfcw/9NQzuixgoW3G2WGiH0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkU1RkRTQjFiQkJoK3ZOa1N6Y1hwMVpWc2NqNVRqS21jMWRRS3ZyampCWllt?=
 =?utf-8?B?V3BQaklUQlBTUHZ4Mm1MbE1QSkxxL1p6Nnc4dyt0bC9LSkl1aTRlVHVRTzVH?=
 =?utf-8?B?alJNbWNjakV5amVxcVRKaFlLMUt5YXE2YnNXNXRmby9Kd0J4UkFVYU9yRnJ4?=
 =?utf-8?B?cXM2RjMzZld0V2VBcnZhaEl1QUUvOTk3cEN4dXpHdzdLV1hZK0xtQlhOWGRZ?=
 =?utf-8?B?OEVRZGxnalJOaDhhcllSNzE4bmE0a3MveWRZN2ZMb29xbkdRc3VzS3NIdG1l?=
 =?utf-8?B?d2tEdlhvYUxwcVV5dEg4T2RsazJyY1B4R1hkQkZJS3NDaEFzdlVXbzdlOTNX?=
 =?utf-8?B?VTJyQzVRakVJdjBWc3ArUmd2QlF5eml5ZTd0SThOSjdRa3l4MThQaWJNNmd1?=
 =?utf-8?B?SVJQYVlUZXo1RFpsS1Y1ZFE5Kzc4amRqMU1OSjcyNU9EMEhOa0xtelZPZUlG?=
 =?utf-8?B?VkhpSmdqWmNhYkRDYVNqV2NHa0Q2NDBPRUoxTFdURGRkQmF6TUVkWCt0MUVL?=
 =?utf-8?B?WHAyRGdpQlVuOHM1d0pIMnJHMXNhV3VXSDl5VUg0Z0tncE9Db290VDB2RFdn?=
 =?utf-8?B?UzVPaHZsVzRNRVpwclpzTkFlWW5CTlBNTkZoaFJ3WVp2UndpMWhDMXRRTFBH?=
 =?utf-8?B?RU9LY3BydDNkeE11d2hsNGpZclJpcGIzVUpjK3plUmdCR3hRNjVNclVlWjNV?=
 =?utf-8?B?KzdVN3NCYnNVT3ZYSmVJQm1hbUFEM25oZHVnWk9WU3VZTXFBdTJRWE5Oak85?=
 =?utf-8?B?d1BaT214K21Jb29ZeFgxcXZqZ1F3YjJUMFlZRGJiempOSFI0eGN2MXhPYS9F?=
 =?utf-8?B?bytRVXBlNDlHR2FEdjMzVVBEYy96eWRQUloxZXdzbDFsbG5hSS9seHFtMGJ3?=
 =?utf-8?B?S08wSGtXdEVFUVJ5ME42b1kxSjJjaUhyb3ZzZjdPUkNjNC9FM2hYZUlnd2hl?=
 =?utf-8?B?Y3VBcEpOc1dBdjdyS01mUEZmdzhLaTQzY1lZK3BBU2ZSU2tuRCtlczlIWUpV?=
 =?utf-8?B?S2xwemhub2o2N29jME51R0NxclNrRjB1a0UxMGNyQ3lKOW9jdmI3Mm1jK1ZE?=
 =?utf-8?B?aE5JRVlzVisraDNKSFQ3OVFnVUx4NXMwMFN3aTUwYWZ0cldnMUF3Ni8rNmE1?=
 =?utf-8?B?TVdpeEpuaFJnN0lqeERQN29UTE1sZ2luVUFmOWNNcmhibko0QzJMZkk1ZzZO?=
 =?utf-8?B?NkpKRHVhKzdnWU1RYWJlcmVZTmJjRjR2NUc4VmZDekZKSXFRM0crSS9rWWhm?=
 =?utf-8?B?cjI4ZzZCUnVJTHhlR3FmK0NCSEp2KzBuelBxNEl6dzQ3THFNMGNTdDgxRkts?=
 =?utf-8?B?V3FPbGFPRGE3NXpQN0RialNvUDhKZnkrVHVjd0ZtNzVsNXhwOHdnNHAwazhu?=
 =?utf-8?B?RVo3ZWNyUmc0YjFaYi9BK253eEpWR1NPZU9USUZ1UFBhSUlCUnljZkhRVmlY?=
 =?utf-8?B?MUwrVHgvL1VtSGEwYWlia0RoaHhpN2Q0SWNQZHV3TUpUQUlrT3BpWHRvQXpn?=
 =?utf-8?B?eTlLWXFjR0IybVhWbkdTU2VuK2JnMmd4Q245MURKSDQvYzB1V1A2VDFlYmlz?=
 =?utf-8?B?d2NqY21pTlJkYVN5bndhY25SUGdKZkxLMGhxcGlqcEllQk9wYU15UmtnZTc1?=
 =?utf-8?B?TVBCVDJsMWtudVhVQ0dYd0pzYmE4UzcrWnpYZlRyZ3BacHMxM013RWtwMlEr?=
 =?utf-8?B?TUlSRjNxUjBXYWhUdW55ZDJWTTdxcDhkWUNDUjdvMjZzdmZhN1RidDNRQXUx?=
 =?utf-8?B?ZHV0UnRZY205VmtCRGVJaW5kczdxZ2Ixa1RCZ0cxK1AxR29PQ2tTWHhCS1dZ?=
 =?utf-8?B?LzJ2UVRjVVNMNVVhUVNkaEJFUVB2bUtsVDdNdm5QS1IwRW5JV3Q0WWEzZjVI?=
 =?utf-8?B?TEFCYklva3BzbVFHMVUwWTVxR0wySnZIa1ZCNGIxYVd5Um5TOHEzVU5zalkx?=
 =?utf-8?B?UGwrRndRU295amRRSURGYWx2cGZQZnVWbTNNdUlnTEVxN1c4ZkZ3M0daY2FY?=
 =?utf-8?B?ZmhoRU5IemhKQ0VYeTZqUFo0RXZsZlQzMWpHRlhrT2VobWlFdXR3VmFjaFhG?=
 =?utf-8?B?eElDaU1qZmhRNzVUaUdpK3VrM3laU3FsdklhM1VLZUwrbmFHcGdvaUxTR2tI?=
 =?utf-8?Q?fw+oHV8/8pnWo64Tjt1YFg5me?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d1c27a-72cf-42c6-a7e3-08dc5b5a653f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 01:38:18.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyI7wV7GhCgPy1rXTKKh2dVVPpHO0Rq1CoTJRfd3WjxBFbX6+GA/MI7M+l9T3Yq+9FRqe4UMftcwkanFTQpB1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5867


在 2024/4/12 16:47, Qi Zheng 写道:
> Hi Peifeng,
>
> On 2024/4/12 16:07, lipeifeng@oppo.com wrote:
>> From: Peifeng Li <lipeifeng@oppo.com>
>>
>> In the case of insufficient memory, threads will be in direct_reclaim to
>> reclaim memory, direct_reclaim will call shrink_slab to run sequentially
>> each shrinker callback. If there is a lock-contention in the shrinker
>> callback,such as spinlock,mutex_lock and so on, threads may be likely to
>> be stuck in direct_reclaim for a long time, even if the memfree has 
>> reached
>> the high watermarks of the zone, resulting in poor performance of 
>> threads.
>>
>> Example 1: shrinker callback may wait for spinlock
>> static unsigned long mb_cache_shrink(struct mb_cache *cache,
>>                                       unsigned long nr_to_scan)
>> {
>>          struct mb_cache_entry *entry;
>>          unsigned long shrunk = 0;
>>
>>          spin_lock(&cache->c_list_lock);
>>          while (nr_to_scan-- && !list_empty(&cache->c_list)) {
>>                  entry = list_first_entry(&cache->c_list,
>>                                           struct mb_cache_entry, 
>> e_list);
>>                  if (test_bit(MBE_REFERENCED_B, &entry->e_flags) ||
>>                      atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
>>                          clear_bit(MBE_REFERENCED_B, &entry->e_flags);
>>                          list_move_tail(&entry->e_list, &cache->c_list);
>>                          continue;
>>                  }
>>                  list_del_init(&entry->e_list);
>>                  cache->c_entry_count--;
>>                  spin_unlock(&cache->c_list_lock);
>>                  __mb_cache_entry_free(cache, entry);
>>                  shrunk++;
>>                  cond_resched();
>>                  spin_lock(&cache->c_list_lock);
>>          }
>>          spin_unlock(&cache->c_list_lock);
>>
>>          return shrunk;
>> }
>> Example 2: shrinker callback may wait for mutex lock
>> static
>> unsigned long kbase_mem_evictable_reclaim_scan_objects(struct 
>> shrinker *s,
>>         struct shrink_control *sc)
>> {
>>     struct kbase_context *kctx;
>>     struct kbase_mem_phy_alloc *alloc;
>>     struct kbase_mem_phy_alloc *tmp;
>>     unsigned long freed = 0;
>>
>>     kctx = container_of(s, struct kbase_context, reclaim);
>>
>>     // MTK add to prevent false alarm
>>     lockdep_off();
>>
>>     mutex_lock(&kctx->jit_evict_lock);
>>
>>     list_for_each_entry_safe(alloc, tmp, &kctx->evict_list, 
>> evict_node) {
>>         int err;
>>
>>         err = kbase_mem_shrink_gpu_mapping(kctx, alloc->reg,
>>                 0, alloc->nents);
>>         if (err != 0) {
>>             freed = -1;
>>             goto out_unlock;
>>         }
>>
>>         alloc->evicted = alloc->nents;
>>
>>         kbase_free_phy_pages_helper(alloc, alloc->evicted);
>>         freed += alloc->evicted;
>>         list_del_init(&alloc->evict_node);
>>
>>         kbase_jit_backing_lost(alloc->reg);
>>
>>         if (freed > sc->nr_to_scan)
>>             break;
>>     }
>> out_unlock:
>>     mutex_unlock(&kctx->jit_evict_lock);
>>
>>     // MTK add to prevent false alarm
>>     lockdep_on();
>>
>>     return freed;
>> }
>>
>> In mobile-phone,threads are likely to be stuck in shrinker callback 
>> during
>> direct_reclaim, with example like the following:
>> <...>-2806    [004] ..... 866458.339840: mm_shrink_slab_start:
>>             dynamic_mem_shrink_scan+0x0/0xb8 ... priority 2
>> <...>-2806    [004] ..... 866459.339933: mm_shrink_slab_end:
>>             dynamic_mem_shrink_scan+0x0/0xb8 ...
>>
>> For the above reason, the patch introduces SHRINKER_NO_DIRECT_RECLAIM 
>> that
>> allows driver to set shrinker callback not to be called in 
>> direct_reclaim
>> unless sc->priority is 0.
>
> Hmm, this is just a workaround, no shrinker will want to set this flag.
> If a shrinker has a lock contention problem, then it needs to be fixed.
>
> Perhaps executing do_shrink_slab() asynchronously may be a more
> fundamental solution, but this may result in untimely reclamation.
>
In fact, we have implemented do_shrink_slab() asynchronous, but the code 
changes are

relatively large, which may have a large impact on different products.

This submit also wants to consult the community experts on which 
solution you prefer.

In real projects, most of the shrinker callback has synchronization 
mechanism, and many

drivers want to remove synchronization operation will be difficult, such 
as the mali driver

of ARM. If the memory-reclaim-path of the kernel will be affected by the 
driver, the

robustness of the kernel will be greatly reduced.

Back to this patch, with this flag, at least in the case that the driver 
cannot remove the

synchronization mechanism, we can recommend the corresponding driver to 
set this flag

to improve the performance of the kernel memory reclaim.

>>
>> The reason why sc->priority=0 allows shrinker callback to be called in
>> direct_reclaim is for two reasons:
>> 1.Always call all shrinker callback in drop_slab that priority is 0.
>> 2.sc->priority is 0 during direct_reclaim, allow direct_reclaim to call
>> shrinker callback, to reclaim memory timely.
>>
>> Note:
>> 1.Register_shrinker_prepared() default not to set
>
> This API is no longer included in the latest upstream code. Please
> submit a patch based on the latest code.
>
> Thanks,
> Qi
Allright, I will submit the V2 patch with the new commit message.
>
>> SHRINKER_NO_DIRECT_RECLAIM, to maintain the current behavior of the 
>> code.
>> 2.Logic of kswapd and drop_slab to call shrinker callback isn't 
>> affected.
>>
>> Signed-off-by: Peifeng Li <lipeifeng@oppo.com>
>> ---
>>   include/linux/shrinker.h |  5 +++++
>>   mm/shrinker.c            | 36 ++++++++++++++++++++++++++++++++++--
>>   2 files changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 1a00be90d93a..2d5a8b3a720b 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -130,6 +130,11 @@ struct shrinker {
>>    * non-MEMCG_AWARE shrinker should not have this flag set.
>>    */
>>   #define SHRINKER_NONSLAB    BIT(4)
>> +/*
>> + * Can shrinker callback be called in direct_relcaim unless
>> + * sc->priority is 0?
>> + */
>> +#define SHRINKER_NO_DIRECT_RECLAIM    BIT(5)
>>     __printf(2, 3)
>>   struct shrinker *shrinker_alloc(unsigned int flags, const char 
>> *fmt, ...);
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index dc5d2a6fcfc4..3ac50da72494 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -544,7 +544,23 @@ static unsigned long shrink_slab_memcg(gfp_t 
>> gfp_mask, int nid,
>>               if (!memcg_kmem_online() &&
>>                   !(shrinker->flags & SHRINKER_NONSLAB))
>>                   continue;
>> -
>> +            /*
>> +             * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
>> +             * should not be called in direct_reclaim unless priority
>> +             * is 0.
>> +             */
>> +            if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
>> +                    !current_is_kswapd()) {
>> +                /*
>> +                 * 1.Always call shrinker callback in drop_slab that
>> +                 * priority is 0.
>> +                 * 2.sc->priority is 0 during direct_reclaim, allow
>> +                 * direct_reclaim to call shrinker callback, to reclaim
>> +                 * memory timely.
>> +                 */
>> +                if (priority)
>> +                    continue;
>> +            }
>>               ret = do_shrink_slab(&sc, shrinker, priority);
>>               if (ret == SHRINK_EMPTY) {
>>                   clear_bit(offset, unit->map);
>> @@ -658,7 +674,23 @@ unsigned long shrink_slab(gfp_t gfp_mask, int 
>> nid, struct mem_cgroup *memcg,
>>               continue;
>>             rcu_read_unlock();
>> -
>> +        /*
>> +         * SHRINKER_NO_DIRECT_RECLAIM, mean that shrinker callback
>> +         * should not be called in direct_reclaim unless priority
>> +         * is 0.
>> +         */
>> +        if ((shrinker->flags & SHRINKER_NO_DIRECT_RECLAIM) &&
>> +                !current_is_kswapd()) {
>> +            /*
>> +             * 1.Always call shrinker callback in drop_slab that
>> +             * priority is 0.
>> +             * 2.sc->priority is 0 during direct_reclaim, allow
>> +             * direct_reclaim to call shrinker callback, to reclaim
>> +             * memory timely.
>> +             */
>> +            if (priority)
>> +                continue;
>> +        }
>>           ret = do_shrink_slab(&sc, shrinker, priority);
>>           if (ret == SHRINK_EMPTY)
>>               ret = 0;

