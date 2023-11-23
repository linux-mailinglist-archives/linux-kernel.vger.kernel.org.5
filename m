Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2D7F6340
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbjKWPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbjKWPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:47:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA0DC1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vasH22+ZqE7NawyIR92P5uPhDSRcq1ysNxbjToJ1LBY=; b=vLpbgGizfUkL6qUgpsivl4JAm/
        l8J8tNyrQHt5ij+7+mH22jvJHwKDnm15G+Y8yMTDvxK5gRlnADcaWJ0gGwXnEL+X6/fGctU+gIkgH
        i7e0bTPjn5mArHPGmVnZ3Sd4irNBwcAJX3hcvaGLJPXbWqYn15n3uPyDZxtwkLGiuzrZBSL0W3h7g
        0NnaVmbnZK083gVv5tpkKKqa2NiGaBEqg1aGsZitgcpovI9OR2AvH5HpmcbdwkXTFME1UrDr2MgzP
        GZEnBpDtPaOAgDKKUAZp8G4YTEUeZWMFnI74HVPypN/duW75NVuUCoPbRlM89yKGH7bN101Tg5qlt
        qowOlYxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6Bvh-007gJ1-SR; Thu, 23 Nov 2023 15:47:49 +0000
Date:   Thu, 23 Nov 2023 15:47:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV90JcnQ1RGud/0R@casper.infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV21GCbG48nTLDzn@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:00:24AM -0800, Christoph Hellwig wrote:
> > The other option is I can always add a comment above gup_huge_pd()
> > explaining this special bit, so that when someone is adding hugepd support
> > to file large folios we'll hopefully not forget it?  But then that
> > generalization work will only happen when the code will be needed.
> 
> If dropping the check is the right thing for now (and I think the ppc
> maintainers and willy as the large folio guy might have a more useful
> opinions than I do), leaving a comment in would be very useful.

It looks like ARM (in the person of Ryan) are going to add support for
something equivalent to hugepd.  Insofar as I understand hugepd, anyway.
I've done my best to set up the generic code so that the arch code can
use whatever size TLB entries it supports.  I haven't been looking to the
hugetlb code as a reference for it, since it can assume natural alignment
and generic THP/large folio must be able to handle arbitrary alignment.

If powerpc want to join in on the fun, they're more than welcome, but I
get the feeling that investment in Linux-on-PPC is somewhat smaller than
Linux-on-ARM these days.  Even if we restrict that to the server space.
