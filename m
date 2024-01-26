Return-Path: <linux-kernel+bounces-40270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E750383DD68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB07282145
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A11D54B;
	Fri, 26 Jan 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIN5KgkQ"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D61D6BD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282709; cv=none; b=HfbHa9vTwFIagJU/ESYP7lVuiemUeNWKBm6kuAEy++4xNv5l5r8VdqvaFV4Sj4VMKf58DW/RKd2x2MPjlRllKUwE/jnxfOrpehcUoZMXRMKYBG1sV1C2p8xL/qk6w8ZOSIZF2MArFHhE/OJqVj3pP9KKUn4So8u+rgwe+s+nv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282709; c=relaxed/simple;
	bh=YikDHBkjoqd+ws8wiuocM92jiPsOsAd+AX07ms88HyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agKZdm0bJtJfREKQZAuGFmmfv/BCLo4Z8D1KTmMBB//3pJ7FfRBoQFVQ1kJUL9aSge66lDutpDekMfYgEbXhDHpWxZ186GIhddlxSrkw9fTwmdOBCdoLE5U3lAiIIxcMgtCwpOr1Ff/NYjKteG1EJ69OSuuaRJjibJe1ZJt/bNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIN5KgkQ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpmnH1heqxiT9L2xvocYTAQyyeV+M8p6qSwgZH/mouw=;
	b=NIN5KgkQ6ktwWa4GiDjUdAl7RaNOrgEmptJXjSAwQxyyMDJcoijL2+TDpy7yOmpIZkDhsL
	OSnefDgiw31H9dPHL9T6oBqYiSboHE9E7/g4GRKZgZb0/NDBZi/sa0bL1SshUOSqTeY3cu
	/G8p+dcISN/5OT93ypM/kpclSHGR/Kg=
From: Gang Li <gang.li@linux.dev>
To: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v5 2/7] hugetlb: split hugetlb_hstate_alloc_pages
Date: Fri, 26 Jan 2024 23:24:06 +0800
Message-Id: <20240126152411.1238072-3-gang.li@linux.dev>
In-Reply-To: <20240126152411.1238072-1-gang.li@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
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
index 20d0494424780..00bbf7442eb6c 100644
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


