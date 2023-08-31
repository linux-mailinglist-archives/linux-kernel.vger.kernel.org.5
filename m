Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F278EDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjHaMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHaMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:51:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D4CED;
        Thu, 31 Aug 2023 05:51:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C99B468C4E; Thu, 31 Aug 2023 14:51:10 +0200 (CEST)
Date:   Thu, 31 Aug 2023 14:51:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: Re: [PATCH v7 9/9] swiotlb: search the software IO TLB only if the
 device makes use of it
Message-ID: <20230831125109.GA11562@lst.de>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com> <adea71bd1fa8660d4c3157a562431ad8127016d4.1690871004.git.petr.tesarik.ext@huawei.com> <87a5uz3ob8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5uz3ob8.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:20:43PM -0600, Jonathan Corbet wrote:
> >  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
> >  
> > -	/* Pairs with smp_rmb() in swiotlb_find_pool(). */
> > -	smp_wmb();
> >  found:
> > +	dev->dma_uses_io_tlb = true;
> > +	/* Pairs with smp_rmb() in is_swiotlb_buffer() */
> > +	smp_wmb();
> > +
> 
> ...and here you set it if swiotlb is used.
> 
> But, as far as I can tell, you don't actually *use* this field anywhere.
> What am I missing?

It's very much unused.  Petr, I guess you wanted to use this in
is_swiotlb_buffer to avoid the lookup unless required.  Can you send
a follow up?
