Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBA7E4997
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjKGUIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjKGUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:08:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49FFD7E;
        Tue,  7 Nov 2023 12:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u01JIqVzaSf8TF8G4BYOMmURcC23GrYXwrlghebzjfQ=; b=CI7nr3Mdn1TfJDk6UKyDLm5nec
        het5KZgVo64urTH2eiMoc6tK4DwIIR9kc+R78QDpAdMOOU2qxnNiyJ/DegmZFq+O1bQfZoYFpaHr6
        Hhfx+QIq8PGImFUefq6+UPK4PQ2yAfZP5xT8UVGRG0dDAHAmAkhoDKSl9K+8WkWNTSXKmKVHje1qw
        Rt4DzJEoBRBUmqK0rt/gPohq1y709lkgz021U0mCSOZrPQgPY2OMnKklxAK0wwLCSPYleAy8jMtBW
        JJcS4ywoBxVvM/EkHeCuQ/s/Z2bPLHWdxbyC0l02vHMzI8ar/OaM9RNGrWgqIm2m0AJjtxR4IsPh/
        O4KeMOTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0SMh-00EHv8-LH; Tue, 07 Nov 2023 20:07:59 +0000
Date:   Tue, 7 Nov 2023 20:07:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        akpm@linux-foundation.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <ZUqZH2jUgrYeCY3z@casper.infradead.org>
References: <20231107181805.4188397-1-shr@devkernel.io>
 <ZUqRia1Ww0+wNfKr@casper.infradead.org>
 <20231107200616.GA3797353@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107200616.GA3797353@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:06:16PM -0500, Johannes Weiner wrote:
> On Tue, Nov 07, 2023 at 07:35:37PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 07, 2023 at 10:18:05AM -0800, Stefan Roesch wrote:
> > > +++ b/mm/huge_memory.c
> > > @@ -2740,7 +2740,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> > >  			if (folio_test_swapbacked(folio)) {
> > >  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
> > >  							-nr);
> > > -			} else {
> > > +			} else if (folio_test_pmd_mappable(folio)) {
> > >  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
> > >  							-nr);
> > >  				filemap_nr_thps_dec(mapping);
> > 
> > As I said, we also need the folio_test_pmd_mappable() for swapbacked.
> > Not because there's currently a problem, but because we don't leave
> > landmines for other people to trip over in future!
> 
> Do we need to fix filemap_unaccount_folio() as well?

Looks to me like it is already correct?

        __lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
        if (folio_test_swapbacked(folio)) {
                __lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
                if (folio_test_pmd_mappable(folio))
                        __lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
        } else if (folio_test_pmd_mappable(folio)) {
                __lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
                filemap_nr_thps_dec(mapping);
        }

