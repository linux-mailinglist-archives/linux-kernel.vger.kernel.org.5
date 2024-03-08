Return-Path: <linux-kernel+bounces-96603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFF875ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524D7B20E47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C64F61C;
	Fri,  8 Mar 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ6sFcXp"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB54F217
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884183; cv=none; b=pQiXFGuDmPdo9JfP776CP/4wTuUFd7ppMKW0X5+gPuz1kPmrIn13MwbU2JwgildQFm4IOzfnYIzfdpeR8AukpU2hPJK1SjGWTX0VgdcUKp2rP3iKbTfEhkF/KiKwvyaI1fcK20Aaaa2bBqBuYTm0uEJ4NtXxKoN6gQvdlw84WnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884183; c=relaxed/simple;
	bh=wvkbzHuGNpZnqBWBUqIvoqcv4nKaMpz9UDRHz8mbrB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C9jjE+hkYcSPGFcUuDT1BKoGXWUjGkyTDv9mE1ELV5KUHnQhx6pm6oU/cf/KaOmKsoq5bJRTmeBNzBR1Qyc5V2k8dQncfIXEBtr9CaseSMY4hiD8JSfWZ5d48sw5xQb5VdZxbGP3coOy8j5b2cksOE1w2ZzxdKvkAx1DJiZGTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ6sFcXp; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c224add9b4so805259b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709884180; x=1710488980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qMSiEu8nY0E83yNC6g1NCX6P1kFAKXul/MRDUIem5A=;
        b=XJ6sFcXpWINt1pR0G/GvYJh1wx23/PPhnIkDAhS9Ky1Ph6L274XmWdovmGsvjmc7gj
         sa9m/pff8ebf6GCXuVMhf24M+EYWbZ51u9AQKlqxpWrUJPXFqUEi+X/FX90wYdF2zWKA
         AdFEcarMBAaaTNqfmBonxbguy//u0QYCVTfy3xr8ctbqqL9sEdXB8pJWQvjrTklUxW4A
         /HMckAMiQDqyIHyNvN73r9ntf3leeXQnoFgJ0A27kT/QcWMF9Gb1lRr56/GtcmEq9bgk
         mXhgTjT550+8LhzOZm3BtYV7405FwNKv/e0gAz7DIrD4twfCJDi8/rvF3cAaRNjCAras
         KETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884180; x=1710488980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qMSiEu8nY0E83yNC6g1NCX6P1kFAKXul/MRDUIem5A=;
        b=xKCLTJO+ylQSt7PGhUAYBdXQ5OjKZ9SB3zsMZYBp9+opEzmL9jHUXLDK2WGlyas/yk
         g3XdfMKcjhU/RGy5n96sBZTK4MENz6UeDmQ57dK/KwWtzpuCCLaaNYl7MuN+ll/hnda7
         PkicCoxyec27NMfQMjDA2J7sKz9ESrKTVZlyxyeORzThZTZujCra1GHyVYBlF2v5GAML
         nGLtLR7DAB9q2oqb1wZsf6wQ2Gt1x+jJNb7zXE28jT6dxocPJSULFJRFYdgIbbdWhLkQ
         otXdtrqZ4qwLr3zGzDevGAwkG9hU6cUCFLCqvn0K2l6SOOpJ8mbL20z1ajx2/ppjf3bJ
         P1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe4QM2nSKtRp4czpfD9T1iYSkfN0CDP2vAzLvmnjyVio7h2YJ+RfiiLwHxJ3xYZ7BYYUTYqSIX6hGMsKuG/xzKU2PqfGjyPqoa/YBw
X-Gm-Message-State: AOJu0YzAUvbZu1XcQCk14JIkWr8qAizchPItg6vvkPSsp5dUo43l7YZk
	yYV1SmstZNT31t2qrfjfBKGThyxaw3/VM2APFFUETf4KOuDh1arf
X-Google-Smtp-Source: AGHT+IGSIbgY91MiTNX/RJduGlZDvnVktYm1Sx9nN8RxL+FOCKS2JaShyJqCkaDLvmQx9fzUlAI+GA==
X-Received: by 2002:a05:6808:1a0d:b0:3c1:cd88:2897 with SMTP id bk13-20020a0568081a0d00b003c1cd882897mr13470605oib.16.1709884179745;
        Thu, 07 Mar 2024 23:49:39 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.240.9])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b006e583a649b4sm13597973pfn.210.2024.03.07.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 23:49:39 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	mhocko@suse.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	songmuchun@bytedance.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/khugepaged: reduce process visible downtime by pre-zeroing hugepage
Date: Fri,  8 Mar 2024 15:49:21 +0800
Message-Id: <20240308074921.45752-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch reduces the process visible downtime during hugepage
collapse. This is achieved by pre-zeroing the hugepage before
acquiring mmap_lock(write mode) if nr_pte_none >= 256, without
affecting the efficiency of khugepaged.

On an Intel Core i5 CPU, the process visible downtime during
hugepage collapse is as follows:

| nr_ptes_none  | w/o __GFP_ZERO | w/ __GFP_ZERO  |  Change |
--------------------------------------------------—----------
|      511      |     233us      |      95us      |  -59.21%|
|      384      |     376us      |     219us      |  -41.20%|
|      256      |     421us      |     323us      |  -23.28%|
|      128      |     523us      |     507us      |   -3.06%|

