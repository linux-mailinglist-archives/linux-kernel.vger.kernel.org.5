Return-Path: <linux-kernel+bounces-77680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7E8608DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C9B1C21379
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA74B65F;
	Fri, 23 Feb 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RX5zaavS"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B4372
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655444; cv=none; b=Cxz+IdoJZ33sxm/gog3Nd17qv3JFcga6l4Z2W8gFEotyImyBPSYwrsEntBgrgrfB7wN6q78LfXc5hThICNRE16IHueHVjbL6QdBharq+A2ewL9mWC4QxtBUdXBjdIGCbyfAGqgdvUQLqP/gRpb54GcDgBJr3aiJBitaLdbs1DoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655444; c=relaxed/simple;
	bh=73cz1+ZnwyITTeM7LH5Pf640GbLeYiiXss/FXfdry4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bHwNmju7ND0uYGDQGvtWkx/b7e2Rx4OoHygZptUNrlfXdW8l6SfB1Bjyr8Rixc7204hT0XuAwT+uxcZWVcQ5S5zTrCOGth66DMld/MHcDmOym99LOsJZACBaajNVA69apdxfcSIvvDrFmD8Q8TU0tQt4UNzXIUWHwOiaDrJ7tUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RX5zaavS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7cc1952d-958f-3867-d9eb-fd70d41b29f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708655440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn0DwPHukXKXbPRCk/008A2MQ+iJBle+LqZeMHn+wVQ=;
	b=RX5zaavSP806/U8b+yYYISEclwVh+Tr4o+XaPiXiO3bDMoeFU9jYmtlpeMvNIorn5lGraa
	pWNh/EPaXLh4fsR2LumXrp9VmSOfbtZ59tXQmdDqrWplHD58MOniyC/oN9NgcijlBOn5LK
	B1ylnjPMnHAlxl+97x0IeBD5eJvXdEI=
Date: Fri, 23 Feb 2024 10:30:29 +0800
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
 <d9b4624a-214d-2f49-3883-4d62f60a9de4@linux.dev>
 <20240222150703.u55kpmdlog5hrld3@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240222150703.u55kpmdlog5hrld3@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/22 23:07, Liam R. Howlett wrote:
> * Yajun Deng <yajun.deng@linux.dev> [240222 03:56]:
> ...
>
>>>>>>> @@ -1959,11 +1958,12 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>>>>>      	struct vm_area_struct *next;
>>>>>>>      	unsigned long gap_addr;
>>>>>>>      	int error = 0;
>>>>>>> -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
>>>>>>> +	VMA_ITERATOR(vmi, mm, 0);
>>>>>>>      	if (!(vma->vm_flags & VM_GROWSUP))
>>>>>>>      		return -EFAULT;
>>>>>>> +	vma_iter_config(&vmi, vma->vm_start, address);
>>>>> This is confusing.  I think you are doing this so that the vma iterator
>>>>> is set up the same as the maple state, and not what is logically
>>>>> necessary?
>>>> Yes, VMA_ITERATOR can only pass one address.
>>>>
>>>>>>>      	/* Guard against exceeding limits of the address space. */
>>>>>>>      	address &= PAGE_MASK;
>>>>>>>      	if (address >= (TASK_SIZE & PAGE_MASK))
>>>>>>> @@ -1985,15 +1985,15 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>>>>>>>      	}
>>>>>>>      	if (next)
>>>>>>> -		mas_prev_range(&mas, address);
>>>>>>> +		mas_prev_range(&vmi.mas, address);
>>>>> This isn't really hiding the maple state.
>>>> Okay,  I will create a new helper function for this in the mm/internal.h.
>>>>
>>>>>>> -	__mas_set_range(&mas, vma->vm_start, address - 1);
>>>>>>> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
>>>>>>> +	vma_iter_config(&vmi, vma->vm_start, address);
>>>>> The above maple state changes is to get the maple state to point to the
>>>>> correct area for the preallocation call below.  This seems unnecessary
>>>>> to me.
>>>>>
>>>>> We really should just set it up correctly.  Unfortunately, with the VMA
>>>>> iterator, that's not really possible on initialization.
>>>>>
>>>>> What we can do is use the vma->vm_start for the initialization, then use
>>>>> vma_iter_config() here.  That will not reset any state - but that's fine
>>>>> because the preallocation is the first call that actually uses it
>>>>> anyways.
>>>>>
>>>>> So we can initialize with vma->vm_start, don't call vma_iter_config
>>>>> until here, and also drop the if (next) part.
>>>>>
>>>>> This is possible here because it's not optimised like the
>>>>> expand_upwards() case, which uses the state to check prev and avoids an
>>>>> extra walk.
>>>>>
>>>>> Please make sure to test with the ltp tests on the stack combining, etc
>>>>> on a platform that expands down.
>>
>> It seems something wrong about this description. This change is in
>> expand_upwards(), but not in
>>
>> expand_downwards(). So we should test it on a platform that expands up.
> Oh, yes.  Test on the platform that expands upwards would be best.
> Sorry about the mix up.


I didn't have a platform that expands up, so I can't test the 
expand_upwards().

>> And
>> drop the if (next) part
>>
>> is unnecessary. Did I get that right?
> Yes, I think the if (next) part is unnecessary because the maple
> state/vma iterator has not actually moved - we use
> find_vma_intersection() to locate next and not the iterator.  This is
> different than what we do in the expand_downwards.

Yes.

Since I can't test the expand_upwards(), I think it's safer to keep the 
if (next) part.

> Note that, in the even that we reach the limit and cannot return a
> usable address, these functions will call the counterpart and search in
> the opposite direction.
>
>>>> Okay, I will test it.
>>> Testing this can be tricky.  Thanks for looking at it.
>>>
> ...
>
>
> Thanks,
> Liam
>

