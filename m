Return-Path: <linux-kernel+bounces-162072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA38B5585
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299101C21A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1438382;
	Mon, 29 Apr 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="V9juz5Rx"
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83554E1BE;
	Mon, 29 Apr 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386971; cv=none; b=OY/AeFbaM4mUC1XqttBjvRkZi46D/xLwuuPFgtRtbnY3z4802xH7vn1SYaoveW9Ioq4NnpaG8Fhs9jsMu7sC5sphql6xPBqbVCQHxPWRXZwJiR/FByG+7AR8/ZI0zuu60juUkxRbyZ6H7iB8cZNFwXAatBiTQ2dcsc9xVknnt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386971; c=relaxed/simple;
	bh=VY9sZlLbdOohRHek7Or+cOx51HaBJ+7tOVXra2qD9VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ar68NBxp9A97f/Q6H772Xi5qj+yroP8ZAi+fx3I4Ha+bWHY2yrTJfnAU2BaBlnwOq1iPcbD5aQS+cBezoEY/TlHVCczJ3PQP3XSsmTioNowX8+r4fbS7o+unG6LfgTmcGDzIaFBdTZRZZ9+pDNipouGAKpdBoAcl03uDW/ZsnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=V9juz5Rx; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714386961; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MCByWayo1rTtWGbtdA4qwJOFgDYVs7q3tTYHIInGmHY=;
	b=V9juz5RxFGMGwrjlGxUh97IayTySsqHdx93GAsZJba2WhiS8GGBz02xt4XsuxTdbaQ9wKXc7rUzfor1j2xII6VQP6ynLRcRZTlCtX/ozvt3PeNKrm2W2FTXR2a1q32wbdkxfpqivwBtjHj2UacqHIdl2SS6tZ0M5i4ybLeSuRJI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.XOEanMm_1714386958;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XOEanMm_1714386958)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 18:35:59 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc:  <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <libang.linux@gmail.com>,
   <ioworker0@gmail.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <loongarch@lists.linux.dev>,
   <linux-mips@vger.kernel.org>,
   <linux-riscv@lists.infradead.org>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v1 5/5] mm: Add update_mmu_tlb_range()
Date: Mon, 29 Apr 2024 18:33:46 +0800
Message-Id: <20240429103346.59115-6-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240429103346.59115-1-libang.li@antgroup.com>
References: <20240429103346.59115-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
multi-size THP"), it may need to batch update tlb of an address range
through the update_mmu_tlb function. We can simplify this operation by
adding the update_mmu_tlb_range function, which may also reduce the
execution of some unnecessary code in some architectures.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 include/linux/pgtable.h | 5 +++++
 mm/memory.c             | 4 +---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..73411dfebf7a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -734,6 +734,11 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
 				unsigned long address, pte_t *ptep)
 {
 }
+
+static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
+				unsigned long address, pte_t *ptep, unsigned int nr)
+{
+}
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #endif
 
diff --git a/mm/memory.c b/mm/memory.c
index 6647685fd3c4..1f0ca362b82a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4396,7 +4396,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int nr_pages = 1;
 	pte_t entry;
-	int i;
 
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
@@ -4465,8 +4464,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		update_mmu_tlb(vma, addr, vmf->pte);
 		goto release;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		for (i = 0; i < nr_pages; i++)
-			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
+		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		goto release;
 	}
 
-- 
2.19.1.6.gb485710b


