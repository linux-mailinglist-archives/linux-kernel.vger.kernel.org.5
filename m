Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8776EC21
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjHCOPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHCOPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:15:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3431F1BF6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:15:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E263A113E;
        Thu,  3 Aug 2023 07:16:13 -0700 (PDT)
Received: from [10.1.35.53] (C02Z41KALVDN.cambridge.arm.com [10.1.35.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2801C3F5A1;
        Thu,  3 Aug 2023 07:15:29 -0700 (PDT)
Message-ID: <bb871b52-526a-d4aa-5249-6105bc06aaba@arm.com>
Date:   Thu, 3 Aug 2023 15:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
 <4255e71a-63c9-b2f9-5e97-e46834f7837c@arm.com>
 <b54e7885-3e49-150f-cf8a-36a880e5dfc9@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b54e7885-3e49-150f-cf8a-36a880e5dfc9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 15:10, David Hildenbrand wrote:
>>>
>>> With this patch, you'll might suddenly have mapcount > refcount for a folio, or
>>> am I wrong?
>>
>> Yes you would. Does that break things?
>>
> 
> It is problematic whenever you want to check for additional page references that
> are not from mappings (i.e., GUP refs/pins or anything else)
> 
> One example lives in KSM code (!compound only):
> 
> page_mapcount(page) + 1 + swapped != page_count(page)
> 
> Another one in compaction code:
> 
> if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
> 
> And another one in khugepaged (is_refcount_suitable)
> 
> ... and in THP split can_split_folio() (although that can deal with false
> positives and false negatives).
> 
> 
> We want to avoid detecting "no other references" if there *are* other
> references. Detecting "there are other references" although there are not is
> usually better.
> 
> 
> Assume you have mapcount > refcount for some time due to concurrent unmapping,
> AND some unrelated reference. You would suddenly pass these checks (mapcount ==
> refcount) and might not detect other references.

OK. I'll rework with the 2 loop approach, assuming I can calculate the number of
free slots in the mmu_gather ahead of time.


> 
>>>
>>>> +
>>>> +    for (i = 0; i < nr_pages;) {
>>>> +        ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
>>>> +        tlb_remove_tlb_entry(tlb, pte, addr);
>>>> +        zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
>>>> +        full = __tlb_remove_page(tlb, page, 0);
>>>> +
>>>> +        if (unlikely(page_mapcount(page) < 1))
>>>> +            print_bad_pte(vma, addr, ptent, page);
>>>
>>> Can we avoid new users of page_mapcount() outside rmap code, please? :)
>>
>> Sure. This is just trying to replicate the same diagnstics that's done on the
>> non-batched path. I'm happy to remove it.
> 
> Spotted it afterwards in the existing code already, so you're effetively not
> adding new ones.
> 

