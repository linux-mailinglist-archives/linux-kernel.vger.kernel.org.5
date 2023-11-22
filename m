Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3411F7F3F62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjKVIAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKVIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:00:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A099D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rG9CnI6rb1E9NFvnbYt1RG2l2gXTlO1XMx7PoiRe2Ec=; b=PCtBrTBvxv7SOp8UE5vFdvbfF0
        P5NaPlXmpvqNViNINDPdipO0w9S7846a/jfPx/chfTBwwTwYjneEH25vRgUw635dBIYYVnMCDmiM6
        OeTvKWjvS5RPTRtLFJM8VWWVC1A3xvPIQ+lpajb19q+Chh4kjK5j81FkX1DAOmUYdLz8CY2/xQjU/
        eHO+ESOk90z7nvlFOUb/rkbJstkzzg3x3vrH7Vvfk96TWlMZ6TRu1MnpeRKEUoHL7WMK53ciD/Y6Q
        bdvOGQ2aAG+0OYv9E7rZOWLEOZLfUmhAOJwT7XbQn2p/6gB5NGOg/D88uulBsscSZ7PfrfCGM1nAw
        u/zzeo7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5i9o-000z5V-1I;
        Wed, 22 Nov 2023 08:00:24 +0000
Date:   Wed, 22 Nov 2023 00:00:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV21GCbG48nTLDzn@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzT5_3Zn-Y-6xth@x1n>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:59:35AM -0500, Peter Xu wrote:
> > What prevents us from ever using hugepd with file mappings?  I think
> > it would naturally fit in with how large folios for the pagecache work.
> > 
> > So keeping this check and generalizing it seems like the better idea to
> > me.
> 
> But then it means we're still keeping that dead code for fast-gup even if
> we know that fact..  Or do we have a plan to add that support very soon, so
> this code will be destined to add back?

The question wasn't mean retorical - we support arbitrary power of two
sized folios for the pagepage, what prevents us from using hugepd with
them right now?

> The other option is I can always add a comment above gup_huge_pd()
> explaining this special bit, so that when someone is adding hugepd support
> to file large folios we'll hopefully not forget it?  But then that
> generalization work will only happen when the code will be needed.

If dropping the check is the right thing for now (and I think the ppc
maintainers and willy as the large folio guy might have a more useful
opinions than I do), leaving a comment in would be very useful.

