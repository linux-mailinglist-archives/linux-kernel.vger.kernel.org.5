Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5A7D2A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjJWGQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJWGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:16:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA3E8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:16:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB32968AA6; Mon, 23 Oct 2023 08:16:01 +0200 (CEST)
Date:   Mon, 23 Oct 2023 08:16:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jim Quinlan <james.quinlan@broadcom.com>,
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
Message-ID: <20231023061601.GA12056@lst.de>
References: <20230926175208.9298-1-james.quinlan@broadcom.com> <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com> <20231002061628.GC911@lst.de> <CA+-6iNy79pLgACMGXxRkPuVkXca0VyLis+jQcRmCwtBvEfFzgw@mail.gmail.com> <20231006074045.GA15303@lst.de> <CGME20231020081648eucas1p17d2572cfca5762d2f5cbc560dd648564@eucas1p1.samsung.com> <3515448c-8a4b-4669-9f80-2f55c5100674@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3515448c-8a4b-4669-9f80-2f55c5100674@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:16:46AM +0200, Marek Szyprowski wrote:
> For historical reasons (performance and limitations of the pre-ARM v7 
> cores), on the 32bit ARM the whole kernel's direct mapping is done using 
> so called 'sections' (1MiB size afair). Those sections are created in 
> the per-process MMU page tables (there are no separate MMU table for the 
> kernel mappings), so altering those mappings requires updating bits in 
> all processes in the system. Practically this means that those mappings 
> has to be static once created during boot time.

That's actually the same on many architetures, and matches the
explanation I heard from Russell before.

> That's why when no CMA 
> is selected, the whole dma_alloc_coherent() allocations are limited to 
> rather small region, which is already remapped as non-cached during boot.

But this does not match my understanding of the code:

 - arch_dma_alloc calls __dma_alloc with is_coherent set to false
 - __dma_alloc then selects cma_allocator if CMA is supported for
   the device / allocation, else remap_allocator if the allocation
   is allowed to block and only if blocking is not allowed pool_allocator
   to allocate from the boot-time pool

This very match matches the dma-direct flow with DMA_DIRECT_REMAP
selected.  The major exception is the direct mapping of the CMA
allocations done by arm32.
