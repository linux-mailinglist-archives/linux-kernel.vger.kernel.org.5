Return-Path: <linux-kernel+bounces-86288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41586C36A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E98B2893B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9774EB24;
	Thu, 29 Feb 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY9/lmKt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6E4CE00
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195198; cv=none; b=lORfLT9SnR+lIfBP9fW0xQCzfdNvD3Wp7cNxu4NyFJ16lLmbdYbqd4JMlh1TPo1kGvGKEDXl7va56eXQknlECmC7iApSKI9+he4R7Gefol44j0/rlSRBUsSfT1PJGvPYoFwV+VvlXLSYLl2xD8IvZPghc08md9OAbFWkuIJA3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195198; c=relaxed/simple;
	bh=juUcc4UcKK/NL61XUnA4t+5ff677KqidZ2CHwPWtVYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvWK4bytIVJy/KsJk3zLAYQtQQt14bIusYcGdMyMeDWcCAxMNIiobHtFvWUMuLFSxKjtSweTx7GP315Nm20vgxh1iQTfYMr3ZqsybdYJPkOUnnY9a8X1EPacKT9KiALsNCwOI6H+r592LfFasX7NKVwZMx4r4QJsYVdKwOd35a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nY9/lmKt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709195196; x=1740731196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=juUcc4UcKK/NL61XUnA4t+5ff677KqidZ2CHwPWtVYc=;
  b=nY9/lmKtN2mJm7OUgW9B5felRxxM+kkRVMH18cOxWdWkmQW2roldibY7
   iZq59vTmq3ZejqR8/JbN2Njvv81ZgfkN7P0esAMIFBqKI5BlYgLZ9Q9KK
   hrp0dqzd8WmGZrF2J3BcWb5BByM6isVKXNYDLJXcHECurQM7grrbi6CVz
   m/ZQDceRrCEJqiPh/KkFbQSL7kHLjHwlBs43T/iNdQPD7gyh8PJELWwOh
   CLxgjFmf7QqRan/9MaQ1cxcVlN9QnWgdC/9w4EwpuUXyjfivK01KZ4RGI
   NRDmvWdVrPZOkpxDJcgGVKXyKVMbrSy+ZRi9l6npDlnQJ4obj30Ks9/2f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="29082088"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="29082088"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 00:26:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12360365"
Received: from a4bf01946c30.jf.intel.com ([10.165.116.30])
  by fmviesa004.fm.intel.com with ESMTP; 29 Feb 2024 00:26:33 -0800
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
Subject: [PATCH v6] mm/vmalloc: lock contention optimization under multi-threading
Date: Thu, 29 Feb 2024 00:26:11 -0800
Message-ID: <20240229082611.4104839-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating a new memory area where the mapping address range is
known, it is observed that the vmap_node->busy.lock is acquired twice.

The first acquisition occurs in the alloc_vmap_area() function when
inserting the vm area into the vm mapping red-black tree. The second
acquisition occurs in the setup_vmalloc_vm() function when updating the
properties of the vm, such as flags and address, etc.

Combine these two operations together in alloc_vmap_area(), which
improves scalability when the vmap_node->busy.lock is contended.
By doing so, the need to acquire the lock twice can also be eliminated
 to once.

With the above change, tested on intel sapphire rapids
platform(224 vcpu), a 4% performance improvement is
gained on stress-ng/pthread(https://github.com/ColinIanKing/stress-ng),
which is the stress test of thread creations.

Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: "Chen, Tim C" <tim.c.chen@intel.com>
Reviewed-by: "King, Colin" <colin.king@intel.com>
Signed-off-by: rulinhuang <rulin.huang@intel.com>
---
V1 -> V2: Avoided the partial initialization issue of vm and
separated insert_vmap_area() from alloc_vmap_area()
V2 -> V3: Rebased on 6.8-rc5
V3 -> V4: Rebased on mm-unstable branch
V4 -> V5: cancel the split of alloc_vmap_area()
and keep insert_vmap_area()
V5 -> V6: add bug_on
---
 mm/vmalloc.c | 132 +++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 68 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..5ae028b0d58d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1841,15 +1841,66 @@ node_alloc(unsigned long size, unsigned long align,
 	return va;
 }
 
+/*** Per cpu kva allocator ***/
+
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
+static inline void setup_vmalloc_vm(struct vm_struct *vm,
+	struct vmap_area *va, unsigned long flags, const void *caller)
+{
+	vm->flags = flags;
+	vm->addr = (void *)va->va_start;
+	vm->size = va->va_end - va->va_start;
+	vm->caller = caller;
+	va->vm = vm;
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
- * vstart and vend.
+ * vstart and vend. If vm is passed in, the two will also be bound.
  */
 static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask,
-				unsigned long va_flags)
+				unsigned long va_flags, struct vm_struct *vm,
+				unsigned long flags, const void *caller)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
@@ -1912,6 +1963,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = (va_flags | vn_id);
 
+	if (vm) {
+		BUG_ON(va_flags & VMAP_RAM);
+		setup_vmalloc_vm(vm, va, flags, caller);
+	}
+
 	vn = addr_to_node(va->va_start);
 
 	spin_lock(&vn->busy.lock);
@@ -2325,46 +2381,6 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 	return NULL;
 }
 
-/*** Per cpu kva allocator ***/
-
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
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
@@ -2486,7 +2502,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
 					node, gfp_mask,
-					VMAP_RAM|VMAP_BLOCK);
+					VMAP_RAM|VMAP_BLOCK, NULL,
+					0, NULL);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2843,7 +2860,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		struct vmap_area *va;
 		va = alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END,
-				node, GFP_KERNEL, VMAP_RAM);
+				node, GFP_KERNEL, VMAP_RAM,
+				NULL, 0, NULL);
 		if (IS_ERR(va))
 			return NULL;
 
@@ -2946,26 +2964,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
-	struct vmap_area *va, unsigned long flags, const void *caller)
-{
-	vm->flags = flags;
-	vm->addr = (void *)va->va_start;
-	vm->size = va->va_end - va->va_start;
-	vm->caller = caller;
-	va->vm = vm;
-}
-
-static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, const void *caller)
-{
-	struct vmap_node *vn = addr_to_node(va->va_start);
-
-	spin_lock(&vn->busy.lock);
-	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vn->busy.lock);
-}
-
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 {
 	/*
@@ -3002,14 +3000,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
 	}
 
-	setup_vmalloc_vm(area, va, flags, caller);
-
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.
@@ -4584,7 +4580,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}

base-commit: 7e6ae2db7f319bf9613ec6db8fa3c9bc1de1b346
-- 
2.43.0


