Return-Path: <linux-kernel+bounces-50814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D06847E41
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316C52823D2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD775567F;
	Sat,  3 Feb 2024 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p6EkLQZK"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4746A4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924819; cv=none; b=mp9M2UQZ/JCNK49Ih0bbdK2PJwy7ISsjm5S4KKu5w0GpahScZFAemtva0jBx15v2pTIw6pOB56aR6JhypqRMV8YxJ9cUvoPwX53VyDYsXjB+6dtpNCZL+3JspHlOp2l0r6jIGry/G2kdWcPO3KZwlLJykNEAml4bN/y4nnOCY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924819; c=relaxed/simple;
	bh=y0PZltIcM3KfU9KXXSkTCWDtDNbnTxYu5KdBQp9I7Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndgVgowZkqLiOFmRruKx7Wa0USgFCOJgxHuQu034kLpx00MgwF1ZeVP+wG1HDDZ0sNR0aNn5jZRhrhU13UB9I22vGGBYvkX3o5z8c1L6cHXHSmJOXvQz9ifAaQ9/hELVCGRVCaoh8xFUGbLWcPamAPw1FP/lxdHkZHuIbQptd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p6EkLQZK; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706924814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uQvZQX7CRf4lYHiNuYQqSkwD20GYoPXfurrH/TrfrDM=;
	b=p6EkLQZKrQJEwcsgDXE/fTmFVdRqB943qHykZbOyVKNKxwNukE2NC5ycHNeoh+pKu5DciD
	jCL1nM06SY/U4834ld1B8GqctQdCtx6eSxdVEpXPblqihAZISAe4MJdu4D7JWBjxfCn4aG
	zjyQ0wQ5bXKBGbnovzi/9l2nur7cCh4=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@Oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3] mm/mmap: pass vma to vma_merge()
Date: Sat,  3 Feb 2024 09:46:32 +0800
Message-Id: <20240203014632.2726545-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These vma_merge() callers will pass mm, anon_vma and file, they all from
the same vma. There is no need to pass three parameters at the same time.

Pass vma instead of mm, anon_vma and file to vma_merge(), so that it can
save two parameters.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: resend the first patch again alone.
v2: split it into two patches.
v1: https://lore.kernel.org/all/20240118082312.2801992-1-yajun.deng@linux.dev/
---
 mm/mmap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 485a6e1e4226..8f176027583c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -860,13 +860,15 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  *      area is returned, or the function will return NULL
  */
 static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
-	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
-	   pgoff_t pgoff, struct mempolicy *policy,
+*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
+	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
+	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
 	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
 	   struct anon_vma_name *anon_name)
 {
+	struct mm_struct *mm = src->vm_mm;
+	struct anon_vma *anon_vma = src->anon_vma;
+	struct file *file = src->vm_file;
 	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	struct vm_area_struct *anon_dup = NULL;
@@ -2426,9 +2428,8 @@ struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
 	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
 	struct vm_area_struct *merged;
 
-	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
-			   vma->anon_vma, vma->vm_file, pgoff, policy,
-			   uffd_ctx, anon_name);
+	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
+			   pgoff, policy, uffd_ctx, anon_name);
 	if (merged)
 		return merged;
 
@@ -2458,9 +2459,8 @@ static struct vm_area_struct
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
@@ -2474,10 +2474,9 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
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


