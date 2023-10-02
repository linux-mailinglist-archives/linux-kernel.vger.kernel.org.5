Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801F57B4B58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjJBGQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjJBGQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:16:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C416A7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:16:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6614368D07; Mon,  2 Oct 2023 08:16:28 +0200 (CEST)
Date:   Mon, 2 Oct 2023 08:16:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted
 DMA
Message-ID: <20231002061628.GC911@lst.de>
References: <20230926175208.9298-1-james.quinlan@broadcom.com> <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 01:10:27AM +0200, Linus Walleij wrote:
> (...)
> > +       select DMA_DIRECT_REMAP
> 
> Christoph invented that symbol so he can certainly
> explain what is missing to use this on ARM.
> 
> This looks weird to me, because:
> > git grep atomic_pool_init
> arch/arm/mm/dma-mapping.c:static int __init atomic_pool_init(void)
> kernel/dma/pool.c:static int __init dma_atomic_pool_init(void)
> 
> Now you have two atomic DMA pools in the kernel,
> and a lot more than that is duplicated. I'm amazed that it
> compiles at all.
> 
> Clearly if you want to do this, surely the ARM-specific
> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
> needs to be removed at the same time?
> 
> However I don't think it's that simple, because Christoph would surely
> had done this a long time ago if it was that simple.

Yes, DMA_DIRECT_REMAP should only be used for platforms using the
generic generic remap that plus straight into dma-direct and
bypasses arch_dma_alloc.

ARM first needs support to directly set the uncached/wc bits on
the direct mapping for CMA, which should be fairly simple but require
wide spread testing.

I'd be happy to work with anyone who wants to look into this.
