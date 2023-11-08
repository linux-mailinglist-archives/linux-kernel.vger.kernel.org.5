Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329E7E5841
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKHN74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjKHN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:59:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B31A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E2O8VEEm0jssDUttytoq4gF0X536yxn5CittkkXinDY=; b=taDVlVfb0ZvzQBIGoimggn2HhN
        aywdIbEU3WPA+RNBnrT4lH/xD2LubL2z/dzzO989G4tmnvntHwJwZ0hj1hw8hINwvggOt5dIO6AAj
        byzsCMVYAc4mRGZUX4vgJYeHofG4OQnFs2BfUQDCBemSQNomku6VMeiQFEk5S2nXrUHfRVzFXB6Mc
        77B0eIqnHkUrBR/cSP84yR55ktsGmKbcX/r8zzPH9xGSia9xOa9GVdTnu1ETrBqSPthg602NPYO8M
        WCA+PlCCSQdX348qlzM2sUNp3MqAi01EPT8hHm6cUQpGUBCCtZ/tLzZaVCFevWkktgeR4tAwg4f/h
        gFeVLgHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0j5w-001MjC-Gq; Wed, 08 Nov 2023 13:59:48 +0000
Date:   Wed, 8 Nov 2023 13:59:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/6] mm: ksm: use more folio api in
 ksm_might_need_to_copy()
Message-ID: <ZUuUVDbiWETJ2OU1@casper.infradead.org>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-2-wangkefeng.wang@huawei.com>
 <ZUpIlkO0E7+i2hCg@casper.infradead.org>
 <81e0289c-225c-4468-959c-937d3678cb2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e0289c-225c-4468-959c-937d3678cb2d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 09:40:09AM +0800, Kefeng Wang wrote:
> 
> 
> On 2023/11/7 22:24, Matthew Wilcox wrote:
> > On Tue, Nov 07, 2023 at 09:52:11PM +0800, Kefeng Wang wrote:
> > >   struct page *ksm_might_need_to_copy(struct page *page,
> > > -			struct vm_area_struct *vma, unsigned long address)
> > > +			struct vm_area_struct *vma, unsigned long addr)
> > >   {
> > >   	struct folio *folio = page_folio(page);
> > >   	struct anon_vma *anon_vma = folio_anon_vma(folio);
> > > -	struct page *new_page;
> > > +	struct folio *new_folio;
> > > -	if (PageKsm(page)) {
> > > -		if (page_stable_node(page) &&
> > > +	if (folio_test_ksm(folio)) {
> > > +		if (folio_stable_node(folio) &&
> > >   		    !(ksm_run & KSM_RUN_UNMERGE))
> > >   			return page;	/* no need to copy it */
> > >   	} else if (!anon_vma) {
> > >   		return page;		/* no need to copy it */
> > > -	} else if (page->index == linear_page_index(vma, address) &&
> > > +	} else if (page->index == linear_page_index(vma, addr) &&
> > 
> > Hmm.  page->index is going away.  What should we do here instead?
> 
> Do you mean to replace page->index to folio->index, or kill index from
> struct page?

I'm asking you what we should do.

Tail pages already don't have a valid ->index (or ->mapping).
So presumably we can't see a tail page here today.  But will we in future?

Just to remind you, the goal here is:

struct page {
	unsigned long memdesc;
};

so folios will be the only thing that have a ->index.  I haven't looked
at this code; I know nothing about it.  But you're changing it, so you
must have some understanding of it.
