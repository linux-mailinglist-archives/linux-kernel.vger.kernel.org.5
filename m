Return-Path: <linux-kernel+bounces-104295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 800D887CBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FD7B21C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C4E1B7EB;
	Fri, 15 Mar 2024 10:59:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C2B1B7E2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500367; cv=none; b=ozRqlKs4yqMPFTcCt8DckhBheua47Itk4l3Vlx8HYj/+7Zt8G1w21HsqUa9q9pHknlJa+xXpPcUX2rhVokHJUjEIwvZThJJBXnskG9LQBOWdrmqHKFFJRgTpdptWTrjZjhutvGqIokYv2whozHvjtdgAE7HQuPywDUFt8aAji9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500367; c=relaxed/simple;
	bh=43rVENI8c7Xjq3GiKV/Hi0nkYIdilqgYNSWoFHgvraU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBFhjMGEPP6k3nmtE9Qtt8FlDcyBkPW5f3u/DtreEJDUOrq2jr9jHpIhHef7nysekZ3e8oeRzpuLZH9/YHJp2UUiTRZMcfJh0rwIM8YHNvhXL7ai2REpBY0xyCfuMA7CK/H1iy4YFpeEd+LwnlInD33UOdCSAR3p74rtmr9Lous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 207B2C15;
	Fri, 15 Mar 2024 04:00:00 -0700 (PDT)
