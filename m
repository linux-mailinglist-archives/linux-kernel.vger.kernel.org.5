Return-Path: <linux-kernel+bounces-123051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1DC89017A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDBF1C27C83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42656127B67;
	Thu, 28 Mar 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TYfxZYak"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F86823A9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635520; cv=none; b=acskU3Jc3BLLTs1VWSpj516WzwgdC9uEjPqnmjr1sbVgqOjE1QmlSUjsFetqajHq5B6QuDi1n31CjANB5JfvPwG9vtELBfYNX89yWIqwciivDc1BVCKrskPAQVI01TYwYNG0UAK7swmyyFuGwzeHH87qHlSQYHcpu4yrJlFeEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635520; c=relaxed/simple;
	bh=O2welLPbj/7GPVq7pwCV7fmRkdoi/9WxaP3s1r95SGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFdpnApj6kJ9YhD2gRPtBZZTYaG7a/YLHU+s7G0H55pfEqX3LBoZvUhpaJW5mpw4lEVxzeGsIxqUhztVHG3rUms7gJSs9fnB5HhjTe0aNCp0CMI+dGYIglapLSYaLgHJ1zDaCPr0NS5dfvW5tDOZ53lq1y/v1tvRZuz7fLSuPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TYfxZYak; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711635511; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mPgOR3xiLkUOv39HXRYANndMd72QxChze6dfNdBh9ZY=;
	b=TYfxZYakbeHR2MZCu48y6MjTkXh+aQvvfKNaZsVLP1Km27tnh1688HzDl/qSumc7g1KZgQq23IXAsiTGrXwTX1s9E8qn03+1Fz8d3Xiw+lndvZg4+z0UdIzfJIyuQeDdvh4aqthiY6SkZ3p+awRC+EI+ZoQ5zNkvABHk5w7V5q4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3TgXFp_1711635509;
Received: from 30.236.50.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3TgXFp_1711635509)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 22:18:30 +0800
Message-ID: <87f9ae34-91af-4df3-b4be-5ec4e0eb9982@linux.alibaba.com>
Date: Thu, 28 Mar 2024 22:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: mgorman@techsingularity.net, wangkefeng.wang@huawei.com,
 jhubbard@nvidia.com, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
 <dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
 <adf36acf-19b9-49fc-b9f3-138fd66de2da@redhat.com>
 <0baa443a-7872-4ded-94c6-06af88a6a943@linux.alibaba.com>
 <760800b1-c708-4c1d-b153-c252ab21938a@redhat.com>
 <3f465638-f96f-4d81-87b2-779897c03b21@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3f465638-f96f-4d81-87b2-779897c03b21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/28 20:25, David Hildenbrand wrote:
