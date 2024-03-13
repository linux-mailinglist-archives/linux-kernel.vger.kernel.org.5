Return-Path: <linux-kernel+bounces-101047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3587A193
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D311282DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7FBE66;
	Wed, 13 Mar 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="BPLAt505"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB2A93C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296512; cv=fail; b=au4pr662LqTg6y1fK1/9hJdMl/Ok2sqlx3IDr302g+oBlIlmRiAgUswxHrf2eKtRw5CMS5wqM2IWIigimwBrd4LCSLGMFfvExmmPR/zbGlgn0XZWBO4ED1iySmg5NvnUNBLeFPGMT1XM1OqGLY8kK8UAIQLknwh3bm2qQf9xFM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296512; c=relaxed/simple;
	bh=LSrM7qcc8Ya2eWifx7L/EfQ3MSGfb4GRJWsacN9s2lY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PAEHO4IGCJPhbI8TFZZEOzEt9dRayqaiAW4NwLrXyz/UX9HME312El8hQq2JgQRb2fR631lnrGRRl1hZyUPvtDpdsKAmkWeIWXoSi176IMh5ZGmxnmgkIRjWqH75f5E0RBvBFb7rhDJL0jXtV+H7MFORJvk8/4eZYzEordwTLQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=BPLAt505; arc=fail smtp.client-ip=40.107.117.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4OtPPwhW316t3HVWJ68w0+nhhXvx5K2MCqGBiqtv/VS1WuVuOGlMfoxz/gH2FESIR+EX42GqEWiLNxEnqt15Pir5oC8SYeEQYjYNx0Wo3qUuTUoe2+nLLsEhXSRGLGIR9YdU7GY0IV3fBirXpDJmo/sXhdGST6ZgztmpYURuLsT8eMOW4E828JGvk4neagikE8Th2tXLELI5d1BsDE5/O+8akj8OYVyyfuqFv0b69jE5rR+SGNPf2N2SP8W7XEMddp1ks8OCc1lsFz8pmrTSX3WGFRHYFP5vTonF3RYdBBoCtTKNIhg5WDlqR1IeTngtjUNpT3yay22eLmZEJXtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vaZukkDp9co5SInJKdHik64MwM4f/k/Kl1Mu3M6RjU=;
 b=nULSovSBD1H695hjMnofFg3L7jk6byLIBk7zotc+tP+TA5bFNOFi+pQxPYNH6VpgB9Amhaxo9gfBCCHEI/4454kEvU7ZK1s+gbc3U0Dfrg40KAaIkzAt5EFQnpam3vgJ/0EGMFqDRCEsxQr2l2kyV4isW4dQOiztrw7/k9lUv9GpAR85zshix+A9Q9FLEROgpTWstAXje7SElic/hm4huMx6eM6ETUY3ZxXjI4DE8pbam3FpMuyJL9cUo+gnAbCDfQAzdrVJHF3vobqajgnRdsL0YuDBlixVE9DYJsOIDUc/0vWWf/f0fQ2mWQq6uEfvJYcHCeh6F/JYfMejk1qXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vaZukkDp9co5SInJKdHik64MwM4f/k/Kl1Mu3M6RjU=;
 b=BPLAt505pYpkqzz71nmFfZrXVjgz++TAqLiPxKWlGrDdNzNdOO89A7uT48XxNaObrk3LABehmN6z1OsJwk311EhcOAlJljp9JahA8/5gG8b4Q+hswd5ZrE6e1FcRAdH16E7pbZlM8rPUn3+OpujeLATGCx5uirmQWVqqtnNZsrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB7988.apcprd02.prod.outlook.com (2603:1096:405:aa::5)
 by SEZPR02MB5614.apcprd02.prod.outlook.com (2603:1096:101:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 02:21:47 +0000
Received: from TYZPR02MB7988.apcprd02.prod.outlook.com
 ([fe80::9aeb:5c84:e751:1bad]) by TYZPR02MB7988.apcprd02.prod.outlook.com
 ([fe80::9aeb:5c84:e751:1bad%5]) with mapi id 15.20.7362.031; Wed, 13 Mar 2024
 02:21:47 +0000
Message-ID: <24dc6251-8582-790f-bbd3-465deed946f5@oppo.com>
Date: Wed, 13 Mar 2024 10:21:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v3 3/5] mm: swap: make should_try_to_free_swap()
 support large-folio
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-4-21cnbao@gmail.com>
 <e73c12ff-5234-44d5-a2b3-99cdc61a9c37@arm.com>
