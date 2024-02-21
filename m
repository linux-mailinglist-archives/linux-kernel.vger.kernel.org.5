Return-Path: <linux-kernel+bounces-73998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5B85CEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A1AB22C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7B364C4;
	Wed, 21 Feb 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifuQRQq7"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7C23C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708485973; cv=none; b=QBz/oCZ1igMKyEQsoUclV51pzYHOzBeiAiflEFg49T3cURWVsbMqwmTFieJwcr+R+/0At1G8xj/fEv3T3IZC3MBmzZcAmfl4KHuFoGnjsrqGliugXXjI3epWdAAdX6DBTSxAJKJTWLKUwMbhXGSY1givaWxf2gzTNN8RfyWa/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708485973; c=relaxed/simple;
	bh=9SW7INwu2nXJDhb7RbJr7ULpD9R5vJzceX2iWz8Vc7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ALDGwF15M3tGwkuwGCPt4Fjwl97AQtG4JGkr6BNAO/7wztk5Ng+YuapXJnAYXB6YTwDwlNQYxgYoh8ymZU7bUKO8BELF4YnNN88ixkP6lkJzDGmmsr1gW0ZcZKUVlJ6WFhLFUqJpF5d6zeKUwsrEaleDD6zS67HnyZI8eyhF8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifuQRQq7; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ff93990-b8b6-89ce-0174-4023599059e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708485962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNK/PGZagtBR1qslPXdArTywReXAXHYyTZO5X4wWRY8=;
	b=ifuQRQq7aX872VE9Q6JH+cnzrdSOkSXwmhl30EBe+cWANHBdA+GZJWq0NvyOgzJMA+Nq6H
	C7i+F2HdJ1nLcuJ1cpDRZFmt6wQWsMFF6mo5D3HD26qLxdwmIlvjZLGGvry8kDPjYKD5tF
	4IYta8Bq0+9sH1+JmS1YojlkNdvy9lI=
Date: Wed, 21 Feb 2024 11:25:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: convert all mas except mas_detach to vma
 iterator
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20240218023155.2684469-1-yajun.deng@linux.dev>
 <9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev>
 <20240220180603.dhnthx2nk5455opm@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
 surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240220180603.dhnthx2nk5455opm@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/21 02:06, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240218 21:30]:
>> Cc:  Vlastimil, Lorenzo,Suren
>>
>> On 2024/2/18 10:31, Yajun Deng wrote:
>>> There are two types of iterators mas and vmi in the current code. If the
>>> maple tree comes from the mm struct, we can use vma iterator. Avoid using
>>> mas directly.
> Thanks for looking at this.
>
> I had left the maple state exposed in the mmap.c file because it does a
> number of operations that no one else does, so the new functions will be
> called a very limited number of times (as low as once).
>
> I think this is a worth while change since this may be needed in the
> future for dealing with more specialised uses of the tree.  It also
> removes the 0/ULONG_MAX limits from certain calls, and the vma iterator
> names help explain things.
>
> I don't know why you treat the low/high search differently than the
> mas_reset() and mas_*_range(). In any case, the comment is inaccurate
> when mas_ functions are called with &vmi.mas in places.
>
>

Because the mas_reset() and mas_*_range() only covert mas to vmi. It's 
simple.

But the low/high also covert max to max - 1. It's a little more complex.

>>> Leave the mt_detach tree keep using mas, as it doesn't come from the mm
>>> struct.
> Well, it's still VMAs from the mm struct.  I agree that we should not
> change this for now.
>
>>> Convert all mas except mas_detach to vma iterator. And introduce
>>> vma_iter_area_{lowest, highest} helper functions for use vma interator.
> Do you mean mas functions?  You do pass the maple state through to other
> areas.  ie: free_pgtables().


Yes.

>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>> ---
>>>    mm/internal.h |  12 ++++++
>>>    mm/mmap.c     | 114 +++++++++++++++++++++++++-------------------------
>>>    2 files changed, 69 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 1e29c5821a1d..6117e63a7acc 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1147,6 +1147,18 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
>>>    	__mas_set_range(&vmi->mas, index, last - 1);
>>>    }
>>> +static inline int vma_iter_area_lowest(struct vma_iterator *vmi, unsigned long min,
>>> +				       unsigned long max, unsigned long size)
> Is this spacing okay?  It looks off in email and on lore.
>
>

Yes, it's fine after applying the patch.

