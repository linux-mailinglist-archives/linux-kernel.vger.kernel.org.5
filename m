Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4457A4EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjIRQal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjIRQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:30:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202725ADA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:27:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399A5C4167D;
        Mon, 18 Sep 2023 15:45:37 +0000 (UTC)
Date:   Mon, 18 Sep 2023 16:45:34 +0100
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
Message-ID: <ZQhwnhOQbDp3j8y7@arm.com>
References: <20230913114016.17752-1-petr@tesarici.cz>
 <20230913121403.GB4544@lst.de>
 <20230913142656.29e135d6@meshulam.tesarici.cz>
 <ZQNQscYr0rQWdw66@arm.com>
 <20230915111343.01496320@meshulam.tesarici.cz>
 <ZQSPyBRjnSISNFmD@arm.com>
 <20230917114741.01a23364@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917114741.01a23364@meshulam.tesarici.cz>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 11:47:41AM +0200, Petr Tesařík wrote:
> On Fri, 15 Sep 2023 18:09:28 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Sep 15, 2023 at 11:13:43AM +0200, Petr Tesařík wrote:
> > > On Thu, 14 Sep 2023 19:28:01 +0100
> > > Catalin Marinas <catalin.marinas@arm.com> wrote:  
> > > > What do the smp_wmb() barriers in swiotlb_find_slots() and
> > > > swiotlb_dyn_alloc() order? The latter is even more unclear as it's at
> > > > the end of the function and the "pairing" comment doesn't help.  
> > > 
> > > By the time swiotlb_find_slots() returns a valid slot index, the new
> > > value of dev->dma_uses_io_tlb must be visible by all CPUs in
> > > is_swiotlb_buffer(). The index is used to calculate the bounce buffer
> > > address returned to device drivers. This address may be passed to
> > > another CPU and used as an argument to is_swiotlb_buffer().  
> > 
> > Ah, I remember now. So the smp_wmb() ensures that dma_uses_io_tlb is
> > seen by other CPUs before the slot address (presumably passed via other
> > memory write). It may be worth updating the comment in the code (I'm
> > sure I'll forget it in a month time). The smp_rmb() before READ_ONCE()
> > in this patch is also needed for the same reasons (ordering after the
> > read of the address passed to is_swiotlb_buffer()).
> 
> I agree. The comment should definitely mention the implicitly assumed
> memory write done by device drivers, because it is not obvious which
> two writes are being ordered.
> 
> > BTW, you may want to use WRITE_ONCE() when setting dma_uses_io_tlb (it
> > also matches the READ_ONCE() in is_swiotlb_buffer()). Or you can use
> > smp_store_mb() (but check its semantics first).
> 
> I can use WRITE_ONCE(), although I believe it does not make much
> difference thanks to the barrier provided by smp_wmb().

WRITE_ONCE() is about atomicity rather than ordering (and avoiding
compiler optimisations messing things). While I don't see the compiler
generating multiple accesses for a boolean write, using these accessors
also helps tools like kcsan.

> Using smp_store_mb() should also work, but it inserts a full memory
> barrier, which is more than is needed IMO.

True.

> > > I am not sure that the smp_wmb() in swiotlb_dyn_alloc() is needed, but
> > > let me explain my thinking. Even if the dev->dma_uses_io_tlb flag is
> > > set, is_swiotlb_buffer() returns false unless the buffer address is
> > > found in the RCU list of swiotlb pools, which is walked without taking
> > > any lock. In some iterations of the patch series, there was a direct
> > > call to swiotlb_dyn_alloc(), and a smp_wmb() was necessary to make sure
> > > that the list of swiotlb pools cannot be observed as empty by another
> > > CPU. You have already explained to me that taking a spin lock in
> > > add_mem_pool() is not sufficient, because it does not invalidate a
> > > value that might have been speculatively read by another CPU before
> > > entering the critical section. OTOH swiotlb_dyn_alloc() is always
> > > called through schedule_work() in the current version. If that
> > > implicitly provides necessary barriers, this smp_wmb() can be removed.  
> > 
> > Normally you'd need a barrier between pool update and flag update:
> > 
> > 	list_add_rcu(&pool->node, &mem->pools);
> > 	smp_wmb();
> > 	WRITE_ONCE(dev->dma_uses_io_tlb, true);
> 
> I agree. However, if is_swiotlb_buffer() gets an address allocated from
> a swiotlb pool that was added here, then it also had to be returned by
> swiotlb_find_slots(), where smp_wmb() makes sure that all writes are
> visible before the above-mentioned assumed write of the buffer pointer
> into a private data field, performed by driver code.

You are right, we have a dependency on this assumed write, so it should
be fine (no need to sprinkle more barriers).

> > The lock around mem->pools update doesn't help since since it only has
> > release semantics on the unlock path (which doesn't prevent the
> > dma_uses_io_tlb write from being reordered before).
> 
> Yes.
> 
> > On the reader side, you need to make sure that if the dma_uses_io_tlb is
> > true, the mem->pools access was not speculated and read earlier as
> > empty, so another dma_rmb():
> > 
> > 	if (READ_ONCE(dev->dma_uses_io_tlb)) {
> > 		dma_rmb();
> 
> I think this is a typo, and you mean smp_rmb(); at least I can't see
> which consistent DMA memory would be accessed here.

Yes, smp_rmb().

> > 		swiotlb_find_pool(...);
> > 	}
> > 
> > That's missing in the code currently (and rcu_read_lock() only has
> > acquire semantics).
> > 
> > However, what confuses me is that mem->pools is populated
> > asynchronously via schedule_work(). Not sure how the barriers help
> > since the work can be scheduled on any CPU at any point after,
> > potentially after dma_uses_io_tlb has been updated.
> 
> Ah... You may have a point after all if this sequence of events is
> possible:
> 
> - CPU 0 writes new value to mem->pools->next in swiotlb_dyn_alloc().
> 
> - CPU 1 observes the new value in swiotlb_find_slots(), even though it
>   is not guaranteed by any barrier, allocates a slot and sets the
>   dev->dma_uses_io_tlb flag.
> 
> - CPU 1 (driver code) writes the returned buffer address into its
>   private struct. This write is ordered after dev->dma_uses_io_tlb
>   thanks to the smp_wmb() in swiotlb_find_slots().
> 
> - CPU 2 (driver code) reads the buffer address, and DMA core passes it
>   to is_swiotlb_buffer(), which contains smp_rmb().
> 
> - IIUC CPU 2 is guaranteed to observe the new value of
>   dev->dma_uses_io_tlb, but it may still use the old value of
>   mem->pools->next, because the write on CPU 0 was not ordered
>   against anything. The fact that the new value was observed by CPU 1
>   does not mean that it is also observed by CPU 2.

