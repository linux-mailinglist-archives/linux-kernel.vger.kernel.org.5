Return-Path: <linux-kernel+bounces-76472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527D85F7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EFB286EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8546448;
	Thu, 22 Feb 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjvdF7qD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651045976
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603474; cv=none; b=RNoWOybFCj22pHf2BExwo7mMzv2/2aMJDWkjMQPFj+cNEapMZR8Tmwl7VpiGdNN2oAnuO0cU/xH8JxD2+4r3iqx7jDRKwrBRNTmR7/ukBdCIYeICOuhlINpD9WLlpnS+x1vPxiJ2s+PI+XqgIFGdg0odxTX9rmmLNmXbPqsg+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603474; c=relaxed/simple;
	bh=bYSaX56dO8kdy94pHYYZFze3kwfrczgEVdVcwjZvFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDT20IqDjR4eJRikjsEK+cGkTNTMTQfHQmjyLGHn7bHcpiQRbfgaNcWOhKNfXVos6xBteM0zZfMnZTOephZPvmZIbEbydCbWOrIzATJ5/hZ/GbKq3rz8dIJKAjBqm3WQWV21AJB6VcpHbmEkxOhzujOmVkMzo6a10obG7qupBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjvdF7qD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708603473; x=1740139473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYSaX56dO8kdy94pHYYZFze3kwfrczgEVdVcwjZvFXk=;
  b=JjvdF7qDG9ze+pq6VEJx+wl7rj9BW7LSBLQn/Extr5GF14y/QsTtcXzM
   x0+wJy1G4QMl66aaSljBUcbxpGBWakKFG2LQyaru9bez/TMC3XY8iwxu1
   KurfvHu+jzlsoge/eh0T1w+mhGvQj87xto/+0RqMIb3UwYaW5WXREHjcp
   jjJt5ld4t3zgl4ionX+U151LDlrKYBuxzNxrsTYPtKAw1EZY5hTInQp2c
   2PD+iQwSO0/QHP0DGKJ/zJbTVXuIO64SmO3y4WM6d1sXmDJs+i/n+dxgX
   jUliqN5uOz3WBARqU+0y/04ZuJ7nolK3df/jzrS+kIrb+1J1i0+s0wtpZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6600879"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6600879"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913510455"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913510455"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2024 04:04:28 -0800
From: rulinhuang <rulin.huang@intel.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com
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
Subject: [PATCH v4] mm/vmalloc: lock contention optimization under multi-threading
Date: Thu, 22 Feb 2024 07:05:36 -0500
Message-ID: <20240222120536.216166-1-rulin.huang@intel.com>
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
---
 mm/vmalloc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 25a8df497255..ce126e7bc3d8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1851,7 +1851,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask,
 				unsigned long va_flags)
 {
-	struct vmap_node *vn;
 	struct vmap_area *va;
 	unsigned long freed;
 	unsigned long addr;
@@ -1912,19 +1911,18 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = (va_flags | vn_id);
 
-	vn = addr_to_node(va->va_start);
-
-	spin_lock(&vn->busy.lock);
-	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
-	spin_unlock(&vn->busy.lock);
-
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
 	ret = kasan_populate_vmalloc(addr, size);
 	if (ret) {
-		free_vmap_area(va);
+		/*
+		 * Insert/Merge it back to the free tree/list.
+		 */
+		spin_lock(&free_vmap_area_lock);
+		merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
+		spin_unlock(&free_vmap_area_lock);
 		return ERR_PTR(ret);
 	}
 
@@ -1953,6 +1951,15 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	return ERR_PTR(-EBUSY);
 }
 
+static inline void insert_vmap_area_locked(struct vmap_area *va)
+{
+	struct vmap_node *vn = addr_to_node(va->va_start);
+
+	spin_lock(&vn->busy.lock);
+	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
+	spin_unlock(&vn->busy.lock);
+}
+
 int register_vmap_purge_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&vmap_notify_list, nb);
@@ -2492,6 +2499,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_CAST(va);
 	}
 
+	insert_vmap_area_locked(va);
+
 	vaddr = vmap_block_vaddr(va->va_start, 0);
 	spin_lock_init(&vb->lock);
 	vb->va = va;
@@ -2847,6 +2856,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		if (IS_ERR(va))
 			return NULL;
 
+		insert_vmap_area_locked(va);
+
 		addr = va->va_start;
 		mem = (void *)addr;
 	}
@@ -2946,7 +2957,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
-static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
+static inline void setup_vmalloc_vm(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
 	vm->flags = flags;
@@ -2956,16 +2967,6 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	va->vm = vm;
 }
 
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
@@ -3010,6 +3011,8 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 
 	setup_vmalloc_vm(area, va, flags, caller);
 
+	insert_vmap_area_locked(va);
+
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.
@@ -4584,7 +4587,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}

base-commit: 9d193b36872d153e02e80c26203de4ee15127b58
-- 
2.39.3


