Return-Path: <linux-kernel+bounces-164277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499618B7BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30181F24E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816017BB18;
	Tue, 30 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fXOdTypW"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481F175579
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490999; cv=none; b=pngOWPHHikUJ+TANMQIgebKbS48o7y6wb0ZQ6rA17JBAl/OzYE4tm2NINfCLefKO/PfQAiYSWIepm8o4xicyJiPKnxUzTyBc6c2TnzfMgS04lm7lzYOfB4zE8+v2Rw8R77uju/apj98dGnG9f6QLQ05goAKfnGp00yxKMQbNzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490999; c=relaxed/simple;
	bh=QeOThma+C+xVBPv/VbtaPx4QYbN7GGFCVewQ4gi5YFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvMNCjLQF5NvGF3lU5dEjUBbLyevRiKw+9fFY7jiMyhRo6MkbLcFBXrSsX3/MzrrKMTZISz1F+zvUVWIIgQrX05QFtVl2vAxRFdszE5aUOc/Oj/83isgDG5+M4EJbJWXLJOeLDUKGpJGDMtKq9BzDUcVTRMhbFz6KD97IYFlLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fXOdTypW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so6096906a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490995; x=1715095795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALyXA1N3h50IKuqnW6AM7h0jqplMyLOr0C50l7ESkJs=;
        b=fXOdTypWZxurfiOPVBXlulquMiCaHjqEwRVfWpNp9RvDM8m2m1NdAHfje94SvyHqr+
         OvW+5TyuCJPjQ3BiP4w+lYSm7Op2AB5wSd20r1JGmJ54Y72jmDNCwdNhs7L5u093tsV1
         d3VCczL/KW1o9hFweXeLiKWxKgAviTzF/FyqwBHfpcCVVxjOVURb87Cn5YrmuR+BgeGT
         Xbos+XCuYxvVDOEh4PP48kQl8/8WtcV2/lPb6zQqGw4FKhLYebpxuihbLK/eyf6uL5Gp
         wh57Rx+DSfKnRQOZxzc8x2sNbCz5pgrqA5/oHha5mNTe9GtGqo8yKRbifhVC/L0xXam+
         qqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490995; x=1715095795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALyXA1N3h50IKuqnW6AM7h0jqplMyLOr0C50l7ESkJs=;
        b=GWq41O2rVN6JWddUB8oL93gVLZPo9ZiA8NjhDvaoyt04fMDEhKBqIYOD+oCBQ5mwww
         i7UEBFYscf7KQoypXcDDOIQIVImf19qOk4npWmDGSdR3uu6w8pSYxFE1bBWLitb9TRTS
         ot+WC0GEtByluIr9NdkVp7+5SuYpGFw5e55K2WGCHCxhmdRipK15fIF2J+TXxoJsW0Js
         noRCjB2g35AKjv4laAlt7UClSjH8Sr4zQIJOzCsZFCRJGGYPcewIZckbiHGRiNwz/zK+
         vVps9U5ZWU2dtbpFRdOtNwhyhuAe5wUrq8P1szDxw/gNvhfUypxNzO3WzjS9F0Yx8OBv
         HARA==
X-Forwarded-Encrypted: i=1; AJvYcCXpRQAVkl3yZQHhtxEXqUt0BBjjGE9D4rxgwJA/c/FIWu8LDSqxtsfpvrYU4FKGOhedPLOC9l/qAEJkv7TfZduugOZ9LmjXafkdg+kg
X-Gm-Message-State: AOJu0YznE+GVEEZRxv3dM6WPAsIRXxO4bCt+07LtVU3LghHB3OM0O3Nx
	khFefWZduQvsHENC9PEW2zHY96XVeIi/7n+IqPxvQDtG9x/iNu5GLIaN6SXDmu0=
X-Google-Smtp-Source: AGHT+IHqBTFz+UP3YE82nUBzLxtPLQ9un5u8zgG1Mp92ayvUtgncZZIZcrkoH7klkj1PEiHND+OAgA==
X-Received: by 2002:a17:906:3555:b0:a58:e9ef:5e47 with SMTP id s21-20020a170906355500b00a58e9ef5e47mr33246eja.63.1714490994716;
        Tue, 30 Apr 2024 08:29:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 10/15] linux/mm.h: move usage count functions to mm/folio_usage.h
Date: Tue, 30 Apr 2024 17:29:26 +0200
Message-Id: <20240430152931.1137975-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430152931.1137975-1-max.kellermann@ionos.com>
References: <20240430152931.1137975-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to reduce dependencies on linux/mm.h.

This new header contains wrappers for the low-level functions from
page_ref.h.  By having those higher-level functions in a separate
header, we can avoid their additional dependencies in the page_ref.h.

Having these in a separate header will allow eliminating the
dependency on linux/mm.h from these headers:

- linux/skbuff.h
- linux/swap.h

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h             | 172 +------------------------------
 include/linux/mm/folio_usage.h | 182 +++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+), 171 deletions(-)
 create mode 100644 include/linux/mm/folio_usage.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9539ba12b99d..035e56e203df 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,9 +2,9 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
