Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F178DFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjH3TmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjH3TkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:40:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00801D906
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tqz/DZawdYZxdUO9cH0CNTKU0VPKN8BYJEeAbOf2UBM=; b=oe+LBcOaZkEVCF8aJtKZlvfWSg
        ZhPQg99fcqS1AWvoK39kdwiB+SKWjXItaWk3dAAgcHfB2FVAE2ZeKq9EhhnnsxehM4JrCu0d3AFHV
        SOa60NHEU1h7Jfn154TvmjndfOdAHJBgxH8BjePTNgJRNbyojEQtxroskuLDOjFdjtbNJJlUp8mr9
        zomm2H6pEf5PJjmOwHhroH9ekX4sPwNE5B0knDdAlygRyfdDuTSQ5Kg248kaPKPBwH74x+rImIsmc
        byLHGWpiEmHQkNG6tOD1W4FimhTEwUUfeMYxhs7KDd17cuvTCkHcHIlc10L4/ibzdy3NW08OeZ9x6
        wIxJsDFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbQap-00ET8A-Fp; Wed, 30 Aug 2023 19:11:07 +0000
Date:   Wed, 30 Aug 2023 20:11:07 +0100
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
Message-ID: <ZO+US8nVJTpbFGx3@casper.infradead.org>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
 <20230830095011.1228673-5-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830095011.1228673-5-ryan.roberts@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:50:10AM +0100, Ryan Roberts wrote:
> In preparation for implementing folios_put_refs() in the next patch,
> refactor release_pages() into a set of helper functions, which can be
> reused. The primary difference between release_pages() and
> folios_put_refs() is how they iterate over the set of folios. The
> per-folio actions are identical.

As you noted, we have colliding patchsets.  I'm not hugely happy with
how patch 4 turned out, so I thought I'd send some addendum patches to
my RFC series that implement pfn_range_put() (maybe should have been
pfn_ranges_put()?) on top of my patch series.  I think it's a bit nicer,
but not quite as nice as it could be.

I'm thinking about doing ...

void release_unref_folios(struct folio_batch *folios)
{
	struct lruvec *lruvec = NULL;
	unsigned long flags = 0;
	int i;

	for (i = 0; i < folios->nr; i++) {
		struct folio *folio = folios->folios[i];
		free_swap_cache(folio);
		__page_cache_release(folio, &lruvec, &flags);
	}
	mem_cgroup_uncharge_folios(folios);
	free_unref_folios(folios);
}

then this becomes:

void folios_put(struct folio_batch *folios)
{
        int i, j;

        for (i = 0, j = 0; i < folios->nr; i++) {
                struct folio *folio = folios->folios[i];

                if (is_huge_zero_page(&folio->page))
                        continue;
                if (folio_is_zone_device(folio)) {
                       if (put_devmap_managed_page(&folio->page))
                                continue;
                        if (folio_put_testzero(folio))
                                free_zone_device_page(&folio->page);
                        continue;
                }

                if (!folio_put_testzero(folio))
                        continue;
                if (folio_test_hugetlb(folio)) {
                       free_huge_folio(folio);
                        continue;
                }

                if (j != i)
                        folios->folios[j] = folio;
                j++;
        }

        folios->nr = j;
        if (!j)
                return;
	release_unref_folios(folios);
}

and pfn_range_put() also becomes shorter and loses all the lruvec work.

Thoughts?
