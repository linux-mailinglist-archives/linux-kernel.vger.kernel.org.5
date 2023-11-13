Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E27E9F79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjKMPEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:04:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2066132
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBQ5a0hJZ/GfX0iieQrBicPR1Pwnet9ZpiDu5Dc5S8o=; b=T4JygIqSJTI4zR7pgmmCZFqPiE
        Cuix9/8FMuTEaTJ2GiTMl9zVm70vXXkZ30telLR0jR+fttKqiv5V2IP2m0FzipRM96jnQKHlprEFp
        Y+h+Vm4ZC7GbL8wCbkUDU3KWWJDC6ZH0dEuD8xWwQP2Tuxvkte3ZMeOX656eFiCraCyqwyGMCcXqf
        EH02CShkSiYi4LeGns/w5lXlFX6sJ3xDuO11lHlpIFNdBNMcR3vs1Sv77gtYx707ggQFx0YNwHod0
        KHMYYStbY//caLhJTuoCHEiDIF4aN4bzXJt+eFXej+JH266hPBrLtvilWpxrxkRyBk0zhfrj3yOzS
        bnH1rYaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r2YTu-00EsZO-5e; Mon, 13 Nov 2023 15:04:06 +0000
Date:   Mon, 13 Nov 2023 15:04:06 +0000
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
Message-ID: <ZVI65lck7WqsHZwF@casper.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
 <ZVGxkMeY50JSesaj@casper.infradead.org>
 <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:19:48AM +0000, Ryan Roberts wrote:
> On 13/11/2023 05:18, Matthew Wilcox wrote:
> > My hope is to abolish the 64kB page size configuration.  ie instead of
> > using the mixture of page sizes that you currently are -- 64k and
> > 1M (right?  Order-0, and order-4)
> 
> Not quite; the contpte-size for a 64K page size is 2M/order-5. (and yes, it is
> 64K/order-4 for a 4K page size, and 2M/order-7 for a 16K page size. I agree that
> intuitively you would expect the order to remain constant, but it doesn't).
> 
> The "recommend" setting above will actually enable order-3 as well even though
> there is no HW benefit to this. So the full set of available memory sizes here is:
> 
> 64K/order-0, 512K/order-3, 2M/order-5, 512M/order-13
> 
> > , that 4k, 64k and 2MB (order-0,
> > order-4 and order-9) will provide better performance.
> > 
> > Have you run any experiements with a 4kB page size?
> 
> Agree that would be interesting with 64K small-sized THP enabled. And I'd love
> to get to a world were we universally deal in variable sized chunks of memory,
> aligned on 4K boundaries.
> 
> In my experience though, there are still some performance benefits to 64K base
> page vs 4K+contpte; the page tables are more cache efficient for the former case
> - 64K of memory is described by 8 bytes in the former vs 8x16=128 bytes in the
> latter. In practice the HW will still only read 8 bytes in the latter but that's
> taking up a full cache line vs the former where a single cache line stores 8x
> 64K entries.

This is going to depend on your workload though -- if you're using more
2MB than 64kB, you get to elide a layer of page table with 4k base,
rather than taking up 4 cache lines with a 64k base.
