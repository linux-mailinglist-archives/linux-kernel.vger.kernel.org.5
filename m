Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC97E5F12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjKHUVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKHUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:21:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03F62212C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:21:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50961476;
        Wed,  8 Nov 2023 12:21:46 -0800 (PST)
Received: from [10.57.72.173] (unknown [10.57.72.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A3433F6C4;
        Wed,  8 Nov 2023 12:20:59 -0800 (PST)
Message-ID: <2c98be67-657e-4c65-bf6b-3d70ff596c64@arm.com>
Date:   Wed, 8 Nov 2023 20:20:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     steven.price@arm.com, akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>, nd@arm.com
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com>
 <20231104093423.170054-1-v-songbaohua@oppo.com>
 <b0e4257e-b094-40b6-adb3-923c0d008309@arm.com>
 <CAGsJ_4zntZ4Drm5jndXamy_4VoVQ3qbCpUqCR9k4vdxLdmMO4Q@mail.gmail.com>
 <CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xmBAcApyK8NgVQeX_Znp5e8D4fbbhGguOkNzmh1Veocg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2023 11:23, Barry Song wrote:
> On Wed, Nov 8, 2023 at 2:05 AM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Tue, Nov 7, 2023 at 8:46 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 04/11/2023 09:34, Barry Song wrote:
>>>>> Yes that's right. mte_save_tags() needs to allocate memory so can fail
>>>>> and if failing then arch_prepare_to_swap() would need to put things back
>>>>> how they were with calls to mte_invalidate_tags() (although I think
>>>>> you'd actually want to refactor to create a function which takes a
>>>>> struct page *).
>>>>>
>>>>> Steve
>>>>
>>>> Thanks, Steve. combining all comments from You and Ryan, I made a v2.
>>>> One tricky thing is that we are restoring one page rather than folio
>>>> in arch_restore_swap() as we are only swapping in one page at this
>>>> stage.
>>>>
>>>> [RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large folios
>>>>
>>>> This patch makes MTE tags saving and restoring support large folios,
>>>> then we don't need to split them into base pages for swapping on
>>>> ARM64 SoCs with MTE.
>>>>
>>>> This patch moves arch_prepare_to_swap() to take folio rather than
>>>> page, as we support THP swap-out as a whole. And this patch also
>>>> drops arch_thp_swp_supported() as ARM64 MTE is the only one who
>>>> needs it.
>>>>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>> ---
>>>>  arch/arm64/include/asm/pgtable.h | 21 +++------------
>>>>  arch/arm64/mm/mteswap.c          | 44 ++++++++++++++++++++++++++++++++
>>>>  include/linux/huge_mm.h          | 12 ---------
>>>>  include/linux/pgtable.h          |  2 +-
>>>>  mm/page_io.c                     |  2 +-
>>>>  mm/swap_slots.c                  |  2 +-
>>>>  6 files changed, 51 insertions(+), 32 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index b19a8aee684c..d8f523dc41e7 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -45,12 +45,6 @@
>>>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>
>>>> -static inline bool arch_thp_swp_supported(void)
>>>> -{
>>>> -     return !system_supports_mte();
>>>> -}
>>>> -#define arch_thp_swp_supported arch_thp_swp_supported
>>>> -
>>>>  /*
>>>>   * Outside of a few very special situations (e.g. hibernation), we always
>>>>   * use broadcast TLB invalidation instructions, therefore a spurious page
>>>> @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>>>  #ifdef CONFIG_ARM64_MTE
>>>>
>>>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
>>>> -static inline int arch_prepare_to_swap(struct page *page)
>>>> -{
>>>> -     if (system_supports_mte())
>>>> -             return mte_save_tags(page);
>>>> -     return 0;
>>>> -}
>>>> +#define arch_prepare_to_swap arch_prepare_to_swap
>>>> +extern int arch_prepare_to_swap(struct folio *folio);
>>>>
>>>>  #define __HAVE_ARCH_SWAP_INVALIDATE
>>>>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
>>>> @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int type)
>>>>  }
>>>>
>>>>  #define __HAVE_ARCH_SWAP_RESTORE
>>>> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>>> -{
>>>> -     if (system_supports_mte())
>>>> -             mte_restore_tags(entry, &folio->page);
>>>> -}
>>>> +#define arch_swap_restore arch_swap_restore
>>>> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
>>>>
>>>>  #endif /* CONFIG_ARM64_MTE */
>>>>
>>>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
>>>> index a31833e3ddc5..14a479e4ea8e 100644
>>>> --- a/arch/arm64/mm/mteswap.c
>>>> +++ b/arch/arm64/mm/mteswap.c
>>>> @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
>>>>       mte_free_tag_storage(tags);
>>>>  }
>>>>
>>>> +static inline void __mte_invalidate_tags(struct page *page)
>>>> +{
>>>> +     swp_entry_t entry = page_swap_entry(page);
>>>> +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
>>>> +}
>>>> +
>>>>  void mte_invalidate_tags_area(int type)
>>>>  {
>>>>       swp_entry_t entry = swp_entry(type, 0);
>>>> @@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
>>>>       }
>>>>       xa_unlock(&mte_pages);
>>>>  }
>>>> +
>>>> +int arch_prepare_to_swap(struct folio *folio)
>>>> +{
>>>> +     int err;
>>>> +     long i;
>>>> +
>>>> +     if (system_supports_mte()) {
>>>> +             long nr = folio_nr_pages(folio);
>>>
>>> nit: there should be a clear line between variable declarations and logic.
>>
>> right.
>>
>>>
>>>> +             for (i = 0; i < nr; i++) {
>>>> +                     err = mte_save_tags(folio_page(folio, i));
>>>> +                     if (err)
>>>> +                             goto out;
>>>> +             }
>>>> +     }
>>>> +     return 0;
>>>> +
>>>> +out:
>>>> +     while (--i)
>>>
>>> If i is initially > 0, this will fail to invalidate page 0. If i is initially 0
>>> then it will wrap and run ~forever. I think you meant `while (i--)`?
>>
>> nop. if i=0 and we goto out, that means the page0 has failed to save tags,
>> there is nothing to revert. if i=3 and we goto out, that means 0,1,2 have
>> saved, we restore 0,1,2 and we don't restore 3.
> 
> I am terribly sorry for my previous noise. You are right, Ryan. i
> actually meant i--.

No problem - it saves me from writing a long response explaining why --i is
wrong, at least!

> 
>>
>>>
>>>> +             __mte_invalidate_tags(folio_page(folio, i));
>>>> +     return err;
>>>> +}
>>>> +
>>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>>> +{
>>>> +     if (system_supports_mte()) {
>>>> +             /*
>>>> +              * We don't support large folios swap in as whole yet, but
>>>> +              * we can hit a large folio which is still in swapcache
>>>> +              * after those related processes' PTEs have been unmapped
>>>> +              * but before the swapcache folio  is dropped, in this case,
>>>> +              * we need to find the exact page which "entry" is mapping
>>>> +              * to. If we are not hitting swapcache, this folio won't be
>>>> +              * large
>>>> +              */
>>>
>>> So the currently defined API allows a large folio to be passed but the caller is
>>> supposed to find the single correct page using the swap entry? That feels quite
>>> nasty to me. And that's not what the old version of the function was doing; it
>>> always assumed that the folio was small and passed the first page (which also
>>> doesn't feel 'nice'). If the old version was wrong, I suggest a separate commit
>>> to fix that. If the old version is correct, then I guess this version is wrong.
>>
>> the original version(mainline) is wrong but it works as once we find the SoCs
>> support MTE, we will split large folios into small pages. so only small pages
>> will be added into swapcache successfully.
>>
>> but now we want to swap out large folios even on SoCs with MTE as a whole,
>> we don't split, so this breaks the assumption do_swap_page() will always get
>> small pages.
> 
> let me clarify this more. The current mainline assumes
> arch_swap_restore() always
> get a folio with only one page. this is true as we split large folios
> if we find SoCs
> have MTE. but since we are dropping the split now, that means a large
> folio can be
> gotten by do_swap_page(). we have a chance that try_to_unmap_one() has been done
> but folio is not put. so PTEs will have swap entry but folio is still
> there, and do_swap_page()
> to hit cache directly and the folio won't be released.
> 
> but after getting the large folio in do_swap_page, it still only takes
> one basepage particularly
> for the faulted PTE and maps this 4KB PTE only. so it uses the faulted
> swap_entry and
> the folio as parameters to call arch_swap_restore() which can be something like:
> 
> do_swap_page()
> {
>         arch_swap_restore(the swap entry for the faulted 4KB PTE, large folio);
> }

OK, I understand what's going on, but it seems like a bad API decision. I think
Steve is saying the same thing; If its only intended to operate on a single
page, it would be much clearer to pass the actual page rather than the folio;
i.e. leave the complexity of figuring out the target page to the caller, which
understands all this.

As a side note, if the folio is still in the cache, doesn't that imply that the
tags haven't been torn down yet? So perhaps you can avoid even making the call
in this case?

>>
>>>
>>> Thanks,
>>> Ryan
> 
> Thanks
> Barry

