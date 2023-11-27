Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A037FA6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjK0QvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjK0QvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:51:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2105F1AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:51:22 -0800 (PST)
Received: (qmail 131349 invoked by uid 1000); 27 Nov 2023 11:51:21 -0500
Date:   Mon, 27 Nov 2023 11:51:21 -0500
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
        USB mailing list <linux-usb@vger.kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127160759.GA1668@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:07:59PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 11:02:20AM -0500, Alan Stern wrote:
> > All it looks for is mappings that start on the same cache line.  However 
> > on architectures that have cache-coherent DMA (such as x86), touching 
> > the same cache line does not mean that two DMA mappings will interfere 
> > with each other.  To truly overlap, they would have to touch the same 
> > _bytes_.
> 
> But that is a special case that does not matter.  Linux drivers need
> to be written in a portable way, and that means we have to care about
> platforms that are not DMA coherent.

The buffers in the bug report were allocated by kmalloc().  Doesn't 
kmalloc() guarantee that on architectures with non-cache-coherent DMA, 
allocations will be aligned on cache-line boundaries (or larger)?  Isn't 
this what ARCH_DMA_MINALIGN and ARCH_KMALLOC_MINALIGN are supposed to 
take care of in include/linux/slab.h?

> > How should this be fixed?  Since the check done in add_dma_entry() is 
> > completely invalid for x86 and similar architectures, should it simply 
> > be removed for them?  Or should the check be enhanced to look for 
> > byte-granularity overlap?
> 
> The patch is every but "completely invalid".  It points out that you
> violate the Linux DMA API requirements.

Since when does the DMA API require that mappings on x86 must be to 
separate cache lines?  Is this documented anywhere?

For that matter, Documentation/core-api/dma-api-howto.rst explicitly 
says:

	If you acquired your memory via the page allocator
	(i.e. __get_free_page*()) or the generic memory allocators
	(i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
	that memory using the addresses returned from those routines.

It also says:

	Architectures must ensure that kmalloc'ed buffer is
	DMA-safe. Drivers and subsystems depend on it. If an architecture
	isn't fully DMA-coherent (i.e. hardware doesn't ensure that data in
	the CPU cache is identical to data in main memory),
	ARCH_DMA_MINALIGN must be set so that the memory allocator
	makes sure that kmalloc'ed buffer doesn't share a cache line with
	the others. See arch/arm/include/asm/cache.h as an example.

It says nothing about avoiding more than one DMA operation at a time to 
prevent overlap.  Is the documentation wrong?

>  This might not have an
> effect on the particular plaform you are currently running on, but it
> is still wrong.

Who decides what is right and what is wrong in this area?  Clearly you 
have a different opinion from David S. Miller, Richard Henderson, and 
Jakub Jelinek (the authors of that documentation file).

>  Note that there have been various mumblings about
> using nosnoop dma on x86, in which case you'll have the issue there
> as well.

Unless the people who implement nosnoop DMA also modify kmalloc() or 
ARCH_DMA_MINALIGN.

I guess the real question boils down to where the responsiblity should 
lie.  Should kmalloc() guarantee that the memory regions it provides 
will always be suitable for DMA, with no overlap issues?  Or should all 
the innumerable users of kmalloc() be responsible for jumping through 
hoops to request arch-specific minimum alignment for their DMA buffers?

Alan Stern
