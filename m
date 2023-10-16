Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8A7CB709
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjJPXcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjJPXci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D5F9F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 54D2020B74C0;
        Mon, 16 Oct 2023 16:32:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54D2020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499157;
        bh=gwqo8nAHuTkGlbsI56Q26dBaLLDjv6Rxrz98nYbOB2c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NLMKufIPDMUJ67hSfmBMt8Y+H9/Q18Hpv2iX7h1kSbsIHVpljtfhVKCQi0chFUj8+
         B4+t3BdWs0SqHbN80N54dh9tjP/K9kcWSckFawigYKvVPN2jF1yNfiXIX/qs9O0HSD
         YVF0B6V8k6kHLVxkHXw7PJey2WV5075oz1FaXXbA=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 05/10] mm/prmem: Implement a buffer allocator for persistent memory
Date:   Mon, 16 Oct 2023 18:32:10 -0500
Message-Id: <20231016233215.13090-6-madvenka@linux.microsoft.com>
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

Implement functions that can allocate and free memory smaller than a page
size.

	- prmem_alloc()
	- prmem_free()

These functions look like kmalloc() and kfree(). However, the only GFP flag
that is processed is __GFP_ZERO to zero out the allocated memory.

To make the implementation simpler, create allocation caches for different
object sizes:

	8, 16, 32, 64, ..., PAGE_SIZE

For a given size, allocate from the appropriate cache. This idea has been
plagiarized from the kmem allocator.

To fill the cache of a specific size, allocate a page, break it up into
equal sized objects and add the objects to the cache. This is just a very
simple allocator. It does not attempt to do sophisticated things like
cache coloring, coalescing objects that belong to the same page so the
page can be freed, etc.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 include/linux/prmem.h          |  12 ++++
 kernel/prmem/prmem_allocator.c | 112 ++++++++++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index 108683933c82..1cb4660cf35e 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -50,6 +50,8 @@ struct prmem_region {
 	struct gen_pool_chunk	*chunk;
 };
 
+#define PRMEM_MAX_CACHES	14
+
 /*
  * PRMEM metadata.
  *
@@ -60,6 +62,9 @@ struct prmem_region {
  * size		Size of initial memory allocated to prmem.
  *
  * regions	List of memory regions.
+ *
+ * caches	Caches for different object sizes. For allocations smaller than
+ *		PAGE_SIZE, these caches are used.
  */
 struct prmem {
 	unsigned long		checksum;
@@ -68,6 +73,9 @@ struct prmem {
 
 	/* Persistent Regions. */
 	struct list_head	regions;
+
+	/* Allocation caches. */
+	void			*caches[PRMEM_MAX_CACHES];
 };
 
 extern struct prmem		*prmem;
@@ -87,6 +95,8 @@ int  prmem_cmdline_size(void);
 /* Allocator API. */
 struct page *prmem_alloc_pages(unsigned int order, gfp_t gfp);
 void prmem_free_pages(struct page *pages, unsigned int order);
+void *prmem_alloc(size_t size, gfp_t gfp);
+void prmem_free(void *va, size_t size);
 
 /* Internal functions. */
 struct prmem_region *prmem_add_region(unsigned long pa, size_t size);
@@ -95,6 +105,8 @@ void *prmem_alloc_pool(struct prmem_region *region, size_t size, int align);
 void prmem_free_pool(struct prmem_region *region, void *va, size_t size);
 void *prmem_alloc_pages_locked(unsigned int order);
 void prmem_free_pages_locked(void *va, unsigned int order);
+void *prmem_alloc_locked(size_t size);
+void prmem_free_locked(void *va, size_t size);
 unsigned long prmem_checksum(void *start, size_t size);
 bool __init prmem_validate(void);
 void prmem_cmdline(char *cmdline);
diff --git a/kernel/prmem/prmem_allocator.c b/kernel/prmem/prmem_allocator.c
index 07a5a430630c..f12975bc6777 100644
--- a/kernel/prmem/prmem_allocator.c
+++ b/kernel/prmem/prmem_allocator.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Persistent-Across-Kexec memory feature (prmem) - Allocator.
+ * Persistent-Across-Kexec memory (prmem) - Allocator.
  *
  * Copyright (C) 2023 Microsoft Corporation
  * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
@@ -72,3 +72,113 @@ void prmem_free_pages(struct page *pages, unsigned int order)
 	spin_unlock(&prmem_lock);
 }
 EXPORT_SYMBOL_GPL(prmem_free_pages);
+
+/* Buffer allocation functions. */
+
+#if PAGE_SIZE > 65536
+#error "Page size is too big"
+#endif
+
+static size_t	prmem_cache_sizes[PRMEM_MAX_CACHES] = {
+	8, 16, 32, 64, 128, 256, 512,
+	1024, 2048, 4096, 8192, 16384, 32768, 65536,
+};
+
+static int prmem_cache_index(size_t size)
+{
+	int	i;
+
+	for (i = 0; i < PRMEM_MAX_CACHES; i++) {
+		if (size <= prmem_cache_sizes[i])
+			return i;
+	}
+	BUG();
+}
+
+static void prmem_refill(void **cache, size_t size)
+{
+	void		*va;
+	int		i, n = PAGE_SIZE / size;
+
+	/* Allocate a page. */
+	va = prmem_alloc_pages_locked(0);
+	if (!va)
+		return;
+
+	/* Break up the page into pieces and put them in the cache. */
+	for (i = 0; i < n; i++, va += size) {
+		*((void **) va) = *cache;
+		*cache = va;
+	}
+}
+
+void *prmem_alloc_locked(size_t size)
+{
+	void		*va;
+	int		index;
+	void		**cache;
+
+	index = prmem_cache_index(size);
+	size = prmem_cache_sizes[index];
+
+	cache = &prmem->caches[index];
+	if (!*cache) {
+		/* Refill the cache. */
+		prmem_refill(cache, size);
+	}
+
+	/* Allocate one from the cache. */
+	va = *cache;
+	if (va)
+		*cache = *((void **) va);
+	return va;
+}
+
+void *prmem_alloc(size_t size, gfp_t gfp)
+{
+	void		*va;
+	bool		zero = !!(gfp & __GFP_ZERO);
+
+	if (!prmem_inited || !size)
+		return NULL;
+
+	/* This function is only for sizes up to a PAGE_SIZE. */
+	if (size > PAGE_SIZE)
+		return NULL;
+
+	spin_lock(&prmem_lock);
+	va = prmem_alloc_locked(size);
+	spin_unlock(&prmem_lock);
+
+	if (va && zero)
+		memset(va, 0, size);
+	return va;
+}
+EXPORT_SYMBOL_GPL(prmem_alloc);
+
+void prmem_free_locked(void *va, size_t size)
+{
+	int		index;
+	void		**cache;
+
+	/* Free the object into its cache. */
+	index = prmem_cache_index(size);
+	cache = &prmem->caches[index];
+	*((void **) va) = *cache;
+	*cache = va;
+}
+
+void prmem_free(void *va, size_t size)
+{
+	if (!prmem_inited || !va || !size)
+		return;
+
+	/* This function is only for sizes up to a PAGE_SIZE. */
+	if (size > PAGE_SIZE)
+		return;
+
+	spin_lock(&prmem_lock);
+	prmem_free_locked(va, size);
+	spin_unlock(&prmem_lock);
+}
+EXPORT_SYMBOL_GPL(prmem_free);
-- 
2.25.1

