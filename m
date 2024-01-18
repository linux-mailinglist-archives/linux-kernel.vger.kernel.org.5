Return-Path: <linux-kernel+bounces-30109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C96831946
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8352F1C2106F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA928E3A;
	Thu, 18 Jan 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X9AMrKwC"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E228DC3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581580; cv=none; b=tEWZiFS/FsM1t/eMJIkcSVJS+qx+V6HZlh6DdNmCcjjwM6VZMaGejPzUwGxdabHiUiFT9ERNH9GlHyg94JatoI4ZyjlVyicXLcLklWg++LqiZKFFDtXLkPw/REeM/ipllzZNl8ZIlM8tvmXBlpQSkHOqeI0qcAWTpmRomt7C4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581580; c=relaxed/simple;
	bh=RXho9gcWShyEgzc6VWxyMJAoRzTXkb0OAPzJWwFdVNk=;
	h=X-Report-Abuse:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Migadu-Flow; b=JBxx7x0p4aVNQeJO2eSpJ6FqDQfAXhcZD9ZQYBfdBb4WLKURle13XASBLy8RdQ9x1G47lgX2EozL/dqo7pz8G2SIcQXwMDtMcWxXUbG3Pf/nlTDbgmJoOolYY4f0ABLTNcrvl8RdmH26dLPGbju8ToYqpyN9AZ4DSNnzfZoBuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X9AMrKwC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705581576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NWoU3oNLKXdGAS21M0bC7+FD15GTIkL0kQlYQf/mAw=;
	b=X9AMrKwCFkauV1DKTVIEE+qGM2FG1NTvSzWTmV79baKdAnr8JOXd0UzWf4lXz9eRSwPsmJ
	xUlRA/NNXsMhUd+q5AubG2ApMlLTNXk5xLpCNocAJIIsPrKSI0L4SkGbNsxx3zBpI/B7Hw
	DoLUtRX1d5mdreKgoItEtz++Kk7gaXI=
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
Subject: [PATCH v4 6/7] hugetlb: parallelize 2M hugetlb allocation and initialization
Date: Thu, 18 Jan 2024 20:39:10 +0800
Message-Id: <20240118123911.88833-7-gang.li@linux.dev>
In-Reply-To: <20240118123911.88833-1-gang.li@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By distributing both the allocation and the initialization tasks across
multiple threads, the initialization of 2M hugetlb will be faster,
thereby improving the boot speed.

Here are some test results:
        test          no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2t(4 node) 2M           3336          1051   68.52%
  128c1t(2 node) 2M           1943           716   63.15%

Signed-off-by: Gang Li <gang.li@linux.dev>
Tested-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index effe5539e545..9b348ba418f5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -35,6 +35,7 @@
 #include <linux/delayacct.h>
 #include <linux/memory.h>
 #include <linux/mm_inline.h>
+#include <linux/padata.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -3510,43 +3511,76 @@ static void __init hugetlb_hstate_alloc_pages_errcheck(unsigned long allocated,
 	}
 }
 
-static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
+static void __init hugetlb_alloc_node(unsigned long start, unsigned long end, void *arg)
 {
-	unsigned long i;
+	struct hstate *h = (struct hstate *)arg;
+	int i, num = end - start;
+	nodemask_t node_alloc_noretry;
+	unsigned long flags;
+	int next_node = 0;
 
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
+	/* Bit mask controlling how hard we retry per-node allocations.*/
+	nodes_clear(node_alloc_noretry);
+
+	for (i = 0; i < num; ++i) {
+		struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+						&node_alloc_noretry, &next_node);
+		if (!folio)
 			break;
+		spin_lock_irqsave(&hugetlb_lock, flags);
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		cond_resched();
 	}
+}
 
-	return i;
+static void __init hugetlb_vmemmap_optimize_node(unsigned long start, unsigned long end, void *arg)
+{
+	struct hstate *h = (struct hstate *)arg;
+	int nid = start;
+
+	hugetlb_vmemmap_optimize_folios(h, &h->hugepage_freelists[nid]);
 }
 
-static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
+static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 {
 	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t node_alloc_noretry;
-
-	/* Bit mask controlling how hard we retry per-node allocations.*/
-	nodes_clear(node_alloc_noretry);
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-						&node_alloc_noretry);
-		if (!folio)
+		if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 			break;
-		list_add(&folio->lru, &folio_list);
 		cond_resched();
 	}
 
-	prep_and_add_allocated_folios(h, &folio_list);
-
 	return i;
 }
 
+static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
+{
+	struct padata_mt_job job = {
+		.fn_arg		= h,
+		.align		= 1,
+		.numa_aware	= true
+	};
+
+	job.thread_fn	= hugetlb_alloc_node;
+	job.start	= 0;
+	job.size	= h->max_huge_pages;
+	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
+	job.max_threads	= num_node_state(N_MEMORY) * 2;
+	padata_do_multithreaded(&job);
+
+	job.thread_fn	= hugetlb_vmemmap_optimize_node;
+	job.start	= 0;
+	job.size	= num_node_state(N_MEMORY);
+	job.min_chunk	= 1;
+	job.max_threads	= num_node_state(N_MEMORY);
+	padata_do_multithreaded(&job);
+
+	return h->nr_huge_pages;
+}
+
 /*
  * NOTE: this routine is called in different contexts for gigantic and
  * non-gigantic pages.
-- 
2.20.1


