Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA878F3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjHaT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHaT6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:58:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99C11EA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:58:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 577E4C15;
        Thu, 31 Aug 2023 12:58:57 -0700 (PDT)
Received: from [10.57.65.16] (unknown [10.57.65.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 837C53FBD2;
        Thu, 31 Aug 2023 12:57:57 -0700 (PDT)
Message-ID: <31aa40aa-1471-44ca-9cc8-3f5476fbde7e@arm.com>
Date:   Thu, 31 Aug 2023 20:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: Refector release_pages()
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
 <20230830095011.1228673-5-ryan.roberts@arm.com>
 <ZO+US8nVJTpbFGx3@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZO+US8nVJTpbFGx3@casper.infradead.org>
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

On 30/08/2023 20:11, Matthew Wilcox wrote:
> On Wed, Aug 30, 2023 at 10:50:10AM +0100, Ryan Roberts wrote:
>> In preparation for implementing folios_put_refs() in the next patch,
>> refactor release_pages() into a set of helper functions, which can be
>> reused. The primary difference between release_pages() and
>> folios_put_refs() is how they iterate over the set of folios. The
>> per-folio actions are identical.
> 
> As you noted, we have colliding patchsets.  I'm not hugely happy with
> how patch 4 turned out, 

Could you describe the issues as you see them? I'm keen not to repeat the same
bad patterns in future.

so I thought I'd send some addendum patches to
> my RFC series that implement pfn_range_put() (maybe should have been
> pfn_ranges_put()?) on top of my patch series.  I think it's a bit nicer,
> but not quite as nice as it could be.
> 
> I'm thinking about doing ...
> 
> void release_unref_folios(struct folio_batch *folios)
> {
> 	struct lruvec *lruvec = NULL;
> 	unsigned long flags = 0;
> 	int i;
> 
> 	for (i = 0; i < folios->nr; i++) {
> 		struct folio *folio = folios->folios[i];
> 		free_swap_cache(folio);

Agree this can't go here - would put it in pfn_range_put(). But would not want
it in folios_put() as you suggeted in the other email - that would surely change
the behaviour of folios_put()?

> 		__page_cache_release(folio, &lruvec, &flags);
> 	}

I think you would need to add:

	if (lruvec)
		unlock_page_lruvec_irqrestore(lruvec, flags);

> 	mem_cgroup_uncharge_folios(folios);
> 	free_unref_folios(folios);
> }
> 
> then this becomes:
> 
> void folios_put(struct folio_batch *folios)
> {
>         int i, j;
> 
>         for (i = 0, j = 0; i < folios->nr; i++) {
>                 struct folio *folio = folios->folios[i];
> 
>                 if (is_huge_zero_page(&folio->page))
>                         continue;
>                 if (folio_is_zone_device(folio)) {
>                        if (put_devmap_managed_page(&folio->page))
>                                 continue;
>                         if (folio_put_testzero(folio))
>                                 free_zone_device_page(&folio->page);
>                         continue;
>                 }
> 
>                 if (!folio_put_testzero(folio))
>                         continue;
>                 if (folio_test_hugetlb(folio)) {
>                        free_huge_folio(folio);
>                         continue;
>                 }
> 
>                 if (j != i)
>                         folios->folios[j] = folio;
>                 j++;
>         }
> 
>         folios->nr = j;
>         if (!j)
>                 return;
> 	release_unref_folios(folios);
> }
> 
> and pfn_range_put() also becomes shorter and loses all the lruvec work.

something like this?

void pfn_range_put(struct pfn_range *range, unsigned int nr)
{
	struct folio_batch folios;
	unsigned int i;

	folio_batch_init(&folios);
	for (i = 0; i < nr; i++) {
		struct folio *folio = pfn_folio(range[i].start);
		unsigned int refs = range[i].end - range[i].start;

		free_swap_cache(folio); // <<<<< HERE? To be equivalent to
					//       free_pages_and_swap_cache()

		if (is_huge_zero_page(&folio->page))
                         continue;

		if (folio_is_zone_device(folio)) {
			if (put_devmap_managed_page_refs(&folio->page, refs))
				continue;
			if (folio_ref_sub_and_test(folio, refs))
				free_zone_device_page(&folio->page);
			continue;
		}

		if (!folio_ref_sub_and_test(folio, refs))
			continue;

		/* hugetlb has its own memcg */
		if (folio_test_hugetlb(folio)) {
			free_huge_folio(folio);
			continue;
		}

		if (folio_batch_add(&folios, folio) == 0)
			release_unref_folios(&folios);
	}

	if (folios.nr)
		release_unref_folios(&folios);
}

> 
> Thoughts?

Looks like its getting there to me. Although the bulk of the logic inside the
loop is still common between folios_put() and pfn_range_put(); perhaps we can
have a common helper for that, which would just need to take (folio, refs)?

So by adding free_swap_cache() above, we can call pfn_range_put() direct and can
remove free_pages_and_swap_cache() entirely.

What's the best way to move forward here? Two options as I see it:

 - I drop patch 4 and create a version of pfn_range_put() that has the same
semantic as above but essentially just copies the old release_pages() (similar
to my v1). That keeps my series independent. Then you can replace with the new
pfn_range_put() as part of your series.

 - We can just hook my patches up to the end of your series and do it all in one go.

Opinion?

Thanks,
Ryan

