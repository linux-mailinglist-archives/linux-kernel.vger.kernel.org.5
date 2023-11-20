Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39A07F0D78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjKTI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:26:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961EB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uMp2fMZBMPCr8C/u9KI5jUF0TwPRUJ/bxniQfy1HXoM=; b=p0fDRvzTKV43hpBu0+sr2+Pz73
        TZn39hehC2t56EK4IteS4aWT9jFaZ/21cuIc5qudV4m5Ud+NRJkwVpbq8c5J8qHTSB4a6MmJfMGQb
        UGdRc0QuQs7kP/u7CJn7pQQtY6YQ+YaY49Y8BXDregSPUnGGmRCcKYJDAwMO83hqWydxfVubHETSQ
        msAyW9/Ot5qrWxGUV5lWqNKOg6V804Rw4GUzSg+z910mQcNCcEQonRyGMY/ioEsmhcR9b9WezX2IK
        SZhguB0DFZGf+XBBLeKDx4/juMQhOMdzferrd/qZg8BsBikUOtQtsfl/e4DPxBeXe6NnJIRnwm8xr
        dyfRwizg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r4zbs-00BVBv-2U;
        Mon, 20 Nov 2023 08:26:24 +0000
Date:   Mon, 20 Nov 2023 00:26:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Message-ID: <ZVsYMMJpmFV2T/Zc@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-7-peterx@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:29:02PM -0500, Peter Xu wrote:
> Hugepd format is only used in PowerPC with hugetlbfs.  In commit
> a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
> file-backed mappings"), we added a check to fail gup-fast if there's
> potential risk of violating GUP over writeback file systems.  That should
> never apply to hugepd.
>
> Drop that check, not only because it'll never be true for hugepd, but also
> it paves way for reusing the function outside fast-gup.

What prevents us from ever using hugepd with file mappings?  I think
it would naturally fit in with how large folios for the pagecache work.

So keeping this check and generalizing it seems like the better idea to
me.
