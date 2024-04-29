Return-Path: <linux-kernel+bounces-162358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0648B59C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E431C22E52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026A6D1D8;
	Mon, 29 Apr 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Lpw2Pi"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066470CCC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397008; cv=none; b=q7Uxqej+XIS4zuhZIZ6gr7fJdjisATwBn96LHrDs5U6oYKAKn6EoVRHwNFEWuDLma5qsxI2T2u8ppbVuH7u0MdkGaQtOO0KIltfh2fioBzcEiwzcxYX6x8OnNIDxZSPBvZ5DpUt253pr4YaYtIX5va8JJiRjWarf+3Z/vZsmUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397008; c=relaxed/simple;
	bh=gWXuoid7dRKeMQUZwz4YAEAXa4JIxXi9Uf3wRsrmHxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KRsvQXufJttqG3YhmyNOw1QNzPH3bQh/qGMbNB0kQAN+zPXbrkTfotNAaKM/OX0EWrnjP3YBj4HaB0TgpTMNhqC1joJcLJl1EzT5i8iL0KFCEE7fiEBhidaWB628//VQ+p/chLPUwq/pgC1AdYMAYQMmbNzPEuG0ibxtl6zf0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2Lpw2Pi; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2b24dbd1bb6so79934a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397006; x=1715001806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxwHmPfQRT1njG/0ZnhsAAHKQR4nWB4DSExpUtfTagU=;
        b=h2Lpw2PiT5UpEzuG7t1hnR98QLhfFn2Sz/npjfedXI6EYi3WBH3+1Cmmm45dKsLBP0
         HV83WPBLBOzt7OwXK+N8eEUUGowLpjAf4/1OgBN4bWklH3YPKYdWC8WUsrxZSGjiLijS
         kOiUBF7vfBziiSK5xia9Otcj0sXvTViIQnxGiOQHzwao9uLf2zPpuXxwYqaLddTCG3O9
         l8bV5P920x9QJJ1RMAz2qpcYoYE9qmv4tsSVgbwFRGdRTa9aNEZ5GZ2TYmCZzgESNK3Y
         pF7l+3/f6nK5yOKopD7ZlZhf+h/2g8cWcn+kprK8fghJtoZ98iTTv57Gws7/Gq7Dx5CB
         UVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397006; x=1715001806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxwHmPfQRT1njG/0ZnhsAAHKQR4nWB4DSExpUtfTagU=;
        b=ueAzn+n9y/CkcJauqanjOi2qOZS4Lvo9FHurXQjstvnFn+jtjgNba6Jvn5w52RGXZ2
         VrwEY4Z8lzD6Ge5MamCRt+X+QtE9bSTxTJdsWxJXg9TNjqnSz7lZGDWkdq9lnTfNak5x
         lSnjC26QblYS59dlcN5hjGD91Jfvb1u+EF9rV9KNG54+kG2aa87T9MqHMNgpT6YfcSHI
         pQaC05b9rrT8h3eiG1GmFZkBqjHB/z72xq7HyOIu4wkBvLQPaeygnbGx7802BpEv+XJp
         nYVAdmM8KGUh5aNHQi7B5TpWqARSWRPjwUAuonct+cekTh+Iih096+DE6d2esMNSkOc/
         bvtw==
X-Forwarded-Encrypted: i=1; AJvYcCX+5rHfQL7Ux36HrAc2fcJu5WwoOhfMAev+WeEggUyfahNmYwxJK4O/JR9pYlpFWfdVI6j6TV2S5owopm0Z+cnN1vpWLTVRSchkgFwm
X-Gm-Message-State: AOJu0Yy4qAxyn/PX6nBNgQGh2qxaUR5tB1VC29pWgaiTOKTHIbOP8w4v
	0g+bMO4Eu65kgSRZ06lz3f0HAEBzxil7G1w1Q41HNFTPMdo4/YZP
X-Google-Smtp-Source: AGHT+IEjqfs5Wj6xWELIlAmQgTGzpvdNiim5oTC1EPJpMg+Rn05wl3rsER6UCjgEzuJmeCUHtgU2DQ==
X-Received: by 2002:a17:90b:696:b0:2b1:55b1:a58c with SMTP id m22-20020a17090b069600b002b155b1a58cmr4231189pjz.35.1714397005964;
        Mon, 29 Apr 2024 06:23:25 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b002b113ad5f10sm3562203pjb.12.2024.04.29.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:23:25 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
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
Subject: [PATCH v3 1/3] mm/rmap: remove duplicated exit code in pagewalk loop
Date: Mon, 29 Apr 2024 21:23:06 +0800
Message-Id: <20240429132308.38794-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240429132308.38794-1-ioworker0@gmail.com>
References: <20240429132308.38794-1-ioworker0@gmail.com>
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


