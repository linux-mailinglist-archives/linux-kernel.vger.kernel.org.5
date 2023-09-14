Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5679F8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjINDdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjINDdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F59C1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4jC+G8oubwmQKpLyCRffsk3UN+AgofxpDQ8X9qiUgY=;
        b=HImzY1obLLpus64c+gE3fMKIYRKO8Xxb5ZK7Js6IGSXQ+K6VaeocxsZxISI7l4TbvqvaPf
        UE/Wg6djaUH2oZemHTgJnyBF4+rWO4KqGzh1z7gf7izvvQ220rJaOdqIOOfnXMR9LhyoLu
        P4aKiMUuWnXidRj0vUhJwD/AdqRUMEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-xCpiW4koM0-mxEU5PZgrag-1; Wed, 13 Sep 2023 23:32:27 -0400
X-MC-Unique: xCpiW4koM0-mxEU5PZgrag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2E1B185A78E;
        Thu, 14 Sep 2023 03:32:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1F001008808;
        Thu, 14 Sep 2023 03:32:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 8/9] riscv: kdump: use generic interface to simplify crashkernel reservation
Date:   Thu, 14 Sep 2023 11:31:41 +0800
Message-ID: <20230914033142.676708-9-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of newly changed function parse_crashkernel() and
generic reserve_crashkernel_generic(), crashkernel reservation can be
simplified by steps:

1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
   CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
   DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic();

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/riscv/Kconfig.

The old reserve_crashkernel_low() and reserve_crashkernel() can be
removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/Kconfig                  |   3 +
 arch/riscv/include/asm/crash_core.h |  11 +++
 arch/riscv/include/asm/processor.h  |   2 +
 arch/riscv/mm/init.c                | 141 +++-------------------------
 4 files changed, 27 insertions(+), 130 deletions(-)
 create mode 100644 arch/riscv/include/asm/crash_core.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..25474f8c12b7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -694,6 +694,9 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config COMPAT
 	bool "Kernel support for 32-bit U-mode"
 	default 64BIT
diff --git a/arch/riscv/include/asm/crash_core.h b/arch/riscv/include/asm/crash_core.h
new file mode 100644
index 000000000000..e1874b23feaf
--- /dev/null
+++ b/arch/riscv/include/asm/crash_core.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _RISCV_CRASH_CORE_H
+#define _RISCV_CRASH_CORE_H
+
+#define CRASH_ALIGN			PMD_SIZE
+
+#define CRASH_ADDR_LOW_MAX		dma32_phys_limit
+#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
+
+extern phys_addr_t memblock_end_of_DRAM(void);
+#endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3e23e1786d05..441da1839c94 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -116,6 +116,8 @@ static inline void wait_for_interrupt(void)
 	__asm__ __volatile__ ("wfi");
 }
 
+extern phys_addr_t dma32_phys_limit;
+
 struct device_node;
 int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
 int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *hartid);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9fe448900059..d9a4e8702864 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -65,7 +65,7 @@ extern char _start[];
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
-static phys_addr_t dma32_phys_limit __initdata;
+phys_addr_t dma32_phys_limit __initdata;
 
 static void __init zone_sizes_init(void)
 {
@@ -1333,28 +1333,6 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
-/* Reserve 128M low memory by default for swiotlb buffer */
-#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
-
-static int __init reserve_crashkernel_low(unsigned long long low_size)
-{
-	unsigned long long low_base;
-
-	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
-	if (!low_base) {
-		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
-		return -ENOMEM;
-	}
-
-	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		low_base, low_base + low_size, low_size >> 20);
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end = low_base + low_size - 1;
-
-	return 0;
-}
-
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -1362,122 +1340,25 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  * line parameter. The memory reserved is used by dump capture kernel when
  * primary kernel is crashing.
  */
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_base = 0;
-	unsigned long long crash_size = 0;
-	unsigned long long crash_low_size = 0;
-	unsigned long search_start = memblock_start_of_DRAM();
-	unsigned long search_end = (unsigned long)dma32_phys_limit;
+	unsigned long long low_size = 0;
+	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
-	bool fixed_base = false;
 	bool high = false;
-
-	int ret = 0;
+	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
-	/*
-	 * Don't reserve a region for a crash kernel on a crash kernel
-	 * since it doesn't make much sense and we have limited memory
-	 * resources.
-	 */
-	if (is_kdump_kernel()) {
-		pr_info("crashkernel: ignoring reservation request\n");
-		return;
-	}
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base, NULL, NULL);
-	if (ret == -ENOENT) {
-		/* Fallback to crashkernel=X,[high,low] */
-		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
-		if (ret || !crash_size)
-			return;
-
-		/*
-		 * crashkernel=Y,low is valid only when crashkernel=X,high
-		 * is passed.
-		 */
-		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
-		if (ret == -ENOENT)
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-		else if (ret)
-			return;
-
-		search_start = (unsigned long)dma32_phys_limit;
-		search_end = memblock_end_of_DRAM();
-		high = true;
-	} else if (ret || !crash_size) {
-		/* Invalid argument value specified */
+				&crash_size, &crash_base,
+				&low_size, &high);
+	if (ret)
 		return;
-	}
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	if (crash_base) {
-		fixed_base = true;
-		search_start = crash_base;
-		search_end = crash_base + crash_size;
-	}
-
-	/*
-	 * Current riscv boot protocol requires 2MB alignment for
-	 * RV64 and 4MB alignment for RV32 (hugepage size)
-	 *
-	 * Try to alloc from 32bit addressible physical memory so that
-	 * swiotlb can work on the crash kernel.
-	 */
-	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-					       search_start, search_end);
-	if (crash_base == 0) {
-		/*
-		 * For crashkernel=size[KMG]@offset[KMG], print out failure
-		 * message if can't reserve the specified region.
-		 */
-		if (fixed_base) {
-			pr_warn("crashkernel: allocating failed with given size@offset\n");
-			return;
-		}
-
-		if (high) {
-			/*
-			 * For crashkernel=size[KMG],high, if the first attempt was
-			 * for high memory, fall back to low memory.
-			 */
-			search_start = memblock_start_of_DRAM();
-			search_end = (unsigned long)dma32_phys_limit;
-		} else {
-			/*
-			 * For crashkernel=size[KMG], if the first attempt was for
-			 * low memory, fall back to high memory, the minimum required
-			 * low memory will be reserved later.
-			 */
-			search_start = (unsigned long)dma32_phys_limit;
-			search_end = memblock_end_of_DRAM();
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-		}
-
-		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-						       search_start, search_end);
-		if (crash_base == 0) {
-			pr_warn("crashkernel: couldn't allocate %lldKB\n",
-				crash_size >> 10);
-			return;
-		}
-	}
-
-	if ((crash_base >= dma32_phys_limit) && crash_low_size &&
-	     reserve_crashkernel_low(crash_low_size)) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
 
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 }
 
 void __init paging_init(void)
@@ -1495,7 +1376,7 @@ void __init misc_mem_init(void)
 	arch_numa_init();
 	sparse_init();
 	zone_sizes_init();
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 	memblock_dump_all();
 }
 
-- 
2.41.0