Yes, that's possible. On CPU 1 there is a control dependency between the
read of mem->pools->next and the write of dev->dma_uses_io_tlb but I
don't think this is sufficient to claim multi-copy atomicity (if CPU 1
sees mem->pools->next write by CPU 0, CPU 2 must see it as well), at
least not on all architectures supported by Linux. memory-barriers.txt
says that a full barrier on CPU 1 is needed between the read and write,
i.e. smp_mb() before WRITE_ONCE(dev->dma_uses_io_tlb). You could add it
just before "goto found" in swiotlb_find_slots() since it's only needed
on this path.

Another thing I noticed - the write in add_mem_pool() to mem->nslabs is
not ordered with list_add_rcu(). I assume swiotlb_find_slots() doesn't
need to access it since it just walks the mem->pools list.

> > On the transient dev->dma_io_tlb_pools updated in
> > swiotlb_find_slots(), you'd need the barriers as I mentioned above
> > (unless I misunderstood how this pool searching works; not entirely
> > sure why swiotlb_find_pool() searches both).
> 
> The transient pool list is updated only in swiotlb_find_slots() before
> setting dev->dma_uses_io_tlb. AFAICS this write should is already
> ordered with the same smp_wmb().

Yes, I think that's fine.

> >[...]
> > > Actually, I wonder when a newly added RCU list element is
> > > guaranteed to be visible by all CPUs. Existing documentation deals
> > > mainly with element removal, explaining that both the old state and
> > > the new state of an RCU list are valid after addition. Is it
> > > assumed that the old state of an RCU list after addition is valid
> > > indefinitely?  
> > 
> > When some write becomes visible to other CPUs, I don't think the
> > architectures define precisely (more like in vague terms as
> > "eventually"). That's why we can't talk about barriers in relation to
> > a single write as the barrier doesn't make a write visible but rather
> > makes it visible _before_ a subsequent write becomes visible (whenever
> > that may be).
> 
> This is understood. It's just that list_add_rcu() updates the next
> pointer in the previous list entry using smp_store_release(), ordering
> writes on this next pointer, but I don't see the matching loads with
> acquire semantics anywhere. It's probably required to detect RCU grace
> period...

I don't have the history of the release semantics here but one of the
reasons is to ensure that any structure initialisation is visible before
the pointer is added to the list (e.g. the pool structure populated by
swiotlb_alloc_pool() before add_mem_pool()). On the reader side, you
have an address dependency as you can't read the content of the
structure without first reading the pointer (rcu_dereference() provides
an implicit address dependency).

-- 
Catalin
