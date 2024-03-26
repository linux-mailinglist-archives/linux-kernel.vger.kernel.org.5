Return-Path: <linux-kernel+bounces-119623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9EE88CB46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD15D1C3743A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFD1F934;
	Tue, 26 Mar 2024 17:48:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C31CD31
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475338; cv=none; b=eYZHkYcrb/EYYWaEbXk0ouv5O7FHkpj+S4sLwsCTtDAJl+cwEnQW7/Q9kPVV2I/ls1gKlHadgdCvmHVbnoiORjxbhvydkVXoLQ1ejDOpouOx9eqYSDcXaMdYnAwqsRbxlUrlxuAvTQi/9kWPztg4SjvavEth3fLRnyU75w4qj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475338; c=relaxed/simple;
	bh=6IN+0joCT6s/F6ksB1V2YWol5vs9YStCqbIPnUs9JDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aogGCMu9aEfJwfuhdJ9OsNUYtVfgCfYz3tt02PYEiSxIsrAlb8A7NkYGChNLZxOvP0aiZxswctk4hmYVPULgwnV86hsibHA36AAdPpoAk/8KQNQU16EtvC36hm8vQ6iuEh+OLzPG4bYuzgDppRW6105Fs9fHeWK2qZJ13Zc8F0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F39BC2F4;
	Tue, 26 Mar 2024 10:49:27 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55DAE3F64C;
	Tue, 26 Mar 2024 10:48:52 -0700 (PDT)
Message-ID: <fb101fd1-e28a-4278-bf5f-e2dca0215a90@arm.com>
Date: Tue, 26 Mar 2024 17:48:52 +0000
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
 <febd0c97-8869-4ce5-bd37-cbbdf5be0a43@arm.com>
 <f6996c4f-da60-4267-bcf1-09e4fd40c91b@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f6996c4f-da60-4267-bcf1-09e4fd40c91b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 17:38, David Hildenbrand wrote:
> On 26.03.24 18:27, Ryan Roberts wrote:
>> On 26/03/2024 17:02, David Hildenbrand wrote:
>>> On 15.02.24 13:17, Ryan Roberts wrote:
>>>> Let's convert handle_pte_fault()'s use of ptep_get_lockless() to
>>>> ptep_get_lockless_norecency() to save orig_pte.
>>>>
>>>> There are a number of places that follow this model:
>>>>
>>>>       orig_pte = ptep_get_lockless(ptep)
>>>>       ...
>>>>       <lock>
>>>>       if (!pte_same(orig_pte, ptep_get(ptep)))
>>>>               // RACE!
>>>>       ...
>>>>       <unlock>
>>>>
>>>> So we need to be careful to convert all of those to use
>>>> pte_same_norecency() so that the access and dirty bits are excluded from
>>>> the comparison.
>>>>
>>>> Additionally there are a couple of places that genuinely rely on the
>>>> access and dirty bits of orig_pte, but with some careful refactoring, we
>>>> can use ptep_get() once we are holding the lock to achieve equivalent
>>>> logic.
>>>
>>> We really should document that changed behavior somewhere where it can be easily
>>> found: that orig_pte might have incomplete/stale accessed/dirty information.
>>
>> I could add it to the orig_pte definition in the `struct vm_fault`?
>>
>>>
>>>
>>>> @@ -5343,7 +5356,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>>>                             vmf->address, &vmf->ptl);
>>>>            if (unlikely(!vmf->pte))
>>>>                return 0;
>>>> -        vmf->orig_pte = ptep_get_lockless(vmf->pte);
>>>> +        vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte);
>>>>            vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
>>>>
>>>>            if (pte_none(vmf->orig_pte)) {
>>>> @@ -5363,7 +5376,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>>>
>>>>        spin_lock(vmf->ptl);
>>>>        entry = vmf->orig_pte;
>>>> -    if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>>>> +    if (unlikely(!pte_same_norecency(ptep_get(vmf->pte), entry))) {
>>>>            update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>>>>            goto unlock;
>>>
>>> I was wondering about the following:
>>>
>>> Assume the PTE is not dirty.
>>>
>>> Thread 1 does
>>
>> Sorry not sure what threads have to do with this? How is the vmf shared between
>> threads? What have I misunderstood...
> 
> Assume we have a HW that does not have HW-managed access/dirty bits. One that
> ends up using generic ptep_set_access_flags(). Access/dirty bits are always
> updated under PT lock.
> 
> Then, imagine two threads. One is the the fault path here. another thread
> performs some other magic that sets the PTE dirty under PTL.
> 
>>
>>>
>>> vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte)
>>> /* not dirty */
>>>
>>> /* Now, thread 2 ends up setting the PTE dirty under PT lock. */

Ahh, this comment about thread 2 is not referring to the code immediately below
it. It all makes much more sense now. :)

>>>
>>> spin_lock(vmf->ptl);
>>> entry = vmf->orig_pte;
>>> if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>>>      ...
>>> }
>>> ...
>>> entry = pte_mkyoung(entry);
>>
>> Do you mean pte_mkdirty() here? You're talking about dirty everywhere else.
> 
> No, that is just thread 1 seeing "oh, nothing to do" and then goes ahead and
> unconditionally does that in handle_pte_fault().
> 
>>
>>> if (ptep_set_access_flags(vmf->vma, ...)
>>> ...
>>> pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>
>>>
>>> Generic ptep_set_access_flags() will do another pte_same() check and realize
>>> "hey, there was a change!" let's update the PTE!
>>>
>>> set_pte_at(vma->vm_mm, address, ptep, entry);
>>
>> This is called from the generic ptep_set_access_flags() in your example, right?
>>
> 
> Yes.
> 
>>>
>>> would overwrite the dirty bit set by thread 2.
>>
>> I'm not really sure what you are getting at... Is your concern that there is a
>> race where the page could become dirty in the meantime and it now gets lost? I
>> think that's why arm64 overrides ptep_set_access_flags(); since the hw can
>> update access/dirty we have to deal with the races.
> 
> My concern is that your patch can in subtle ways lead to use losing PTE dirty
> bits on architectures that don't have the HW-managed dirty bit. They do exist ;)

But I think the example you give can already happen today? Thread 1 reads
orig_pte = ptep_get_lockless(). So that's already racy, if thread 2 is going to
set dirty just after the get, then thread 1 is going to set the PTE back to (a
modified version of) orig_pte. Isn't it already broken?


> 
> Arm64 should be fine in that regard.
> 

There is plenty of arm64 HW that doesn't do HW access/dirty update. But our
ptep_set_access_flags() can always deal with a racing update, even if that
update originates from SW.

Why do I have the feeling you're about to explain (very patiently) exactly why
I'm wrong?... :)


