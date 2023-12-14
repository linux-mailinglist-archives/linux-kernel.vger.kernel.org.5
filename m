Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA0812DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443813AbjLNKzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443880AbjLNKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:54:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE2FD10E6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:54:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32EE8C15;
        Thu, 14 Dec 2023 02:55:09 -0800 (PST)
Received: from [10.1.38.142] (XHFQ2J9959.cambridge.arm.com [10.1.38.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C091F3F738;
        Thu, 14 Dec 2023 02:54:20 -0800 (PST)
Message-ID: <43a8bfff-f939-4f2d-a8cd-97306d5e44c9@arm.com>
Date:   Thu, 14 Dec 2023 10:54:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
Content-Language: en-GB
To:     Dan Carpenter <dan.carpenter@linaro.org>
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-5-ryan.roberts@arm.com>
 <cb1fe352-ca47-4c3b-ab51-ecf51a83ce50@moroto.mountain>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cb1fe352-ca47-4c3b-ab51-ecf51a83ce50@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2023 07:21, Dan Carpenter wrote:
> On Thu, Dec 07, 2023 at 04:12:05PM +0000, Ryan Roberts wrote:
>> @@ -4176,10 +4260,15 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>  	/* Allocate our own private page. */
>>  	if (unlikely(anon_vma_prepare(vma)))
>>  		goto oom;
>> -	folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>> +	folio = alloc_anon_folio(vmf);
>> +	if (IS_ERR(folio))
>> +		return 0;
>>  	if (!folio)
>>  		goto oom;
> 
> Returning zero is weird.  I think it should be a vm_fault_t code.

It's the same pattern that the existing code a little further down this function
already implements:

	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
	if (!vmf->pte)
		goto release;

If we fail to map/lock the pte (due to a race), then we return 0 to allow user
space to rerun the faulting instruction and cause the fault to happen again. The
above code ends up calling "return ret;" and ret is 0.

> 
> This mixing of error pointers and NULL is going to cause problems.
> Normally when we have a mix of error pointers and NULL then the NULL is
> not an error but instead means that the feature has been deliberately
> turned off.  I'm unable to figure out what the meaning is here.

There are 3 conditions that the function can return:

 - folio successfully allocated
 - folio failed to be allocated due to OOM
 - fault needs to be tried again due to losing race

Previously only the first 2 conditions were possible and they were indicated by
NULL/not-NULL. The new 3rd condition is only possible when THP is compile-time
enabled. So it keeps the logic simpler to keep the NULL/not-NULL distinction for
the first 2, and use the error code for the final one.

There are IS_ERR() and IS_ERR_OR_NULL() variants so I assume a pattern where you
can have pointer, error or NULL is somewhat common already?

Thanks,
Ryan

> 
> It should return one or the other, or if it's a mix then add a giant
> comment explaining what they mean.
> 
> regards,
> dan carpenter
> 
>>  
>> +	nr_pages = folio_nr_pages(folio);
>> +	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
>> +
>>  	if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>>  		goto oom_free_page;
>>  	folio_throttle_swaprate(folio, GFP_KERNEL);
> 

