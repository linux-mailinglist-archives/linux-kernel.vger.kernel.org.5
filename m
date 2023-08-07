Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9F77330D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHGWqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHGWqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:46:17 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276CFE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DMAmkq+Z8+wqHN2hP7Ew/2ByzL7++kUWTu18KZLXSgw=; b=NVMn7DddBbFdq1vo2tm/Nu9M3o
        6vfm9FQpSkkV31ClPcghujps2gR8aT0/hfPlZiGXbGQK2V7NXQQee+90QD17TzZuaSBxwTKXNcEaS
        xI+yJjIXwr/xatIfPSQzk/8NVotjWJ9tsu4HBlIqKPpn24JUdOVW9rTgfs2wHznIgabHkjN4Esx47
        jgYAEv6K/H3z74YzzunIRpixbMp9GwCQ5LDSmE+AT2N+gCviaLt3PuJEA5nb1G1TbDzBv+tEHJ4hc
        XuhfKCx0aTZ6F4CHZbx9t08mcjromf0foM4lFo+NweciAHCv6Y5uAKIDgJBen0GlyRiIF3LYTK3+N
        6ESlSrdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58376)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qT8zG-0005r6-2d;
        Mon, 07 Aug 2023 23:46:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qT8zF-0007RD-MZ; Mon, 07 Aug 2023 23:46:05 +0100
Date:   Mon, 7 Aug 2023 23:46:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Message-ID: <ZNF0LUrtoCp+aS5U@shell.armlinux.org.uk>
References: <CGME20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e@eucas1p1.samsung.com>
 <20230807152657.1692414-1-m.szyprowski@samsung.com>
 <ZNFstXmztIriaKOX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNFstXmztIriaKOX@casper.infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:14:13PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 07, 2023 at 05:26:57PM +0200, Marek Szyprowski wrote:
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 70cb7e63a9a5..02250106e5ed 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -718,7 +718,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
> >  			folio = folio_next(folio);
> >  		}
> >  
> > -		while (left >= (ssize_t)folio_size(folio)) {
> > +		while (left && left >= (ssize_t)folio_size(folio)) {
> >  			set_bit(PG_dcache_clean, &folio->flags);
> >  			left -= folio_size(folio);
> >  			folio = folio_next(folio);
> 
> I've been thinking about this and I think this is the right fix for the
> wrong reason.  I don't understand how it can produce the failure you
> saw, but we shouldn't be calling folio_next() if left is zero, let alone
> calling folio_size() on it.  So I'd rather see this fix:
> 
> 		while (left >= (ssize_t)folio_size(folio)) {
> 			set_bit(PG_dcache_clean, &folio->flags);
> 			left -= folio_size(folio);
> +			if (!left)
> +				break;

Given that set_bit() involves atomics, wouldn't it be better if this
had been written as:

		while (left >= folio_size(folio)) {
			left -= folio_size(folio);
			set_bit(PG_dcache_clean, &folio->flags);
			if (!left)
				break;
> 			folio = folio_next(folio);
> 		}

That likely means that folio_size() will only be evaluated once per
loop rather than twice. I may be wrong though, I didn't check the
generated code.

Also, I'm wondering what that ssize_t cast is doing there - "left"
is a size_t, which is unsigned. folio_size() returns a size_t, so
is also unsigned. Why convert folio_size() to a signed number to
then be compared with an unsigned number?

Or did "left" get converted to ssize_t along with the folio
conversion?

Even if it did, how could "left" be negative (except through casting
a large positive number as "size" that in 2's complement would be
negative after casting to "left") ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
