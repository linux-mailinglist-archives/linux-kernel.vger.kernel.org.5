Return-Path: <linux-kernel+bounces-94999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467388747F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996E2B21595
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E51BF2B;
	Thu,  7 Mar 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GobN0NAI"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916784A22
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792111; cv=none; b=qW/p98JtsDc1ReCsfm+gB0hEM9AqODQPykLHMaBulk+cS7/DIRbTaTXS+dMbvmzpMtKA0h3Zukg3CYcZ+Trz6H0pKriH5IGHcfpb9ZDKztVl6+sgI24g9XKqXK99yrWMw3tkGgl2Jx8XFBVRjCGhF/nbQkOgi3SioqIIeRd/KJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792111; c=relaxed/simple;
	bh=h4DPsSIsmTCgY51zCGEoR0InFOetApY2cAaMMyy7e4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GvGGbnfT6o5T/UP0166Axaq5Cw58eeRy+BIkb0a9TgN+DqqSxXV9fE7N4eLHyJsXuuieK2Mz8d1QI0rx9bXxJFvZNKUF7N8ApcpyN7EteCD7NPAZqMfpmYQymCAks0x46JGJT2CG36iwJh9TXu/KdtApQthf8sAOcQEIrqlShg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GobN0NAI; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22002fbbd6bso201979fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 22:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709792108; x=1710396908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apnvVQ9ZLn9mh7pAifg1wFyh1DXFnDGYwcPOcBe2Rnk=;
        b=GobN0NAIYmc/WTA7I1a0Id15JyJ/LWko5h4a8b4iXmkHOuCFz6lpzKQsXBUtfxHxEI
         1m+Y4t66Zz5kfIzzEUuS3RGRQqg9Rl2cQR/gH4nS7acBV2UhaRnLg/bSfsf5LvtKJi93
         ITLvV7B1nmXKr/FtBFJ0y+dyN7MoKyHVux0MmnSgiVUBbesdRHa9XhzsyoPyvoSCyq5A
         4FyqAwwa2/wIUn6SzOeCkCDMzdk1MuDuEWnpRhtwWTZSXhTkq18qLC3xSsEdGRJtkKCS
         wpr1B7heRQHMrjugcnCtK/cxKYu/PSsrIVKw+MxWnUjg0V9FWrE5G7i/xsvr18VXX4fg
         BrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792108; x=1710396908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apnvVQ9ZLn9mh7pAifg1wFyh1DXFnDGYwcPOcBe2Rnk=;
        b=PL2KCSoQJ31IIgDoWcfIe7XOdqr101epFjcGiJIa6zEurKKT8sE8DE/8VdNfgweh6X
         RRnKq0duWOuK8nerUWO4MQmgTa0l/6BJiS6LSAC78/FgTp9Elk+rVBOQcAwwZ08FaFon
         Yn6jkUEdOatWKrFKYEKZlme1b4r79iSeNn3L23c6eTY+s0oPGvfolcL0bhWK1h1jFkvq
         YtPOFcMq7G1k8oJjiQBjNApjNrmU2FOB4ciy6Sb2qtFT6694Um8f49/XM41WabHAJFmK
         5O+sPKy9iueEUT+3MsBfOgLcO3x/XgePROH80Fggzj4Tu3/GZbUzpOUXLJOiuosBSsfY
         yvow==
X-Forwarded-Encrypted: i=1; AJvYcCXhqpi6PsrTYGLx/CdPQ9PFaT8pG3FYzAuZSkWWfAxpsd1b3+pMuaFWmHKJKa+8w+4IzZJzXoq2XIDt9aFriBN3ai9ie/Iqu0QpofLq
X-Gm-Message-State: AOJu0YwuG1PcJ67RN2QA7ab2GpfS2Ch+gyuhkubrWf6L/kjlxjtba6UD
	mM3rsYTJ24GkMXqsAp3Jr/eZLy8T6l+eOydomLpoqZt0TNQKf8IA
X-Google-Smtp-Source: AGHT+IFpqYcCVD06nSocbIa942aoVM34TabPzLpB/cqqsBVgaflu1XDDQKrpu6qKFqgKazF+zK4Dkg==
X-Received: by 2002:a05:6870:f152:b0:221:141:1f00 with SMTP id l18-20020a056870f15200b0022101411f00mr7981768oac.44.1709792108557;
        Wed, 06 Mar 2024 22:15:08 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.240.9])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b006e64a9104fdsm2546938pfb.114.2024.03.06.22.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 22:15:08 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	shy828301@gmail.com,
	david@redhat.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Thu,  7 Mar 2024 14:14:25 +0800
