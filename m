Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C817768DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjHITi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjHITiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:38:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A6410DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NTKUIRyMkZ6gFM5jOazACfpNT+FP8zSBRsd0kaMgCnI=; b=UlQ1FaJbqGtJRlOQ1TXrwJ6j04
        KYpdgQxFgRUjBGqqcBdfEICY1VOu5MSVW0hz8HABcprRIn+qmwc78SYVzhmXq82uEGvXkFcnlaqR9
        YHd3JE2tvmJ2OMMzgw6kPsCqiMNhY+S5egNPMBhhRvwB9BgGDEbU0AHN+iVNcu5rZeNz553TR/eSK
        vNqLmXI4GP2RcxWZ7rKZxvuyHeW1ZORgeohFCgJpI6mLQmUy6jzD74Fv/PJdNdubypnqCzgkX3jK8
        bq1sRpfWHNtVg4S3ZWcA3clEmqQnYX54MAtsDPyBTATcZPDeTx9oJ7A/jIv2+LIynutMAHm8k09nV
        zyqrUt6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTp0a-0082MK-8g; Wed, 09 Aug 2023 19:38:16 +0000
Date:   Wed, 9 Aug 2023 20:38:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] arm: dma-mapping: fix potential endless loop in
 __dma_page_dev_to_cpu()
Message-ID: <ZNPrKJy31Jkgu41r@casper.infradead.org>
References: <CGME20230807152704eucas1p1bbe08af4559a7d2984198fe8ba487a2e@eucas1p1.samsung.com>
 <20230807152657.1692414-1-m.szyprowski@samsung.com>
 <ZNFstXmztIriaKOX@casper.infradead.org>
 <ZNF0LUrtoCp+aS5U@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNF0LUrtoCp+aS5U@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:46:05PM +0100, Russell King (Oracle) wrote:
> On Mon, Aug 07, 2023 at 11:14:13PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 07, 2023 at 05:26:57PM +0200, Marek Szyprowski wrote:
> > > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > > index 70cb7e63a9a5..02250106e5ed 100644
> > > --- a/arch/arm/mm/dma-mapping.c
> > > +++ b/arch/arm/mm/dma-mapping.c
> > > @@ -718,7 +718,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
> > >  			folio = folio_next(folio);
> > >  		}
> > >  
> > > -		while (left >= (ssize_t)folio_size(folio)) {
> > > +		while (left && left >= (ssize_t)folio_size(folio)) {
> > >  			set_bit(PG_dcache_clean, &folio->flags);
> > >  			left -= folio_size(folio);
> > >  			folio = folio_next(folio);
> > 
> > I've been thinking about this and I think this is the right fix for the
> > wrong reason.  I don't understand how it can produce the failure you
> > saw, but we shouldn't be calling folio_next() if left is zero, let alone
> > calling folio_size() on it.  So I'd rather see this fix:
> > 
> > 		while (left >= (ssize_t)folio_size(folio)) {
> > 			set_bit(PG_dcache_clean, &folio->flags);
> > 			left -= folio_size(folio);
> > +			if (!left)
> > +				break;
> 
> Given that set_bit() involves atomics, wouldn't it be better if this
> had been written as:
> 
> 		while (left >= folio_size(folio)) {
> 			left -= folio_size(folio);
> 			set_bit(PG_dcache_clean, &folio->flags);
> 			if (!left)
> 				break;
> > 			folio = folio_next(folio);
> > 		}
> 
> That likely means that folio_size() will only be evaluated once per
> loop rather than twice. I may be wrong though, I didn't check the
> generated code.

I'd really like it if gcc did notice that folio_size() could be CSE.
Unfortunately, I don't think it can.

+long rmk(struct folio *folio, long size)
+{
+       while (size >= folio_size(folio)) {
+               size -= folio_size(folio);
+               folio_set_workingset(folio);
+               if (size < 0)
+                       return size;
+               folio = folio_next(folio);
+       }
+
+       return size;
+}

000039d4 <rmk>:
    39d4:       e92d41f0        push    {r4, r5, r6, r7, r8, lr}
    39d8:       e1a04000        mov     r4, r0
    39dc:       e1a05001        mov     r5, r1
    39e0:       e3a06a01        mov     r6, #4096       @ 0x1000
    39e4:       e3a07020        mov     r7, #32
    39e8:       ea000010        b       3a30 <rmk+0x5c>
    39ec:       e5943000        ldr     r3, [r4]
    39f0:       e1a01004        mov     r1, r4
    39f4:       e3a00009        mov     r0, #9
    39f8:       e3130040        tst     r3, #64 @ 0x40
    39fc:       03a03a01        moveq   r3, #4096       @ 0x1000
    3a00:       15d43020        ldrbne  r3, [r4, #32]
    3a04:       11a03316        lslne   r3, r6, r3
    3a08:       e0455003        sub     r5, r5, r3
    3a0c:       ebfffffe        bl      0 <_set_bit>
                        3a0c: R_ARM_CALL        _set_bit
    3a10:       e3550000        cmp     r5, #0
    3a14:       ba00000c        blt     3a4c <rmk+0x78>
    3a18:       e5943000        ldr     r3, [r4]
    3a1c:       e3130040        tst     r3, #64 @ 0x40
    3a20:       03a03020        moveq   r3, #32
    3a24:       15d43020        ldrbne  r3, [r4, #32]
    3a28:       11a03317        lslne   r3, r7, r3
    3a2c:       e0844003        add     r4, r4, r3
    3a30:       e5943000        ldr     r3, [r4]
    3a34:       e3130040        tst     r3, #64 @ 0x40
    3a38:       03a03a01        moveq   r3, #4096       @ 0x1000
    3a3c:       15d43020        ldrbne  r3, [r4, #32]
    3a40:       11a03316        lslne   r3, r6, r3
    3a44:       e1550003        cmp     r5, r3
    3a48:       2affffe7        bcs     39ec <rmk+0x18>
    3a4c:       e1a00005        mov     r0, r5
    3a50:       e8bd81f0        pop     {r4, r5, r6, r7, r8, pc}

Certainly seems to me like it's calculating folio_size() twice.
And actually it's redone the ordering to put the calculation
after the call to set_bit!

> Also, I'm wondering what that ssize_t cast is doing there - "left"
> is a size_t, which is unsigned. folio_size() returns a size_t, so
> is also unsigned. Why convert folio_size() to a signed number to
> then be compared with an unsigned number?

Because earlier we did:

+       if (offset) {
+               left -= folio_size(folio) - offset;
+               folio = folio_next(folio);
+       }

so left might now be negative.  If we did an unsigned comparison,
we'd go round this loop.

Er.  And the fix from Marek didn't accommodate this problem.  So we need
a fix-fix:

	if (offset) {
		left -= folio_size(folio) - offset;
+		if (left <= 0)
+			return;
		folio = folio_next(folio);
	}

Marek, can you do the honours here?

> Or did "left" get converted to ssize_t along with the folio
> conversion?
> 
> Even if it did, how could "left" be negative (except through casting
> a large positive number as "size" that in 2's complement would be
> negative after casting to "left") ?
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
