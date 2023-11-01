Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8248C7DE217
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjKAN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjKAN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:56:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABCC010F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:56:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1622F4;
        Wed,  1 Nov 2023 06:57:18 -0700 (PDT)
Received: from [10.1.34.131] (XHFQ2J9959.cambridge.arm.com [10.1.34.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF9EA3F64C;
        Wed,  1 Nov 2023 06:56:33 -0700 (PDT)
Message-ID: <a6fa0847-a950-4044-972c-e5dc8cbc7922@arm.com>
Date:   Wed, 1 Nov 2023 13:56:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] mm: thp: Extend THP to allocate anonymous large
 folios
Content-Language: en-GB
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-6-ryan.roberts@arm.com>
 <8a72da61-b2ef-48ad-ae59-0bae7ac2ce10@nvidia.com>
 <5993c198-0d27-46c3-b757-3a02c2aacfc9@arm.com>
 <d07c45bb-4eba-484c-bba1-b586136f8cdb@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d07c45bb-4eba-484c-bba1-b586136f8cdb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 23:25, John Hubbard wrote:
> On 10/30/23 04:43, Ryan Roberts wrote:
>> On 28/10/2023 00:04, John Hubbard wrote:
>>> On 9/29/23 04:44, Ryan Roberts wrote:
> ...
>>>>    +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    if (nr_pages == 1)
>>>> +        return vmf_pte_changed(vmf);
>>>> +
>>>> +    for (i = 0; i < nr_pages; i++) {
>>>> +        if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>> +            return true;
>>>
>>> This seems like something different than the function name implies.
>>> It's really confusing: for a single page case, return true if the
>>> pte in the page tables has changed, yes that is very clear.
>>>
>>> But then for multiple page cases, which is really the main
>>> focus here--for that, claim that the range has changed if any
>>> pte is present (!pte_none). Can you please help me understand
>>> what this means?
>>
>> Yes I understand your confusion. Although I'm confident that the code is
>> correct, its a bad name - I'll make the excuse that this has evolved through
>> rebasing to cope with additions to UFFD. Perhaps something like
>> vmf_is_large_folio_suitable() is a better name.
>>
>> It used to be that we would only take the do_anonymous_page() path if the pte
>> was none; i.e. this is the first time we are faulting on an address covered by
>> an anon VMA and we need to allocate some memory. But more recently we also end
>> up here if the pte is a uffd_wp marker. So for a single pte, instead of checking
>> none, we can check if the pte has changed from our original check (where we
>> determined it was a uffd_wp marker or none). But for multiple ptes, we don't
>> have storage to store all the original ptes from the first check.
>>
>> Fortunately, if uffd is in use for a vma, then we don't want to use a large
>> folio anyway (this would break uffd semantics because we would no longer get a
>> fault for every page). So we only care about the "same but not none" case for
>> nr_pages=1.
>>
>> Would changing the name to vmf_is_large_folio_suitable() help here?
> 
> Yes it would! And adding in a sentence or two from above about the uffd, as
> a function-level comment might be just the right of demystification for
> the code.

Actually I don't think the name I proposed it quite right either - this gets
called for small folios too.

I think its cleaner to change the name to vmf_pte_range_none() and strip out the
nr_pages==1 case. The checking-for-none part is required by alloc_anon_folio()
and needs to be safe without holding the PTL. vmf_pte_changed() is not safe in
without the lock. So I've just hoisted the nr_pages==1 case directly into
do_anonymous_page(). Shout if you think we can do better:


diff --git a/mm/memory.c b/mm/memory.c
index 569c828b1cdc..b48e4de1bf20 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4117,19 +4117,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        return ret;
 }

-static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
+static bool pte_range_none(pte_t *pte, int nr_pages)
 {
        int i;

-       if (nr_pages == 1)
-               return vmf_pte_changed(vmf);
-
        for (i = 0; i < nr_pages; i++) {
-               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
-                       return true;
+               if (!pte_none(ptep_get_lockless(pte + i)))
+                       return false;
        }

-       return false;
+       return true;
 }

 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -4170,7 +4167,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
        while (orders) {
                addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
                vmf->pte = pte + pte_index(addr);
-               if (!vmf_pte_range_changed(vmf, 1 << order))
+               if (pte_range_none(vmf->pte, 1 << order))
                        break;
                order = next_order(&orders, order);
        }
@@ -4280,7 +4277,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
        if (!vmf->pte)
                goto release;
-       if (vmf_pte_range_changed(vmf, nr_pages)) {
+       if ((nr_pages == 1 && vmf_pte_changed(vmf)) ||
+           (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
                for (i = 0; i < nr_pages; i++)
                        update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
                goto release;

