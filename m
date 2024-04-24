Return-Path: <linux-kernel+bounces-156629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF78B05F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E888B2408B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1AC158D98;
	Wed, 24 Apr 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nzDhW7ej"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91991E4A9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950791; cv=none; b=DX148o3wDFMQGfXMYmZzrAoUWHVw6H+9+5X3JXsd92OkKxa/Z73rso/vMEPiDZ5CAGEex0LnOT5bYfK/ux2OPCHBxQAd3uD94I4jNvCTB8ofRaNCV6XM6QpEvlXs4Wrv60U+mCWcvCoU8XM4HkPljItuscFGs6iKu0gegOtqxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950791; c=relaxed/simple;
	bh=dmQN0eX1tcSqSjv18MnXnBI/Gk3ZwSHAA7agwUwijig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oG5kSLfco4HNsrbwA0wvpz8khOCDD7OpbM/YoHi8YieJvhgIRQMRx+YDkcZpELPo+yYWbLf6ppOs6BJjSK9fNB6KpUcPRxqnlGVx/LZCR4XapSyZy9dhcsh70adK6lwJAmxkPiVbGFkIAT9Ir8QWtexqLx8IcdC1jTveu52gKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nzDhW7ej; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713950780; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=asuta3TdqTQKC4TQYKxp0fcNemSgX8yGS7cyyZty+I0=;
	b=nzDhW7ejtkr33KCkuzY1HA+DADQN2SESFypUtoOw6jrdkwWPTI690PJszIJCXkJylX6KYVdNGN1hXfXgnW9EMiIm3hNvvovkyO+cEkRRH4wwVmuZzbcBV92HN7KiYn7WEcMhJxDn7tCH7MqPbFeWjQQ91Lcn6LEDgR+FEnGxYso=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5BsIsB_1713950777;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5BsIsB_1713950777)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:26:18 +0800
Message-ID: <5f949c1f-c56e-4227-af60-05a2a19f4c2e@linux.alibaba.com>
Date: Wed, 24 Apr 2024 17:26:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm: memory: extend finish_fault() to support
 large folio
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <358aefb1858b63164894d7d8504f3dae0b495366.1713755580.git.baolin.wang@linux.alibaba.com>
 <6aa25e2a-a6b6-4ab7-8300-053ca3c0d748@arm.com>
 <c48ae381-f073-4b20-84ae-bd5e9e56ce29@linux.alibaba.com>
 <6c418d70-a75d-4019-a0f5-56a61002d37a@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <6c418d70-a75d-4019-a0f5-56a61002d37a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/24 16:07, Ryan Roberts wrote:
> On 24/04/2024 04:23, Baolin Wang wrote:
>>
>>
>> On 2024/4/23 19:03, Ryan Roberts wrote:
>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>> Add large folio mapping establishment support for finish_fault() as a
>>>> preparation,
>>>> to support multi-size THP allocation of anonymous shared pages in the following
>>>> patches.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/memory.c | 25 ++++++++++++++++++-------
>>>>    1 file changed, 18 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index b6fa5146b260..094a76730776 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4766,7 +4766,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>    {
>>>>        struct vm_area_struct *vma = vmf->vma;
>>>>        struct page *page;
>>>> +    struct folio *folio;
>>>>        vm_fault_t ret;
>>>> +    int nr_pages, i;
>>>> +    unsigned long addr;
>>>>          /* Did we COW the page? */
>>>>        if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
>>>> @@ -4797,22 +4800,30 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>                return VM_FAULT_OOM;
>>>>        }
>>>>    +    folio = page_folio(page);
>>>> +    nr_pages = folio_nr_pages(folio);
>>>> +    addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>>>
>>> I'm not sure this is safe. IIUC, finish_fault() is called for any file-backed
>>> mapping. So you could have a situation where part of a (regular) file is mapped
>>> in the process, faults and hits in the pagecache. But the folio returned by the
>>> pagecache is bigger than the portion that the process has mapped. So you now end
>>> up mapping beyond the VMA limits? In the pagecache case, you also can't assume
>>> that the folio is naturally aligned in virtual address space.
>>
>> Good point. Yes, I think you are right, I need consider the VMA limits, and I
>> should refer to the calculations of the start pte and end pte in do_fault_around().
> 
> You might also need to be careful not to increase reported RSS. I have a vague
> recollection that David once mentioned a problem with fault-around because it
> causes the reported RSS to increase for the process and this could lead to
> different decisions in other places. IIRC Redhat had an advisory somewhere with
> suggested workaround being to disable fault-around. For the anon-shared memory
> case, it shouldn't be a problem because the user has opted into allocating
> bigger blocks, but there may be a need to ensure we don't also start eagerly
> mapping regular files beyond what fault-around is configured for.

Thanks for reminding. And I also agree with you that this should not be 
a problem since user has selected the larger folio, which is not the 
same as fault-around.

>>>>        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>>> -                      vmf->address, &vmf->ptl);
>>>> +                       addr, &vmf->ptl);
>>>>        if (!vmf->pte)
>>>>            return VM_FAULT_NOPAGE;
>>>>          /* Re-check under ptl */
>>>> -    if (likely(!vmf_pte_changed(vmf))) {
>>>> -        struct folio *folio = page_folio(page);
>>>> -
>>>> -        set_pte_range(vmf, folio, page, 1, vmf->address);
>>>> -        ret = 0;
>>>> -    } else {
>>>> +    if (nr_pages == 1 && vmf_pte_changed(vmf)) {
>>>>            update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>            ret = VM_FAULT_NOPAGE;
>>>> +        goto unlock;
>>>> +    } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>>>
>>> I think you have grabbed this from do_anonymous_page()? But I'm not sure it
>>> works in the same way here as it does there. For the anon case, if userfaultfd
>>> is armed, alloc_anon_folio() will only ever allocate order-0. So we end up in
>>
>> IMO, the userfaultfd validation should do in the vma->vm_ops->fault() callback,
>> to make sure the nr_pages is always 1 if userfaultfd is armed.
> 
> OK. Are you saying there is already logic to do that today? Great!

I mean I should add the userfaultfd validation in shmem_fault(), and may 
be need add a warning in finish_fault() to catch this issue if other 
vma->vm_ops->fault() will support large folio allocation?

WARN_ON(nr_pages > 1 && userfaultfd_armed(vma));

