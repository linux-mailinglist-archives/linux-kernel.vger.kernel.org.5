Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8438477CB65
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjHOK7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbjHOK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:58:24 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B7B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:58:21 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RQ7Xq5Q3zz9sgl;
        Tue, 15 Aug 2023 12:58:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 35I_1FWIg5xz; Tue, 15 Aug 2023 12:58:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RQ7Xq4YBhz9sgk;
        Tue, 15 Aug 2023 12:58:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 984238B76C;
        Tue, 15 Aug 2023 12:58:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8HnwJpFcbP5f; Tue, 15 Aug 2023 12:58:19 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.223])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5400C8B763;
        Tue, 15 Aug 2023 12:58:19 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37FAwBrP077191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 12:58:11 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37FAw9lQ077190;
        Tue, 15 Aug 2023 12:58:09 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Move zalloc_maybe_bootmem() into pci-common.c
Date:   Tue, 15 Aug 2023 12:57:55 +0200
Message-ID: <4235adc9515a4b084f815cc12f24ef1ac2b43eba.1692097067.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692097074; l=3588; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=7P8PUpj4knPK7IjXYrS0Hvc31FR/JHVAdIARH2NQJQU=; b=xSL8aUcrGcbJXZE8h0NNjhr5UldtJ5uzYxIKloDP3CucTjaKVIG6VjsAZyvW533ssrmwuivai 3JIHfxS7617BmFnBWAf1xD88dfjiTsMIuM6Vb4QskmuBMoGNVTyD8IS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zalloc_maybe_bootmem() is only used by PCI related functions.

Move it into pci-common.c and remove the always built alloc.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/pci.h   |  2 ++
 arch/powerpc/include/asm/setup.h |  1 -
 arch/powerpc/kernel/pci-common.c | 16 ++++++++++++++++
 arch/powerpc/lib/Makefile        |  2 +-
 arch/powerpc/lib/alloc.c         | 23 -----------------------
 5 files changed, 19 insertions(+), 25 deletions(-)
 delete mode 100644 arch/powerpc/lib/alloc.c

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index f5078a7dd85a..13d36ec3a5ea 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -45,6 +45,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
+
 #ifdef CONFIG_PCI
 void __init set_pci_dma_ops(const struct dma_map_ops *dma_ops);
 #else	/* CONFIG_PCI */
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index e29e83f8a89c..eed74c1fb832 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -8,7 +8,6 @@
 extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned long long memory_limit;
-extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 struct device_node;
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e88d7c9feeec..34e66b06a030 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -31,6 +31,7 @@
 #include <linux/numa.h>
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
+#include <linux/memblock.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -121,6 +122,21 @@ static int get_phb_number(struct device_node *dn)
 	return phb_id;
 }
 
+void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
+{
+	void *p;
+
+	if (slab_is_available()) {
+		p = kzalloc(size, mask);
+	} else {
+		p = memblock_alloc(size, SMP_CACHE_BYTES);
+		if (!p)
+			panic("%s: Failed to allocate %zu bytes\n", __func__,
+			      size);
+	}
+	return p;
+}
+
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 9aa8286c9687..51ad0397c17a 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -27,7 +27,7 @@ endif
 CFLAGS_code-patching.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_feature-fixups.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
-obj-y += alloc.o code-patching.o feature-fixups.o pmem.o
+obj-y += code-patching.o feature-fixups.o pmem.o
 
 obj-$(CONFIG_CODE_PATCHING_SELFTEST) += test-code-patching.o
 
diff --git a/arch/powerpc/lib/alloc.c b/arch/powerpc/lib/alloc.c
deleted file mode 100644
index ce180870bd52..000000000000
--- a/arch/powerpc/lib/alloc.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/memblock.h>
-#include <linux/string.h>
-#include <asm/setup.h>
-
-
-void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
-{
-	void *p;
-
-	if (slab_is_available())
-		p = kzalloc(size, mask);
-	else {
-		p = memblock_alloc(size, SMP_CACHE_BYTES);
-		if (!p)
-			panic("%s: Failed to allocate %zu bytes\n", __func__,
-			      size);
-	}
-	return p;
-}
-- 
2.41.0

