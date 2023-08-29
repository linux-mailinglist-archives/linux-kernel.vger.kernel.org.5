Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE5A78BCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjH2CLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjH2CKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:10:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671E199
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YvhsnVnVxkF2DtUubelTRgfBv4rbhb89904sdEuy7sk=; b=uxdF6MdA7wLXYedSPOWY+YbDhM
        +Avn3bMr5ULWE8BV84XSJA4sS4DsveH1W/phBOQZpnkPM42oFHJJ2XYfWsBkPRljJ1/Ecbn8I9xHd
        O4FJauVOVKFBMIU/FdEoG6zicEsNkXqoUveZaGD4XnuLPp3XVe8+jmta7dyGpeNIrnVMKPdQh2Fxh
        ujKT9Nxvzwqjs8PYJ9R9PMwESGz1wV1ttYLFwCwL7Teorm61wXkX/qDbusvSv8nG8Fk+6IMi/nnTK
        3Q3jmpICRbydfsfE45ILW0QW6noJ+CYKVVhBYQeZzQntBB/jdMq6bI/z7rLsEEUbm/ga+3KpHuj9O
        MJNCTPNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qaoBF-003qIo-5g; Tue, 29 Aug 2023 02:10:09 +0000
Date:   Tue, 29 Aug 2023 03:10:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 4/8] mm: migrate: use a folio in
 migrate_misplaced_page()
Message-ID: <ZO1TgSCevv5JJEz0@casper.infradead.org>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-5-wangkefeng.wang@huawei.com>
 <855536BE-766C-49B2-B358-6C0548760929@nvidia.com>
 <875y4y65b8.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y4y65b8.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:49:31AM +0800, Huang, Ying wrote:
> Zi Yan <ziy@nvidia.com> writes:
> 
> > On 21 Aug 2023, at 7:56, Kefeng Wang wrote:
> >
> >> Use a folio in migrate_misplaced_page() to save compound_head() calls.
> >>
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>  mm/migrate.c | 23 ++++++++++++-----------
> >>  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > LGTM. And a comment below. Reveiwed-by: Zi Yan <ziy@nvidia.com>
> >
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 281eafdf8e63..fc728f9a383f 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -2521,17 +2521,18 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
> >>  			   int node)
> >>  {
> >>  	pg_data_t *pgdat = NODE_DATA(node);
> >> +	struct folio *folio = page_folio(page);
> >>  	int isolated;
> >>  	int nr_remaining;
> >>  	unsigned int nr_succeeded;
> >>  	LIST_HEAD(migratepages);
> >> -	int nr_pages = thp_nr_pages(page);
> >> +	int nr_pages = folio_nr_pages(folio);
> >>
> >>  	/*
> >>  	 * Don't migrate file pages that are mapped in multiple processes
> >>  	 * with execute permissions as they are probably shared libraries.
> >>  	 */
> >> -	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
> >> +	if (page_mapcount(page) != 1 && folio_is_file_lru(folio) &&
> >
> > page_mapcount() is not converted, since folio_mapcount() is not equivalent
> > to page_mapcount(). It can be converted and this function can be converted
> > to migrate_misplaced_folio() once we have something like folio_num_sharers().
> 
> It seems that we can use folio_estimated_sharers() here.

So, funny thing, page_mapcount() was always wrong here.  We have two
callers, do_huge_pmd_numa_page() and do_numa_page().  do_numa_page()
has a check for PageCompound() (and /* TODO: handle PTE-mapped THP */).
do_huge_pmd_numa_page() returns pfn_to_page(), after it got the pfn
fromm pmd_pfn(pmd).

That makes folio_estimated_sharers() an improvement, possibly even
a bugfix.  Also, we should look at removing the PageCompound() check
in do_numa_page().
