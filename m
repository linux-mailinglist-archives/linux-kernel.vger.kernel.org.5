Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9B789CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjH0KNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjH0KNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64210132
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693131130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7abeATfyQslvBYUQ06/AS2G+fIAqveQCmkXKLRWolm0=;
        b=KeTrYZY89QWYa3vVRjHCZkUZKEcpOA70TnzDjt/ACvLIlNm+JNJm39bDpa4AsQtSe/uI+E
        7RiubL4GRg/eLhuAqd06tNW1UWup5CQ4bTvB4RbqiU/bw42Hs8DUaMCXCUEoDu57OVa85h
        6m23o+ElUy8yVmT3gdBSIA6De6/Jhyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-2nrDBWI6N7WxvX9oaANdOw-1; Sun, 27 Aug 2023 06:12:05 -0400
X-MC-Unique: 2nrDBWI6N7WxvX9oaANdOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3EA58015AB;
        Sun, 27 Aug 2023 10:12:04 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94AE92166B25;
        Sun, 27 Aug 2023 10:12:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 6/8] arm64: kdump: use generic interface to simplify crashkernel reservation
Date:   Sun, 27 Aug 2023 18:11:25 +0800
Message-ID: <20230827101128.70931-7-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of newly changed function parse_crashkernel() and
generic reserve_crashkernel_generic(), crashkernel reservation can be
simplified by steps:

1) Provide CRASH_ALIGN, CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
   DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/kexec.h>;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic();

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/arm64/Kconfig.

The old reserve_crashkernel_low() and reserve_crashkernel() can be
removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/Kconfig             |   3 +
 arch/arm64/include/asm/kexec.h |   5 ++
 arch/arm64/mm/init.c           | 140 ++-------------------------------
 3 files changed, 16 insertions(+), 132 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2511b30d0f6..6739e7b456b9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1481,6 +1481,9 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9ac9572a3bbe..442fc13588a2 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -132,4 +132,9 @@ extern int load_other_segments(struct kimage *image,
 
 #endif /* __ASSEMBLY__ */
 
+/* Current arm64 boot protocol requires 2MB alignment */
+#define CRASH_ALIGN                     SZ_2M
+
+#define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
+#define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
 #endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 36967b82c150..2e63954a2574 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -64,149 +64,25 @@ EXPORT_SYMBOL(memstart_addr);
  */
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
-/* Current arm64 boot protocol requires 2MB alignment */
-#define CRASH_ALIGN			SZ_2M
-
-#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
-#define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
-#define CRASH_HIGH_SEARCH_BASE		SZ_4G
-
-#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
-
-static int __init reserve_crashkernel_low(unsigned long long low_size)
-{
-	unsigned long long low_base;
-
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
-	if (!low_base) {
-		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
-		return -ENOMEM;
-	}
-
-	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
-		low_base, low_base + low_size, low_size >> 20);
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-
-	return 0;
-}
-
-/*
- * reserve_crashkernel() - reserves memory for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
- */
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_low_size = 0, search_base = 0;
-	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
+	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
-	bool fixed_base = false;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base, NULL, NULL);
-	if (ret == -ENOENT) {
-		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
-		if (ret || !crash_size)
-			return;
-
-		/*
-		 * crashkernel=Y,low can be specified or not, but invalid value
-		 * is not allowed.
-		 */
-		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
-		if (ret == -ENOENT)
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-		else if (ret)
-			return;
-
-		search_base = CRASH_HIGH_SEARCH_BASE;
-		crash_max = CRASH_ADDR_HIGH_MAX;
-		high = true;
-	} else if (ret || !crash_size) {
-		/* The specified value is invalid */
+				&crash_size, &crash_base,
+				&low_size, &high);
+	if (ret)
 		return;
-	}
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	/* User specifies base address explicitly. */
-	if (crash_base) {
-		fixed_base = true;
-		search_base = crash_base;
-		crash_max = crash_base + crash_size;
-	}
-
-retry:
-	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       search_base, crash_max);
-	if (!crash_base) {
-		/*
-		 * For crashkernel=size[KMG]@offset[KMG], print out failure
-		 * message if can't reserve the specified region.
-		 */
-		if (fixed_base) {
-			pr_warn("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-
-		/*
-		 * For crashkernel=size[KMG], if the first attempt was for
-		 * low memory, fall back to high memory, the minimum required
-		 * low memory will be reserved later.
-		 */
-		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
-			crash_max = CRASH_ADDR_HIGH_MAX;
-			search_base = CRASH_ADDR_LOW_MAX;
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
-		}
-
-		/*
-		 * For crashkernel=size[KMG],high, if the first attempt was
-		 * for high memory, fall back to low memory.
-		 */
-		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
-			crash_max = CRASH_ADDR_LOW_MAX;
-			search_base = 0;
-			goto retry;
-		}
-		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-			crash_size);
-		return;
-	}
-
-	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
-	     reserve_crashkernel_low(crash_low_size)) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
-
-	/*
-	 * The crashkernel memory will be removed from the kernel linear
-	 * map. Inform kmemleak so that it won't try to access it.
-	 */
-	kmemleak_ignore_phys(crash_base);
-	if (crashk_low_res.end)
-		kmemleak_ignore_phys(crashk_low_res.start);
 
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 }
 
 /*
@@ -454,7 +330,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 
 	memblock_dump_all();
 }
-- 
2.41.0

