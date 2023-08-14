Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8477C181
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjHNUaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjHNU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:29:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58F110;
        Mon, 14 Aug 2023 13:29:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso47725055e9.1;
        Mon, 14 Aug 2023 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692044981; x=1692649781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZS9k4hytgqpdauCxiUcsVRcbK/dI1ReGuOryfTEBiQ=;
        b=XI+s+7CVo6H/28yrasQEb1zG0CwG8Gw05f+BBbim9Oy77Fpazbchju2ryuV0tjTxnr
         h4p39E5/3Y2DOzYrVii7nZ647u0y1DOTjG1u1/RgpMr45afmmprJhu02BDujXr5pNK6t
         EVIVj3/DpXqpRyqu3J+20MUl2BoYWCIKT9ooaxlFIlNW2JOUvBxCOH3x+EnXgcqtoVol
         t06B99iVi5vnYqpuBTR908hAgbWfElTfIs4B+rwmPAeUQqeoLLuMedM1VGUVYUDDImtk
         +Mggr7330KY8nN2/tPNHXgPYag8EoYWaQ71t4EfrwZT5EDayIRerCKViGZPsyp3Yz7ha
         gcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044981; x=1692649781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZS9k4hytgqpdauCxiUcsVRcbK/dI1ReGuOryfTEBiQ=;
        b=NB9wJ242U59j4SsiuZXb46ZSd1AEwpqPjSX4bqQQpRKT8170NEX7YI0pQOKxE6pe6h
         UmxLfgcWnmcczjZHJYZwmIkfHQ+lVR9aj64lQdpieRyrZFelOwvQkuoDwoD+4Pc2TO+O
         Kjs4xE7ODNoVoQMFSpJTOqkwGvBiQJ1m+T6EETfLDdM6ZsdALuUwXLsIva3Z5YclHYI6
         scBGfnrGV873+iHNh6AUlFUbFPwhKgKkRmzZW4OCT2bH3uY8krdPE/4DUbRosmxkgWQc
         uLh+OpfDqHiLMJ0GQiz4uUI3j8iQ2FaPhaSAFZU/KH1XZXNuSNCsyiX+m5AisYCf0T4i
         BkRQ==
X-Gm-Message-State: AOJu0YwAOj5aFKqj5WzwIuntSq2QNDNQMoL8lVZqRUuKdGEoEWSFlA1Y
        VHVrOGjGtEclUyoXqKbgtkA=
X-Google-Smtp-Source: AGHT+IHQ7bdRxGxrq2fuUzX2MdpRR3MB+8ItcJVxiqiOb/Bhlr4j/+phIulI07DH0brzvBPdxURdIA==
X-Received: by 2002:a05:600c:253:b0:3fe:1d13:4664 with SMTP id 19-20020a05600c025300b003fe1d134664mr9172860wmj.6.1692044980914;
        Mon, 14 Aug 2023 13:29:40 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003fd2d33ea53sm15181223wmj.14.2023.08.14.13.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:29:40 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [(subset) PATCH v2 3/3] riscv: dma-mapping: replace custom code with generic implementation
Date:   Mon, 14 Aug 2023 21:28:21 +0100
Message-Id: <20230814202821.78120-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814202821.78120-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230814202821.78120-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Now that all of these have consistent behavior, replace them with
a single shared implementation of arch_sync_dma_for_device() and
arch_sync_dma_for_cpu() and three parameters to pick how they should
operate:

 - If the CPU has speculative prefetching, then the cache
   has to be invalidated after a transfer from the device.
   On the rarer CPUs without prefetching, this can be skipped,
   with all cache management happening before the transfer.
   This flag can be runtime detected, but is usually fixed
   per architecture.

 - Some architectures currently clean the caches before DMA
   from a device, while others invalidate it. There has not
   been a conclusion regarding whether we should change all
   architectures to use clean instead, so this adds an
   architecture specific flag that we can change later on.

For the function naming, I picked 'wback' over 'clean', and 'wback_inv'
over 'flush', to avoid any ambiguity of what the helper functions are
supposed to do.

