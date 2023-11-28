Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE07FC171
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346739AbjK1PSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346689AbjK1PSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:18:14 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3064F10C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:18:20 -0800 (PST)
Received: (qmail 168629 invoked by uid 1000); 28 Nov 2023 10:18:19 -0500
Date:   Tue, 28 Nov 2023 10:18:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Ferry Toth <ferry.toth@elsinga.info>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128133702.GA9917@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:37:02PM +0100, Christoph Hellwig wrote:
> I'd actually go one step back:
> 
>  1) for not cache coherent DMA you can't do overlapping operations inside
>     a cache line

Rephrasing slightly: You mustn't perform multiple non-cache-coherent DMA 
operations that touch the same cache line concurrently.  (The word 
"overlapping" is a a little ambiguous in this context.)

(Right now dma-debug considers only DMA-IN operations.  In theory this 
restriction should apply even when some of the concurrent operations are 
DMA-OUT, provided that at least one of them is DMA-IN.  Minor point...)

>  2) dma-debug is intended to find DMA API misuses, even if they don't
>     have bad effects on your particular system
>  3) the fact that the kmalloc implementation returns differently aligned
>     memory depending on the platform breaks how dma-debug works currently

Exactly.  That's essentially what Bugzilla #215740 is about.

> The logical confcusion from that would be that IFF dma-debug is enabled on
> any platform we need to set ARCH_DMA_MINALIGN to the cache line size.

(IF, not IFF.)  And tell distributions that CONFIG_DMA_API_DEBUG is not 
meant for production systems but rather for kernel testing, right?

> BUT:  we're actually reduzing our dependency on ARCH_DMA_MINALIGN by
> moving to bounce buffering unaligned memory for non-coherent
> architectures,

What's the reason for this?  To allow the minimum allocation size to be
smaller than the cache line size?  Does the savings in memory make up 
for the extra overhead of bounce buffering?

Or is this just to allow people to be more careless about how they 
allocate their DMA buffers (which doesn't seem to make sense)?

>  which makes this even more complicated.  Right now I
> don't have a good idea how to actually deal with having the cachline
> sanity checks with that, but I'm Ccing some of the usual suspects if
> they have a better idea.

I get the impression that you would really like to have two different 
versions of kmalloc() and friends: one for buffers that will be used in 
DMA (and hence require cache-line alignment) and one for buffers that 
won't be.

Alan Stern
