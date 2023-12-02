Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D617801D2C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjLBNyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjLBNyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:54:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CC116
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:54:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848CCC433C7;
        Sat,  2 Dec 2023 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701525290;
        bh=bomojrOAMU2gHGxmYDLygOQUoO4KABGe2Me37Cc0YE0=;
        h=From:To:Cc:Subject:Date:From;
        b=TLDhW872Qeq6T2lOiL/tmbelYRkMW2rIQaE4jkN2Q7OnQKvnK0+B81Hngx2UZIR6/
         ETWx7tcNYE1TVKJ/8r0TWFldBBt2c6NYUdKvD/W53sET147ei1ih0uJTMZ62Xg1vv+
         D/4V4wCKLUKiU811CGfxekWJC4K6Fggm+IeihHucqryvW612yFnA8LGBAEtNM8svgs
         vMuRCcbUFUwuUPLb6beNdkzHMJzbgsMvem8OkFLCefLaFbR1d0cEhJFlyN0VhjWcFn
         yRoteBGcCKVHJ9iOC9iJtNNYym5kkvhP81ByRe4F8vGM9m0Du3s0rI+Ok4JtfJDPIx
         Vyg8Ib3CbhMAQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: mm: still create swiotlb buffer for kmalloc() bouncing if required
Date:   Sat,  2 Dec 2023 21:42:24 +0800
Message-Id: <20231202134224.4029-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

since v2:
 - fix build error if CONFIG_RISCV_DMA_NONCOHERENT=n

 arch/riscv/include/asm/cache.h |  2 +-
 arch/riscv/mm/init.c           | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index 2174fe7bac9a..570e9d8acad1 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -26,8 +26,8 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_RISCV_DMA_NONCOHERENT
 extern int dma_cache_alignment;
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
 #define dma_get_cache_alignment dma_get_cache_alignment
 static inline int dma_get_cache_alignment(void)
 {
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

