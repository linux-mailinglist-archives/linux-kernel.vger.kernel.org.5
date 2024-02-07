Return-Path: <linux-kernel+bounces-55893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F784C31A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D229B1F2860A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF212B75;
	Wed,  7 Feb 2024 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjBYdx31"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E88101F2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276542; cv=none; b=VtNZtQd5Aep8ui/5x1TGEQJaYEOdzpY/+NHBvggKCSs89uw4FYZyAoXA4bGbV09nAVLcaQwiGs4Odg81DiNNMzhibRD8hroKw8XbcYGMncAfHKEfMmL44JQRASeGCQs2lSXNt7zx/y4WjMu4ck9hVYiRBM8VFK0OwLqdWypvFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276542; c=relaxed/simple;
	bh=5z8kY6K3nvIR3A14IdHiEafFgYEBuUDMqEiZjPP8O+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcXD0zRMQ+BTCznDwx4UMHB3a8sM7P0/Y4rDDHvzfyTE8TVoeUVtMbvfKlYUKZp7filFDasOtgfF7f6XeibwwmnbqYbW2MNNjVJWZ7uveJ2aDC0pz3VO6FAoH/RnGe8JPkPO/yF9LL+o6B2Se8qKn+OVL/bTem49CjR6j24M3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjBYdx31; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707276540; x=1738812540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5z8kY6K3nvIR3A14IdHiEafFgYEBuUDMqEiZjPP8O+Y=;
  b=IjBYdx31S828hlmx7Iv+rn38BUoJPFSrirsaMhWRpoRCOsFUqx+E+eOw
   cx26lSQfZdyQ+yBJYg9xSdjQIGaBej1/nlZ9PO9l0gIJ5BeZnLHVMn8al
   NPXs/CF879j3PjsKTF2M3QR2uwPFAzDimJAs+PGQcI1/nVzaT+frQD3uM
   mAzDTAVkFyN82VvpbZceiFE1stUsBkGMqSleOn/P3s7PWFN+sQGh/edbB
   2vj1OdTcPi6wt8IjYgH/cd3KQmY5acsZrFpXooc46ER1/v0t1qR4+6PM7
   8q+ML9wwENJ4Cy6sTVctcx5FyRLvKxEqF5CN3vp8v5Ev7zHLRzZR405os
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="26344748"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="26344748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 19:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="824384659"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="824384659"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2024 19:28:52 -0800
From: rulinhuang <rulin.huang@intel.com>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	lstoakes@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tim.c.chen@intel.com,
	colin.king@intel.com,
	zhiguo.zhou@intel.com,
	rulinhuang <rulin.huang@intel.com>
Subject: [PATCH] mm/vmalloc: lock contention optimization under multi-threading
Date: Tue,  6 Feb 2024 22:30:59 -0500
Message-ID: <20240207033059.1565623-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating a new memory area where the mapping address range is
known, it is observed that the vmap_area lock is acquired twice.
The first acquisition occurs in the alloc_vmap_area() function when
inserting the vm area into the vm mapping red-black tree. The second
acquisition occurs in the setup_vmalloc_vm() function when updating the
properties of the vm, such as flags and address, etc.
Combine these two operations together in alloc_vmap_area(), which
improves scalability when the vmap_area lock is contended. By doing so,
the need to acquire the lock twice can also be eliminated.
With the above change, tested on intel icelake platform(160 vcpu, kernel
v6.7), a 6% performance improvement and a 7% reduction in overall
spinlock hotspot are gained on
stress-ng/pthread(https://github.com/ColinIanKing/stress-ng), which is
the stress test of thread creations.

Reviewed-by: "Chen, Tim C" <tim.c.chen@intel.com>
Reviewed-by: "King, Colin" <colin.king@intel.com>
Signed-off-by: rulinhuang <rulin.huang@intel.com>
---
 mm/vmalloc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c171..3b1f616e8ecf0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1577,13 +1577,13 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 
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
+				unsigned long va_flags, struct vm_struct *vm)
 {
 	struct vmap_area *va;
 	unsigned long freed;
@@ -1627,9 +1627,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	va->va_start = addr;
 	va->va_end = addr + size;
-	va->vm = NULL;
+	va->vm = vm;
 	va->flags = va_flags;
 
+	if (vm != NULL)
+		vm->addr = (void *)addr;
+
 	spin_lock(&vmap_area_lock);
 	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
 	spin_unlock(&vmap_area_lock);
@@ -2039,7 +2042,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
 					node, gfp_mask,
-					VMAP_RAM|VMAP_BLOCK);
+					VMAP_RAM|VMAP_BLOCK,
+					NULL);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2394,7 +2398,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		struct vmap_area *va;
 		va = alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END,
-				node, GFP_KERNEL, VMAP_RAM);
+				node, GFP_KERNEL, VMAP_RAM,
+				NULL);
 		if (IS_ERR(va))
 			return NULL;
 
@@ -2548,14 +2553,6 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	va->vm = vm;
 }
 
-static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, const void *caller)
-{
-	spin_lock(&vmap_area_lock);
-	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vmap_area_lock);
-}
-
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 {
 	/*
@@ -2592,14 +2589,16 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
+	area->flags = flags;
+	area->caller = caller;
+	area->size = size;
+
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
 	}
 
-	setup_vmalloc_vm(area, va, flags, caller);
-
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.

base-commit: de927f6c0b07d9e698416c5b287c521b07694cac
-- 
2.43.0