> On 28.03.24 13:07, David Hildenbrand wrote:
>> On 28.03.24 12:34, Baolin Wang wrote:
>>>
>>>
>>> On 2024/3/28 17:25, David Hildenbrand wrote:
>>>> On 26.03.24 12:51, Baolin Wang wrote:
>>>>> Now the anonymous page allocation already supports multi-size THP 
>>>>> (mTHP),
>>>>> but the numa balancing still prohibits mTHP migration even though it
>>>>> is an
>>>>> exclusive mapping, which is unreasonable.
>>>>>
>>>>> Allow scanning mTHP:
>>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data 
>>>>> section
>>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared 
>>>>> data
>>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>>>> NUMA-migrate COW pages that have other uses") change to use 
>>>>> page_count()
>>>>> to avoid GUP pages migration, that will also skip the mTHP numa 
>>>>> scaning.
>>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>>> issue, although there is still a GUP race, the issue seems to have 
>>>>> been
>>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the
>>>>> folio_likely_mapped_shared()
>>>>> to skip shared CoW pages though this is not a precise sharers 
>>>>> count. To
>>>>> check if the folio is shared, ideally we want to make sure every 
>>>>> page is
>>>>> mapped to the same process, but doing that seems expensive and using
>>>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>>>
>>>>> Allow migrating mTHP:
>>>>> As mentioned in the previous thread[1], large folios (including 
>>>>> THP) are
>>>>> more susceptible to false sharing issues among threads than 4K base 
>>>>> page,
>>>>> leading to pages ping-pong back and forth during numa balancing, 
>>>>> which is
>>>>> currently not easy to resolve. Therefore, as a start to support 
>>>>> mTHP numa
>>>>> balancing, we can follow the PMD mapped THP's strategy, that means 
>>>>> we can
>>>>> reuse the 2-stage filter in should_numa_migrate_memory() to check 
>>>>> if the
>>>>> mTHP is being heavily contended among threads (through checking the
>>>>> CPU id
>>>>> and pid of the last access) to avoid false sharing at some degree. 
>>>>> Thus,
>>>>> we can restore all PTE maps upon the first hint page fault of a large
>>>>> folio
>>>>> to follow the PMD mapped THP's strategy. In the future, we can
>>>>> continue to
>>>>> optimize the NUMA balancing algorithm to avoid the false sharing issue
>>>>> with
>>>>> large folios as much as possible.
>>>>>
>>>>> Performance data:
>>>>> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
>>>>> Base: 2024-03-25 mm-unstable branch
>>>>> Enable mTHP to run autonuma-benchmark
>>>>>
>>>>> mTHP:16K
>>>>> Base                Patched
>>>>> numa01                numa01
>>>>> 224.70                137.23
>>>>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>>>>> 118.05                50.57
>>>>> numa02                numa02
>>>>> 13.45                9.30
>>>>> numa02_SMT            numa02_SMT
>>>>> 14.80                7.43
>>>>>
>>>>> mTHP:64K
>>>>> Base                Patched
>>>>> numa01                numa01
>>>>> 216.15                135.20
>>>>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>>>>> 115.35                46.93
>>>>> numa02                numa02
>>>>> 13.24                9.24
>>>>> numa02_SMT            numa02_SMT
>>>>> 14.67                7.31
>>>>>
>>>>> mTHP:128K
>>>>> Base                Patched
>>>>> numa01                numa01
>>>>> 205.13                140.41
>>>>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>>>>> 112.93                44.78
>>>>> numa02                numa02
>>>>> 13.16                9.19
>>>>> numa02_SMT            numa02_SMT
>>>>> 14.81                7.39
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>     mm/memory.c   | 56 
>>>>> +++++++++++++++++++++++++++++++++++++++++++--------
>>>>>     mm/mprotect.c |  3 ++-
>>>>>     2 files changed, 50 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index c30fb4b95e15..36191a9c799c 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -5068,16 +5068,55 @@ static void numa_rebuild_single_mapping(struct
>>>>> vm_fault *vmf, struct vm_area_str
>>>>>         update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>>>>     }
>>>>> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct
>>>>> vm_area_struct *vma,
>>>>> +                       struct folio *folio, pte_t fault_pte, bool
>>>>> ignore_writable)
>>>>> +{
>>>>> +    int nr = pte_pfn(fault_pte) - folio_pfn(folio);
>>>>> +    unsigned long start = max(vmf->address - nr * PAGE_SIZE,
>>>>> vma->vm_start);
>>>>> +    unsigned long end = min(start + folio_nr_pages(folio) *
>>>>> PAGE_SIZE, vma->vm_end);
>>>>> +    pte_t *start_ptep = vmf->pte - (vmf->address - start) / 
>>>>> PAGE_SIZE;
>>>>> +    bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
>>>>> +    unsigned long addr;
>>>>> +
>>>>> +    /* Restore all PTEs' mapping of the large folio */
>>>>> +    for (addr = start; addr != end; start_ptep++, addr += 
>>>>> PAGE_SIZE) {
>>>>> +        pte_t pte, old_pte;
>>>>> +        pte_t ptent = ptep_get(start_ptep);
>>>>> +        bool writable = false;
>>>>> +
>>>>> +        if (!pte_present(ptent) || !pte_protnone(ptent))
>>>>> +            continue;
>>>>> +
>>>>> +        if (vm_normal_folio(vma, addr, ptent) != folio)
>>>>> +            continue;
>>>>> +
>>>>
>>>> Should you be using folio_pte_batch() in the caller to collect all
>>>> applicable PTEs and then only have function that batch-changes a given
>>>> nr of PTEs?
>>>>
>>>> (just like we are now batching other stuff)
>>>
>>> Seems folio_pte_batch() is not suitable for numa balancing, since we did
>>> not care about other PTE bits, only care about the protnone bits. And
>>
>> You should be able to ignore most bits we care about, which case are you
>> concerned about folio_pte_batch() would miss. Hand crafting own
>> functions to cover some corner cases nobody cares about is likely a bad
>> idea.
> 
> Note that the reason why I am asking is that folio_pte_batch() can 
> optimize-out repeated ptep_get() with cont-ptes.

IIUC, the protnone PTEs will not set cont-ptes bit.

Another concern is that the protnone PTEs of the large folio might not 
be contiguous. For example, if a middle section of the large folio has 
been zapped, we would still like to restore all the protnone PTE mapping 
for the entire folio. However, folio_pte_batch() seems to only help 
identify the initial contiguous protnone PTEs.


 > Are you sure about that?

Sorry for noise, I am wrong. Folio validation is needed for some corner 
cases, but I may optimize the code with a simple pfn validation.

