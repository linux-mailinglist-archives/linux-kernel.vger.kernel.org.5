Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD77F7859
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345962AbjKXPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjKXPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:53:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CF012B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yp/TRPnJUCRddcn2pwqpadteZMnyKo+3JgWlmsfeyA8=; b=hjzmSFaDj2EPMwg3j4Voli4wxk
        plO+mX85rqcIAExFojWw6zdP/4cQlZcoxhiqc/dZHaKeTy1dFmH6FGcUFX9UIh68Vtxk8ii3n/uqN
        /mW6X4/Asm/QMk7rs/H+oKD/H2s9KxNy2KiyIeq+6VMt+DrVDnyvF0UOpHMOmRfY9j4sI30NAaJsM
        KYPnt6dI6ZHzWFYk4hDSWR4ZfnhQryFDRZDI9fdi6YzGRsnbMly3QaU+KR3vL9cQefGVTXL2HADdz
        /uwm8AppmQCyNYeOvWJ4JC90e0208Tmwop3wGQi8w3dI+hBiJndFqYLAlKn+yFjFd8htpKXLT9b5f
        Rk61PzVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6YUS-008icA-JD; Fri, 24 Nov 2023 15:53:12 +0000
Date:   Fri, 24 Nov 2023 15:53:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Message-ID: <ZWDG6BYqmZVpyTLL@casper.infradead.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:25:38PM +0100, David Hildenbrand wrote:
> On 24.11.23 16:13, Matthew Wilcox wrote:
> > On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
> > > On 23/11/2023 15:59, Matthew Wilcox wrote:
> > > > On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
> > > > > This is v7 of a series to implement small-sized THP for anonymous memory
> > > > > (previously called "large anonymous folios"). The objective of this is to
> > > > 
> > > > I'm still against small-sized THP.  We've now got people asking whether
> > > > the THP counters should be updated when dealing with large folios that
> > > > are smaller than PMD sized.  It's sowing confusion, and we should go
> > > > back to large anon folios as a name.
> > > 
> > > I suspect I'm labouring the point here, but I'd like to drill into exactly what
> > > you are objecting to. Is it:
> > > 
> > > A) Using the name "small-sized THP" (which is currently only used in the commit
> > > logs and a couple of times in the documentation).
> > 
> > Yes, this is what I'm objecting to.
> 
> I'll just repeat that "large anon folio" is misleading, because
> * we already have "large anon folios" in hugetlb

We do?  Where?

> * we already have PMD-sized "large anon folios" in THP

Right, those are already accounted as THP, and that's what users expect.
If we're allocating 1024 x 64kB chunks of memory, the user won't be able
to distinguish that from 32 x 2MB chunks of memory, and yet the
performance profile for some applications will be very different.

> But inn the end, I don't care how we will call this in a commit message.
> 
> Just sticking to what we have right now makes most sense to me.
> 
> I know, as the creator of the term "folio" you have to object :P Sorry ;)

I don't care if it's called something to do with folios or not.  I
am objecting to the use of the term "small THP" on the grounds of
confusion and linguistic nonsense.
