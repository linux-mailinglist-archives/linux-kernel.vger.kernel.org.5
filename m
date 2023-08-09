Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F22776AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjHIVO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjHITVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:21:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBEB4493;
        Wed,  9 Aug 2023 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V6aw3cKsEAtcteG5TsVfLRgpt+DuKUB5RKFqkVnPpSE=; b=lsUxQcuWgOl6iSPOALnYzG0wD2
        LrOSFUpTYzRV2I7TU5dEJ6WhDAMXvaHNrHA7jsmh7FirTeooUWNl06NukygzHox9aG34P/umosboi
        NzK4MRv0KQb+H2+de/XnOqWVFFCLY0z8SJJnOEE9dj3ESBZf38CMe55j8CIxFekqBMuQ2M5asPan2
        vyFsomoxYkhgRpoCb4rQHpuA5eM+b2i3usPxfRMfN5o4Vi7d9OMWfer5oZSvs7IbzTNR9FzrsuV3K
        jp5E14YVTVI/bGT8STIPcApoP+jVIkqCUNCFb1DvtD0iMjux2Xmcd3wrmz8w255nTjze/GHMB6qr2
        u+rEebWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTok8-007x7J-SP; Wed, 09 Aug 2023 19:21:16 +0000
Date:   Wed, 9 Aug 2023 20:21:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNPnLGNCnt5lfdy8@casper.infradead.org>
References: <20230809083256.699513-1-david@redhat.com>
 <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:07:43PM +0100, Ryan Roberts wrote:
> > +++ b/mm/hugetlb.c
> > @@ -1479,7 +1479,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
> >  	struct page *p;
> >  
> >  	atomic_set(&folio->_entire_mapcount, 0);
> > -	atomic_set(&folio->_nr_pages_mapped, 0);
> > +	atomic_set(&folio->_total_mapcount, 0);
> 
> Just checking this is definitely what you intended? _total_mapcount is -1 when
> it means "no pages mapped", so 0 means 1 page mapped?

We're destroying the page here, so rather than setting the meaning of
this, we're setting the contents of this memory to 0.


Other thoughts that ran through my mind ... can we wrap?  I don't think
we can; we always increment total_mapcount by 1, no matter whether we're
incrementing entire_mapcount or an individual page's mapcount, and we
always call folio_get() first, so we can't increment total_mapcount
past 2^32 because folio_get() will die first.  We might be able to
wrap past 2^31, but I don't think so.

I had some other thoughts, but I convinced myself they were all OK.
