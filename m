Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC90778F7AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348207AbjIAEgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 00:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjIAEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 00:36:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0EBD7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q86tS1awgf6N4EnRYrgorhAZo9uxjE8cuaKOiv4nfP0=; b=jhLte4MUt0KbG8uPB9PlV2WL/m
        OY7FevEG18kL7CZlWtgIWsOTfl1ECsdRk+zKkAPPkqI9bP+ZWNYvMgpqmwS2V/FAXUyMPNW5lLZJi
        RIYzWhVt4RP9PjJCdw28xVqmykWGl3for9gDTXFI3aVKZ+NuxctTGkx9xY5oEkF4JolvOSp6xY83g
        dRwPOMKY95KTFZ/f0Ju+zBzEp0DnZpj/u2mxg411vHVy+QwXY4TM/i4mSOpDQUmQlmqxrx8DFvEp2
        eCOsHoVYjES9hEao+1huZKAkRfoVqjbFXsI8holHH4EXUHGZPMFl4Erim2CyoHWws42rcvRFnEyZH
        jKmcpW+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbvtE-005S27-EN; Fri, 01 Sep 2023 04:36:12 +0000
Date:   Fri, 1 Sep 2023 05:36:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
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
Subject: Re: [PATCH v2 4/5] mm: Refector release_pages()
Message-ID: <ZPFqPPqW3MYQFCSb@casper.infradead.org>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-5-ryan.roberts@arm.com>
 <ZO+US8nVJTpbFGx3@casper.infradead.org>
 <31aa40aa-1471-44ca-9cc8-3f5476fbde7e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31aa40aa-1471-44ca-9cc8-3f5476fbde7e@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 08:57:51PM +0100, Ryan Roberts wrote:
> On 30/08/2023 20:11, Matthew Wilcox wrote:
> > On Wed, Aug 30, 2023 at 10:50:10AM +0100, Ryan Roberts wrote:
> >> In preparation for implementing folios_put_refs() in the next patch,
> >> refactor release_pages() into a set of helper functions, which can be
> >> reused. The primary difference between release_pages() and
> >> folios_put_refs() is how they iterate over the set of folios. The
> >> per-folio actions are identical.
> > 
> > As you noted, we have colliding patchsets.  I'm not hugely happy with
> > how patch 4 turned out, 
> 
> Could you describe the issues as you see them? I'm keen not to repeat the same
> bad patterns in future.

I think you absolutely had the right idea.  I'd've probably done the same
as you in the same circumstances as you.  It's just that I'd done this
patch series getting rid of / simplifying a bunch of the code you were
modifying, and I thought it'd make your 4/5 irrelevant and 5/5 simpler.

> > void release_unref_folios(struct folio_batch *folios)
> > {
> > 	struct lruvec *lruvec = NULL;
> > 	unsigned long flags = 0;
> > 	int i;
> > 
> > 	for (i = 0; i < folios->nr; i++) {
> > 		struct folio *folio = folios->folios[i];
> > 		free_swap_cache(folio);
> 
> Agree this can't go here - would put it in pfn_range_put(). But would not want
> it in folios_put() as you suggeted in the other email - that would surely change
> the behaviour of folios_put()?

yes; perhaps there are times when we want to put a batch of folios and
_don't_ want to rip them out of the swapcache.  I haven't thought about
this in much detail, and we're definitely venturing into areas of the
MM where I get myself in trouble (ie anonymous memory).

> > 		__page_cache_release(folio, &lruvec, &flags);
> > 	}
> 
> I think you would need to add:
> 
> 	if (lruvec)
> 		unlock_page_lruvec_irqrestore(lruvec, flags);

Indeed.

> > 	mem_cgroup_uncharge_folios(folios);
> > 	free_unref_folios(folios);
> > }
> > 
> > then this becomes:
> > 
> > void folios_put(struct folio_batch *folios)
> > {
> >         int i, j;
> > 
> >         for (i = 0, j = 0; i < folios->nr; i++) {
> >                 struct folio *folio = folios->folios[i];
> > 
> >                 if (is_huge_zero_page(&folio->page))
> >                         continue;
> >                 if (folio_is_zone_device(folio)) {
> >                        if (put_devmap_managed_page(&folio->page))
> >                                 continue;
> >                         if (folio_put_testzero(folio))
> >                                 free_zone_device_page(&folio->page);
> >                         continue;
> >                 }
> > 
> >                 if (!folio_put_testzero(folio))
> >                         continue;
> >                 if (folio_test_hugetlb(folio)) {
> >                        free_huge_folio(folio);
> >                         continue;
> >                 }
> > 
> >                 if (j != i)
> >                         folios->folios[j] = folio;
> >                 j++;
> >         }
> > 
> >         folios->nr = j;
> >         if (!j)
> >                 return;
> > 	release_unref_folios(folios);
> > }
> > 
> > and pfn_range_put() also becomes shorter and loses all the lruvec work.
> 
> something like this?
> 
> void pfn_range_put(struct pfn_range *range, unsigned int nr)
> {
> 	struct folio_batch folios;
> 	unsigned int i;
> 
> 	folio_batch_init(&folios);
> 	for (i = 0; i < nr; i++) {
> 		struct folio *folio = pfn_folio(range[i].start);
> 		unsigned int refs = range[i].end - range[i].start;
> 
> 		free_swap_cache(folio); // <<<<< HERE? To be equivalent to
> 					//       free_pages_and_swap_cache()
> 
> 		if (is_huge_zero_page(&folio->page))
>                          continue;
> 
> 		if (folio_is_zone_device(folio)) {
> 			if (put_devmap_managed_page_refs(&folio->page, refs))
> 				continue;
> 			if (folio_ref_sub_and_test(folio, refs))
> 				free_zone_device_page(&folio->page);
> 			continue;
> 		}
> 
> 		if (!folio_ref_sub_and_test(folio, refs))
> 			continue;
> 
> 		/* hugetlb has its own memcg */
> 		if (folio_test_hugetlb(folio)) {
> 			free_huge_folio(folio);
> 			continue;
> 		}
> 
> 		if (folio_batch_add(&folios, folio) == 0)
> 			release_unref_folios(&folios);
> 	}
> 
> 	if (folios.nr)
> 		release_unref_folios(&folios);
> }
> 
> > 
> > Thoughts?
> 
> Looks like its getting there to me. Although the bulk of the logic inside the
> loop is still common between folios_put() and pfn_range_put(); perhaps we can
> have a common helper for that, which would just need to take (folio, refs)?
> 
> So by adding free_swap_cache() above, we can call pfn_range_put() direct and can
> remove free_pages_and_swap_cache() entirely.

Yes.  Maybe this works?  I'd like it to!

> What's the best way to move forward here? Two options as I see it:
> 
>  - I drop patch 4 and create a version of pfn_range_put() that has the same
> semantic as above but essentially just copies the old release_pages() (similar
> to my v1). That keeps my series independent. Then you can replace with the new
> pfn_range_put() as part of your series.
> 
>  - We can just hook my patches up to the end of your series and do it all in one go.
> 
> Opinion?

I'm reluctant to tell you "hey, delay until after this series of mine".
We don't have good data yet on whether my patch series helps or hurts.
Plus I'm about to take a few days off (I'll be back for next Wednesday's
meeting).  I think your first option is better (and do feel free to use
a different name from pfn_range_put()) just to keep us from colliding
in ways that ultimately don't matter.
