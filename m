Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8178C418
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjH2MRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjH2MRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B6CDB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693311403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yxgj/4bGPsyeEGGTCmmz+k2NvLzn/k3ICbMHRhDNWaw=;
        b=DgpInAgYPzQeSR8BwbLC+Hv6qUEbJKIa0rHWsRHD/uqRMb8fDKhkSDp+OeZKeeb4083N1C
        IjZbQKQsnm02f/s/thSM8sqTXj4Xy+1i+VzW6m1TRNbb+evCcZOBJxX81pRci7ULJ9RgQp
        +qu9T0gqFBueUu508YB/jz95wG+wLjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-ae7XW89IPrmAROByRIxuNQ-1; Tue, 29 Aug 2023 08:16:38 -0400
X-MC-Unique: ae7XW89IPrmAROByRIxuNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 277FC8432D0;
        Tue, 29 Aug 2023 12:16:38 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B646E6B2B2;
        Tue, 29 Aug 2023 12:16:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 4/8] crash_core: add generic function to do reservation
Date:   Tue, 29 Aug 2023 20:16:06 +0800
Message-ID: <20230829121610.138107-5-bhe@redhat.com>
In-Reply-To: <20230829121610.138107-1-bhe@redhat.com>
References: <20230829121610.138107-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In architecture like x86_64, arm64 and riscv, they have vast virtual
address space and usually have huge physical memory RAM. Their
crashkernel reservation doesn't have to be limited under 4G RAM,
but can be extended to the whole physical memory via crashkernel=,high
support.

Now add function reserve_crashkernel_generic() to reserve crashkernel
memory if users specify any case of kernel pamameters, like
crashkernel=xM[@offset] or crashkernel=,high|low.

This is preparation to simplify code of crashkernel=,high support
in architecutures.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  34 ++++++++++--
 kernel/crash_core.c        | 109 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 85260bf4a734..2f732493e922 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -77,12 +77,6 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
-#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
-#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
-#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
-#endif
-#endif
-
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
@@ -91,4 +85,32 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
+#endif
+#ifndef CRASH_ALIGN
+#define CRASH_ALIGN			SZ_2M
+#endif
+#ifndef CRASH_ADDR_LOW_MAX
+#define CRASH_ADDR_LOW_MAX		SZ_4G
+#endif
+#ifndef CRASH_ADDR_HIGH_MAX
+#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
+#endif
+
+void __init reserve_crashkernel_generic(char *cmdline,
+		unsigned long long crash_size,
+		unsigned long long crash_base,
+		unsigned long long crash_low_size,
+		bool high);
+#else
+static inline void __init reserve_crashkernel_generic(char *cmdline,
+		unsigned long long crash_size,
+		unsigned long long crash_base,
+		unsigned long long crash_low_size,
+		bool high)
+{}
+#endif
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 355b0ab5189c..6bc00cc390b5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -5,11 +5,13 @@
  */
 
 #include <linux/buildid.h>
-#include <linux/crash_core.h>
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/memblock.h>
+#include <linux/kexec.h>
+#include <linux/kmemleak.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -349,6 +351,111 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+#ifdef CONFIG_64BIT
+	unsigned long long low_base;
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
+	return 0;
+}
+
+void __init reserve_crashkernel_generic(char *cmdline,
+			     unsigned long long crash_size,
+			     unsigned long long crash_base,
+			     unsigned long long crash_low_size,
+			     bool high)
+{
+	unsigned long long search_end = CRASH_ADDR_LOW_MAX, search_base = 0;
+	bool fixed_base = false;
+
+	/* User specifies base address explicitly. */
+	if (crash_base) {
+		fixed_base = true;
+		search_base = crash_base;
+		search_end = crash_base + crash_size;
+	}
+
+	if (high) {
+		search_base = CRASH_ADDR_LOW_MAX;
+		search_end = CRASH_ADDR_HIGH_MAX;
+	}
+
+retry:
+	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+					       search_base, search_end);
+	if (!crash_base) {
+		/*
+		 * For crashkernel=size[KMG]@offset[KMG], print out failure
+		 * message if can't reserve the specified region.
+		 */
+		if (fixed_base) {
+			pr_warn("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+
+		/*
+		 * For crashkernel=size[KMG], if the first attempt was for
+		 * low memory, fall back to high memory, the minimum required
+		 * low memory will be reserved later.
+		 */
+		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
+			search_end = CRASH_ADDR_HIGH_MAX;
+			search_base = CRASH_ADDR_LOW_MAX;
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			goto retry;
+		}
+
+		/*
+		 * For crashkernel=size[KMG],high, if the first attempt was
+		 * for high memory, fall back to low memory.
+		 */
+		if (high && search_end == CRASH_ADDR_HIGH_MAX) {
+			search_end = CRASH_ADDR_LOW_MAX;
+			search_base = 0;
+			goto retry;
+		}
+		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
+			crash_size);
+		return;
+	}
+
+	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
+	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		crash_base, crash_base + crash_size, crash_size >> 20);
+
+	/*
+	 * The crashkernel memory will be removed from the kernel linear
+	 * map. Inform kmemleak so that it won't try to access it.
+	 */
+	kmemleak_ignore_phys(crash_base);
+	if (crashk_low_res.end)
+		kmemleak_ignore_phys(crashk_low_res.start);
+
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
+}
+#endif
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.41.0

