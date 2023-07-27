Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A4E7653D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjG0M1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjG0M1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF449DD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F9861E5A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C7C433C8;
        Thu, 27 Jul 2023 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460775;
        bh=27hdkgrWFVckIqtGKwcqckK1Jo4k5q7PyN7ZJPYm1Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=G1IXjkALkleX4HzpP/GBUU4jC0fioQoVwq9nLLdOBjMTiQUNvINgLBZWZSKZRzFjp
         rPNxwdh576pES6qHQaW63U5RrOmgCMISK0DCvCcjlsS0F0CVfpmd2mvuyHNGB8lByr
         XJfIsEAigySm7RvZBH/ymFF5ooJ7tHkC+pqepI3potipnIRue/OQfyjH3lK2i9qOGw
         TTMEdeWmERD7kuxrWK/kHWbcAE8fEIeHPV8VUE7PnNQbqQsatYfsLSU+lZHaTQcLP/
         OLylrNrJgkBI21vtBnota2Sd4H4ehNblQw5px/x0jcXDNPZjKeeOP3wcFTuPwxCxgM
         gQtvCfdH30sSw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [PATCH] dma-mapping: move arch_dma_set_mask() declaration to header
Date:   Thu, 27 Jul 2023 14:25:42 +0200
Message-Id: <20230727122608.2507415-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function has a __weak definition and an override that is only used on
freescale powerpc chips. The powerpc definition however does not see the
declaration that is in a .c file:

arch/powerpc/kernel/dma-mask.c:7:6: error: no previous prototype for 'arch_dma_set_mask' [-Werror=missing-prototypes]

Move it into the linux/dma-map-ops.h header where the other arch_dma_* functions
are declared.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma-mask.c | 1 +
 include/linux/dma-map-ops.h    | 6 ++++++
 kernel/dma/mapping.c           | 6 ------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma-mask.c b/arch/powerpc/kernel/dma-mask.c
index ffbbbc4326126..5b07ca7b73aac 100644
--- a/arch/powerpc/kernel/dma-mask.c
+++ b/arch/powerpc/kernel/dma-mask.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <asm/machdep.h>
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9bf19b5bf7559..bb5e06fd359d5 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -343,6 +343,12 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 
+#ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
+void arch_dma_set_mask(struct device *dev, u64 mask);
+#else
+#define arch_dma_set_mask(dev, mask)	do { } while (0)
+#endif
+
 #ifdef CONFIG_MMU
 /*
  * Page protection so that devices that can't snoop CPU caches can use the
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9a4db5cce6004..e323ca48f7f2a 100644
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
2.39.2

