Return-Path: <linux-kernel+bounces-36413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA383A04B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EF1F2BBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164606FBB;
	Wed, 24 Jan 2024 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rs501SWW"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D128F72
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068674; cv=none; b=CqWaFNcA+5WgYd7fyLT9bB2MxsVZRYsTmyXqmRH81Aq4pErNmCshcE7b6ioQOIpyWgK3PMz8mRKtzebyXvxEjEIoEAItc6f2KBjrbvoTB24kawgj+aPj8YPrUB9WLrzUtEaf7fiTuQ6LeoZEikA8JJCzPRtTQVm1S1OS5dX+G38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068674; c=relaxed/simple;
	bh=lYhs7+P2QVAmsCMG3P7ZWdn74Zqa7PqQiiZy1MmiysM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iF7FSqEvHqCRdjDI5d5NEgMEUawlNBmb0cEdpLkpC66p+YTU7570ZuMmIahkBkoKZKVHpS+M5JsRdOdY//UTUPVEMjQd8+5jazRArqcbO6y3CdcvU6B9V0breBZIPAd1aJ0PmNOSRen0ka830gK0wYJZ0qDPcWPt2YoK+wEknLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rs501SWW; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706068670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pc/i1VbKtSEso2IXmI9KYzDVtKwwDVTOJQT3Za9yKGw=;
	b=rs501SWWvHSqUn4l2tYKu2axRaydOkEfeidfRdsBh4PsSCB/4WXkcMdxeCkhkrN8AEfRyr
	o7OeGK4Qb2v5wTaPX/82JaXWhXrB0t26jvsNfJyca+MUE0k0r6xJ5z9HIna0Ok+PizijC9
	qusxYYVBIGJXweAxwlhbCiaPhRe9bf0=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] mm/mmap: introduce vma_set_range()
Date: Wed, 24 Jan 2024 11:57:19 +0800
Message-Id: <20240124035719.3685193-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is a lot of code needs to set the range of vma in mmap.c,
introduce vma_set_range() to simplify the code.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: use vma_set_range and put it to mm/internal.h.
v1: https://lore.kernel.org/all/20240111021526.3461825-1-yajun.deng@linux.dev/
---
 mm/internal.h |  9 +++++++++
 mm/mmap.c     | 29 +++++++----------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..1e29c5821a1d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1114,6 +1114,15 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 extern bool mirrored_kernelcore;
 extern bool memblock_has_mirror(void);
 
+static __always_inline void vma_set_range(struct vm_area_struct *vma,
+					  unsigned long start, unsigned long end,
+					  pgoff_t pgoff)
+{
+	vma->vm_start = start;
+	vma->vm_end = end;
+	vma->vm_pgoff = pgoff;
+}
+
 static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 {
 	/*
diff --git a/mm/mmap.c b/mm/mmap.c
index cf2f058bb3ae..7a9d2895a1bd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -663,9 +663,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
+	vma_set_range(vma, start, end, pgoff);
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
@@ -708,9 +706,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_adjust_trans_huge(vma, start, end, 0);
 
 	vma_iter_clear(vmi);
-	vma->vm_start = start;
-	vma->vm_end = end;
-	vma->vm_pgoff = pgoff;
+	vma_set_range(vma, start, end, pgoff);
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
+	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
 
 	if (vma_expanded)
 		vma_iter_store(vmi, vma);
@@ -2809,11 +2802,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	vma_iter_config(&vmi, addr, end);
-	vma->vm_start = addr;
-	vma->vm_end = end;
+	vma_set_range(vma, addr, end, pgoff);
 	vm_flags_init(vma, vm_flags);
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);
-	vma->vm_pgoff = pgoff;
 
 	if (file) {
 		vma->vm_file = get_file(file);
@@ -3163,9 +3154,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto unacct_fail;
 
 	vma_set_anonymous(vma);
-	vma->vm_start = addr;
-	vma->vm_end = addr + len;
-	vma->vm_pgoff = addr >> PAGE_SHIFT;
+	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
 	vm_flags_init(vma, flags);
 	vma->vm_page_prot = vm_get_page_prot(flags);
 	vma_start_write(vma);
@@ -3402,9 +3391,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
-		new_vma->vm_start = addr;
-		new_vma->vm_end = addr + len;
-		new_vma->vm_pgoff = pgoff;
+		vma_set_range(new_vma, addr, addr + len, pgoff);
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
 		if (anon_vma_clone(new_vma, vma))
@@ -3572,9 +3559,7 @@ static struct vm_area_struct *__install_special_mapping(
 	if (unlikely(vma == NULL))
 		return ERR_PTR(-ENOMEM);
 
-	vma->vm_start = addr;
-	vma->vm_end = addr + len;
-
+	vma_set_range(vma, addr, addr + len, 0);
 	vm_flags_init(vma, (vm_flags | mm->def_flags |
 		      VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-- 
2.25.1


