Return-Path: <linux-kernel+bounces-149563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE38A92E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7F1F216D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5CE7D089;
	Thu, 18 Apr 2024 06:15:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4038777F32
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420958; cv=none; b=o5qTCoDzODbZkfwbzjhW/C/snPBXML1GJKG6cdfZTSs9MNqvU3zoJly6rE5OkWOREJ/R/CX8If/kUI6uo50CwA2knP+5rTr26jA42Zd8W1JH8SvPhEsbj4aJK9QCcVB2Dd6NSD4/vGnX7Ne08KMKqBQCZmU13RhLerT52pKz7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420958; c=relaxed/simple;
	bh=3eLH2BLlWkEYsS7RF+xY4RVwqItCJ3CSmzz3P6DKcbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dnledQeu6Zd2XiCwJaxOwlicWBtIDUoTaIerbw9HExfGVcpZYz8nO/swxNciFVEL6ChfQnh+md7EhVs9C/ql28iIx6qwfho7xLEjCIPvY1LpVJlfCNNsFS6u+Bnj8yyUwvtStmhqPrwfXCBm0/y0RumN7A/61bdysP0idM3iczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-16-6620ba93ce04
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
Subject: [PATCH v9 rebase on mm-unstable 6/8] mm: buddy: make room for a new variable, mgen, in struct page
Date: Thu, 18 Apr 2024 15:15:34 +0900
Message-Id: <20240418061536.11645-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnke7kXQppBjvnC1jMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	f6f3MhasUqn41DGNpYHxpUwXIyeHhICJxLRfjxlh7L5TncwgNpuAusSNGz/BbBEBM4mDrX/Y
	QWxmgbtMEgf62UBsYYFsiS+LvgPVcHCwCKhK/O9jAQnzCphKPL94lBVipLzE6g0HwMZwAo3p
	f3+IEaRcCKjmwt+QLkYuoJL3bBJf/tyGqpeUOLjiBssERt4FjAyrGIUy88pyEzNzTPQyKvMy
	K/SS83M3MQLDflntn+gdjJ8uBB9iFOBgVOLhPXlAPk2INbGsuDL3EKMEB7OSCG+LsGyaEG9K
	YmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsa5jWeuh3osWhkz
	4ysLk9+az42XTvz75vXggUWIyPNNM4++WjUhY/JHplm+7fNMqyeu/7lj/uapyUxXVJ4z+2e+
	LDpTMt22f7dT785jBU8vTDuts9zH/nhjpyhnIeeeKw+Vlm8tO1yUYy5xLuCmysQ3bm43Dy/9
	qZP1+fHm08ZOXUrxJ7Yc27csQomlOCPRUIu5qDgRAPdDPVp3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrDt5l0Kawd2/zBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyvh3ei9jwSqVik8d01gaGF/KdDFyckgImEj0nepkBrHZBNQlbtz4CWaLCJhJ
	HGz9ww5iMwvcZZI40M8GYgsLZEt8WfQdqIaDg0VAVeJ/HwtImFfAVOL5xaOsECPlJVZvOAA2
	hhNoTP/7Q4wg5UJANRf+hkxg5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMIiX1f6Z
	uIPxy2X3Q4wCHIxKPLwnDsinCbEmlhVX5h5ilOBgVhLhbRGWTRPiTUmsrEotyo8vKs1JLT7E
	KM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgPB46x3Lj1tbjzflrl97XqFt6eOG9ZCe+
	pb+2irWY3Dq1ZPqNhdf1tkdJrFJ0y3bR/rqxOUjsrPFcxsLS3gvzbvBt2nMxq/1HV9LMULF6
	772ff37tKeZd/KNj+rXtG7OYmY3nBhhLLItxeie+4WlXmZTr2+ZXN9l/8k7N6XfMjtN6d/ER
	45pJ2UosxRmJhlrMRcWJAHomsZpeAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for migrc mechanism that
tracks need of tlb flush for each page residing in buddy, using a
generation number in struct page.

Fortunately, since the private field in struct page is used only to
store page order in buddy, ranging from 0 to MAX_PAGE_ORDER, that can be
covered with unsigned short int.  So splitted it into two smaller ones,
order and mgen, so that the both can be used in buddy at the same time.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h | 39 ++++++++++++++++++++++++++++++++-------
 mm/internal.h            |  4 ++--
 mm/page_alloc.c          | 13 ++++++++-----
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index db0adf5721cc..47fd3780bd19 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -108,13 +108,24 @@ struct page {
 				pgoff_t index;		/* Our offset within mapping. */
 				unsigned long share;	/* share count for fsdax */
 			};
-			/**
-			 * @private: Mapping-private opaque data.
-			 * Usually used for buffer_heads if PagePrivate.
-			 * Used for swp_entry_t if PageSwapCache.
-			 * Indicates order in the buddy system if PageBuddy.
-			 */
-			unsigned long private;
+			union {
+				/**
+				 * @private: Mapping-private opaque data.
+				 * Usually used for buffer_heads if PagePrivate.
+				 * Used for swp_entry_t if PageSwapCache.
+				 */
+				unsigned long private;
+				struct {
+					/*
+					 * Indicates order in the buddy system if PageBuddy.
+					 */
+					unsigned short int order;
+					/*
+					 * Tracks need of tlb flush used by migrc
+					 */
+					unsigned short int mgen;
+				};
+			};
 		};
 		struct {	/* page_pool used by netstack */
 			/**
@@ -521,6 +532,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
+#define page_buddy_order(page)		((page)->order)
+
+static inline void set_page_buddy_order(struct page *page, unsigned int order)
+{
+	page->order = (unsigned short int)order;
+}
+
+#define page_buddy_mgen(page)		((page)->mgen)
+
+static inline void set_page_buddy_mgen(struct page *page, unsigned short int mgen)
+{
+	page->mgen = mgen;
+}
+
 static inline void *folio_get_private(struct folio *folio)
 {
 	return folio->private;
diff --git a/mm/internal.h b/mm/internal.h
index b34d9e627132..0336375c6e8b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -453,7 +453,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -467,7 +467,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33d4a1be927b..cbde22c4c189 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -565,9 +565,12 @@ void prep_compound_page(struct page *page, unsigned int order)
 	prep_compound_head(page, order);
 }
 
-static inline void set_buddy_order(struct page *page, unsigned int order)
+static inline void set_buddy_order_mgen(struct page *page,
+					unsigned int order,
+					unsigned short int mgen)
 {
-	set_page_private(page, order);
+	set_page_buddy_order(page, order);
+	set_page_buddy_mgen(page, order);
 	__SetPageBuddy(page);
 }
 
@@ -834,7 +837,7 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order(page, order);
+	set_buddy_order_mgen(page, order, 0);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1344,7 +1347,7 @@ static inline void expand(struct zone *zone, struct page *page,
 			continue;
 
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
-		set_buddy_order(&page[size], high);
+		set_buddy_order_mgen(&page[size], high, 0);
 		nr_added += size;
 	}
 	account_freepages(zone, nr_added, migratetype);
@@ -6802,7 +6805,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_list(current_buddy, zone, high, migratetype, false);
-		set_buddy_order(current_buddy, high);
+		set_buddy_order_mgen(current_buddy, high, 0);
 	}
 }
 
-- 
2.17.1


