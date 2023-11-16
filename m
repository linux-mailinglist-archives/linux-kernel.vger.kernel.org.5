Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC37EE356
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjKPOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKPOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:52:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1B130
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ojEoDQsJbTKNbq6oPAMc3aknQ7lB4yrHDrRikIo44Y=; b=hfk9fkdc9vO0S2gBsS4PhgF/Hv
        xo9giUPkBJqOVc9jqbjGwEyrOzKkCmfF6hujr3hTvHFKID6f3Fq503I6juI4QqENzgjAqWGFqSsqQ
        q4dQSYdXySSSMpRl06w5hMDO5ZUkwD5xI7VVmtyI1iaowUFygHTOFLgNHO9yDAVPMGXeCvu9Gao8n
        AnFHee7FVHpCS1Vh0ANhbbsv/Xnl5+SFsBHIPSCWTyz9B10vBKv268A5/zbvNpO6p12eKsGmY9kLl
        WljHM9JeeL6Catj3T5Sj38GRo2nAdgOgE/5wi0tECtxXIpU+2ds9zj32B2EjBGFny5oh7RqJ4jmBP
        56LNyPVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3dii-003azA-ES; Thu, 16 Nov 2023 14:51:52 +0000
Date:   Thu, 16 Nov 2023 14:51:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 07/12] mm/gup: Refactor record_subpages() to find 1st
 small page
Message-ID: <ZVYsiNxXGJCk0EYs@casper.infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-8-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:29:03PM -0500, Peter Xu wrote:
> All the fast-gup functions take a tail page to operate, always need to do
> page mask calculations before feeding that into record_subpages().
> 
> Merge that logic into record_subpages(), so that we always take a head
> page, and leave the rest calculation to record_subpages().

This is a bit fragile.  You're assuming that pmd_page() always returns
a head page, and that's only true today because I looked at the work
required vs the reward and decided to cap the large folio size at PMD
size.  If we allowed 2*PMD_SIZE (eg 4MB on x86), pmd_page() would not
return a head page.  There is a small amount of demand for > PMD size
large folio support, so I suspect we will want to do this eventually.
I'm not particularly trying to do these conversions, but it would be
good to not add more assumptions that pmd_page() returns a head page.

> +static int record_subpages(struct page *head, unsigned long sz,
> +			   unsigned long addr, unsigned long end,
> +			   struct page **pages)

> @@ -2870,8 +2873,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  					     pages, nr);
>  	}
>  
> -	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
> -	refs = record_subpages(page, addr, end, pages + *nr);
> +	page = pmd_page(orig);
> +	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
>  
>  	folio = try_grab_folio(page, refs, flags);
>  	if (!folio)
