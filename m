Return-Path: <linux-kernel+bounces-76663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA33A85FAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F94287507
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CAA14601D;
	Thu, 22 Feb 2024 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZZ38NdKG"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1981474B3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610693; cv=none; b=fnp6E9R21YzuV4+vMmmy6x/eUqtbtgoXr1iM4ERzKPKh2Z/zhxdAjkOP3n9ompLIhAzF4WZMgvn0yiQKL1e45sCp455/xvNpGF3nqbQPFCsP/J+8SR/HBdBisTwsYy+I4TR2ItugOyp8+h4mIfLAaDTb8t/EIquk+ZfqoMWPh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610693; c=relaxed/simple;
	bh=vRuxUrdqrEjW/kmQKHVnf2KKQjRlpz3t45eHDJuC1Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sf+Fkr8HhW+ZK2vz8JSRm2tGDHbmGizSuWT8yDISkkNjH11VAiKYmWA+5u4yLqe0BUh0Ow+hPPstokk5SyTNPNVytqBgBmYhpjAH9kJ8Jsh2VWgzl2TPtSYkHVKA/UqcJpnATX9i02Zk0GmRa2i7QqvDxBMXEncB9sIThA/81p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZZ38NdKG; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708610690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFm+BsVb+EJLE4T/S60F9nhII3K5Okpm0T3KX+Ypj6g=;
	b=ZZ38NdKGJjXCAsgG44/Qo//cf/3cc1EknNNpxFahUoIgcacNCf55oBecrLxSCFmnIx/6Yc
	zc0joimqN7Kl9zD1PYmr5FlyOXa9qomyj3kBYRaaA7C375f+IuMQnFTecYf2S6/jKeHeH3
	JIJykJuzg6dwPf8qafigyzC4+gneD6Q=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v6 2/8] hugetlb: split hugetlb_hstate_alloc_pages
Date: Thu, 22 Feb 2024 22:04:15 +0800
Message-Id: <20240222140422.393911-3-gang.li@linux.dev>
In-Reply-To: <20240222140422.393911-1-gang.li@linux.dev>
References: <20240222140422.393911-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1G and 2M huge pages have different allocation and initialization logic,
which leads to subtle differences in parallelization. Therefore, it is
appropriate to split hugetlb_hstate_alloc_pages into gigantic and
non-gigantic.

This patch has no functional changes.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/hugetlb.c | 87 ++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 794f3e6a19bb6..647e52596e2da 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3509,6 +3509,43 @@ static void __init hugetlb_hstate_alloc_pages_errcheck(unsigned long allocated,
 	}
 }
 
+static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
+{
+	unsigned long i;
+
+	for (i = 0; i < h->max_huge_pages; ++i) {
+		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
+			break;
+		cond_resched();
+	}
+
+	return i;
+}
+
+static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
+{
+	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
+	nodemask_t node_alloc_noretry;
+
+	/* Bit mask controlling how hard we retry per-node allocations.*/
+	nodes_clear(node_alloc_noretry);
+
+	for (i = 0; i < h->max_huge_pages; ++i) {
+		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+						&node_alloc_noretry);
+		if (!folio)
+			break;
+		list_add(&folio->lru, &folio_list);
+		cond_resched();
+	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
+
+	return i;
+}
+
 /*
  * NOTE: this routine is called in different contexts for gigantic and
  * non-gigantic pages.
@@ -3522,10 +3559,7 @@ static void __init hugetlb_hstate_alloc_pages_errcheck(unsigned long allocated,
  */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
-	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t *node_alloc_noretry;
+	unsigned long allocated;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3538,47 +3572,12 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 
 	/* below will do all node balanced alloc */
-	if (!hstate_is_gigantic(h)) {
-		/*
-		 * Bit mask controlling how hard we retry per-node allocations.
-		 * Ignore errors as lower level routines can deal with
-		 * node_alloc_noretry == NULL.  If this kmalloc fails at boot
-		 * time, we are likely in bigger trouble.
-		 */
-		node_alloc_noretry = kmalloc(sizeof(*node_alloc_noretry),
-						GFP_KERNEL);
-	} else {
-		/* allocations done at boot time */
-		node_alloc_noretry = NULL;
-	}
-
-	/* bit mask controlling how hard we retry per-node allocations */
-	if (node_alloc_noretry)
-		nodes_clear(*node_alloc_noretry);
-
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		if (hstate_is_gigantic(h)) {
-			/*
-			 * gigantic pages not added to list as they are not
-			 * added to pools now.
-			 */
-			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
-				break;
-		} else {
-			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-							node_alloc_noretry);
-			if (!folio)
-				break;
-			list_add(&folio->lru, &folio_list);
-		}
-		cond_resched();
-	}
-
-	/* list will be empty if hstate_is_gigantic */
-	prep_and_add_allocated_folios(h, &folio_list);
+	if (hstate_is_gigantic(h))
+		allocated = hugetlb_gigantic_pages_alloc_boot(h);
+	else
+		allocated = hugetlb_pages_alloc_boot(h);
 
-	hugetlb_hstate_alloc_pages_errcheck(i, h);
-	kfree(node_alloc_noretry);
+	hugetlb_hstate_alloc_pages_errcheck(allocated, h);
 }
 
 static void __init hugetlb_init_hstates(void)
-- 
2.20.1