Received: from [10.57.69.160] (unknown [10.57.69.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AE513F762;
	Fri, 15 Mar 2024 03:59:17 -0700 (PDT)
Message-ID: <ac660239-fd53-4e88-9c40-3d81fb4df259@arm.com>
Date: Fri, 15 Mar 2024 10:59:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: Chuanhua Han <chuanhuahan@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org,
 david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Chuanhua Han
 <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-6-21cnbao@gmail.com>
 <c9702789-5772-4750-a609-e44a5bbd8468@arm.com>
 <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
 <85b59657-9660-41a2-b091-0c6ec4a6ef16@arm.com>
 <CAGsJ_4wwyFtyYgyoHpWOR=rbg23pkaMNLxJ0oMKbQjPb5oR-RQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wwyFtyYgyoHpWOR=rbg23pkaMNLxJ0oMKbQjPb5oR-RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2024 20:43, Barry Song wrote:
> On Fri, Mar 15, 2024 at 2:57 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 14/03/2024 12:56, Chuanhua Han wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> 于2024年3月13日周三 00:33写道：
>>>>
>>>> On 04/03/2024 08:13, Barry Song wrote:
>>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>>>
>>>>> On an embedded system like Android, more than half of anon memory is
>>>>> actually in swap devices such as zRAM. For example, while an app is
>>>>> switched to background, its most memory might be swapped-out.
>>>>>
>>>>> Now we have mTHP features, unfortunately, if we don't support large folios
>>>>> swap-in, once those large folios are swapped-out, we immediately lose the
>>>>> performance gain we can get through large folios and hardware optimization
>>>>> such as CONT-PTE.
>>>>>
>>>>> This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-in
>>>>> to those contiguous swaps which were likely swapped out from mTHP as a
>>>>> whole.
>>>>>
>>>>> Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
>>>>> case. It doesn't support swapin_readahead as large folios yet since this
>>>>> kind of shared memory is much less than memory mapped by single process.
>>>>>
>>>>> Right now, we are re-faulting large folios which are still in swapcache as a
>>>>> whole, this can effectively decrease extra loops and early-exitings which we
>>>>> have increased in arch_swap_restore() while supporting MTE restore for folios
>>>>> rather than page. On the other hand, it can also decrease do_swap_page as
>>>>> PTEs used to be set one by one even we hit a large folio in swapcache.
>>>>>
>>>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>> ---
>>>>>  mm/memory.c | 250 ++++++++++++++++++++++++++++++++++++++++++++--------
>>>>>  1 file changed, 212 insertions(+), 38 deletions(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index e0d34d705e07..501ede745ef3 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -3907,6 +3907,136 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>>>>>       return VM_FAULT_SIGBUS;
>>>>>  }
>>>>>
>>>>> +/*
>>>>> + * check a range of PTEs are completely swap entries with
>>>>> + * contiguous swap offsets and the same SWAP_HAS_CACHE.
>>>>> + * pte must be first one in the range
>>>>> + */
>>>>> +static bool is_pte_range_contig_swap(pte_t *pte, int nr_pages)
>>>>> +{
>>>>> +     int i;
>>>>> +     struct swap_info_struct *si;
>>>>> +     swp_entry_t entry;
>>>>> +     unsigned type;
>>>>> +     pgoff_t start_offset;
>>>>> +     char has_cache;
>>>>> +
>>>>> +     entry = pte_to_swp_entry(ptep_get_lockless(pte));
>>>>
>>>> Given you are getting entry locklessly, I expect it could change under you? So
>>>> probably need to check that its a swap entry, etc. first?
>>> The following non_swap_entry checks to see if it is a swap entry.
>>
>> No, it checks if something already known to be a "swap entry" type is actually
>> describing a swap entry, or a non-swap entry (e.g. migration entry, hwpoison
>> entry, etc.) Swap entries with type >= MAX_SWAPFILES don't actually describe swap:
>>
>> static inline int non_swap_entry(swp_entry_t entry)
>> {
>>         return swp_type(entry) >= MAX_SWAPFILES;
>> }
>>
>>
>> So you need to do something like:
>>
>> pte = ptep_get_lockless(pte);
>> if (pte_none(pte) || !pte_present(pte))
>>         return false;
> 
> 
> Indeed, I noticed that a couple of days ago, but it turned out that it
> didn't cause any issues
> because the condition following 'if (swp_offset(entry) != start_offset
> + i)'  cannot be true :-)
> 
> I do agree it needs a fix here. maybe by
> 
> if (!is_swap_pte(pte))
>            return false?

Nice! I hadn't noticed is_swap_pte().

> 
>> entry = pte_to_swp_entry(pte);
>> if (non_swap_entry(entry))
>>         return false;
>> ...
>>
>>>>
>>>>> +     if (non_swap_entry(entry))
>>>>> +             return false;
>>>>> +     start_offset = swp_offset(entry);
>>>>> +     if (start_offset % nr_pages)
>>>>> +             return false;
>>>>> +
>>>>> +     si = swp_swap_info(entry);
>>>>
>>>> What ensures si remains valid (i.e. swapoff can't happen)? If swapoff can race,
>>>> then swap_map may have been freed when you read it below. Holding the PTL can
>>>> sometimes prevent it, but I don't think you're holding that here (you're using
>>>> ptep_get_lockless(). Perhaps get_swap_device()/put_swap_device() can help?
>>> Thank you for your review,you are righit! this place reaally needs
>>> get_swap_device()/put_swap_device().
>>>>
>>>>> +     type = swp_type(entry);
>>>>> +     has_cache = si->swap_map[start_offset] & SWAP_HAS_CACHE;
>>>>> +     for (i = 1; i < nr_pages; i++) {
>>>>> +             entry = pte_to_swp_entry(ptep_get_lockless(pte + i));
>>>>> +             if (non_swap_entry(entry))
>>>>> +                     return false;
>>>>> +             if (swp_offset(entry) != start_offset + i)
>>>>> +                     return false;
>>>>> +             if (swp_type(entry) != type)
>>>>> +                     return false;
>>>>> +             /*
>>>>> +              * while allocating a large folio and doing swap_read_folio for the
>>>>> +              * SWP_SYNCHRONOUS_IO path, which is the case the being faulted pte
>>>>> +              * doesn't have swapcache. We need to ensure all PTEs have no cache
>>>>> +              * as well, otherwise, we might go to swap devices while the content
>>>>> +              * is in swapcache
>>>>> +              */
>>>>> +             if ((si->swap_map[start_offset + i] & SWAP_HAS_CACHE) != has_cache)
>>>>> +                     return false;
>>>>> +     }
>>>>> +
>>>>> +     return true;
>>>>> +}
>>>>
>>>> I created swap_pte_batch() for the swap-out series [1]. I wonder if that could
>>>> be extended for the SWAP_HAS_CACHE checks? Possibly not because it assumes the
>>>> PTL is held, and you are lockless here. Thought it might be of interest though.
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/20240311150058.1122862-3-ryan.roberts@arm.com/
>>>>
>>> Thanks. It's probably simily to ours, but as you said we are lockless
>>> here, and we need to check has_cache.
>>>>> +
>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> +/*
>>>>> + * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>>>> + * for this vma. Then filter out the orders that can't be allocated over
>>>>> + * the faulting address and still be fully contained in the vma.
>>>>> + */
>>>>> +static inline unsigned long get_alloc_folio_orders(struct vm_fault *vmf)
>>>>> +{
>>>>> +     struct vm_area_struct *vma = vmf->vma;
>>>>> +     unsigned long orders;
>>>>> +
>>>>> +     orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>>>>> +                                       BIT(PMD_ORDER) - 1);
>>>>> +     orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>>>> +     return orders;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>>>>> +{
>>>>> +     struct vm_area_struct *vma = vmf->vma;
>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> +     unsigned long orders;
>>>>> +     struct folio *folio;
>>>>> +     unsigned long addr;
>>>>> +     pte_t *pte;
>>>>> +     gfp_t gfp;
>>>>> +     int order;
>>>>> +
>>>>> +     /*
>>>>> +      * If uffd is active for the vma we need per-page fault fidelity to
>>>>> +      * maintain the uffd semantics.
>>>>> +      */
>>>>> +     if (unlikely(userfaultfd_armed(vma)))
>>>>> +             goto fallback;
>>>>> +
>>>>> +     /*
>>>>> +      * a large folio being swapped-in could be partially in
>>>>> +      * zswap and partially in swap devices, zswap doesn't
>>>>> +      * support large folios yet, we might get corrupted
>>>>> +      * zero-filled data by reading all subpages from swap
>>>>> +      * devices while some of them are actually in zswap
>>>>> +      */
>>>>> +     if (is_zswap_enabled())
>>>>> +             goto fallback;
>>>>> +
>>>>> +     orders = get_alloc_folio_orders(vmf);
>>>>> +     if (!orders)
>>>>> +             goto fallback;
>>>>> +
>>>>> +     pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>>
>>>> Could also briefly take PTL here, then is_pte_range_contig_swap() could be
>>>> merged with an enhanced swap_pte_batch()?
>>> Yes, it's easy to use a lock here, but I'm wondering if it's
>>> necessary, because when we actually set pte in do_swap_page, we'll
>>> hold PTL to check if the pte changes.
>>>>
>>>>> +     if (unlikely(!pte))
>>>>> +             goto fallback;
>>>>> +
>>>>> +     /*
>>>>> +      * For do_swap_page, find the highest order where the aligned range is
>>>>> +      * completely swap entries with contiguous swap offsets.
>>>>> +      */
>>>>> +     order = highest_order(orders);
>>>>> +     while (orders) {
>>>>> +             addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>>> +             if (is_pte_range_contig_swap(pte + pte_index(addr), 1 << order))
>>>>> +                     break;
>>>>> +             order = next_order(&orders, order);
>>>>> +     }
>>>>
>>>> So in the common case, swap-in will pull in the same size of folio as was
>>>> swapped-out. Is that definitely the right policy for all folio sizes? Certainly
>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
>>>> it makes sense for 2M THP; As the size increases the chances of actually needing
>>>> all of the folio reduces so chances are we are wasting IO. There are similar
>>>> arguments for CoW, where we currently copy 1 page per fault - it probably makes
>>>> sense to copy the whole folio up to a certain size.
>>> For 2M THP, IO overhead may not necessarily be large? :)
>>> 1.If 2M THP are continuously stored in the swap device, the IO
>>> overhead may not be very large (such as submitting bio with one
>>> bio_vec at a time).
>>> 2.If the process really needs this 2M data, one page-fault may perform
>>> much better than multiple.
>>> 3.For swap devices like zram,using 2M THP might also improve
>>> decompression efficiency.
>>>
>>> On the other hand, if the process only needs a small part of the 2M
>>> data (such as only frequent use of 4K page, the rest of the data is
>>> never accessed), This is indeed give a lark to catch a kite!  :(
>>
>> Yes indeed. It's not always clear-cut what the best thing to do is. It would be
>> good to hear from others on this.
>>
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>> +
>>>>> +     pte_unmap(pte);
>>>>> +
>>>>> +     /* Try allocating the highest of the remaining orders. */
>>>>> +     gfp = vma_thp_gfp_mask(vma);
>>>>> +     while (orders) {
>>>>> +             addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>>>>> +             folio = vma_alloc_folio(gfp, order, vma, addr, true);
>>>>> +             if (folio)
>>>>> +                     return folio;
>>>>> +             order = next_order(&orders, order);
>>>>> +     }
>>>>> +
>>>>> +fallback:
>>>>> +#endif
>>>>> +     return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
>>>>> +}
>>>>> +
>>>>> +
>>>>>  /*
>>>>>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>>>>>   * but allow concurrent faults), and pte mapped but not yet locked.
>>>>> @@ -3928,6 +4058,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>       pte_t pte;
>>>>>       vm_fault_t ret = 0;
>>>>>       void *shadow = NULL;
>>>>> +     int nr_pages = 1;
>>>>> +     unsigned long start_address;
>>>>> +     pte_t *start_pte;
>>>>>
>>>>>       if (!pte_unmap_same(vmf))
>>>>>               goto out;
>>>>> @@ -3991,35 +4124,41 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>       if (!folio) {
>>>>>               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>>>>                   __swap_count(entry) == 1) {
>>>>> -                     /*
>>>>> -                      * Prevent parallel swapin from proceeding with
>>>>> -                      * the cache flag. Otherwise, another thread may
>>>>> -                      * finish swapin first, free the entry, and swapout
>>>>> -                      * reusing the same entry. It's undetectable as
>>>>> -                      * pte_same() returns true due to entry reuse.
>>>>> -                      */
>>>>> -                     if (swapcache_prepare(entry)) {
>>>>> -                             /* Relax a bit to prevent rapid repeated page faults */
>>>>> -                             schedule_timeout_uninterruptible(1);
>>>>> -                             goto out;
>>>>> -                     }
>>>>> -                     need_clear_cache = true;
>>>>> -
>>>>>                       /* skip swapcache */
>>>>> -                     folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>>>>> -                                             vma, vmf->address, false);
>>>>> +                     folio = alloc_swap_folio(vmf);
>>>>>                       page = &folio->page;
>>>>>                       if (folio) {
>>>>>                               __folio_set_locked(folio);
>>>>>                               __folio_set_swapbacked(folio);
>>>>>
>>>>> +                             if (folio_test_large(folio)) {
>>>>> +                                     nr_pages = folio_nr_pages(folio);
>>>>> +                                     entry.val = ALIGN_DOWN(entry.val, nr_pages);
>>>>> +                             }
>>>>> +
>>>>> +                             /*
>>>>> +                              * Prevent parallel swapin from proceeding with
>>>>> +                              * the cache flag. Otherwise, another thread may
>>>>> +                              * finish swapin first, free the entry, and swapout
>>>>> +                              * reusing the same entry. It's undetectable as
>>>>> +                              * pte_same() returns true due to entry reuse.
>>>>> +                              */
>>>>> +                             if (swapcache_prepare_nr(entry, nr_pages)) {
>>>>> +                                     /* Relax a bit to prevent rapid repeated page faults */
>>>>> +                                     schedule_timeout_uninterruptible(1);
>>>>> +                                     goto out;
>>>>> +                             }
>>>>> +                             need_clear_cache = true;
>>>>> +
>>>>>                               if (mem_cgroup_swapin_charge_folio(folio,
>>>>>                                                       vma->vm_mm, GFP_KERNEL,
>>>>>                                                       entry)) {
>>>>>                                       ret = VM_FAULT_OOM;
>>>>>                                       goto out_page;
>>>>>                               }
>>>>> -                             mem_cgroup_swapin_uncharge_swap(entry);
>>>>> +
>>>>> +                             for (swp_entry_t e = entry; e.val < entry.val + nr_pages; e.val++)
>>>>> +                                     mem_cgroup_swapin_uncharge_swap(e);
>>>>>
>>>>>                               shadow = get_shadow_from_swap_cache(entry);
>>>>>                               if (shadow)
>>>>> @@ -4118,6 +4257,42 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>        */
>>>>>       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>>>                       &vmf->ptl);
>>>>> +
>>>>> +     start_address = vmf->address;
>>>>> +     start_pte = vmf->pte;
>>>>> +     if (start_pte && folio_test_large(folio)) {
>>>>> +             unsigned long nr = folio_nr_pages(folio);
>>>>> +             unsigned long addr = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
>>>>> +             pte_t *aligned_pte = vmf->pte - (vmf->address - addr) / PAGE_SIZE;
>>>>> +
>>>>> +             /*
>>>>> +              * case 1: we are allocating large_folio, try to map it as a whole
>>>>> +              * iff the swap entries are still entirely mapped;
>>>>> +              * case 2: we hit a large folio in swapcache, and all swap entries
>>>>> +              * are still entirely mapped, try to map a large folio as a whole.
>>>>> +              * otherwise, map only the faulting page within the large folio
>>>>> +              * which is swapcache
>>>>> +              */
>>>>> +             if (!is_pte_range_contig_swap(aligned_pte, nr)) {
>>>>> +                     if (nr_pages > 1) /* ptes have changed for case 1 */
>>>>> +                             goto out_nomap;
>>>>> +                     goto check_pte;
>>>>> +             }
>>>>> +
>>>>> +             start_address = addr;
>>>>> +             start_pte = aligned_pte;
>>>>> +             /*
>>>>> +              * the below has been done before swap_read_folio()
>>>>> +              * for case 1
>>>>> +              */
>>>>> +             if (unlikely(folio == swapcache)) {
>>>>> +                     nr_pages = nr;
>>>>> +                     entry.val = ALIGN_DOWN(entry.val, nr_pages);
>>>>> +                     page = &folio->page;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +check_pte:
>>>>>       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
>>>>>               goto out_nomap;
>>>>>
>>>>> @@ -4185,12 +4360,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>        * We're already holding a reference on the page but haven't mapped it
>>>>>        * yet.
>>>>>        */
>>>>> -     swap_free(entry);
>>>>> +     swap_nr_free(entry, nr_pages);
>>>>>       if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>>>               folio_free_swap(folio);
>>>>>
>>>>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>>>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>>>> +     folio_ref_add(folio, nr_pages - 1);
>>>>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>>>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>>>>> +
>>>>>       pte = mk_pte(page, vma->vm_page_prot);
>>>>>
>>>>>       /*
>>>>> @@ -4200,14 +4377,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>        * exclusivity.
>>>>>        */
>>>>>       if (!folio_test_ksm(folio) &&
>>>>> -         (exclusive || folio_ref_count(folio) == 1)) {
>>>>> +         (exclusive || folio_ref_count(folio) == nr_pages)) {
>>>>>               if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>>                       pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>>>>>                       vmf->flags &= ~FAULT_FLAG_WRITE;
>>>>>               }
>>>>>               rmap_flags |= RMAP_EXCLUSIVE;
>>>>>       }
>>>>> -     flush_icache_page(vma, page);
>>>>> +     flush_icache_pages(vma, page, nr_pages);
>>>>>       if (pte_swp_soft_dirty(vmf->orig_pte))
>>>>>               pte = pte_mksoft_dirty(pte);
>>>>>       if (pte_swp_uffd_wp(vmf->orig_pte))
>>>>> @@ -4216,17 +4393,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>
>>>>>       /* ksm created a completely new copy */
>>>>>       if (unlikely(folio != swapcache && swapcache)) {
>>>>> -             folio_add_new_anon_rmap(folio, vma, vmf->address);
>>>>> +             folio_add_new_anon_rmap(folio, vma, start_address);
>>>>>               folio_add_lru_vma(folio, vma);
>>>>> +     } else if (!folio_test_anon(folio)) {
>>>>> +             folio_add_new_anon_rmap(folio, vma, start_address);
>>>>>       } else {
>>>>> -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
>>>>> +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, start_address,
>>>>>                                       rmap_flags);
>>>>>       }
>>>>>
>>>>>       VM_BUG_ON(!folio_test_anon(folio) ||
>>>>>                       (pte_write(pte) && !PageAnonExclusive(page)));
>>>>> -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>>>>> -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>>>>> +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
>>>>> +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->orig_pte);
>>>>>
>>>>>       folio_unlock(folio);
>>>>>       if (folio != swapcache && swapcache) {
>>>>> @@ -4243,6 +4422,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>       }
>>>>>
>>>>>       if (vmf->flags & FAULT_FLAG_WRITE) {
>>>>> +             if (nr_pages > 1)
>>>>> +                     vmf->orig_pte = ptep_get(vmf->pte);
>>>>> +
>>>>>               ret |= do_wp_page(vmf);
>>>>>               if (ret & VM_FAULT_ERROR)
>>>>>                       ret &= VM_FAULT_ERROR;
>>>>> @@ -4250,14 +4432,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>       }
>>>>>
>>>>>       /* No need to invalidate - it was non-present before */
>>>>> -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>>>> +     update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pages);
>>>>>  unlock:
>>>>>       if (vmf->pte)
>>>>>               pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>  out:
>>>>>       /* Clear the swap cache pin for direct swapin after PTL unlock */
>>>>>       if (need_clear_cache)
>>>>> -             swapcache_clear(si, entry);
>>>>> +             swapcache_clear_nr(si, entry, nr_pages);
>>>>>       if (si)
>>>>>               put_swap_device(si);
>>>>>       return ret;
>>>>> @@ -4273,7 +4455,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>               folio_put(swapcache);
>>>>>       }
>>>>>       if (need_clear_cache)
>>>>> -             swapcache_clear(si, entry);
>>>>> +             swapcache_clear_nr(si, entry, nr_pages);
>>>>>       if (si)
>>>>>               put_swap_device(si);
>>>>>       return ret;
>>>>> @@ -4309,15 +4491,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>>>>       if (unlikely(userfaultfd_armed(vma)))
>>>>>               goto fallback;
>>>>>
>>>>> -     /*
>>>>> -      * Get a list of all the (large) orders below PMD_ORDER that are enabled
>>>>> -      * for this vma. Then filter out the orders that can't be allocated over
>>>>> -      * the faulting address and still be fully contained in the vma.
>>>>> -      */
>>>>> -     orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
>>>>> -                                       BIT(PMD_ORDER) - 1);
>>>>> -     orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>>>>> -
>>>>> +     orders = get_alloc_folio_orders(vmf);
>>>>>       if (!orders)
>>>>>               goto fallback;
>>>>>
> 
> Thanks
> Barry


