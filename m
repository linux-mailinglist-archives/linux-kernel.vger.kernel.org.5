Return-Path: <linux-kernel+bounces-80449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26A866882
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6283283652
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF291BF35;
	Mon, 26 Feb 2024 03:06:41 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F651B7E2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916800; cv=none; b=bYmbnh9BN0t/A16WIEXoRyr6SgLcsMN+tDA+RcMjhGlNr/gBjd8oVQnHVlseaLa85OEPppOyfIWf+6oWBTStoWNTLUsXWwUh/jVQsILN0lvb7xR7tjoSOj5pI3yb1XWSgl7KfQ37IKgo/O2dAW0r4hCiMhQ8TFsG7qwgQVUf6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916800; c=relaxed/simple;
	bh=o06PFcoiHrss96x6Trd7RHh2EbWbMqndDf78qMPLNHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Lt5nViZSAZoMoAJPuU5yOGFyFBhlPulyZgSy5fv9KXYcclysY4EH9HB8XRGNSDkmCiZ2lwB0DSLlmw6eoip3NHEsUICK+sBSaqBn7SfInSmHTNePiXvI+jyV16z6Ka/kX2RL811JN3xSQU5LmqLOoOq56Tr7vA70LEAgg0c99l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-41-65dc002f0738
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RESEND PATCH v8 6/8] mm: Add APIs to free a folio directly to the buddy bypassing pcp
Date: Mon, 26 Feb 2024 12:06:11 +0900
Message-Id: <20240226030613.22366-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoa4Bw51Ug/Pn2CzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	qfuL2AuuyVb8f/uPtYFxskQXIweHhICJxNZHGV2MnGDm0zntLCA2m4C6xI0bP5lBbBEBM4mD
	rX/YQWxmgbtMEgf62UBsYYF4if2X9oDVsAioSux98QOsl1fAVGLG58lsEDPlJVZvOMAMsooT
	aM77/4YgYSGgkr+9Vxm7GLmASj6zSWzZepgdol5S4uCKGywTGHkXMDKsYhTKzCvLTczMMdHL
	qMzLrNBLzs/dxAgM+2W1f6J3MH66EHyIUYCDUYmHd8GH26lCrIllxZW5hxglOJiVRHjDZW6m
	CvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamBs/fwpueHU
	+a9tKw+2sUW6Xbrza+XE5pfOx8KLlTklC3pe7Dl5W/xH0iLN+GtZapmOzp+F9zow/WKaJquq
	t/Td3RgtJZXY6nUBOjITfu//bnl8389p/695R/1hzOyZG64y9XTs34X8TNqa66csEjSdH9Zm
	u73wwNTLs17mLVOZ/P3rydCGyGUflViKMxINtZiLihMBNdP+sncCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfVYOcJS4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZZy6v4i94Jpsxf+3/1gbGCdLdDFyckgImEg8ndPOAmKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFoiX2H9pD1gNi4CqxN4XP8B6eQVMJWZ8nswGMVNeYvWGA0A1
	HBycQHPe/zcECQsBlfztvco4gZFrASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAwXlb7
	Z+IOxi+X3Q8xCnAwKvHwLvhwO1WINbGsuDL3EKMEB7OSCG+4zM1UId6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkadtKp9a39EpfhfkeG/yl7+RWGKU8Ar
	h7QetZ0O31+/at9+Y9qPHSdCr54z+NdVrbB9evJcp3jNm4/Z5V709a477P5QvGKyx1WtmQw9
	zwzOBq15tV137Ycfy9IvnZa4HZEYYGsSVuHG98zS5ZL1gbK2ZSzHJ3fMO6gpEPyQ5yTnZY24
	2xMfZzEosRRnJBpqMRcVJwIAuYNFwF8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that frees folios at a better
time. The mechanism will defer the use of folio_put*() for source folios
of migration, that are unlikely to be used and a group of folios will be
freed at once at a later time.

However, this will pollute pcp so as to inexpectedly free_pcppages_bulk()
fresher folios and make pcp get unstable. To facilitate this new
mechanism, an additional API has been added that allows folios under
migrc's control to be freed directly to buddy bypassing pcp.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h | 23 +++++++++++++++++++++++
 mm/internal.h      |  1 +
 mm/page_alloc.c    | 10 ++++++++++
 mm/swap.c          |  7 +++++++
 4 files changed, 41 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index da5219b48d52..fc0581cce3a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1284,6 +1284,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_small_nopcp(struct folio *folio);
 
 void put_pages_list(struct list_head *pages);
 
@@ -1483,6 +1484,28 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+/**
+ * folio_put_small_nopcp - Decrement the reference count on a folio.
+ * @folio: The folio.
+ *
+ * This is only for a single page folio to release directly to the buddy
+ * allocator bypassing pcp.
+ *
+ * If the folio's reference count reaches zero, the memory will be
+ * released back to the page allocator and may be used by another
+ * allocation immediately.  Do not access the memory or the struct folio
+ * after calling folio_put_small_nopcp() unless you can be sure that it
+ * wasn't the last reference.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put_small_nopcp(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__folio_put_small_nopcp(folio);
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/internal.h b/mm/internal.h
index b880f1e78700..3be8fd5604e8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -451,6 +451,7 @@ extern int user_min_free_kbytes;
 
 extern void free_unref_page(struct page *page, unsigned int order);
 extern void free_unref_page_list(struct list_head *list);
+extern void free_pages_nopcp(struct page *page, unsigned int order);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..21b8c8cd1673 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -565,6 +565,16 @@ static inline void free_the_page(struct page *page, unsigned int order)
 		__free_pages_ok(page, order, FPI_NONE);
 }
 
+void free_pages_nopcp(struct page *page, unsigned int order)
+{
+	/*
+	 * This function will be used in case that the pages are too
+	 * cold to keep in pcp e.g. migrc mechanism. So it'd better
+	 * release the pages to the tail.
+	 */
+	__free_pages_ok(page, order, FPI_TO_TAIL);
+}
+
 /*
  * Higher-order pages are called "compound pages".  They are structured thusly:
  *
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..3f37496a1184 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -106,6 +106,13 @@ static void __folio_put_small(struct folio *folio)
 	free_unref_page(&folio->page, 0);
 }
 
+void __folio_put_small_nopcp(struct folio *folio)
+{
+	__page_cache_release(folio);
+	mem_cgroup_uncharge(folio);
+	free_pages_nopcp(&folio->page, 0);
+}
+
 static void __folio_put_large(struct folio *folio)
 {
 	/*
-- 
2.17.1


