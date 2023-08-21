Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E41782165
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjHUC3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjHUC3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:29:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE9E99
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4iyN5XJixW9XMMjoB8nCsjnA5CisXfjAJRdmQ4Uv0Ag=; b=uL1QVT9dnEbMu7ZjDin2zcuQa+
        Z3qsxmhBtwFWzq4ektkwJ23hUTrQqgJP8qHSo54z48uyBI7qQfBwbmXkU9gwqyuMgk9OX4x53wF7H
        iJtIdYgxBI+hsvoERpFCv4LwKc5BGhYS75fXW8gvIlVG/x09bV/aC2s9QbRKoLmWDtALkiEY6rZS3
        ium4AHlX7NYAKdmRuGQ0g21pxxwoYgmdlA+xsb366PAergxxIkh4Sc5E8mf7RzAmpotda81Gof6Uc
        U6ZqhDaJ8LtplJ3hWJNxPUPZM1RVLwkLoj7XzwJxj1b9ySyeH9GcQP9jdIkYcQyX4dcbOj40Z7IO6
        jOTW5nPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXuf7-007bBg-5I; Mon, 21 Aug 2023 02:29:01 +0000
Date:   Mon, 21 Aug 2023 03:29:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Wire up tail page poisoning over ->mappings
Message-ID: <ZOLL7f+Ihc93lyo0@casper.infradead.org>
References: <20230815210659.430010-1-peterx@redhat.com>
 <ZN/tRLy0e+Iod9z3@casper.infradead.org>
 <ZOK6U4vOFn8IbcGp@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOK6U4vOFn8IbcGp@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 09:13:55PM -0400, Peter Xu wrote:
> > https://lore.kernel.org/linux-mm/ZNp7yUgUrIpILnXu@casper.infradead.org/
> 
> https://lore.kernel.org/linux-mm/ZNqFv0AwkfDKExiw@x1n/#t
> 
> Firstly, I've answered and you didn't follow that up.

I didn't see it.  I get a lot of email ...

> > > More importantly, I think this is over-parametrisation.  If you start to
> > > use extra fields in struct folio, just change the code in page_alloc.c
> > > directly.
> 
> Change the hard-coded "2"s in different functions?  Can you kindly explain
> why can't we just have a macro to help?

Because it's unnecessary.  You're putting in way too much effort here
for something that might happen once.

> Setting tail mapping for tail 1/2 is even wrong, which part of this patch
> fixes:
> 
> @@ -428,7 +428,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
>  {
>         struct page *p = head + tail_idx;
> 
> -       p->mapping = TAIL_MAPPING;
> +       if (tail_idx > TAIL_MAPPING_REUSED_MAX)
> +               p->mapping = TAIL_MAPPING;
>         set_compound_head(p, head);
>         set_page_private(p, 0);
>  }

I didn't see this.  This is wrong.  tail->mapping is only reused for
large rmappable pages.  It's not reused for other compound pages.

If you really insist on cleaning this up, the special casing of tail pages
should move out of page_alloc entirely.  folio_undo_large_rmappable()
should restore TAIL_MAPPING for all tail pages that were modified by
folio_prep_large_rmappable().

The other thing we should do is verify that the additional large-rmap
fields have the correct values in folio_undo_large_rmappable().

But let's look back to why TAIL_MAPPING was introduced.  Commit
1c290f642101e poisoned tail->mapping to catch users which forgot to
call compound_head().  So we can actually remove TAIL_MAPPING entirely
if we get rid of page->mapping.

You probably think that's an unattainable goal; there are something like
340 occurrences of the string 'page->mapping' in the kernel right now
(and there are probably instances of struct page named something other
than 'page'), but a lot of those are actually in comments, which would
be my fault for not fixing them during folio conversions.

However, I have a small patch series which enables 'allnoconfig' to
build after renaming page->mapping to page->_mapping.  Aside from fs/
there are *very* few places which look at page->mapping [1].  I'll post
that patch series tomorrow.

I think with some serious work, we can land "remove page->mapping"
(which would include removing TAIL_MAPPING) by the end of the year.
And that work gets us closer to the goal of shrinking struct page.

[1] device-dax, intel_th, mthca, cortina, fb_defio

