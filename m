Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70957784541
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjHVPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:19:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F651B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHXtvgp2vFB1N8oXlS+0V2S/KPy9LASs+TLCFHvkSkM=; b=OJdxrOsBxr1l3pxhaCBZm5JAUN
        kN4pwMf2Od0l9KwnTU4ltvBAIOJMFyRTbZoTITKp3ABLHQlIpdNkJN6mEBxpwniNqjHoefFfWKvK+
        2LXc1qfL1Trfl3+HlzW91nZiIsL2kiSG9ybwFjvKPYwqTkW+9eIfigFCRICLyvybiWUyBzGAZ7Qh5
        6FYOARZeu3KLmcYWY/uoTSZc9efbYAkc3TjXFqWHbkuYmCcAWlGOUDD6zV2o2fcj/uX0cll/RNl7a
        CDn28g/ECXlXgW1+i8Cg8XdoVkkN6p0wmtqHrpSWqR0G5H9weFBRYJ2eNN0VcV8I/jwuet0LlZ5RN
        9ni0mYYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYT9j-00H2bq-IT; Tue, 22 Aug 2023 15:18:55 +0000
Date:   Tue, 22 Aug 2023 16:18:55 +0100
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
Message-ID: <ZOTR3wJP5m6qgwaF@casper.infradead.org>
References: <20230815210659.430010-1-peterx@redhat.com>
 <ZN/tRLy0e+Iod9z3@casper.infradead.org>
 <ZOK6U4vOFn8IbcGp@x1n>
 <ZOLL7f+Ihc93lyo0@casper.infradead.org>
 <ZOOVUgsCcLx2ZxtI@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOOVUgsCcLx2ZxtI@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:48:18PM -0400, Peter Xu wrote:
> On Mon, Aug 21, 2023 at 03:29:01AM +0100, Matthew Wilcox wrote:
> > On Sun, Aug 20, 2023 at 09:13:55PM -0400, Peter Xu wrote:
> > > Setting tail mapping for tail 1/2 is even wrong, which part of this patch
> > > fixes:
> > > 
> > > @@ -428,7 +428,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
> > >  {
> > >         struct page *p = head + tail_idx;
> > > 
> > > -       p->mapping = TAIL_MAPPING;
> > > +       if (tail_idx > TAIL_MAPPING_REUSED_MAX)
> > > +               p->mapping = TAIL_MAPPING;
> > >         set_compound_head(p, head);
> > >         set_page_private(p, 0);
> > >  }
> > 
> > I didn't see this.  This is wrong.  tail->mapping is only reused for
> > large rmappable pages.  It's not reused for other compound pages.
> 
> Just to make sure we're on the same page: I think it's not only
> _deferred_list (of tail page 2) that reused the mapping field (word offset
> 3), but also _nr_pages_mapped (of tail page 1)?

I don't see how this comment is related to the part of the email you're
replying to.  But yes, prep_large_rmappable overwrites ->mapping in
two tail pages.

> > However, I have a small patch series which enables 'allnoconfig' to
> > build after renaming page->mapping to page->_mapping.  Aside from fs/
> > there are *very* few places which look at page->mapping [1].  I'll post
> > that patch series tomorrow.
> 
> Assuming it's still not yet posted; I can wait and read it.

I sent out a few patches.  Some have made it to -next already because
they're almost trivial.  Nobody's commented on the difficult one.

https://lore.kernel.org/linux-mm/20230821202016.2910321-1-willy@infradead.org/

> If you plan to remove the whole TAIL_MAPPING in a few days then I agree
> this patch is not needed, but so far I don't know when it'll land and also
> why, before that it does sound like we can still keep this patch.

This patch is putting fresh paint on a condemned building.  Just stop
it.

> Regarding the question on "why removing TAIL_MAPPING": poisoning an unused
> field is always helpful to me even if not referenced with "page->mapping".
> So I don't see an immediate benefit from removing the poisoning if it's
> already there; OTOH not sure whether poison more unused fields will be more
> helpful in general?

You are wrong.

