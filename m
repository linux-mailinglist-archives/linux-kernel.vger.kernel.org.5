Return-Path: <linux-kernel+bounces-23089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D4F82A785
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FE2856AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B83DDBC;
	Thu, 11 Jan 2024 06:23:35 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C3D6D39
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-f2-659f85c84066
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	xhao@linux.alibaba.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [v5 5/7] mm: Add APIs to free a folio directly to the buddy bypassing pcp
Date: Thu, 11 Jan 2024 15:07:55 +0900
Message-Id: <20240111060757.13563-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111060757.13563-1-byungchul@sk.com>
References: <20240111060757.13563-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnke6J1vmpBqvvClnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
	jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXRsd1
	toI/UhWHj+9mbmD8IdrFyMkhIWAiMb3pOSOMvfHTX3YQm01AXeLGjZ/MILaIgJnEwdY/QHEu
	DmaBB0wSc9+uAGrg4BAWCJLo+VAGUsMioCrxrWkqG4jNK2Aq8WT6eyaImfISqzccAJvDCTTn
	wuFZYK1CQDWP2upARkoIvGeTmHVyEgtEvaTEwRU3WCYw8i5gZFjFKJSZV5abmJljopdRmZdZ
	oZecn7uJERjyy2r/RO9g/HQh+BCjAAejEg/vg0XzUoVYE8uKK3MPMUpwMCuJ8Cp8npMqxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgbG1MJQnJ209j1uf
	34enj2dOZXGdupdBKTwoKPnVp8uHOlU1A7s4baL8HS/vuBu3ef3nw39vBZ3Ri9vvZMbeZPRW
	dBlj/KTdTsFTuk47TVS5ujvgao9krHCB+MdXLkke7v0Rp/gXVq62bMxwXq6uW1fWp13OPkc4
	sqb57t0brzd5tGgaP5nLqMRSnJFoqMVcVJwIAMpo1nB1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrHuidX6qQdNxDos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
	sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
	y1KL9O0SuDI6rrMV/JGqOHx8N3MD4w/RLkZODgkBE4mNn/6yg9hsAuoSN278ZAaxRQTMJA62
	/gGKc3EwCzxgkpj7dgVjFyMHh7BAkETPhzKQGhYBVYlvTVPZQGxeAVOJJ9PfM0HMlJdYveEA
	2BxOoDkXDs8CaxUCqnnUVjeBkWsBI8MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwABeVvtn
	4g7GL5fdDzEKcDAq8fAavJyXKsSaWFZcmXuIUYKDWUmEV+HznFQh3pTEyqrUovz4otKc1OJD
	jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRg4/2Rzhuw90Bfk+T1v7W0f0e6dAdrXB
	dqGD1UY9+ioSU2PeiTi7rewtr867bn+raY9J2UJt9fa9GtYbU9Zn//B1XNHrHqe50vUVv7Bh
	386XlmErftw//++yc2zDdS8emZrLOjfeVl/LVelTebBgclSo0HLuloBNBnXJt5tsVX5J6f6p
	b/qnxFKckWioxVxUnAgAIn/9/1wCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that frees folios at a better
time later, rather than the moment migrating folios. The folios freed by
migrc are too old to keep in pcp.

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