Of course, alloc_charge_hpage() will take longer to run with
the __GFP_ZERO flag.

|       Func           | w/o __GFP_ZERO | w/ __GFP_ZERO |
|----------------------|----------------|---------------|
| alloc_charge_hpage   |      198us     |      295us    |

But it's not a big deal because it doesn't impact the total
time spent by khugepaged in collapsing a hugepage. In fact,
it would decrease.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/khugepaged.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 38830174608f..a2872596b865 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -88,6 +88,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
 static unsigned int khugepaged_max_ptes_none __read_mostly;
 static unsigned int khugepaged_max_ptes_swap __read_mostly;
 static unsigned int khugepaged_max_ptes_shared __read_mostly;
+static unsigned int khugepaged_min_ptes_none_prezero __read_mostly;
 
 #define MM_SLOTS_HASH_BITS 10
 static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
@@ -96,6 +97,7 @@ static struct kmem_cache *mm_slot_cache __ro_after_init;
 
 struct collapse_control {
 	bool is_khugepaged;
+	bool alloc_zeroed_hpage;
 
 	/* Num pages scanned per node */
 	u32 node_load[MAX_NUMNODES];
@@ -396,6 +398,7 @@ int __init khugepaged_init(void)
 	khugepaged_max_ptes_none = HPAGE_PMD_NR - 1;
 	khugepaged_max_ptes_swap = HPAGE_PMD_NR / 8;
 	khugepaged_max_ptes_shared = HPAGE_PMD_NR / 2;
+	khugepaged_min_ptes_none_prezero = HPAGE_PMD_NR / 2;
 
 	return 0;
 }
@@ -782,6 +785,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
 				     struct vm_area_struct *vma,
 				     unsigned long address,
 				     spinlock_t *ptl,
+				     struct collapse_control *cc,
 				     struct list_head *compound_pagelist)
 {
 	struct page *src_page;
@@ -797,7 +801,8 @@ static int __collapse_huge_page_copy(pte_t *pte,
 	     _pte++, page++, _address += PAGE_SIZE) {
 		pteval = ptep_get(_pte);
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-			clear_user_highpage(page, _address);
+			if (!cc->alloc_zeroed_hpage)
+				clear_user_highpage(page, _address);
 			continue;
 		}
 		src_page = pte_page(pteval);
@@ -1067,6 +1072,9 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
 
+	if (cc->alloc_zeroed_hpage)
+		gfp |= __GFP_ZERO;
+
 	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
 		*hpage = NULL;
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
@@ -1209,7 +1217,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	anon_vma_unlock_write(vma->anon_vma);
 
 	result = __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
-					   vma, address, pte_ptl,
+					   vma, address, pte_ptl, cc,
 					   &compound_pagelist);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
@@ -1272,6 +1280,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+	cc->alloc_zeroed_hpage = false;
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!pte) {
 		result = SCAN_PMD_NULL;
@@ -1408,6 +1417,10 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 out_unmap:
 	pte_unmap_unlock(pte, ptl);
 	if (result == SCAN_SUCCEED) {
+		if (cc->is_khugepaged &&
+		    none_or_zero >= khugepaged_min_ptes_none_prezero)
+			cc->alloc_zeroed_hpage = true;
+
 		result = collapse_huge_page(mm, address, referenced,
 					    unmapped, cc);
 		/* collapse_huge_page will return with the mmap_lock released */
@@ -2054,7 +2067,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	index = start;
 	list_for_each_entry(page, &pagelist, lru) {
 		while (index < page->index) {
-			clear_highpage(hpage + (index % HPAGE_PMD_NR));
+			if (!cc->alloc_zeroed_hpage)
+				clear_highpage(hpage + (index % HPAGE_PMD_NR));
 			index++;
 		}
 		if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR), page) > 0) {
@@ -2064,7 +2078,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		index++;
 	}
 	while (index < end) {
-		clear_highpage(hpage + (index % HPAGE_PMD_NR));
+		if (!cc->alloc_zeroed_hpage)
+			clear_highpage(hpage + (index % HPAGE_PMD_NR));
 		index++;
 	}
 
@@ -2234,6 +2249,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	swap = 0;
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+	cc->alloc_zeroed_hpage = false;
 	rcu_read_lock();
 	xas_for_each(&xas, page, start + HPAGE_PMD_NR - 1) {
 		if (xas_retry(&xas, page))
@@ -2305,11 +2321,16 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	rcu_read_unlock();
 
 	if (result == SCAN_SUCCEED) {
-		if (cc->is_khugepaged &&
-		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
+		if (!cc->is_khugepaged)
+			result = collapse_file(mm, addr, file, start, cc);
+		else if (present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
 			result = SCAN_EXCEED_NONE_PTE;
 			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 		} else {
+			if (HPAGE_PMD_NR - present >=
+			    khugepaged_min_ptes_none_prezero)
+				cc->alloc_zeroed_hpage = true;
+
 			result = collapse_file(mm, addr, file, start, cc);
 		}
 	}
-- 
2.33.1


