Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1297AF4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjIZUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjIZUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BCD11D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:23:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC976C433CA;
        Tue, 26 Sep 2023 20:23:45 +0000 (UTC)
Date:   Tue, 26 Sep 2023 21:23:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Petr Tesarik <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <ZRM9z6JQKTtqTMQa@arm.com>
References: <20230926185556.16433-1-petr@tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926185556.16433-1-petr@tesarici.cz>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:55:56PM +0200, Petr Tesarik wrote:
> When CONFIG_SWIOTLB_DYNAMIC=y, devices which do not use the software IO TLB
> can avoid swiotlb lookup. A flag is added by commit 1395706a1490 ("swiotlb:
> search the software IO TLB only if the device makes use of it"), the flag
> is correctly set, but it is then never checked. Add the actual check here.
> 
> Note that this code is an alternative to the default pool check, not an
> additional check, because:
> 
> 1. swiotlb_find_pool() also searches the default pool;
> 2. if dma_uses_io_tlb is false, the default swiotlb pool is not used.
> 
> Tested in a KVM guest against a QEMU RAM-backed SATA disk over virtio and
> *not* using software IO TLB, this patch increases IOPS by approx 2% for
> 4-way parallel I/O.
> 
> The write memory barrier in swiotlb_dyn_alloc() is not needed, because a
> newly allocated pool must always be observed by swiotlb_find_slots() before
> an address from that pool is passed to is_swiotlb_buffer().
> 
> Correctness was verified using the following litmus test:
> 
> C swiotlb-new-pool
> 
> (*
>  * Result: Never
>  *
>  * Check that a newly allocated pool is always visible when the
>  *  corresponding swiotlb buffer is visible.
>  *)
> 
> {
> 	mem_pools = default;
> }
> 
> P0(int **mem_pools, int *pool)
> {
> 	/* add_mem_pool() */
> 	WRITE_ONCE(*pool, 999);
> 	rcu_assign_pointer(*mem_pools, pool);
> }
> 
> P1(int **mem_pools, int *flag, int *buf)
> {
> 	/* swiotlb_find_slots() */
> 	int *r0;
> 	int r1;
> 
> 	rcu_read_lock();
> 	r0 = READ_ONCE(*mem_pools);
> 	r1 = READ_ONCE(*r0);
> 	rcu_read_unlock();
> 
> 	if (r1) {
> 		WRITE_ONCE(*flag, 1);
> 		smp_mb();
> 	}
> 
> 	/* device driver (presumed) */
> 	WRITE_ONCE(*buf, r1);
> }
> 
> P2(int **mem_pools, int *flag, int *buf)
> {
> 	/* device driver (presumed) */
> 	int r0 = READ_ONCE(*buf);
> 
> 	/* is_swiotlb_buffer() */
> 	int r1;
> 	int *r2;
> 	int r3;
> 
> 	smp_rmb();
> 	r1 = READ_ONCE(*flag);
> 	if (r1) {
> 		/* swiotlb_find_pool() */
> 		rcu_read_lock();
> 		r2 = READ_ONCE(*mem_pools);
> 		r3 = READ_ONCE(*r2);
> 		rcu_read_unlock();
> 	}
> }
> 
> exists (2:r0<>0 /\ 2:r3=0) (* Not found. *)
> 
> Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
> Reported-by: Jonathan Corbet <corbet@lwn.net>
> Closes: https://lore.kernel.org/linux-iommu/87a5uz3ob8.fsf@meer.lwn.net/
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

I added this for v2, here it is again:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
