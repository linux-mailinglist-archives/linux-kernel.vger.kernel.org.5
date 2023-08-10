Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9686777678
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjHJLGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjHJLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:06:20 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78247211F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9NPriZJP01HOjRIFXLEdP+y7thwGzVL4AEnxIoVS/i8=; b=oEk2AnhOgVr1nINeV3I1FfSFTX
        Cd9RR2mbpi0kQF+ztEq2tX3qKvAG1wZoGwQbWlbeTjYGKyBW5dkLM3zCB4DNpJLlV/JCIaZRKkqrJ
        FhY7AcW2ph+kKi5EGKIUixD77nF+uv6COQlTwqj2JrDcC9gH9n0uLgkg1nkThN7/AvWC71gf5M2GI
        FQgeMyc3ewmxS6kY5CdDre70h+haoXR0Q2zk6xgeuVrlhs2A0M9evndNLkPR7cb3QKQj1oFiksM4B
        awO/2YVYp0eYOTwhAPXP4V3A1iFpllph420Qge6UVqa9ohrFsUJ2qlCg8CIDl+oPLgLBiZMQBwuhV
        m9cDTn7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38534)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qU3Ua-0003rc-1C;
        Thu, 10 Aug 2023 12:06:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qU3UX-0001it-Nr; Thu, 10 Aug 2023 12:06:09 +0100
Date:   Thu, 10 Aug 2023 12:06:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: dma-mapping: don't call folio_next() beyond the
 requested region
Message-ID: <ZNTEoUB7V5BtNvfp@shell.armlinux.org.uk>
References: <CGME20230810092017eucas1p23930e5e5ec443ac7776002f2f09967d4@eucas1p2.samsung.com>
 <20230810091955.3579004-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091955.3579004-1-m.szyprowski@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:19:55AM +0200, Marek Szyprowski wrote:
> Add a check for the non-zero offset case to avoid calling folio_next()
> beyond the requested region and relying on its parameters.
> 
> Fixes: cc24e9c0895c ("arm: implement the new page table range API")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> ---
>  arch/arm/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 0474840224d9..6c952d6899f2 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -715,6 +715,8 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
>  
>  		if (offset) {
>  			left -= folio_size(folio) - offset;

In most cases, "offset" is masked by ~PAGE_MASK, the only exception
being when we're walking scatterlists, where it is whatever is in
sg->offset.

So, what is the range of values that sg->offset could take? If it is
guaranteed to be less than PAGE_SIZE (or folio_size() of the first
folio) then we're all good.

However, consider what happens with the above when offset is larger
than the first folio size. To show this, let's rewrite it:

	left += offset - folio_size(folio);

In that case, "left" becomes larger than the original size, which
surely is not what we want?

This wasn't a problem with the original code, because we guaranteed
that "off" was always less than PAGE_SIZE, so

	left -= PAGE_SIZE - off;

would always result in a reduction, but this is no longer the case
with folios.

The more I'm looking at this, the more I'm convinced that the original
conversion is wrong. Let's go back to the original code and see what
it is doing:

                size_t left = size;

                pfn = page_to_pfn(page) + off / PAGE_SIZE;

This positions pfn to be the page frame number to which the page and
offset passed into the function reference.

                off %= PAGE_SIZE;

This gives us the offset _within_ that page.

                if (off) {
                        pfn++;
                        left -= PAGE_SIZE - off;
                }

What this is doing is saying if the first page is a partial page, then
we skip marking it clean - only _full_ pages get marked clean.

                while (left >= PAGE_SIZE) {
                        page = pfn_to_page(pfn++);
                        set_bit(PG_dcache_clean, &page->flags);
                        left -= PAGE_SIZE;
                }

There, we iterate over the size for the number of _whole_ pages only
and not a final partial page.

Now, if we consider the folio version:

+               ssize_t left = size;

Casts an unsigned to a signed, which will not give expected results if
large.

+               size_t offset = offset_in_folio(folio, paddr);

paddr here is the physical address of the page plus the passed in
offset. If the offset is larger than a page, then it will be the
following pages. What if the offset is larger than the first folio
size - bearing in mind that there is no limit on the offset in a
scatterlist?

If offset is bounded to the size of the folio, then that can truncate
the original "offset" that was passed in and we'll end up marking
the wrong folios, because:

+
+               if (offset) {
+                       left -= folio_size(folio) - offset;
+                       folio = folio_next(folio);
                }

This only allows us to move to the next folio.

Moreover, if offset here _is_ allowed to be bigger than folio_size()
then we end up _increasing_ "left" as stated above, so we end up
marking _more_ folios as clean than the user of this function requested.

+
+               while (left >= (ssize_t)folio_size(folio)) {
+                       set_bit(PG_dcache_clean, &folio->flags);
+                       left -= folio_size(folio);
+                       folio = folio_next(folio);
                }

So, in all, to me it looks like this conversion is basically wrong, and it
needs to be something like:

		size_t left = size;

		while (off >= folio_size(folio)) {
			off -= folio_size(folio);
			folio = folio_next(folio);
		}
		if (off) {
			/* Partial first folio */
			size_t first = folio_size(folio) - off;

			/* Size doesn't extend the full folio size, so exit */
			if (left < first)
				return;

			/* Truncate the size and move to the next folio */
			left -= first;
			folio = folio_next(folio);
		}

		while (left >= folio_size(folio)) {
			/* can't become negative */
			left -= folio_size(folio);
			set_bit(PG_dcache_clean, &folio->flags);
			if (!left)
				break;
			folio = folio_next(folio);
		}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