-#include <linux/mm/devmap_managed.h>
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
+#include <linux/mm/folio_usage.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1074,51 +1074,6 @@ struct inode;
 
 #include <linux/huge_mm.h>
 
-/*
- * Methods to modify the page usage count.
- *
- * What counts for a page usage:
- * - cache mapping   (page->mapping)
- * - private data    (page->private)
- * - page mapped in a task's page tables, each mapping
- *   is counted separately
- *
- * Also, many kernel routines increase the page count before a critical
- * routine so they can be sure the page doesn't go away from under them.
- */
-
-/*
- * Drop a ref, return true if the refcount fell to zero (the page has no users)
- */
-static inline int put_page_testzero(struct page *page)
-{
-	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-	return page_ref_dec_and_test(page);
-}
-
-static inline int folio_put_testzero(struct folio *folio)
-{
-	return put_page_testzero(&folio->page);
-}
-
-/*
- * Try to grab a ref unless the page has a refcount of zero, return false if
- * that is the case.
- * This can be called when MMU is off so it must not access
- * any of the virtual mappings.
- */
-static inline bool get_page_unless_zero(struct page *page)
-{
-	return page_ref_add_unless(page, 1, 0);
-}
-
-static inline struct folio *folio_get_nontail_page(struct page *page)
-{
-	if (unlikely(!get_page_unless_zero(page)))
-		return NULL;
-	return (struct folio *)page;
-}
-
 extern int page_is_ram(unsigned long pfn);
 
 enum {
@@ -1275,8 +1230,6 @@ static inline struct folio *virt_to_folio(const void *x)
 	return page_folio(page);
 }
 
