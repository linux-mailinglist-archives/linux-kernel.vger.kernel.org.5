Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1137E784840
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjHVRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHVRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:12:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1689CFF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pAvdzBr8xJbkKP9oGhwJOhkcjpuEd8zfm5pqt9FtdRs=; b=Ekgm6EikmR6wKxMWvcB5lAVHZ/
        zawmmDfz/wu1BrkzlQ8UHJuvsLyQtemb2FLLRSqAE2KClRiAuT/k0scuv438iGVvV8L1mQTRuHRWO
        Shsqm2mDcbzwB30feJKklUNzNbpwc8jrgvxcv0QCRlVxDY4v1bzeBmmewrsd7tnEQXONbsmXunzLQ
        su8FI2nZL7i61j+44TosPFs9DXpjd4bLTTXKiscLeV2oDz0TiWHSylDwNgEbiaTNyUfXMg5Zl5JK0
        vsZ1ob2lV0EdArVXGwa0aNNxXD2xuTOXm8ylHBj+yDppn2CgYsz5gtfEaWNzAcnIL90w2RpPTvMq3
        EwYSaX8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYUvK-00HVGo-83; Tue, 22 Aug 2023 17:12:10 +0000
Date:   Tue, 22 Aug 2023 18:12:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: dma-mapping: don't call folio_next() beyond the
 requested region
Message-ID: <ZOTsamBusDJu7wY0@casper.infradead.org>
References: <CGME20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4@eucas1p2.samsung.com>
 <20230810091955.3579004-1-m.szyprowski@samsung.com>
 <ZNTEoUB7V5BtNvfp@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNTEoUB7V5BtNvfp@shell.armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:06:09PM +0100, Russell King (Oracle) wrote:
> However, consider what happens with the above when offset is larger
> than the first folio size. To show this, let's rewrite it:

Hmm.  I thought 'off' had to be smaller than PAGE_SIZE.

> So, in all, to me it looks like this conversion is basically wrong, and it
> needs to be something like:
> 
> 		size_t left = size;
> 
> 		while (off >= folio_size(folio)) {
> 			off -= folio_size(folio);
> 			folio = folio_next(folio);
> 		}


We can jump straight to the first folio without iterating over the
folios in between.  Like so:

static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
        size_t size, enum dma_data_direction dir)
{
        phys_addr_t paddr = page_to_phys(page) + off;

...

        if (dir != DMA_TO_DEVICE && size >= PAGE_SIZE) {
                struct folio *folio = pfn_folio(paddr / PAGE_SIZE);
                size_t offset = offset_in_folio(folio, paddr);

                for (;;) {
                        size_t sz = folio_size(folio) - offset;

                        if (size < sz)
                                break;
                        if (!offset)
                                set_bit(PG_dcache_clean, &folio->flags);
                        offset = 0;
                        size -= sz;
                        if (!size)
                                break;
                        folio = folio_next(folio);
                }
        }

Advantages:
 * No more signed arithmetic
 * Not even an intended arithmetic overflow
 * Only one call to folio_size() per loop
 * Folded the first conditional into the loop

Disadvantages:
 * Some maintainers don't like a for (;;) loop, or a two-exit loop.
   (we could remove the for (;;) by moving 'sz' outside the loop and
    recalculating it at the end of the loop)
