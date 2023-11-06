Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D67E2DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjKFUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjKFULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:11:45 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D310C4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:11:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8UoFAswFgd+L4wk44THWP2F8PtTdf8hA2eur1Xmylc=;
        b=nqNu/iJtTBpRGoCOjf1lL74liuMLk3YhpzpUWzj3S+HMg+GQeM+EOVnxft+z4OPpPQbPuS
        Udqa+ZKx2NChvvQUHxkJu+aUnZoO5Chyi4YdPGofo1DOrNugA3NlPhfyyz2+pR+R6ojuqt
        30m2oaGb1ReuPP6HOsDoxxp4rcV7+Ok=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH RFC 07/20] kasan: introduce kasan_mempool_unpoison_pages
Date:   Mon,  6 Nov 2023 21:10:16 +0100
Message-Id: <573ab13b08f2e13d8add349c3a3900bcb7d79680.1699297309.git.andreyknvl@google.com>
In-Reply-To: <cover.1699297309.git.andreyknvl@google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 9ccc78b20cf2..6283f0206ef6 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -439,6 +439,12 @@ bool __kasan_mempool_poison_pages(struct page *page, unsigned int order,
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