>>> +{
>>> +	return mas_empty_area(&vmi->mas, min, max - 1, size);
>>> +}
>>> +
>>> +static inline int vma_iter_area_highest(struct vma_iterator *vmi, unsigned long min,
>>> +					unsigned long max, unsigned long size)
> Same spacing question here, could be fine though.
>
>>> +{
>>> +	return mas_empty_area_rev(&vmi->mas, min, max - 1, size);
>>> +}
>>> +
>>>    /*
>>>     * VMA Iterator functions shared between nommu and mmap
>>>     */
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index 7a9d2895a1bd..2fc38bf0d1aa 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>>> @@ -1104,21 +1104,21 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
>>>     */
>>>    struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
>>>    {
>>> -	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
>>>    	struct anon_vma *anon_vma = NULL;
>>>    	struct vm_area_struct *prev, *next;
>>> +	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_end);
>>>    	/* Try next first. */
>>> -	next = mas_walk(&mas);
>>> +	next = vma_iter_load(&vmi);
>>>    	if (next) {
>>>    		anon_vma = reusable_anon_vma(next, vma, next);
>>>    		if (anon_vma)
>>>    			return anon_vma;
>>>    	}
>>> -	prev = mas_prev(&mas, 0);
>>> +	prev = vma_prev(&vmi);
>>>    	VM_BUG_ON_VMA(prev != vma, vma);
>>> -	prev = mas_prev(&mas, 0);
>>> +	prev = vma_prev(&vmi);
>>>    	/* Try prev next. */
>>>    	if (prev)
>>>    		anon_vma = reusable_anon_vma(prev, prev, vma);
>>> @@ -1566,8 +1566,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>>>    	unsigned long length, gap;
>>>    	unsigned long low_limit, high_limit;
>>>    	struct vm_area_struct *tmp;
>>> -
>>> -	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
>>> +	VMA_ITERATOR(vmi, current->mm, 0);
> Should have a new line here.  In fact, the new line was before this so
> checkpatch.pl wouldn't complain - did you run checkpatch.pl against the
> patch?


Yes, remove the new line and checkpatch.pl wouldn't complain.

I don't think we need a new line here. Because the other functions don't 
have a new line here.

> I don't really like that it complains here, but I maintain the new line
> if a function had one already.
>
>
>>>    	/* Adjust search length to account for worst case alignment overhead */
>>>    	length = info->length + info->align_mask;
>>> @@ -1579,23 +1578,23 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>>>    		low_limit = mmap_min_addr;
>>>    	high_limit = info->high_limit;
>>>    retry:
>>> -	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
>>> +	if (vma_iter_area_lowest(&vmi, low_limit, high_limit, length))
>>>    		return -ENOMEM;
>>> -	gap = mas.index;
>>> +	gap = vma_iter_addr(&vmi);
>>>    	gap += (info->align_offset - gap) & info->align_mask;
>>> -	tmp = mas_next(&mas, ULONG_MAX);
>>> +	tmp = vma_next(&vmi);
>>>    	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
>>>    		if (vm_start_gap(tmp) < gap + length - 1) {
>>>    			low_limit = tmp->vm_end;
>>> -			mas_reset(&mas);
>>> +			mas_reset(&vmi.mas);
> If you're going to convert the maple state, create a static inline for
> this too in the mm/internal.h.  There are four of these mas_reset()
> calls by my count.


Okay.

>>>    			goto retry;
>>>    		}
>>>    	} else {
>>> -		tmp = mas_prev(&mas, 0);
>>> +		tmp = vma_prev(&vmi);
>>>    		if (tmp && vm_end_gap(tmp) > gap) {
>>>    			low_limit = vm_end_gap(tmp);
>>> -			mas_reset(&mas);
>>> +			mas_reset(&vmi.mas);
>>>    			goto retry;
>>>    		}
>>>    	}
>>> @@ -1618,8 +1617,8 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>>>    	unsigned long length, gap, gap_end;
>>>    	unsigned long low_limit, high_limit;
>>>    	struct vm_area_struct *tmp;
>>> +	VMA_ITERATOR(vmi, current->mm, 0);
>>> -	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
>>>    	/* Adjust search length to account for worst case alignment overhead */
>>>    	length = info->length + info->align_mask;
>>>    	if (length < info->length)
>>> @@ -1630,24 +1629,24 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>>>    		low_limit = mmap_min_addr;
>>>    	high_limit = info->high_limit;
>>>    retry:
>>> -	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
>>> +	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
>>>    		return -ENOMEM;
>>> -	gap = mas.last + 1 - info->length;
>>> +	gap = vma_iter_end(&vmi) - info->length;
>>>    	gap -= (gap - info->align_offset) & info->align_mask;
>>> -	gap_end = mas.last;
>>> -	tmp = mas_next(&mas, ULONG_MAX);
>>> +	gap_end = vma_iter_end(&vmi);
> vma_iter_end will return vmi->mas.last + 1, is what you have here
> correct?
>

