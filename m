Return-Path: <linux-kernel+bounces-90245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E73286FC64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F245E280D47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE61A28C;
	Mon,  4 Mar 2024 08:47:38 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5E1A29F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542058; cv=none; b=d5pxMFU2wyXdXoafEC48M4fZnhD59j4FjUPujdjavTYjFogExVCteCSq54CEUTUBQo7I1bYQYTYBD2BppFJeoeUJld+ojS5OIlWJmHt1FaKeJ8IB736uwQ9JZnE87kI8N3YUSk/piY0uHs/mcXsERk8lZEa8DwhxBp9ahw9sKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542058; c=relaxed/simple;
	bh=XAknf21rVx62pAgkkL+BL6/e/HvfPNTsKSsFEiwUcwo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mft3iX0wTy3ODBsFDlsPPUpCe4M3s1UoisUjXt9EtWuy5QQCJgctI2NwbBNfXnuenQAztfJi4pJzNou7vg+xwDdxNcOAX/aleO81Ik8ABglKXI153jYWnOQTXvenyAfxABlqD04yKxu219s9cOMW+5TUjQWVjtwDSEekYtHSbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TpC3q6fQzz1vvkM;
	Mon,  4 Mar 2024 16:46:47 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F3971A0172;
	Mon,  4 Mar 2024 16:47:27 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 4 Mar 2024 16:47:26 +0800
Message-ID: <234a5423-8d6d-444a-a27c-c772a71c9871@huawei.com>
Date: Mon, 4 Mar 2024 16:47:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: Re: [Question] CoW on VM_PFNMAP vma during write fault
Content-Language: en-US
To: <david@redhat.com>, <akpm@linux-foundation.org>, <khlebnikov@openvz.org>,
	<jaredeh@gmail.com>, <linmiaohe@huawei.com>, <hpa@zytor.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<jaredeh@gmail.com>, <cotte@de.ibm.com>, <npiggin@suse.de>
References: <20240227122814.3781907-1-mawupeng1@huawei.com>
 <a74c8b96-3fc5-44ff-949c-6e5c5e05e122@redhat.com>
 <de0cc6e0-dd15-40b6-89c2-c8e83fd6f587@redhat.com>
 <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <fa8f9f3b-e01e-4662-a2d5-77caeeb7b9f5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200001.china.huawei.com (7.185.36.224)

Hi Maintainers, kindly ping...

On 2024/2/28 9:55, mawupeng wrote:
> 
> 
> On 2024/2/27 21:15, David Hildenbrand wrote:
>> On 27.02.24 14:00, David Hildenbrand wrote:
>>> On 27.02.24 13:28, Wupeng Ma wrote:
>>>> We find that a warn will be produced during our test, the detail log is
>>>> shown in the end.
>>>>
>>>> The core problem of this warn is that the first pfn of this pfnmap vma is
>>>> cleared during memory-failure. Digging into the source we find that this
>>>> problem can be triggered as following:
>>>>
>>>> // mmap with MAP_PRIVATE and specific fd which hook mmap
>>>> mmap(MAP_PRIVATE, fd)
>>>>     __mmap_region
>>>>       remap_pfn_range
>>>>       // set vma with pfnmap and the prot of pte is read only
>>>>     
>>>
>>> Okay, so we get a MAP_PRIVATE VM_PFNMAP I assume.
>>>
>>> What fd is that exactly? Often, we disallow private mappings in the
>>> mmap() callback (for a good reason).

We found this problem in 5.10, Commit 9f78bf330a66 ("xsk: support use vaddr as ring") Fix this
problem during supporting vaddr by remap VM_PFNMAP by VM_MIXEDMAP. But other modules which
use remap_pfn_range may still have this problem.

It do seems wired for private mappings, What is the good reason?

