Return-Path: <linux-kernel+bounces-122835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA7788FE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED631C26353
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3E7E57F;
	Thu, 28 Mar 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ovvbp4LU"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB52A1AA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625687; cv=none; b=GfPVnl096hHYrKDeNy/E5BKBRZtW6q3qY/S/vo7chetxCMimNoEmTDS/p/WcTIBfBzrLJFQh2EZDId3TvSYs9mP1B7XcReWyPvFAAWezBevgiwUfppJ+xMU3sF7Zr6eHpYY3Gp8bC9YGn0rVvq+uevULcUEbxSTDftsd5CvPzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625687; c=relaxed/simple;
	bh=hUjEWa8XSbck/uhesdAZNspXXPVpZvAeonChTuFKn1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+B7ut8ElBuZmklf/cRVNn3qNiCbzJY7XQEsNOtDGKAOsFeHOWfNnENRpQiCqbojYhyX9ec/SqIcOXnvOmdpxrQvttI5qGyUy78K1BgsFmYHlHxOgbkuN6E+OVoBvjcDBnGaT+dcrZGGtuGMRL52uOGAFvHBocLL2Cd6SmYL7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ovvbp4LU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711625677; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N7LAp1xKPwjIQcsSOXSDyjWhh7oArMh2VFYbUdBe/bU=;
	b=Ovvbp4LUL0zfZewkL54ydgevl7OfxNxL4V2UJsvbyYJA0GyL8+95DMrgN/7tia4XQCsmRM72u8kPOLOOkkKtZMLgfgDl3wHYIa15JYUuoTfgXB8me88pbRJX6N/v5KOuBssy+0ON71oCKyAOIoFYocQvkv9/dxc2i614YYIABAU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3TH2YB_1711625674;
Received: from 30.97.56.91(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3TH2YB_1711625674)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 19:34:35 +0800
Message-ID: <0baa443a-7872-4ded-94c6-06af88a6a943@linux.alibaba.com>
Date: Thu, 28 Mar 2024 19:34:34 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <adf36acf-19b9-49fc-b9f3-138fd66de2da@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/28 17:25, David Hildenbrand wrote:
> On 26.03.24 12:51, Baolin Wang wrote:
>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>> but the numa balancing still prohibits mTHP migration even though it 
>> is an
>> exclusive mapping, which is unreasonable.
>>
>> Allow scanning mTHP:
>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>> NUMA-migrate COW pages that have other uses") change to use page_count()
>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>> issue, although there is still a GUP race, the issue seems to have been
>> resolved by commit 80d47f5de5e3. Meanwhile, use the 
>> folio_likely_mapped_shared()
>> to skip shared CoW pages though this is not a precise sharers count. To
>> check if the folio is shared, ideally we want to make sure every page is
>> mapped to the same process, but doing that seems expensive and using
>> the estimated mapcount seems can work when running autonuma benchmark.
>>
>> Allow migrating mTHP:
>> As mentioned in the previous thread[1], large folios (including THP) are
>> more susceptible to false sharing issues among threads than 4K base page,
>> leading to pages ping-pong back and forth during numa balancing, which is
>> currently not easy to resolve. Therefore, as a start to support mTHP numa
>> balancing, we can follow the PMD mapped THP's strategy, that means we can
>> reuse the 2-stage filter in should_numa_migrate_memory() to check if the
>> mTHP is being heavily contended among threads (through checking the 
>> CPU id
>> and pid of the last access) to avoid false sharing at some degree. Thus,
>> we can restore all PTE maps upon the first hint page fault of a large 
>> folio
>> to follow the PMD mapped THP's strategy. In the future, we can 
>> continue to
>> optimize the NUMA balancing algorithm to avoid the false sharing issue 
>> with
>> large folios as much as possible.
>>
>> Performance data:
>> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
>> Base: 2024-03-25 mm-unstable branch
>> Enable mTHP to run autonuma-benchmark
>>
>> mTHP:16K
>> Base                Patched
>> numa01                numa01
>> 224.70                137.23
>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>> 118.05                50.57
>> numa02                numa02
>> 13.45                9.30
>> numa02_SMT            numa02_SMT
>> 14.80                7.43
>>
>> mTHP:64K
>> Base                Patched
>> numa01                numa01
>> 216.15                135.20
>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>> 115.35                46.93
>> numa02                numa02
>> 13.24                9.24
>> numa02_SMT            numa02_SMT
>> 14.67                7.31
>>
>> mTHP:128K
>> Base                Patched
>> numa01                numa01
>> 205.13                140.41
>> numa01_THREAD_ALLOC        numa01_THREAD_ALLOC
>> 112.93                44.78
>> numa02                numa02
>> 13.16                9.19
>> numa02_SMT            numa02_SMT
>> 14.81                7.39
>>
>> [1] 
>> https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c   | 56 +++++++++++++++++++++++++++++++++++++++++++--------
>>   mm/mprotect.c |  3 ++-
>>   2 files changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c30fb4b95e15..36191a9c799c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5068,16 +5068,55 @@ static void numa_rebuild_single_mapping(struct 
>> vm_fault *vmf, struct vm_area_str
>>       update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>   }
>> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct 
>> vm_area_struct *vma,
>> +                       struct folio *folio, pte_t fault_pte, bool 
>> ignore_writable)
>> +{
>> +    int nr = pte_pfn(fault_pte) - folio_pfn(folio);
>> +    unsigned long start = max(vmf->address - nr * PAGE_SIZE, 
>> vma->vm_start);
>> +    unsigned long end = min(start + folio_nr_pages(folio) * 
>> PAGE_SIZE, vma->vm_end);
>> +    pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
>> +    bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
>> +    unsigned long addr;
>> +
>> +    /* Restore all PTEs' mapping of the large folio */
>> +    for (addr = start; addr != end; start_ptep++, addr += PAGE_SIZE) {
>> +        pte_t pte, old_pte;
>> +        pte_t ptent = ptep_get(start_ptep);
>> +        bool writable = false;
>> +
>> +        if (!pte_present(ptent) || !pte_protnone(ptent))
>> +            continue;
>> +
>> +        if (vm_normal_folio(vma, addr, ptent) != folio)
>> +            continue;
>> +
> 
> Should you be using folio_pte_batch() in the caller to collect all 
> applicable PTEs and then only have function that batch-changes a given 
> nr of PTEs?
> 
> (just like we are now batching other stuff)

Seems folio_pte_batch() is not suitable for numa balancing, since we did 
not care about other PTE bits, only care about the protnone bits. And 
after more thinking, I think I can drop the vm_normal_folio() 
validation, since all PTEs are ensured to be within the range of the 
folio size.

