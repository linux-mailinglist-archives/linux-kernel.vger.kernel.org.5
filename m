Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60B9763CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGZQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjGZQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:45:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86912D4B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ffylz1uSDobu0cDe/+ol0i31EM3nl1BynfNdms0slZc=; b=MeDYCY3TCPK1hNuburzA798uN2
        9fiomyfW0Yl8idOiy2Fr6RaeMcXeMKgMKCzfABamLPZSJsaXqe3lflR3Ao8XJo7hv6RCyktjKGyNv
        F6D7dBbE4LpEZIOwos7xPVBZzDFgdP2S3Aj5AZ5lYCdUv0/WUulUNCoUb/u+Klv/SwKIUsuCXYrWK
        OJdfTymAd49aKh3IfJEl38VXhyyfuT1vteFdlLaMatdLzQsf4HIiusFz+9iKgQ3We/KAU4Qfz/KFB
        T0TDOyDsr3A6HmoVUVuZInrJX4ZoAZgaPzqCGiEDW41zFd/KG/+zFviUe2XV//jvJYk7ZdL7N7Lnx
        eM9Ct09w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOhd4-006f6o-Tm; Wed, 26 Jul 2023 16:44:50 +0000
Date:   Wed, 26 Jul 2023 17:44:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
Message-ID: <ZMFNgmlT1JpI0z5+@casper.infradead.org>
References: <20230720112955.643283-1-ryan.roberts@arm.com>
 <20230720112955.643283-3-ryan.roberts@arm.com>
 <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:53:26PM -0600, Yu Zhao wrote:
> > +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> > +               int nr, struct vm_area_struct *vma);
> 
> I prefer folio_remove_rmap_range(page, nr, vma). Passing both the
> folio and the starting page seems redundant to me.
> 
> Matthew, is there a convention (function names, parameters, etc.) for
> operations on a range of pages within a folio?

We've been establishing that convention recently, yes.  It seems
pointless to re-derive the folio from the page when the caller already
has the folio.  I also like Ryan's point that it reinforces that all
pages must be from the same folio.

> And regarding the refactor, what I have in mind is that
> folio_remove_rmap_range() is the core API and page_remove_rmap() is
> just a wrapper around it, i.e., folio_remove_rmap_range(page, 1, vma).
> 
> Let me post a diff later and see if it makes sense to you.

I think that can make sense.  Because we limit to a single page table,
specifying 'nr = 1 << PMD_ORDER' is the same as 'compound = true'.
Just make it folio, page, nr, vma.  I'd actually prefer it as (vma,
folio, page, nr), but that isn't the convention we've had in rmap up
until now.
