Return-Path: <linux-kernel+bounces-32250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB5835911
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494D9281C93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D068F78;
	Mon, 22 Jan 2024 01:01:09 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CB4C7D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885268; cv=none; b=hYu0n6PXtzqqcuiEzK3FeRUF5jSp2OheLptw9pRi5AgA4Ohr1F5coLJoSL41DeliC+NjCNKzEp7DXcaxDKDfUEOM/tnbxoub2thHf6spfHG9BIwBDZakrSBBTDCfgmjNDQfv/EkUGIdhoqaiPqS6AlhcIczevEzO8VyepbvDSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885268; c=relaxed/simple;
	bh=PPKOPn2IbvTcBctKVTS0Fl0+U/NWQCZnf8fEERyE5Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pVIkvj/+CEX0557+y0iUYb4R/iLaRLsfrtbtbtVdaPKaQmhh34bXe+KyHqEM4lg2i0IqUPZtklGUCdqruIP2SuibL6NYRW9Msm1mfISe/6LI2pz7qzUiiUzyHQsTeEV7LunDMzxGV9zNrvK8BN8ExSsZ/KlRFNJD50UzyqjXcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-8a-65adbe437328
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
Subject: [PATCH v7 6/8] mm: Add APIs to free a folio directly to the buddy bypassing pcp
Date: Mon, 22 Jan 2024 10:00:38 +0900
Message-Id: <20240122010040.74346-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
References: <20240122010040.74346-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXC9ZZnka7zvrWpBtc2G1rMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK6PjOlvBH6mKw8d3Mzcw/hDtYuTgkBAwkdhxjAPG3N4s2MXIycEmoC5x48ZP
	ZhBbRMBM4mDrH/YuRi4OZoGPTBKrv3ewgCSEBSIkpmxfxA5iswioSjRMfAkW5xUwlTi//QUj
	iC0hIC+xesMBsEGcQIOm/OpiArGFgGrmftgJVdPOLvFmvz+ELSlxcMUNlgmMvAsYGVYxCmXm
	leUmZuaY6GVU5mVW6CXn525iBEbCsto/0TsYP10IPsQowMGoxMPrwL42VYg1say4MvcQowQH
	s5IIL7/qqlQh3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFIN
	jFPjFoYkO/Srujx9E/MstvSd0JHVn5Yxz61ROWWgqS9hsud8W57y6arTa96rLrC/+m37qjid
	5NYEs7I9DSeKudKLs3cfd9V7wiH55kvB4s0Mx66JLL0iGGZpWRRra61/8cAdNakXp2/f9vCO
	ym3bIhqsc9HpwW251btaprjeO3/w4i+N8y/TFyuxFGckGmoxFxUnAgBo49/vgAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwd+FahZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyOq6zFfyRqjh8fDdzA+MP0S5GDg4JAROJ7c2CXYycHGwC
	6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFvjIJLH6ewcLSEJYIEJiyvZF7CA2i4CqRMPEl2BxXgFT
	ifPbXzCC2BIC8hKrNxwAG8QJNGjKry4mEFsIqGbuh52MExi5FjAyrGIUycwry03MzDHVK87O
	qMzLrNBLzs/dxAgM7WW1fybuYPxy2f0QowAHoxIPrwP72lQh1sSy4srcQ4wSHMxKIrz8qqtS
	hXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhjDKx6vLkh3
	Mvtea9p77d7RzOPWKxN4W3a4T6++ddqBbWbq3J+TtSaXTH7AaCzym1le+vjqQvfUxcflTvyI
	fl6VsP3tvEnl089+/LIpjVvXSUo8616gj+cV5VszBHuZKh6JVD5bXW3Isb9ggnP7l9PuRfF7
	dKdeNrhel3VsVtIy0awtlZ9maq5VYinOSDTUYi4qTgQAE1Vq9mkCAAA=
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


