Return-Path: <linux-kernel+bounces-102084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9487AE42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F841F2A58D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A4160872;
	Wed, 13 Mar 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knQ/BFSi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611858AA4;
	Wed, 13 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348467; cv=none; b=m64xEibxge5ubGcxxml3e9G8VNHPVO5adKYJTR+7PzEC3bHmMoKIryP5A/ELCELVgeAtuFUqhzarFv9tgQokpdLTHaPNUkcSMzb7ewK5ifacfGG097iVrq/MtHG0seKTTykrzfR00HynFazCxKvcJmo5qd4sXuF+/ZwbRZ4Jml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348467; c=relaxed/simple;
	bh=8DrZe4V/PmgJG0xFr0P5OAc30m8lwJITKLM3iheY4xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2sZn+VN1BlNYPbp3otKfW17PtmsMJX7VyHoBLmmbR1CX7VLJVFM3qulydkyXqOTTEoHGMYiftAQPpQOQMq8kBmmFM30gvDMdquQTdWIsb3CN6lkRvyVXhCIx5in7sZQKNchqIZpXNMDhBoVJHqq1hA2xrB0WI6GuD/rZXBPz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knQ/BFSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61523C433C7;
	Wed, 13 Mar 2024 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348467;
	bh=8DrZe4V/PmgJG0xFr0P5OAc30m8lwJITKLM3iheY4xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knQ/BFSiQji/VgVw44LELxq/pIZNRZep1ZtIBJx1moVHLjc6BaIEuszQuj0NuVswj
	 n0TibKt+i8phOi4ANqW1y+fUyt4m0zJ6erpTnGURUW1md4HGlTYIoDi6xPZslpgfy3
	 xZ+xWCpd7PuLca/ZOWHDOy8a8fGWst/8yT8K9PVuF4n2liCOWWje07CFVFtogMr15T
	 UCeT7uWzuHQlxUQKtVO1fyYtnX7Jw99AIlDEF4E1njUfxW20nVhbm0GQUqmEnXBbFg
	 FmQaTedKWsDwhrA4R7xGtH4osizcjhDUlKQONR7ciLIkfyGgO+yWdpCXWRaTWItatu
	 kUzXr9AlaN/Xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 58/73] mm/hugetlb: change hugetlb_reserve_pages() to type bool
Date: Wed, 13 Mar 2024 12:46:25 -0400
Message-ID: <20240313164640.616049-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mike Kravetz <mike.kravetz@oracle.com>

[ Upstream commit 33b8f84a4ee78491a8f4f9e4c5520c9da4a10983 ]

While reviewing a bug in hugetlb_reserve_pages, it was noticed that all
callers ignore the return value.  Any failure is considered an ENOMEM
error by the callers.

Change the function to be of type bool.  The function will return true if
the reservation was successful, false otherwise.  Callers currently assume
a zero return code indicates success.  Change the callers to look for true
to indicate success.  No functional change, only code cleanup.

Link: https://lkml.kernel.org/r/20201221192542.15732-1-mike.kravetz@oracle.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: e656c7a9e596 ("mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c    |  4 ++--
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 37 ++++++++++++++-----------------------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a0edd4b8fa189..c3e9fa7ce75f7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -176,7 +176,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	if (hugetlb_reserve_pages(inode,
+	if (!hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
 				vma->vm_flags))
@@ -1500,7 +1500,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	inode->i_size = size;
 	clear_nlink(inode);
 
-	if (hugetlb_reserve_pages(inode, 0,
+	if (!hugetlb_reserve_pages(inode, 0,
 			size >> huge_page_shift(hstate_inode(inode)), NULL,
 			acctflag))
 		file = ERR_PTR(-ENOMEM);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 99b73fc4a8246..90c66b9458c31 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -140,7 +140,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				struct page **pagep);
-int hugetlb_reserve_pages(struct inode *inode, long from, long to,
+bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81949f6d29af5..02b7c8f9b0e87 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5108,12 +5108,13 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	return pages << h->order;
 }
 
-int hugetlb_reserve_pages(struct inode *inode,
+/* Return true if reservation was successful, false otherwise.  */
+bool hugetlb_reserve_pages(struct inode *inode,
 					long from, long to,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long ret, chg, add = -1;
+	long chg, add = -1;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
@@ -5123,7 +5124,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	/* This should never happen */
 	if (from > to) {
 		VM_WARN(1, "%s called with a negative range\n", __func__);
-		return -EINVAL;
+		return false;
 	}
 
 	/*
@@ -5132,7 +5133,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * without using reserves
 	 */
 	if (vm_flags & VM_NORESERVE)
-		return 0;
+		return true;
 
 	/*
 	 * Shared mappings base their reservation on the number of pages that
@@ -5154,7 +5155,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
-			return -ENOMEM;
+			return false;
 
 		chg = to - from;
 
@@ -5162,18 +5163,12 @@ int hugetlb_reserve_pages(struct inode *inode,
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
 
-	if (chg < 0) {
-		ret = chg;
+	if (chg < 0)
 		goto out_err;
-	}
-
-	ret = hugetlb_cgroup_charge_cgroup_rsvd(
-		hstate_index(h), chg * pages_per_huge_page(h), &h_cg);
 
-	if (ret < 0) {
-		ret = -ENOMEM;
+	if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
+				chg * pages_per_huge_page(h), &h_cg) < 0)
 		goto out_err;
-	}
 
 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
@@ -5188,19 +5183,15 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * reservations already in place (gbl_reserve).
 	 */
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0) {
-		ret = -ENOSPC;
+	if (gbl_reserve < 0)
 		goto out_uncharge_cgroup;
-	}
 
 	/*
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	ret = hugetlb_acct_memory(h, gbl_reserve);
-	if (ret < 0) {
+	if (hugetlb_acct_memory(h, gbl_reserve) < 0)
 		goto out_put_pages;
-	}
 
 	/*
 	 * Account for the reservations made. Shared mappings record regions
@@ -5218,7 +5209,6 @@ int hugetlb_reserve_pages(struct inode *inode,
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
-			ret = add;
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
@@ -5251,7 +5241,8 @@ int hugetlb_reserve_pages(struct inode *inode,
 			hugetlb_cgroup_put_rsvd_cgroup(h_cg);
 		}
 	}
-	return 0;
+	return true;
+
 out_put_pages:
 	/* put back original number of pages, chg */
 	(void)hugepage_subpool_put_pages(spool, chg);
@@ -5267,7 +5258,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 			region_abort(resv_map, from, to, regions_needed);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
-	return ret;
+	return false;
 }
 
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
-- 
2.43.0


