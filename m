Return-Path: <linux-kernel+bounces-25718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F782D4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4ACB211CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C63C134;
	Mon, 15 Jan 2024 08:20:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002379F9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-89-65a4eab45724
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
Subject: [PATCH v6 5/7] mm: Add APIs to free a folio directly to the buddy bypassing pcp
Date: Mon, 15 Jan 2024 17:19:51 +0900
Message-Id: <20240115081953.2521-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240115081953.2521-1-byungchul@sk.com>
References: <20240115081953.2521-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnke6WV0tSDebPkrWYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	Mf/eZzaLzZumMlscnzKV0eL3D6COk7MmszgIenxv7WPx2DnrLrvHgk2lHptXaHks3vOSyWPT
	qk42j02fJrF7vDt3jt3jxIzfLB7zTgZ6vN93lc1j6y87j8ap19g8Pm+S83g3/y1bAH8Ul01K
	ak5mWWqRvl0CV0bHdbaCP1IVh4/vZm5g/CHaxcjJISFgIrHo02N2GHvDsR1MIDabgLrEjRs/
	mUFsEQEziYOtf4BquDiYBT4ySaz+3sECkhAWiJD4c/ksWBGLgKpE5789bF2MHBy8QIOWnayH
	mCkvsXrDAbASTgFTiXcfj4PtEgIqabm7jhVkpoRAM7vE8v9rWSEaJCUOrrjBMoGRdwEjwypG
	ocy8stzEzBwTvYzKvMwKveT83E2MwGhYVvsnegfjpwvBhxgFOBiVeHh//F2cKsSaWFZcmXuI
	UYKDWUmEt/rOklQh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwc
	nFINjE4zODo3GK5az23z2HHVzVXObm9F1jPF3+1zr/slsXj3tvwk8SVl06eFxX00F1BsyWry
	WlclvijK22yjxDZPb6YvPh0JfW6zBSNPhXDE3jhgWPJUnFE7r/L2YftoHnPV1XfX7LxpJfTm
	75PUDy9ldvD+ruW79sRh6+IdmcJmZ4+crwlfyljzUImlOCPRUIu5qDgRAEaPGL6CAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC5WfdrLvl1ZJUg9ZmQYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZHdfZCv5IVRw+vpu5gfGHaBcjJ4eEgInEhmM7mEBsNgF1
	iRs3fjKD2CICZhIHW/+wdzFycTALfGSSWP29gwUkISwQIfHn8lmwIhYBVYnOf3vYuhg5OHiB
	Bi07WQ8xU15i9YYDYCWcAqYS7z4eZwexhYBKWu6uY53AyLWAkWEVo0hmXlluYmaOqV5xdkZl
	XmaFXnJ+7iZGYGgvq/0zcQfjl8vuhxgFOBiVeHh//F2cKsSaWFZcmXuIUYKDWUmEt/rOklQh
	3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRvX/9/84uPN9
	eJAfK+R/+bb8Bbfsb9eaXhVMvvw3UlknWe7jkliWlntncvxVLkmfl1NY09grNDWU/WmJ7uUU
	J6WJPhpfz/S6HYsPaGeT2154+35Lt2PSgpyJa9dkeMn/9w1Otk7fMrtuM0/Ij3mRS3fMKnst
	YPzwS6dvt66K8+QTU5ZOXHi2TImlOCPRUIu5qDgRALgW8+dpAgAA
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


