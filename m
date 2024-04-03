Return-Path: <linux-kernel+bounces-129155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCE896616
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2BD285D81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04AC58AA9;
	Wed,  3 Apr 2024 07:21:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9A4D133
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128880; cv=none; b=JdJOfB4P6cTAi0Qw3FfCZbeVxPK7GyQ8h38ffwe6wVd8JOZR7w4CFVGIYRIKclPkgMeNFuPnWZNIKQ9XkPlhECEaQm16uwqq/T9aGOrCRgxlbiDAFQ0pnt6ti3XYWMBhM2txoMKXD9N9RERTOqNa70vYG/9Pf4cFFkIri900N2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128880; c=relaxed/simple;
	bh=Wa5Oh1EEA+Je2ED21aem5RZr/wby3lpBIZHvUQczWJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVvI2yKcDrVINR9ryoc3KOHLTw7lZoF/jvJF1g2+5lsqR70Yzzg8yK0C6uznAFWntjmZMiAg16JSjxdlAwHTgnjn7LJH6sQjXBd1DssKJAndHtHiI9SXlF/R1gR2htZ+1bdKtHUmlG4KLgtgszf2SHIycJ7thrpJD+AI44gccy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B4D91007;
	Wed,  3 Apr 2024 00:21:49 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2B3B3F7B4;
	Wed,  3 Apr 2024 00:21:15 -0700 (PDT)
Message-ID: <4020c532-d20d-4624-8ea6-607de423396c@arm.com>
Date: Wed, 3 Apr 2024 08:21:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-3-ryan.roberts@arm.com>
 <B0E526FD-64CF-4653-B624-1AFA5B7AA245@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <B0E526FD-64CF-4653-B624-1AFA5B7AA245@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 01:30, Zi Yan wrote:
> On 27 Mar 2024, at 10:45, Ryan Roberts wrote:
> 
>> Now that we no longer have a convenient flag in the cluster to determine
>> if a folio is large, free_swap_and_cache() will take a reference and
>> lock a large folio much more often, which could lead to contention and
>> (e.g.) failure to split large folios, etc.
>>
>> Let's solve that problem by batch freeing swap and cache with a new
>> function, free_swap_and_cache_nr(), to free a contiguous range of swap
>> entries together. This allows us to first drop a reference to each swap
>> slot before we try to release the cache folio. This means we only try to
>> release the folio once, only taking the reference and lock once - much
>> better than the previous 512 times for the 2M THP case.
>>
>> Contiguous swap entries are gathered in zap_pte_range() and
>> madvise_free_pte_range() in a similar way to how present ptes are
>> already gathered in zap_pte_range().
>>
>> While we are at it, let's simplify by converting the return type of both
>> functions to void. The return value was used only by zap_pte_range() to
>> print a bad pte, and was ignored by everyone else, so the extra
>> reporting wasn't exactly guaranteed. We will still get the warning with
>> most of the information from get_swap_device(). With the batch version,
>> we wouldn't know which pte was bad anyway so could print the wrong one.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/pgtable.h | 28 +++++++++++++++
>>  include/linux/swap.h    | 12 +++++--
>>  mm/internal.h           | 48 +++++++++++++++++++++++++
>>  mm/madvise.c            | 12 ++++---
>>  mm/memory.c             | 13 +++----
>>  mm/swapfile.c           | 78 ++++++++++++++++++++++++++++++-----------
>>  6 files changed, 157 insertions(+), 34 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 09c85c7bf9c2..8185939df1e8 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>>  }
>>  #endif
>>
>> +#ifndef clear_not_present_full_ptes
>> +/**
>> + * clear_not_present_full_ptes - Clear consecutive not present PTEs.
>> + * @mm: Address space the ptes represent.
>> + * @addr: Address of the first pte.
>> + * @ptep: Page table pointer for the first entry.
>> + * @nr: Number of entries to clear.
>> + * @full: Whether we are clearing a full mm.
>> + *
>> + * May be overridden by the architecture; otherwise, implemented as a simple
>> + * loop over pte_clear_not_present_full().
>> + *
>> + * Context: The caller holds the page table lock.  The PTEs are all not present.
>> + * The PTEs are all in the same PMD.
>> + */
>> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
>> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>> +{
>> +	for (;;) {
>> +		pte_clear_not_present_full(mm, addr, ptep, full);
>> +		if (--nr == 0)
>> +			break;
>> +		ptep++;
>> +		addr += PAGE_SIZE;
>> +	}
>> +}
>> +#endif
>> +
> 
> Would the code below be better?
> 
> for (i = 0; i < nr; i++, ptep++, addr += PAGE_SIZE)
> 	pte_clear_not_present_full(mm, addr, ptep, full);

I certainly agree that this is cleaner and more standard. But I'm copying the
pattern used by the other batch helpers. I believe this pattern was first done
by Willy for set_ptes(), then continued by DavidH for wrprotect_ptes() and
clear_full_ptes().

I guess the benefit is that ptep and addr are only incremented if we are going
around the loop again. I'd rather continue to be consistent with those other
helpers.


> 
> --
> Best Regards,
> Yan, Zi


