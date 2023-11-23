Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DAF7F5936
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjKWH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjKWH20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:28:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F7100
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cFIZx1yogxTLlZGRvld5KeeBDD9lT1xUio7I+xCLOyU=; b=HGn9w41HrtRpenjpgTwuLAegI6
        XIG0w7jdu0ZjPjA50rnWjFlSrNtpbnWBwNAv8EY4b2qvqCe9MC1/0SHjwRBHnvkgWI2HYP7om3Ex+
        OmkmxRqaxLOzO1gTDA/LZEfpucHPdqy62+SQFQZTAs6R79wcvhTauyGD+OkxIx96R92nAqse9/tvc
        25sSai1Z8cX30vfR+DFAfCqW76EwOQJHAAtfP8QQRvVMrQ14lJJr46uyE4PwhtQNiQupZYAF/0vvK
        GAnWrqUv1KmKtHQjpPrylCqMaWB4D0AZyc6iyTwxsoX8HKWxT5DoAa0rU/j4CwP9rLx1lczhI36IL
        nlqpw0kw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r648V-0042Sy-0z;
        Thu, 23 Nov 2023 07:28:31 +0000
Date:   Wed, 22 Nov 2023 23:28:31 -0800
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
Subject: Re: [PATCH RFC 09/12] mm/gup: Handle huge pud for follow_pud_mask()
Message-ID: <ZV7/H6zTYodxVNl0@infradead.org>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116012908.392077-10-peterx@redhat.com>
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

> We need to export "struct follow_page_context" along the way, so that
> huge_memory.c can understand it.

Again, thankfully not actually exported, just made global.

> @@ -751,24 +746,25 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>  				    unsigned int flags,
>  				    struct follow_page_context *ctx)
>  {
> -	pud_t *pud;
> +	pud_t *pudp, pud;

This adding of pud while useful seems mostly unrelated and clutter
the patch up quite a bit.  If you have to respin this anyway it might
be worth to split it out into a little prep patch.

