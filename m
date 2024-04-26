Return-Path: <linux-kernel+bounces-160181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B050C8B3A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F3C1F24874
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67056149004;
	Fri, 26 Apr 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H3Kru3bJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C7148FE5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142718; cv=none; b=uL/zAO46Yl9CJEXNBCIoah846j842c8rokvGjQz6OyBFrS5n16XzvricGs/boOH7OkhmuyXKos6qBb0oSB0YShcwtBGx740+LNZlPwQEObXcccPMJgbmq+gZZzkubsgExU7lvWg7eg+UhezpASoG9rmNs+MTSY6Kzx3uhqQDoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142718; c=relaxed/simple;
	bh=lHKjkiMlqqnTSGXO+YOarVat3czks6kIXJgqZkv33Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhYRlejenwUoWXU0cxZhjuzfhxqYzbQh16py0ZPoI7RE1qAV2cMpJ8cJsMU1RMwjjpFNTBmJm4BsfLmu9bONTovwu77p8lN7LPrnMgQNxHAOrBgDnbFc78vPG3he/7bhYZ9nn5336wB3ah9IeBozHkP6T5XV0afawPgQqoPR0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H3Kru3bJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ahgxolPjR35rGtX1/SJWQbu72Aplypg3iRuwgc7l0ko=; b=H3Kru3bJevR/UbQEi+rQZVHYBs
	4jZpcvre5O2AGbp8OOvPMiDJkyyXKYEwehrbAEXn46zMrJ7KBuWpFNQeP5GvM2ym4Znpe2rFHtJGY
	msYEmfK9UvuayFULCI8kk6G7LUB6YPrB2Zx+N03fvRhfkOQQbI+vtr45609Tt2Kwn6FJlK1MeXJxS
	WMcWkh72E4cJosWiQFX1pYa+1vdoenBQAajpeUfrFZWmbzAJ9JWV2hofQM8juXYox4jLlGGaod9A5
	tg72zpBJGzqFbzLuE2zjQPW+GvalGrwtimdgo9buMc+VIRx3vHv5q3cPTlFfAlqho5X7/s/abOeuJ
	CWaJ58PA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mp2-00000005Pl4-1Nds;
	Fri, 26 Apr 2024 14:45:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 3/4] mm: Fix some minor per-VMA lock issues in userfaultfd
Date: Fri, 26 Apr 2024 15:45:02 +0100
Message-ID: <20240426144506.1290619-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426144506.1290619-1-willy@infradead.org>
References: <20240426144506.1290619-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename lock_vma() to uffd_lock_vma() because it really is uffd specific.
Remove comment referencing unlock_vma() which doesn't exist.
Fix the comment about lock_vma_under_rcu() which I just made incorrect.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/userfaultfd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e6486923263c..defa5109cc62 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -56,17 +56,16 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
 
 #ifdef CONFIG_PER_VMA_LOCK
 /*
- * lock_vma() - Lookup and lock vma corresponding to @address.
+ * uffd_lock_vma() - Lookup and lock vma corresponding to @address.
  * @mm: mm to search vma in.
  * @address: address that the vma should contain.
  *
- * Should be called without holding mmap_lock. vma should be unlocked after use
- * with unlock_vma().
+ * Should be called without holding mmap_lock.
  *
  * Return: A locked vma containing @address, -ENOENT if no vma is found, or
  * -ENOMEM if anon_vma couldn't be allocated.
  */
-static struct vm_area_struct *lock_vma(struct mm_struct *mm,
+static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 				       unsigned long address)
 {
 	struct vm_area_struct *vma;
@@ -74,9 +73,8 @@ static struct vm_area_struct *lock_vma(struct mm_struct *mm,
 	vma = lock_vma_under_rcu(mm, address);
 	if (vma) {
 		/*
-		 * lock_vma_under_rcu() only checks anon_vma for private
-		 * anonymous mappings. But we need to ensure it is assigned in
-		 * private file-backed vmas as well.
+		 * We know we're going to need to use anon_vma, so check
+		 * that early.
 		 */
 		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
 			vma_end_read(vma);
@@ -107,7 +105,7 @@ static struct vm_area_struct *uffd_mfill_lock(struct mm_struct *dst_mm,
 {
 	struct vm_area_struct *dst_vma;
 
-	dst_vma = lock_vma(dst_mm, dst_start);
+	dst_vma = uffd_lock_vma(dst_mm, dst_start);
 	if (IS_ERR(dst_vma) || validate_dst_vma(dst_vma, dst_start + len))
 		return dst_vma;
 
@@ -1436,7 +1434,7 @@ static int uffd_move_lock(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int err;
 
-	vma = lock_vma(mm, dst_start);
+	vma = uffd_lock_vma(mm, dst_start);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
@@ -1451,7 +1449,7 @@ static int uffd_move_lock(struct mm_struct *mm,
 	}
 
 	/*
-	 * Using lock_vma() to get src_vma can lead to following deadlock:
+	 * Using uffd_lock_vma() to get src_vma can lead to following deadlock:
 	 *
 	 * Thread1				Thread2
 	 * -------				-------
@@ -1473,7 +1471,7 @@ static int uffd_move_lock(struct mm_struct *mm,
 	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
 	if (!err) {
 		/*
-		 * See comment in lock_vma() as to why not using
+		 * See comment in uffd_lock_vma() as to why not using
 		 * vma_start_read() here.
 		 */
 		down_read(&(*dst_vmap)->vm_lock->lock);
-- 
2.43.0


