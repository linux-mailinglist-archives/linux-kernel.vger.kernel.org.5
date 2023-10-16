Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951A37CB70E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjJPXcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjJPXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0DE1D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6F27A20B74C3;
        Mon, 16 Oct 2023 16:32:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F27A20B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499155;
        bh=1++eNyqRswp3oGNUuCWUHGrpRdktVHyUltKwKhyqiRU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iNqCEpEjzTE8WovCw4f+pbtGA2H9fPOLKS/lmVB0QpDyYHLhb+OX2CgYw4laOjE1w
         nwliO/996zaOQ0eCLQ2mMU8cAPWRbBQRZ4rLPouM0t7i6SwcvYpf8IGHjlQcVT1v0y
         XcdWcIxwROlouzNUs2skG0w/can9dYak3PkQg52M=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 03/10] mm/prmem: Manage persistent memory with the gen pool allocator.
Date:   Mon, 16 Oct 2023 18:32:08 -0500
Message-Id: <20231016233215.13090-4-madvenka@linux.microsoft.com>
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

The memory in a prmem region must be managed by an allocator. Use
the Gen Pool allocator (lib/genalloc.c) for that purpose. This is so we
don't have to write a new allocator.

Now, the Gen Pool allocator uses a "struct gen_pool_chunk" to manage a
contiguous range of memory. The chunk is normally allocated using the kmem
allocator. However, for prmem, the chunk must be persisted across a
kexec reboot so that the allocations can be "remembered". To allow this,
allocate the chunk from the region itself and initialize it. Then, pass
the chunk to the Gen Pool allocator. In other words, persist the chunk.

Inside the Gen Pool allocator, distinguish between a chunk that is
allocated internally from kmem and a chunk that is passed by the caller
and handle it properly when the pool is destroyed.

Provide wrapper functions around the Gen Pool allocator functions so we
can change the allocator in the future if we wanted to.

	prmem_create_pool()
	prmem_alloc_pool()
	prmem_free_pool()

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 include/linux/genalloc.h    |  6 ++++
 include/linux/prmem.h       |  8 +++++
 kernel/prmem/prmem_init.c   |  8 +++++
 kernel/prmem/prmem_region.c | 67 ++++++++++++++++++++++++++++++++++++-
 lib/genalloc.c              | 45 ++++++++++++++++++-------
 5 files changed, 121 insertions(+), 13 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 0bd581003cd5..186757b0aec7 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -73,6 +73,7 @@ struct gen_pool_chunk {
 	struct list_head next_chunk;	/* next chunk in pool */
 	atomic_long_t avail;
 	phys_addr_t phys_addr;		/* physical starting address of memory chunk */
+	bool external;			/* Chunk is passed by caller. */
 	void *owner;			/* private data to retrieve at alloc time */
 	unsigned long start_addr;	/* start address of memory chunk */
 	unsigned long end_addr;		/* end address of memory chunk (inclusive) */
@@ -121,6 +122,11 @@ static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
 {
 	return gen_pool_add_virt(pool, addr, -1, size, nid);
 }
+extern unsigned long gen_pool_chunk_size(size_t size, int min_alloc_order);
+extern void gen_pool_init_chunk(struct gen_pool_chunk *chunk,
+				unsigned long addr, phys_addr_t phys,
+				size_t size, bool external, void *owner);
+void gen_pool_add_chunk(struct gen_pool *pool, struct gen_pool_chunk *chunk);
 extern void gen_pool_destroy(struct gen_pool *);
 unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t size,
 		genpool_algo_t algo, void *data, void **owner);
diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index bc8054a86f49..f43f5b0d2b9c 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -24,6 +24,7 @@
  * non-volatile storage is too slow.
  */
 #include <linux/types.h>
+#include <linux/genalloc.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/memblock.h>
@@ -38,11 +39,15 @@
  * node		List node.
  * pa		Physical address of the region.
  * size		Size of the region in bytes.
+ * pool		Gen Pool to manage region memory.
+ * chunk	Persistent Gen Pool chunk.
  */
 struct prmem_region {
 	struct list_head	node;
 	unsigned long		pa;
 	size_t			size;
+	struct gen_pool		*pool;
+	struct gen_pool_chunk	*chunk;
 };
 
 /*
@@ -80,6 +85,9 @@ int  prmem_cmdline_size(void);
 
 /* Internal functions. */
 struct prmem_region *prmem_add_region(unsigned long pa, size_t size);
+bool prmem_create_pool(struct prmem_region *region, bool new_region);
+void *prmem_alloc_pool(struct prmem_region *region, size_t size, int align);
+void prmem_free_pool(struct prmem_region *region, void *va, size_t size);
 unsigned long prmem_checksum(void *start, size_t size);
 bool __init prmem_validate(void);
 void prmem_cmdline(char *cmdline);
diff --git a/kernel/prmem/prmem_init.c b/kernel/prmem/prmem_init.c
index 9cea1cd3b6a5..56df1e6d3ebc 100644
--- a/kernel/prmem/prmem_init.c
+++ b/kernel/prmem/prmem_init.c
@@ -22,6 +22,14 @@ void __init prmem_init(void)
 
 		if (!prmem_add_region(prmem_pa, prmem_size))
 			return;
+	} else {
+		/* Warm boot. */
+		struct prmem_region	*region;
+
+		list_for_each_entry(region, &prmem->regions, node) {
+			if (!prmem_create_pool(region, false))
+				return;
+		}
 	}
 	prmem_inited = true;
 }
