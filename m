Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8727F93EA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKZQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:37:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB0D7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:37:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2236C433C7;
        Sun, 26 Nov 2023 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701016674;
        bh=14LKXLMt/+5p7qNVS51zb2f8quhJJfzs+4w5ju16qQE=;
        h=From:To:Cc:Subject:Date:From;
        b=mt7oHGf9eqanTX1nkP81wW4zCU1I2igViCVsXynMsPOkiJ6FEJmGV3NY3UUTdBhbj
         1Pj5QIjP6KqCyvS7c2o5SObZ73Os35SJblEnA86rrUC2Pq/Q6cRqf/pLj2r8cvXTKI
         J9ojaEZvebtfR1eAn00K/dtPAx6ldxX9WhHRCOP7ZYJ4D5xWD/dd2sk0MTqLmpR2sf
         y0FH0hkb9xRAWaNDFq91uV+HkipxIhLnGdQGEZe4pCGvxQaVoyrhPSsE07JFRUwqTa
         icYlYgsGQWf5zPKFq/5j2XdxddlL7yX5q4BjVli5kdSgsECw7Dtbrwfta+pHqpCYXi
         yfPhtdRPfHtjw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: still create swiotlb buffer for kmalloc() bouncing if required
Date:   Mon, 27 Nov 2023 00:25:28 +0800
Message-Id: <20231126162528.2411-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f51f7a0fc2f4 ("riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC
for !dma_coherent"), for non-coherent platforms with less than 4GB
memory, we rely on users to pass "swiotlb=mmnn,force" kernel parameters
to enable DMA bouncing for unaligned kmalloc() buffers. Now let's go
further: If no bouncing needed for ZONE_DMA, let kernel automatically
allocate 1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing on
non-coherent platforms, so that no need to pass "swiotlb=mmnn,force"
any more.

The math of "1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing"
is taken from arm64. Users can still force smaller swiotlb buffer by
passing "swiotlb=mmnn".

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2e011cbddf3a..cbcb9918f721 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -162,11 +162,25 @@ static void print_vm_layout(void) { }
 
 void __init mem_init(void)
 {
+	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
-	swiotlb_init(max_pfn > PFN_DOWN(dma32_phys_limit), SWIOTLB_VERBOSE);
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
+	    dma_cache_alignment != 1) {
+		/*
+		 * If no bouncing needed for ZONE_DMA, allocate 1MB swiotlb
+		 * buffer per 1GB of RAM for kmalloc() bouncing on
+		 * non-coherent platforms.
+		 */
+		unsigned long size =
+			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
+		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
+		swiotlb = true;
+	}
+
+	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
 	memblock_free_all();
 
 	print_vm_layout();
-- 
2.42.0

