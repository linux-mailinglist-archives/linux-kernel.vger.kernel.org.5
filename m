Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560D758106
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjGRPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjGRPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:34:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375161B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75D76163F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F9CC433C7;
        Tue, 18 Jul 2023 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694429;
        bh=dNhCnd7BRoxmEqrazlgCFOTdL35V2PIvQRzI8MBzvnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFQ8InmJBGLXenNwP9TnDxUAeYjLdfDQrr8/wvAJCYqc4mrpPIq0ZDaoObnj9De23
         Qr6f29az56t/spK0A4QRGSAeLEwJMUgG48Ea3TRX4Mzt7N6F552Zxe6gSg6zzQ4Wu5
         lc7cKIYgNIRocm20YW0mn47mMNx1yfPpDKXKU3jb2Kzyf9MYBc6RoEv1XSEsdxNufS
         BbzcZzQWpU0+m0GsJ/TUpMcScleur68RFM+hygwNFuVVfS1j1JfkENZpHBktkkGyn7
         jK13Hr1rjvd19fBFltYyTB3eo5n3GCF69fWeyK85m+M9rYBo/Wc/QvN/fRAI/PClLG
         uf+7JdXQJgsFA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: allow kmalloc() caches aligned to the smallest value
Date:   Tue, 18 Jul 2023 23:22:13 +0800
Message-Id: <20230718152214.2907-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230718152214.2907-1-jszhang@kernel.org>
References: <20230718152214.2907-1-jszhang@kernel.org>
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

Currently, riscv defines ARCH_DMA_MINALIGN as L1_CACHE_BYTES, I.E
64Bytes, if CONFIG_RISCV_DMA_NONCOHERENT=y. To support unified kernel
Image, usually we have to enable CONFIG_RISCV_DMA_NONCOHERENT, thus
it brings some bad effects to coherent platforms:

Firstly, it wastes memory, kmalloc-96, kmalloc-32, kmalloc-16 and
kmalloc-8 slab caches don't exist any more, they are replaced with
either kmalloc-128 or kmalloc-64.

Secondly, larger than necessary kmalloc aligned allocations results
in unnecessary cache/TLB pressure.

This issue also exists on arm64 platforms. From last year, Catalin
tried to solve this issue by decoupling ARCH_KMALLOC_MINALIGN from
ARCH_DMA_MINALIGN, limiting kmalloc() minimum alignment to
dma_get_cache_alignment() and replacing ARCH_KMALLOC_MINALIGN usage
in various drivers with ARCH_DMA_MINALIGN etc.[1]

One fact we can make use of for riscv: if the CPU doesn't support
ZICBOM or T-HEAD CMO, we know the platform is coherent. Based on
Catalin's work and above fact, we can easily solve the kmalloc align
issue for riscv: we can override dma_get_cache_alignment(), then let
it return ARCH_DMA_MINALIGN at the beginning and return 1 once we know
the underlying HW neither supports ZICBOM nor supports T-HEAD CMO.

So what about if the CPU supports ZICBOM or T-HEAD CMO, but all the
devices are dma coherent? Well, we use ARCH_DMA_MINALIGN as the
kmalloc minimum alignment, nothing changed in this case. This case
can be improved in the future.

After this patch, a simple test of booting to a small buildroot rootfs
on qemu shows:

kmalloc-96           5041    5041     96  ...
kmalloc-64           9606    9606     64  ...
kmalloc-32           5128    5128     32  ...
kmalloc-16           7682    7682     16  ...
kmalloc-8           10246   10246      8  ...

So we save about 1268KB memory. The saving will be much larger in normal
OS env on real HW platforms.

Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.3967031-1-catalin.marinas@arm.com/ [1]

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/cache.h      | 14 ++++++++++++++
 arch/riscv/include/asm/cacheflush.h |  2 ++
 arch/riscv/kernel/setup.c           |  1 +
 arch/riscv/mm/dma-noncoherent.c     |  8 ++++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index d3036df23ccb..2174fe7bac9a 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_RISCV_DMA_NONCOHERENT
 #define ARCH_DMA_MINALIGN L1_CACHE_BYTES
+#define ARCH_KMALLOC_MINALIGN	(8)
 #endif
 
 /*
@@ -23,4 +24,17 @@
 #define ARCH_SLAB_MINALIGN	16
 #endif
 
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_RISCV_DMA_NONCOHERENT
+extern int dma_cache_alignment;
+#define dma_get_cache_alignment dma_get_cache_alignment
+static inline int dma_get_cache_alignment(void)
+{
+	return dma_cache_alignment;
+}
+#endif
+
+#endif	/* __ASSEMBLY__ */
+
 #endif /* _ASM_RISCV_CACHE_H */
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8091b8bf4883..c640ab6f843b 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -55,8 +55,10 @@ void riscv_init_cbo_blocksizes(void);
 
 #ifdef CONFIG_RISCV_DMA_NONCOHERENT
 void riscv_noncoherent_supported(void);
+void __init riscv_set_dma_cache_alignment(void);
 #else
 static inline void riscv_noncoherent_supported(void) {}
+static inline void riscv_set_dma_cache_alignment(void) {}
 #endif
 
 /*
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 971fe776e2f8..027879b1557a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -311,6 +311,7 @@ void __init setup_arch(char **cmdline_p)
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
 		riscv_noncoherent_supported();
+	riscv_set_dma_cache_alignment();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d51a75864e53..811227e54bbd 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -11,6 +11,8 @@
 #include <asm/cacheflush.h>
 
 static bool noncoherent_supported __ro_after_init;
+int dma_cache_alignment __ro_after_init = ARCH_DMA_MINALIGN;
+EXPORT_SYMBOL_GPL(dma_cache_alignment);
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 			      enum dma_data_direction dir)
@@ -78,3 +80,9 @@ void riscv_noncoherent_supported(void)
 	     "Non-coherent DMA support enabled without a block size\n");
 	noncoherent_supported = true;
 }
+
+void __init riscv_set_dma_cache_alignment(void)
+{
+	if (!noncoherent_supported)
+		dma_cache_alignment = 1;
+}
-- 
2.40.1

