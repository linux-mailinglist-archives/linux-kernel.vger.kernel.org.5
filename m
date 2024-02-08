Return-Path: <linux-kernel+bounces-57520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3B84DA12
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4E32890A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C76A03A;
	Thu,  8 Feb 2024 06:26:32 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D8F69970
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373592; cv=none; b=Zn1D/bS51T0nBQHFSHuaEk0y8EBHNq9sHCG3+DRxqWN+5ECEV4n+Wq3CYtH5UouOlBy3iP9WCqE/3YVxcmtswDgV/e4RlSAy4vasCZTH8a8WBeSLsNC45BF6BoLMktHXeVxZJmn6gMiNZRGRjxgSYbHdDjImel449uEEinZstH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373592; c=relaxed/simple;
	bh=PPKOPn2IbvTcBctKVTS0Fl0+U/NWQCZnf8fEERyE5Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A6JfNFoTGkWb5DBVhT0B0z1gFCFb2DzCkHHqmXW6VuB/EdV1WlvlZclaKALgUM5556Jx5zRfbSvHujs05/5K775AG2wj2Pj37nMZqGYuSJtHO4vorIIKAuyJmtADHdcx+p4P2oi9xUXeTMOMmzVu+U80pA1+bO6sllMafRK73fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-8a-65c4740b3aca
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
Subject: [RESEND PATCH v7 6/8] mm: Add APIs to free a folio directly to the buddy bypassing pcp
Date: Thu,  8 Feb 2024 15:26:06 +0900
Message-Id: <20240208062608.44351-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208062608.44351-1-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnkS53yZFUg6X3pS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkPN7Nf8sWwB/FZZOS
	mpNZllqkb5fAldFxna3gj1TF4eO7mRsYf4h2MXJySAiYSPx9vIQRxr508xwLiM0moC5x48ZP
	ZhBbRMBM4mDrH/YuRi4OZoGPTBKrv3eAFQkLxEvMOLAazGYRUJW4cewdWAOvgKnElH2fmSCG
	ykus3nAALM4JNGjntlOsILYQUM2L2ZPZQIZKCDSzS0x/OIMFokFS4uCKGywTGHkXMDKsYhTK
	zCvLTczMMdHLqMzLrNBLzs/dxAiMh2W1f6J3MH66EHyIUYCDUYmH90T54VQh1sSy4srcQ4wS
	HMxKIrxmOw6kCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCU
	amAsn+fk1X/zMVvXtPUi95U7J/3kuNDX9+fysunXT17TeHYnUUK0tzzilaIku+vF/1V9v1+x
	SJjYOqrMn8YbWKfE53t99UzDbPO2Kewd631afBoeTvYS7rU2+6j7qftehvVz3r2nKk7euP9M
	qizDu87t4PP+AqUkee3tkl4Cx16/jep1lnk3Y44SS3FGoqEWc1FxIgCrGM6WgwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrMtdciTVoPu8gMWc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqOPkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJOfx
	bv5btgCBKC6blNSczLLUIn27BK6MjutsBX+kKg4f383cwPhDtIuRk0NCwETi0s1zLCA2m4C6
	xI0bP5lBbBEBM4mDrX/Yuxi5OJgFPjJJrP7eAVYkLBAvMePAajCbRUBV4saxd2ANvAKmElP2
	fWaCGCovsXrDAbA4J9CgndtOsYLYQkA1L2ZPZpvAyLWAkWEVo0hmXlluYmaOqV5xdkZlXmaF
	XnJ+7iZGYHAvq/0zcQfjl8vuhxgFOBiVeHhPlB9OFWJNLCuuzD3EKMHBrCTCa7bjQKoQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QD492z8W6P5Z95z+n/
	MOfwUXGW1feapvXGXpUz+b8t6qzOxv8flk+PEX59PfL1TdWn/meNV9v7xrblizvNa42PP/o0
	actxlspLuRwMtosnvm3b/+f8S4mnvNuONGfqZ/hYOj0wa/k+veKI3rPpa6I3L3Jibdl2UO2t
	lOepdz4z2C63dvZPOWf6lUmJpTgj0VCLuag4EQAsrNOuagIAAA==
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


