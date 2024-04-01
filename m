Return-Path: <linux-kernel+bounces-126567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08D8939A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33561C21199
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2910A03;
	Mon,  1 Apr 2024 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BMfV0eWX"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430873C28
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964628; cv=none; b=JvniN6E2N/QQOZgwb9p+CER3syixixwmBaD4Q7AcqWePZv9vKFup8ZwyerYzFp0Dcpny+gBBjqhkWXFXbVwEdFnuRbUN+/BwM14U1+/ngB4UuV/kCVL1QzUBHgC8HSjOKKY5+lCC3pdUY8Ky4IfrQTdHXhT7MdxEmU8xuPLrn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964628; c=relaxed/simple;
	bh=S1hw9N8hq+5bHWj3ivauXOiBEOis6D+K5xGGScTw4Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN9oC3+svwY8j84lPvJf9gNubDseHXVjpKoqhaJ2F3SVJ2RrWMtnEhwa9TDg7zVRykTmG+ebVwwINRGzyMFMjqBfTuYxa6i/8MK1oY24d6uyIce2+us5zrpWktQ4JjRaKueQZmrDE+XVSnd0np/71+fvoHS3f6KY5fgT8Tat2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BMfV0eWX; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711964623; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2zzCye5gdOoBiYrYFli6u1c9p3Kc3YRSBl8d6kTXqRk=;
	b=BMfV0eWXWCA0E4dfU9pEecyXGxmLn0t+BdKqtYXr4EmmWH6fQF2IYWq5px+4aoOAY8QheJXe431TppgIi0088qItvhoO5rYzyUswKeeOh1+XBiCpOm9VWj8auDorYGjwY163EcuPoTbiNWB7V6RbZZ/77Z6BL4kv2fTNewbqbqU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3juXIk_1711964621;
Received: from 30.97.56.92(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3juXIk_1711964621)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 17:43:42 +0800
Message-ID: <81d1cd03-f3dc-4549-b5b1-2dc4e4614ffe@linux.alibaba.com>
Date: Mon, 1 Apr 2024 17:43:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: support multi-size THP numa balancing
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1711683069.git.baolin.wang@linux.alibaba.com>
 <d28d276d599c26df7f38c9de8446f60e22dd1950.1711683069.git.baolin.wang@linux.alibaba.com>
 <87sf05kd8j.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87sf05kd8j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/1 10:50, Huang, Ying wrote:
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
>>
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
>> 224.70				143.48
>> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
>> 118.05				47.43
>> numa02				numa02
>> 13.45				9.29
>> numa02_SMT			numa02_SMT
>> 14.80				7.50
>>
>> mTHP:64K
>> Base				Patched
>> numa01				numa01
>> 216.15				114.40
>> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
>> 115.35				47.41
>> numa02				numa02
>> 13.24				9.25
>> numa02_SMT			numa02_SMT
>> 14.67				7.34
>>
>> mTHP:128K
>> Base				Patched
>> numa01				numa01
>> 205.13				144.45
>> numa01_THREAD_ALLOC		numa01_THREAD_ALLOC
>> 112.93				41.88
>> numa02				numa02
>> 13.16				9.18
>> numa02_SMT			numa02_SMT
>> 14.81				7.49
>>
>> [1] https://lore.kernel.org/all/20231117100745.fnpijbk4xgmals3k@techsingularity.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c   | 57 +++++++++++++++++++++++++++++++++++++++++++--------
>>   mm/mprotect.c |  3 ++-
>>   2 files changed, 51 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c30fb4b95e15..2aca19e4fbd8 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5068,16 +5068,56 @@ static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_str
>>   	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>   }
>>   
>> +static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
>> +				       struct folio *folio, pte_t fault_pte, bool ignore_writable)
>> +{
>> +	int nr = pte_pfn(fault_pte) - folio_pfn(folio);
>> +	unsigned long start = max(vmf->address - nr * PAGE_SIZE, vma->vm_start);
>> +	unsigned long end = min(vmf->address + (folio_nr_pages(folio) - nr) * PAGE_SIZE, vma->vm_end);
>> +	pte_t *start_ptep = vmf->pte - (vmf->address - start) / PAGE_SIZE;
>> +	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
> 
> We call vma_wants_manual_pte_write_upgrade() in do_numa_page() already.
> It seems that we can make "ignore_writable = true" if
> "vma_wants_manual_pte_write_upgrade() == false" in do_numa_page() to
> remove one call.

 From the original logics, we should also call pte_mkwrite() for the new 
mapping if the pte_write() is true while 
vma_wants_manual_pte_write_upgrade() is false.

But I can add a new boolean parameter for numa_rebuild_large_mapping() 
to remove the same function call.

> Otherwise, the patchset LGTM, feel free to add
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> in the future versions.

Thanks for your valuable input!

