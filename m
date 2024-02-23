Return-Path: <linux-kernel+bounces-78341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75177861227
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9985E1C22BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343B7E571;
	Fri, 23 Feb 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hbzqe4kj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F17CF1D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693270; cv=none; b=sJcQgeS+1b3UuShEiiNMy0ytJU6wwDQqSxI2rrIb7xX4KHohjqlCj57sX9KIht9YGSuzNerkttUs09ueXxu38+KOlZ6Fx4gqPo34OKzIuPVqgBN/mrD/PPVbkJBhMbaF2UVyWvMOwACfn0YjU/iXLpkPTlUSeA6Y9Acr5zk9uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693270; c=relaxed/simple;
	bh=8zCjAhelcZ3RRKa7WFuIXi9YgEQhHdl4OA8stTHmYYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FObKgosaCr+gYtQxsGxSqjzNGAVc31rrTivWUQsenrEU8NolbuDdy4b5ZHkL1glZt1hJNEp6VLlcJaaKRwUjTUTOZ+YqyZwAi84ard3VrjVFc+7W4AsLaZ1DwbQfBbnew9p/EpT5v2cNSl+Vlqi1czV1tKCtarFmdiRKzlyZtq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hbzqe4kj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708693269; x=1740229269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8zCjAhelcZ3RRKa7WFuIXi9YgEQhHdl4OA8stTHmYYE=;
  b=Hbzqe4kj/jTcTeIdv7Q3Y2HAGHTGZdCJTRg/nVhjn33xhwZ6pVGSi0k1
   9LcRLb64ae3xn+MXyhpUkgwX8x4l1sNbavLWKLhc3co5iA8auwNzmczKJ
   OWKHFG0LAea41lX1lJe3Eo646HNHr5sJDWiHFFzfYUu4YN+EZ6tzdO/hm
   CqgV0H3D3a2a3a7axcN1A9jCloSd2mkX30lXojSu/pUUnDIN2IfFTuPq0
   zcEakfcyxVjRLe+HvwKQAztrOfkZPzpAsqklWdQhwHqBYywqA+yDy1b2k
   /C+PrK1UJMsEmhs2m4mtvw/TQvE3dzOPhpE/wSMHGLufARIwTEjvgxjhL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="25479602"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="25479602"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 05:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10596216"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by orviesa004.jf.intel.com with ESMTP; 23 Feb 2024 05:01:04 -0800
From: rulinhuang <rulin.huang@intel.com>
To: urezki@gmail.com,
	bhe@redhat.com
Cc: colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	wangyang.guo@intel.com,
	zhiguo.zhou@intel.com
Subject: [PATCH v5] mm/vmalloc: lock contention optimization under multi-threading
Date: Fri, 23 Feb 2024 08:03:19 -0500
Message-ID: <20240223130318.112198-2-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207033059.1565623-1-rulin.huang@intel.com>
References: <20240207033059.1565623-1-rulin.huang@intel.com>
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

Reviewed-by: Chen Tim C <tim.c.chen@intel.com>
Reviewed-by: King Colin <colin.king@intel.com>
Signed-off-by: rulinhuang <rulin.huang@intel.com>
---
V1 -> V2: Avoided the partial initialization issue of vm and
separated insert_vmap_area() from alloc_vmap_area()
V2 -> V3: Rebased on 6.8-rc5
V3 -> V4: Rebased on mm-unstable branch
V4 -> V5: cancel the split of alloc_vmap_area()
and keep insert_vmap_area()
---
 mm/vmalloc.c | 48 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..6baaf08737f8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1841,15 +1841,26 @@ node_alloc(unsigned long size, unsigned long align,
 	return va;
 }
 
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
@@ -1912,6 +1923,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = (va_flags | vn_id);
 
+	if (vm)
+		setup_vmalloc_vm(vm, va, flags, caller);
+
 	vn = addr_to_node(va->va_start);
 
 	spin_lock(&vn->busy.lock);
@@ -2486,7 +2500,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
 					node, gfp_mask,
-					VMAP_RAM|VMAP_BLOCK);
+					VMAP_RAM|VMAP_BLOCK, NULL,
+					0, NULL);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2843,7 +2858,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		struct vmap_area *va;
 		va = alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END,
-				node, GFP_KERNEL, VMAP_RAM);
+				node, GFP_KERNEL, VMAP_RAM,
+				NULL, 0, NULL);
 		if (IS_ERR(va))
 			return NULL;
 
@@ -2946,26 +2962,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
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
@@ -3002,7 +2998,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 	if (!(flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
-	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
+	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
@@ -4584,7 +4580,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}

base-commit: c09a8e005eff6c064e2e9f11549966c36a724fbf
-- 
2.43.0


