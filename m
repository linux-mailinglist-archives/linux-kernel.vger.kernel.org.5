Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B479F8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjINDdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbjINDdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 281931BE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znbCARmlc3jzayhQdsOeRF7d+N1aifD5+DGhNcydCJU=;
        b=hrurn8O233RH7I8lSg4aJq864rbkAQvvc31spFhYcbh9v+E4IFnn7mezLj0isLX/++xA47
        NVQBQnEUP7wHywA3qrLJG6JpVoPR25IAzFKd2eToCKZXrSPBOfTlPJoe1aup43Dy72ogYR
        RZKL/Ahvpzxf1bIJS+l9dUOJgCO+jfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-XI4B-DCONTu_dVRWa_Pb7g-1; Wed, 13 Sep 2023 23:32:17 -0400
X-MC-Unique: XI4B-DCONTu_dVRWa_Pb7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A77B805B29;
        Thu, 14 Sep 2023 03:32:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546D710F1BEA;
        Thu, 14 Sep 2023 03:32:13 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code
Date:   Thu, 14 Sep 2023 11:31:39 +0800
Message-ID: <20230914033142.676708-7-bhe@redhat.com>
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
   reserve_crashkernel_generic(), and do the ARCH specific work if
   needed.

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/x86/Kconfig.

When adding DEFAULT_CRASH_KERNEL_LOW_SIZE, add crash_low_size_default()
to calculate crashkernel low memory because x86_64 has special
requirement.

The old reserve_crashkernel_low() and reserve_crashkernel() can be
removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig                  |   3 +
 arch/x86/include/asm/crash_core.h |  34 +++++++
 arch/x86/kernel/setup.c           | 144 ++++--------------------------
 3 files changed, 52 insertions(+), 129 deletions(-)
 create mode 100644 arch/x86/include/asm/crash_core.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..d5ebb2ad2ad6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2062,6 +2062,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
new file mode 100644
index 000000000000..5fc5e4f94521
--- /dev/null
+++ b/arch/x86/include/asm/crash_core.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_CRASH_CORE_H
+#define _X86_CRASH_CORE_H
+
+/* 16M alignment for crash kernel regions */
+#define CRASH_ALIGN             SZ_16M
+
+/*
+ * Keep the crash kernel below this limit.
+ *
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
+ * due to mapping restrictions.
+ *
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
+ */
+
+#ifdef CONFIG_X86_32
+# define CRASH_ADDR_LOW_MAX     SZ_512M
+# define CRASH_ADDR_HIGH_MAX    SZ_512M
+#else
+# define CRASH_ADDR_LOW_MAX     SZ_4G
+# define CRASH_ADDR_HIGH_MAX    SZ_64T
+#endif
+
+# define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
+
+extern unsigned long crash_low_size_default(void);
+
+#endif /* _X86_CRASH_CORE_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f945d88215b4..0acc86587fc0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -473,152 +473,38 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 /*
  * --------- Crashkernel reservation ------------------------------
  */
-
-/* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		SZ_16M
-
-/*
- * Keep the crash kernel below this limit.
- *
- * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
- * due to mapping restrictions.
- *
- * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
- * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jump could be from 5-level paging to 4-level paging, the jump will fail if
- * the kernel is put above 64 TB, and during the 1st kernel bootup there's
- * no good way to detect the paging mode of the target kernel which will be
- * loaded for dumping.
- */
-#ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	SZ_512M
-# define CRASH_ADDR_HIGH_MAX	SZ_512M
-#else
-# define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	SZ_64T
-#endif
-
-static int __init reserve_crashkernel_low(void)
+unsigned long crash_low_size_default(void)
 {
 #ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long low_mem_limit;
-	int ret;
-
-	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
-	if (ret) {
-		/*
-		 * two parts from kernel/dma/swiotlb.c:
-		 * -swiotlb size: user-specified with swiotlb= or default.
-		 *
-		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-		 * to 8M for other buffers that may need to stay low too. Also
-		 * make sure we allocate enough extra low memory so that we
-		 * don't run out of DMA buffers for 32-bit devices.
-		 */
-		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-	} else {
-		/* passed with crashkernel=0,low ? */
-		if (!low_size)
-			return 0;
-	}
-
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(low_mem_limit >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-#endif
+	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+#else
 	return 0;
+#endif
 }
 
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
+	unsigned long long crash_base, crash_size, low_size = 0;
+	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	total_mem = memblock_phys_mem_size();
-
-	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base, NULL, NULL);
-	if (ret != 0 || crash_size <= 0) {
-		/* crashkernel=X,high */
-		ret = parse_crashkernel_high(boot_command_line, total_mem,
-					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
-			return;
-		high = true;
-	}
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+				&crash_size, &crash_base,
+				&low_size, &high);
+	if (ret)
+		return;
 
 	if (xen_pv_domain()) {
 		pr_info("Ignoring crashkernel for a Xen PV domain\n");
 		return;
 	}
 
-	/* 0 means: find the address automatically */
-	if (!crash_base) {
-		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
-		 */
-		if (!high)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX);
-		if (!crash_base)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
-
-		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
-						  crash_base + crash_size);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
-
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 }
 
 static struct resource standard_io_resources[] = {
@@ -1232,7 +1118,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
 	 */
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 
 	memblock_find_dma_reserve();
 
-- 
2.41.0

