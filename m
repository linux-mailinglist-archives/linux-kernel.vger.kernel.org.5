Return-Path: <linux-kernel+bounces-120630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962688DA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC2B295DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16A381B0;
	Wed, 27 Mar 2024 09:51:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13C17F8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533071; cv=none; b=VsnlKr8cXlVKSMYyrTpN8zR6GWvudFeK1W4fUNAI8RuVfp0Qb3Jhb/T0oeZFGt6hdEHjYiSwmhA8SDB4oYuLAwBC+rxBT5Nzj+R4hkRVXqq/Ov6CzEZH/hlGyBnF929GtAOgrwrsksnbtn8NADLWhZaQTUktCy/1ZJii2vuyoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533071; c=relaxed/simple;
	bh=OJYryGjIzV2LHc5fNHYCX9Nv6VEM30mqUf0F3Fky2bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjU8RW6ns8CaSRuI8yJx9DqcgSnq8KaaoItCzQTbPxXHKxhiVHwu+eqSlwR7QoXuAedfCdVi43npmJhg4/IQUQ2NLg8sALz0qfjzY78BXIHGa0thlyUpLVql6mZQaD4DCkg3gNgvo48IUCYSr7D9GoAuDKDx+04A954o+05Ulew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1ED372F4;
	Wed, 27 Mar 2024 02:51:43 -0700 (PDT)
Received: from [10.57.72.121] (unknown [10.57.72.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191333F694;
	Wed, 27 Mar 2024 02:51:06 -0700 (PDT)
Message-ID: <de03fcd0-53fe-4672-b148-7a5eda19be03@arm.com>
Date: Wed, 27 Mar 2024 09:51:05 +0000
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
 <fb101fd1-e28a-4278-bf5f-e2dca0215a90@arm.com>
 <6aaff470-c510-469b-8f4f-2e4c5cf07d56@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6aaff470-c510-469b-8f4f-2e4c5cf07d56@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 17:58, David Hildenbrand wrote:
>>>>>
>>>>> vmf->orig_pte = ptep_get_lockless_norecency(vmf->pte)
>>>>> /* not dirty */
>>>>>
>>>>> /* Now, thread 2 ends up setting the PTE dirty under PT lock. */
>>
>> Ahh, this comment about thread 2 is not referring to the code immediately below
>> it. It all makes much more sense now. :)
> 
> Sorry :)
> 
>>
>>>>>
>>>>> spin_lock(vmf->ptl);
>>>>> entry = vmf->orig_pte;
>>>>> if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
>>>>>       ...
>>>>> }
>>>>> ...
>>>>> entry = pte_mkyoung(entry);
>>>>
>>>> Do you mean pte_mkdirty() here? You're talking about dirty everywhere else.
>>>
>>> No, that is just thread 1 seeing "oh, nothing to do" and then goes ahead and
>>> unconditionally does that in handle_pte_fault().
>>>
>>>>
>>>>> if (ptep_set_access_flags(vmf->vma, ...)
>>>>> ...
>>>>> pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>
>>>>>
>>>>> Generic ptep_set_access_flags() will do another pte_same() check and realize
>>>>> "hey, there was a change!" let's update the PTE!
>>>>>
>>>>> set_pte_at(vma->vm_mm, address, ptep, entry);
>>>>
>>>> This is called from the generic ptep_set_access_flags() in your example, right?
>>>>
>>>
>>> Yes.
>>>
>>>>>
>>>>> would overwrite the dirty bit set by thread 2.
>>>>
>>>> I'm not really sure what you are getting at... Is your concern that there is a
>>>> race where the page could become dirty in the meantime and it now gets lost? I
>>>> think that's why arm64 overrides ptep_set_access_flags(); since the hw can
>>>> update access/dirty we have to deal with the races.
>>>
>>> My concern is that your patch can in subtle ways lead to use losing PTE dirty
>>> bits on architectures that don't have the HW-managed dirty bit. They do exist ;)
>>
>> But I think the example you give can already happen today? Thread 1 reads
>> orig_pte = ptep_get_lockless(). So that's already racy, if thread 2 is going to
>> set dirty just after the get, then thread 1 is going to set the PTE back to (a
>> modified version of) orig_pte. Isn't it already broken?
> 
> No, because the pte_same() check under PTL would have detected it, and we would
> have backed out. And I think the problem comes to live when we convert
> pte_same()->pte_same_norecency(), because we fail to protect PTE access/dirty
> changes that happend under PTL from another thread.

Ahh yep. Got it. I absolutely knew that you would be correct, but I still walked
right into it!

I think one could argue that the generic ptep_set_access_flags() is not
implementing its own spec:

"
.. Only sets the access flags (dirty, accessed), as well as write permission.
Furthermore, we know it always gets set to a "more permissive" setting ...
"

Surely it should be folding the access and dirty bits from *ptep into entry if
they are set?

Regardless, I think this example proves that its fragile and subtle. I'm not
really sure how to fix it more generally/robustly. Any thoughts? If not perhaps
we are better off keeping ptep_get_lockless() around and only using
ptep_get_lockless_norecency() for the really obviously correct cases?


> 
> But could be I am missing something :)
> 
>>> Arm64 should be fine in that regard.
>>>
>>
>> There is plenty of arm64 HW that doesn't do HW access/dirty update. But our
>> ptep_set_access_flags() can always deal with a racing update, even if that
>> update originates from SW.
>>
>> Why do I have the feeling you're about to explain (very patiently) exactly why
>> I'm wrong?... :)
> 
> heh ... or you'll tell me (vary patiently) why I am wrong :)
> 


