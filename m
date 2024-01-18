Return-Path: <linux-kernel+bounces-29889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3DE8314BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70501C2207D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB713AF8;
	Thu, 18 Jan 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SBJmTn8g"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6B125D3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566212; cv=none; b=qbb0F37vXUzmJ1ffBLmYwPr09KqmLQPTrySA0943c4SwzXoLp62+jSqEeK+yUqo10Cf8CiMe36WcT7a+PFpWIRL23JJ1qtdB/MZEAhgqLqxf6+6k0u1iSah3kO/7lUNjS2BPpUJoPQTmFWVPC8TssashPq6VDsSeLpSAp/xu5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566212; c=relaxed/simple;
	bh=C1hmTg2nY8yzj64atwww1ythwPSEs6LPcdpJP7PXbqw=;
	h=X-Report-Abuse:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:X-Migadu-Flow; b=lvq8xIWl17YDyvzX0m/xdOhZoWPGcU3Q945U6/+rsxnfgDGzNbqmJawMujlCaoMn1G6sQApR8DmAhhlyprb8vUc+B99JqdPoiht1cB0gEQ7vhON0kOYtRPnXTiDCMUldFgLqS+aQI2dp5Dstiq9XjwLeW146yh2er5Nu4RogShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SBJmTn8g; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705566207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pe8IQrETqG5sJ0hFhkc64W1l6+nAKA4aDlhTJnXDWtk=;
	b=SBJmTn8g80S8xKAdpZWPh/c8KSATg87T78tr6m5D14ECkBeTJqRCJfnqu63LsoU1CU2t5Z
	BaoXLQyzx9nI+IezmXxYukd1V73FEBZ7GsBUFrrd+FiExJjqTVjDwno93GRTNj7/WVhpRI
	nSv3+o86VTpwX8+wlHsxW+SIEqRopps=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mmap: simplify vma_merge()
Date: Thu, 18 Jan 2024 16:23:12 +0800
Message-Id: <20240118082312.2801992-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These vma_merge() callers will pass mm, anon_vma and file, they all from
vma. There is no need to pass three parameters at the same time.

We will find the current vma in vma_merge(). If we pass the original vma
to vma_merge(), the current vma is actually the original vma or NULL.
So we didn't need to find the current vma with find_vma_intersection().

Pass vma to vma_merge(), and add a check to make sure the current vma
is an existing vma.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mmap.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 49d25172eac8..7e00ae4f39e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -860,14 +860,16 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  *      area is returned, or the function will return NULL
  */
 static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
-	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
-	   pgoff_t pgoff, struct mempolicy *policy,
+*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
+	   struct vm_area_struct *curr, unsigned long addr, unsigned long end,
+	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
 	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 	   struct anon_vma_name *anon_name)
 {
-	struct vm_area_struct *curr, *next, *res;
+	struct mm_struct *mm = curr->vm_mm;
+	struct anon_vma *anon_vma = curr->anon_vma;
+	struct file *file = curr->vm_file;
+	struct vm_area_struct *next = NULL, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	struct vm_area_struct *anon_dup = NULL;
 	struct vma_prepare vp;
@@ -889,13 +891,12 @@ static struct vm_area_struct
 		return NULL;
 
 	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
+	if (prev == curr || addr != curr->vm_start || end > curr->vm_end)
+		curr = NULL;
 
 	if (!curr ||			/* cases 1 - 4 */
 	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vma_lookup(mm, end);
-	else
-		next = NULL;		/* case 5 */
+		next = vma_lookup(mm, end); /* NULL case 5 */
 
 	if (prev) {
 		vma_start = prev->vm_start;
@@ -919,7 +920,6 @@ static struct vm_area_struct
 
 	/* Verify some invariant that must be enforced by the caller. */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
 	if (!merge_prev && !merge_next)
@@ -2424,9 +2424,8 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	struct vm_area_struct *merged;
 
-	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
-			   vma->anon_vma, vma->vm_file, pgoff, policy,
-			   uffd_ctx, anon_name);
+	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
+			   pgoff, policy, uffd_ctx, anon_name);
 	if (merged)
 		return merged;
 
@@ -2456,9 +2455,8 @@ static struct vm_area_struct
 		   struct vm_area_struct *vma, unsigned long start,
 		   unsigned long end, pgoff_t pgoff)
 {
-	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
-			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
+			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
 /*
@@ -2472,10 +2470,9 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
 
 	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
-			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
-			 vma_policy(vma), vma->vm_userfaultfd_ctx,
-			 anon_vma_name(vma));
+	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
+			 vma->vm_flags, pgoff, vma_policy(vma),
+			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 }
 
 /*
-- 
2.25.1


