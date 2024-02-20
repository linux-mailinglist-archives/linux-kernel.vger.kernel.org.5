Return-Path: <linux-kernel+bounces-72237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58485B10C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB42B211DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FF45959;
	Tue, 20 Feb 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsT3mVFg"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C93433B3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398043; cv=none; b=cPB82l+86NPi/hvBstcZkc3mLAA/T/oJhgpriF5wWo2qfuGdvOnN5InyiZxMHocncGGrPIQ80GnZtFDf/52e+eoUSRIwsWN15LT/f7aX98fNaojhKX2fhHQhtxCC01lZheIKjDaQaVmW3FjwIDlK4egWotnpqFwr3C0REnlNLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398043; c=relaxed/simple;
	bh=/IeaaKyllnXBtJJ48HMH5+0WGzXBm4XIBwUop+B3gFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7ZV6/aL7f0O+/ZBqaSW7a37IatQJWhsPEuir1ktnNKC5L0fyRhaDWRPBj19AJ3GqnFgqCzSIfMch8DVSi25V5VhkkPjmeG1vVNztDe1DJVsJjSRJSfetXCOaYd0yapCdF0MhYN03M6HQqIsvcb60Q5UOg+I53AAMnGj5akM0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsT3mVFg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f88de15e-508f-f651-0164-346845d23e85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708398038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62UrT3cpno7hjOTET/L8V6znazoo6gcdnhOZELLpvOg=;
	b=nsT3mVFgyVJ0bpvazA4AAzDjc6tKuQNkUFJ3C0+h2znZUJLLt9m74fQfduAIyqsvPqC6TN
	sZJEicTasuFWRdnh5ChoMlRLb4rPd5XexpsclW+/i0b0uL/P0tgKJ9DxHzdoQ/I5QC8FcV
	7tujUbBsrxw3+9vrGzBKScL+pL9VGgE=
Date: Tue, 20 Feb 2024 11:00:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mmap: Add case 9 in vma_merge()
Content-Language: en-US
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, vbabka@suse.cz
References: <20240218085028.3294332-1-yajun.deng@linux.dev>
 <a5cd692e-34e3-4bc1-a8fa-f6bb56f04e8a@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <a5cd692e-34e3-4bc1-a8fa-f6bb56f04e8a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/19 07:03, Lorenzo Stoakes wrote:
> On Sun, Feb 18, 2024 at 04:50:28PM +0800, Yajun Deng wrote:
>> If the prev vma exists and the end is less than the end of prev, we
>> can return NULL immediately. This reduces unnecessary operations.
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Adding Vlastimil, while get_maintainers.pl might not show it very clearly,
> myself, Vlastimil and Liam often work with vma_merge() so it's handy to cc
> us on these if you can!
Okay.
>> ---
>>   mm/mmap.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 8f176027583c..b738849321c0 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -827,7 +827,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>>    *
>>    *     ****             ****                   ****
>>    *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
>> - *    cannot merge    might become       might become
>> + *    cannot merge 9  might become       might become
> While I welcome your interest here :) I am not a fan of the 'case' approach
> to this function as-is and plan to heavily refactor this when I get a chance.
>
> But at any rate, an early-exit situation is not a merge case, merge cases
> describe cases where we _can_ merge, so we can drop this case 9 stuff (this
> is not your fault, it's understandable why you would label this, this
> function is just generally unclear).

Yes, it's not a merge case. I label this to make it easier to understand.

>>    *                    PPNNNNNNNNNN       PPPPPPPPPPCC
>>    *    mmap, brk or    case 4 below       case 5 below
>>    *    mremap move:
>> @@ -890,6 +890,9 @@ static struct vm_area_struct
>>   	if (vm_flags & VM_SPECIAL)
>>   		return NULL;
>>
>> +	if (prev && end < prev->vm_end) /* case 9 */
>> +		return NULL;
>> +
> I need to get back into vma_merge() head space, but I don't actually think
> a caller that's behaving correctly should ever do this. I know the ASCII
> diagram above lists it as a thing that can happen, but I think we
> implicitly avoid this from the way we invoke callers. Either prev == vma as
> per vma_merge_extend(), or the loops that invoke vma_merge_new_vma()
> wouldn't permit this to occur.
No, it will actually happen. That's why I submitted this patch.
> Let me look into it more deeply + reply again a bit later, I mean we could
> perhaps do with asserting this somehow, but I don't think it's useful to do
> an early exit for something that ostensibly _shouldn't_ happen.
>
>>   	/* Does the input range span an existing VMA? (cases 5 - 8) */
>>   	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>>
>> --
>> 2.25.1
>>

