Return-Path: <linux-kernel+bounces-76662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B571285FAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A7284D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CD1482E9;
	Thu, 22 Feb 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i3uRvd9J"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EC1474A4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610690; cv=none; b=sGUFOgsC4egy+wuHmRHyKGNgmxB2uj7P1iSuywJSHRxCkexdtNWlfDd6YjbGsseFfEv+SEsaWiMwkKCtphkX64yPL70zK+rVj6PYCDOjMjrzztO1FPKV8Ho68/c9U1MlM9dL2MsiiCEO+F3Itp15rdLsvletDf8ps2Crl1FIlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610690; c=relaxed/simple;
	bh=9Nlv5yU9lraOMOB9dfIUMrxAw7ypqQN0Obqwia5pjOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tv7tR7D1/QoVuyuZxrH9a9W651ymOGuK9NDh7wCJ+z/oF/dUw8TExGAvetfsvexl7IBu0KNBQmvGtLSl2bDhOhUgAlaOSiR+5NklFEDGUKZF524oNw8KnnOBp9+/CXybxoz1Zpz2QcB4qKFSd9jCOoL+FlYGYNW/ny7+jOgAIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i3uRvd9J; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708610686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLDJ0oXYyRPh9zz0wE8IXI1bSRdqq7PDnnR6TGU9VgU=;
	b=i3uRvd9JstCtGlLa8/tyWtExImE0JtGxaojcIRs7n7nhFDNAP1r0mFxWuFGnV0DVJck360
	+ybW3ROURTCTJyB8p7i3fvB985dnVQ3LNtm4RXv8GdUo6fpAsYQ3cBv0H6OF+4mHm7dqT7
	SiYS5mOQGsqbMvVVng+9nU3mjbwRkQs=
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
Subject: [PATCH v6 1/8] hugetlb: code clean for hugetlb_hstate_alloc_pages
Date: Thu, 22 Feb 2024 22:04:14 +0800
Message-Id: <20240222140422.393911-2-gang.li@linux.dev>
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

The readability of `hugetlb_hstate_alloc_pages` is poor. By cleaning the
code, its readability can be improved, facilitating future modifications.

This patch extracts two functions to reduce the complexity of
`hugetlb_hstate_alloc_pages` and has no functional changes.

- hugetlb_hstate_alloc_pages_node_specific() to handle iterates through
  each online node and performs allocation if necessary.
- hugetlb_hstate_alloc_pages_report() report error during allocation.
  And the value of h->max_huge_pages is updated accordingly.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/hugetlb.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c53a41d07cd3a..794f3e6a19bb6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3482,6 +3482,33 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+static bool __init hugetlb_hstate_alloc_pages_specific_nodes(struct hstate *h)
+{
+	int i;
+	bool node_specific_alloc = false;
+
+	for_each_online_node(i) {
+		if (h->max_huge_pages_node[i] > 0) {
+			hugetlb_hstate_alloc_pages_onenode(h, i);
+			node_specific_alloc = true;
+		}
+	}
+
+	return node_specific_alloc;
+}
+
+static void __init hugetlb_hstate_alloc_pages_errcheck(unsigned long allocated, struct hstate *h)
+{
+	if (allocated < h->max_huge_pages) {
+		char buf[32];
+
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
+		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
+			h->max_huge_pages, buf, allocated);
+		h->max_huge_pages = allocated;
+	}
+}
+
 /*
  * NOTE: this routine is called in different contexts for gigantic and
  * non-gigantic pages.
@@ -3499,7 +3526,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	struct folio *folio;
 	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
-	bool node_specific_alloc = false;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3508,14 +3534,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	}
 
 	/* do node specific alloc */
-	for_each_online_node(i) {
-		if (h->max_huge_pages_node[i] > 0) {
-			hugetlb_hstate_alloc_pages_onenode(h, i);
-			node_specific_alloc = true;
-		}
-	}
-
-	if (node_specific_alloc)
+	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
 
 	/* below will do all node balanced alloc */
@@ -3558,14 +3577,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	/* list will be empty if hstate_is_gigantic */
 	prep_and_add_allocated_folios(h, &folio_list);
 
-	if (i < h->max_huge_pages) {
-		char buf[32];
-
-		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
-		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
-			h->max_huge_pages, buf, i);
-		h->max_huge_pages = i;
-	}
+	hugetlb_hstate_alloc_pages_errcheck(i, h);
 	kfree(node_alloc_noretry);
 }
 
-- 
2.20.1


