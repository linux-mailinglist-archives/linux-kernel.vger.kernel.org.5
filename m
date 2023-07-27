Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A37653E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjG0M26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjG0M2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA853C11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F6E61E58
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE70C433C7;
        Thu, 27 Jul 2023 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460845;
        bh=ZT1ZAhDl9Us1qyYzoAo30SmrH7DzyLRh79VUEapqkR8=;
        h=From:To:Cc:Subject:Date:From;
        b=KSvoBeVDFB2WLb/ZthrcY2/5un3LhBPT2h010VvMXIIbxrI9k59hU1haL9I4YmAS6
         bweh4UMZ2tZTtgDk02XSJzxUx4Wz9qX/Z7OS7DqzKWLefzH9tutQ4EP5x4IulZPjlz
         b7xs3B5CISDY6Ca7r+x3H+buQQjyB5STEpjdKEla1KsJU0Kymp8QufwNXQYuYctSTZ
         wnzD2l3VYqQOl443xDPNcz8wUWipGoQY25c3fSboxLLviwH5DATj3vti7Exfl4ukLq
         7/iXcE9hUcBeAYKXNUlgGZg49p4ypTI1VwvDCsYBt3sBw7swYO5Vd/9hHBquNi2Jjz
         P+7UhDPFeRwjA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: address missing-prototypes warnings
Date:   Thu, 27 Jul 2023 14:26:50 +0200
Message-Id: <20230727122720.2558065-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

There are a few warnings in powerpc64 defconfig builds after -Wmissing-prototypes
gets promoted from W=1 to the default warning set:

arch/powerpc/mm/book3s64/pgtable.c:422:6: error: no previous prototype for 'arch_report_meminfo' [-Werror=missing-prototypes]
arch/powerpc/mm/init_64.c:311:12: error: no previous prototype for '__vmemmap_free' [-Werror=missing-prototypes]
arch/powerpc/platforms/cell/ras.c:275:5: error: no previous prototype for 'cbe_sysreset_hack' [-Werror=missing-prototypes]
arch/powerpc/platforms/cell/spu_manage.c:29:21: error: no previous prototype for 'spu_devnode' [-Werror=missing-prototypes]
arch/powerpc/platforms/pasemi/time.c:12:17: error: no previous prototype for 'pas_get_boot_time' [-Werror=missing-prototypes]
arch/powerpc/platforms/powermac/feature.c:1532:13: error: no previous prototype for 'g5_phy_disable_cpu1' [-Werror=missing-prototypes]
arch/powerpc/platforms/86xx/pic.c:28:13: error: no previous prototype for 'mpc86xx_init_irq' [-Werror=missing-prototypes]
drivers/pci/pci-sysfs.c:936:13: error: no previous prototype for 'pci_adjust_legacy_attr' [-Werror=missing-prototypes]

Address these by including the right header files or marking the
functions static. The audit.c one is a bit tricky since compat_audit.h
cannot include regular kernel headers tht have conflicting types on
32-bit powerpc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/pci.h            | 3 ++-
 arch/powerpc/kernel/audit.c               | 3 ++-
 arch/powerpc/kernel/audit_32.h            | 7 +++++++
 arch/powerpc/kernel/compat_audit.c        | 2 ++
 arch/powerpc/mm/book3s64/pgtable.c        | 1 +
 arch/powerpc/mm/init_64.c                 | 2 +-
 arch/powerpc/platforms/86xx/pic.c         | 2 ++
 arch/powerpc/platforms/cell/ras.c         | 2 +-
 arch/powerpc/platforms/cell/spu_manage.c  | 1 +
 arch/powerpc/platforms/pasemi/pasemi.h    | 1 +
 arch/powerpc/platforms/pasemi/time.c      | 2 ++
 arch/powerpc/platforms/powermac/feature.c | 2 ++
 12 files changed, 24 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/kernel/audit_32.h

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 289f1ec85bc54..f5078a7dd85a5 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -82,7 +82,8 @@ extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 				      struct vm_area_struct *vma,
 				      enum pci_mmap_state mmap_state);
