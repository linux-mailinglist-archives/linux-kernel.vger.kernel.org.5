Return-Path: <linux-kernel+bounces-150195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61688A9B89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5033F1F21EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A4165FB3;
	Thu, 18 Apr 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmyBFRgo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AA161900
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447901; cv=none; b=Qcz+EaoMlfdcmXZUjzpZn46IAajPyCyfmZAbvs0Mey+BRzT7Qyjp6NET5B90WCi6zGPJtchqBAMpvXRkhmypbdPoU5gG1lEeJeoCs6LRxqpW0a+v/hSBD2LXNt7jWWpk3e/v1PMlrbKCHjydHw10TMJgcVdVpRKDx10u+ads3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447901; c=relaxed/simple;
	bh=zeLCQtAMPyhlZ+GIepcWKCZyjf329mCJRgPJQfRGg8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmCkGfr81zoh59GvRU7+lKIUyUcwTh20oCmFvIGTrlAYFxeVC7jolbauU+SHvv9gOMxUDlyuzzcu4TOrh5PgFXM2siOVIGaUNVbvp4NEKAYzCDQ/saqfRZdbgquxeXaWD3Y7sru0lLih9b6Sm5EBQBmKOHAMslngl2jdZyDbNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmyBFRgo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4266673bbso8193155ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447899; x=1714052699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgQ7Fv4qoOj50C93E985pB5vnNpjpXSugVdGk65lNOA=;
        b=CmyBFRgoyjSLjVBf2N/JmOGZNfIJhGolbU79rJ15FrkFB8dExT3DuWoCAHZQ0nbLii
         scK2C7FvhghrDBoh79iMsX94RB28oYIZqreh+913GQUHEimQ51AVu4q0ghkQy4vcMvi9
         aQkfOJUVmFl4HNEHZcmeI0Rqy8JN7BjPIOCvO+FMqMBmtbNVxkNVdisb/gxV5DLExe5g
         1yeVf4hvu8+Y91QNfIkQrctnj9hW7v5x/GhcOyOmU1ytn6lVasBIOkJWWB3VDPI61lKQ
         uPiJVn591s3HjcMSTXM0nYNA1n08HrvhY5o7wCtcWP2pP6F4w/vTTLdMwtsZfOrKzhkd
         JHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447899; x=1714052699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgQ7Fv4qoOj50C93E985pB5vnNpjpXSugVdGk65lNOA=;
        b=MLRMi6hll+FeOZTtsYYQql9JgELLqcl37ubrfvvvoUpr+N5uSKx3axVlEEYqD5n71t
         b9c5L1DMbXtNaDwmLCrSAYnHuyse9sGgHK08U3HyxEHRoucl6F+/4d/nU7ZpXXGq0+Yg
         hKoxfei91q8WFitXJNJcnImhG3n5WaTz7CTs+wr5GyjtXhyVCnXHRptENULq3k0SpFqt
         X9mvcBAs6VbQQUdJSw6K3gZ17uFshL17HlQM1Dof4BjKTcZzKChXuhOxrz2RPYHj86cs
         L3Hd80Sjjr+vrgnDczidxkKGK8lSh2wrkj9/pNah5Q/dQ/04L13TGuIOXYJgDpeZeRx4
         LScA==
X-Forwarded-Encrypted: i=1; AJvYcCVYy1JHdYa4RIBZy/uKn2z9RcxRARrIvpxziyWDBauR4Nz03Twgzc6bQTRIGosKHrBwb0iXfOhq/Qke+vsNLvuEUXkOKzTW1l17KLg9
X-Gm-Message-State: AOJu0Yw/zblmyRe1ESiQbSTAqoqwSslrp0IvcTUtnKeWAXMsmpNMY5/r
	q3I8KqirxsIB/N3MqWWJaa3GwfFUdZ92wY8CTXkWZ9heZJwzt0PJSteKr2Nx
X-Google-Smtp-Source: AGHT+IGGqaeZJIZi8LM0BZvZXjbrMIOv72J2g3c12uT7zMGxJh9Xc/5vCUs+3eTCkX6ArwbYFFIuZA==
X-Received: by 2002:a17:902:c20d:b0:1de:f91:3cf3 with SMTP id 13-20020a170902c20d00b001de0f913cf3mr2714045pll.55.1713447899052;
        Thu, 18 Apr 2024 06:44:59 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902b70800b001e4fdcf67desm1504837pls.299.2024.04.18.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:44:58 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v10 4/4] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
