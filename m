Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C0275795A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGRKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGRKgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:36:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BAD1B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:36:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D622F4;
        Tue, 18 Jul 2023 03:36:56 -0700 (PDT)
Received: from [10.1.34.52] (C02Z41KALVDN.cambridge.arm.com [10.1.34.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F153A3F67D;
        Tue, 18 Jul 2023 03:36:10 -0700 (PDT)
Message-ID: <a7289b0f-466e-1eaa-dae6-3a4e55b46528@arm.com>
Date:   Tue, 18 Jul 2023 11:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Hugh Dickins <hughd@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 <5df787a0-8e69-2472-cdd6-f96a3f7dfaaf@arm.com>
 <8bdfd8d8-5662-4615-86dc-d60259bd16d@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8bdfd8d8-5662-4615-86dc-d60259bd16d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 00:37, Hugh Dickins wrote:
> On Mon, 17 Jul 2023, Ryan Roberts wrote:
> 
>>>>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +       gfp_t gfp;
>>>>>> +       pte_t *pte;
>>>>>> +       unsigned long addr;
>>>>>> +       struct vm_area_struct *vma = vmf->vma;
>>>>>> +       int prefer = anon_folio_order(vma);
>>>>>> +       int orders[] = {
>>>>>> +               prefer,
>>>>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDER : 0,
>>>>>> +               0,
>>>>>> +       };
>>>>>> +
>>>>>> +       *folio = NULL;
>>>>>> +
>>>>>> +       if (vmf_orig_pte_uffd_wp(vmf))
>>>>>> +               goto fallback;
>>>>>> +
>>>>>> +       for (i = 0; orders[i]; i++) {
>>>>>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i]);
>>>>>> +               if (addr >= vma->vm_start &&
>>>>>> +                   addr + (PAGE_SIZE << orders[i]) <= vma->vm_end)
>>>>>> +                       break;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (!orders[i])
>>>>>> +               goto fallback;
>>>>>> +
>>>>>> +       pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
>>>>>> +       if (!pte)
>>>>>> +               return -EAGAIN;
>>>>>
>>>>> It would be a bug if this happens. So probably -EINVAL?
>>>>
>>>> Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1 makes it
>>>> possible for pte_offset_map() to fail (if I understood correctly) and we have to
>>>> handle this. The intent is that we will return from the fault without making any
>>>> change, then we will refault and try again.
>>>
>>> Thanks for checking that -- it's very relevant. One detail is that
>>> that series doesn't affect anon. IOW, collapsing PTEs into a PMD can't
>>> happen while we are holding mmap_lock for read here, and therefore,
>>> the race that could cause pte_offset_map() on shmem/file PTEs to fail
>>> doesn't apply here.
>>
>> But Hugh's patches have changed do_anonymous_page() to handle failure from
>> pte_offset_map_lock(). So I was just following that pattern. If this really
>> can't happen, then I'd rather WARN/BUG on it, and simplify alloc_anon_folio()'s
>> prototype to just return a `struct folio *` (and if it's null that means ENOMEM).
>>
>> Hugh, perhaps you can comment?
> 
> I agree with your use of -EAGAIN there: I find it better to allow for the
> possibility, than to go to great effort persuading that it's impossible;
> especially because what's possible tomorrow may differ from today.
> 
> And notice that, before my changes, there used to be a pmd_trans_unstable()
> check above, implying that it is possible for it to fail (for more reasons
> than corruption causing pmd_bad()) - one scenario would be that the
> pte_alloc() above succeeded *because* someone else had managed to insert
> a huge pmd there already (maybe we have MMF_DISABLE_THP but they did not).
> 
> But I see from later mail that Yu Zhao now agrees with your -EAGAIN too,
> so we are all on the same folio.

Thanks for the explanation. I think we are all now agreed that the error case
needs handling and -EAGAIN is the correct code.

> 
> Hugh
> 
> p.s. while giving opinions, I'm one of those against using "THP" for
> large but not pmd-mappable folios; and was glad to see Matthew arguing
> the same way when considering THP_SWPOUT in another thread today.

Honestly, I don't have an opinion either way on this (probably because I don't
have the full context and history of THP like many of you do). So given there is
a fair bit of opposition to FLEXIBLE_THP, I'll change it back to
LARGE_ANON_FOLIO (and move it out of the THP sub-menu) in the next revision.

