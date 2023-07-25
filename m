Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057EF76182B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGYMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjGYMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:23:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321AEE7E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:23:21 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9GPY1KxlzrRvc;
        Tue, 25 Jul 2023 20:22:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 20:23:17 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <catalin.marinas@arm.com>, <ill@kernel.org>,
        <mark.rutland@arm.com>, <ryan.roberts@arm.com>,
        <joey.gouly@arm.com>, <ardb@kernel.org>,
        <anshuman.khandual@arm.com>, <bhe@redhat.com>,
        <thunder.leizhen@huawei.com>, <broonie@kernel.org>
CC:     <chris.zjh@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3] arm64: fix build warning for ARM64_MEMSTART_SHIFT
Date:   Tue, 25 Jul 2023 20:24:04 +0000
Message-ID: <20230725202404.3470111-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, the following warning occurs.

arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
  129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
      |                                         ^~~~~~~~~
arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
  142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
      |     ^~~~~~~~~~~~~~~~~~~~

The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS == 3
and CONFIG_VA_BITS == 39. Now move the macro ARM64_MEMSTART_SHIFT and
ARM64_MEMSTART_ALIGN to arch/arm64/mm/init.c where it is used to avoid
this issue, and also there is no other place to call these two macro.

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
v3:
	Move the defination of macro ARM64_MEMSTART_SHIFT and ARM64_MEMSTART_ALIGN
	from arch/arm64/include/asm/kernel-pgtable.h to arch/arm64/mm/init.c

v2:
	Add define judgement of PUD_SHIFT/CONT_PMD_SHIFT/CONT_PMD_SHIFT
	before use them, instead of define PUD_SHIFT only.
---
---
 arch/arm64/include/asm/kernel-pgtable.h | 27 -------------------------
 arch/arm64/mm/init.c                    | 27 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 577773870b66..85d26143faa5 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -118,31 +118,4 @@
 #define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PTE_RDONLY)
 #endif
 
-/*
- * To make optimal use of block mappings when laying out the linear
- * mapping, round down the base of physical memory to a size that can
- * be mapped efficiently, i.e., either PUD_SIZE (4k granule) or PMD_SIZE
- * (64k granule), or a multiple that can be mapped using contiguous bits
- * in the page tables: 32 * PMD_SIZE (16k granule)
- */
-#if defined(CONFIG_ARM64_4K_PAGES)
-#define ARM64_MEMSTART_SHIFT		PUD_SHIFT
-#elif defined(CONFIG_ARM64_16K_PAGES)
-#define ARM64_MEMSTART_SHIFT		CONT_PMD_SHIFT
-#else
-#define ARM64_MEMSTART_SHIFT		PMD_SHIFT
-#endif
-
-/*
- * sparsemem vmemmap imposes an additional requirement on the alignment of
- * memstart_addr, due to the fact that the base of the vmemmap region
- * has a direct correspondence, and needs to appear sufficiently aligned
- * in the virtual address space.
- */
-#if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
-#define ARM64_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
-#else
-#define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_SHIFT)
-#endif
-
 #endif	/* __ASM_KERNEL_PGTABLE_H */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d31c3a9290c5..4fcb88a445ef 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -73,6 +73,33 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
 #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
 
+/*
+ * To make optimal use of block mappings when laying out the linear
+ * mapping, round down the base of physical memory to a size that can
+ * be mapped efficiently, i.e., either PUD_SIZE (4k granule) or PMD_SIZE
+ * (64k granule), or a multiple that can be mapped using contiguous bits
+ * in the page tables: 32 * PMD_SIZE (16k granule)
+ */
+#if defined(CONFIG_ARM64_4K_PAGES)
+#define ARM64_MEMSTART_SHIFT		PUD_SHIFT
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define ARM64_MEMSTART_SHIFT		CONT_PMD_SHIFT
+#else
+#define ARM64_MEMSTART_SHIFT		PMD_SHIFT
+#endif
+
+/*
+ * sparsemem vmemmap imposes an additional requirement on the alignment of
+ * memstart_addr, due to the fact that the base of the vmemmap region
+ * has a direct correspondence, and needs to appear sufficiently aligned
+ * in the virtual address space.
+ */
+#if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
+#define ARM64_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
+#else
+#define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_SHIFT)
+#endif
+
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base;
-- 
2.34.1

