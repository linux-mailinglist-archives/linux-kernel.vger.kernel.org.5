Return-Path: <linux-kernel+bounces-77681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2666F8608E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9279FB2306B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF546BE5B;
	Fri, 23 Feb 2024 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZgfnbj1"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D00372
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655792; cv=none; b=rpwIlC6p/HfFlcm/FCNmtcCP6jGWcDgesI8l/1MIaFjbrvk+YbFAasKLh8OE0f6VOcIXWKTq7EuuP1ITWGlOxX5Wm0SvMPF6sLnbOx7b+8j0hpg9P8S9rwis6Bb81n1JgZHx0L1iO2FmDw8/oejjBobJ1RnDjgj8BpBGa+IcMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655792; c=relaxed/simple;
	bh=I9+vio4ZG8Dg9eVHn5xYSPR2OztHsRZjls3I2Qe0Dbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IIdRReothzvf4sNnESg1MGuqJF/DYwU9fPodH8mT7jh3YAP4lcldl+iidBNKh+JsJpVq2DCxlk/RHYEO6nh2X52WZx7LqGew9hsFO6HCPNyDm9cZIStR9byTiY1zXd7fYInnREQzIXYP9pFIEMGIbPpMRFmhZ3rXMmYjdHnVxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZgfnbj1; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3b1dddf-57e0-f1fb-66fc-cf08c94c5dc8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708655787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHqdu3spwmkF6oWZOtRqdMOZaCL8AWKGggIeQiYpA+s=;
	b=PZgfnbj1wz3UlFSGeyz9yQxBmfYAVpF35gls8d+bGNxqRGt19k39nJXtYyb5A4YzkPGS4Q
	9A6Ly+iB1q0ebPEw0mzGmN33PDSPFbOkJEiv97taml+aJwrKPoqCmp0JI7TSnGTJ3KRXr6
	C1u7tNmVUE8+YJ/0OV5WXzhKg54qG5w=
Date: Fri, 23 Feb 2024 10:36:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: remove the mm parameter in vma_complete()
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 lstoakes@gmail.com
References: <20240129075305.3512138-1-yajun.deng@linux.dev>
 <20240129150417.3m6jyj3ftdh6ka7x@revolver>
 <7229eb6e-bf3e-fa97-6709-6c92bc72443b@linux.dev>
 <20240222162222.d7imwzuqpreilr6u@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240222162222.d7imwzuqpreilr6u@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/23 00:22, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240222 05:26]:
>> Adding Vlastimil and Lorenzo to discuss this patch.
>>
>>
>> On 2024/1/29 23:04, Liam R. Howlett wrote:
>>> * Yajun Deng <yajun.deng@linux.dev> [240129 02:53]:
>>>> There are vma_merge() and do_brk_flags() pass mm to vma_complete(), others
>>>> would pass the vma->vm_mm. The following explains that the mm is the
>>>> vma->vm_mm in vma_merge() and do_brk_flags().
>>>>
>>>> All vma will point to the same mm struct if the vma_merge() is successful.
>>>> So the mm and the vma->mm are the same.
>>> Absolutely, they must be the same.  I don't think vma_merge() checks
>>> this, but it is true.
>>>
>>>> vm_brk_flags() and brk syscall will initialize vmi with current->mm,
>>>> so the vma->vm_mm and the current->mm are the same if vma exists in
>>>> do_brk_flags().
>>>>
>>>> Remove the mm parameter in vma_complete() and get mm from the vma in vp.
>>> You have added a dereference to the two paths that don't need it to
>>> reduce the argument list from 3 to 2.  It's the same number of lines as
>>> well.  vma_shrink() is only used on process creation, but brk is more
>>> common.  Note that this function is marked as inline.
>>>
>>> I'm not sure this change is worth making.
>> If we can make sure the mm is  vma->vm_mm, I don't think we need to pass the
>> mm.
>>
>> If we can't make sure that, this change is not worth it.
> We can be quite confident the mm struct is the same.  The point is that
> you are causing more instructions for zero gain.  There isn't a lot of
> arguments and this is marked inline.  For most of the cases, we are
> already causing 1/2 the dereferences you are moving - except
> brk_flags(), which already has the pointer available.  But instead of
> using the pointer already in a register, you are adding two new
> dereferences inside an inline function.
>
> This is like writing:
>
> struct mm_struct *mm = current->mm;
> struct vm_area_stuuct *vma = find_vma(mm, 0);
>
> ...
>
> use_the_mm(vma->vm_mm);
>
> .. only it's worse than that because the compiler will replace
> use_the_mm() with the actual code in use_the_mm(), so we have
> effectively told the compiler to set another register up by
> dereferencing twice instead of using the value already available.
>
> It's a change for the sake of changing.
>
> You are not reducing the code size, you are not increasing the
> readability.  You are adding two dereferences to brk() and one to all
> other callers.  Why do this change?


Thank you for your explanation.

>>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>>> ---
>>>>    mm/mmap.c | 16 ++++++++--------
>>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>> index e97b9144c61a..9b968d1edf55 100644
>>>> --- a/mm/mmap.c
>>>> +++ b/mm/mmap.c
>>>> @@ -509,11 +509,11 @@ static inline void vma_prepare(struct vma_prepare *vp)
>>>>     *
>>>>     * @vp: The vma_prepare struct
>>>>     * @vmi: The vma iterator
>>>> - * @mm: The mm_struct
>>>>     */
>>>> -static inline void vma_complete(struct vma_prepare *vp,
>>>> -				struct vma_iterator *vmi, struct mm_struct *mm)
>>>> +static inline void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi)
>>>>    {
>>>> +	struct mm_struct *mm = vp->vma->vm_mm;
>>>> +
>>>>    	if (vp->file) {
>>>>    		if (vp->adj_next)
>>>>    			vma_interval_tree_insert(vp->adj_next,
>>>> @@ -666,7 +666,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>>>    	vma_set_range(vma, start, end, pgoff);
>>>>    	vma_iter_store(vmi, vma);
>>>> -	vma_complete(&vp, vmi, vma->vm_mm);
>>>> +	vma_complete(&vp, vmi);
>>>>    	return 0;
>>>>    nomem:
>>>> @@ -707,7 +707,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>>>    	vma_iter_clear(vmi);
>>>>    	vma_set_range(vma, start, end, pgoff);
>>>> -	vma_complete(&vp, vmi, vma->vm_mm);
>>>> +	vma_complete(&vp, vmi);
>>>>    	return 0;
>>>>    }
>>>> @@ -1030,7 +1030,7 @@ static struct vm_area_struct
>>>>    		}
>>>>    	}
>>>> -	vma_complete(&vp, vmi, mm);
>>>> +	vma_complete(&vp, vmi);
>>>>    	khugepaged_enter_vma(res, vm_flags);
>>>>    	return res;
>>>> @@ -2377,7 +2377,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>>>    	}
>>>>    	/* vma_complete stores the new vma */
>>>> -	vma_complete(&vp, vmi, vma->vm_mm);
>>>> +	vma_complete(&vp, vmi);
>>>>    	/* Success. */
>>>>    	if (new_below)
>>>> @@ -3145,7 +3145,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>>>    		vm_flags_set(vma, VM_SOFTDIRTY);
>>>>    		vma_iter_store(vmi, vma);
>>>> -		vma_complete(&vp, vmi, mm);
>>>> +		vma_complete(&vp, vmi);
>>>>    		khugepaged_enter_vma(vma, flags);
>>>>    		goto out;
>>>>    	}
>>>> -- 
>>>> 2.25.1
>>>>
>>>>

