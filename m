Return-Path: <linux-kernel+bounces-76323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6685F5A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0811F272E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A23F8ED;
	Thu, 22 Feb 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uBIsCIa1"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4013E493
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597591; cv=none; b=I6rMfzc9+hagxvOJCx/5cwVl4NG9+qDZpj5kpMimxyE1pPvSSjG+pzQGAdsk8PLAS8DMs7FqBl1BOMmqxMtOl2SyDyHDE1XNs3keG2jjRdcey99W242UtMABUQxnOi2e9O33z5ge8g3u2QMIPSw8c7nlFcuvwmcK50a0XxsneVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597591; c=relaxed/simple;
	bh=UEj9sHztDU8qj7jBQBTqaSJ97zq+jU8sjx+z8b97n9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SpFM/iHIO+CO+w+wteWKQb6VQr5M7UXx+W+qkuGQQWd23UBRTAQlo4aNnvA24bO6sSK0XloG/+tERU91QlM8y77ZriM6RxxJmV0Jp/rrMHIO2hb+8WFwywU/uwGiV0cndBwX+CV2zEvy5gmYCpv5aQZO8zZ2NBphtW8pGbX6eJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uBIsCIa1; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7229eb6e-bf3e-fa97-6709-6c92bc72443b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708597586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7spRFbh2J4ww37DpVZh+dxZFQJF6WKI0aJByND9M2M=;
	b=uBIsCIa13A/Fs89WWjKMTg//DsS1q1bl0lRGY8fIonQKfUYADQPrsYRucSSGgCr1k7komW
	ABm8yceiEl3msvXaPyDirssN/rn0BImI/8NeKLNmo6VaDzgB3DKaQIiUomdRMsc8c5yg09
	dEHQK2kIhgLQCC+P3JZ/XAFLRCgO/FA=
Date: Thu, 22 Feb 2024 18:26:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: remove the mm parameter in vma_complete()
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20240129075305.3512138-1-yajun.deng@linux.dev>
 <20240129150417.3m6jyj3ftdh6ka7x@revolver>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, vbabka@suse.cz, lstoakes@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240129150417.3m6jyj3ftdh6ka7x@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Adding Vlastimil and Lorenzo to discuss this patch.


On 2024/1/29 23:04, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240129 02:53]:
>> There are vma_merge() and do_brk_flags() pass mm to vma_complete(), others
>> would pass the vma->vm_mm. The following explains that the mm is the
>> vma->vm_mm in vma_merge() and do_brk_flags().
>>
>> All vma will point to the same mm struct if the vma_merge() is successful.
>> So the mm and the vma->mm are the same.
> Absolutely, they must be the same.  I don't think vma_merge() checks
> this, but it is true.
>
>> vm_brk_flags() and brk syscall will initialize vmi with current->mm,
>> so the vma->vm_mm and the current->mm are the same if vma exists in
>> do_brk_flags().
>>
>> Remove the mm parameter in vma_complete() and get mm from the vma in vp.
> You have added a dereference to the two paths that don't need it to
> reduce the argument list from 3 to 2.  It's the same number of lines as
> well.  vma_shrink() is only used on process creation, but brk is more
> common.  Note that this function is marked as inline.
>
> I'm not sure this change is worth making.

If we can make sure the mm is  vma->vm_mm, I don't think we need to pass 
the mm.

If we can't make sure that, this change is not worth it.

>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   mm/mmap.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index e97b9144c61a..9b968d1edf55 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -509,11 +509,11 @@ static inline void vma_prepare(struct vma_prepare *vp)
>>    *
>>    * @vp: The vma_prepare struct
>>    * @vmi: The vma iterator
>> - * @mm: The mm_struct
>>    */
>> -static inline void vma_complete(struct vma_prepare *vp,
>> -				struct vma_iterator *vmi, struct mm_struct *mm)
>> +static inline void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi)
>>   {
>> +	struct mm_struct *mm = vp->vma->vm_mm;
>> +
>>   	if (vp->file) {
>>   		if (vp->adj_next)
>>   			vma_interval_tree_insert(vp->adj_next,
>> @@ -666,7 +666,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   	vma_set_range(vma, start, end, pgoff);
>>   	vma_iter_store(vmi, vma);
>>   
>> -	vma_complete(&vp, vmi, vma->vm_mm);
>> +	vma_complete(&vp, vmi);
>>   	return 0;
>>   
>>   nomem:
>> @@ -707,7 +707,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   
>>   	vma_iter_clear(vmi);
>>   	vma_set_range(vma, start, end, pgoff);
>> -	vma_complete(&vp, vmi, vma->vm_mm);
>> +	vma_complete(&vp, vmi);
>>   	return 0;
>>   }
>>   
>> @@ -1030,7 +1030,7 @@ static struct vm_area_struct
>>   		}
>>   	}
>>   
>> -	vma_complete(&vp, vmi, mm);
>> +	vma_complete(&vp, vmi);
>>   	khugepaged_enter_vma(res, vm_flags);
>>   	return res;
>>   
>> @@ -2377,7 +2377,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   	}
>>   
>>   	/* vma_complete stores the new vma */
>> -	vma_complete(&vp, vmi, vma->vm_mm);
>> +	vma_complete(&vp, vmi);
>>   
>>   	/* Success. */
>>   	if (new_below)
>> @@ -3145,7 +3145,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   		vm_flags_set(vma, VM_SOFTDIRTY);
>>   		vma_iter_store(vmi, vma);
>>   
>> -		vma_complete(&vp, vmi, mm);
>> +		vma_complete(&vp, vmi);
>>   		khugepaged_enter_vma(vma, flags);
>>   		goto out;
>>   	}
>> -- 
>> 2.25.1
>>
>>

