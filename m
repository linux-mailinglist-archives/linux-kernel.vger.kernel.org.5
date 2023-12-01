Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942E800955
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378476AbjLALIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378464AbjLALIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:08:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9499D1B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:08:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBCAC433C7;
        Fri,  1 Dec 2023 11:08:46 +0000 (UTC)
Date:   Fri, 1 Dec 2023 11:08:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew <travneff@gmail.com>,
        Ferry Toth <ferry.toth@elsinga.info>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        iommu@lists.linux.dev,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <ZWm-u2kV1UP09M84@arm.com>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <ZWYnECPRKca5Dpqc@arm.com>
 <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:08:23PM +0100, Ferry Toth wrote:
> Op 28-11-2023 om 18:44 schreef Catalin Marinas:
> > Or just force the kmalloc() min align to cache_line_size(), something
> > like:
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4a658de44ee9..3ece20367636 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -543,6 +543,8 @@ static inline int dma_get_cache_alignment(void)
> >   #ifdef ARCH_HAS_DMA_MINALIGN
> >   	return ARCH_DMA_MINALIGN;
> >   #endif
> > +	if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> > +		return cache_line_size();
> >   	return 1;
> >   }
> >   #endif
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 8d431193c273..d0b21d6e9328 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -879,7 +879,7 @@ static unsigned int __kmalloc_minalign(void)
> >   	unsigned int minalign = dma_get_cache_alignment();
> >   	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> > -	    is_swiotlb_allocated())
> > +	    is_swiotlb_allocated() && !IS_ENABLED(CONFIG_DMA_API_DEBUG))
> >   		minalign = ARCH_KMALLOC_MINALIGN;
> >   	return max(minalign, arch_slab_minalign());
> 
> With above suggestion "force the kmalloc() min align to cache_line_size()" +
> Alan's debug code:
> 
> root@yuna:~# journalctl -k | grep hub
> kernel: usbcore: registered new interface driver hub
> kernel: hub 1-0:1.0: USB hub found
> kernel: usb usb1: hub buffer at 71c7180, status at 71c71c0
> kernel: hub 1-0:1.0: 1 port detected
> kernel: hub 2-0:1.0: USB hub found
> kernel: usb usb2: hub buffer at 71c79c0, status at 71c7a00
> kernel: hub 2-0:1.0: 1 port detected
> kernel: hub 1-1:1.0: USB hub found
> kernel: usb 1-1: hub buffer at 65b36c0, status at 6639340
> kernel: hub 1-1:1.0: 7 ports detected
> 
> and the stack trace indeed goes away.
> 
> IOW also the 2 root hub kmalloc() are now also aligned to the cache line
> size, even though these never triggered the stack trace. Strange: hub status
> is aligned far away from hub buffer, kmalloc mysteries.

They are 64 bytes apart in most cases other than the last one which I
guess the status had to go to a different slab page.

> This still did not land for me: are we detecting a false alarm here as the 2
> DMA operations can never happen on the same cache line on non-cache-coherent
> platforms? If so, shouldn't we fix up the dma debug code to not detect a
> false alarm? Instead of changing the alignment?

It's a false alarm indeed on this hardware since the DMA is
cache-coherent. I think Christoph mentioned earlier in this thread that
he'd like the DMA API debug to report potential problems even if the
hardware it is running on is safe.

> Or, is this a bonafide warning (for non-cache-coherent platforms)? Then we
> should not silence it by force aligning it, but issue a WARN (on a cache
> coherent platform) that is more useful (i.e. here we have not an overlap but
> a shared cache line). On a non-cache coherent platform something stronger
> than a WARN might be appropriate?

A non-cache coherent platform would either have the kmalloc()
allocations aligned or it would bounce those small, unaligned buffers.
So it doesn't seem right to issue a warning on x86 where kmalloc()
minimum alignment is 8 and not getting the warning on a non-coherent
platform which forces the kmalloc() alignment.

If we consider the kmalloc() aspect already covered by bouncing or force
alignment, the DMA API debug code can still detect other cache line
sharing situations.

-- 
Catalin
