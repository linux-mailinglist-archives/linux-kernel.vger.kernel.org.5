Return-Path: <linux-kernel+bounces-120500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFA88D86D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25E11F2A906
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19C2CCB3;
	Wed, 27 Mar 2024 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c74Tz07m"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017D2C6BD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526975; cv=none; b=fVnzCmtYM0fExSTBL8YyYjpCKLc+hnHih+MtTsWOwiOIhHttfdTB6WI6D1HXjHN61aBMYeS94zK1wCWFCpzdK7lsaCaAF9zD1ioHmqgrH5FdkZvzgV+pyl/NUK9P2WSitWBwZFo4WOZt5lvepF/ELJkCEgXW6reVEsd4CdkXrLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526975; c=relaxed/simple;
	bh=M0YDBVYVQpYBJuMHYc4YlhVguE+k5LxBz80oz7H0VBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5VtTQfQbHBAS38JyjbfiGJb3k2D0g9vFzPtDCuXFuyUnMsZI5Wa9zkFv3sSKiEdRWPqhj2QFAL/h4Rjt6F3iomS4MSRhHItGGfFECmOz5triYZmLSssV2vxuAdLD6Z7MFRI5iBRwFSqrVTwIDEvfsARt2EAY7GmTQuWpuY3yEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c74Tz07m; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711526965; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7HaRYR15tSF2sXn0BXu0XGrgVN8ugQU3Uof5XntL9NQ=;
	b=c74Tz07mfDyC1Ko8ZYWoVa7F6EPw5theRPMWZ3PTxWq/369+kMX5HKDqiFEttfZU54IwXQc9ESc/NxLKIPdREgZIOqvHgQumopmiqA4AvZx5rAypJ28U0eu4x/OAUqsIQ1lVMTYuuvsdXTaiFYVoWIj3Hj6SJMSDwU8lUYEXH30=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3O-4qs_1711526963;
Received: from 30.97.56.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3O-4qs_1711526963)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 16:09:24 +0800
Message-ID: <bc671388-f398-4776-af15-c144f2c39d78@linux.alibaba.com>
Date: Wed, 27 Mar 2024 16:09:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
 <dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
 <87cyrgo2ez.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87cyrgo2ez.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/27 10:04, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>> but the numa balancing still prohibits mTHP migration even though it is an
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
>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_likely_mapped_shared()
>> to skip shared CoW pages though this is not a precise sharers count. To
>> check if the folio is shared, ideally we want to make sure every page is
>> mapped to the same process, but doing that seems expensive and using
>> the estimated mapcount seems can work when running autonuma benchmark.
> 
> Because now we can deal with shared mTHP, it appears even possible to
> remove folio_likely_mapped_shared() check?

IMO, the issue solved by commit 859d4adc3415 is about shared CoW 
mapping, and I prefer to measure it in another patch:)

>> Allow migrating mTHP:
>> As mentioned in the previous thread[1], large folios (including THP) are
>> more susceptible to false sharing issues among threads than 4K base page,
>> leading to pages ping-pong back and forth during numa balancing, which is
>> currently not easy to resolve. Therefore, as a start to support mTHP numa
>> balancing, we can follow the PMD mapped THP's strategy, that means we can
>> reuse the 2-stage filter in should_numa_migrate_memory() to check if the
>> mTHP is being heavily contended among threads (through checking the CPU id
>> and pid of the last access) to avoid false sharing at some degree. Thus,
>> we can restore all PTE maps upon the first hint page fault of a large folio
>> to follow the PMD mapped THP's strategy. In the future, we can continue to
>> optimize the NUMA balancing algorithm to avoid the false sharing issue with
>> large folios as much as possible.
>>
>> Performance data:
>> Machine environment: 2 nodes, 128 cores Intel(R) Xeon(R) Platinum
>> Base: 2024-03-25 mm-unstable branch
>> Enable mTHP to run autonuma-benchmark
>>
>> mTHP:16K
>> Base				Patched
>> numa01				numa01
>> 224.70				137.23
>> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
>> 118.05				50.57
>> numa02				numa02
>> 13.45				9.30
>> numa02_SMT			numa02_SMT
>> 14.80				7.43
>>
>> mTHP:64K
>> Base				Patched
>> numa01				numa01
>> 216.15				135.20
>> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
>> 115.35				46.93
>> numa02				numa02
>> 13.24				9.24
>> numa02_SMT			numa02_SMT
>> 14.67				7.31
>>
>> mTHP:128K
>> Base				Patched
>> numa01				numa01
>> 205.13				140.41
>> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
>> 112.93				44.78
>> numa02				numa02
>> 13.16				9.19
>> numa02_SMT			numa02_SMT
>> 14.81				7.39
>>
>> [1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c   | 56 +++++++++++++++++++++++++++++++++++++++++++--------
>>   mm/mprotect.c |  3 ++-
>>   2 files changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c30fb4b95e15..36191a9c799c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5068,16 +5068,55 @@ static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_str
>>   	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>   }
>>   
>> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
>> +				       struct folio *folio, pte_t fault_pte, bool ignore_writable)
>> +{
>> +	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
>> +	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
>> +	unsigned long end = min(start + folio_nr_pages(folio) * PAGE_SIZE, vma->vm_end);
> 
> If start is in the middle of folio, it's possible for end to go beyond
> the end of folio.  So, should be something like below?

Yes, good catch, even though below iteration can skip over the parts 
that exceed the size of that folio.

> 	unsigned long end = min(vmf->address + (folio_nr_pages(folio) - nr) * PAGE_SIZE, vma->vm_end);

Yes, this looks good to me. Will do in next version. Thanks.

>> +	pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
>> +	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
>> +	unsigned long addr;
>> +
>> +	/* Restore all PTEs' mapping of the large folio */
>> +	for (addr = start; addr != end; start_ptep++, addr += PAGE_SIZE) {
>> +		pte_t pte, old_pte;
>> +		pte_t ptent = ptep_get(start_ptep);
>> +		bool writable = false;
>> +
>> +		if (!pte_present(ptent) || !pte_protnone(ptent))
>> +			continue;
>> +
>> +		if (vm_normal_folio(vma, addr, ptent) != folio)
>> +			continue;
>> +
>> +		if (!ignore_writable) {
>> +			writable = pte_write(pte);
>> +			if (!writable && pte_write_upgrade &&
>> +			    can_change_pte_writable(vma, addr, pte))
>> +				writable = true;
>> +		}
>> +
>> +		old_pte = ptep_modify_prot_start(vma, addr, start_ptep);
>> +		pte = pte_modify(old_pte, vma->vm_page_prot);
>> +		pte = pte_mkyoung(pte);
>> +		if (writable)
>> +			pte = pte_mkwrite(pte, vma);
>> +		ptep_modify_prot_commit(vma, addr, start_ptep, old_pte, pte);
>> +		update_mmu_cache_range(vmf, vma, addr, start_ptep, 1);
> 
> Can this be batched for the whole folio?

I thought about it, but things are a little tricky. The folio may not 
contain continuous protnone PTEs, should skip non-present or 
non-protnone PTEs.

Moreover, it is necessary to define architecture-specified 
ptep_modify_prot_start*_nr and ptep_modify_prot_commit*_nr that can 
handle multiple PTEs, which is in my TODO list including batch numa 
scanning in change_pte_range().

