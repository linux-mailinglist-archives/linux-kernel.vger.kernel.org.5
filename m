Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A503178E22A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbjH3WOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245479AbjH3WON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:14:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB18F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wMEggmZxL4goGk4wIRAVlREtoAybKHItWmob2C6lubM=; b=llJXqS/aqU/78wYjuMyvbcGWf6
        S/KvkO/6Ce2cTAS51CSTeEBsicD7Vzm3cAIWiBRFtI0RUFcfwCLT0WW3oWi96wAUBtgQYO4UMfZqe
        JceZLNrzFwRLlnlITHPjeDXV0SmeS5SWbiKmO4I58vv1n8itO02cdOsR2BEwcmQzn/beQgmSeuiBe
        ygBdX/R4mgrlRYoA3nQVmGUxhTy0lEvE6R6uDtIdkwc2po0Xo0W4dAOxJ8MEbRIyUmAhpzj2mGbrL
        g318SBKNpqf892YiCGyCi/OH899J2pjyXQax/I+50mdDSF0n2VSHRO+fE5A1fVOD78WCZ5LRM8njP
        dgBqrarg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbSZF-00F1N4-Fo; Wed, 30 Aug 2023 21:17:37 +0000
Date:   Wed, 30 Aug 2023 22:17:37 +0100
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
Message-ID: <ZO+x8Wfz0BxgVpS6@casper.infradead.org>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-5-ryan.roberts@arm.com>
 <ZO+US8nVJTpbFGx3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO+US8nVJTpbFGx3@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:11:07PM +0100, Matthew Wilcox wrote:
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

No, can't do that here.  Swap cache has refs on the folio, so it'll
never trigger.

> 		__page_cache_release(folio, &lruvec, &flags);
> 	}
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

Must go at least here, maybe earlier.

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
> 
> Thoughts?
> 
