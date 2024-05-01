Return-Path: <linux-kernel+bounces-164913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03B8B84D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF7FB224DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFD3FB1E;
	Wed,  1 May 2024 04:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6nA8Zz5"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF73F9C5
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537637; cv=none; b=uGkNmnxsnjDK1xa+osUcp9h/cJAbucs2z8Hk2s/7ippQxu5jQcMwjh1jv8yjqX4uAsppyP6SjvMhFPrp5aN9FZjxOAV/hEbTjJUP2xOeVPhq9d9EchvzJj/1vWS+fNduCs/FB+7yBz2+8O8wHU5UmudX9W8NT0CP5TwhhkmZivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537637; c=relaxed/simple;
	bh=gWXuoid7dRKeMQUZwz4YAEAXa4JIxXi9Uf3wRsrmHxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeUO/W04FmGiv1tsIo14hiquvEKwtKJn622hd+Kw3jqWeGPJB4hffXkgYKvmuJcnUB6YoD3q6HnsMdGXF6xBbZPQA57BpiTRAiXaiAyNyWs88rSLFkQyF+Fz0KCZP2dzySBxnz515cp4LH+PuMjgfjMmUnsvdG8HNIuZ7S6kE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6nA8Zz5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c70999ff96so3357601b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537635; x=1715142435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxwHmPfQRT1njG/0ZnhsAAHKQR4nWB4DSExpUtfTagU=;
        b=C6nA8Zz599momHHPwCc3iHD/zL+9GZcqMnTPEgIOmhK3IfhCpfHyWpbC/7Pg2z/lpL
         ymVCayPgM2/nKM6ANzbFfXuj/rLS9ZtXyL7oQZ1D3oMBni4DySZkQ/yHZvFjAhuZi27o
         T0z1H3syoKFI4cYXlNY8HEH2SnPu+cW0zDJYCkSMHoDLWHmdcMMn0vV3ZuRkpGSQ3Lvy
         SHRU5E3RBgrKWLb1VxNZr2HS9dYq9jbmS0c+5yn0hBqBq4jDc4e9wrdcgVWWn4aeOieq
         Cdm3V669FO0kjUQx3fCngT/xW26l5bYB6+1XSvFzYNLabX6TOMxdkv49G/gt9RwxaWw0
         2vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537635; x=1715142435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxwHmPfQRT1njG/0ZnhsAAHKQR4nWB4DSExpUtfTagU=;
        b=Lf0cy5c8h5NrfMVdd/r82CdZvliPlLV5YdtxOM8FrsOy44f6+WkQG9oy1joLyMc5xp
         LipDs9JHZy7p0Pv+Pre/RKfU/dUzyZ3a26W0/e/FNjTceeUwtHxvJRdMmQafBSM4Y1pE
         +XkP8syalgcDEJy38UlnxlVx2KJ/9NY32pSaPr1q92iCoF1E7/g5ErZg+JbznOO2ZCa8
         Cp1rxOmBlvJorMRWToaibOJ8QP4ZIwyr80uVCyiQhdBNaIuHRO5pcR6sRAt/dbfkdQut
         XtVP8Q+cWiB+idzxC+7+W/q/x1NNZtIdcvVUfy00sdBR6cbpsae9h1Q4NdaIj9PdG7aa
         1qgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkeKKxEY+VRHws6LX8VD0gXcM/8QSyx5pMfKEg17aXlyjxqo9MAmJ8y+etejsc7kQiiqYypnzpMC9UHX/VqDBY0jTAkAaBYvF4OLyb
X-Gm-Message-State: AOJu0YwD8mOCXGNMnn6Ox6ztWke0CMQ4b/LSG9d05vq0hach8Of03/wt
	hZjh1i+mjRGQlu+Tyjezo7R4lYZFcOWpZYInTVO4oJYCejxOgAtR
X-Google-Smtp-Source: AGHT+IEl+/L1ituyaJTnk0BjJi3vRmGfqMR+zcexC0PXTPj0xeHACJfp1bfVqYeei+6Mig3AUi1xRg==
X-Received: by 2002:a05:6808:1813:b0:3c9:147c:bd22 with SMTP id bh19-20020a056808181300b003c9147cbd22mr1266333oib.29.1714537635509;
        Tue, 30 Apr 2024 21:27:15 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b005dc4806ad7dsm19165970pgu.40.2024.04.30.21.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:27:15 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v4 1/3] mm/rmap: remove duplicated exit code in pagewalk loop
Date: Wed,  1 May 2024 12:26:58 +0800
Message-Id: <20240501042700.83974-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240501042700.83974-1-ioworker0@gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the labels walk_done and walk_done_err as exit points to
eliminate duplicated exit code in the pagewalk loop.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7faa60bc3e4d..7e2575d669a9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1675,9 +1675,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			/* Restore the mlock which got missed */
 			if (!folio_test_large(folio))
 				mlock_vma_folio(folio, vma);
-			page_vma_mapped_walk_done(&pvmw);
-			ret = false;
-			break;
+			goto walk_done_err;
 		}
 
 		pfn = pte_pfn(ptep_get(pvmw.pte));
@@ -1715,11 +1713,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (!anon) {
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-				if (!hugetlb_vma_trylock_write(vma)) {
-					page_vma_mapped_walk_done(&pvmw);
-					ret = false;
-					break;
-				}
+				if (!hugetlb_vma_trylock_write(vma))
+					goto walk_done_err;
 				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
 					hugetlb_vma_unlock_write(vma);
 					flush_tlb_range(vma,
@@ -1734,8 +1729,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					 * actual page and drop map count
 					 * to zero.
 					 */
-					page_vma_mapped_walk_done(&pvmw);
-					break;
+					goto walk_done;
 				}
 				hugetlb_vma_unlock_write(vma);
 			}
@@ -1807,9 +1801,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
 				WARN_ON_ONCE(1);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			/* MADV_FREE page check */
@@ -1848,23 +1840,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				folio_set_swapbacked(folio);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			if (swap_duplicate(entry) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			/* See folio_try_share_anon_rmap(): clear PTE first. */
@@ -1872,9 +1858,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			    folio_try_share_anon_rmap_pte(folio, subpage)) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 			if (list_empty(&mm->mmlist)) {
 				spin_lock(&mmlist_lock);
@@ -1914,6 +1898,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
+		continue;
+walk_done_err:
+		ret = false;
+walk_done:
+		page_vma_mapped_walk_done(&pvmw);
+		break;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.33.1


