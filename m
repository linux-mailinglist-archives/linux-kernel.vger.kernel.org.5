Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC89178DF51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbjH3TXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbjH3Pcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:32:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD71FB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:32:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9280E2F4;
        Wed, 30 Aug 2023 08:33:07 -0700 (PDT)
Received: from [10.57.64.173] (unknown [10.57.64.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 896133F64C;
        Wed, 30 Aug 2023 08:32:25 -0700 (PDT)
Message-ID: <ba05ec7a-e49c-4dbb-abc6-1662a7f5ff30@arm.com>
Date:   Wed, 30 Aug 2023 16:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-6-ryan.roberts@arm.com>
 <ZO9bGbsrveOIyeAA@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZO9bGbsrveOIyeAA@casper.infradead.org>
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

On 30/08/2023 16:07, Matthew Wilcox wrote:
> On Wed, Aug 30, 2023 at 10:50:11AM +0100, Ryan Roberts wrote:
>> +++ b/include/asm-generic/tlb.h
>> @@ -246,11 +246,11 @@ struct mmu_gather_batch {
>>  	struct mmu_gather_batch	*next;
>>  	unsigned int		nr;
>>  	unsigned int		max;
>> -	struct page		*pages[];
>> +	struct pfn_range	folios[];
> 
> I think it's dangerous to call this 'folios' as it lets you think that
> each entry is a single folio.  But as I understand this patch, you can
> coagulate contiguous ranges across multiple folios.

No that's not quite the case; each contiguous range only ever spans a *single*
folio. If there are 2 contiguous folios, they will be represented as separate
ranges. This is done so that we can subsequently do the per-folio operations
without having to figure out how many folios are within each range - one range =
one (contiguous part of a) folio.

On naming, I was calling this variable "ranges" in v1 but thought folios was
actually clearer. How about "folio_regions"?

> 
>> -void free_pages_and_swap_cache(struct page **pages, int nr)
>> +void free_folios_and_swap_cache(struct pfn_range *folios, int nr)
>>  {
>>  	lru_add_drain();
>>  	for (int i = 0; i < nr; i++)
>> -		free_swap_cache(pages[i]);
>> -	release_pages(pages, nr);
>> +		free_swap_cache(pfn_to_page(folios[i].start));
> 
> ... but here, you only put the swapcache for the first folio covered by
> the range, not for each folio.

Yes that's intentional - one range only ever covers one folio, so I only need to
call free_swap_cache() once for the folio. Unless I've misunderstood and
free_swap_cache() is actually decrementing a reference count and needs to be
called for every page? (but it doesn't look like that in the code).

> 
>> +	folios_put_refs(folios, nr);
> 
> It's kind of confusing to have folios_put() which takes a struct folio *
> and then folios_put_refs() which takes a struct pfn_range *.
> pfn_range_put()?

I think it's less confusing if you know that each pfn_range represents a single
contig range of pages within a *single* folio. pfn_range_put() would make it
sound like its ok to pass a pfn_range that spans multiple folios (this would
break). I could rename `struct pfn_range` to `struct sub_folio` or something
like that. Would that help make the semantic clearer?


