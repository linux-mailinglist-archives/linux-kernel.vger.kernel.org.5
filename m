Return-Path: <linux-kernel+bounces-40274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38183DD6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5366C1C21E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C31D6AA;
	Fri, 26 Jan 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qwIcy4O8"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733591D697
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282742; cv=none; b=KilYz0wc6iztOE3Ne7WJvZO+6fPaFGrTWIpHuOOgjfGuGTHxVSX0HjbFjb0ohPiivUbCm9vr9MtS4313VNFlYYSlZMuNeq1wbEu++ME2PATfunQyfSWtE0M5P+7wqpw05CegvJ3U2kBb6WUIsZmNa9ycy8W7sNTuhxeErxW72hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282742; c=relaxed/simple;
	bh=1MgYoEYA0TYAFs7M4fp1D81Bw+npp83XpLElfpWHMK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBv3xNdrqoqeOqYEIjz0vH6pBkefL/CqZSOBqNQqBTO6HI0s/d4cJRRFtX+uXwzK3Ih2ISv1GxXJIB0kHFv2tKeguQuZkkIq3fnw+R34JKqYSKmOWAlNspPegdX7PIk4QL2wPuLf1cY8eng/4HSKz5rikYVqHd34nGXwDIRQwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qwIcy4O8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jedycsf2hoazZl2VD5dKzn3Ogz/yNT2KcxNdOLYavB4=;
	b=qwIcy4O8oYc6ieAe8OwvpEKH4wyBee3Jlif+nxuPJKFmuXp+E3oYFgTjBUsVhVcTbe3PJO
	LbG1Yp4MWWpIydaJlX5rrJfhgvOcuD2EKuJO/Yme8P9fG6DM1ACjVdMyPO1FZ4Ag0JyV0D
	a0k79BNlAPNr4wc8ZdQcdQUIK48SoXc=
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
Subject: [PATCH v5 6/7] hugetlb: parallelize 2M hugetlb allocation and initialization
Date: Fri, 26 Jan 2024 23:24:10 +0800
Message-Id: <20240126152411.1238072-7-gang.li@linux.dev>
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

By distributing both the allocation and the initialization tasks across
multiple threads, the initialization of 2M hugetlb will be faster,
thereby improving the boot speed.

Here are some test results:
      test case        no patch(ms)   patched(ms)   saved
 ------------------- -------------- ------------- --------
  256c2T(4 node) 2M           3336          1051   68.52%
  128c1T(2 node) 2M           1943           716   63.15%

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb.c | 73 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4e8ffa1c145a..385840397bce5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -35,6 +35,7 @@
 #include <linux/delayacct.h>
 #include <linux/memory.h>
 #include <linux/mm_inline.h>
+#include <linux/padata.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -3510,6 +3511,30 @@ static void __init hugetlb_hstate_alloc_pages_errcheck(unsigned long allocated,
 	}
 }
 
+static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned long end, void *arg)
+{
+	struct hstate *h = (struct hstate *)arg;
+	int i, num = end - start;
+	nodemask_t node_alloc_noretry;
+	LIST_HEAD(folio_list);
+	int next_node = first_online_node;
+
+	/* Bit mask controlling how hard we retry per-node allocations.*/
+	nodes_clear(node_alloc_noretry);
+
+	for (i = 0; i < num; ++i) {
+		struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+						&node_alloc_noretry, &next_node);
+		if (!folio)
+			break;
+
+		list_move(&folio->lru, &folio_list);
+		cond_resched();
+	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
+}
+
 static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 {
 	unsigned long i;
@@ -3525,26 +3550,40 @@ static unsigned long __init hugetlb_gigantic_pages_alloc_boot(struct hstate *h)
 
 static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 {
-	unsigned long i;
-	struct folio *folio;
-	LIST_HEAD(folio_list);
-	nodemask_t node_alloc_noretry;
-
-	/* Bit mask controlling how hard we retry per-node allocations.*/
-	nodes_clear(node_alloc_noretry);
+	struct padata_mt_job job = {
+		.fn_arg		= h,
+		.align		= 1,
+		.numa_aware	= true
+	};
 
-	for (i = 0; i < h->max_huge_pages; ++i) {
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
-						&node_alloc_noretry);
-		if (!folio)
-			break;
-		list_add(&folio->lru, &folio_list);
-		cond_resched();
-	}
+	job.thread_fn	= hugetlb_pages_alloc_boot_node;
+	job.start	= 0;
+	job.size	= h->max_huge_pages;
 
-	prep_and_add_allocated_folios(h, &folio_list);
+	/*
+	 * job.max_threads is twice the num_node_state(N_MEMORY),
+	 *
+	 * Tests below indicate that a multiplier of 2 significantly improves
+	 * performance, and although larger values also provide improvements,
+	 * the gains are marginal.
+	 *
+	 * Therefore, choosing 2 as the multiplier strikes a good balance between
+	 * enhancing parallel processing capabilities and maintaining efficient
+	 * resource management.
+	 *
+	 * +------------+-------+-------+-------+-------+-------+
+	 * | multiplier |   1   |   2   |   3   |   4   |   5   |
+	 * +------------+-------+-------+-------+-------+-------+
+	 * | 256G 2node | 358ms | 215ms | 157ms | 134ms | 126ms |
+	 * | 2T   4node | 979ms | 679ms | 543ms | 489ms | 481ms |
+	 * | 50G  2node | 71ms  | 44ms  | 37ms  | 30ms  | 31ms  |
+	 * +------------+-------+-------+-------+-------+-------+
+	 */
+	job.max_threads	= num_node_state(N_MEMORY) * 2;
+	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;
+	padata_do_multithreaded(&job);
 
-	return i;
+	return h->nr_huge_pages;
 }
 
 /*
-- 
2.20.1


