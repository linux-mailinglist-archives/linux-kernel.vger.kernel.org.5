Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42677B35E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjI2Oj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjI2Ojz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:39:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00BE31B8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:39:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A631FB;
        Fri, 29 Sep 2023 07:40:30 -0700 (PDT)
Received: from [10.57.66.194] (unknown [10.57.66.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD23F3F5A1;
        Fri, 29 Sep 2023 07:39:49 -0700 (PDT)
Message-ID: <188646a6-c854-4fbe-96ff-ddf3ffc5ec77@arm.com>
Date:   Fri, 29 Sep 2023 15:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-GB
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-3-ryan.roberts@arm.com>
 <20230929134524.wwyykrxfikhle54k@box.shutemov.name>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230929134524.wwyykrxfikhle54k@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 14:45, Kirill A. Shutemov wrote:
> On Fri, Sep 29, 2023 at 12:44:13PM +0100, Ryan Roberts wrote:
>> In preparation for anonymous large folio support, improve
>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>> passed to it. In this case, all contained pages are accounted using the
>> order-0 folio (or base page) scheme.
>>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/rmap.c | 27 ++++++++++++++++++++-------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 8600bd029acf..106149690366 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1266,31 +1266,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>   * This means the inc-and-test can be bypassed.
>>   * The folio does not have to be locked.
>>   *
>> - * If the folio is large, it is accounted as a THP.  As the folio
>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>   * is new, it's assumed to be mapped exclusively by a single process.
>>   */
>>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>  		unsigned long address)
>>  {
>> -	int nr;
>> +	int nr = folio_nr_pages(folio);
>>  
>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>  	__folio_set_swapbacked(folio);
>>  
>> -	if (likely(!folio_test_pmd_mappable(folio))) {
>> +	if (likely(!folio_test_large(folio))) {
>>  		/* increment count (starts at -1) */
>>  		atomic_set(&folio->_mapcount, 0);
>> -		nr = 1;
>> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>> +	} else if (!folio_test_pmd_mappable(folio)) {
>> +		int i;
>> +
>> +		for (i = 0; i < nr; i++) {
>> +			struct page *page = folio_page(folio, i);
>> +
>> +			/* increment count (starts at -1) */
>> +			atomic_set(&page->_mapcount, 0);
>> +			__page_set_anon_rmap(folio, page, vma,
>> +					address + (i << PAGE_SHIFT), 1);
>> +		}
>> +
>> +		atomic_set(&folio->_nr_pages_mapped, nr);
> 
> This code should work for !folio_test_large() case too, no?

Not quite; for !folio_test_large() we don't set _nr_pages_mapped - that's a
compound-only field in the second struct page. So I could make most of this
common but would still have a conditional around that last line, and at that
point I thought it was better to split it the way I've done it to avoid the loop
overhead for the !large case.

> 
>>  	} else {
>>  		/* increment count (starts at -1) */
>>  		atomic_set(&folio->_entire_mapcount, 0);
>>  		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
>> -		nr = folio_nr_pages(folio);
>> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>>  	}
>>  
>>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>> -	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>  }
>>  
>>  /**
>> -- 
>> 2.25.1
>>
> 

