Return-Path: <linux-kernel+bounces-94853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B8A8745F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173D21F2144C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91C5C89;
	Thu,  7 Mar 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqykEe/i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB046AF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777496; cv=none; b=PkCC7t6cE+U9jNhaBugffowfuQxpRQCw56S8yTGwnX9LxuIDBPesJUa3ifbhSd//hDKLr3zbrRIkRWu4upItnPZul+zrk/ckcAdwlC4P46r1EyOh+/feyHWJwx0s7pMQtdkfTHDmpvbsesrOYcwVyTBQrcD1zf0Es0anmo0H5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777496; c=relaxed/simple;
	bh=rSVzpqAtaP7VsIqGvDvnM7VnZ7HA9GL+hoNyerON4vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQuvexJn1iXL748dag1DMbM/hoRSTs+K/TQZVCxU8R6avDyfd9Bhp67rvAK6XG0ypmM0uCYpdBOUbEbRWNFbI+mdwlgxb2sYuOj7/n+VK9ylrR5Vo3U/PZBeiqCZFxEVW0Jj3NTldP6k9eNZyweFY99L5CujZyk3pSrXh4x5lfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqykEe/i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709777494; x=1741313494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rSVzpqAtaP7VsIqGvDvnM7VnZ7HA9GL+hoNyerON4vw=;
  b=AqykEe/iPYhB8PFnj1dpGbAt/D+WWQ+wH2GTC/25MF5xXg0RktWt2n5g
   2g8CYXm/OX8cqz0Yh8PA2vnzmyf494Y4awL2WDR7KAqVg+mx6++p4UDM1
   JxINoDeLhxSQj5sqZXWbZFRpT7uYWjavLQpjCd2z/xv+D0FkIDw0WkQ4H
   5SRPk9kshwvcKWWaXrQ1QCFNtx/Wa+bKpN/peoB7AF6qYU1EFgy+Url+g
   3OoUCTJMHVXkKVG206N+YykNEgdtyQCK2yq0JWyPl+zG2nvysVa0B7v/Z
   vKDN0I6UeTOqFsQGIsGoJzLknclh+JyVYz15fz9XqA4yeEM0KwLIGaNq+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4594949"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4594949"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 18:11:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9852876"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa007.fm.intel.com with ESMTP; 06 Mar 2024 18:11:30 -0800
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
Subject: [PATCH v8] mm/vmalloc: Eliminated the lock contention from twice to once
Date: Wed,  6 Mar 2024 21:14:40 -0500
Message-ID: <20240307021440.64967-1-rulin.huang@intel.com>
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

Co-developed-by: "Chen, Tim C" <tim.c.chen@intel.com>
Signed-off-by: "Chen, Tim C" <tim.c.chen@intel.com>
Co-developed-by: "King, Colin" <colin.king@intel.com>
Signed-off-by: "King, Colin" <colin.king@intel.com>
Signed-off-by: rulinhuang <rulin.huang@intel.com>
---
V1 -> V2: Avoided the partial initialization issue of vm and
separated insert_vmap_area() from alloc_vmap_area()
V2 -> V3: Rebased on 6.8-rc5
V3 -> V4: Rebased on mm-unstable branch
V4 -> V5: Canceled the split of alloc_vmap_area()
and keep insert_vmap_area()
V5 -> V6: Added bug_on
V6 -> V7: Adjusted the macros
V7 -> V8: Removed bugs_on and adjustion of macros
---
 mm/vmalloc.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..f933a62fef50 100644
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
@@ -3002,14 +2998,12 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
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
@@ -4584,7 +4578,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}

base-commit: f4239a5d7acc1b5ff9bac4d5471000b952279ef0
-- 
2.43.0


