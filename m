Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB37F9E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjK0Lad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjK0La3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:30:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E772191
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:30:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 983052F4;
        Mon, 27 Nov 2023 03:31:22 -0800 (PST)
Received: from [10.57.73.191] (unknown [10.57.73.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3885B3F73F;
        Mon, 27 Nov 2023 03:30:32 -0800 (PST)
Message-ID: <45d0aa4c-e438-476e-a0b2-a129ba1975b4@arm.com>
Date:   Mon, 27 Nov 2023 11:30:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, david@redhat.com, fengwei.yin@intel.com,
        hughd@google.com, itaru.kitayama@gmail.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mcgrof@kernel.org, rientjes@google.com,
        shy828301@gmail.com, vbabka@suse.cz, wangkefeng.wang@huawei.com,
        willy@infradead.org, ying.huang@intel.com, yuzhao@google.com,
        ziy@nvidia.com
References: <20231122162950.3854897-3-ryan.roberts@arm.com>
 <20231127043644.8072-1-v-songbaohua@oppo.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231127043644.8072-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 04:36, Barry Song wrote:
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
>> +	__folio_set_anon(folio, vma, address, true);
>>
>> -	if (likely(!folio_test_pmd_mappable(folio))) {
>> +	if (likely(!folio_test_large(folio))) {
>>  		/* increment count (starts at -1) */
>>  		atomic_set(&folio->_mapcount, 0);
>> -		nr = 1;
>> +		SetPageAnonExclusive(&folio->page);
>> +	} else if (!folio_test_pmd_mappable(folio)) {
>> +		int i;
>> +
>> +		for (i = 0; i < nr; i++) {
>> +			struct page *page = folio_page(folio, i);
>> +
>> +			/* increment count (starts at -1) */
>> +			atomic_set(&page->_mapcount, 0);
>> +			SetPageAnonExclusive(page);
> 
> Hi Ryan,
> 
> we are doing an entire mapping, right? what is the reason to
> increase mapcount for each subpage? shouldn't we only increase
> mapcount of subpage in either split or doublemap case?
> 
> in page_add_anon_rmap(), are we also increasing mapcount of
> each subpage for fork() case where the entire large folio
> is inheritted by child processes?

I think this is all answered by the conversation we just had in the context of
the contpte series? Let me know if you still have concerns.

> 
>> +		}
>> +
>> +		atomic_set(&folio->_nr_pages_mapped, nr);
>>  	} else {
>>  		/* increment count (starts at -1) */
>>  		atomic_set(&folio->_entire_mapcount, 0);
>>  		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
>> -		nr = folio_nr_pages(folio);
>> +		SetPageAnonExclusive(&folio->page);
>>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>>  	}
>>
>>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>> -	__folio_set_anon(folio, vma, address, true);
>> -	SetPageAnonExclusive(&folio->page);
>>  }
> 
> Thanks
> Barry
> 

