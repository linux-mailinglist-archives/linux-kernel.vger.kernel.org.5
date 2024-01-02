Return-Path: <linux-kernel+bounces-14387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF7821C61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C0228327F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C614AB2;
	Tue,  2 Jan 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rOSB7/ml"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B814AAA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704201222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lq6odAt2f+wReMUr3LVecCPvhipoB8fbQDkgCZGAfFs=;
	b=rOSB7/mlWJwm7Sgj4858g08l3Mah9AIYX19x1bg4TM3sAFEv9Sl0kgizs7/gcRTPswrfp0
	vOOopJqL+bE11QDfDg2MV8rTX8iV8fJMNIn3ouKYEcKaZ82/9tLxyXxN5xbIYQpLmzlMAU
	1lf390N2ueiFxZGQLNGz7dsM80AvN8Q=
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
Subject: [PATCH v3 6/7] hugetlb: parallelize 2M hugetlb allocation and initialization
Date: Tue,  2 Jan 2024 21:12:48 +0800
Message-Id: <20240102131249.76622-7-gang.li@linux.dev>
In-Reply-To: <20240102131249.76622-1-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
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
---
 mm/hugetlb.c | 72 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a71bc1622b53b..d1629df5f399f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -35,6 +35,7 @@
 #include <linux/delayacct.h>
 #include <linux/memory.h>
 #include <linux/mm_inline.h>
+#include <linux/padata.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -3510,6 +3511,38 @@ static void __init hugetlb_hstate_alloc_pages_report(unsigned long allocated, st
 	}
 }
 
+static void __init hugetlb_alloc_node(unsigned long start, unsigned long end, void *arg)
+{
+	struct hstate *h = (struct hstate *)arg;
+	int i, num = end - start;
+	nodemask_t node_alloc_noretry;
+	unsigned long flags;
+	int next_nid_to_alloc = 0;
+
+	/* Bit mask controlling how hard we retry per-node allocations.*/
+	nodes_clear(node_alloc_noretry);
+
+	for (i = 0; i < num; ++i) {
+		struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+						&node_alloc_noretry, &next_nid_to_alloc);
+		if (!folio)
+			break;
+		spin_lock_irqsave(&hugetlb_lock, flags);
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+		spin_unlock_irqrestore(&hugetlb_lock, flags);
+		cond_resched();
+	}
+}
+
+static void __init hugetlb_vmemmap_optimize_node(unsigned long start, unsigned long end, void *arg)
+{
+	struct hstate *h = (struct hstate *)arg;
+	int nid = start;
+
+	hugetlb_vmemmap_optimize_folios(h, &h->hugepage_freelists[nid]);
+}
+
 static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h)
 {
 	unsigned long i;
@@ -3529,26 +3562,27 @@ static unsigned long __init hugetlb_hstate_alloc_pages_gigantic(struct hstate *h
 
 static unsigned long __init hugetlb_hstate_alloc_pages_non_gigantic(struct hstate *h)
 {
-	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t node_alloc_noretry;
-
-	/* Bit mask controlling how hard we retry per-node allocations.*/
-	nodes_clear(node_alloc_noretry);
-
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-						&node_alloc_noretry);
-		if (!folio)
-			break;
-		list_add(&folio->lru, &folio_list);
-		cond_resched();
-	}
-
-	prep_and_add_allocated_folios(h, &folio_list);
+	struct padata_mt_job job = {
+		.fn_arg		= h,
+		.align		= 1,
+		.numa_aware	= true
+	};
 
-	return i;
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
 }
 
 /*
-- 
2.20.1