-void __folio_put(struct folio *folio);
-
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
@@ -1365,129 +1318,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-/* 127: arbitrary random number, small enough to assemble well */
-#define folio_ref_zero_or_close_to_overflow(folio) \
-	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
-
-/**
- * folio_get - Increment the reference count on a folio.
- * @folio: The folio.
- *
- * Context: May be called in any context, as long as you know that
- * you have a refcount on the folio.  If you do not already have one,
- * folio_try_get() may be the right interface for you to use.
- */
-static inline void folio_get(struct folio *folio)
-{
-	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
-	folio_ref_inc(folio);
-}
-
-static inline void get_page(struct page *page)
-{
-	folio_get(page_folio(page));
-}
-
-static inline __must_check bool try_get_page(struct page *page)
-{
-	page = compound_head(page);
-	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
-		return false;
-	page_ref_inc(page);
-	return true;
-}
-
-/**
- * folio_put - Decrement the reference count on a folio.
- * @folio: The folio.
- *
- * If the folio's reference count reaches zero, the memory will be
- * released back to the page allocator and may be used by another
- * allocation immediately.  Do not access the memory or the struct folio
- * after calling folio_put() unless you can be sure that it wasn't the
- * last reference.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folio_put(struct folio *folio)
-{
-	if (folio_put_testzero(folio))
-		__folio_put(folio);
-}
-
-/**
- * folio_put_refs - Reduce the reference count on a folio.
- * @folio: The folio.
- * @refs: The amount to subtract from the folio's reference count.
- *
- * If the folio's reference count reaches zero, the memory will be
- * released back to the page allocator and may be used by another
- * allocation immediately.  Do not access the memory or the struct folio
- * after calling folio_put_refs() unless you can be sure that these weren't
- * the last references.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folio_put_refs(struct folio *folio, int refs)
-{
-	if (folio_ref_sub_and_test(folio, refs))
-		__folio_put(folio);
-}
-
-void folios_put_refs(struct folio_batch *folios, unsigned int *refs);
-
-/*
- * union release_pages_arg - an array of pages or folios
- *
- * release_pages() releases a simple array of multiple pages, and
- * accepts various different forms of said page array: either
- * a regular old boring array of pages, an array of folios, or
- * an array of encoded page pointers.
- *
- * The transparent union syntax for this kind of "any of these
- * argument types" is all kinds of ugly, so look away.
- */
-typedef union {
-	struct page **pages;
-	struct folio **folios;
-	struct encoded_page **encoded_pages;
-} release_pages_arg __attribute__ ((__transparent_union__));
-
-void release_pages(release_pages_arg, int nr);
-
-/**
- * folios_put - Decrement the reference count on an array of folios.
- * @folios: The folios.
- *
- * Like folio_put(), but for a batch of folios.  This is more efficient
- * than writing the loop yourself as it will optimise the locks which need
- * to be taken if the folios are freed.  The folios batch is returned
- * empty and ready to be reused for another batch; there is no need to
- * reinitialise it.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folios_put(struct folio_batch *folios)
-{
-	folios_put_refs(folios, NULL);
-}
-
-static inline void put_page(struct page *page)
-{
-	struct folio *folio = page_folio(page);
-
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_folio_refs(folio, 1))
-		return;
-	folio_put(folio);
-}
-
 /*
  * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
  * the page's refcount so that two separate items are tracked: the original page
diff --git a/include/linux/mm/folio_usage.h b/include/linux/mm/folio_usage.h
new file mode 100644
index 000000000000..1cf11ca1f5ab
--- /dev/null
+++ b/include/linux/mm/folio_usage.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_USAGE_H
+#define _LINUX_MM_FOLIO_USAGE_H
+
+#include <linux/mm/devmap_managed.h> // for put_devmap_managed_page()
+#include <linux/mmdebug.h> // for VM_BUG_ON_PAGE()
+#include <linux/mm_types.h> // for struct folio
+#include <linux/page_ref.h>
+
+struct folio_batch;
+
+/*
+ * Methods to modify the page usage count.
+ *
+ * What counts for a page usage:
+ * - cache mapping   (page->mapping)
+ * - private data    (page->private)
+ * - page mapped in a task's page tables, each mapping
+ *   is counted separately
+ *
+ * Also, many kernel routines increase the page count before a critical
+ * routine so they can be sure the page doesn't go away from under them.
+ */
+
+/*
+ * Drop a ref, return true if the refcount fell to zero (the page has no users)
+ */
+static inline int put_page_testzero(struct page *page)
+{
+	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
+	return page_ref_dec_and_test(page);
+}
+
+static inline int folio_put_testzero(struct folio *folio)
+{
+	return put_page_testzero(&folio->page);
+}
+
+/*
+ * Try to grab a ref unless the page has a refcount of zero, return false if
+ * that is the case.
+ * This can be called when MMU is off so it must not access
+ * any of the virtual mappings.
+ */
+static inline bool get_page_unless_zero(struct page *page)
+{
+	return page_ref_add_unless(page, 1, 0);
+}
+
+static inline struct folio *folio_get_nontail_page(struct page *page)
+{
+	if (unlikely(!get_page_unless_zero(page)))
+		return NULL;
+	return (struct folio *)page;
+}
+
+void __folio_put(struct folio *folio);
+
+/* 127: arbitrary random number, small enough to assemble well */
+#define folio_ref_zero_or_close_to_overflow(folio) \
+	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
+
+/**
+ * folio_get - Increment the reference count on a folio.
+ * @folio: The folio.
+ *
+ * Context: May be called in any context, as long as you know that
+ * you have a refcount on the folio.  If you do not already have one,
+ * folio_try_get() may be the right interface for you to use.
+ */
+static inline void folio_get(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	folio_ref_inc(folio);
+}
+
+static inline void get_page(struct page *page)
+{
+	folio_get(page_folio(page));
+}
+
+static inline __must_check bool try_get_page(struct page *page)
+{
+	page = compound_head(page);
+	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+		return false;
+	page_ref_inc(page);
+	return true;
+}
+
+/**
+ * folio_put - Decrement the reference count on a folio.
+ * @folio: The folio.
+ *
+ * If the folio's reference count reaches zero, the memory will be
+ * released back to the page allocator and may be used by another
+ * allocation immediately.  Do not access the memory or the struct folio
+ * after calling folio_put() unless you can be sure that it wasn't the
+ * last reference.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__folio_put(folio);
+}
+
+/**
+ * folio_put_refs - Reduce the reference count on a folio.
+ * @folio: The folio.
+ * @refs: The amount to subtract from the folio's reference count.
+ *
+ * If the folio's reference count reaches zero, the memory will be
+ * released back to the page allocator and may be used by another
+ * allocation immediately.  Do not access the memory or the struct folio
+ * after calling folio_put_refs() unless you can be sure that these weren't
+ * the last references.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folio_put_refs(struct folio *folio, int refs)
+{
+	if (folio_ref_sub_and_test(folio, refs))
+		__folio_put(folio);
+}
+
+void folios_put_refs(struct folio_batch *folios, unsigned int *refs);
+
+/*
+ * union release_pages_arg - an array of pages or folios
+ *
+ * release_pages() releases a simple array of multiple pages, and
+ * accepts various different forms of said page array: either
+ * a regular old boring array of pages, an array of folios, or
+ * an array of encoded page pointers.
+ *
+ * The transparent union syntax for this kind of "any of these
+ * argument types" is all kinds of ugly, so look away.
+ */
+typedef union {
+	struct page **pages;
+	struct folio **folios;
+	struct encoded_page **encoded_pages;
+} release_pages_arg __attribute__ ((__transparent_union__));
+
+void release_pages(release_pages_arg, int nr);
+
+/**
+ * folios_put - Decrement the reference count on an array of folios.
+ * @folios: The folios.
+ *
+ * Like folio_put(), but for a batch of folios.  This is more efficient
+ * than writing the loop yourself as it will optimise the locks which need
+ * to be taken if the folios are freed.  The folios batch is returned
+ * empty and ready to be reused for another batch; there is no need to
+ * reinitialise it.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folios_put(struct folio_batch *folios)
+{
+	folios_put_refs(folios, NULL);
+}
+
+static inline void put_page(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	/*
+	 * For some devmap managed pages we need to catch refcount transition
+	 * from 2 to 1:
+	 */
+	if (put_devmap_managed_folio_refs(folio, 1))
+		return;
+	folio_put(folio);
+}
+
+#endif /* _LINUX_MM_FOLIO_USAGE_H */
-- 
2.39.2


