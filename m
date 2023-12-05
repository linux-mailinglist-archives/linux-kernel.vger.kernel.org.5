Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E73805B80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbjLEQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjLEQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:06:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F54D62
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZ9hGmOAU2FBZdAcWBT4EroA4dZyM8ao7E1RVyy5W1Q=; b=JfAYiPlIjHY6yui/t2m/kE0wwI
        NQ+2jYzHxNa0mPbd0fmcYgXvhv1NLrJ5ufZAOKI5GeGjrSTknq7p2pKaPTDOxqhZGPcCk0hsGAvwN
        FQ9iDXDki6wTVSFIHpXWiZoF7qh/DD4rSm9SX9yTLrkn/1CjUcf+W1NHn4VSyiizp7h/kk4ZcImh1
        60HHfxOOehBijlCbWAJsEoulSTiEIpMiFMX+0aftLr1+veiUBaBSdh82CB3/txeuAhQsjmreIAHe+
        24RZQgCsAM8qSjBcquM5jzjbUwQ1txDmwnq25RI28EikbuYdQhlRmba18Ls5HIJDDhUvx3N9zFvtl
        gnYjTGNg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rAXvi-0022Oo-57; Tue, 05 Dec 2023 16:05:50 +0000
Date:   Tue, 5 Dec 2023 16:05:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Message-ID: <ZW9KXpsF7y5MvSlJ@casper.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
 <ZVGxkMeY50JSesaj@casper.infradead.org>
 <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
 <ZVI65lck7WqsHZwF@casper.infradead.org>
 <181a25c2-219e-4af9-9f8e-e5f514bbc4b6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181a25c2-219e-4af9-9f8e-e5f514bbc4b6@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 10:57:07AM +0000, Ryan Roberts wrote:
> On 13/11/2023 15:04, Matthew Wilcox wrote:
> > On Mon, Nov 13, 2023 at 10:19:48AM +0000, Ryan Roberts wrote:
> >> On 13/11/2023 05:18, Matthew Wilcox wrote:
> >>> My hope is to abolish the 64kB page size configuration.  ie instead of
> >>> using the mixture of page sizes that you currently are -- 64k and
> >>> 1M (right?  Order-0, and order-4)
> >>
> >> Not quite; the contpte-size for a 64K page size is 2M/order-5. (and yes, it is
> >> 64K/order-4 for a 4K page size, and 2M/order-7 for a 16K page size. I agree that
> >> intuitively you would expect the order to remain constant, but it doesn't).
> >>
> >> The "recommend" setting above will actually enable order-3 as well even though
> >> there is no HW benefit to this. So the full set of available memory sizes here is:
> >>
> >> 64K/order-0, 512K/order-3, 2M/order-5, 512M/order-13
> >>
> >>> , that 4k, 64k and 2MB (order-0,
> >>> order-4 and order-9) will provide better performance.
> >>>
> >>> Have you run any experiements with a 4kB page size?
> >>
> >> Agree that would be interesting with 64K small-sized THP enabled. And I'd love
> >> to get to a world were we universally deal in variable sized chunks of memory,
> >> aligned on 4K boundaries.
> >>
> >> In my experience though, there are still some performance benefits to 64K base
> >> page vs 4K+contpte; the page tables are more cache efficient for the former case
> >> - 64K of memory is described by 8 bytes in the former vs 8x16=128 bytes in the
> >> latter. In practice the HW will still only read 8 bytes in the latter but that's
> >> taking up a full cache line vs the former where a single cache line stores 8x
> >> 64K entries.
> > 
> > This is going to depend on your workload though -- if you're using more
> > 2MB than 64kB, you get to elide a layer of page table with 4k base,
> > rather than taking up 4 cache lines with a 64k base.
> 
> True, but again depending on workload/config, you may have few levels of lookup
> for the 64K native case in the first place because you consume more VA bits at
> each level.

Sorry, missed this email ... let's work it through.

With 4k, and a 48-bit VA space, we get 12 bits at the lowest level, then
9 bits each layer, so 4 * 9 + 12 = 48.  With a 2MB allocation, we
eliminate the bottom layer and examine three cachelines to find it (PGD
entry, PUD entry, PMD entry)

With 64k, we get 16 bits at the lowest level, then 13 bits each layer,
so 3 * 13 + 16 = 55.  With a 2MB allocation, we can't eliminate the
bottom layer, so we still have to examine three cachelines to find it
(PGD, PMD, PTE).  If you can fit into a 42-bit address space, you can
reduce it by one cache miss, but my impression is that applications
which use 21 bits of address space for a single allocation want more
address space than your average application.
