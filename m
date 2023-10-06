Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3831F7BB27F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjJFHnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjJFHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:42:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA9386B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:40:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AFDA6732D; Fri,  6 Oct 2023 09:40:46 +0200 (CEST)
Date:   Fri, 6 Oct 2023 09:40:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20231006074045.GA15303@lst.de>
References: <20230926175208.9298-1-james.quinlan@broadcom.com> <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com> <20231002061628.GC911@lst.de> <CA+-6iNy79pLgACMGXxRkPuVkXca0VyLis+jQcRmCwtBvEfFzgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNy79pLgACMGXxRkPuVkXca0VyLis+jQcRmCwtBvEfFzgw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:53:33PM -0400, Jim Quinlan wrote:
> > Yes, DMA_DIRECT_REMAP should only be used for platforms using the
> > generic generic remap that plus straight into dma-direct and
> > bypasses arch_dma_alloc.
> >
> > ARM first needs support to directly set the uncached/wc bits on
> > the direct mapping for CMA, which should be fairly simple but require
> > wide spread testing.
> >
> > I'd be happy to work with anyone who wants to look into this.
> I'd like to look into this and help make it work for ARCH=arm but you
> seem to be saying that you also need help from ARM the company?

No, I don't care about companies.  I just need someone (singular or
plural) to test a wide range of arm systems.

Here is my idea for the attack plan:

As step 1 ignore the whole CMA direct map issue, and just to the
trivial generic dma remap conversion.  This should involved:

 - select DMA_DIRECT_REMAP
 - provide arch_dma_prep_coherent to flush out all dirty data by
   calling __dma_clear_buffer
 - remove the existing arch_dma_alloc/arch_dma_free and all their
   infrastructure

With this things should work fine on any system not using CMA

Then attack the CMA direct mapping:

 - modify the core DMA mapping code so that the
   ARCH_HAS_DMA_SET_UNCACHED code is only used conditionally
   I'm not quite sure what the right checks and right place is,
   but the intent is that it should allow arm to only use that
   path for CMA allocations.  For all existing users of
   CONFIG_ARCH_HAS_DMA_SET_UNCACHED it should evaluate to
   a compile-time true to not change the behavior or code
   generation
 - then in arm select ARCH_HAS_DMA_SET_UNCACHED and implement
   arch_dma_set_uncached, arch_dma_clear_uncached and the new
   helper above
