Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5F7E55C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjKHLwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHLwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:52:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 972331BD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:52:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF5211477;
        Wed,  8 Nov 2023 03:52:47 -0800 (PST)
Received: from [10.1.36.36] (e122027.cambridge.arm.com [10.1.36.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF50C3F703;
        Wed,  8 Nov 2023 03:52:00 -0800 (PST)
Message-ID: <09050cd1-f20a-4d46-9bda-ef1d7b4f1f6c@arm.com>
Date:   Wed, 8 Nov 2023 11:51:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com,
        Barry Song <v-songbaohua@oppo.com>
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com>
 <20231104093423.170054-1-v-songbaohua@oppo.com>
 <e84ae266-6de4-4b40-babc-ce4777b4c3fa@arm.com>
 <CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <CAGsJ_4yXjex8txgEGt7+WMKp4uDQTn-fR06ijv4Ac68MkhjMDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2023 21:39, Barry Song wrote:
> On Mon, Nov 6, 2023 at 6:12 PM Steven Price <steven.price@arm.com> wrote:
>>
>> On 04/11/2023 09:34, Barry Song wrote:
>>>> Yes that's right. mte_save_tags() needs to allocate memory so can fail
>>>> and if failing then arch_prepare_to_swap() would need to put things back
>>>> how they were with calls to mte_invalidate_tags() (although I think
>>>> you'd actually want to refactor to create a function which takes a
>>>> struct page *).
>>>>
>>>> Steve
>>>
>>> Thanks, Steve. combining all comments from You and Ryan, I made a v2.
>>> One tricky thing is that we are restoring one page rather than folio
>>> in arch_restore_swap() as we are only swapping in one page at this
>>> stage.
>>>
>>> [RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large folios
>>>
>>> This patch makes MTE tags saving and restoring support large folios,
>>> then we don't need to split them into base pages for swapping on
>>> ARM64 SoCs with MTE.
>>>
>>> This patch moves arch_prepare_to_swap() to take folio rather than
>>> page, as we support THP swap-out as a whole. And this patch also
>>> drops arch_thp_swp_supported() as ARM64 MTE is the only one who
>>> needs it.
>>>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>  arch/arm64/include/asm/pgtable.h | 21 +++------------
>>>  arch/arm64/mm/mteswap.c          | 44 ++++++++++++++++++++++++++++++++
>>>  include/linux/huge_mm.h          | 12 ---------
>>>  include/linux/pgtable.h          |  2 +-
>>>  mm/page_io.c                     |  2 +-
>>>  mm/swap_slots.c                  |  2 +-
>>>  6 files changed, 51 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index b19a8aee684c..d8f523dc41e7 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -45,12 +45,6 @@
>>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>
>>> -static inline bool arch_thp_swp_supported(void)
>>> -{
>>> -     return !system_supports_mte();
>>> -}
>>> -#define arch_thp_swp_supported arch_thp_swp_supported
>>> -
>>>  /*
>>>   * Outside of a few very special situations (e.g. hibernation), we always
>>>   * use broadcast TLB invalidation instructions, therefore a spurious page
>>> @@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>>  #ifdef CONFIG_ARM64_MTE
>>>
>>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
>>> -static inline int arch_prepare_to_swap(struct page *page)
>>> -{
>>> -     if (system_supports_mte())
>>> -             return mte_save_tags(page);
>>> -     return 0;
>>> -}
>>> +#define arch_prepare_to_swap arch_prepare_to_swap
>>> +extern int arch_prepare_to_swap(struct folio *folio);
>>>
>>>  #define __HAVE_ARCH_SWAP_INVALIDATE
>>>  static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
>>> @@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int type)
>>>  }
>>>
>>>  #define __HAVE_ARCH_SWAP_RESTORE
>>> -static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>> -{
>>> -     if (system_supports_mte())
>>> -             mte_restore_tags(entry, &folio->page);
>>> -}
>>> +#define arch_swap_restore arch_swap_restore
>>> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
>>>
>>>  #endif /* CONFIG_ARM64_MTE */
>>>
>>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
>>> index a31833e3ddc5..14a479e4ea8e 100644
>>> --- a/arch/arm64/mm/mteswap.c
>>> +++ b/arch/arm64/mm/mteswap.c
>>> @@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
>>>       mte_free_tag_storage(tags);
>>>  }
>>>
>>> +static inline void __mte_invalidate_tags(struct page *page)
>>> +{
>>> +     swp_entry_t entry = page_swap_entry(page);
>>> +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
>>> +}
>>> +
>>>  void mte_invalidate_tags_area(int type)
>>>  {
>>>       swp_entry_t entry = swp_entry(type, 0);
>>> @@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
>>>       }
>>>       xa_unlock(&mte_pages);
>>>  }
>>> +
>>> +int arch_prepare_to_swap(struct folio *folio)
>>> +{
>>> +     int err;
>>> +     long i;
>>> +
>>> +     if (system_supports_mte()) {
>>> +             long nr = folio_nr_pages(folio);
>>> +             for (i = 0; i < nr; i++) {
>>> +                     err = mte_save_tags(folio_page(folio, i));
>>> +                     if (err)
>>> +                             goto out;
>>> +             }
>>> +     }
>>> +     return 0;
>>> +
>>> +out:
>>> +     while (--i)
>>> +             __mte_invalidate_tags(folio_page(folio, i));
>>> +     return err;
>>> +}
>>> +
>>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>>> +{
>>> +     if (system_supports_mte()) {
>>> +             /*
>>> +              * We don't support large folios swap in as whole yet, but
>>> +              * we can hit a large folio which is still in swapcache
>>> +              * after those related processes' PTEs have been unmapped
>>> +              * but before the swapcache folio  is dropped, in this case,
>>> +              * we need to find the exact page which "entry" is mapping
>>> +              * to. If we are not hitting swapcache, this folio won't be
>>> +              * large
>>> +              */
>>
>> Does it make sense to keep arch_swap_restore taking a folio? I'm not
>> sure I understand why the change was made in the first place. It just
>> seems odd to have a function taking a struct folio but making the
>> assumption that it's actually only a single page (and having to use
>> entry to figure out which page).
> 
> Steve, let me give an example. in case we have a large anon folios with
> 16 pages.
> 
> while reclaiming, we do add_to_swap(), this folio is added to swapcache
> as a whole; then we unmap the folio; in the last step,  we try to release
> the folio.
> 
> we have a good chance some processes might access the virtual address
> after the folio is unmapped but before the folio is finally released. thus,
> do_swap_page() will find the large folio in swapcache, there is no I/O needed.
> 
> Let's assume processes read the 3rd page of the unmapped folio, in
> do_swap_page(), the code is like,
> 
> vm_fault_t do_swap_page(struct vm_fault *vmf)
> {
>      swp_entry_t entry;
>      ...
>      entry = pte_to_swp_entry(vmf->orig_pte);
> 
>      folio = swap_cache_get_folio(entry, vma, vmf->address);
>      if (folio)
>            page = folio_file_page(folio, swp_offset(entry));
> 
>      arch_swap_restore(entry, folio);
> }
> 
> entry points to the 3rd page, but folio points to the head page. so we
> can't use the entry parameter to restore the whole folio in
> arch_swap_restore()

Sorry, I don't think I explained myself very clearly. My issue was that
with your patch (and currently) we have the situation where
arch_swap_restore() can only restore a single page. But the function
takes a "struct folio *" argument.

Current mainline assumes that the folio is a single page, and with your
patch we now have a big comment explaining what's going on (bonus points
for that!) and pick out the correct page from the folio. What I'm
puzzled by is why the change was made in the first place to pass a
"struct folio *" - if we passed a "struct page *" that:

 a) It would be clear that the current API only allows a single page at
    a time.

 b) The correct page could be passed by the caller rather than
    arch_swap_restore() having to obtain the offset into the folio.

