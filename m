Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E157A2452
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjIORJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIORJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A050EE7F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A176EC433C7;
        Fri, 15 Sep 2023 17:09:30 +0000 (UTC)
Date:   Fri, 15 Sep 2023 18:09:28 +0100
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
Message-ID: <ZQSPyBRjnSISNFmD@arm.com>
References: <20230913114016.17752-1-petr@tesarici.cz>
 <20230913121403.GB4544@lst.de>
 <20230913142656.29e135d6@meshulam.tesarici.cz>
 <ZQNQscYr0rQWdw66@arm.com>
 <20230915111343.01496320@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915111343.01496320@meshulam.tesarici.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:13:43AM +0200, Petr Tesařík wrote:
> On Thu, 14 Sep 2023 19:28:01 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > What do the smp_wmb() barriers in swiotlb_find_slots() and
> > swiotlb_dyn_alloc() order? The latter is even more unclear as it's at
> > the end of the function and the "pairing" comment doesn't help.
> 
> By the time swiotlb_find_slots() returns a valid slot index, the new
> value of dev->dma_uses_io_tlb must be visible by all CPUs in
> is_swiotlb_buffer(). The index is used to calculate the bounce buffer
> address returned to device drivers. This address may be passed to
> another CPU and used as an argument to is_swiotlb_buffer().

Ah, I remember now. So the smp_wmb() ensures that dma_uses_io_tlb is
seen by other CPUs before the slot address (presumably passed via other
memory write). It may be worth updating the comment in the code (I'm
sure I'll forget it in a month time). The smp_rmb() before READ_ONCE()
in this patch is also needed for the same reasons (ordering after the
read of the address passed to is_swiotlb_buffer()).

BTW, you may want to use WRITE_ONCE() when setting dma_uses_io_tlb (it
also matches the READ_ONCE() in is_swiotlb_buffer()). Or you can use
smp_store_mb() (but check its semantics first).

> I am not sure that the smp_wmb() in swiotlb_dyn_alloc() is needed, but
> let me explain my thinking. Even if the dev->dma_uses_io_tlb flag is
> set, is_swiotlb_buffer() returns false unless the buffer address is
> found in the RCU list of swiotlb pools, which is walked without taking
> any lock. In some iterations of the patch series, there was a direct
> call to swiotlb_dyn_alloc(), and a smp_wmb() was necessary to make sure
> that the list of swiotlb pools cannot be observed as empty by another
> CPU. You have already explained to me that taking a spin lock in
> add_mem_pool() is not sufficient, because it does not invalidate a
> value that might have been speculatively read by another CPU before
> entering the critical section. OTOH swiotlb_dyn_alloc() is always
> called through schedule_work() in the current version. If that
> implicitly provides necessary barriers, this smp_wmb() can be removed.

Normally you'd need a barrier between pool update and flag update:

	list_add_rcu(&pool->node, &mem->pools);
	smp_wmb();
	WRITE_ONCE(dev->dma_uses_io_tlb, true);

The lock around mem->pools update doesn't help since since it only has
release semantics on the unlock path (which doesn't prevent the
dma_uses_io_tlb write from being reordered before).

On the reader side, you need to make sure that if the dma_uses_io_tlb is
true, the mem->pools access was not speculated and read earlier as
empty, so another dma_rmb():

	if (READ_ONCE(dev->dma_uses_io_tlb)) {
		dma_rmb();
		swiotlb_find_pool(...);
	}

That's missing in the code currently (and rcu_read_lock() only has
acquire semantics).

However, what confuses me is that mem->pools is populated asynchronously
via schedule_work(). Not sure how the barriers help since the work can
be scheduled on any CPU at any point after, potentially after
dma_uses_io_tlb has been updated.

On the transient dev->dma_io_tlb_pools updated in swiotlb_find_slots(),
you'd need the barriers as I mentioned above (unless I misunderstood how
this pool searching works; not entirely sure why swiotlb_find_pool()
searches both).

> FTR list_add_rcu() alone is not sufficient. It adds the new element
> using rcu_assign_pointer(), which modifies the forward link with
> smp_store_release(). However, list_for_each_entry_rcu() reads the head
> with list_entry_rcu(), which is a simple READ_ONCE(); there is no
> ACQUIRE semantics.
> 
> Actually, I wonder when a newly added RCU list element is guaranteed to
> be visible by all CPUs. Existing documentation deals mainly with
> element removal, explaining that both the old state and the new state
> of an RCU list are valid after addition. Is it assumed that the old
> state of an RCU list after addition is valid indefinitely?

When some write becomes visible to other CPUs, I don't think the
architectures define precisely (more like in vague terms as
"eventually"). That's why we can't talk about barriers in relation to a
single write as the barrier doesn't make a write visible but rather
makes it visible _before_ a subsequent write becomes visible (whenever
that may be).

Anyway, as above, I think the current code is still missing some
barriers between dma_uses_io_tlb update or read and the actual pool
writes. But I haven't figured out how this works with the asynchronous
swiotlb_dyn_alloc().

-- 
Catalin
