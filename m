Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2588E780D46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377557AbjHRN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbjHRN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:57:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C964204;
        Fri, 18 Aug 2023 06:57:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so9067495e9.3;
        Fri, 18 Aug 2023 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692367061; x=1692971861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px92ERlElc4wesNBWinjmIr2HCi2x9DQzB2ZaP/fD6k=;
        b=fb8BqnyvjYGtA3NTQlNXnTM1J9GEa987M4uuKcyZ8LfmzHOEhBqGBxfTfi8pX1Pmo3
         NVxLNX07rxCDH/E6cJIeODtsSSPisX3NbX3ha/s1qA657Bn4LVsxlq65TMfsXjLaxX7Q
         gBe9w4whRXlAwBU/dr9Msx1CnVXSe5sAFPUhiEIUN684vQtRTCR5Q+K/TWPeadInV4eY
         IIpj58A0woHXiXHIynwHIBUafMnpCSbrKF+8tx3XOIYR4HPplM8qwEJ3VTkMdSFIje5y
         fuMcl6mlik4BaGNOz2mZYI1j/sRhqiodZ7vFBB+LMjEFs81/Rk6WSPpzhEjV/ycN1DQs
         NKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367061; x=1692971861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px92ERlElc4wesNBWinjmIr2HCi2x9DQzB2ZaP/fD6k=;
        b=Rg7TwqMvCyrqlxYt5MgS26WNJGIZCA16S6u5IZeJLkhx8SrzxcXixiJcZ+eM5zTzbI
         Dhajyw3VA9FJeZS8IDk3dG8DKyvCNrbdgl2KslTQnA78xcmXMQCcT2KIyaqf2JaOzZ4q
         OfInjcMndWg2Xmpx3kYpmTV21fNLp06mBlj+fG72p/n9zyCwMi8Dpwh5V6+C+RwQ+neK
         pQ3AjDlX7NZwwIVTQd7XzdRNJGsUidtsAGwAK3QJaFni/hDzarTydIb5MC190PpDT6MS
         qji+trIDiUV5oBKJb8ivYUPsRsd+GjYoxyzUkzNvIKJAHFPx1bMGNVvhAzR/1q95sBQw
         +fCQ==
X-Gm-Message-State: AOJu0YzZ3/VTyZo0SaaFFn2Vj4Rfey8JPXA1FY1TgsKLlTdl1kTGnQ4a
        hI2/SdC0vEQ4N6pN3uRJ0jM=
X-Google-Smtp-Source: AGHT+IHxobRI9e/jvEGblmCFX7B1XfOEPH2YhJ8+NawIAgryjWzb0wx6Adb++1SYwZFIml/u0vl+bg==
X-Received: by 2002:a1c:f701:0:b0:3fe:18d8:a61b with SMTP id v1-20020a1cf701000000b003fe18d8a61bmr2309081wmh.29.1692367060277;
        Fri, 18 Aug 2023 06:57:40 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:4b30:13e8:1d57:42fb])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c044e00b003fa96fe2bd9sm6444055wmb.22.2023.08.18.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:57:39 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v12 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations support
Date:   Fri, 18 Aug 2023 14:57:20 +0100
Message-Id: <20230818135723.80612-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Introduce support for nonstandard noncoherent systems in the RISC-V
architecture. It enables function pointer support to handle cache
management in such systems.

This patch adds a new configuration option called
"RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
support for cache management in nonstandard noncoherent systems.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v11 -> v12
* Renamed struct riscv_cache_ops -> struct riscv_nonstd_cache_ops

v10 -> v11
* Changed data type of size from unsigned long to size_t
* Reworded doc for struct riscv_cache_ops

v9 -> v10
* Added __ro_after_init compiler attribute for noncoherent_cache_ops
* Renamed clean -> wback
* Renamed inval -> inv
* Renamed flush -> wback_inv