> 
> just a device fd with device-specify mmap which use remap_pfn_range to assign memory.
> 
>>>
>>>> // memset this memory with trigger fault
>>>> handle_mm_fault
>>>>     __handle_mm_fault
>>>>       handle_pte_fault
>>>>         // write fault and !pte_write(entry)
>>>>         do_wp_page
>>>>           wp_page_copy // this will alloc a new page with valid page struct
>>>>                        // for this pfnmap vma
>>>
>>> Here we replace the mapped PFNMAP thingy by a proper anon folio.
> 
> My problem is can wen replace a pfn with fully functioned page for pfnmap vma? This is not MIXEDMAP vma.
> 
>>>
>>>>
>>>> // inject a hwpoison to the first page of this vma
>>>
>>> I assume this is an anon folio?
> 
> Yes.
> 
>>>
>>>> madvise_inject_error
>>>>     memory_failure
>>>>       hwpoison_user_mappings
>>>>         try_to_unmap_one
>>>>           // mark this pte as invalid (hwpoison)
>>>>           mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
>>>>                   address, range.end);
> 
> If we can replace the mapped PFNMAP thingy by a proper anon folio, we need to make memory_failure to handle
> pfnmap vma properly since pfnmap vma shoule not touch its struct page?
> 
> Current this page have a valid mapping and can be unmap.
> 
> Maybe there is something wrong with my understanding of CoW on a private pfnmap vma.
> 
>>>>
>>>> // during unmap vma, the first pfn of this pfnmap vma is invalid
>>>> vm_mmap_pgoff
>>>>     do_mmap
>>>>       __do_mmap_mm
>>>>         __mmap_region
>>>>           __do_munmap
>>>>             unmap_region
>>>>               unmap_vmas
>>>>                 unmap_single_vma
>>>>                   untrack_pfn
>>>>                     follow_phys // pte is already invalidate, WARN_ON here
>>>
>>> unmap_single_vma()->...->zap_pte_range() should do the right thing when
>>> calling vm_normal_page().
>>>
>>> untrack_pfn() is the problematic part.
> 
> For pfnmap vma, it don't have a valid page for all pfns, so unmap is not expected. In this case, it just
> check wheather the first address have a valid pte or not which seems reasonable to me.
> 
>>>
>>>>
>>>> CoW with a valid page for pfnmap vma is weird to us. Can we use
>>>> remap_pfn_range for private vma(read only)? Once CoW happens on a pfnmap
>>>> vma during write fault, this page is normal(page flag is valid) for most mm
>>>> subsystems, such as memory failure in thais case and extra should be done to
>>>> handle this special page.
>>>>
>>>> During unmap, if this vma is pfnmap, unmap shouldn't be done since page
>>>> should not be touched for pfnmap vma.
>>>>
>>>> But the root problem is that can we insert a valid page for pfnmap vma?
>>>>
>>>> Any thoughts to solve this warn?
>>>
>>> vm_normal_page() documentation explains how that magic is supposed to
>>> work. vm_normal_page() should be able to correctly identify whether we
>>> want to look at the struct page for an anon folio that was COWed.
> 
> vm_normal_page() can find out a CoW mapping but 
> 
>>>
>>>
>>> untrack_pfn() indeed does not seem to be well prepared for handling
>>> MAP_PRIVATE mappings where we end up having anon folios.
>>>
>>> I think it will already *completely mess up* simply when unmapping the
>>> range without the memory failure involved.
>>>
>>> See, follow_phys() would get the PFN of the anon folio and then
>>> untrack_pfn() would do some nonesense with that. Completely broken.
>>>
>>> The WARN is just a side-effect of the brokenness.
>>>
>>> In follow_phys(), we'd likely have to call vm_normal_page(). If we get a
>>> page back, we'd likely have to fail follow_phys() instead of returning a
>>> PFN of an anon folio.
>>>
>>> Now, how do we fix untrack_pfn() ? I really don't know. In theory, we
>>> might no longer have *any* PFNMAP PFN in there after COW'ing everything.
>>>
>>> Sounds like MAP_PRIVATE VM_PFNMAP + __HAVE_PFNMAP_TRACKING is some
>>> broken garbage (sorry). Can we disallow it?
>>
>> Staring at track_pfn_copy(), it's maybe similarly broken?
>>
>> I think we want to do:
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 098356b8805ae..da5d1e37c5534 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -6050,6 +6050,10 @@ int follow_phys(struct vm_area_struct *vma,
>>                 goto out;
>>         pte = ptep_get(ptep);
>>  
>> +       /* Never return addresses of COW'ed anon folios. */
>> +       if (vm_normal_page(vma, address, pte))
>> +               goto unlock;
>> +
>>         if ((flags & FOLL_WRITE) && !pte_write(pte))
>>                 goto unlock;
>>  
>>
>> And then, just disallow it with PAT involved:
>>
>> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
>> index 0904d7e8e1260..e4d2b2e8c0281 100644
>> --- a/arch/x86/mm/pat/memtype.c
>> +++ b/arch/x86/mm/pat/memtype.c
>> @@ -997,6 +997,15 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
>>                                 && size == (vma->vm_end - vma->vm_start))) {
>>                 int ret;
>>  
>> +               /*
>> +                * untrack_pfn() and friends cannot handl regions that suddenly
>> +                * contain anon folios after COW. In particular, follow_phys()
>> +                * will fail when we have an anon folio at the beginning og the
>> +                * VMA.
>> +                */
>> +               if (vma && is_cow_mapping(vma->vm_flags))
>> +                       return -EINVAL;
> 
> In this case, anyone use remap_pfn_range can not be cow_maaping which means if VM_MAYWRITE exists, VM_SHARED is
> needed for this vma.
> 
> This can solve this CoW on private vma problem.
> 
>> +
>>                 ret = reserve_pfn_range(paddr, size, prot, 0);
>>                 if (ret == 0 && vma)
>>                         vm_flags_set(vma, VM_PAT);
>>
>>
>> I'm afraid that will break something. But well, it's already semi-broken.
>>
>> As long as VM_PAT is not involved, it should work as expected.
>>
>> In an ideal world, we'd get rid of follow_phys() completely and just
>> derive that information from the VMA?
>>

