Return-Path: <linux-kernel+bounces-37894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25983B747
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720F7B21B06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82AB613A;
	Thu, 25 Jan 2024 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dlu0FC8X"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E97475
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150626; cv=none; b=Bo2+C3BnJzuHzt/iJnu3pD0X/XEWR5JTn82qnR8l0G4Ez7JM8oBzlaUYICVTtF4Irk4zLIFqwvNgt56Wyn/vVmeKxQ21B8FUrEKLPDEKgykDbebbZdUYm439+qrH8RCoUYRBMr/CXII3H0yBQ9Uyy5bXONjvmVbjTVq/f0PizXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150626; c=relaxed/simple;
	bh=epnQ2T5/hSU4soZs9ZTpDtAlKVSYHK4bARFOC+6XZXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=PUryLbyOEzNkg39jd2SQyPB4xa2bEOjGOHFYw/x/vjwd07oin8wxQP2TyhdLdGVHOf2UVZ16d5qZYeTcCvmgjHJ3zP1Ac7rv5XiLhrRdkr5xq8ElzYJsPxj/1ZhvOMBaMv9M00KmQmc5R7mTfHSwsz0r1T/yBP0DRvQlBsSVI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dlu0FC8X; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cfde276-1175-b798-cc40-2a8654a1846e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706150616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfgGA7zDp2YuL24bfZ9uV+PDegKQEBOnvlT1qNaUykw=;
	b=Dlu0FC8Xmncej8IyWmUFQ7DqsQdjp6pG15ocvAdF3TSWTc0QAK0RqkyBX2gVEvq2MnxoDq
	6/3J5w6CJlOGeEWEJfUVpM35NNhmeFTZe5OGjWGrJKnun04qbBo5qwRaAOTEvwFljRIzM8
	mRUKR1ZoJoO1j206UT9GVHRKFaKjS9o=
Date: Thu, 25 Jan 2024 10:43:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mmap: introduce vma_set_range()
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20240124035719.3685193-1-yajun.deng@linux.dev>
 <20240124154756.edja2u2rjzlm23vy@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124154756.edja2u2rjzlm23vy@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/24 23:47, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240123 22:57]:
>> There is a lot of code needs to set the range of vma in mmap.c,
>> introduce vma_set_range() to simplify the code.
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Thank you for making the suggested changes, I have one small comment but
> you don't need to re-spin the patch for it.  This looks good.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
>> ---
>> v2: use vma_set_range and put it to mm/internal.h.
>> v1: https://lore.kernel.org/all/20240111021526.3461825-1-yajun.deng@linux.dev/
>> ---
>>   mm/internal.h |  9 +++++++++
>>   mm/mmap.c     | 29 +++++++----------------------
>>   2 files changed, 16 insertions(+), 22 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index f309a010d50f..1e29c5821a1d 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1114,6 +1114,15 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
>>   extern bool mirrored_kernelcore;
>>   extern bool memblock_has_mirror(void);
>>   
>> +static __always_inline void vma_set_range(struct vm_area_struct *vma,
>> +					  unsigned long start, unsigned long end,
>> +					  pgoff_t pgoff)
> Nit: This isn't part of the style guide, but if you just indent with two
> tabs for arguments then it is easier to expand the list without more
> lines.  It also allows changing the function prototype without
> re-indenting all the other lines, so future changes can be smaller.  I
> think you would save a line here without affecting readability.

Thank you. I thought the parameters needed to be aligned.

>
>> +{
>> +	vma->vm_start = start;
>> +	vma->vm_end = end;
>> +	vma->vm_pgoff = pgoff;
>> +}
>> +
>>   static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>>   {
>>   	/*
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index cf2f058bb3ae..7a9d2895a1bd 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -663,9 +663,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   
>>   	vma_prepare(&vp);
>>   	vma_adjust_trans_huge(vma, start, end, 0);
>> -	vma->vm_start = start;
>> -	vma->vm_end = end;
>> -	vma->vm_pgoff = pgoff;
>> +	vma_set_range(vma, start, end, pgoff);
>>   	vma_iter_store(vmi, vma);
>>   
>>   	vma_complete(&vp, vmi, vma->vm_mm);
>> @@ -708,9 +706,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   	vma_adjust_trans_huge(vma, start, end, 0);
>>   
>>   	vma_iter_clear(vmi);
>> -	vma->vm_start = start;
>> -	vma->vm_end = end;
>> -	vma->vm_pgoff = pgoff;
>> +	vma_set_range(vma, start, end, pgoff);
>>   	vma_complete(&vp, vmi, vma->vm_mm);
>>   	return 0;
>>   }
>> @@ -1015,10 +1011,7 @@ static struct vm_area_struct
>>   
>>   	vma_prepare(&vp);
>>   	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
>> -
>> -	vma->vm_start = vma_start;
>> -	vma->vm_end = vma_end;
>> -	vma->vm_pgoff = vma_pgoff;
>> +	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
>>   
>>   	if (vma_expanded)
>>   		vma_iter_store(vmi, vma);
>> @@ -2809,11 +2802,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>   	}
>>   
>>   	vma_iter_config(&vmi, addr, end);
>> -	vma->vm_start = addr;
>> -	vma->vm_end = end;
>> +	vma_set_range(vma, addr, end, pgoff);
>>   	vm_flags_init(vma, vm_flags);
>>   	vma->vm_page_prot = vm_get_page_prot(vm_flags);
>> -	vma->vm_pgoff = pgoff;
>>   
>>   	if (file) {
>>   		vma->vm_file = get_file(file);
>> @@ -3163,9 +3154,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>>   		goto unacct_fail;
>>   
>>   	vma_set_anonymous(vma);
>> -	vma->vm_start = addr;
>> -	vma->vm_end = addr + len;
>> -	vma->vm_pgoff = addr >> PAGE_SHIFT;
>> +	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
>>   	vm_flags_init(vma, flags);
>>   	vma->vm_page_prot = vm_get_page_prot(flags);
>>   	vma_start_write(vma);
>> @@ -3402,9 +3391,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>>   		new_vma = vm_area_dup(vma);
>>   		if (!new_vma)
>>   			goto out;
>> -		new_vma->vm_start = addr;
>> -		new_vma->vm_end = addr + len;
>> -		new_vma->vm_pgoff = pgoff;
>> +		vma_set_range(new_vma, addr, addr + len, pgoff);
>>   		if (vma_dup_policy(vma, new_vma))
>>   			goto out_free_vma;
>>   		if (anon_vma_clone(new_vma, vma))
>> @@ -3572,9 +3559,7 @@ static struct vm_area_struct *__install_special_mapping(
>>   	if (unlikely(vma == NULL))
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	vma->vm_start = addr;
>> -	vma->vm_end = addr + len;
>> -
>> +	vma_set_range(vma, addr, addr + len, 0);
>>   	vm_flags_init(vma, (vm_flags | mm->def_flags |
>>   		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
>>   	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
>> -- 
>> 2.25.1
>>

