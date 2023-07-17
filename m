Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5346D75652C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGQNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjGQNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:36:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ECE8E76
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:36:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE3EC15;
        Mon, 17 Jul 2023 06:36:50 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99A93F67D;
        Mon, 17 Jul 2023 06:36:04 -0700 (PDT)
Message-ID: <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com>
Date:   Mon, 17 Jul 2023 14:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com>
 <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com>
 <CAOUHufaDfJwF_-zb6zV5COG-KaaGcSyrNmbaEzaWz2UjcGGgHQ@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufaDfJwF_-zb6zV5COG-KaaGcSyrNmbaEzaWz2UjcGGgHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>>> +{
>>>> +       int i;
>>>> +       gfp_t gfp;
>>>> +       pte_t *pte;
>>>> +       unsigned long addr;
>>>> +       struct vm_area_struct *vma = vmf->vma;
>>>> +       int prefer = anon_folio_order(vma);
>>>> +       int orders[] = {
>>>> +               prefer,
>>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
>>>> +               0,
>>>> +       };
>>>> +
>>>> +       *folio = NULL;
>>>> +
>>>> +       if (vmf_orig_pte_uffd_wp(vmf))
>>>> +               goto fallback;
>>>> +
>>>> +       for (i = 0; orders[i]; i++) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>> +               if (addr >= vma->vm_start &&
>>>> +                   addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
>>>> +                       break;
>>>> +       }
>>>> +
>>>> +       if (!orders[i])
>>>> +               goto fallback;
>>>> +
>>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>> +       if (!pte)
>>>> +               return -EAGAIN;
>>>
>>> It would be a bug if this happens. So probably -EINVAL?
>>
>> Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1 makes it
>> possible for pte_offset_map() to fail (if I understood correctly) and we have to
>> handle this. The intent is that we will return from the fault without making any
>> change, then we will refault and try again.
> 
> Thanks for checking that -- it's very relevant. One detail is that
> that series doesn't affect anon. IOW, collapsing PTEs into a PMD can't
> happen while we are holding mmap_lock for read here, and therefore,
> the race that could cause pte_offset_map() on shmem/file PTEs to fail
> doesn't apply here.

But Hugh's patches have changed do_anonymous_page() to handle failure from
pte_offset_map_lock(). So I was just following that pattern. If this really
can't happen, then I'd rather WARN/BUG on it, and simplify alloc_anon_folio()'s
prototype to just return a `struct folio *` (and if it's null that means ENOMEM).

Hugh, perhaps you can comment?

As an aside, it was my understanding from LWN, that we are now using a per-VMA
lock so presumably we don't hold mmap_lock for read here? Or perhaps that only
applies to file-backed memory?

> 
> +Hugh Dickins for further consultation if you need it.
> 
>>>> +
>>>> +       for (; orders[i]; i++) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>> +               vmf->pte = pte + pte_index(addr);
>>>> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
>>>> +                       break;
>>>> +       }
>>>> +
>>>> +       vmf->pte = NULL;
>>>> +       pte_unmap(pte);
>>>> +
>>>> +       gfp = vma_thp_gfp_mask(vma);
>>>> +
>>>> +       for (; orders[i]; i++) {
>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>> +               *folio = vma_alloc_folio(gfp, orders[i], vma, addr, true);
>>>> +               if (*folio) {
>>>> +                       clear_huge_page(&(*folio)->page, addr, 1 << orders[i]);
>>>> +                       return 0;
>>>> +               }
>>>> +       }
>>>> +
>>>> +fallback:
>>>> +       *folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>>>> +       return *folio ? 0 : -ENOMEM;
>>>> +}
>>>> +#else
>>>> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>>
>>> Drop "inline" (it doesn't do anything in .c).
>>
>> There are 38 instances of inline in memory.c alone, so looks like a well used
>> convention, even if the compiler may choose to ignore. Perhaps you can educate
>> me; what's the benefit of dropping it?
> 
> I'll let Willy and Andrew educate both of us :)
> 
> +Matthew Wilcox +Andrew Morton please. Thank you.
> 
>>> The rest looks good to me.
>>
>> Great - just incase it wasn't obvious, I decided not to overwrite vmf->address
>> with the aligned version, as you suggested
> 
> Yes, I've noticed. Not overwriting has its own merits for sure.
> 
>> for 2 reasons; 1) address is const
>> in the struct, so would have had to change that. 2) there is a uffd path that
>> can be taken after the vmf->address fixup would have occured and the path
>> consumes that member, so it would have had to be un-fixed-up making it more
>> messy than the way I opted for.
>>
>> Thanks for the quick review as always!

