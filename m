Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AE17CB707
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJPXcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjJPXcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFAF79F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88BD920B74C1;
        Mon, 16 Oct 2023 16:32:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88BD920B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499153;
        bh=aE7GEE4w8uDUnb6VvRJNVuX+EcDx1I9KmGc5OVksCs4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qx+Gfv5hj1Fy0/v27lcwkdslPDvHbw4VQGT8jnw/A/kASaJRIEfU7UcY0pvaDcAvd
         F76GHm7xqfroCNDJrZhjEdr4S/iKTHBcXgLjdudX9nPz7P/WkvgQvdnfGN6JoclsH3
         Gy731Qw8P0FE4VPQnBHPPpj8S/465RGBTdl3OPoA=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 01/10] mm/prmem: Allocate memory during boot for storing persistent data
Date:   Mon, 16 Oct 2023 18:32:06 -0500
Message-Id: <20231016233215.13090-2-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016233215.13090-1-madvenka@linux.microsoft.com>
References: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
 <20231016233215.13090-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Introduce the "Persistent-Across-Kexec memory (prmem)" feature that allows
user and kernel data to be persisted across kexecs.

The first step is to set aside some memory for storing persistent data.
Introduce a new kernel command line parameter for this:

	prmem=size[KMG]

Allocate this memory from memblocks during boot. Make sure that the
allocation is done late enough so it does not interfere with any fixed
range allocations.

Define a "prmem_region" structure to store the range that is allocated. The
region structure will be used to manage the memory.

Define a "prmem" structure for storing persistence metadata.

Allocate a metadata page to contain the metadata structure. Initialize the
metadata. Add the initial region to a region list in the metadata.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/x86/kernel/setup.c      |  2 +
 include/linux/prmem.h        | 76 ++++++++++++++++++++++++++++++++++++
 kernel/Makefile              |  1 +
 kernel/prmem/Makefile        |  3 ++
 kernel/prmem/prmem_init.c    | 27 +++++++++++++
 kernel/prmem/prmem_parse.c   | 33 ++++++++++++++++
 kernel/prmem/prmem_region.c  | 21 ++++++++++
 kernel/prmem/prmem_reserve.c | 56 ++++++++++++++++++++++++++
 mm/mm_init.c                 |  2 +
 9 files changed, 221 insertions(+)
 create mode 100644 include/linux/prmem.h
 create mode 100644 kernel/prmem/Makefile
 create mode 100644 kernel/prmem/prmem_init.c
 create mode 100644 kernel/prmem/prmem_parse.c
 create mode 100644 kernel/prmem/prmem_region.c
 create mode 100644 kernel/prmem/prmem_reserve.c

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..f2b13b3d3ead 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
 #include <linux/random.h>
+#include <linux/prmem.h>
 
 #include <uapi/linux/mount.h>
 
@@ -1231,6 +1232,7 @@ void __init setup_arch(char **cmdline_p)
 	 * won't consume hotpluggable memory.
 	 */
 	reserve_crashkernel();
+	prmem_reserve();
 
 	memblock_find_dma_reserve();
 
diff --git a/include/linux/prmem.h b/include/linux/prmem.h
new file mode 100644
index 000000000000..7f22016c4ad2
--- /dev/null
+++ b/include/linux/prmem.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Persistent-Across-Kexec memory (prmem) - Definitions.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#ifndef _LINUX_PRMEM_H
+#define _LINUX_PRMEM_H
+/*
+ * The prmem feature can be used to persist kernel and user data across kexec
+ * reboots in memory for various uses. E.g.,
+ *
+ *	- Saving cached data. E.g., database caches.
+ *	- Saving state. E.g., KVM guest states.
+ *	- Saving historical information since the last cold boot such as
+ *	  events, logs and journals.
+ *	- Saving measurements for integrity checks on the next boot.
+ *	- Saving driver data.
+ *	- Saving IOMMU mappings.
+ *	- Saving MMIO config information.
+ *
+ * This is useful on systems where there is no non-volatile storage or
+ * non-volatile storage is too slow.
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/printk.h>
+
+#include <asm-generic/errno.h>
+#include <asm/page.h>
+#include <asm/setup.h>
+/*
+ * A prmem region supplies the memory for storing persistent data.
+ *
+ * node		List node.
+ * pa		Physical address of the region.
+ * size		Size of the region in bytes.
+ */
+struct prmem_region {
+	struct list_head	node;
+	unsigned long		pa;
+	size_t			size;
+};
+
+/*
+ * PRMEM metadata.
+ *
+ * metadata	Physical address of the metadata page.
+ * size		Size of initial memory allocated to prmem.
+ *
+ * regions	List of memory regions.
+ */
+struct prmem {
+	unsigned long		metadata;
+	size_t			size;
+
+	/* Persistent Regions. */
+	struct list_head	regions;
+};
+
+extern struct prmem		*prmem;
+extern unsigned long		prmem_metadata;
+extern unsigned long		prmem_pa;
+extern size_t			prmem_size;
+
+/* Kernel API. */
+void prmem_reserve(void);
+void prmem_init(void);
+
+/* Internal functions. */
+struct prmem_region *prmem_add_region(unsigned long pa, size_t size);
+
+#endif /* _LINUX_PRMEM_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..43b485b0467a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += prmem/
 obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
