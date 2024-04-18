Return-Path: <linux-kernel+bounces-149936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563F8A9807
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C8282619
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D915E5B8;
	Thu, 18 Apr 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJVD+lj6"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03215E1EE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437920; cv=none; b=grhjgI5SRdUSdy7QUzIth+IXO9NKKtf1YDaGaBLShPTV5Mjq3a8cDzLQjaLVe6XybITBgNHECk/kZtOub7xKTXixnKXoiOpMwdEP1cTQpPZP+HZQ5W88lNxsdlrQNcZnw7VZumPxiwHgj2Yjev9kA/lECVavCy34oRvKA4CUQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437920; c=relaxed/simple;
	bh=sTz2Pp+8IsOE9Kkx3okka4q7c48jbMNCvkE4Ama0VsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtZs3R1j016B6E1LOuqwWo9FTAbQHaWaGwfR4ttIPDa/H3PLkNf1Sdfys8U/cqm2qzUOsbbZ81Bktkp1NBg246gbdu8uiV3rXyGjTSwiXn9iUcpDLErg637vuXAnX1IXkM4r8u1su+PWAl1mGBT8alvrBA36QzjDgIpD9RZcljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJVD+lj6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb7b6f92d4so399765a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437918; x=1714042718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8NkjRR32gwNlYRbH1lR13f1NodvtqYs34036pu1WAk=;
        b=DJVD+lj6ImNBfYh/lYYYyLYPclb5AK7Rzbsmw6VY2ulQhtIDA9IfTRy2RpyqKL0SBO
         qRU91vH1DlSVfi5hfbJXrnHjcZc6+or7O5Fwi64p+cgMWY5xNd7WJyOwtnoBVZdDk9lm
         LIbhs738qNwyQq+Fq4Oi87S7YFB7VlEXPfUD29I8PFelYZlm6UOLE9mRQd9srYuA12FA
         0Bc6Ssfg1+S3wr6IYWtOqdTdm7fcgGx17wq9kKPCQMJMJVt7o+VmW0VlgQh6xLR1WADF
         yadhC1nOq3FFc8jYjpF5GfTFSXrgrVEtJCLDMoF1VcFI3kmNhiCeVJLcSPJFPQel3rLu
         uYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437918; x=1714042718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8NkjRR32gwNlYRbH1lR13f1NodvtqYs34036pu1WAk=;
        b=Bs34sF7i8zut+OKXmcE+x96xqhcLU/zRvKAgFUDimhFwOpcbiW76DcktstWpKwcRdn
         rwqS2wrF9An54/5ZX9Frltmy+iGRxNbALQIoIrlSZMBBnVZsGFq/b+VJxcYKeeIyqk4g
         hs6Qa+bNy8YYhFIYhB7EuZZXHF7y58HdbvsfD5c61DMtx+5WZ0p6o2iDKmrE9XpTTWvD
         IDhDzD2ljLbVVxOKmnem2RmT4ESHdnvSWa4aF9QhL42ji4EEcWaD7yc/a+32wHIsV76K
         spV0F0HMQo+QN3cgcSP+6UtZawutK5QNpoma+RPfrKEb8AlO1FIlNQSBsq8oh5OCE26w
         AEdw==
X-Forwarded-Encrypted: i=1; AJvYcCU8tmYT/eucuRKzbP5A9Y+RdIJ6Tynv/Rm3RFgS9skaNcW72DMy9bykGZ+pR8cO73juHdM8cUHivDwfhxCfTcNvwMj2QlNQT8HXopF+
X-Gm-Message-State: AOJu0Yylt8vhj9uSuoGMVei3qSSVGoBoDfztI3spEGj2Gd2G/woAkR0V
	3++O0g3O8uNfzaYO4Nd2H3vLw4cG2rjKpamSssUcy0j16MXGBItA
X-Google-Smtp-Source: AGHT+IE0Wend3e5EpVQTSC9tsdUxn2WDCsJjwIeBC6hJ6WUDqPXTIzMmKsKYHmthb5COY6jTF/NdRg==
X-Received: by 2002:a05:6870:7096:b0:22e:dfbc:4d9d with SMTP id v22-20020a056870709600b0022edfbc4d9dmr2903143oae.1.1713437917381;
        Thu, 18 Apr 2024 03:58:37 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id gd26-20020a056a00831a00b006ea923678a6sm1200487pfb.137.2024.04.18.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:58:37 -0700 (PDT)
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
Subject: [PATCH v9 4/4] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
Date: Thu, 18 Apr 2024 18:57:50 +0800
Message-Id: <20240418105750.98866-5-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240418105750.98866-1-ioworker0@gmail.com>
References: <20240418105750.98866-1-ioworker0@gmail.com>
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
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/madvise.c | 85 +++++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4597a3568e7e..375ab3234603 100644
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
+						     ptent, &any_young, NULL);
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
+				start_pte = pte =
+					pte_offset_map_lock(mm, pmd, addr, &ptl);
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


