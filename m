Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F127F9D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjK0Ke7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjK0Ke5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:34:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0482E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:35:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E8F2F4;
        Mon, 27 Nov 2023 02:35:51 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF31F3F73F;
        Mon, 27 Nov 2023 02:35:00 -0800 (PST)
Message-ID: <48417f46-d01c-48d1-b53e-d9458a1527fe@arm.com>
Date:   Mon, 27 Nov 2023 10:34:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-3-ryan.roberts@arm.com>
 <f232c69e-92f7-4e34-8dae-2495b00c3d50@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f232c69e-92f7-4e34-8dae-2495b00c3d50@redhat.com>
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

On 24/11/2023 17:40, David Hildenbrand wrote:
> On 22.11.23 17:29, Ryan Roberts wrote:
>> In preparation for supporting anonymous small-sized THP, improve
>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>> passed to it. In this case, all contained pages are accounted using the
>> order-0 folio (or base page) scheme.
>>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   mm/rmap.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 49e4d86a4f70..b086dc957b0c 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1305,32 +1305,44 @@ void page_add_anon_rmap(struct page *page, struct
>> vm_area_struct *vma,
>>    * This means the inc-and-test can be bypassed.
>>    * The folio does not have to be locked.
>>    *
>> - * If the folio is large, it is accounted as a THP.  As the folio
>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>    * is new, it's assumed to be mapped exclusively by a single process.
>>    */
>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>           unsigned long address)
>>   {
>> -    int nr;
>> +    int nr = folio_nr_pages(folio);
>>
>> -    VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>> +    VM_BUG_ON_VMA(address < vma->vm_start ||
>> +            address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>       __folio_set_swapbacked(folio);
>> +    __folio_set_anon(folio, vma, address, true);
> 
> Likely the changed order doesn't matter.

Yes; the reason I moved __folio_set_anon() up here is because
SetPageAnonExclusive() asserts that the page is anon, and SetPageAnonExclusive()
has to be called differently for the 3 cases. I couldn't see any reason why it
wouldn't be safe to call __folio_set_anon() before setting up the mapcounts.

> 
> LGTM
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks!

