Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789075685F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjGQPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGQPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:55:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C92A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PjCcG9GMHBMdf5iB1swzPe5EzvZ1yf8Qqje/jcuPjk0=; b=MYMB6qFHsfey39Gq6ZMPCsAz15
        N+LIcWiSErJvhVYjCEfoHts27sXhwSyGgYrm80DT53qMnC723NVbXFs54ywzFkwoXXhnc0fVVEtVB
        WFK8BxmthSxTRrNlnWFBxNTuo+91uRpQMdkEMpcOdB+nl75GMne+VxdPb9SjW1HarvP3qEnonx776
        sfoEeYtHGzyw00UXWWWJViCewsYbmOaNqC7D++PMupN61AGCfW2H4pRLZ57FaZT7KYFRCvzEexZIq
        Mdzzfvq8jLEGTkRQV0zciAcGUOkzFLeAgwyABNnREupzHGAh4F7KeeJCqDuVTD3YiUExKyShr0olV
        A5/7I5mw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLQYs-0043W7-R6; Mon, 17 Jul 2023 15:54:59 +0000
Date:   Mon, 17 Jul 2023 16:54:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
Message-ID: <ZLVkUlQXmPH1BXEx@casper.infradead.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
 <ZLVeeDmPDWupYzSH@casper.infradead.org>
 <283e4122-c23f-35a1-4782-fddde32f4ad4@arm.com>
 <c10ae780-c405-b2d2-ecc0-78ef35a892f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10ae780-c405-b2d2-ecc0-78ef35a892f3@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:43:40PM +0200, David Hildenbrand wrote:
> On 17.07.23 17:41, Ryan Roberts wrote:
> > On 17/07/2023 16:30, Matthew Wilcox wrote:
> > > On Mon, Jul 17, 2023 at 03:31:08PM +0100, Ryan Roberts wrote:
> > > > In preparation for the introduction of large folios for anonymous
> > > > memory, we would like to be able to split them when they have unmapped
> > > > subpages, in order to free those unused pages under memory pressure. So
> > > > remove the artificial requirement that the large folio needed to be at
> > > > least PMD-sized.
> > > > 
> > > > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > > > Reviewed-by: Yu Zhao <yuzhao@google.com>
> > > > Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> > > 
> > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Thanks!
> > 
> > > 
> > > >   		 */
> > > > -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> > > > +		if (folio_test_large(folio) && folio_test_anon(folio))
> > > >   			if (!compound || nr < nr_pmdmapped)
> > > >   				deferred_split_folio(folio);
> > > 
> > > I wonder if it's worth introducing a folio_test_deferred_split() (better
> > > naming appreciated ...) to allow us to allocate order-1 folios and not
> > > do horrible things.  Maybe it's not worth supporting order-1 folios;
> > > we're always better off going to order-2 immediately.  Just thinking.
> > 
> > There is more than just _deferred_list in the 3rd page; you also have _flags_2a
> > and _head_2a. I guess you know much better than me what they store. But I'm
> > guessing its harder than jsut not splitting an order-1 page?

Those are page->flags and page->compound_head for the third page in
the folio.  They don't really need a name; nothing refers to them,
but it's important that space not be reused ;-)

This is slightly different from _flags_1; we do have some flags which
reuse the bits (they're labelled as PF_SECOND).  Right now, it's only
PF_has_hwpoisoned, but we used to have PF_double_map.  Others may arise.

> > With the direction of large anon folios (_not_ retrying with every order down to
> > 0), I'm not sure what the use case would be for order-1 anyway?
> 
> Just noting that we might need some struct-page space for better
> mapcount/shared tracking, which might get hard for order-1 pages.

My assumption had been that we'd be able to reuse the _entire_mapcount
and _nr_pages_mapped fields and not spill into the third page, but the
third page is definitely available today if we want it.  I'm fine with
disallowing order-1 anon/file folios forever.