diff --git a/kernel/prmem/prmem_region.c b/kernel/prmem/prmem_region.c
index 8254dafcee13..6dc88c74d9c8 100644
--- a/kernel/prmem/prmem_region.c
+++ b/kernel/prmem/prmem_region.c
@@ -1,12 +1,74 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Persistent-Across-Kexec memory (prmem) - Regions.
+ * Persistent-Across-Kexec memory (prmem) - Regions and Region Pools.
  *
  * Copyright (C) 2023 Microsoft Corporation
  * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
  */
 #include <linux/prmem.h>
 
+bool prmem_create_pool(struct prmem_region *region, bool new_region)
+{
+	size_t		chunk_size, total_size;
+
+	chunk_size = gen_pool_chunk_size(region->size, PAGE_SHIFT);
+	total_size = sizeof(*region) + chunk_size;
+	total_size = ALIGN(total_size, PAGE_SIZE);
+
+	if (new_region) {
+		/*
+		 * We place the region structure at the base of the region
+		 * itself. Part of the region is a genpool chunk that is used
+		 * to manage the region memory.
+		 *
+		 * Normally, the chunk is allocated from regular memory by
+		 * genpool. But in the case of prmem, the chunk must be
+		 * persisted across kexecs so allocations can be remembered.
+		 * That is why it is allocated from the region memory itself
+		 * and passed to genpool.
+		 *
+		 * Make sure there is enough space for the region and the chunk.
+		 */
+		if (total_size >= region->size) {
+			pr_warn("%s: region size too small\n", __func__);
+			return false;
+		}
+
+		/* Initialize the persistent genpool chunk. */
+		region->chunk = (void *) (region + 1);
+		memset(region->chunk, 0, chunk_size);
+		gen_pool_init_chunk(region->chunk, (unsigned long) region,
+				    region->pa, region->size, true, NULL);
+	}
+
+	region->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!region->pool) {
+		pr_warn("%s: Could not create genpool\n", __func__);
+		return false;
+	}
+
+	gen_pool_add_chunk(region->pool, region->chunk);
+
+	if (new_region) {
+		/* Reserve the region and chunk. */
+		gen_pool_alloc(region->pool, total_size);
+	}
+	return true;
+}
+
+void *prmem_alloc_pool(struct prmem_region *region, size_t size, int align)
+{
+	struct genpool_data_align	data = { .align = align, };
+
+	return (void *) gen_pool_alloc_algo(region->pool, size,
+					    gen_pool_first_fit_align, &data);
+}
+
+void prmem_free_pool(struct prmem_region *region, void *va, size_t size)
+{
+	gen_pool_free(region->pool, (unsigned long) va, size);
+}
+
 struct prmem_region *prmem_add_region(unsigned long pa, size_t size)
 {
 	struct prmem_region	*region;
@@ -16,6 +78,9 @@ struct prmem_region *prmem_add_region(unsigned long pa, size_t size)
 	region->pa = pa;
 	region->size = size;
 
+	if (!prmem_create_pool(region, true))
+		return NULL;
+
 	list_add_tail(&region->node, &prmem->regions);
 	return region;
 }
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 6c644f954bc5..655db7b47ea9 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -165,6 +165,33 @@ struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 }
 EXPORT_SYMBOL(gen_pool_create);
 
+size_t gen_pool_chunk_size(size_t size, int min_alloc_order)
+{
+	unsigned long nbits = size >> min_alloc_order;
+	unsigned long nbytes = sizeof(struct gen_pool_chunk) +
+				BITS_TO_LONGS(nbits) * sizeof(long);
+	return nbytes;
+}
+
+void gen_pool_init_chunk(struct gen_pool_chunk *chunk, unsigned long virt,
+			 phys_addr_t phys, size_t size, bool external,
+			 void *owner)
+{
+	chunk->phys_addr = phys;
+	chunk->start_addr = virt;
+	chunk->end_addr = virt + size - 1;
+	chunk->external = external;
+	chunk->owner = owner;
+	atomic_long_set(&chunk->avail, size);
+}
+
+void gen_pool_add_chunk(struct gen_pool *pool, struct gen_pool_chunk *chunk)
+{
+	spin_lock(&pool->lock);
+	list_add_rcu(&chunk->next_chunk, &pool->chunks);
+	spin_unlock(&pool->lock);
+}
+
 /**
  * gen_pool_add_owner- add a new chunk of special memory to the pool
  * @pool: pool to add new memory chunk to
@@ -183,23 +210,14 @@ int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_addr_t ph
 		 size_t size, int nid, void *owner)
 {
 	struct gen_pool_chunk *chunk;
-	unsigned long nbits = size >> pool->min_alloc_order;
-	unsigned long nbytes = sizeof(struct gen_pool_chunk) +
-				BITS_TO_LONGS(nbits) * sizeof(long);
+	unsigned long nbytes = gen_pool_chunk_size(size, pool->min_alloc_order);
 
 	chunk = vzalloc_node(nbytes, nid);
 	if (unlikely(chunk == NULL))
 		return -ENOMEM;
 
-	chunk->phys_addr = phys;
-	chunk->start_addr = virt;
-	chunk->end_addr = virt + size - 1;
-	chunk->owner = owner;
-	atomic_long_set(&chunk->avail, size);
-
-	spin_lock(&pool->lock);
-	list_add_rcu(&chunk->next_chunk, &pool->chunks);
-	spin_unlock(&pool->lock);
+	gen_pool_init_chunk(chunk, virt, phys, size, false, owner);
+	gen_pool_add_chunk(pool, chunk);
 
 	return 0;
 }
@@ -248,6 +266,9 @@ void gen_pool_destroy(struct gen_pool *pool)
 		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
 		list_del(&chunk->next_chunk);
 
+		if (chunk->external)
+			continue;
+
 		end_bit = chunk_size(chunk) >> order;
 		bit = find_first_bit(chunk->bits, end_bit);
 		BUG_ON(bit < end_bit);
-- 
2.25.1

