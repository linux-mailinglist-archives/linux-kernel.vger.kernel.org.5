Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180237747F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjHHTWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbjHHTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:22:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B7B144460
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:46:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8244D1516;
        Tue,  8 Aug 2023 02:37:49 -0700 (PDT)
Received: from [10.1.31.53] (C02Z41KALVDN.cambridge.arm.com [10.1.31.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC13F3F59C;
        Tue,  8 Aug 2023 02:37:04 -0700 (PDT)
Message-ID: <20469f02-d62d-d925-3536-d6a1f1099fda@arm.com>
Date:   Tue, 8 Aug 2023 10:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufbdbeFhpXw_w4z62=PwCjCa-yuvE6Brhpd3AOxiswa_2Q@mail.gmail.com>
 <433fb8de-f5c0-d150-ac7b-5d73e9958e02@arm.com>
 <CAOUHufZwyNrNbnpgTR=o5O8__QE4NdNG=LTgUoB26bVvDfgBkA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZwyNrNbnpgTR=o5O8__QE4NdNG=LTgUoB26bVvDfgBkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 00:21, Yu Zhao wrote:
> On Mon, Aug 7, 2023 at 1:07 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 07/08/2023 06:24, Yu Zhao wrote:
>>> On Wed, Jul 26, 2023 at 3:52 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>>> allocated in large folios of a determined order. All pages of the large
>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>> counting, rmap management lru list management) are also significantly
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>>> which defaults to disabled for now; The long term aim is for this to
>>>> defaut to enabled, but there are some risks around internal
>>>> fragmentation that need to be better understood first.
>>>>
>>>> When enabled, the folio order is determined as such: For a vma, process
>>>> or system that has explicitly disabled THP, we continue to allocate
>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>> fragmentation so we honour that request.
>>>>
>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>>> bigger). This allows for a performance boost without requiring any
>>>> explicit opt-in from the workload while limitting internal
>>>> fragmentation.
>>>>
>>>> If the preferred order can't be used (e.g. because the folio would
>>>> breach the bounds of the vma, or because ptes in the region are already
>>>> mapped) then we fall back to a suitable lower order; first
>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>
>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>> mechanism allows the architecture to optimize as required.
>>>>
>>>> Here we add the default implementation of arch_wants_pte_order(), used
>>>> when the architecture does not define it, which returns -1, implying
>>>> that the HW has no preference. In this case, mm will choose it's own
>>>> default order.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h |  13 ++++
>>>>  mm/Kconfig              |  10 +++
>>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>>>>  3 files changed, 172 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index 5063b482e34f..2a1d83775837 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>> + * to be at least order-2. Negative value implies that the HW has no preference
>>>> + * and mm will choose it's own default order.
>>>> + */
>>>> +static inline int arch_wants_pte_order(void)
>>>> +{
>>>> +       return -1;
>>>> +}
>>>> +#endif
>>>> +
>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>                                        unsigned long address,
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 09130434e30d..fa61ea160447 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>
>>>>  source "mm/damon/Kconfig"
>>>>
>>>> +config LARGE_ANON_FOLIO
>>>> +       bool "Allocate large folios for anonymous memory"
>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>> +       default n
>>>> +       help
>>>> +         Use large (bigger than order-0) folios to back anonymous memory where
>>>> +         possible, even for pte-mapped memory. This reduces the number of page
>>>> +         faults, as well as other per-page overheads to improve performance for
>>>> +         many workloads.
>>>> +
>>>>  endmenu
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 01f39e8144ef..64c3f242c49a 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>> +{
>>>> +       int i;
>>>> +
>>>> +       if (nr_pages == 1)
>>>> +               return vmf_pte_changed(vmf);
>>>> +
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>> +                       return true;
>>>> +       }
>>>> +
>>>> +       return false;
>>>> +}
>>>> +
>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>>> +
>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>> +{
>>>> +       int order;
>>>> +
>>>> +       /*
>>>> +        * If THP is explicitly disabled for either the vma, the process or the
>>>> +        * system, then this is very likely intended to limit internal
>>>> +        * fragmentation; in this case, don't attempt to allocate a large
>>>> +        * anonymous folio.
>>>> +        *
>>>> +        * Else, if the vma is eligible for thp, allocate a large folio of the
>>>> +        * size preferred by the arch. Or if the arch requested a very small
>>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>>> +        * which still meets the arch's requirements but means we still take
>>>> +        * advantage of SW optimizations (e.g. fewer page faults).
>>>> +        *
>>>> +        * Finally if thp is enabled but the vma isn't eligible, take the
>>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>> +        * This ensures workloads that have not explicitly opted-in take benefit
>>>> +        * while capping the potential for internal fragmentation.
>>>> +        */
>>>> +
>>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>> +           !hugepage_flags_enabled())
>>>> +               order = 0;
>>>> +       else {
>>>> +               order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>>> +
>>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>>> +                       order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>> +       }
>>>> +
>>>> +       return order;
>>>> +}
>>>> +
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
>>>
>>> Per the discussion, we need to check hugepage_vma_check() for
>>> correctness of VM LM. I'd just check it here and fall back to order 0
>>> if that helper returns false.
>>
>> I'm not sure if either you haven't noticed the logic in anon_folio_order()
>> above, or whether you are making this suggestion because you disagree with the
>> subtle difference in my logic?
> 
> The latter, or more generally the policy you described earlier.
> 
>> My logic is deliberately not calling hugepage_vma_check() because that would
>> return false for the thp=madvise,mmap=unhinted case, whereas the policy I'm
>> implementing wants to apply LAF in that case.
>>
>>
>> My intended policy:
>>
>>                 | never     | madvise   | always
>> ----------------|-----------|-----------|-----------
>> no hint         | S         | LAF>S     | THP>LAF>S
>> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
>> MADV_NOHUGEPAGE | S         | S         | S
>>
>>
>> What your suggestion would give:
>>
>>                 | never     | madvise   | always
>> ----------------|-----------|-----------|-----------
>> no hint         | S         | S         | THP>LAF>S
>> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
>> MADV_NOHUGEPAGE | S         | S         | S
> 
> This is not what I'm suggesting.
> 
> Let me reiterate [1]:
>   My impression is we only agreed on one thing: at the current stage, we
>   should respect things we absolutely have to. We didn't agree on what
>   "never" means ("never 2MB" or "never >4KB"), and we didn't touch on
>   how "always" should behave at all.
> 
> And [2]:
>   (Thanks to David, now I agree that) we have to interpret MADV_NOHUGEPAGE
>   as nothing >4KB.
> 
> My final take [3]:
>   I agree these points require more discussion. But I don't think we
>   need to conclude them now, unless they cause correctness issues like
>   ignoring MADV_NOHUGEPAGE would.

