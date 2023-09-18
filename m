Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC47A4CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIRPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIRPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:39:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B205BBA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3W2iG96sXNpt+qL0wzYfxSEXfbU14HH4BwI31ALCsRw=; b=kJFx1xc5KRX1gV3ixQPahDa8xR
        NtVwdG/6RbvBONC1WcD4awRPsWs2+LNGyk1IggDwHPiMU7RRQaenz9+vX0oEHENWHINZp+v7dbwkh
        Z6GsbkePAG+7zVqxxZWEVc601prwTO+DOWJA1fEHoqOW7tBjnqAddom0oo4qQXI4LHELhLgb10t7R
        +YSuEXa5eRNBt8AQL+DNBMM9l3/M763b87c8vmx+RS+wowL5EB3+pcF1Q0oYDHOYnQ967Yn9brtkU
        Efh68kGF86lUYZJrdC+3gKnX0/1WbRwdNxrs9ndowe3ynz1/a+9TCfsE5/xpNxdiL6t/H9VySTLSF
        ghTWBO/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiFdE-00Bd02-Dp; Mon, 18 Sep 2023 14:53:48 +0000
Date:   Mon, 18 Sep 2023 15:53:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Message-ID: <ZQhkfIqwcuTrKxK+@casper.infradead.org>
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZPCpQQVTtlB0FA5A@casper.infradead.org>
 <ZPs8+sLv5oaubrKj@casper.infradead.org>
 <22a42774-ebe1-081a-c9b9-e11f4d74bc3a@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a42774-ebe1-081a-c9b9-e11f4d74bc3a@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:15:05PM +0200, Mirsad Todorovac wrote:
> > This is what I'm currently running with, and it doesn't trigger.
> > I'd expect it to if we were going to hit the KCSAN bug.
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 0c5be12f9336..d22e8798c326 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4439,6 +4439,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
> >   	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
> >   out:
> > +	VM_BUG_ON_PAGE(page && (page->flags & (PAGE_FLAGS_CHECK_AT_PREP &~ (1 << PG_head))), page);
> >   	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
> >   	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
> >   		__free_pages(page, order);
> 
> Hi,
> 
> Caught another instance of this bug involving folio_batch_move_lru: I don't seem that I can make it
> happen reliably by the nature of the data racing conditions if I understood them well.

Were you running with this patch at the time, or was this actually
vanilla?  The problem is that, if my diagnosis is correct, both of the
tasks mentioned are victims; we have a prematurely freed page.  While
btrfs is clearly a user, it may not be btrfs's fault that the
page was also allocated as an anon page.

I'm trying to gather more data, and running with this patch will give
us more -- because it'll dump the entire struct page instead of just
the page->flags, like KCSAN is currently doing.