-
+extern void pci_adjust_legacy_attr(struct pci_bus *bus,
+				   enum pci_mmap_state mmap_type);
 #define HAVE_PCI_LEGACY	1
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
diff --git a/arch/powerpc/kernel/audit.c b/arch/powerpc/kernel/audit.c
index 1bcfca5fdf676..92298d6a3a37a 100644
--- a/arch/powerpc/kernel/audit.c
+++ b/arch/powerpc/kernel/audit.c
@@ -4,6 +4,8 @@
 #include <linux/audit.h>
 #include <asm/unistd.h>
 
+#include "audit_32.h"
+
 static unsigned dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
@@ -41,7 +43,6 @@ int audit_classify_arch(int arch)
 int audit_classify_syscall(int abi, unsigned syscall)
 {
 #ifdef CONFIG_PPC64
-	extern int ppc32_classify_syscall(unsigned);
 	if (abi == AUDIT_ARCH_PPC)
 		return ppc32_classify_syscall(syscall);
 #endif
diff --git a/arch/powerpc/kernel/audit_32.h b/arch/powerpc/kernel/audit_32.h
new file mode 100644
index 0000000000000..c6c79c3041ab2
--- /dev/null
+++ b/arch/powerpc/kernel/audit_32.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __AUDIT_32_H__
+#define __AUDIT_32_H__
+
+extern int ppc32_classify_syscall(unsigned);
+
+#endif
diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
index d92ffe4e5dc1c..57b38c592b9f3 100644
--- a/arch/powerpc/kernel/compat_audit.c
+++ b/arch/powerpc/kernel/compat_audit.c
@@ -3,6 +3,8 @@
 #include <linux/audit_arch.h>
 #include <asm/unistd.h>
 
+#include "audit_32.h"
+
 unsigned ppc32_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 75b938268b040..0558202103171 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -9,6 +9,7 @@
 #include <linux/memremap.h>
 #include <linux/pkeys.h>
 #include <linux/debugfs.h>
+#include <linux/proc_fs.h>
 #include <misc/cxl-base.h>
 
 #include <asm/pgalloc.h>
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 6db7a063ba63f..7241b8515f89b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -315,7 +315,7 @@ static unsigned long vmemmap_list_free(unsigned long start)
 	return vmem_back->phys;
 }
 
-void __ref __vmemmap_free(unsigned long start, unsigned long end,
+static void __ref __vmemmap_free(unsigned long start, unsigned long end,
 			  struct vmem_altmap *altmap)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 2c32c3488afbb..7cdb16dc8b936 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -12,6 +12,8 @@
 #include <asm/mpic.h>
 #include <asm/i8259.h>
 
+#include "mpc86xx.h"
+
 #ifdef CONFIG_PPC_I8259
 static void mpc86xx_8259_cascade(struct irq_desc *desc)
 {
diff --git a/arch/powerpc/platforms/cell/ras.c b/arch/powerpc/platforms/cell/ras.c
index 98db63b72d56b..f6b87926530cc 100644
--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -22,7 +22,7 @@
 #include <asm/cell-regs.h>
 
 #include "ras.h"
-
+#include "pervasive.h"
 
 static void dump_fir(int cpu)
 {
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index 74567b32c48c2..f464a1f2e5681 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -25,6 +25,7 @@
 
 #include "spufs/spufs.h"
 #include "interrupt.h"
+#include "spu_priv1_mmio.h"
 
 struct device_node *spu_devnode(struct spu *spu)
 {
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 3f277a200fd87..018c30665e1b3 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -4,6 +4,7 @@
 
 extern time64_t pas_get_boot_time(void);
 extern void pas_pci_init(void);
+struct pci_dev;
 extern void pas_pci_irq_fixup(struct pci_dev *dev);
 extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
 
diff --git a/arch/powerpc/platforms/pasemi/time.c b/arch/powerpc/platforms/pasemi/time.c
index ad721882c8b6f..70ac6db027d0e 100644
--- a/arch/powerpc/platforms/pasemi/time.c
+++ b/arch/powerpc/platforms/pasemi/time.c
@@ -9,6 +9,8 @@
 
 #include <asm/time.h>
 
+#include "pasemi.h"
+
 time64_t __init pas_get_boot_time(void)
 {
 	/* Let's just return a fake date right now */
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index ed58928469b5b..ed472b797e28a 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -37,6 +37,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/pmac_low_i2c.h>
 
+#include "pmac.h"
+
 #undef DEBUG_FEATURE
 
 #ifdef DEBUG_FEATURE
-- 
2.39.2