diff --git a/kernel/prmem/Makefile b/kernel/prmem/Makefile
new file mode 100644
index 000000000000..11a53d49312a
--- /dev/null
+++ b/kernel/prmem/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += prmem_parse.o prmem_reserve.o prmem_init.o prmem_region.o
diff --git a/kernel/prmem/prmem_init.c b/kernel/prmem/prmem_init.c
new file mode 100644
index 000000000000..97b550252028
--- /dev/null
+++ b/kernel/prmem/prmem_init.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Persistent-Across-Kexec memory (prmem) - Initialization.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+bool			prmem_inited;
+
+void __init prmem_init(void)
+{
+	if (!prmem)
+		return;
+
+	if (!prmem->metadata) {
+		/* Cold boot. */
+		prmem->metadata = prmem_metadata;
+		prmem->size = prmem_size;
+		INIT_LIST_HEAD(&prmem->regions);
+
+		if (!prmem_add_region(prmem_pa, prmem_size))
+			return;
+	}
+	prmem_inited = true;
+}
diff --git a/kernel/prmem/prmem_parse.c b/kernel/prmem/prmem_parse.c
new file mode 100644
index 000000000000..191655b53545
--- /dev/null
+++ b/kernel/prmem/prmem_parse.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Persistent-Across-Kexec memory (prmem) - Process prmem cmdline parameter.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+/*
+ * Syntax: prmem=size[KMG]
+ *
+ *	Specifies the size of the initial memory to be allocated to prmem.
+ */
+static int __init prmem_size_parse(char *cmdline)
+{
+	char			*tmp, *cur = cmdline;
+	unsigned long		size;
+
+	if (!cur)
+		return -EINVAL;
+
+	/* Get initial size. */
+	size = memparse(cur, &tmp);
+	if (cur == tmp || !size || size & (PAGE_SIZE - 1)) {
+		pr_warn("%s: Incorrect size %lx\n", __func__, size);
+		return -EINVAL;
+	}
+
+	prmem_size = size;
+	return 0;
+}
+early_param("prmem", prmem_size_parse);
diff --git a/kernel/prmem/prmem_region.c b/kernel/prmem/prmem_region.c
new file mode 100644
index 000000000000..8254dafcee13
--- /dev/null
+++ b/kernel/prmem/prmem_region.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Persistent-Across-Kexec memory (prmem) - Regions.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+struct prmem_region *prmem_add_region(unsigned long pa, size_t size)
+{
+	struct prmem_region	*region;
+
+	/* Allocate region structure from the base of the region itself. */
+	region = __va(pa);
+	region->pa = pa;
+	region->size = size;
+
+	list_add_tail(&region->node, &prmem->regions);
+	return region;
+}
diff --git a/kernel/prmem/prmem_reserve.c b/kernel/prmem/prmem_reserve.c
new file mode 100644
index 000000000000..e20e31a61d12
--- /dev/null
+++ b/kernel/prmem/prmem_reserve.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Persistent-Across-Kexec memory (prmem) - Reserve memory.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+struct prmem		*prmem;
+unsigned long		prmem_metadata;
+unsigned long		prmem_pa;
+unsigned long		prmem_size;
+
+void __init prmem_reserve(void)
+{
+	BUILD_BUG_ON(sizeof(*prmem) > PAGE_SIZE);
+
+	if (!prmem_size)
+		return;
+
+	/*
+	 * prmem uses direct map addresses. If PAGE_OFFSET is randomized,
+	 * these addresses will change across kexecs. Persistence cannot
+	 * be supported.
+	 */
+	if (kaslr_memory_enabled()) {
+		pr_warn("%s: Cannot support persistence because of KASLR.\n",
+			__func__);
+		return;
+	}
+
+	/* Allocate a metadata page. */
+	prmem_metadata = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (!prmem_metadata) {
+		pr_warn("%s: Could not allocate metadata at %lx\n", __func__,
+			prmem_metadata);
+		return;
+	}
+
+	/* Allocate initial memory. */
+	prmem_pa = memblock_phys_alloc(prmem_size, PAGE_SIZE);
+	if (!prmem_pa) {
+		pr_warn("%s: Could not allocate initial memory\n", __func__);
+		goto free_metadata;
+	}
+
+	/* Clear metadata. */
+	prmem = __va(prmem_metadata);
+	memset(prmem, 0, sizeof(*prmem));
+	return;
+
+free_metadata:
+	memblock_phys_free(prmem_metadata, PAGE_SIZE);
+	prmem = NULL;
+}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..f12757829281 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -24,6 +24,7 @@
 #include <linux/page_ext.h>
 #include <linux/pti.h>
 #include <linux/pgtable.h>
+#include <linux/prmem.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include "internal.h"
@@ -2804,4 +2805,5 @@ void __init mm_core_init(void)
 	pti_init();
 	kmsan_init_runtime();
 	mm_cache_init();
+	prmem_init();
 }
-- 
2.25.1

