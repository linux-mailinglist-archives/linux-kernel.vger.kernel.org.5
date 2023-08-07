Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC07732D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjHGWOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHGWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:14:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D060C12D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=48c2F3MjJvgi4JWSUMqr70/KHIBFgCs30cp0A4pwjRU=; b=GTVKHz/r5C5WjK0DjgEdumh5v7
        zPVgeXuSkyIE1p4x+hvY5SRDjLRYR7wVdxWcs9v/1nfutaB0atPqAOfCszdUE28AMj2CbQBlhhTJK
        kxKTTz71f/F9+703baKo2kOmgdo9ywbl25NY2IFt9VNfAvs49rwfKP/LLG0Td/T924jAEw7BcE0gn
        UaqV5xCgN4kpi1P0Eam7fBW2pUeLNB5dVyYOaYJ2Wcg5i8otE69nTKaxOmUbLvPDaY/ITBgIu/+ML
        ew1VBhlrVvCRw/JqAwMU50KNpKFKAs1DpPgWLzqXCNsvsMaqdD2eojQ2cUmsxeq0IkA9TVMC1/Zsu
        5d6Kmlwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qT8UP-00DgvF-IT; Mon, 07 Aug 2023 22:14:13 +0000
Date:   Mon, 7 Aug 2023 23:14:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Message-ID: <ZNFstXmztIriaKOX@casper.infradead.org>
References: <CGME20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e@eucas1p1.samsung.com>
 <20230807152657.1692414-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807152657.1692414-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:26:57PM +0200, Marek Szyprowski wrote:
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 70cb7e63a9a5..02250106e5ed 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -718,7 +718,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
>  			folio = folio_next(folio);
>  		}
>  
> -		while (left >= (ssize_t)folio_size(folio)) {
> +		while (left && left >= (ssize_t)folio_size(folio)) {
>  			set_bit(PG_dcache_clean, &folio->flags);
>  			left -= folio_size(folio);
>  			folio = folio_next(folio);

I've been thinking about this and I think this is the right fix for the
wrong reason.  I don't understand how it can produce the failure you
saw, but we shouldn't be calling folio_next() if left is zero, let alone
calling folio_size() on it.  So I'd rather see this fix:

		while (left >= (ssize_t)folio_size(folio)) {
			set_bit(PG_dcache_clean, &folio->flags);
			left -= folio_size(folio);
+			if (!left)
+				break;
			folio = folio_next(folio);
		}
