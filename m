Return-Path: <linux-kernel+bounces-76160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE085F3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24582283A93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E24376F9;
	Thu, 22 Feb 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZxnEK7kM"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257537711
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592223; cv=none; b=Iv+/S0SWL1TWB/laVlgBel4bxDQUIa8D0QBdw7sk+arnGejsF0eoXBNKqhVUQ7fhBTP2xHClFbQ1rJCXqNDUUq1AjZusbe1WCH9l70jn4WfWXbEBPQnzjfr9STNlgMcjJ97kXBnBt1e2FwmxvhBNs+Ege/jMbX7FL8VgeNdU+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592223; c=relaxed/simple;
	bh=FBWRtuth2Yv1KKihVJvAJQ16++bjnhnjyDxJvHloM/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=trvBnu7rQc6h8GqBHwbEzdGc8myLlH3+rzB7r0NnsCEXMWWoch7hozJfF8g+aIu2NfpcYQlRIzOI1EG+UBZoaN3s84qRmdxKkBdzY/ltDy54oPPPs56MTUc+Wz8VYK0bRvgkNNZoxg1jKSwjTu0AL9ymSUPksbkWRVPYH8fokzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZxnEK7kM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9b4624a-214d-2f49-3883-4d62f60a9de4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708592203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWKE7NjmOpKnuDYaoiaD8eNu+PXdRJkjU2KqUazNjX4=;
	b=ZxnEK7kMOyA0KZojbYbbD/Hvztl9lAOb0OdyMRodQ7touYDwg/xTNGT2fz47ZbQ83a+EWh
	+o/X+mEhgHxE/5SMqys6BzJ8dcLgd+GdReUts7FyyTrrnqET88L9ajD2W+zVZAqJ+HSfqM
	nbcpq/DyPu45neplCrBloTwLS8Em+vc=
Date: Thu, 22 Feb 2024 16:56:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: convert all mas except mas_detach to vma
 iterator
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>, akpm@linux-foundation.org,
 vbabka@suse.cz, lstoakes@gmail.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240218023155.2684469-1-yajun.deng@linux.dev>
 <9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev>
 <20240220180603.dhnthx2nk5455opm@revolver>
 <0ff93990-b8b6-89ce-0174-4023599059e7@linux.dev>
 <20240221143103.bkhewpq2wirsoyqw@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240221143103.bkhewpq2wirsoyqw@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/21 22:31, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240220 22:26]:
>> On 2024/2/21 02:06, Liam R. Howlett wrote:
>>> * Yajun Deng <yajun.deng@linux.dev> [240218 21:30]:
>>>> Cc:  Vlastimil, Lorenzo,Suren
>>>>
>>>> On 2024/2/18 10:31, Yajun Deng wrote:
>>>>> There are two types of iterators mas and vmi in the current code. If the
>>>>> maple tree comes from the mm struct, we can use vma iterator. Avoid using
>>>>> mas directly.
>>> Thanks for looking at this.
>>>
>>> I had left the maple state exposed in the mmap.c file because it does a
>>> number of operations that no one else does, so the new functions will be
>>> called a very limited number of times (as low as once).
>>>
>>> I think this is a worth while change since this may be needed in the
>>> future for dealing with more specialised uses of the tree.  It also
>>> removes the 0/ULONG_MAX limits from certain calls, and the vma iterator
>>> names help explain things.
>>>
>>> I don't know why you treat the low/high search differently than the
>>> mas_reset() and mas_*_range(). In any case, the comment is inaccurate
>>> when mas_ functions are called with &vmi.mas in places.
>>>
>>>
>> Because the mas_reset() and mas_*_range() only covert mas to vmi. It's
>> simple.
>>
>> But the low/high also covert max to max - 1. It's a little more complex.
> Ah, so the code doesn't match the comment, since the code will still use
> mas directly in this version.  This was, perhaps, the largest issue with
> the patch.  Having a good patch log is very important as people rely on
> it during reviews, but more importantly when tracking down an issue
> later on.
>
> I like the idea of removing as many mas uses as feasible, but we will
> still have a few that must be passed through, so please change the
> wording.
>

Okay.