From: Chuanhua Han <hanchuanhua@oppo.com>
In-Reply-To: <e73c12ff-5234-44d5-a2b3-99cdc61a9c37@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To TYZPR02MB7988.apcprd02.prod.outlook.com
 (2603:1096:405:aa::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7988:EE_|SEZPR02MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b548685-16f1-427f-9b66-08dc4304559b
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHleEcUbHnfPNjsdxFnc69X/Vlf1i6Bqam8+e3QxrvBtaoMAhOJJN1f3zirruShEeeZZIBz4bNj5nRwiR9zjdPa9klJPexaqcSjKL2sdclb0zcsXrWcE97q+Dw0kamHjaD5BRHPfB9VDEBX1CgyxmaCBiYB2gEpdDpZH2GoFtVjPBEd4zwKOhJZD2vqFq//NsAxv9qAvGowSq0vAkE6cBs5lAKH8VNrfjOM29kiD9qRQ45P1NXg7AIRiXLZSjZbtuOwTs6v5caW8Z0IWcZK0/lhcJ9wXG6+E3wUzJq9sDLmIsd0EvrDVX8t3g6/621Fez9clk6urRl0sbAp95eUKyuPN6mt1otBt8McYwQ1aZSi7qUPOwREXNRv8qnehmFqcWBuLosOFg0lNEwBHn/0AKNimtEbmQ2Zg6FuH66+Ydg3FhZM4nT76TefAA+7jeYdlAJVE8vdKdYWaR9owfzy2uTcay90rsIOmKq8YFoV51hbCflpW4JC+/BuPcmte1cL/RBI7DIDyO0l3Ed90seC9ltfMSf3KWSmisOPxhKlJ0MitvnjXMEw423ZP9THo8rj+TX3nCxGvRzmowE9VxPmzigdtz6DXRzypr1VIDoFWb465KC3zdnKHRG8SuXmXvMZKQ5UBHq4Fcytl0MvyHZ+HGlelf++52afFzZJo/pYWon8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB7988.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmlTcGYwOFIwc01xazNwb096cXZYZkJ2emVzSEc1WjQ3K29Mb2E3V0lJeXhP?=
 =?utf-8?B?UE4ydmY1aFBqZjJpMkx5RC9jWXJ4SXRsWnlndzlxTXc5bDFvRk9YY010cWpL?=
 =?utf-8?B?UERkNWV0Mk9PSjQ0UkRUSU9XMmxsY1BEWU5oSnEyUXR0aUpIaTh2Sy9tNUxs?=
 =?utf-8?B?dHJTMkNaRlhiaDNKMjh4cGF1dmFtNnoyZUpyWnlPaTh4R2NoNHZPNE5rdHRM?=
 =?utf-8?B?VVB3WlU1ZmhWNndjT0VTUFhNQ3o3SFk4K2ZrTFBBaWpkYUVOVSt0UE5heThV?=
 =?utf-8?B?RTNuTDBpNlNoWllqZEFraEFtRHduaWdBVXQwU1N2RTZsSU9NNWZ1UGhFS3FC?=
 =?utf-8?B?Vno5NlJONVNUMmxxS1NMTEc1ZHNROFJXTHpLUEZTQ2x1Z3owNTdENmUwU3pF?=
 =?utf-8?B?RjA4anpXcHJ3aDRaU1pTSmZLcXNWeHBITDNFRkpWdUpGNFJNUzZRZ05PZDNt?=
 =?utf-8?B?dDBTaVgyWGcrcDBWdHpZMjVNcFRVN2wxdnpvN3hoWHZuZ3lEKyt6cGJNVEI0?=
 =?utf-8?B?T1BjY3ptMGptQlord1hpSVNuRzN3Q1RJcU85dHJKTEhyOC9zbGdLYk1TbjJT?=
 =?utf-8?B?Z2xXTXNoTDZSd2ZhY1VRKzFvaklKRXBLR1pjVTJtd1puOWJtSVMwWHdWS2Np?=
 =?utf-8?B?T2c1Zys3STN5RndQcWhvbHRyYnpyTnpqUFY5MEVUMHhWRk1GOS9aUWhOVkNz?=
 =?utf-8?B?bllORjRlQ3BKSTRPd0xhZ2NKeVRMNlh5UExKTmhDMndPTnIrbTlpUWkxOElG?=
 =?utf-8?B?S0dlMHVHeElHZXlBMVZJOVJwVHdxRVorbld1NGZ3Vi84VVhNb2ZLb2RGQUNQ?=
 =?utf-8?B?SHpLRENTaThGM3hFalQ0VkZWRDNpZW5Cc1ZuVFhHRldRcHg3dmJ1bmVsWG5H?=
 =?utf-8?B?amRjM3ZZT0h6ZkJ5OGtqZWdiVUIvbVlhTWtySGJkdkJjZU5jVGFOTjhNYlhz?=
 =?utf-8?B?cG5DNUVRaDN3VjlDbE5ENHNGZkhOSjNOdVVwdTdxSmV1aURZKzMyeXErUlpx?=
 =?utf-8?B?NzMrdm5IQ1BWSW9uUGhZNTcyYU12K2VRM2hJVGpad0RCbnA3YnNSUG51QVVG?=
 =?utf-8?B?S2tzYTliQVJtU1EvRW4yeDh1STBBeHd5a0dpdjc1aFJXYTUrck9LeTI4Lzdo?=
 =?utf-8?B?em10N2d4bmdBSldlV3UxQUV6WHE2VkU3RzJaMFdjNEFFTy9mNHZtU3puaTdu?=
 =?utf-8?B?Z1BsR1lWTU1nc3R4K01vSlFnd2ZmZlNyd1FmTTcySFlzVmJHc2xzbnpGeW9i?=
 =?utf-8?B?cm02SlREdmpHWlNKMmNWdlMxSklvaFpQUXdmNjFaMEE2NitlUEFRdTdvLy90?=
 =?utf-8?B?d2xCbHh6RGNWNzJVcEhNLy9qWExXMmVvTFZPRE5SWUJhQXkyMHhKNlBGTldm?=
 =?utf-8?B?MmpSbEpucW45bStZem1LMmc3Vks3QU8zaXRXenU3bFVkSWVENjVERlhoQWgr?=
 =?utf-8?B?Y1I1RlZVR1pOTXRJMTZhV1FwWXE4aTlrRDg0MTlhK0xJZEpJNlg4M1BPZ055?=
 =?utf-8?B?SGpNOVdGbWkyem9hajJrc3I0aHRWUmlGZ0hnZENCdzZOeGNpMjhDbkhISGU5?=
 =?utf-8?B?VUpRdXpLRXkvRVZWSXo5elJ1R0daVVVWSFpqNnp3SFhiQ3dQWVlqU0JSVUVv?=
 =?utf-8?B?STlDMlJpdnNTMHdrOUZjT000UzJiQVZvVWk5dDlxNWk0MENleHF0YkRVTGd3?=
 =?utf-8?B?SHArMTVjM2Jsc29NeElEdWRXSEdZczJKSENBeUVDd3d5NTZ6WG16UnVyTWxr?=
 =?utf-8?B?RHlmQlRrN2pNMFJIL0diVEpXc29rOWpwM3FUdHhIWHg4VjMwRkhoL0E0V2pO?=
 =?utf-8?B?TlROYS9KZTlNMEhPaTAxNkRnSnJlZ0J1Tis4R1NnQzBBMUFFZ3ZkSFo4dmh1?=
 =?utf-8?B?bng3NytZbmtNYzVqc2dIdVdDajZ3Ni9tNXByK3RpUFhLRVZqVUJjVFVCS3pS?=
 =?utf-8?B?YkZsaWtSejJ4dGR3S1J3ckpNbzdaTW9kdFo3Z2lOaEkrV0FRYkdEM0EzSzl6?=
 =?utf-8?B?YytuVE9ia2FvTTZ1WCtkVzZ3WERyV0llMWw3M0F6RGJmSUV6VHlHWHl3OTJw?=
 =?utf-8?B?UlNaOWVWVjVsd21nVzRZOVYzZDJTSEt2d3RLODc0cmhEbXZ1bVFOb3ZpWFgy?=
 =?utf-8?B?VXRKTFFhNHNLS2JwQStXZ1pTRkJDazZ0WituVWxsM2JOczBSRU9zeUpRZU9K?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b548685-16f1-427f-9b66-08dc4304559b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7988.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 02:21:47.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WepdixPbOqA1MWeonBIFx3Klz6sYfZiTEIp7haz4PC60o0IVBEqUD2HrLZOnh+UwUCp4sLVz0UnayNFxixpC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5614

hi, Ryan Roberts

在 2024/3/12 20:34, Ryan Roberts 写道:
> On 04/03/2024 08:13, Barry Song wrote:
>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>
>> should_try_to_free_swap() works with an assumption that swap-in is always done
>> at normal page granularity, aka, folio_nr_pages = 1. To support large folio
>> swap-in, this patch removes the assumption.
>>
>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> Acked-by: Chris Li <chrisl@kernel.org>
>> ---
>>  mm/memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index abd4f33d62c9..e0d34d705e07 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3837,7 +3837,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
>>  	 * reference only in case it's likely that we'll be the exlusive user.
>>  	 */
>>  	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
>> -		folio_ref_count(folio) == 2;
>> +		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
> I don't think this is correct; one reference has just been added to the folio in
> do_swap_page(), either by getting from swapcache (swap_cache_get_folio()) or by
> allocating. If it came from the swapcache, it could be a large folio, because we
> swapped out a large folio and never removed it from swapcache. But in that case,
> others may have partially mapped it, so the refcount could legitimately equal
> the number of pages while still not being exclusively mapped.
>
> I'm guessing this logic is trying to estimate when we are likely exclusive so
> that we remove from swapcache (release ref) and can then reuse rather than CoW
> the folio? The main CoW path currently CoWs page-by-page even for large folios,
> and with Barry's recent patch, even the last page gets copied. So not sure what
> this change is really trying to achieve?
>
First, if it is a large folio in the swap cache, then its refcont is at
least folio_nr_pages(folio) :  


For example, in add_to_swap_cache path:

int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
                        gfp_t gfp, void **shadowp)
{
        struct address_space *address_space = swap_address_space(entry);
        pgoff_t idx = swp_offset(entry);
        XA_STATE_ORDER(xas, &address_space->i_pages, idx,
folio_order(folio));
        unsigned long i, nr = folio_nr_pages(folio); <---
        void *old;
        ...
        folio_ref_add(folio, nr); <---
        folio_set_swapcache(folio);
        ...
}


  *

    Then in the do_swap_page path:

  * if (should_try_to_free_swap(folio, vma, vmf->flags))
            folio_free_swap(folio);
  *

  * It also indicates that only folio in the swap cache will call
    folio_free_swap
  * to delete it from the swap cache, So I feel like this patch is
    necessary!? 😁

>>  }
>>  
>>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)

Thanks,

Chuanhua