Message-Id: <20240307061425.21013-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
(Inspired by David Hildenbrand[2]). We aim to avoid unnecessary
folio splitting if the large folio is entirely within the given
range.

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
PTE-mapped folios of the same size results in the following
runtimes for madvise(MADV_FREE) in seconds (shorter is better):

Folio Size |   Old    |   New    | Change
------------------------------------------
      4KiB | 0.590251 | 0.590259 |    0%
     16KiB | 2.990447 | 0.185655 |  -94%
     32KiB | 2.547831 | 0.104870 |  -95%
     64KiB | 2.457796 | 0.052812 |  -97%
    128KiB | 2.281034 | 0.032777 |  -99%
    256KiB | 2.230387 | 0.017496 |  -99%
    512KiB | 2.189106 | 0.010781 |  -99%
   1024KiB | 2.183949 | 0.007753 |  -99%
   2048KiB | 0.002799 | 0.002804 |    0%

[1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
[2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com/

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
v1 -> v2:
 * Update the performance numbers
 * Update the changelog, suggested by Ryan Roberts
 * Check the COW folio, suggested by Yin Fengwei
 * Check if we are mapping all subpages, suggested by Barry Song,
 David Hildenbrand, Ryan Roberts
 * https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gmail.com/

 mm/madvise.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158..1437ac6eb25e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -616,6 +616,20 @@ static long madvise_pageout(struct vm_area_struct *vma,
 	return 0;
 }
 
+static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
+						 struct folio *folio, pte_t *start_pte)
+{
+	int nr_pages = folio_nr_pages(folio);
+	fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+
+	for (int i = 0; i < nr_pages; i++)
+		if (page_mapcount(folio_page(folio, i)) != 1)
+			return false;
+
+	return nr_pages == folio_pte_batch(folio, addr, start_pte,
+					 ptep_get(start_pte), nr_pages, flags, NULL);
+}
+
 static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
@@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 */
 		if (folio_test_large(folio)) {
 			int err;
+			unsigned long next_addr, align;
 
-			if (folio_estimated_sharers(folio) != 1)
-				break;
-			if (!folio_trylock(folio))
-				break;
+			if (folio_estimated_sharers(folio) != 1 ||
+			    !folio_trylock(folio))
+				goto skip_large_folio;
+
+			align = folio_nr_pages(folio) * PAGE_SIZE;
+			next_addr = ALIGN_DOWN(addr + align, align);
+
+			/*
+			 * If we mark only the subpages as lazyfree, or
+			 * cannot mark the entire large folio as lazyfree,
+			 * then just split it.
+			 */
+			if (next_addr > end || next_addr - addr != align ||
+			    !can_mark_large_folio_lazyfree(addr, folio, pte))
+				goto split_large_folio;
+
+			/*
+			 * Avoid unnecessary folio splitting if the large
+			 * folio is entirely within the given range.
+			 */
+			folio_clear_dirty(folio);
+			folio_unlock(folio);
+			for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
+				ptent = ptep_get(pte);
+				if (pte_young(ptent) || pte_dirty(ptent)) {
+					ptent = ptep_get_and_clear_full(
+						mm, addr, pte, tlb->fullmm);
+					ptent = pte_mkold(ptent);
+					ptent = pte_mkclean(ptent);
+					set_pte_at(mm, addr, pte, ptent);
+					tlb_remove_tlb_entry(tlb, pte, addr);
+				}
+			}
+			folio_mark_lazyfree(folio);
+			goto next_folio;
+
+split_large_folio:
 			folio_get(folio);
 			arch_leave_lazy_mmu_mode();
 			pte_unmap_unlock(start_pte, ptl);
@@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-			if (err)
-				break;
-			start_pte = pte =
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-			if (!start_pte)
-				break;
-			arch_enter_lazy_mmu_mode();
+
+			/*
+			 * If the large folio is locked or cannot be split,
+			 * we just skip it.
+			 */
+			if (err) {
+skip_large_folio:
+				if (next_addr >= end)
+					break;
+				pte += (next_addr - addr) / PAGE_SIZE;
+				addr = next_addr;
+			}
+
+			if (!start_pte) {
+				start_pte = pte = pte_offset_map_lock(
+					mm, pmd, addr, &ptl);
+				if (!start_pte)
+					break;
+				arch_enter_lazy_mmu_mode();
+			}
+
+next_folio:
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
-- 
2.33.1