> then we have two choices in arch_swap_restore()
> 1. we get the 1st page's swap entry and restore all 16 tags in this large folio.
> 2. we restore the 3rd tag only by getting the right page in the folio
> 
> if we choose 1, in all 16 page faults of do_swap_page for the 16 unmapped
> PTEs, we will restore 16*16=256 tags. One pte will have one page fault
> since we don't restore 16 PTEs in do_swap_page().
> 
> if we choose 2, in all 16 pages fault of do_swap_page for the 16 unmapped
> PTEs, we will only restore 16 *1=16 tags.

So if we choose option 1 then we're changing the API of
arch_swap_restore() to actually restore the entire folio and it makes
sense to pass a "struct folio *" - and I'm happy with that. But AFAICT
that's not what your patch currently implements as it appears to be
doing option 2.

I'm quite happy to believe that the overhead of option 2 is small and
that might be the right solution, but at the moment we've got an API
which implies arch_swap_restore() should be operating on an entire folio.

Note that I don't have any particularly strong views on this - I've not
been following the folio work very closely, but I personally find it
confusing when a function takes a "struct folio *" but then operates on
only one page of it.

Steve

>>
>> It seems particularly broken in the case of unuse_pte() which calls
>> page_folio() to get the folio in the first place.
>>
>> Other than that it looks correct to me.
>>
>> Thanks,
>>
>> Steve
>>
>>> +             struct page *page = folio_file_page(folio, swp_offset(entry));
>>> +             mte_restore_tags(entry, page);
>>> +     }
>>> +}
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index fa0350b0812a..f83fb8d5241e 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -400,16 +400,4 @@ static inline int split_folio(struct folio *folio)
>>>       return split_folio_to_list(folio, NULL);
>>>  }
>>>
>>> -/*
>>> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
>>> - * limitations in the implementation like arm64 MTE can override this to
>>> - * false
>>> - */
>>> -#ifndef arch_thp_swp_supported
>>> -static inline bool arch_thp_swp_supported(void)
>>> -{
>>> -     return true;
>>> -}
>>> -#endif
>>> -
>>>  #endif /* _LINUX_HUGE_MM_H */
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index af7639c3b0a3..33ab4ddd91dd 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -897,7 +897,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>>>   * prototypes must be defined in the arch-specific asm/pgtable.h file.
>>>   */
>>>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
>>> -static inline int arch_prepare_to_swap(struct page *page)
>>> +static inline int arch_prepare_to_swap(struct folio *folio)
>>>  {
>>>       return 0;
>>>  }
>>> diff --git a/mm/page_io.c b/mm/page_io.c
>>> index cb559ae324c6..0fd832474c1d 100644
>>> --- a/mm/page_io.c
>>> +++ b/mm/page_io.c
>>> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>>        * Arch code may have to preserve more data than just the page
>>>        * contents, e.g. memory tags.
>>>        */
>>> -     ret = arch_prepare_to_swap(&folio->page);
>>> +     ret = arch_prepare_to_swap(folio);
>>>       if (ret) {
>>>               folio_mark_dirty(folio);
>>>               folio_unlock(folio);
>>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
>>> index 0bec1f705f8e..2325adbb1f19 100644
>>> --- a/mm/swap_slots.c
>>> +++ b/mm/swap_slots.c
>>> @@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>>       entry.val = 0;
>>>
>>>       if (folio_test_large(folio)) {
>>> -             if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
>>> +             if (IS_ENABLED(CONFIG_THP_SWAP))
>>>                       get_swap_pages(1, &entry, folio_nr_pages(folio));
>>>               goto out;
>>>       }
>>
> 
> Thanks
> Barry

