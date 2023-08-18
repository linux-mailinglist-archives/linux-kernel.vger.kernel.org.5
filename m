Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11807806C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358417AbjHRH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358458AbjHRH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:56:41 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889A3C2B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:56:13 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRvLh446Nz9yYL;
        Fri, 18 Aug 2023 09:55:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fcxylVjVF3Iq; Fri, 18 Aug 2023 09:55:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRvLh34Trz9yYJ;
        Fri, 18 Aug 2023 09:55:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6332F8B76C;
        Fri, 18 Aug 2023 09:55:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kZjxaA0XkgDf; Fri, 18 Aug 2023 09:55:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (PO17626.IDSI0.si.c-s.fr [172.19.54.29])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 203C48B763;
        Fri, 18 Aug 2023 09:55:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37I7tVsv044178
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 09:55:31 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37I7tT6e044167;
        Fri, 18 Aug 2023 09:55:29 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        iommu@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dma-mapping, powerpc: Move arch_dma_set_mask() prototype into dma-map-ops.h
Date:   Fri, 18 Aug 2023 09:55:13 +0200
Message-ID: <008c4b0a118d37abac6b1ec89b5677b1c6e347ae.1692345210.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692345312; l=2113; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Y8eR5MYIcGQkcPhwL0fVutBBQ/r7VCI5rheBSQoEqXk=; b=XO0T0FdUaUCymsyFZIYpYhC/EYUO1TDuNQGEqyGRodx/ilSA1rtSQB+c2Ub6Pu5R7Xe6/jM+2 QNCruSdjUmcDFBaAS5JI25U06C5tlzYtRASAOEhqv8mPbApsymhu4dx
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_FAIL,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix the following error,

  CC      arch/powerpc/kernel/dma-mask.o
arch/powerpc/kernel/dma-mask.c:7:6: error: no previous prototype for 'arch_dma_set_mask' [-Werror=missing-prototypes]
    7 | void arch_dma_set_mask(struct device *dev, u64 dma_mask)
      |      ^~~~~~~~~~~~~~~~~

Move arch_dma_set_mask() definition into dma-map-ops.h and
include it in arch/powerpc/kernel/dma-mask.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma-mask.c | 1 +
 include/linux/dma-map-ops.h    | 6 ++++++
 kernel/dma/mapping.c           | 6 ------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma-mask.c b/arch/powerpc/kernel/dma-mask.c
index ffbbbc432612..5b07ca7b73aa 100644
--- a/arch/powerpc/kernel/dma-mask.c
+++ b/arch/powerpc/kernel/dma-mask.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <asm/machdep.h>
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9bf19b5bf755..6bca67e21bc1 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -509,4 +509,10 @@ pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 }
 #endif /* CONFIG_PCI_P2PDMA */
 
+#ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
+void arch_dma_set_mask(struct device *dev, u64 mask);
+#else
+#define arch_dma_set_mask(dev, mask)	do { } while (0)
+#endif
+
 #endif /* _LINUX_DMA_MAP_OPS_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9a4db5cce600..e323ca48f7f2 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -760,12 +760,6 @@ bool dma_pci_p2pdma_supported(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_pci_p2pdma_supported);
 
-#ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
-void arch_dma_set_mask(struct device *dev, u64 mask);
-#else
-#define arch_dma_set_mask(dev, mask)	do { } while (0)
-#endif
-
 int dma_set_mask(struct device *dev, u64 mask)
 {
 	/*
-- 
2.41.0

