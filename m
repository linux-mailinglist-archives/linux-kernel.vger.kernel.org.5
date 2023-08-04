Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5385576FC00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjHDI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjHDI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:28:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F00FE4C02
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:27:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF072F4;
        Fri,  4 Aug 2023 01:28:36 -0700 (PDT)
Received: from [10.57.77.247] (unknown [10.57.77.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1E63F6C4;
        Fri,  4 Aug 2023 01:27:50 -0700 (PDT)
Message-ID: <5e595904-3dca-0e15-0769-7ed10975fd0d@arm.com>
Date:   Fri, 4 Aug 2023 09:27:49 +0100
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
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 00:50, Yu Zhao wrote:
> On Thu, Aug 3, 2023 at 6:43 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> + Kirill
>>
>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>> allocated in large folios of a determined order. All pages of the large
>>> folio are pte-mapped during the same page fault, significantly reducing
>>> the number of page faults. The number of per-page operations (e.g. ref
>>> counting, rmap management lru list management) are also significantly
>>> reduced since those ops now become per-folio.
>>>
>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>> which defaults to disabled for now; The long term aim is for this to
>>> defaut to enabled, but there are some risks around internal
>>> fragmentation that need to be better understood first.
>>>
>>> When enabled, the folio order is determined as such: For a vma, process
>>> or system that has explicitly disabled THP, we continue to allocate
>>> order-0. THP is most likely disabled to avoid any possible internal
>>> fragmentation so we honour that request.
>>>
>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
>>> bigger). This allows for a performance boost without requiring any
>>> explicit opt-in from the workload while limitting internal
>>> fragmentation.
>>>
>>> If the preferred order can't be used (e.g. because the folio would
>>> breach the bounds of the vma, or because ptes in the region are already
>>> mapped) then we fall back to a suitable lower order; first
>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>
>>
>> ...
>>
>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
>>> +
>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>> +{
>>> +     int order;
>>> +
>>> +     /*
>>> +      * If THP is explicitly disabled for either the vma, the process or the
>>> +      * system, then this is very likely intended to limit internal
>>> +      * fragmentation; in this case, don't attempt to allocate a large
>>> +      * anonymous folio.
>>> +      *
>>> +      * Else, if the vma is eligible for thp, allocate a large folio of the
>>> +      * size preferred by the arch. Or if the arch requested a very small
>>> +      * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
>>> +      * which still meets the arch's requirements but means we still take
>>> +      * advantage of SW optimizations (e.g. fewer page faults).
>>> +      *
>>> +      * Finally if thp is enabled but the vma isn't eligible, take the
>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
>>> +      * This ensures workloads that have not explicitly opted-in take benefit
>>> +      * while capping the potential for internal fragmentation.
>>> +      */
>>> +
>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>> +         !hugepage_flags_enabled())
>>> +             order = 0;
>>> +     else {
>>> +             order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>> +
>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>> +                     order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>> +     }
>>> +
>>> +     return order;
>>> +}
>>
>>
>> Hi All,
>>
>> I'm writing up the conclusions that we arrived at during discussion in the THP
>> meeting yesterday, regarding linkage with exiting THP ABIs. It would be great if
>> I can get explicit "agree" or disagree + rationale from at least David, Yu and
>> Kirill.
>>
>> In summary; I think we are converging on the approach that is already coded, but
>> I'd like confirmation.
>>
>>
>>
>> The THP situation today
>> -----------------------
>>
>>  - At system level: THP can be set to "never", "madvise" or "always"
>>  - At process level: THP can be "never" or "defer to system setting"
>>  - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>
>> That gives us this table to describe how a page fault is handled, according to
>> process state (columns) and vma flags (rows):
>>
>>                 | never     | madvise   | always
>> ----------------|-----------|-----------|-----------
>> no hint         | S         | S         | THP>S
>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>> MADV_NOHUGEPAGE | S         | S         | S
>>
>> Legend:
>> S       allocate single page (PTE-mapped)
>> LAF     allocate lage anon folio (PTE-mapped)
>> THP     allocate THP-sized folio (PMD-mapped)
>>>       fallback (usually because vma size/alignment insufficient for folio)
>>
>>
>>
>> Principles for Large Anon Folios (LAF)
>> --------------------------------------
>>
>> David tells us there are use cases today (e.g. qemu live migration) which use
>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly faulted"
>> and these use cases will break (i.e. functionally incorrect) if this request is
>> not honoured.
> 
> I don't remember David saying this. I think he was referring to UFFD,
> not MADV_NOHUGEPAGE, when discussing what we need to absolutely
> respect.

My understanding was that MADV_NOHUGEPAGE was being applied to regions *before*
UFFD was being registered, and the app relied on MADV_NOHUGEPAGE to not back any
unfaulted pages. It's not completely clear to me how not honouring
MADV_NOHUGEPAGE would break things though. David?