Moving the global functions into a header file is usually a bad idea
as it prevents the header from being included more than once, but it
helps keep the behavior as close as possible to the previous state,
including the possibility of inlining most of it into these functions
where that was done before. This also helps keep the global namespace
clean, by hiding the new arch_dma_cache{_wback,_inv,_wback_inv} from
device drivers that might use them incorrectly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[PL: Dropped other archs, updated commit message and fixed checkpatch issues]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Updated commit message
* Fixed checkpatch issues
* Dropped other archs
---
 arch/riscv/mm/dma-noncoherent.c |  50 +++++++-------
 include/linux/dma-sync.h        | 113 ++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/dma-sync.h

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index fc6377a64c8d..b6a1e9cc9339 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -12,43 +12,39 @@
 
 static bool noncoherent_supported __ro_after_init;
 
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-			      enum dma_data_direction dir)
+static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
-	switch (dir) {
-	case DMA_TO_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-		break;
-	case DMA_FROM_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-		break;
-	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-		break;
-	default:
-		break;
-	}
+	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 }
 
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-			   enum dma_data_direction dir)
+static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
-	switch (dir) {
-	case DMA_TO_DEVICE:
-		break;
-	case DMA_FROM_DEVICE:
-	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
-		break;
-	default:
-		break;
-	}
+	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 }
 
+static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+}
+
+static inline bool arch_sync_dma_clean_before_fromdevice(void)
+{
+	return true;
+}
+
+static inline bool arch_sync_dma_cpu_needs_post_dma_flush(void)
+{
+	return true;
+}
+
+#include <linux/dma-sync.h>
+
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	void *flush_addr = page_address(page);
diff --git a/include/linux/dma-sync.h b/include/linux/dma-sync.h
new file mode 100644
index 000000000000..be23e8dda2e2
--- /dev/null
+++ b/include/linux/dma-sync.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Cache operations depending on function and direction argument, inspired by
+ * https://lore.kernel.org/lkml/20180518175004.GF17671@n2100.armlinux.org.uk
+ * "dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
+ * dma-mapping: provide a generic dma-noncoherent implementation)"
+ *
+ *          |   map          ==  for_device     |   unmap     ==  for_cpu
+ *          |----------------------------------------------------------------
+ * TO_DEV   |   writeback        writeback      |   none          none
+ * FROM_DEV |   invalidate       invalidate     |   invalidate*   invalidate*
+ * BIDIR    |   writeback        writeback      |   invalidate    invalidate
+ *
+ *     [*] needed for CPU speculative prefetches
+ *
+ * NOTE: we don't check the validity of direction argument as it is done in
+ * upper layer functions (in include/linux/dma-mapping.h)
+ *
+ * This file can be included by arch/.../kernel/dma-noncoherent.c to provide
+ * the respective high-level operations without having to expose the
+ * cache management ops to drivers.
+ */
+
+#ifndef __DMA_SYNC_H__
+#define __DMA_SYNC_H__
+
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		/*
+		 * This may be an empty function on write-through caches,
+		 * and it might invalidate the cache if an architecture has
+		 * a write-back cache but no way to write it back without
+		 * invalidating
+		 */
+		arch_dma_cache_wback(paddr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		/*
+		 * FIXME: this should be handled the same across all
+		 * architectures, see
+		 * https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/
+		 */
+		if (!arch_sync_dma_clean_before_fromdevice()) {
+			arch_dma_cache_inv(paddr, size);
+			break;
+		}
+		fallthrough;
+
+	case DMA_BIDIRECTIONAL:
+		/* Skip the invalidate here if it's done later */
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
+		    arch_sync_dma_cpu_needs_post_dma_flush())
+			arch_dma_cache_wback(paddr, size);
+		else
+			arch_dma_cache_wback_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
+}
+
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
+/*
+ * Mark the D-cache clean for these pages to avoid extra flushing.
+ */
+static void arch_dma_mark_dcache_clean(phys_addr_t paddr, size_t size)
+{
+#ifdef CONFIG_ARCH_DMA_MARK_DCACHE_CLEAN
+	unsigned long pfn = PFN_UP(paddr);
+	unsigned long off = paddr & (PAGE_SIZE - 1);
+	size_t left = size;
+
+	if (off)
+		left -= PAGE_SIZE - off;
+
+	while (left >= PAGE_SIZE) {
+		struct page *page = pfn_to_page(pfn++);
+
+		set_bit(PG_dcache_clean, &page->flags);
+		left -= PAGE_SIZE;
+	}
+#endif
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+			   enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		/* FROM_DEVICE invalidate needed if speculative CPU prefetch only */
+		if (arch_sync_dma_cpu_needs_post_dma_flush())
+			arch_dma_cache_inv(paddr, size);
+
+		if (size > PAGE_SIZE)
+			arch_dma_mark_dcache_clean(paddr, size);
+		break;
+
+	default:
+		break;
+	}
+}
+#endif
+#endif /* __DMA_SYNC_H__ */
-- 
2.34.1

