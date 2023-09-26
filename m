Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B87AF362
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjIZS4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjIZS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:56:16 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F06139
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:56:09 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id D0637181833;
        Tue, 26 Sep 2023 20:56:07 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695754568; bh=ElOm4TIidxzIwgnRrVRhsXkA51H4ycV0TyFBLPCb5qU=;
        h=From:To:Cc:Subject:Date:From;
        b=4anjJeL/S3irWFD0xuAQtSGj9T2sAIRXmOWds0qxodvZfr+W/ZBeaRMrAqV50C9/w
         0FmzJJLvvbdSoxn2XPdAEEeJHBglmXlQOnvhDVc4RuvZYYPLJ7NhNUaOFH5PTwrvQI
         CxgQBLCkxIc9+yWMzurM55CAyFV0byd4nB5yDPDxmpYfxcJdzpE8V7gd0p0/vEtMIe
         nbuChrp+gWRaaB/XPUGshQCqW5f5rkRgUh7wo1lsYYokfC1l0mVdgTYYy9iowO5KJT
         tMZlUaGGBA4zHejUQ398/symjWpMRnWhaLVXH3dapIVreB/dgSuM5SIwMDgpTMLZoc
         MM0tYgliTFNhg==
From:   Petr Tesarik <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Tesarik <petr@tesarici.cz>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3] swiotlb: fix the check whether a device has used software IO TLB
Date:   Tue, 26 Sep 2023 20:55:56 +0200
Message-ID: <20230926185556.16433-1-petr@tesarici.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SWIOTLB_DYNAMIC=y, devices which do not use the software IO TLB
can avoid swiotlb lookup. A flag is added by commit 1395706a1490 ("swiotlb:
search the software IO TLB only if the device makes use of it"), the flag
is correctly set, but it is then never checked. Add the actual check here.

Note that this code is an alternative to the default pool check, not an
additional check, because:

1. swiotlb_find_pool() also searches the default pool;
2. if dma_uses_io_tlb is false, the default swiotlb pool is not used.

Tested in a KVM guest against a QEMU RAM-backed SATA disk over virtio and
*not* using software IO TLB, this patch increases IOPS by approx 2% for
4-way parallel I/O.

The write memory barrier in swiotlb_dyn_alloc() is not needed, because a
newly allocated pool must always be observed by swiotlb_find_slots() before
an address from that pool is passed to is_swiotlb_buffer().

Correctness was verified using the following litmus test:

C swiotlb-new-pool

(*
 * Result: Never
 *
 * Check that a newly allocated pool is always visible when the
 *  corresponding swiotlb buffer is visible.
 *)

{
	mem_pools = default;
}

P0(int **mem_pools, int *pool)
{
	/* add_mem_pool() */
	WRITE_ONCE(*pool, 999);
	rcu_assign_pointer(*mem_pools, pool);
}

P1(int **mem_pools, int *flag, int *buf)
{
	/* swiotlb_find_slots() */
	int *r0;
	int r1;

	rcu_read_lock();
	r0 = READ_ONCE(*mem_pools);
	r1 = READ_ONCE(*r0);
	rcu_read_unlock();

	if (r1) {
		WRITE_ONCE(*flag, 1);
		smp_mb();
	}

	/* device driver (presumed) */
	WRITE_ONCE(*buf, r1);
}

P2(int **mem_pools, int *flag, int *buf)
{
	/* device driver (presumed) */
	int r0 = READ_ONCE(*buf);

	/* is_swiotlb_buffer() */
	int r1;
	int *r2;
	int r3;

	smp_rmb();
	r1 = READ_ONCE(*flag);
	if (r1) {
		/* swiotlb_find_pool() */
		rcu_read_lock();
		r2 = READ_ONCE(*mem_pools);
		r3 = READ_ONCE(*r2);
		rcu_read_unlock();
	}
}

exists (2:r0<>0 /\ 2:r3=0) (* Not found. *)

Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
Reported-by: Jonathan Corbet <corbet@lwn.net>
Closes: https://lore.kernel.org/linux-iommu/87a5uz3ob8.fsf@meer.lwn.net/
Signed-off-by: Petr Tesarik <petr@tesarici.cz>
---
 include/linux/swiotlb.h | 23 ++++++++++++++++-------
 kernel/dma/swiotlb.c    | 26 ++++++++++++++++++++------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b4536626f8ff..ecde0312dd52 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -172,14 +172,23 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 	if (!mem)
 		return false;
 
-	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
-		/* Pairs with smp_wmb() in swiotlb_find_slots() and
-		 * swiotlb_dyn_alloc(), which modify the RCU lists.
-		 */
-		smp_rmb();
-		return swiotlb_find_pool(dev, paddr);
-	}
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	/*
+	 * All SWIOTLB buffer addresses must have been returned by
+	 * swiotlb_tbl_map_single() and passed to a device driver.
+	 * If a SWIOTLB address is checked on another CPU, then it was
+	 * presumably loaded by the device driver from an unspecified private
+	 * data structure. Make sure that this load is ordered before reading
+	 * dev->dma_uses_io_tlb here and mem->pools in swiotlb_find_pool().
+	 *
+	 * This barrier pairs with smp_mb() in swiotlb_find_slots().
+	 */
+	smp_rmb();
+	return READ_ONCE(dev->dma_uses_io_tlb) &&
+		swiotlb_find_pool(dev, paddr);
+#else
 	return paddr >= mem->defpool.start && paddr < mem->defpool.end;
+#endif
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 394494a6b1f3..f8d2b79b5f21 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -729,9 +729,6 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
 	}
 
 	add_mem_pool(mem, pool);
-
-	/* Pairs with smp_rmb() in is_swiotlb_buffer(). */
-	smp_wmb();
 }
 
 /**
@@ -1152,9 +1149,26 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
 
 found:
-	dev->dma_uses_io_tlb = true;
-	/* Pairs with smp_rmb() in is_swiotlb_buffer() */
-	smp_wmb();
+	WRITE_ONCE(dev->dma_uses_io_tlb, true);
+
+	/*
+	 * The general barrier orders reads and writes against a presumed store
+	 * of the SWIOTLB buffer address by a device driver (to a driver private
+	 * data structure). It serves two purposes.
+	 *
+	 * First, the store to dev->dma_uses_io_tlb must be ordered before the
+	 * presumed store. This guarantees that the returned buffer address
+	 * cannot be passed to another CPU before updating dev->dma_uses_io_tlb.
+	 *
+	 * Second, the load from mem->pools must be ordered before the same
+	 * presumed store. This guarantees that the returned buffer address
+	 * cannot be observed by another CPU before an update of the RCU list
+	 * that was made by swiotlb_dyn_alloc() on a third CPU (cf. multicopy
+	 * atomicity).
+	 *
+	 * See also the comment in is_swiotlb_buffer().
+	 */
+	smp_mb();
 
 	*retpool = pool;
 	return index;
-- 
2.42.0

