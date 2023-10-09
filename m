Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE67BDA38
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbjJILpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjJILpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:45:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188A79E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:45:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B14E1FB;
        Mon,  9 Oct 2023 04:46:29 -0700 (PDT)
Received: from [10.57.66.97] (unknown [10.57.66.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 205683F762;
        Mon,  9 Oct 2023 04:45:46 -0700 (PDT)
Message-ID: <25d1cdee-3da8-4728-aa0d-dc07eb28ea95@arm.com>
Date:   Mon, 9 Oct 2023 12:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] mm: thp: Add "recommend" option for anon_orders
Content-Language: en-GB
To:     Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-7-ryan.roberts@arm.com>
 <2f64809e-0d0d-cc61-71ac-8d9b072efc3a@redhat.com>
 <CAOUHufb=qurWDFaX2TPQrsmUpEz+VRwm=SxivYuuDiJ4D-f0+g@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufb=qurWDFaX2TPQrsmUpEz+VRwm=SxivYuuDiJ4D-f0+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 23:28, Yu Zhao wrote:
> On Fri, Oct 6, 2023 at 2:08 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 29.09.23 13:44, Ryan Roberts wrote:
>>> In addition to passing a bitfield of folio orders to enable for THP,
>>> allow the string "recommend" to be written, which has the effect of
>>> causing the system to enable the orders preferred by the architecture
>>> and by the mm. The user can see what these orders are by subsequently
>>> reading back the file.
>>>
>>> Note that these recommended orders are expected to be static for a given
>>> boot of the system, and so the keyword "auto" was deliberately not used,
>>> as I want to reserve it for a possible future use where the "best" order
>>> is chosen more dynamically at runtime.
>>>
>>> Recommended orders are determined as follows:
>>>    - PMD_ORDER: The traditional THP size
>>>    - arch_wants_pte_order() if implemented by the arch
>>>    - PAGE_ALLOC_COSTLY_ORDER: The largest order kept on per-cpu free list
>>>
>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>> set of ptes map physically contigious, naturally aligned memory, so this
>>> mechanism allows the architecture to optimize as required.
>>>
>>> Here we add the default implementation of arch_wants_pte_order(), used
>>> when the architecture does not define it, which returns -1, implying
>>> that the HW has no preference.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>   Documentation/admin-guide/mm/transhuge.rst |  4 ++++
>>>   include/linux/pgtable.h                    | 13 +++++++++++++
>>>   mm/huge_memory.c                           | 14 +++++++++++---
>>>   3 files changed, 28 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>> index 732c3b2f4ba8..d6363d4efa3a 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -187,6 +187,10 @@ pages (=16K if the page size is 4K). The example above enables order-9
>>>   By enabling multiple orders, allocation of each order will be
>>>   attempted, highest to lowest, until a successful allocation is made.
>>>   If the PMD-order is unset, then no PMD-sized THPs will be allocated.
>>> +It is also possible to enable the recommended set of orders, which
>>> +will be optimized for the architecture and mm::
>>> +
>>> +     echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
>>>
>>>   The kernel will ignore any orders that it does not support so read the
>>>   file back to determine which orders are enabled::
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index af7639c3b0a3..0e110ce57cc3 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -393,6 +393,19 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
>>>   }
>>>   #endif
>>>
>>> +#ifndef arch_wants_pte_order
>>> +/*
>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>> + * PMD_ORDER) and must not be order-1 since THP requires large folios to be at
>>> + * least order-2. Negative value implies that the HW has no preference and mm
>>> + * will choose it's own default order.
>>> + */
>>> +static inline int arch_wants_pte_order(void)
>>> +{
>>> +     return -1;
>>> +}
>>> +#endif
>>> +
>>>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>                                      unsigned long address,
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index bcecce769017..e2e2d3906a21 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -464,10 +464,18 @@ static ssize_t anon_orders_store(struct kobject *kobj,
>>>       int err;
>>>       int ret = count;
>>>       unsigned int orders;
>>> +     int arch;
>>>
>>> -     err = kstrtouint(buf, 0, &orders);
>>> -     if (err)
>>> -             ret = -EINVAL;
>>> +     if (sysfs_streq(buf, "recommend")) {
>>> +             arch = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>> +             orders = BIT(arch);
>>> +             orders |= BIT(PAGE_ALLOC_COSTLY_ORDER);
>>> +             orders |= BIT(PMD_ORDER);
>>> +     } else {
>>> +             err = kstrtouint(buf, 0, &orders);
>>> +             if (err)
>>> +                     ret = -EINVAL;
>>> +     }
>>>
>>>       if (ret > 0) {
>>>               orders &= THP_ORDERS_ALL_ANON;
>>
>> :/ don't really like that. Regarding my proposal, one could have
>> something like that in an "auto" setting for the "enabled" value, or a
>> "recommended" setting [not sure].
> 
> Me either.
> 
> Again this is something I call random --  we only discussed "auto",
> and yes, the commit message above explained why "recommended" here but
> it has never surfaced in previous discussions, has it?

The context in which we discussed "auto" was for a future aspiration to
automatically determine the order that should be used for a given allocation to
balance perf vs internal fragmentation.

The case we are talking about here is completely different; I had a pre-existing
feature from previous versions of the series, which would allow the arch to
specify its preferred order (originally proposed by Yu, IIRC). In moving the
allocation size decision to user space, I felt that we still needed a mechanism
whereby the arch could express its preference. And "recommend" is what I came up
with.

All of the friction we are currently having is around this feature, I think?
Certainly all the links you provided in the other thread all point to
conversations skirting around it. How about I just drop it for this initial
patch set? Just let user space decide what sizes it wants (per David's interface
proposal)? I can see I'm trying to get a square peg into a round hole.

> 
> If so, this reinforces what I said here [1].
> 
> [1] https://lore.kernel.org/mm-commits/CAOUHufYEKx5_zxRJkeqrmnStFjR+pVQdpZ40ATSTaxLA_iRPGw@mail.gmail.com/

