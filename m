Return-Path: <linux-kernel+bounces-70753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA5E859BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642AF28128C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43C210F9;
	Mon, 19 Feb 2024 06:04:36 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEF20B03
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322676; cv=none; b=M4hlVY2gQ9UeQCkxRJaWfkl9dk4H5xEX/v7XEHlZBJKpByFkqMhUs3z+ecDRQ+MTiquDnPRQ/43EhoGK55O1CjfFcqMJjJfEd0WpaTKPYAy/1YUfSd8nvHCz6sL3tph5mDj+LKFCbFkUfJgBK6v2MtDwnwFf+smbdqLDsNTXJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322676; c=relaxed/simple;
	bh=o06PFcoiHrss96x6Trd7RHh2EbWbMqndDf78qMPLNHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l3LuBQA087rPKDKbRV4srdbykuGT+DamvHYlVcUWj8tsqW/v6VYlyGL0yz0JAsL9092mLzHkGPgIoM9eogTal4oUzzCyJndYSRcYhq3y1hPMd/2Q993Wuhr5ihOr8hu9pWZt2piiLcCilVaEjad995tU0UABS7xVJpO1EonkYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d6-65d2ef61a9e5
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
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
Subject: [PATCH v8 6/8] mm: Add APIs to free a folio directly to the buddy bypassing pcp
Date: Mon, 19 Feb 2024 15:04:05 +0900
Message-Id: <20240219060407.25254-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219060407.25254-1-byungchul@sk.com>
References: <20240219060407.25254-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnkW7i+0upBouuWFjMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+PU/UXsBddkK/6//cfawDhZoouRk0NCwERiwaOrzDD23CeX2EBsNgF1iRs3
	foLFRQTMJA62/mHvYuTiYBb4yCSx+nsHC0hCWCBC4u69LUAJDg4WAVWJx5OCQMK8AqYSC/5+
	YYKYKS+xesMBZpASTqA5uw8KgYSFgEpOXJ3MBDJSQqCdXeJO12qoGyQlDq64wTKBkXcBI8Mq
	RqHMvLLcxMwcE72MyrzMCr3k/NxNjMBoWFb7J3oH46cLwYcYBTgYlXh4M0QupQqxJpYVV+Ye
	YpTgYFYS4XVvupAqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJ
	g1OqgTHuwW3DhYWpH8t3zGNwaJe1WtX7ac7P6a+T27pFbyzj+MScWJbtknK4PuaooNij78eW
	xx5T1u5aqzi54+b2xvCJU0PLHr17O/26bNT/U2rSD768S72X4XH6SaTaTxexm836gvzTf828
	ZlEWumj7xCtXuEuVkh7KP3sZkJCy/3u3+t/2vKb0bx5KLMUZiYZazEXFiQBUey43ggIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC5WfdrJv4/lKqwdsDehZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyTt1fxF5wTbbi/9t/rA2MkyW6GDk5JARMJOY+ucQGYrMJ
	qEvcuPGTGcQWETCTONj6h72LkYuDWeAjk8Tq7x0sIAlhgQiJu/e2ACU4OFgEVCUeTwoCCfMK
	mEos+PuFCWKmvMTqDQeYQUo4gebsPigEEhYCKjlxdTLTBEauBYwMqxhFMvPKchMzc0z1irMz
	KvMyK/SS83M3MQJDe1ntn4k7GL9cdj/EKMDBqMTDmyFyKVWINbGsuDL3EKMEB7OSCK9704VU
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkZO3uRjO9V9
	duxKY4vpvCy18q6k+dy3AmbiM/O8rfsFLIVnOvBdkXFw2GOwZ5HNybOXn66N3X7liv/cuKk3
	Flx8+rzbWPLtstWTJU9O+qy4dvZmRwGmZ3meGoIXhLUWGSR/3WGdF84jxvJodcFir0Um0u6O
	HXG3cxsDqn5bmdw8pnzNKtiFXUCJpTgj0VCLuag4EQD1ji3paQIAAA==
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