Yes, the following changes 'if (vm_start_gap(tmp) <= gap_end)' to 'if 
(vm_start_gap(tmp) < gap_end)'.

>>> +	tmp = vma_next(&vmi);
>>>    	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
>>> -		if (vm_start_gap(tmp) <= gap_end) {
>>> +		if (vm_start_gap(tmp) < gap_end) {
>>>    			high_limit = vm_start_gap(tmp);
>>> -			mas_reset(&mas);
>>> +			mas_reset(&vmi.mas);
>>>    			goto retry;
>>>    		}
>>>    	} else {
>>> -		tmp = mas_prev(&mas, 0);
>>> +		tmp = vma_prev(&vmi);
>>>    		if (tmp && vm_end_gap(tmp) > gap) {
>>>    			high_limit = tmp->vm_start;
>>> -			mas_reset(&mas);
>>> +			mas_reset(&vmi.mas);
>>>    			goto retry;
>>>    		}
>>>    	}
>>> @@ -1900,12 +1899,12 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
>>>    			struct vm_area_struct **pprev)
>>>    {
>>>    	struct vm_area_struct *vma;
>>> -	MA_STATE(mas, &mm->mm_mt, addr, addr);
>>> +	VMA_ITERATOR(vmi, mm, addr);
>>> -	vma = mas_walk(&mas);
>>> -	*pprev = mas_prev(&mas, 0);
>>> +	vma = vma_iter_load(&vmi);
>>> +	*pprev = vma_prev(&vmi);
>>>    	if (!vma)
>>> -		vma = mas_next(&mas, ULONG_MAX);
>>> +		vma = vma_next(&vmi);
>>>    	return vma;
>>>    }
>>> @@ -1959,11 +1958,12 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>    	struct vm_area_struct *next;
>>>    	unsigned long gap_addr;
>>>    	int error = 0;
>>> -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>    	if (!(vma->vm_flags & VM_GROWSUP))
>>>    		return -EFAULT;
>>> +	vma_iter_config(&vmi, vma->vm_start, address);
> This is confusing.  I think you are doing this so that the vma iterator
> is set up the same as the maple state, and not what is logically
> necessary?


Yes, VMA_ITERATOR can only pass one address.

>
>>>    	/* Guard against exceeding limits of the address space. */
>>>    	address &= PAGE_MASK;
>>>    	if (address >= (TASK_SIZE & PAGE_MASK))
>>> @@ -1985,15 +1985,15 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>    	}
>>>    	if (next)
>>> -		mas_prev_range(&mas, address);
>>> +		mas_prev_range(&vmi.mas, address);
> This isn't really hiding the maple state.


Okay,  I will create a new helper function for this in the mm/internal.h.

>
>
>>> -	__mas_set_range(&mas, vma->vm_start, address - 1);
>>> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
>>> +	vma_iter_config(&vmi, vma->vm_start, address);
> The above maple state changes is to get the maple state to point to the
> correct area for the preallocation call below.  This seems unnecessary
> to me.
>
> We really should just set it up correctly.  Unfortunately, with the VMA
> iterator, that's not really possible on initialization.
>
> What we can do is use the vma->vm_start for the initialization, then use
> vma_iter_config() here.  That will not reset any state - but that's fine
> because the preallocation is the first call that actually uses it
> anyways.
>
> So we can initialize with vma->vm_start, don't call vma_iter_config
> until here, and also drop the if (next) part.
>
> This is possible here because it's not optimised like the
> expand_upwards() case, which uses the state to check prev and avoids an
> extra walk.
>
> Please make sure to test with the ltp tests on the stack combining, etc
> on a platform that expands down.


Okay, I will test it.

