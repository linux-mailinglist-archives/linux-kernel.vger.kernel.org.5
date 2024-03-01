Return-Path: <linux-kernel+bounces-88643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7286E4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174721C20F40
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42870CBC;
	Fri,  1 Mar 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXR6it0p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7470AF5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308286; cv=none; b=b3JrqigfA+LxhVZg+smFvJEZr5nqtz3JYO7yBClCyM+zG0Zm+e/6LVFOYMrr5H+hEZRzFW1wSA0ldvkuFV1tpp8k+iOUaGPyN7UrMRnFI2JE9RYe3yr7Pgvfi44AbRPJAasCxmU7+1CCuLqXUVxCkPN/kTXyMbPSxgV2UzJ1b3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308286; c=relaxed/simple;
	bh=PDWDDt4QR97SNsCyWpItSkT/i9E2ArftSSSpich7b2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjVAKCOKvGLrBnc9lfjMIgoCcrtoCakWrzXgVvzQLqoW9nv+O72f8bj8Lat2uAbmlEvaCi34XO6cNVnOlpYf1p9/QybBirItWskHg7MxaEcBJ2+QvKhnT0ljhebpYAgsOoVjhC4U4gxOAuP1kJ4xBgWhKr7AFdhVW4RV98N/uAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXR6it0p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709308283; x=1740844283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDWDDt4QR97SNsCyWpItSkT/i9E2ArftSSSpich7b2U=;
  b=FXR6it0pURYaSp7jiGlOYe9xbxLoCa693pfqt8lX0yVsijxUQdwbTYJx
   +SO2RPqYIjv+GwyhOH0x9CeY9cfMa+aFpysCLsHNhqz7Ro0u++myt12+Y
   ECZF0P438W4xkKstN24uGY1hS5s2Yt8DuqFcyJ61zApqxH1hSiBbh/aH/
   k46RPeDmyoX2Sa/VKWJoYwh1xuYZl6Y/4YF/kadJzQQzsv2ViqNKNkkzO
   GUSK11Ka2Irrh4oCrr6tEaPp1c/yySZxUHTCzIfnGd67nTaakCdN9pfv9
   IsT14eypfyumterh1sFHcep53z+RBk3RzqyR6XR7zCyMMQP1izRufVLsW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3700841"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3700841"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 07:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8370205"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2024 07:51:20 -0800
From: rulinhuang <rulin.huang@intel.com>
To: urezki@gmail.com,
	bhe@redhat.com
Cc: akpm@linux-foundation.org,
	colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	wangyang.guo@intel.com,
	zhiguo.zhou@intel.com
Subject: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional change happened
Date: Fri,  1 Mar 2024 10:54:16 -0500
Message-ID: <20240301155417.1852290-2-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301155417.1852290-1-rulin.huang@intel.com>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moved data structures and basic helpers related to per cpu kva allocator
up too to along with these macros with no functional change happened.

Signed-off-by: rulinhuang <rulin.huang@intel.com>
---
V6 -> V7: Adjusted the macros
---
 mm/vmalloc.c | 262 +++++++++++++++++++++++++--------------------------
 1 file changed, 131 insertions(+), 131 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..fc027a61c12e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -887,6 +887,137 @@ is_vn_id_valid(unsigned int node_id)
 	return false;
 }
 
+/*
+ * vmap space is limited especially on 32 bit architectures. Ensure there is
+ * room for at least 16 percpu vmap blocks per CPU.
+ */
+/*
+ * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
+ * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
+ * instead (we just need a rough idea)
+ */
+#if BITS_PER_LONG == 32
+#define VMALLOC_SPACE		(128UL*1024*1024)
+#else
+#define VMALLOC_SPACE		(128UL*1024*1024*1024)
+#endif
+
+#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
+#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
+#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
+#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
+#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
+#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
+#define VMAP_BBMAP_BITS		\
+		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
+		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
+			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
+
+#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
+
+/*
+ * Purge threshold to prevent overeager purging of fragmented blocks for
+ * regular operations: Purge if vb->free is less than 1/4 of the capacity.
+ */
+#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
+
+#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
+#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
+#define VMAP_FLAGS_MASK		0x3
+
+struct vmap_block_queue {
+	spinlock_t lock;
+	struct list_head free;
+
+	/*
+	 * An xarray requires an extra memory dynamically to
+	 * be allocated. If it is an issue, we can use rb-tree
+	 * instead.
+	 */
+	struct xarray vmap_blocks;
+};
+
+struct vmap_block {
+	spinlock_t lock;
+	struct vmap_area *va;
+	unsigned long free, dirty;
+	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
+	unsigned long dirty_min, dirty_max; /*< dirty range */
+	struct list_head free_list;
+	struct rcu_head rcu_head;
+	struct list_head purge;
+};
+
+/* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
+static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
+
+/*
+ * In order to fast access to any "vmap_block" associated with a
+ * specific address, we use a hash.
+ *
+ * A per-cpu vmap_block_queue is used in both ways, to serialize
+ * an access to free block chains among CPUs(alloc path) and it
+ * also acts as a vmap_block hash(alloc/free paths). It means we
+ * overload it, since we already have the per-cpu array which is
+ * used as a hash table. When used as a hash a 'cpu' passed to
+ * per_cpu() is not actually a CPU but rather a hash index.
+ *
+ * A hash function is addr_to_vb_xa() which hashes any address
+ * to a specific index(in a hash) it belongs to. This then uses a
+ * per_cpu() macro to access an array with generated index.
+ *
+ * An example:
+ *
+ *  CPU_1  CPU_2  CPU_0
+ *    |      |      |
+ *    V      V      V
+ * 0     10     20     30     40     50     60
+ * |------|------|------|------|------|------|...<vmap address space>
+ *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
+ *
+ * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
+ *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
+ *
+ * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
+ *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
+ *
+ * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
+ *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
+ *
+ * This technique almost always avoids lock contention on insert/remove,
+ * however xarray spinlocks protect against any contention that remains.
+ */
+static struct xarray *
+addr_to_vb_xa(unsigned long addr)
+{
+	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+
+	return &per_cpu(vmap_block_queue, index).vmap_blocks;
+}
+
+/*
+ * We should probably have a fallback mechanism to allocate virtual memory
+ * out of partially filled vmap blocks. However vmap block sizing should be
+ * fairly reasonable according to the vmalloc size, so it shouldn't be a
+ * big problem.
+ */
+
+static unsigned long addr_to_vb_idx(unsigned long addr)
+{
+	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
+	addr /= VMAP_BLOCK_SIZE;
+	return addr;
+}
+
+static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
+{
+	unsigned long addr;
+
+	addr = va_start + (pages_off << PAGE_SHIFT);
+	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
+	return (void *)addr;
+}
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
@@ -2327,137 +2458,6 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 
 /*** Per cpu kva allocator ***/
 
