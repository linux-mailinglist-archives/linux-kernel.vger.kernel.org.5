Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003D7F592D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjKWHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjKWHZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:25:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E8112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ymXPGuek+YUqZ+cTCcWRVVyz0cUPzd9VJqoG6IBQ/u4=; b=tx/ec7GkHS3eCYwtH2GmMOqqQH
        vJwfb1p3YMwuJucI9f24yWXTOuXlv16U5ABtNAWfbYM3l9VQ4KNAFXCy55GtyJPRtjpF+pv5T9c+C
        O6QfeD4T8jkLP1/k0QfO1nQUnMFlbMu1emuchcXz1YZagsxJPYwezcj3w8fXn+ZOEIbo4njJky9ZH
        w52qMOU9PA3XZDKZlWmT5NLCqpbXvcnm9VhbAtrG2I9GK3K63xxyykPsu8gUQK7ROwjXn1qwsjaRJ
        VhiKotQ5/IDWnZE5ATkI/Oh8Wto+GgF+H+uXU44f39S9g1ALAzWmxnaGj9cZRaNyo6Z+IdL+HjCUH
        iOF81E3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r645Y-0041tu-0V;
        Thu, 23 Nov 2023 07:25:28 +0000
Date:   Wed, 22 Nov 2023 23:25:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 05/12] mm/gup: Fix follow_devmap_p[mu]d() to return
 even if NULL
Message-ID: <ZV7+aP8x0aFE4D57@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-6-peterx@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:29:01PM -0500, Peter Xu wrote:
> This seems to be a bug not by any report but by code observations.
> 
> When GUP sees a devpmd or devpud, it should return whatever value returned
> from follow_devmap_p[mu]d().  If page==NULL returned, it means a fault is
> probably required.  Skipping return the NULL should allow the code to fall
> through, which can cause unexpected behavior.
> 
> It was there at least before the follow page rework (080dbb618b) in 2017,
> so 6 years.  Not yet digging for a Fixes, assuming it can hardly trigger
> even if the logical bug does exist.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

I'd still add a fixes tag and send if off to Linux for 6.7-rc instead
of letting it linger.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
