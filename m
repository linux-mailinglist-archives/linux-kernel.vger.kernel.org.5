Return-Path: <linux-kernel+bounces-76025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6085F21E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A301C2136A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6617BC7;
	Thu, 22 Feb 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JikvPYDB"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9A17BCA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588041; cv=none; b=ZfMv2WDvzl+NISaJZggWOWtxRpMfEwmMYNi4Dlmac0Bw5Ny6RNUeqpM+Jrc8y6qBx2Brg8n/SFBM3eARK6D4xEOtmupA/tVxKw0Wz18gYV8M3PXg8NiNSjq09as8PTY1SVyds1qN+bp6b0R4sLo7ZpuRtZ+5RFXSc+/nRfAnOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588041; c=relaxed/simple;
	bh=JpI+VAD3EL0i6A+tjOZA3jx29w1rbWGJEZVyQbbieb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qG9c/yYQGvugQwgDV+yZdkHuWRk0YbKHYdoZ910fiMSNFMNHfCJHW3ZbDRvWHTo7rnRNr4vVUxi/zq+uT7zNpIOEC/5oSxRHEn+QrZfCXeN75ixLdgxsOI5z8UPL24zJeBqTQjTr5zc7oiWi6DuxK9cCHKD7VdvADDKH3dz8phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JikvPYDB; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <082fed0a-8489-37d1-f990-067976260659@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708588032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8ksOUceWP8fZMPWDbm1sqr9ILHsp0CLZKDJzGg7bMc=;
	b=JikvPYDB8OT6V9M2fxfrukoJSqhmrOclRBqT6Hs1bTz8HGpZvVFQ62eW5mGo5tA35KzqSx
	g16KjL7hkMVVfP4Tvdf6e1O8gb0x1OC01kVh4RY7jP/DfY+WNA51R5qdepptLnGq5m3n6a
	d8Zp9T4GBmWuTFC1ABdjDw2J+TOfVI8=
Date: Thu, 22 Feb 2024 15:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/mmap: return early if it can't merge in vma_merge()
Content-Language: en-US
To: Lorenzo Stoakes <lstoakes@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240221091453.1785076-1-yajun.deng@linux.dev>
 <20240221153827.wkmjnnwsf6lyxatc@revolver>
 <f3847dd7-5564-4d7e-951e-1a9d8f55fb78@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <f3847dd7-5564-4d7e-951e-1a9d8f55fb78@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/2/22 04:41, Lorenzo Stoakes wrote:
> On Wed, Feb 21, 2024 at 10:38:27AM -0500, Liam R. Howlett wrote:
>> * Yajun Deng <yajun.deng@linux.dev> [240221 04:15]:
>>> In most cases, the range of the area is valid. But in do_mprotect_pkey(),
>>> the minimum value of end and vma->vm_end is passed to mprotect_fixup().
>>> This will lead to the end is less than the end of prev.
>>>
>>> In this case, the curr will be NULL, but the next will be equal to the
>>> prev. So it will attempt to merge before, the vm_pgoff check will cause
>>> this case to fail.
>>>
>>> To avoid the process described above and reduce unnecessary operations.
>>> Add a check to immediately return NULL if the end is less than the end of
>>> prev.
>> If it's only one caller, could we stop that caller instead of checking
>> an almost never case for all callers?  Would this better fit in
>> vma_modify()?  Although that's not just for this caller at this point.
>> Maybe there isn't a good place?
> I definitely agree with Liam that this should not be in vma_merge(), as
> it's not going to be relevant to _most_ callers.
>
> I am not sure vma_modify() is much better, this would be the only early
> exit check in that function and makes what is very simple and
> straightforward now more confusing.


There are two paths that will cause this case. One is in 
mprotect_fixup(), the other is in

madvise_update_vma().


One way is to separate out the split_vma() from vma_modify(). And create 
a new helper function.

We can call it directly at source, but we need to do this in both 
paths.  It's more complicated.


The other way is to add a check in vma_modify(). Like the following:

diff --git a/mm/mmap.c b/mm/mmap.c
index 0fccd23f056e..f93f1d3939f2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2431,11 +2431,15 @@ struct vm_area_struct *vma_modify(struct 
vma_iterator *vmi,
         pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> 
PAGE_SHIFT);
         struct vm_area_struct *merged;

+       if (prev && end < prev->vm_end)
+               goto cannot_merge;
+
         merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
                            pgoff, policy, uffd_ctx, anon_name);
         if (merged)
                 return merged;

+cannot_merge:
         if (vma->vm_start < start) {
                 int err = split_vma(vmi, vma, start, 1);


> And I think this is the crux of it - it's confusing that we special case
> this one particular non-merge scenario, but no others (all of which we then
> deem ok to be caught by the usual rules).
>
> I think it's simpler (and more efficient) to just keep things the way they
> are.
>
>> Or are there other reasons this may happen and is better done in this
>> function?
>>
>> Often, this is called the "punch a hole" scenario; where an operation
>> creates two entries from the old data and either leaves an empty space
>> or fills the space with a new VMA.
>>
>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>> ---
>>> v2: remove the case label.
>>> v1: https://lore.kernel.org/all/20240218085028.3294332-1-yajun.deng@linux.dev/
>>> ---
>>>   mm/mmap.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index 0fccd23f056e..7668854d2246 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>>> @@ -890,6 +890,9 @@ static struct vm_area_struct
>>>   	if (vm_flags & VM_SPECIAL)
>>>   		return NULL;
>>>
>>> +	if (prev && end < prev->vm_end)
>>> +		return NULL;
>>> +
>>>   	/* Does the input range span an existing VMA? (cases 5 - 8) */
>>>   	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
>>>
>>> --
>>> 2.25.1
>>>
> So overall I don't think this check makes much sense anywhere.
>
> I think a better solution would be to prevent it happening _at source_ if
> you can find a logical way of doing so.
>
> I do plan to do some cleanup passes over this stuff once again so maybe I
> can figure something out that better handles non-merge scenarios.
>
> This is a great find though overall even if a patch doesn't make sense
> Yajun, thanks for this, it's really made me think about this case (+ others
> like it) :)

