Return-Path: <linux-kernel+bounces-21859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69897829557
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F17B1C219CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A463A1D5;
	Wed, 10 Jan 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QATBXoTT"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702039859
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704876396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HORRhNn8cQhlCzoO7/tuR5hnshhn8S+KOZbQ0BIusdU=;
	b=QATBXoTTJxGOORB8isMLBsltDJ0gIKHF/Qn2rl6uVul7pIKSixCFQYSo0rcgNV0arMm2Vv
	p4nfI6Y7vOFIZJGhBsDy6t3uFuZ+bWNOpM+3+LaP1C4Fm+5MvlL+lSeHvvTAmrXRp1JwO9
	E8Fw4yUlgMQZfmTD38KQfXtwXh6URNc=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mmap: simplify vma link and unlink
Date: Wed, 10 Jan 2024 16:46:22 +0800
Message-Id: <20240110084622.2425927-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The file parameter in the __remove_shared_vm_struct is no longer used,
remove it.

These functions vma_link() and mmap_region() have some of the same code,
introduce vma_link_file() helper function to simplify the code.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mmap.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b78e83d351d2..06f1f3e88598 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -105,7 +105,7 @@ void vma_set_page_prot(struct vm_area_struct *vma)
  * Requires inode->i_mapping->i_mmap_rwsem
  */
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
-		struct file *file, struct address_space *mapping)
+				      struct address_space *mapping)
 {
 	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
@@ -126,7 +126,7 @@ void unlink_file_vma(struct vm_area_struct *vma)
 	if (file) {
 		struct address_space *mapping = file->f_mapping;
 		i_mmap_lock_write(mapping);
-		__remove_shared_vm_struct(vma, file, mapping);
+		__remove_shared_vm_struct(vma, mapping);
 		i_mmap_unlock_write(mapping);
 	}
 }
@@ -392,26 +392,30 @@ static void __vma_link_file(struct vm_area_struct *vma,
 	flush_dcache_mmap_unlock(mapping);
 }
 
+static void vma_link_file(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+	struct address_space *mapping;
+
+	if (file) {
+		mapping = file->f_mapping;
+		i_mmap_lock_write(mapping);
+		__vma_link_file(vma, mapping);
+		i_mmap_unlock_write(mapping);
+	}
+}
+
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
-	struct address_space *mapping = NULL;
 
 	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
 	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
 	vma_start_write(vma);
-
 	vma_iter_store(&vmi, vma);
-
-	if (vma->vm_file) {
-		mapping = vma->vm_file->f_mapping;
-		i_mmap_lock_write(mapping);
-		__vma_link_file(vma, mapping);
-		i_mmap_unlock_write(mapping);
-	}
-
+	vma_link_file(vma);
 	mm->map_count++;
 	validate_mm(mm);
 	return 0;
@@ -519,10 +523,9 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 
 	if (vp->remove && vp->file) {
-		__remove_shared_vm_struct(vp->remove, vp->file, vp->mapping);
+		__remove_shared_vm_struct(vp->remove, vp->mapping);
 		if (vp->remove2)
-			__remove_shared_vm_struct(vp->remove2, vp->file,
-						  vp->mapping);
+			__remove_shared_vm_struct(vp->remove2, vp->mapping);
 	} else if (vp->insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
@@ -2889,16 +2892,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_start_write(vma);
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
-	if (vma->vm_file) {
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-		if (vma_is_shared_maywrite(vma))
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
+	vma_link_file(vma);
 
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
-- 
2.25.1