Thanks, I've read all of these comments previously, and appreciate the time you
have put into the feedback. I'm not sure I fully agree with your point that we
don't need to conclude on a policy now; I certainly don't think we need the
whole thing in place on day 1, but I do think that whatever we put in should
strive to be a strict subset of where we think we are going. For example, if we
put something in with one policy (i.e. "never" only means "never 2MB") then find
a problem and have to change that to be more conservative, are we risking perf
regressions for any LAF users that started using it on day 1?

> 
> But I should have been clear about the parameters to
> hugepage_vma_check(): enforce_sysfs=false.

So hugepage_vma_check(..., smaps=false, in_pf=true, enforce_sysfs=false) would
give us:

                | prctl/fw  | sysfs     | sysfs     | sysfs
                | disable   | never     | madvise   | always
----------------|-----------|-----------|-----------|-----------
no hint         | S         | LAF>S     | LAF>S     | THP>LAF>S
MADV_HUGEPAGE   | S         | LAF>S     | THP>LAF>S | THP>LAF>S
MADV_NOHUGEPAGE | S         | S         | S         | S

Where "prctl/fw disable" trumps the sysfs setting.

I can certainly see the benefit of this approach; it gives us a way to enable
LAF while disabling THP (thp=never). It doesn't give us a way to enable THP
without enabling LAF though (unless you recompile with LAF disabled). Does
anyone see a problem with this?



> 
> [1] https://lore.kernel.org/linux-mm/CAOUHufYQTcOdKU=1mPq-fdLV7a66sHx1=EJpPpMVogciCNKO9A@mail.gmail.com/
> [2] https://lore.kernel.org/linux-mm/CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc6t+ZOphwgw7tw@mail.gmail.com/
> [3] https://lore.kernel.org/linux-mm/CAOUHufYQTcOdKU=1mPq-fdLV7a66sHx1=EJpPpMVogciCNKO9A@mail.gmail.com/

