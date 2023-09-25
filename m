Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A6D7AD728
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjIYLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjIYLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:43:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC4EE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:43:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB333C433C9;
        Mon, 25 Sep 2023 11:43:25 +0000 (UTC)
Date:   Mon, 25 Sep 2023 12:43:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <ZRFyW/pFpnL+bDbg@arm.com>
References: <20230913121403.GB4544@lst.de>
 <20230913142656.29e135d6@meshulam.tesarici.cz>
 <ZQNQscYr0rQWdw66@arm.com>
 <20230915111343.01496320@meshulam.tesarici.cz>
 <ZQSPyBRjnSISNFmD@arm.com>
 <20230917114741.01a23364@meshulam.tesarici.cz>
 <ZQhwnhOQbDp3j8y7@arm.com>
 <20230922153129.69b26975@meshulam.tesarici.cz>
 <20230922191213.379d440a@meshulam.tesarici.cz>
 <20230922202057.47d93603@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922202057.47d93603@meshulam.tesarici.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 08:20:57PM +0200, Petr Tesařík wrote:
> On Fri, 22 Sep 2023 19:12:13 +0200
> Petr Tesařík <petr@tesarici.cz> wrote:
> > On Fri, 22 Sep 2023 15:31:29 +0200
> > Petr Tesařík <petr@tesarici.cz> wrote:
> > > On Mon, 18 Sep 2023 16:45:34 +0100
> > > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > On Sun, Sep 17, 2023 at 11:47:41AM +0200, Petr Tesařík wrote:    
> > > > > Ah... You may have a point after all if this sequence of events is
> > > > > possible:
> > > > > 
> > > > > - CPU 0 writes new value to mem->pools->next in swiotlb_dyn_alloc().
> > > > > 
> > > > > - CPU 1 observes the new value in swiotlb_find_slots(), even though it
> > > > >   is not guaranteed by any barrier, allocates a slot and sets the
> > > > >   dev->dma_uses_io_tlb flag.
> > > > > 
> > > > > - CPU 1 (driver code) writes the returned buffer address into its
> > > > >   private struct. This write is ordered after dev->dma_uses_io_tlb
> > > > >   thanks to the smp_wmb() in swiotlb_find_slots().
> > > > > 
> > > > > - CPU 2 (driver code) reads the buffer address, and DMA core passes it
> > > > >   to is_swiotlb_buffer(), which contains smp_rmb().
> > > > > 
> > > > > - IIUC CPU 2 is guaranteed to observe the new value of
> > > > >   dev->dma_uses_io_tlb, but it may still use the old value of
> > > > >   mem->pools->next, because the write on CPU 0 was not ordered
> > > > >   against anything. The fact that the new value was observed by CPU 1
> > > > >   does not mean that it is also observed by CPU 2.      
> > > > 
> > > > Yes, that's possible. On CPU 1 there is a control dependency between the
> > > > read of mem->pools->next and the write of dev->dma_uses_io_tlb but I
> > > > don't think this is sufficient to claim multi-copy atomicity (if CPU 1
> > > > sees mem->pools->next write by CPU 0, CPU 2 must see it as well), at
> > > > least not on all architectures supported by Linux. memory-barriers.txt
> > > > says that a full barrier on CPU 1 is needed between the read and write,
> > > > i.e. smp_mb() before WRITE_ONCE(dev->dma_uses_io_tlb). You could add it
> > > > just before "goto found" in swiotlb_find_slots() since it's only needed
> > > > on this path.    
> > > 
> > > Let me check my understanding. This smp_mb() is not needed to make sure
> > > that the write to dev->dma_uses_io_tlb cannot be visible before the
> > > read of mem->pools->next. Since stores are not speculated, that
> > > ordering is provided by the control dependency alone.
> > > 
> > > But a general barrier ensures that a third CPU will observe the write to
> > > mem->pools->next after the read of mem->pools->next. Makes sense.  
> > 
> > Now that I'm writing the patch, I get your idea to replace WRITE_ONCE()
> > with smp_store_release(). Since a full memory barrier is required for
> > multicopy atomicity, it is not "more than I need". Instead, the
> > ordering contraints may be possibly restricted to "CPUs participating
> > in a release-acquire chain" if I also replace READ_ONCE() in
> > is_swiotlb_buffer() with smp_read_acquire().
> > 
> > I believe it does not matter that the CPU which writes a new value to
> > mem->pools->next in swiotlb_dyn_alloc() does not participate in the
> > chain, because the value must have been visible to the CPU which
> > executes swiotlb_find_slots() and which does participate in the chain.
> > 
> > Let me double-check this thinking with a litmus test.
> 
> Hm. I didn't have much luck with smp_store_release(), because I need
> to ensure ordering of the SUBSEQUENT store (by a device driver).
> 
> However, inserting smp_mb() _after_ WRITE_ONCE(dev->dma_uses_io_tlb)
> seems to be enough to ensure proper ordering. I could even remove the
> write memory barrier in swiotlb_dyn_alloc().

The smp_wmb() in swiotlb_dyn_alloc() should be removed, it doesn't help
anything.

> This is my first time using herd7, so I can only hope I got everything
> right. FWIW this is my litmus test:

Nice, easier to reason on a smaller test.

> C swiotlb-new-pool
> 
> (*
>  * Result: Never
>  *
>  * Check that a newly allocated pool is always visible when the corresponding
>  * swiotlb buffer is visible.
>  *)
> 
> {}
> 
> P0(int *pool)
> {
> 	/* swiotlb_dyn_alloc() */
> 	WRITE_ONCE(*pool, 999);
> }
> 
> P1(int *pool, int *flag, int *buf)
> {
> 	/* swiotlb_find_slots() */
> 	int r0 = READ_ONCE(*pool);
> 	if (r0) {
> 		WRITE_ONCE(*flag, 1);
> 		smp_mb();

I think in the current code, that's the smp_wmb() just before the
presumed driver write. IIUC, smp_wmb() is not sufficient to ensure that
WRITE_ONCE() on P0 is also observed, it would need to be smp_mb(). Nor
would the smp_store_release() instead of WRITE_ONCE(*flag, 1).

My initial thought was to place an smp_mb() just before WRITE_ONCE()
above as it matches the multicopy atomicity description in
memory-barriers.txt. But since we have the presumed driver write anyway,
we can use that as the write on P1, read-from by P2, to ensure the
global visibility of the write on P0.

> 	}
> 
> 	/* device driver (presumed) */
> 	WRITE_ONCE(*buf, r0);
> }
> 
> P2(int *pool, int *flag, int *buf)
> {
> 	/* device driver (presumed) */
> 	int r1 = READ_ONCE(*buf);
> 
> 	/* is_swiotlb_buffer() */
> 	int r2;
> 	int r3;
> 
> 	smp_rmb();
> 	r2 = READ_ONCE(*flag);
> 	if (r2) {
> 		r3 = READ_ONCE(*pool);
> 	}
> }
> 
> exists (2:r1<>0 /\ 2:r3=0) (* Not flagged or pool not found. *)
> 
> Petr T

I guess a v2 of this patch would only need to change the smp_wmb() in
swiotlb_find_slots() (and the original fix). But write some comments,
I'll forget everything in a week.

-- 
Catalin