v8 -> v9
* New patch
---
 arch/riscv/Kconfig                       |  7 ++++
 arch/riscv/include/asm/dma-noncoherent.h | 28 +++++++++++++++
 arch/riscv/mm/dma-noncoherent.c          | 43 ++++++++++++++++++++++++
 arch/riscv/mm/pmem.c                     | 13 +++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f52dd125ac5e..a629d383affb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -269,6 +269,13 @@ config RISCV_DMA_NONCOHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select DMA_DIRECT_REMAP
 
+config RISCV_NONSTANDARD_CACHE_OPS
+	bool
+	depends on RISCV_DMA_NONCOHERENT
+	help
+	  This enables function pointer support for non-standard noncoherent
+	  systems to handle cache management.
+
 config AS_HAS_INSN
 	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
 
diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
new file mode 100644
index 000000000000..312cfa0858fb
--- /dev/null
+++ b/arch/riscv/include/asm/dma-noncoherent.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#ifndef __ASM_DMA_NONCOHERENT_H
+#define __ASM_DMA_NONCOHERENT_H
+
+#include <linux/dma-direct.h>
+
+/*
+ * struct riscv_nonstd_cache_ops - Structure for non-standard CMO function pointers
+ *
+ * @wback: Function pointer for cache writeback
+ * @inv: Function pointer for invalidating cache
+ * @wback_inv: Function pointer for flushing the cache (writeback + invalidating)
+ */
+struct riscv_nonstd_cache_ops {
+	void (*wback)(phys_addr_t paddr, size_t size);
+	void (*inv)(phys_addr_t paddr, size_t size);
+	void (*wback_inv)(phys_addr_t paddr, size_t size);
+};
+
+extern struct riscv_nonstd_cache_ops noncoherent_cache_ops;
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_nonstd_cache_ops *ops);
+
+#endif	/* __ASM_DMA_NONCOHERENT_H */
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index 06b8fea58e20..a4f3f37859ae 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -9,13 +9,26 @@
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 static bool noncoherent_supported __ro_after_init;
 
+struct riscv_nonstd_cache_ops noncoherent_cache_ops __ro_after_init = {
+	.wback = NULL,
+	.inv = NULL,
+	.wback_inv = NULL,
+};
+
 static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback)) {
+		noncoherent_cache_ops.wback(paddr, size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.inv)) {
+		noncoherent_cache_ops.inv(paddr, size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback_inv)) {
+		noncoherent_cache_ops.wback_inv(paddr, size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
 }
 
@@ -95,6 +122,13 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	void *flush_addr = page_address(page);
 
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback_inv)) {
+		noncoherent_cache_ops.wback_inv(page_to_phys(page), size);
+		return;
+	}
+#endif
+
 	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
 }
 
@@ -120,3 +154,12 @@ void riscv_noncoherent_supported(void)
 	     "Non-coherent DMA support enabled without a block size\n");
 	noncoherent_supported = true;
 }
+
+void riscv_noncoherent_register_cache_ops(const struct riscv_nonstd_cache_ops *ops)
+{
+	if (!ops)
+		return;
+
+	noncoherent_cache_ops = *ops;
+}
+EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);
diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
index 089df92ae876..c5fc5ec96f6d 100644
--- a/arch/riscv/mm/pmem.c
+++ b/arch/riscv/mm/pmem.c
@@ -7,15 +7,28 @@
 #include <linux/libnvdimm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/dma-noncoherent.h>
 
 void arch_wb_cache_pmem(void *addr, size_t size)
 {
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.wback)) {
+		noncoherent_cache_ops.wback(virt_to_phys(addr), size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
 void arch_invalidate_pmem(void *addr, size_t size)
 {
+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (unlikely(noncoherent_cache_ops.inv)) {
+		noncoherent_cache_ops.inv(virt_to_phys(addr), size);
+		return;
+	}
+#endif
 	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-- 
2.34.1

