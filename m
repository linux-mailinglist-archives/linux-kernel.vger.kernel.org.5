Return-Path: <linux-kernel+bounces-119508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CED88C9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F59A1C650CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067DF1C69D;
	Tue, 26 Mar 2024 16:48:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43A1C69C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471731; cv=none; b=DQyqMj7CcgTqRhilmSxzX+NkpiVuTAGvxeltiDNP71wluLWh/cl47VHB8xZSFhO5UUAc6RuQ1VYpkTRz13P+nxK02WGOp9ac3ygaLUQyEEAo1EuVZyuQCh2DsSOBRxilKIYSKUZRMRSOnSbYcDuY1blcIft2ucGbHFR5esN7UNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471731; c=relaxed/simple;
	bh=dOBYFG2CFVG88RBbN6IiQLjRxxljLiWi7mMX9/e5kiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzO5nGFvKRylEKNaJeIK0kdWflY7FEE1QmG79HSc1T1WT4dDB1nldvupVmd4qA8FtMZfG1JVQXS1ROI/YPYX4lE6r6Y3OrVcfrEZixy5rgmbzeDko4kX4xuJqT+DLHPMlm81DLZZYQn8ghdsUkyLa3T9olytLLVh7Y4SFGWIfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5E172F4;
	Tue, 26 Mar 2024 09:49:22 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69D4D3F694;
	Tue, 26 Mar 2024 09:48:47 -0700 (PDT)
Message-ID: <79ade347-419a-4c9e-84db-def06ec5f36a@arm.com>
Date: Tue, 26 Mar 2024 16:48:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] mm/gup: Use ptep_get_lockless_norecency()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <20240215121756.2734131-3-ryan.roberts@arm.com>
 <5d80c368-7ce7-4a44-9cd7-aee3e1c9182b@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5d80c368-7ce7-4a44-9cd7-aee3e1c9182b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 16:30, David Hildenbrand wrote:
> On 15.02.24 13:17, Ryan Roberts wrote:
>> Gup needs to read ptes locklessly, so it uses ptep_get_lockless().
>> However, the returned access and dirty bits are unimportant so let's
>> switch over to ptep_get_lockless_norecency().
>>
>> The wrinkle is that gup needs to check that the pte hasn't changed once
>> it has pinned the folio following this model:
>>
>>      pte = ptep_get_lockless_norecency(ptep)
>>      ...
>>      if (!pte_same(pte, ptep_get_lockless(ptep)))
>>              // RACE!
>>      ...
>>
>> And now that pte may not contain correct access and dirty information,
>> the pte_same() comparison could spuriously fail. So let's introduce a
>> new pte_same_norecency() helper which will ignore the access and dirty
>> bits when doing the comparison.
>>
>> Note that previously, ptep_get() was being used for the comparison; this
>> is technically incorrect because the PTL is not held. I've also
>> converted the comparison to use the preferred pmd_same() helper instead
>> of doing a raw value comparison.
>>
>> As a side-effect, this new approach removes the possibility of
>> concurrent read/write to the page causing a spurious fast gup failure,
>> because the access and dirty bits are no longer used in the comparison.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
> 
> [...]
> 
>>   #ifndef __HAVE_ARCH_PTE_UNUSED
>>   /*
>>    * Some architectures provide facilities to virtualization guests
>> diff --git a/mm/gup.c b/mm/gup.c
>> index df83182ec72d..0f96d0a5ec09 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2576,7 +2576,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp,
>> unsigned long addr,
>>       if (!ptep)
>>           return 0;
>>       do {
>> -        pte_t pte = ptep_get_lockless(ptep);
>> +        pte_t pte = ptep_get_lockless_norecency(ptep);
>>           struct page *page;
>>           struct folio *folio;
>>
>> @@ -2617,8 +2617,9 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp,
>> unsigned long addr,
>>               goto pte_unmap;
>>           }
>>
>> -        if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>> -            unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
>> +        if (unlikely(!pmd_same(pmd, *pmdp)) ||
>> +            unlikely(!pte_same_norecency(pte,
>> +                    ptep_get_lockless_norecency(ptep)))) {
>>               gup_put_folio(folio, 1, flags);
>>               goto pte_unmap;
> 
> We pass the pte into pte_access_permitted(). It would be good to mention that
> you checked all implementations.

TBH, I hadn't; I decided that since the "inaccurate access/dirty bits" was only
possible on arm64, then only arm64's implementation needed checking. But given
your comment, I just had a quick look at all impls. I didn't spot any problems
where any impl needs the access/dirty bits. I'll add this to the commit log.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


