Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757407E6F88
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjKIQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbjKIQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:40:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AFC35BB;
        Thu,  9 Nov 2023 08:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J7QLDd9OVD4borN5mRbVxHh9xbWC1S+rfDDIxHA2HVc=; b=NJ+FVUSNgGAXqK2bnR5QovhKuJ
        SGAsYgYFG62E9WIIC+Rh0oPxLYQot5hdfUbB2u+Z66KpHStHt6CteqrK+wIqmA1jEuzci0gBuqg1E
        oqa/JIKqykkKDNrGckF09G49iW0MGmO37jC+GJHyCutxmprEyinQ42jA0jBP5CePH9u/7ziChYJGX
        zgMrHbD0/QWi9xMl1oYh2fu0ISjCbEFrN94BENwMiBfXV62x26FCVb/wreHfAx0ooEdHT8akQYbya
        BACBHZyueDEmfkMBBkV6GXDIqMFNY1XQiKZIMQaTlVVcI+ZjuDKI13gHQRRZl36MYsqRQr8aY1WI0
        mvzSRpaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r183F-008Ipm-Te; Thu, 09 Nov 2023 16:38:41 +0000
Date:   Thu, 9 Nov 2023 16:38:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     jeff.xie@linux.dev
Cc:     Jeff Xie <xiehuan09@gmail.com>, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn
Subject: Re: [RFC][PATCH 1/4] mm, page_owner: add folio allocate post
 callback for struct page_owner to make the owner clearer
Message-ID: <ZU0LEYfu01W6sQLR@casper.infradead.org>
References: <ZUz8kTx1eNQkkbFc@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-2-jeff.xie@linux.dev>
 <ZUzl0U++a5fRpCQm@casper.infradead.org>
 <CAEr6+EB5q3ksmgYruOVngiwf6KJcrzABchd=Osyk0MiVDGQyQQ@mail.gmail.com>
 <58d4f340549dd69a5d605c1526ceceb035b3cc98@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d4f340549dd69a5d605c1526ceceb035b3cc98@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:04:39PM +0000, jeff.xie@linux.dev wrote:
> November 9, 2023 at 11:36 PM, "Matthew Wilcox" <willy@infradead.org> wrote:
> > But we want that anyway (or at least I do). You're right that vmalloc
> > pages are not marked as being vmalloc pages and don't contain the
> > information about which vmalloc area they belong to. I've talked about
> > ways we can add that information to folios in the past, but I have a lot
> > of other projects I'm working on. Are you interested in doing that?
> >
> 
> Certainly, I'm willing to give it a try. If a folio can include vmalloc information
> or more information, this is great. I may need to understand the background of why
> you proposed this method in the past.

I can't find the proposal now, but it's basically this:

Turn PG_slab into a PG_kernel.  If PG_kernel is set, then other flags
change their meaning.  Flags that should be reusable: writeback,
referenced, uptodate, lru, active, workingset, private, reclaim

One of those flags gets reused to be the new slab.  So, eg
folio_test_slab() becomes:

	return (folio->flags & (PG_kernel | PG_slab)) == (PG_kernel | PG_slab);

Now we have somewhere that we can use for PG_vmalloc (also PG_reserved
can become a PG_kernel sub-flag, freeing up a page flag).

We'd need to change some helpers.  eg folio_mapping() currently does:

        if (unlikely(folio_test_slab(folio)))
                return NULL;

and that should be:

	if (unlikely(folio_test_kernel(folio)))
		return NULL;

With that in place, we can reuse the folio->mapping space to point to
the struct vm_struct that allocated it.

This isn't an easy project and will require a lot of testing.  It has
some upsides, like freeing up a page flag.
