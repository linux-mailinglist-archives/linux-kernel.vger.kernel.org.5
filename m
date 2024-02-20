Return-Path: <linux-kernel+bounces-72639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C662085B690
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D68A2854EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5B61699;
	Tue, 20 Feb 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4Vm+Tpu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E055FDC3
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419762; cv=none; b=G0rmops1DjT6Xko5u6plANOmOytYIgRs1UXrKESEOSUcsE5/3HAi5uSCNcCPUSVGfNklbcbco/1XxHDe/6ogKFKsQN2yGfI2UETEDRJsB6mUDkvsdMu14hXCxXTT0DoHVL73NPYp7Qb9zRmjGe5OAA97aqMKEsVjew/uSsO7uaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419762; c=relaxed/simple;
	bh=mYhlp/eMEhKS03KF61dRGQDnPpkxK3pDWAEVI1m8zMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpLUz8EKW6RC8uxQLg1WhlBMKTyJphKvs1WUD7mX0wXr8ZP+sMRhLdJGzmO0uA+a7xmMwc6XmNa1Sak5R1iPF19zx8zNQnmeEzhZgWGZQXJpr4eNG9lbtoBUbEwgkUQFFwSB2VOIQMeyQVsClbPlnL+Cp7SL0mPe+BNUhHwf6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4Vm+Tpu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708419761; x=1739955761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYhlp/eMEhKS03KF61dRGQDnPpkxK3pDWAEVI1m8zMM=;
  b=I4Vm+TpuuRKIwgrVwWdPMbRRJkNdUf2tYPQmY+lm+aYxl6VdBZub0wkN
   UaG6dsCIXtkIpWVNPIx9CnLQCHF/uwzGKtLR4fqFI1amUikeCM7Y5VO/+
   OAvpfuY2Ivf/ULK3esGW6aG/7Fe9dcjPNkwm0QgakGvt76B749b63vAH4
   oNJP2y5f0ospts/LSeNr+Z/wB2oa5V7CsWU6FNvbVRCl74urw2QVUAYqx
   W4TS4IV59SP2x+R5Di8E9UU936yMidM1w2yfWQv5JTcjciXQ+FtW+q7An
   hABhNoEqwpWEUmYGyo6ZrL0US1O1VDGUMcx4mmENWitpVfngcuXELwohU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2391932"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2391932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913039557"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913039557"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2024 01:02:27 -0800
From: rulinhuang <rulin.huang@intel.com>
To: urezki@gmail.com
Cc: akpm@linux-foundation.org,
	colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tim.c.chen@intel.com,
	zhiguo.zhou@intel.com,
	wangyang.guo@intel.com,
	tianyou.li@intel.com
Subject: [PATCH v2] mm/vmalloc: lock contention optimization under multi-threading
Date: Tue, 20 Feb 2024 04:05:21 -0500
Message-ID: <20240220090521.3316345-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209115147.261510-1-rulin.huang@intel.com>
References: <20240209115147.261510-1-rulin.huang@intel.com>
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
---
 mm/vmalloc.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c171..768e45f2ed946 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1630,17 +1630,18 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = va_flags;
 
-	spin_lock(&vmap_area_lock);
-	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
-	spin_unlock(&vmap_area_lock);
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
 
@@ -1669,6 +1670,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	return ERR_PTR(-EBUSY);
 }
 
+static inline void insert_vmap_area_with_lock(struct vmap_area *va)
+{
+	spin_lock(&vmap_area_lock);
+	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+	spin_unlock(&vmap_area_lock);
+}
+
 int register_vmap_purge_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&vmap_notify_list, nb);
@@ -2045,6 +2053,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_CAST(va);
 	}
 
+	insert_vmap_area_with_lock(va);
+
 	vaddr = vmap_block_vaddr(va->va_start, 0);
 	spin_lock_init(&vb->lock);
 	vb->va = va;
@@ -2398,6 +2408,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 		if (IS_ERR(va))
 			return NULL;
 
+		insert_vmap_area_with_lock(va);
+
 		addr = va->va_start;
 		mem = (void *)addr;
 	}
@@ -2538,7 +2550,7 @@ static void vmap_init_free_space(void)
 	}
 }
 
-static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
+static inline void setup_vmalloc_vm(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
 	vm->flags = flags;
@@ -2548,14 +2560,6 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
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
@@ -2600,6 +2604,8 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 
 	setup_vmalloc_vm(area, va, flags, caller);
 
+	insert_vmap_area_with_lock(va);
+
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.
@@ -4166,7 +4172,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	for (area = 0; area < nr_vms; area++) {
 		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
 
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 	}
 	spin_unlock(&vmap_area_lock);

base-commit: de927f6c0b07d9e698416c5b287c521b07694cac
-- 
2.43.0


