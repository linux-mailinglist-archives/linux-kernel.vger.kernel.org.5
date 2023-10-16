Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D547CB70B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjJPXcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJPXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AA3692
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 628DF20B74C4;
        Mon, 16 Oct 2023 16:32:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 628DF20B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499156;
        bh=7Kg0kDVRT4XUsyYitTfP8a+YwKQXAgc1KQikAOX3WAY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yt8+5vTSKf0oAErSwOtHn6FQjCOGeLisGeuub6q/djLn2p+T5pP7eOxRYSGmL6t3n
         rmGVIM80mpjIhbpqL9f/XXorAr0bZQkq3mlx1BLzOZNid96fWsO7hN5QGHtO+eT2SX
         zBHgeRKFsB0wU1vyi0WE4hJoh3zRyfs5hhdvcEsQ=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 04/10] mm/prmem: Implement a page allocator for persistent memory
Date:   Mon, 16 Oct 2023 18:32:09 -0500
Message-Id: <20231016233215.13090-5-madvenka@linux.microsoft.com>
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

Define the following convenience wrapper functions for allocating and
freeing pages:

	- prmem_alloc_pages()
	- prmem_free_pages()

The functions look similar to alloc_pages() and __free_pages(). However,
the only GFP flag that is processed is __GFP_ZERO to zero out the
allocated memory.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 include/linux/prmem.h          |  7 ++++
 kernel/prmem/Makefile          |  1 +
 kernel/prmem/prmem_allocator.c | 74 ++++++++++++++++++++++++++++++++++
 kernel/prmem/prmem_init.c      |  2 +
 4 files changed, 84 insertions(+)
 create mode 100644 kernel/prmem/prmem_allocator.c

diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index f43f5b0d2b9c..108683933c82 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -75,6 +75,7 @@ extern unsigned long		prmem_metadata;
 extern unsigned long		prmem_pa;
 extern size_t			prmem_size;
 extern bool			prmem_inited;
+extern spinlock_t		prmem_lock;
 
 /* Kernel API. */
 void prmem_reserve_early(void);
@@ -83,11 +84,17 @@ void prmem_init(void);
 void prmem_fini(void);
 int  prmem_cmdline_size(void);
 
+/* Allocator API. */
+struct page *prmem_alloc_pages(unsigned int order, gfp_t gfp);
+void prmem_free_pages(struct page *pages, unsigned int order);
+
 /* Internal functions. */
 struct prmem_region *prmem_add_region(unsigned long pa, size_t size);
 bool prmem_create_pool(struct prmem_region *region, bool new_region);
 void *prmem_alloc_pool(struct prmem_region *region, size_t size, int align);
 void prmem_free_pool(struct prmem_region *region, void *va, size_t size);
+void *prmem_alloc_pages_locked(unsigned int order);
+void prmem_free_pages_locked(void *va, unsigned int order);
 unsigned long prmem_checksum(void *start, size_t size);
 bool __init prmem_validate(void);
 void prmem_cmdline(char *cmdline);
diff --git a/kernel/prmem/Makefile b/kernel/prmem/Makefile
index 9b0a693bfee1..99bb19f0afd3 100644
--- a/kernel/prmem/Makefile
+++ b/kernel/prmem/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y += prmem_parse.o prmem_reserve.o prmem_init.o prmem_region.o prmem_misc.o
+obj-y += prmem_allocator.o
diff --git a/kernel/prmem/prmem_allocator.c b/kernel/prmem/prmem_allocator.c
new file mode 100644
index 000000000000..07a5a430630c
--- /dev/null
+++ b/kernel/prmem/prmem_allocator.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Persistent-Across-Kexec memory feature (prmem) - Allocator.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+/* Page Allocation functions. */
+
+void *prmem_alloc_pages_locked(unsigned int order)
+{
+	struct prmem_region	*region;
+	void			*va;
+	size_t			size = (1UL << order) << PAGE_SHIFT;
+
+	list_for_each_entry(region, &prmem->regions, node) {
+		va = prmem_alloc_pool(region, size, size);
+		if (va)
+			return va;
+	}
+	return NULL;
+}
+
+struct page *prmem_alloc_pages(unsigned int order, gfp_t gfp)
+{
+	void		*va;
+	size_t		size = (1UL << order) << PAGE_SHIFT;
+	bool		zero = !!(gfp & __GFP_ZERO);
+
+	if (!prmem_inited || order > MAX_ORDER)
+		return NULL;
+
+	spin_lock(&prmem_lock);
+	va = prmem_alloc_pages_locked(order);
+	spin_unlock(&prmem_lock);
+
+	if (va) {
+		if (zero)
+			memset(va, 0, size);
+		return virt_to_page(va);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(prmem_alloc_pages);
+
+void prmem_free_pages_locked(void *va, unsigned int order)
+{
+	struct prmem_region	*region;
+	size_t			size = (1UL << order) << PAGE_SHIFT;
+	void			*eva = va + size;
+	void			*region_va;
+
+	list_for_each_entry(region, &prmem->regions, node) {
+		/* The region structure is at the base of the region memory. */
+		region_va = region;
+		if (va >= region_va && eva <= (region_va + region->size)) {
+			prmem_free_pool(region, va, size);
+			return;
+		}
+	}
+}
+
+void prmem_free_pages(struct page *pages, unsigned int order)
+{
+	if (!prmem_inited || order > MAX_ORDER)
+		return;
+
+	spin_lock(&prmem_lock);
+	prmem_free_pages_locked(page_to_virt(pages), order);
+	spin_unlock(&prmem_lock);
+}
+EXPORT_SYMBOL_GPL(prmem_free_pages);
diff --git a/kernel/prmem/prmem_init.c b/kernel/prmem/prmem_init.c
index 56df1e6d3ebc..d23833d296fe 100644
--- a/kernel/prmem/prmem_init.c
+++ b/kernel/prmem/prmem_init.c
@@ -9,6 +9,8 @@
 
 bool			prmem_inited;
 
+DEFINE_SPINLOCK(prmem_lock);
+
 void __init prmem_init(void)
 {
 	if (!prmem)
-- 
2.25.1

