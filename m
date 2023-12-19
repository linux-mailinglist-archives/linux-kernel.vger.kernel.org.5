Return-Path: <linux-kernel+bounces-6049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FD819392
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51791C2511A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09E3FE5E;
	Tue, 19 Dec 2023 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mmCEXgMa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A61DFD7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvnDVDl+9gd8JY/2icI2mu85dJxeSXpMDACLsdprvYg=;
	b=mmCEXgMaxz3LTDhN5Aelii+nb4wwQAwSPgj8RLHqQ7+wmGOwxjtSh8dT+vmH5EYV5C6oSg
	QM5LoKW2tweYqFLGq6U5930x/xHPsIBo/zhwS0iRxm/r+0RSCb6zBs2bH9dNdRzIbXalym
	qshEQaM+itGw4MLCZQr6zHqTS6ub/qA=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 07/21] kasan: introduce kasan_mempool_unpoison_pages
Date: Tue, 19 Dec 2023 23:28:51 +0100
Message-Id: <239bd9af6176f2cc59f5c25893eb36143184daff.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
References: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Introduce and document a new kasan_mempool_unpoison_pages hook to be used
by the mempool code instead of kasan_unpoison_pages.

This hook is not functionally different from kasan_unpoison_pages, but
using it improves the mempool code readability.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 25 +++++++++++++++++++++++++
 mm/kasan/common.c     |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index de2a695ad34d..f8ebde384bd7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -225,6 +225,9 @@ bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
  * This function is similar to kasan_mempool_poison_object() but operates on
  * page allocations.
  *
+ * Before the poisoned allocation can be reused, it must be unpoisoned via
+ * kasan_mempool_unpoison_pages().
+ *
  * Return: true if the allocation can be safely reused; false otherwise.
  */
 static __always_inline bool kasan_mempool_poison_pages(struct page *page,
@@ -235,6 +238,27 @@ static __always_inline bool kasan_mempool_poison_pages(struct page *page,
 	return true;
 }
 
+void __kasan_mempool_unpoison_pages(struct page *page, unsigned int order,
+				    unsigned long ip);
+/**
+ * kasan_mempool_unpoison_pages - Unpoison a mempool page allocation.
+ * @page: Pointer to the page allocation.
+ * @order: Order of the allocation.
+ *
+ * This function is intended for kernel subsystems that cache page allocations
+ * to reuse them instead of freeing them back to page_alloc (e.g. mempool).
+ *
+ * This function unpoisons a page allocation that was previously poisoned by
+ * kasan_mempool_poison_pages() without zeroing the allocation's memory. For
+ * the tag-based modes, this function assigns a new tag to the allocation.
+ */
+static __always_inline void kasan_mempool_unpoison_pages(struct page *page,
+							 unsigned int order)
+{
+	if (kasan_enabled())
+		__kasan_mempool_unpoison_pages(page, order, _RET_IP_);
+}
+
 bool __kasan_mempool_poison_object(void *ptr, unsigned long ip);
 /**
  * kasan_mempool_poison_object - Check and poison a mempool slab allocation.
@@ -353,6 +377,7 @@ static inline bool kasan_mempool_poison_pages(struct page *page, unsigned int or
 {
 	return true;
 }
+static inline void kasan_mempool_unpoison_pages(struct page *page, unsigned int order) {}
 static inline bool kasan_mempool_poison_object(void *ptr)
 {
 	return true;
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b416f4c265a4..7ebc001d0fcd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -449,6 +449,12 @@ bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
 	return true;
 }
 
+void __kasan_mempool_unpoison_pages(struct page *page, unsigned int order,
+				    unsigned long ip)
+{
+	__kasan_unpoison_pages(page, order, false);
+}
+
 bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 {
 	struct folio *folio;
-- 
2.25.1