-/*
- * vmap space is limited especially on 32 bit architectures. Ensure there is
- * room for at least 16 percpu vmap blocks per CPU.
- */
-/*
- * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be able
- * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
- * instead (we just need a rough idea)
- */
-#if BITS_PER_LONG == 32
-#define VMALLOC_SPACE		(128UL*1024*1024)
-#else
-#define VMALLOC_SPACE		(128UL*1024*1024*1024)
-#endif
-
-#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
-#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
-#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
-#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
-#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
-#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
-#define VMAP_BBMAP_BITS		\
-		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
-		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
-			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
-
-#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
-
-/*
- * Purge threshold to prevent overeager purging of fragmented blocks for
- * regular operations: Purge if vb->free is less than 1/4 of the capacity.
- */
-#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
-
-#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
-#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
-#define VMAP_FLAGS_MASK		0x3
-
-struct vmap_block_queue {
-	spinlock_t lock;
-	struct list_head free;
-
-	/*
-	 * An xarray requires an extra memory dynamically to
-	 * be allocated. If it is an issue, we can use rb-tree
-	 * instead.
-	 */
-	struct xarray vmap_blocks;
-};
-
-struct vmap_block {
-	spinlock_t lock;
-	struct vmap_area *va;
-	unsigned long free, dirty;
-	DECLARE_BITMAP(used_map, VMAP_BBMAP_BITS);
-	unsigned long dirty_min, dirty_max; /*< dirty range */
-	struct list_head free_list;
-	struct rcu_head rcu_head;
-	struct list_head purge;
-};
-
-/* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
-static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
-
-/*
- * In order to fast access to any "vmap_block" associated with a
- * specific address, we use a hash.
- *
- * A per-cpu vmap_block_queue is used in both ways, to serialize
- * an access to free block chains among CPUs(alloc path) and it
- * also acts as a vmap_block hash(alloc/free paths). It means we
- * overload it, since we already have the per-cpu array which is
- * used as a hash table. When used as a hash a 'cpu' passed to
- * per_cpu() is not actually a CPU but rather a hash index.
- *
- * A hash function is addr_to_vb_xa() which hashes any address
- * to a specific index(in a hash) it belongs to. This then uses a
- * per_cpu() macro to access an array with generated index.
- *
- * An example:
- *
- *  CPU_1  CPU_2  CPU_0
- *    |      |      |
- *    V      V      V
- * 0     10     20     30     40     50     60
- * |------|------|------|------|------|------|...<vmap address space>
- *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
- *
- * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
- *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
- *
- * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
- *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
- *
- * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
- *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
- *
- * This technique almost always avoids lock contention on insert/remove,
- * however xarray spinlocks protect against any contention that remains.
- */
-static struct xarray *
-addr_to_vb_xa(unsigned long addr)
-{
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
-
-	return &per_cpu(vmap_block_queue, index).vmap_blocks;
-}
-
-/*
- * We should probably have a fallback mechanism to allocate virtual memory
- * out of partially filled vmap blocks. However vmap block sizing should be
- * fairly reasonable according to the vmalloc size, so it shouldn't be a
- * big problem.
- */
-
-static unsigned long addr_to_vb_idx(unsigned long addr)
-{
-	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
-	addr /= VMAP_BLOCK_SIZE;
-	return addr;
-}
-
-static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
-{
-	unsigned long addr;
-
-	addr = va_start + (pages_off << PAGE_SHIFT);
-	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
-	return (void *)addr;
-}
-
 /**
  * new_vmap_block - allocates new vmap_block and occupies 2^order pages in this
  *                  block. Of course pages number can't exceed VMAP_BBMAP_BITS
-- 
2.43.0