Date: Thu, 18 Apr 2024 21:44:35 +0800
Message-Id: <20240418134435.6092-5-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240418134435.6092-1-ioworker0@gmail.com>
References: <20240418134435.6092-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
(Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
splitting if the large folio is fully mapped within the target range.

If a large folio is locked or shared, or if we fail to split it, we just
leave it in place and advance to the next PTE in the range. But note that
the behavior is changed; previously, any failure of this sort would cause
the entire operation to give up. As large folios become more common,
sticking to the old way could result in wasted opportunities.

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
the same size results in the following runtimes for madvise(MADV_FREE) in
seconds (shorter is better):

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
[2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/madvise.c | 85 +++++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4597a3568e7e..ed125ad8a21e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -643,6 +643,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 
 {
+	const cydp_t cydp_flags = CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY;
 	struct mmu_gather *tlb = walk->private;
 	struct mm_struct *mm = tlb->mm;
 	struct vm_area_struct *vma = walk->vma;
@@ -697,44 +698,57 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 
 		/*
-		 * If pmd isn't transhuge but the folio is large and
-		 * is owned by only this process, split it and
-		 * deactivate all pages.
+		 * If we encounter a large folio, only split it if it is not
+		 * fully mapped within the range we are operating on. Otherwise
+		 * leave it as is so that it can be marked as lazyfree. If we
+		 * fail to split a folio, leave it in place and advance to the
+		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			int err;
+			bool any_young, any_dirty;
 
-			if (folio_likely_mapped_shared(folio))
-				break;
-			if (!folio_trylock(folio))
-				break;
-			folio_get(folio);
-			arch_leave_lazy_mmu_mode();
-			pte_unmap_unlock(start_pte, ptl);
-			start_pte = NULL;
-			err = split_folio(folio);
-			folio_unlock(folio);
-			folio_put(folio);
-			if (err)
-				break;
-			start_pte = pte =
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-			if (!start_pte)
-				break;
-			arch_enter_lazy_mmu_mode();
-			pte--;
-			addr -= PAGE_SIZE;
-			continue;
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, &any_dirty);
+
+			if (nr < folio_nr_pages(folio)) {
+				int err;
+
+				if (folio_likely_mapped_shared(folio))
+					continue;
+				if (!folio_trylock(folio))
+					continue;
+				folio_get(folio);
+				arch_leave_lazy_mmu_mode();
+				pte_unmap_unlock(start_pte, ptl);
+				start_pte = NULL;
+				err = split_folio(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+				pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+				start_pte = pte;
+				if (!start_pte)
+					break;
+				arch_enter_lazy_mmu_mode();
+				if (!err)
+					nr = 0;
+				continue;
+			}
+
+			if (any_young)
+				ptent = pte_mkyoung(ptent);
+			if (any_dirty)
+				ptent = pte_mkdirty(ptent);
 		}
 
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
 			/*
-			 * If folio is shared with others, we mustn't clear
-			 * the folio's dirty flag.
+			 * If we have a large folio at this point, we know it is
+			 * fully mapped so if its mapcount is the same as its
+			 * number of pages, it must be exclusive.
 			 */
-			if (folio_mapcount(folio) != 1) {
+			if (folio_mapcount(folio) != folio_nr_pages(folio)) {
 				folio_unlock(folio);
 				continue;
 			}
@@ -750,19 +764,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pte_young(ptent) || pte_dirty(ptent)) {
-			/*
-			 * Some of architecture(ex, PPC) don't update TLB
-			 * with set_pte_at and tlb_remove_tlb_entry so for
-			 * the portability, remap the pte with old|clean
-			 * after pte clearing.
-			 */
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-
-			ptent = pte_mkold(ptent);
-			ptent = pte_mkclean(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
+			clear_young_dirty_ptes(vma, addr, pte, nr, cydp_flags);
+			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 		folio_mark_lazyfree(folio);
 	}
-- 
2.33.1


