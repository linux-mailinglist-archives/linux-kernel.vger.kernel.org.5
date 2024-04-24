Return-Path: <linux-kernel+bounces-156678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F98B06B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9141F242D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA71591FE;
	Wed, 24 Apr 2024 09:57:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5C3158DAE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952632; cv=none; b=A5qEXDpTcxyWjTNWHr03qQNPgK55eGyrRcCJwlnejWe5WMei9ug/xtrN+PRQyXvs49LbOVrxUWd9gKhz8GFiTwAaOtpOP93J5sXdVVDlWuVeGhTl2Vb0kcfBZ7eSjr+M9NidJHSFbjGxf30XtpOV3U7WbDvjsOiHH9QdzC9yGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952632; c=relaxed/simple;
	bh=xElqm0mzanKgyLcHnkXCZf7n1tImjyjJ3L0Bvz1st3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cfy3Syjt35mvDe9Jx+bcVAvnTJnuf1/HsceBY6FCGallYaKCqs0KFdlk0imRfcoweP/W/IxY8TCuePSfIU0Gvi10RghyDJSbi44X+jn77/VD7i42fo1FJRHoQnapGzobnP9fa2o/Q/E7ZE8gUhq2OzBAHQ9J8rRbXTXh3S4GYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B02D339;
	Wed, 24 Apr 2024 02:57:37 -0700 (PDT)
Received: from [10.1.25.156] (unknown [10.1.25.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C4A93F73F;
	Wed, 24 Apr 2024 02:57:08 -0700 (PDT)
Message-ID: <7ae62c3f-918a-4778-badb-8f7ca74328d8@arm.com>
Date: Wed, 24 Apr 2024 10:57:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm: memory: extend finish_fault() to support
 large folio
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
 <6aa25e2a-a6b6-4ab7-8300-053ca3c0d748@arm.com>
 <c48ae381-f073-4b20-84ae-bd5e9e56ce29@linux.alibaba.com>
 <6c418d70-a75d-4019-a0f5-56a61002d37a@arm.com>
 <5f949c1f-c56e-4227-af60-05a2a19f4c2e@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5f949c1f-c56e-4227-af60-05a2a19f4c2e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 10:26, Baolin Wang wrote:
> 
> 
> On 2024/4/24 16:07, Ryan Roberts wrote:
>> On 24/04/2024 04:23, Baolin Wang wrote:
>>>
>>>
>>> On 2024/4/23 19:03, Ryan Roberts wrote:
>>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>>> Add large folio mapping establishment support for finish_fault() as a
>>>>> preparation,
>>>>> to support multi-size THP allocation of anonymous shared pages in the
>>>>> following
>>>>> patches.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>> ---
>>>>>    mm/memory.c | 25 ++++++++++++++++++-------
>>>>>    1 file changed, 18 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index b6fa5146b260..094a76730776 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -4766,7 +4766,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>    {
>>>>>        struct vm_area_struct *vma = vmf->vma;
>>>>>        struct page *page;
>>>>> +    struct folio *folio;
>>>>>        vm_fault_t ret;
>>>>> +    int nr_pages, i;
>>>>> +    unsigned long addr;
>>>>>          /* Did we COW the page? */
>>>>>        if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
>>>>> @@ -4797,22 +4800,30 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>                return VM_FAULT_OOM;
>>>>>        }
>>>>>    +    folio = page_folio(page);
>>>>> +    nr_pages = folio_nr_pages(folio);
>>>>> +    addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>>>
>>>> I'm not sure this is safe. IIUC, finish_fault() is called for any file-backed
>>>> mapping. So you could have a situation where part of a (regular) file is mapped
>>>> in the process, faults and hits in the pagecache. But the folio returned by the
>>>> pagecache is bigger than the portion that the process has mapped. So you now
>>>> end
>>>> up mapping beyond the VMA limits? In the pagecache case, you also can't assume
>>>> that the folio is naturally aligned in virtual address space.
>>>
>>> Good point. Yes, I think you are right, I need consider the VMA limits, and I
>>> should refer to the calculations of the start pte and end pte in
>>> do_fault_around().
>>
>> You might also need to be careful not to increase reported RSS. I have a vague
>> recollection that David once mentioned a problem with fault-around because it
>> causes the reported RSS to increase for the process and this could lead to
>> different decisions in other places. IIRC Redhat had an advisory somewhere with
>> suggested workaround being to disable fault-around. For the anon-shared memory
>> case, it shouldn't be a problem because the user has opted into allocating
>> bigger blocks, but there may be a need to ensure we don't also start eagerly
>> mapping regular files beyond what fault-around is configured for.
> 
> Thanks for reminding. And I also agree with you that this should not be a
> problem since user has selected the larger folio, which is not the same as
> fault-around.
> 
>>>>>        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>>> -                      vmf->address, &vmf->ptl);
>>>>> +                       addr, &vmf->ptl);
>>>>>        if (!vmf->pte)
>>>>>            return VM_FAULT_NOPAGE;
>>>>>          /* Re-check under ptl */
>>>>> -    if (likely(!vmf_pte_changed(vmf))) {
>>>>> -        struct folio *folio = page_folio(page);
>>>>> -
>>>>> -        set_pte_range(vmf, folio, page, 1, vmf->address);
>>>>> -        ret = 0;
>>>>> -    } else {
>>>>> +    if (nr_pages == 1 && vmf_pte_changed(vmf)) {
>>>>>            update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>>            ret = VM_FAULT_NOPAGE;
>>>>> +        goto unlock;
>>>>> +    } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>>>>
>>>> I think you have grabbed this from do_anonymous_page()? But I'm not sure it
>>>> works in the same way here as it does there. For the anon case, if userfaultfd
>>>> is armed, alloc_anon_folio() will only ever allocate order-0. So we end up in
>>>
>>> IMO, the userfaultfd validation should do in the vma->vm_ops->fault() callback,
>>> to make sure the nr_pages is always 1 if userfaultfd is armed.
>>
>> OK. Are you saying there is already logic to do that today? Great!
> 
> I mean I should add the userfaultfd validation in shmem_fault(), and may be need
> add a warning in finish_fault() to catch this issue if other
> vma->vm_ops->fault() will support large folio allocation?
> 
> WARN_ON(nr_pages > 1 && userfaultfd_armed(vma));

That adds quite a subtle requirement to vm_ops::fault() though, which I guess is
implemented in a lot of places. It would be better if it could be handled
centrally - i.e. that all the ptes are either none or a uffd marker? I'm sure
there would be corner cases to think about if taking that route.


