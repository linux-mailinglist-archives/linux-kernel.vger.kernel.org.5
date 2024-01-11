Return-Path: <linux-kernel+bounces-22961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C582A5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4602328761C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E120E111D;
	Thu, 11 Jan 2024 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a46xlnMp"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56BEC9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704939339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o0NgjRU2NV7JHGIppMqbyQQ2ZDc1uYffbVtkLp09wOM=;
	b=a46xlnMprMCg8OaJGKL+IpPWkj4c0zSutZ2JLvyGTBnlR0FJekhX1FZmtHMxnd01eYfgr4
	Xr3pH+cgzIR422DF5vMG4EZr3DC6jkGwJBD3ZO4E0dR3vTXeYb895kwAPh8U69zp2S+z54
	pFwqFTAhAjKCTvYiyKzLQc04FJZh0YA=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mmap: introduce vma_range_init()
Date: Thu, 11 Jan 2024 10:15:26 +0800
Message-Id: <20240111021526.3461825-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is a lot of code needs to set the range of vma, introduce
vma_range_init() to initialize the range of vma.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/mm.h |  9 +++++++++
 mm/mmap.c          | 29 +++++++----------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..abb4534be3cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3516,6 +3516,15 @@ static inline bool range_in_vma(struct vm_area_struct *vma,
 	return (vma && vma->vm_start <= start && end <= vma->vm_end);
 }
 
+static inline void vma_range_init(struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
+
 #ifdef CONFIG_MMU
 pgprot_t vm_get_page_prot(unsigned long vm_flags);
 void vma_set_page_prot(struct vm_area_struct *vma);
diff --git a/mm/mmap.c b/mm/mmap.c
index 06f1f3e88598..0d3f4612d001 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -663,9 +663,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
+	vma_range_init(vma, start, end, pgoff);
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
@@ -708,9 +706,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_adjust_trans_huge(vma, start, end, 0);
 
 	vma_iter_clear(vmi);
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
+	vma_range_init(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
 	return 0;
 }
@@ -1015,10 +1011,7 @@ static struct vm_area_struct
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-
-	vma->vm_start = vma_start;
-	vma->vm_end = vma_end;
-	vma->vm_pgoff = vma_pgoff;
+	vma_range_init(vma, vma_start, vma_end, vma_pgoff);
 
 	if (vma_expanded)
 		vma_iter_store(vmi, vma);
@@ -2811,11 +2804,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	vma_iter_config(&vmi, addr, end);
-	vma->vm_start = addr;
-	vma->vm_end = end;
+	vma_range_init(vma, addr, end, pgoff);
 	vm_flags_init(vma, vm_flags);
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
-	vma->vm_pgoff = pgoff;
 
 	if (file) {
 		vma->vm_file = get_file(file);
@@ -3165,9 +3156,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto unacct_fail;
 
 	vma_set_anonymous(vma);
-	vma->vm_start = addr;
-	vma->vm_end = addr + len;
-	vma->vm_pgoff = addr >> PAGE_SHIFT;
+	vma_range_init(vma, addr, addr + len, addr >> PAGE_SHIFT);
 	vm_flags_init(vma, flags);
 	vma->vm_page_prot = vm_get_page_prot(flags);
 	vma_start_write(vma);
@@ -3404,9 +3393,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
-		new_vma->vm_start = addr;
-		new_vma->vm_end = addr + len;
-		new_vma->vm_pgoff = pgoff;
+		vma_range_init(new_vma, addr, addr + len, pgoff);
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
 		if (anon_vma_clone(new_vma, vma))
@@ -3574,9 +3561,7 @@ static struct vm_area_struct *__install_special_mapping(
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
 
-	vma->vm_start = addr;
-	vma->vm_end = addr + len;
-
+	vma_range_init(vma, addr, addr + len, 0);
 	vm_flags_init(vma, (vm_flags | mm->def_flags |
 		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-- 
2.25.1


