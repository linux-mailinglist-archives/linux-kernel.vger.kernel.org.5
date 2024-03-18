Return-Path: <linux-kernel+bounces-105896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541E487E628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9EF282BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8882C6A8;
	Mon, 18 Mar 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wpO/QtP4"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A32CCBA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754963; cv=none; b=F2erd2PHWZzRHh/xsih0QZLKkNDoEvMzWrqA1y9XEwErOnWbv0nNrkCHG6QKkLZvZ6JS+TD86/NXoscaLC+/WcBOrgJnVXja9RN7/v0ZhAbo60DaDcmkLwQ0fWoV/OwPpgJ4IpiqvNWOf0KkYm+9jnM8wqKl27qyzx8WHnE6VcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754963; c=relaxed/simple;
	bh=LenUAKpY7IbkXOaONHkh9fB/OC68Xi1tgUvhF1u8hpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzUjGVh6//D3jUgpng2r3HFdbYO4p1w24p6LQ8nvONMdxp7+SS4vaFq/CBWT0v1RXdr8mn/E0mnnVc40f+pODtoEbxLaNvjW1XI0yncZjMlmfDVWnPyJUP6UJ8kbNiFe9QiPPBaiIrsvQg+VQoTw+zoTVYALbCrtNTJEh8p6IRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wpO/QtP4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710754958; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eHKU+0Vmc/fvlmz+jTU/x301ac/TNPsWpN1lCex9O8w=;
	b=wpO/QtP41YNXDNLBwsKDmoiqXHu9yW1BTHoKrwHd+9GHW2u+tz71K9mfjN3fogVPzt/5lBZciO1thoCeJOhrH9sk8hFGr157Kx/y2BqQN1ufMAexutZfuyJU/aNleMCi0gT0/zvkrDhvGIoeSdOKb1SrPFNtNG5fYYUnO3jEINU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W2lrrKC_1710754955;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2lrrKC_1710754955)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 17:42:36 +0800
Message-ID: <f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com>
Date: Mon, 18 Mar 2024 17:42:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm: support multi-size THP numa balancing
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
 <871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/18 14:16, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>> but the numa balancing still prohibits mTHP migration even though it is an
>> exclusive mapping, which is unreasonable. Thus let's support the exclusive
>> mTHP numa balancing firstly.
>>
>> Allow scanning mTHP:
>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>> NUMA-migrate COW pages that have other uses") change to use page_count()
>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>> issue, although there is still a GUP race, the issue seems to have been
>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_estimated_sharers()
>> to skip shared CoW pages though this is not a precise sharers count. To
>> check if the folio is shared, ideally we want to make sure every page is
>> mapped to the same process, but doing that seems expensive and using
>> the estimated mapcount seems can work when running autonuma benchmark.
>>
>> Allow migrating mTHP:
>> As mentioned in the previous thread[1], large folios are more susceptible
>> to false sharing issues, leading to pages ping-pong back and forth during
>> numa balancing, which is currently hard to resolve. Therefore, as a start to
>> support mTHP numa balancing, only exclusive mappings are allowed to perform
>> numa migration to avoid the false sharing issues with large folios. Similarly,
>> use the estimated mapcount to skip shared mappings, which seems can work
>> in most cases (?), and we've used folio_estimated_sharers() to skip shared
>> mappings in migrate_misplaced_folio() for numa balancing, seems no real
>> complaints.
> 
> IIUC, folio_estimated_sharers() cannot identify multi-thread
> applications.  If some mTHP is shared by multiple threads in one

Right.

> process, how to deal with that?

IMHO, seems the should_numa_migrate_memory() already did something to help?

.....
	if (!cpupid_pid_unset(last_cpupid) &&
				cpupid_to_nid(last_cpupid) != dst_nid)
		return false;

	/* Always allow migrate on private faults */
	if (cpupid_match_pid(p, last_cpupid))
		return true;
.....

If the node of the CPU that accessed the mTHP last time is different 
from this time, which means there is some contention for that mTHP among 
threads. So it will not allow migration.

If the contention for the mTHP among threads is light or the accessing 
is relatively stable, then we can allow migration?

> For example, I think that we should avoid to migrate on the first fault
> for mTHP in should_numa_migrate_memory().
> 
> More thoughts?  Can we add a field in struct folio for mTHP to count
> hint page faults from the same node?

IIUC, we do not need add a new field for folio, seems we can reuse 
->_flags_2a field. But how to use it? If there are multiple consecutive 
NUMA faults from the same node, then allow migration?

>> Performance data:
>> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
>> Base: 2024-3-15 mm-unstable branch
>> Enable mTHP=64K to run autonuma-benchmark
>>
>> Base without the patch:
>> numa01
>> 222.97
>> numa01_THREAD_ALLOC
>> 115.78
>> numa02
>> 13.04
>> numa02_SMT
>> 14.69
>>
>> Base with the patch:
>> numa01
>> 125.36
>> numa01_THREAD_ALLOC
>> 44.58
>> numa02
>> 9.22
>> numa02_SMT
>> 7.46
>>
>> [1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Changes from RFC v1:
>>   - Add some preformance data per Huang, Ying.
>>   - Allow mTHP scanning per David Hildenbrand.
>>   - Avoid sharing mapping for numa balancing to avoid false sharing.
>>   - Add more commit message.
>> ---
>>   mm/memory.c   | 9 +++++----
>>   mm/mprotect.c | 3 ++-
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index f2bc6dd15eb8..b9d5d88c5a76 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5059,7 +5059,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	int last_cpupid;
>>   	int target_nid;
>>   	pte_t pte, old_pte;
>> -	int flags = 0;
>> +	int flags = 0, nr_pages = 0;
>>   
>>   	/*
>>   	 * The pte cannot be used safely until we verify, while holding the page
>> @@ -5089,8 +5089,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	if (!folio || folio_is_zone_device(folio))
>>   		goto out_map;
>>   
>> -	/* TODO: handle PTE-mapped THP */
>> -	if (folio_test_large(folio))
>> +	/* Avoid large folio false sharing */
>> +	if (folio_test_large(folio) && folio_estimated_sharers(folio) > 1)
>>   		goto out_map;
>>   
>>   	/*
>> @@ -5112,6 +5112,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   		flags |= TNF_SHARED;
>>   
>>   	nid = folio_nid(folio);
>> +	nr_pages = folio_nr_pages(folio);
>>   	/*
>>   	 * For memory tiering mode, cpupid of slow memory page is used
>>   	 * to record page access time.  So use default value.
>> @@ -5148,7 +5149,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   
>>   out:
>>   	if (nid != NUMA_NO_NODE)
>> -		task_numa_fault(last_cpupid, nid, 1, flags);
>> +		task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>   	return 0;
>>   out_map:
>>   	/*
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index f8a4544b4601..f0b9c974aaae 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   
>>   				/* Also skip shared copy-on-write pages */
>>   				if (is_cow_mapping(vma->vm_flags) &&
>> -				    folio_ref_count(folio) != 1)
>> +				    (folio_maybe_dma_pinned(folio) ||
>> +				     folio_estimated_sharers(folio) > 1))
>>   					continue;
>>   
>>   				/*

