Return-Path: <linux-kernel+bounces-42310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D683FF78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610EE1C23749
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583B57898;
	Mon, 29 Jan 2024 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2n9Trm7"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7E57887
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514808; cv=none; b=WeY4ze9MX0zkEfrbJrUkMScsZqj+bmHJsvT169pWMKQvA/q4qrfuz2ZVf+Jali8s9zV3mdGpNwocpZWI2A/eiAKfta3BatbHkx2ZBlBOYr7q4z1lB3lDi6d+/NTfiMfN/YWZiOsm+m3BTxnlwW2fs4NxVscXY8SFMbrJJgV/3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514808; c=relaxed/simple;
	bh=C5/YmQiOYf1bM02I+5RvLMrUrx0MMswr/SIee6klngA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APT1QDrj5bOlSbDYhzR1TJ0I5+qTooTiDJyiGRROksN1RTe6HmONLVhTMM/f95Ps6ErzDGGJvrUeYkmF8ngJ9vQSfRy100wUnh43cZATOjkvLmqOpy5zxMw6ts2TjeLCZl02dVAA4l47Z7QmwCuQ04vWaLvkr6yuq/+E8IuQEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u2n9Trm7; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706514802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I5LyXm335j6PMvtoknG0DUGXbxAqHQBfeRBYbfkRtTU=;
	b=u2n9Trm7n2i4J+PRhNgk8iG8hI5XnpXnhkuFrieEV9sNBZejxTSo82JR4PRVtmGiqlPpcW
	Qj0mFqBZQ8QtaLyOZWaebB42+wu8VdcG2P69tzf1AVuDTsIxAD3KBwYTa2ZYpjPKPaHReN
	P164ETp3VFij3UD+/bPw0MjgY5ZKAJI=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mmap: remove the mm parameter in vma_complete()
Date: Mon, 29 Jan 2024 15:53:05 +0800
Message-Id: <20240129075305.3512138-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are vma_merge() and do_brk_flags() pass mm to vma_complete(), others
would pass the vma->vm_mm. The following explains that the mm is the
vma->vm_mm in vma_merge() and do_brk_flags().

All vma will point to the same mm struct if the vma_merge() is successful.
So the mm and the vma->mm are the same.

vm_brk_flags() and brk syscall will initialize vmi with current->mm,
so the vma->vm_mm and the current->mm are the same if vma exists in
do_brk_flags().

Remove the mm parameter in vma_complete() and get mm from the vma in vp.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e97b9144c61a..9b968d1edf55 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -509,11 +509,11 @@ static inline void vma_prepare(struct vma_prepare *vp)
  *
  * @vp: The vma_prepare struct
  * @vmi: The vma iterator
- * @mm: The mm_struct
  */
-static inline void vma_complete(struct vma_prepare *vp,
-				struct vma_iterator *vmi, struct mm_struct *mm)
+static inline void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi)
 {
+	struct mm_struct *mm = vp->vma->vm_mm;
+
 	if (vp->file) {
 		if (vp->adj_next)
 			vma_interval_tree_insert(vp->adj_next,
@@ -666,7 +666,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_set_range(vma, start, end, pgoff);
 	vma_iter_store(vmi, vma);
 
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_complete(&vp, vmi);
 	return 0;
 
 nomem:
@@ -707,7 +707,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_complete(&vp, vmi);
 	return 0;
 }
 
@@ -1030,7 +1030,7 @@ static struct vm_area_struct
 		}
 	}
 
-	vma_complete(&vp, vmi, mm);
+	vma_complete(&vp, vmi);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
@@ -2377,7 +2377,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	}
 
 	/* vma_complete stores the new vma */
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_complete(&vp, vmi);
 
 	/* Success. */
 	if (new_below)
@@ -3145,7 +3145,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vm_flags_set(vma, VM_SOFTDIRTY);
 		vma_iter_store(vmi, vma);
 
-		vma_complete(&vp, vmi, mm);
+		vma_complete(&vp, vmi);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.25.1


