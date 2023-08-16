Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8377EDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbjHPXYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347151AbjHPXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:23:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D083271F;
        Wed, 16 Aug 2023 16:23:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe8a1591c8so55757815e9.3;
        Wed, 16 Aug 2023 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692228229; x=1692833029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3AibLZ/flcMM8pjMbhTffSCLpDoNcTFNENKYYaFNY=;
        b=HVyU7R+7NAHiP1FHnuES28Woqar0atRkeoYGbaaacWeuA4/koMeyt7sWGUK2Ynjwk6
         47O7kvMM9nK3nI36bqh4DSCXGzVwhx0oTCphBopPWKKMVjyz/xjtF/WK2UmC7BukPkFc
         j/TiiIgSJqnuheF9Rsdz6rOCZIT7SGCP9aaFepCP6Sgr1qBAXitiX1NBq2QfoY7lZYN+
         V2g9luT63NSlPJCzbfSbqJZdutg+mM+QoCfCJ0cwJgwA2FiVj3rGoSvL0G3lfgqxZ9dT
         kQQuCXiima/MAqL5WWi71hRzx2jA9zZfbP5gvYXrqBH7aTwz5NxMSAf94rAhe8HsqTI1
         ODUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228229; x=1692833029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa3AibLZ/flcMM8pjMbhTffSCLpDoNcTFNENKYYaFNY=;
        b=af5m2iEcgIezMH37o+Y6F8E0s9GKqWriXgR2+96zThJnBk8ZA5PJtw40XF3m+XMaL3
         ye1IfoZjWeUXKKJUcsqTaYLg1zli35fwB9eTmqUA4CZuXFbWklqeuERzlpHHJYVFs3DF
         H0gJbkyg/Vy4vfF5svnPl1dvAzAaTon15j3vUnjR/m6N80GhcuaSRF7Z0u71sYBHezUF
         MQgRxyas/fW6D3Wztj/rHeEU2AvtAS91wWh82nUXjqop6k1xnJmgWMI3dOMskHyEzzk4
         q/AoEw9cd62Ja9ZZPSxWA1Zj0veu6FZGApnCvOaJBJl3d5jw9h8XG069PLEPt1wWUZ/G
         ts4A==
X-Gm-Message-State: AOJu0YxiJgm0KSaFHOifD4EUVPSjwIsbZFLevIS5NtnwzdcaTyyFNmX3
        1vQPPK6GQoXTsLqxHWHpKI4uhSVtFTWvlw==
X-Google-Smtp-Source: AGHT+IFnz3zO5DhsTq/r4acaRKYRoJxmqtk6kyVWxCNSs6D3aHnm7Cqcu25/wzXO/Vs8/Q9UZVonkA==
X-Received: by 2002:a7b:c8ca:0:b0:3f6:1474:905 with SMTP id f10-20020a7bc8ca000000b003f614740905mr2692739wml.29.1692228228455;
        Wed, 16 Aug 2023 16:23:48 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:aeb8:832b:ebc0:1bbf])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm22752617wrr.44.2023.08.16.16.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:23:47 -0700 (PDT)
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
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/3] riscv: dma-mapping: switch over to generic implementation
Date:   Thu, 17 Aug 2023 00:23:36 +0100
Message-Id: <20230816232336.164413-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add helper functions for cache wback/inval/clean and use them
arch_sync_dma_for_device()/arch_sync_dma_for_cpu() functions. The proposed
changes are in preparation for switching over to generic implementation.

Reorganization of the code is based on the patch (Link[0]) from Arnd.
For now I have dropped CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU check as this
will be enabled by default upon selection of RISCV_DMA_NONCOHERENT
and also dropped arch_dma_mark_dcache_clean().

Link[0]: https://lore.kernel.org/all/20230327121317.4081816-22-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Arnd,
I have kept the changes minimal here as compared to your original patch and
dropped arch_dma_mark_dcache_clean() function and config checks for now as we
are currently implementing for riscv only.

Cheers, Prabhakar

v3:
* New patch
---
 arch/riscv/mm/dma-noncoherent.c | 60 ++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index fc6377a64c8d..06b8fea58e20 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -12,21 +12,61 @@
 
 static bool noncoherent_supported __ro_after_init;
 
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-			      enum dma_data_direction dir)
+static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+}
+
+static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+}
+
+static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
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
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
+{
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+		arch_dma_cache_wback(paddr, size);
 		break;
+
 	case DMA_FROM_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-		break;
+		if (!arch_sync_dma_clean_before_fromdevice()) {
+			arch_dma_cache_inv(paddr, size);
+			break;
+		}
+		fallthrough;
+
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+		/* Skip the invalidate here if it's done later */
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
+		    arch_sync_dma_cpu_needs_post_dma_flush())
+			arch_dma_cache_wback(paddr, size);
+		else
+			arch_dma_cache_wback_inv(paddr, size);
 		break;
+
 	default:
 		break;
 	}
@@ -35,15 +75,17 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 			   enum dma_data_direction dir)
 {
-	void *vaddr = phys_to_virt(paddr);
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		break;
+
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+		/* FROM_DEVICE invalidate needed if speculative CPU prefetch only */
+		if (arch_sync_dma_cpu_needs_post_dma_flush())
+			arch_dma_cache_inv(paddr, size);
 		break;
+
 	default:
 		break;
 	}
-- 
2.34.1

