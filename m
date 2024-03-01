Return-Path: <linux-kernel+bounces-88644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D18186E4B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC001C2279F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4170AEA;
	Fri,  1 Mar 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYILHS0z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED570CC4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308291; cv=none; b=cxzD9aups07VvBj3FfgOoka6b2X8jX7bxEZWzDySamuo97dSlis050L3K0m6ixssXRXBt5rszBDHRHRk0ukBpm0igXoddXtK15CPCb+o5VXSotmW0DpMvH9y7C+lGMoInm0nHDhGTLif4qj7l9MWgBXP7AOwfEjqji2tlzHG2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308291; c=relaxed/simple;
	bh=fKIRYBDOdjh4bWSu8rF+M1ucRSxQ8Q/A6JLal5oOMx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6Tbm7qVzIhesDBZ75LiGTj6i3MTX18wfJRxcR1/AFbUBDEGovXN/sw98kSly54FJ29HsYc6CkvcA6Cl18vrr453Ucehlh4/OZp1WgPXCHHLielnbakskuK76LEQqHSqcjkoRA8OASAY1hJvCRfuy3SYsElnvjcfitAiITWsOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYILHS0z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709308289; x=1740844289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fKIRYBDOdjh4bWSu8rF+M1ucRSxQ8Q/A6JLal5oOMx0=;
  b=NYILHS0zBBV+NAot/AM+Blhi6tDUMuDpwSO+oABVcLG8RajPlLdnkYa/
   eQLOuDm1/kkW1Df4grif3pdOWGZdeI8w9YMszyy5d7FCPbuWx4L/u+ZRq
   pn9+ECmHq1nGVSTNpvhSNsv9vgD85Ge8utO5ri02ypUfZpVZeJBhbtmZp
   Hrispw7kWAwQcaDsYpEgYFEMjqOusPh1Y+hA+0ExuHLnnuR7bcUElVm4+
   enF9WEyQkD8vlH8DjQJrv5clrgkX34qiBGvBlITOr01GWeSYjBOGTRMFL
   e2EcIYVpvQywvZV8hcU3LdZyxTNgJxsC1pRzfengAeoMeMf5fFOUSxer2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3700868"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3700868"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 07:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8370244"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2024 07:51:26 -0800
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
Subject: [PATCH v7 2/2] mm/vmalloc: Eliminated the lock contention from twice to once
Date: Fri,  1 Mar 2024 10:54:17 -0500
Message-ID: <20240301155417.1852290-3-rulin.huang@intel.com>
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
---
 mm/vmalloc.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fc027a61c12e..5b7c9156d8da 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1972,15 +1972,26 @@ node_alloc(unsigned long size, unsigned long align,
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
@@ -2043,6 +2054,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = (va_flags | vn_id);
 
+	if (vm) {
+		BUG_ON(va_flags & VMAP_RAM);
+		setup_vmalloc_vm(vm, va, flags, caller);
+	}
+
 	vn = addr_to_node(va->va_start);
 
 	spin_lock(&vn->busy.lock);
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
-- 
2.43.0


