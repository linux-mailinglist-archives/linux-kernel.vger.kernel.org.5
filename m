Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47418096D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjLGX5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjLGX5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:57:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2023E1720;
        Thu,  7 Dec 2023 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YO6MVl02oBiITEYrEywlC3LVDyTUqOlWipn5vN0fmhA=; b=gqhWqtmpvP9SALAF/Q1zmqoGHm
        HxMwUKrMpAPGfReElYZa/S3TvjzUkkyxt10c7razZ5wU/hSxDRc3RN+qkzI4JtEhv37wXZd9YSbbS
        jmePUN0WrspPoPUXkxLQOf7YyHxFy1OiHeXOzAdUxMBynWUHg342NjmGGP19/c1f9GAzvI+qJMQYw
        n4937Xk5nGkIBOJPaceqsLyaBJkOgp/i2Yeaa/1eCg4UW6P61UajreLPS91lO2endUQfeifDbnTti
        kRHruEUK3J0P+gpL56LlxdthWqnXJR3WCc6ztejMQz4wuBkPMZW5ovM7EQDeY0a9vMaw1w0ZXJUcU
        e9k8dAbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBOEp-004cCW-JH; Thu, 07 Dec 2023 23:57:03 +0000
Date:   Thu, 7 Dec 2023 23:57:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-ID: <ZXJbz2F6xi/ZGnsP@casper.infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
 <ZXJCxbAm1_V7lPnF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJCxbAm1_V7lPnF@kbusch-mbp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:10:13PM -0700, Keith Busch wrote:
> On Mon, Aug 14, 2023 at 03:41:00PM +0100, Matthew Wilcox (Oracle) wrote:
> >  void __bio_release_pages(struct bio *bio, bool mark_dirty)
> >  {
> > -	struct bvec_iter_all iter_all;
> > -	struct bio_vec *bvec;
> > +	struct folio_iter fi;
> > +
> > +	bio_for_each_folio_all(fi, bio) {
> > +		struct page *page;
> > +		size_t done = 0;
> >  
> > -	bio_for_each_segment_all(bvec, bio, iter_all) {
> > -		if (mark_dirty && !PageCompound(bvec->bv_page))
> > -			set_page_dirty_lock(bvec->bv_page);
> > -		bio_release_page(bio, bvec->bv_page);
> > +		if (mark_dirty) {
> > +			folio_lock(fi.folio);
> > +			folio_mark_dirty(fi.folio);
> > +			folio_unlock(fi.folio);
> > +		}
> > +		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> > +		do {
> > +			bio_release_page(bio, page++);
> > +			done += PAGE_SIZE;
> > +		} while (done < fi.length);
> >  	}
> >  }
> 
> Is it okay to release same-folio pages while creating the bio instead of
> releasing all the pages at the completion? If so, the completion could
> provide just the final bio_release_page() instead looping. I'm more
> confirming if that's an appropriate way to use folios here.

For this patch, I'm just replicating the existing behaviour.  We can
probably do much better.  Honestly, the whole thing is kind of grotesque
and needs to be reformed ... but I think that's part of the physr project.