>>> +	if (vma_iter_prealloc(&vmi, vma))
>>>    		return -ENOMEM;
>>>    	/* We must make sure the anon_vma is allocated. */
>>>    	if (unlikely(anon_vma_prepare(vma))) {
>>> -		mas_destroy(&mas);
>>> +		vma_iter_free(&vmi);
>>>    		return -ENOMEM;
>>>    	}
>>> @@ -2033,7 +2033,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>    				anon_vma_interval_tree_pre_update_vma(vma);
>>>    				vma->vm_end = address;
>>>    				/* Overwrite old entry in mtree. */
>>> -				mas_store_prealloc(&mas, vma);
>>> +				vma_iter_store(&vmi, vma);
>>>    				anon_vma_interval_tree_post_update_vma(vma);
>>>    				spin_unlock(&mm->page_table_lock);
>>> @@ -2042,7 +2042,7 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>    		}
>>>    	}
>>>    	anon_vma_unlock_write(vma->anon_vma);
>>> -	mas_destroy(&mas);
>>> +	vma_iter_free(&vmi);
>>>    	validate_mm(mm);
>>>    	return error;
>>>    }
>>> @@ -2055,9 +2055,9 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>    int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>>>    {
>>>    	struct mm_struct *mm = vma->vm_mm;
>>> -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
>>>    	struct vm_area_struct *prev;
>>>    	int error = 0;
>>> +	VMA_ITERATOR(vmi, mm, vma->vm_start);
>>>    	if (!(vma->vm_flags & VM_GROWSDOWN))
>>>    		return -EFAULT;
>>> @@ -2067,7 +2067,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>>>    		return -EPERM;
>>>    	/* Enforce stack_guard_gap */
>>> -	prev = mas_prev(&mas, 0);
>>> +	prev = vma_prev(&vmi);
>>>    	/* Check that both stack segments have the same anon_vma? */
>>>    	if (prev) {
>>>    		if (!(prev->vm_flags & VM_GROWSDOWN) &&
>>> @@ -2077,15 +2077,15 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>>>    	}
>>>    	if (prev)
>>> -		mas_next_range(&mas, vma->vm_start);
>>> +		mas_next_range(&vmi.mas, vma->vm_start);
> Not really hiding the maple state or the mas_* functions here.


I will do it in v2.

>
>>> -	__mas_set_range(&mas, address, vma->vm_end - 1);
>>> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
>>> +	vma_iter_config(&vmi, address, vma->vm_end);
>>> +	if (vma_iter_prealloc(&vmi, vma))
>>>    		return -ENOMEM;
>>>    	/* We must make sure the anon_vma is allocated. */
>>>    	if (unlikely(anon_vma_prepare(vma))) {
>>> -		mas_destroy(&mas);
>>> +		vma_iter_free(&vmi);
>>>    		return -ENOMEM;
>>>    	}
>>> @@ -2126,7 +2126,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>>>    				vma->vm_start = address;
>>>    				vma->vm_pgoff -= grow;
>>>    				/* Overwrite old entry in mtree. */
>>> -				mas_store_prealloc(&mas, vma);
>>> +				vma_iter_store(&vmi, vma);
>>>    				anon_vma_interval_tree_post_update_vma(vma);
>>>    				spin_unlock(&mm->page_table_lock);
>>> @@ -2135,7 +2135,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>>>    		}
>>>    	}
>>>    	anon_vma_unlock_write(vma->anon_vma);
>>> -	mas_destroy(&mas);
>>> +	vma_iter_free(&vmi);
>>>    	validate_mm(mm);
>>>    	return error;
>>>    }
>>> @@ -3233,7 +3233,7 @@ void exit_mmap(struct mm_struct *mm)
>>>    	struct mmu_gather tlb;
>>>    	struct vm_area_struct *vma;
>>>    	unsigned long nr_accounted = 0;
>>> -	MA_STATE(mas, &mm->mm_mt, 0, 0);
>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>    	int count = 0;
>>>    	/* mm's last user has gone, and its about to be pulled down */
>>> @@ -3242,7 +3242,7 @@ void exit_mmap(struct mm_struct *mm)
>>>    	mmap_read_lock(mm);
>>>    	arch_exit_mmap(mm);
>>> -	vma = mas_find(&mas, ULONG_MAX);
>>> +	vma = vma_next(&vmi);
>>>    	if (!vma || unlikely(xa_is_zero(vma))) {
>>>    		/* Can happen if dup_mmap() received an OOM */
>>>    		mmap_read_unlock(mm);
>>> @@ -3255,7 +3255,7 @@ void exit_mmap(struct mm_struct *mm)
>>>    	tlb_gather_mmu_fullmm(&tlb, mm);
>>>    	/* update_hiwater_rss(mm) here? but nobody should be looking */
>>>    	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
>>> -	unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
>>> +	unmap_vmas(&tlb, &vmi.mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
>>>    	mmap_read_unlock(mm);
>>>    	/*
>>> @@ -3265,8 +3265,8 @@ void exit_mmap(struct mm_struct *mm)
>>>    	set_bit(MMF_OOM_SKIP, &mm->flags);
>>>    	mmap_write_lock(mm);
>>>    	mt_clear_in_rcu(&mm->mm_mt);
>>> -	mas_set(&mas, vma->vm_end);
>>> -	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
>>> +	vma_iter_set(&vmi, vma->vm_end);
>>> +	free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
>>>    		      USER_PGTABLES_CEILING, true);
> I guess the page tables still deal with the maple state directly then.


Yes.

>>>    	tlb_finish_mmu(&tlb);
>>> @@ -3275,14 +3275,14 @@ void exit_mmap(struct mm_struct *mm)
>>>    	 * enabled, without holding any MM locks besides the unreachable
>>>    	 * mmap_write_lock.
>>>    	 */
>>> -	mas_set(&mas, vma->vm_end);
>>> +	vma_iter_set(&vmi, vma->vm_end);
>>>    	do {
>>>    		if (vma->vm_flags & VM_ACCOUNT)
>>>    			nr_accounted += vma_pages(vma);
>>>    		remove_vma(vma, true);
>>>    		count++;
>>>    		cond_resched();
>>> -		vma = mas_find(&mas, ULONG_MAX);
>>> +		vma = vma_next(&vmi);
>>>    	} while (vma && likely(!xa_is_zero(vma)));
>>>    	BUG_ON(count != mm->map_count);
>>> @@ -3704,7 +3704,7 @@ int mm_take_all_locks(struct mm_struct *mm)
>>>    {
>>>    	struct vm_area_struct *vma;
>>>    	struct anon_vma_chain *avc;
>>> -	MA_STATE(mas, &mm->mm_mt, 0, 0);
>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>    	mmap_assert_write_locked(mm);
>>> @@ -3716,14 +3716,14 @@ int mm_take_all_locks(struct mm_struct *mm)
>>>    	 * being written to until mmap_write_unlock() or mmap_write_downgrade()
>>>    	 * is reached.
>>>    	 */
>>> -	mas_for_each(&mas, vma, ULONG_MAX) {
>>> +	for_each_vma(vmi, vma) {
>>>    		if (signal_pending(current))
>>>    			goto out_unlock;
>>>    		vma_start_write(vma);
>>>    	}
>>> -	mas_set(&mas, 0);
>>> -	mas_for_each(&mas, vma, ULONG_MAX) {
>>> +	vma_iter_init(&vmi, mm, 0);
>>> +	for_each_vma(vmi, vma) {
>>>    		if (signal_pending(current))
>>>    			goto out_unlock;
>>>    		if (vma->vm_file && vma->vm_file->f_mapping &&
>>> @@ -3731,8 +3731,8 @@ int mm_take_all_locks(struct mm_struct *mm)
>>>    			vm_lock_mapping(mm, vma->vm_file->f_mapping);
>>>    	}
>>> -	mas_set(&mas, 0);
>>> -	mas_for_each(&mas, vma, ULONG_MAX) {
>>> +	vma_iter_init(&vmi, mm, 0);
>>> +	for_each_vma(vmi, vma) {
>>>    		if (signal_pending(current))
>>>    			goto out_unlock;
>>>    		if (vma->vm_file && vma->vm_file->f_mapping &&
>>> @@ -3740,8 +3740,8 @@ int mm_take_all_locks(struct mm_struct *mm)
>>>    			vm_lock_mapping(mm, vma->vm_file->f_mapping);
>>>    	}
>>> -	mas_set(&mas, 0);
>>> -	mas_for_each(&mas, vma, ULONG_MAX) {
>>> +	vma_iter_init(&vmi, mm, 0);
>>> +	for_each_vma(vmi, vma) {
>>>    		if (signal_pending(current))
>>>    			goto out_unlock;
>>>    		if (vma->anon_vma)
>>> @@ -3800,12 +3800,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
>>>    {
>>>    	struct vm_area_struct *vma;
>>>    	struct anon_vma_chain *avc;
>>> -	MA_STATE(mas, &mm->mm_mt, 0, 0);
>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>    	mmap_assert_write_locked(mm);
>>>    	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
>>> -	mas_for_each(&mas, vma, ULONG_MAX) {
>>> +	for_each_vma(vmi, vma) {
>>>    		if (vma->anon_vma)
>>>    			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
>>>    				vm_unlock_anon_vma(avc->anon_vma);

