Return-Path: <linux-kernel+bounces-148059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA38A7D25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B751D283316
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03C37D3FB;
	Wed, 17 Apr 2024 07:34:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A2E7441F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339266; cv=none; b=hkRm8cxCL2tHngh7AgmbxhQNOmqtvH+5TA4iXuO460Nnv5aZMVF/CYh3kOf7zN+IjogHk7iuqQ6a36LFYhJuX/f8V/xg8MlqKBsO8Ph1orB5yL9b5dKvoatn4RC45SFVI2G4GEyCld350GqYKKSa9eSKO3J2NKKqAWVvstJOcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339266; c=relaxed/simple;
	bh=6UBLhiqsl7goEJIikM/TmWWuVZKMJGHJBKBpatkJWiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S8tGoUAhQ6CpFbZp6EOCE8ZIvSEKhglhT2mfrT+H136v/GryXHj+nNFpzZQkxIXGoQTYhabH+TEdNFa99jcdobPRqMQFb8pD/ZvbcyQADHUWPzm/8Y3uLHbK50ZSKH4a/KMSkhvezO1aKXgGXu1RSsRaQd8j2YzG5RUlg6ygvIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ac-661f77e2f414
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
Subject: [PATCH v9 6/8] mm: buddy: make room for a new variable, mgen, in struct page
Date: Wed, 17 Apr 2024 16:18:45 +0900
Message-Id: <20240417071847.29584-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnke6jcvk0g5dflSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	v1kX2AquK1c8fuzZwLhIpouRk0NCwESi+fFKdhj7VuMaRhCbTUBd4saNn8wgtoiAmcTB1j9g
	NcwCd5kkDvSzgdjCAqESsz7NZwWxWQRUJV49XgtUz8HBK2AqMaOxBmKkvMTqDQfAxnACjdnc
	vAasVQio5PuJj0A2F1DNZzaJV+fes0I0SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgWG/rPZP9A7GTxeCDzEKcDAq8fAaRMmlCbEmlhVX5h5ilOBgVhLhbRGWTRPiTUms
	rEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAuHhWdVnnz+yK0n0y
	p5g0kk3sdm1K3yxft1qYbZf4rdi6Jp49kyeK9a3IlZ5yb21n4ZOGiUcS2qemPnsRsvbMva4r
	87fE/LdRZ55Yzcq7z+XiVPU1x5/LRr6+Jm84wW+5gv6ts/v2FLRL/ZgaJMej5fN/6bzd/d9i
	g2Osv2ar7g8qPeDwx6jeQomlOCPRUIu5qDgRACm0Dwh3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7N4NwBSYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZfybdYGt4LpyxePHng2Mi2S6GDk5JARMJG41rmEEsdkE1CVu3PjJDGKLCJhJ
	HGz9ww5iMwvcZZI40M8GYgsLhErM+jSfFcRmEVCVePV4LVA9BwevgKnEjMYaiJHyEqs3HAAb
	wwk0ZnPzGrBWIaCS7yc+sk1g5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMIiX1f6Z
	uIPxy2X3Q4wCHIxKPLwGUXJpQqyJZcWVuYcYJTiYlUR4W4Rl04R4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYjeqZG5+ViM9xYxTSX7HtQYF43aNDl72/
	1FZe2v/XbMmD3wwtdve2i8ns/LcwpWFT4PN/4ls81lddvP7UJnBrx98oLZvcSxeEr23b9lBk
	+4sXMZdSf0lfT9VhZuxb5nFocd+k+yb8ev8z655f3LZ1HZ/fpaZ57zmeT52s/TXV5ardnVXt
	oct7lyuxFGckGmoxFxUnAgC2pfBtXgIAAA==
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
index 5240bd7bca33..4130d22977d6 100644
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
@@ -520,6 +531,20 @@ static inline void set_page_private(struct page *page, unsigned long private)
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
index bbaf1fd97b1c..e3a8b77b58ca 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -364,7 +364,7 @@ struct alloc_context {
 static inline unsigned int buddy_order(struct page *page)
 {
 	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
+	return page_buddy_order(page);
 }
 
 /*
@@ -378,7 +378,7 @@ static inline unsigned int buddy_order(struct page *page)
  * times, potentially observing different values in the tests and the actual
  * use of the result.
  */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+#define buddy_order_unsafe(page)	READ_ONCE(page_buddy_order(page))
 
 /*
  * This function checks whether a page is free && is the buddy
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d336..555f6d2e33ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -604,9 +604,12 @@ void destroy_large_folio(struct folio *folio)
 	free_the_page(&folio->page, folio_order(folio));
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
 
@@ -824,7 +827,7 @@ static inline void __free_one_page(struct page *page,
 	}
 
 done_merging:
-	set_buddy_order(page, order);
+	set_buddy_order_mgen(page, order, 0);
 
 	if (fpi_flags & FPI_TO_TAIL)
 		to_tail = true;
@@ -1404,7 +1407,7 @@ static inline void expand(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_list(&page[size], zone, high, migratetype);
-		set_buddy_order(&page[size], high);
+		set_buddy_order_mgen(&page[size], high, 0);
 	}
 }
 
@@ -6710,7 +6713,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
 			continue;
 
 		add_to_free_list(current_buddy, zone, high, migratetype);
-		set_buddy_order(current_buddy, high);
+		set_buddy_order_mgen(current_buddy, high, 0);
 	}
 }
 
-- 
2.17.1