>>>>> Leave the mt_detach tree keep using mas, as it doesn't come from the mm
>>>>> struct.
>>> Well, it's still VMAs from the mm struct.  I agree that we should not
>>> change this for now.
>>>
>>>>> Convert all mas except mas_detach to vma iterator. And introduce
>>>>> vma_iter_area_{lowest, highest} helper functions for use vma interator.
>>> Do you mean mas functions?  You do pass the maple state through to other
>>> areas.  ie: free_pgtables().
>>
>> Yes.
> ...
>>>>>     retry:
>>>>> -	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
>>>>> +	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
>>>>>     		return -ENOMEM;
>>>>> -	gap = mas.last + 1 - info->length;
>>>>> +	gap = vma_iter_end(&vmi) - info->length;
>>>>>     	gap -= (gap - info->align_offset) & info->align_mask;
>>>>> -	gap_end = mas.last;
>>>>> -	tmp = mas_next(&mas, ULONG_MAX);
>>>>> +	gap_end = vma_iter_end(&vmi);
>>> vma_iter_end will return vmi->mas.last + 1, is what you have here
>>> correct?
>>>
>> Yes, the following changes 'if (vm_start_gap(tmp) <= gap_end)' to 'if
>> (vm_start_gap(tmp) < gap_end)'.
>>
>>>>> +	tmp = vma_next(&vmi);
>>>>>     	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
>>>>> -		if (vm_start_gap(tmp) <= gap_end) {
>>>>> +		if (vm_start_gap(tmp) < gap_end) {
> Thanks.  This works and the variable isn't used again.
>
> ...
>>>>> @@ -1959,11 +1958,12 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>>>     	struct vm_area_struct *next;
>>>>>     	unsigned long gap_addr;
>>>>>     	int error = 0;
>>>>> -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
>>>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>>>     	if (!(vma->vm_flags & VM_GROWSUP))
>>>>>     		return -EFAULT;
>>>>> +	vma_iter_config(&vmi, vma->vm_start, address);
>>> This is confusing.  I think you are doing this so that the vma iterator
>>> is set up the same as the maple state, and not what is logically
>>> necessary?
>>
>> Yes, VMA_ITERATOR can only pass one address.
>>
>>>>>     	/* Guard against exceeding limits of the address space. */
>>>>>     	address &= PAGE_MASK;
>>>>>     	if (address >= (TASK_SIZE & PAGE_MASK))
>>>>> @@ -1985,15 +1985,15 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>>>     	}
>>>>>     	if (next)
>>>>> -		mas_prev_range(&mas, address);
>>>>> +		mas_prev_range(&vmi.mas, address);
>>> This isn't really hiding the maple state.
>>
>> Okay,  I will create a new helper function for this in the mm/internal.h.
>>
>>>
>>>>> -	__mas_set_range(&mas, vma->vm_start, address - 1);
>>>>> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
>>>>> +	vma_iter_config(&vmi, vma->vm_start, address);
>>> The above maple state changes is to get the maple state to point to the
>>> correct area for the preallocation call below.  This seems unnecessary
>>> to me.
>>>
>>> We really should just set it up correctly.  Unfortunately, with the VMA
>>> iterator, that's not really possible on initialization.
>>>
>>> What we can do is use the vma->vm_start for the initialization, then use
>>> vma_iter_config() here.  That will not reset any state - but that's fine
>>> because the preallocation is the first call that actually uses it
>>> anyways.
>>>
>>> So we can initialize with vma->vm_start, don't call vma_iter_config
>>> until here, and also drop the if (next) part.
>>>
>>> This is possible here because it's not optimised like the
>>> expand_upwards() case, which uses the state to check prev and avoids an
>>> extra walk.
>>>
>>> Please make sure to test with the ltp tests on the stack combining, etc
>>> on a platform that expands down.


It seems something wrong about this description. This change is in 
expand_upwards(), but not in

expand_downwards(). So we should test it on a platform that expands up. 
And drop the if (next) part

is unnecessary. Did I get that right?

>>
>> Okay, I will test it.
> Testing this can be tricky.  Thanks for looking at it.
>
> ...
>>>>>     	mmap_write_lock(mm);
>>>>>     	mt_clear_in_rcu(&mm->mm_mt);
>>>>> -	mas_set(&mas, vma->vm_end);
>>>>> -	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
>>>>> +	vma_iter_set(&vmi, vma->vm_end);
>>>>> +	free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
>>>>>     		      USER_PGTABLES_CEILING, true);
>>> I guess the page tables still deal with the maple state directly then.
>>
>> Yes.
> That's okay, we can leave that for another time.  I believe Peng
> complicated the internals of free_pgtables() with his forking
> optimisation so care will need to be taken and should probably be done
> in another patch, another time.  In fact, hiding xa_is_zero() within the
> vma iterator is going to be a really good thing to do, if performance
> doesn't suffer.
>
> Just don't state we are removing the use of maple state in the change
> log - since we do pass it through sometimes.
>
> ...
>
> Thanks again,
> Liam

