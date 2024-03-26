Return-Path: <linux-kernel+bounces-119587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFAE88CAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C11F6533A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B361CD3D;
	Tue, 26 Mar 2024 17:27:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA7A95B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474065; cv=none; b=LSWGCCFgnJbHvTAhuWnql8z3n06WmEE5j/ZgTbIjgWE9kCEvCA0Vgj09tet5qjm6bD/LrbWAcbq/Az2KRavOdVNBasRVP25CeGwjewUKzSaQoyPMujW/NwJyxLJf2lPd7SYIDV0B03qFEfnUCi3GaRH4SejW7wlN56TzaQcUhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474065; c=relaxed/simple;
	bh=Jv983fbLexCSUC5jPm28L6QH4n30UubKbPZvwa3RIiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RugYS6vPG8hrTLjIvDuaye1WZEpGkbmLh0kgbm8W3rQQbCGKE39MGXtN3+cRDsE5FEc0nr3UupabNS4GDCnHxoSd/Gcq7qLGBwGeC2XN4LGXSi3gqgZ16D4/DNfs2C46C2lq57sGd5zhrWz9oTnCOFe2SGzS/e/P9RdZCQrCT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB002F4;
	Tue, 26 Mar 2024 10:28:16 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68693F64C;
	Tue, 26 Mar 2024 10:27:40 -0700 (PDT)
Message-ID: <febd0c97-8869-4ce5-bd37-cbbdf5be0a43@arm.com>
Date: Tue, 26 Mar 2024 17:27:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm/memory: Use ptep_get_lockless_norecency()
 for orig_pte
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
 <20240215121756.2734131-4-ryan.roberts@arm.com>
 <e0bdbd5e-a098-422a-90af-9cf07ce378a4@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e0bdbd5e-a098-422a-90af-9cf07ce378a4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 17:02, David Hildenbrand wrote:
> On 15.02.24 13:17, Ryan Roberts wrote:
>> Let's convert handle_pte_fault()'s use of ptep_get_lockless() to
>> ptep_get_lockless_norecency() to save orig_pte.
>>
>> There are a number of places that follow this model:
>>
>>      orig_pte = ptep_get_lockless(ptep)
>>      ...
>>      <lock>
>>      if (!pte_same(orig_pte, ptep_get(ptep)))
>>              // RACE!
>>      ...
>>      <unlock>
>>
>> So we need to be careful to convert all of those to use
>> pte_same_norecency() so that the access and dirty bits are excluded from
>> the comparison.
>>
>> Additionally there are a couple of places that genuinely rely on the
>> access and dirty bits of orig_pte, but with some careful refactoring, we
>> can use ptep_get() once we are holding the lock to achieve equivalent
>> logic.
> 
> We really should document that changed behavior somewhere where it can be easily
> found: that orig_pte might have incomplete/stale accessed/dirty information.

I could add it to the orig_pte definition in the `struct vm_fault`?

> 
> 
>> @@ -5343,7 +5356,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>                            vmf->address, &vmf->ptl);
>>           if (unlikely(!vmf->pte))
>>               return 0;
>> -        vmf->orig_pte = ptep_get_lockless(vmf->pte);
>> +        vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte);
>>           vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
>>
>>           if (pte_none(vmf->orig_pte)) {
>> @@ -5363,7 +5376,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>
>>       spin_lock(vmf->ptl);
>>       entry = vmf->orig_pte;
>> -    if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>> +    if (unlikely(!pte_same_norecency(ptep_get(vmf->pte), entry))) {
>>           update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>>           goto unlock;
> 
> I was wondering about the following:
> 
> Assume the PTE is not dirty.
> 
> Thread 1 does

Sorry not sure what threads have to do with this? How is the vmf shared between
threads? What have I misunderstood...

> 
> vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte)
> /* not dirty */
> 
> /* Now, thread 2 ends up setting the PTE dirty under PT lock. */
> 
> spin_lock(vmf->ptl);
> entry = vmf->orig_pte;
> if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>     ...
> }
> ...
> entry = pte_mkyoung(entry);

Do you mean pte_mkdirty() here? You're talking about dirty everywhere else.

> if (ptep_set_access_flags(vmf->vma, ...)
> ...
> pte_unmap_unlock(vmf->pte, vmf->ptl);
> 
> 
> Generic ptep_set_access_flags() will do another pte_same() check and realize
> "hey, there was a change!" let's update the PTE!
> 
> set_pte_at(vma->vm_mm, address, ptep, entry);

This is called from the generic ptep_set_access_flags() in your example, right?

> 
> would overwrite the dirty bit set by thread 2.

I'm not really sure what you are getting at... Is your concern that there is a
race where the page could become dirty in the meantime and it now gets lost? I
think that's why arm64 overrides ptep_set_access_flags(); since the hw can
update access/dirty we have to deal with the races.


