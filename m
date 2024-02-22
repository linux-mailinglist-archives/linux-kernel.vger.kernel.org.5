Return-Path: <linux-kernel+bounces-76457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588BE85F782
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF5282EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA74D108;
	Thu, 22 Feb 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KjzHQ1Ba"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682834CB35
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602675; cv=none; b=CW4hMFr3NN3/9ThApmlFEbYRBhyvLbZwQT0j5ZlZ9KNnpmKyElF3i1TvI65bcq83uDKJZ9dz800GfVLi4HXrreZUFw9zU0IOv/B9V1P8zyutgDRzYE6JYomRt6wcxumdbbaeT7YAVQ2nOHP6Q3VQs1dD21GxPDhL5wNYZegNndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602675; c=relaxed/simple;
	bh=H98XR5ehGdkw5G5ubT2gWgECqnXtNMZuxsZ6WMDIYgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzWUiyY/4zFoShL2F/hwqpr/fBDVhj874PX0RGLNEdo4Knhf0B7YKFH+8rM1i0ozyWVLvR4mfjGAclfvAyA28wjSqi8bNIfkrC8Rbrq51owUXudUF1MLWI7RXdF+P6l2XeQPkpN0J9MA+zcO3rS0onbCkvoDh67BoswhlxKt6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KjzHQ1Ba; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512be6fda52so4879887e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602670; x=1709207470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kLoKUxPzCv4au/TRObsd9V3UzJrpdaiZFCw0biA2LU=;
        b=KjzHQ1BaUI8bHKThNpR+jBdPqYbXUvuLP98kFxxC2JaCn3+Vgnx4z1PH/kT+YaLMVS
         sZceJdGG/7IBoMkXmrf72oHpZCPJYOFRlhUgIAX5WEbEAZB8JsTs5giBL3dSzGsHV/8J
         /ddg/dsrAKMZE0+6aIYNW+aMSDhbSp4yvI7EjLBmnEWMthSBFKGrfpbakShMCOoIiW5u
         mJcSdANPA2i1Vm7Gzl19BZu2bSpfgxKkYFrWXpLgoMzW3wWVPjbBP4vRUO1y2bOUIrsN
         kdYO3pJa/5xnuzRaRvs7ROZ2OvQW0v1CvAzJ8foKv5ITM2B5L6CSL/0ZCfbTTLylPf9V
         WupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602670; x=1709207470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kLoKUxPzCv4au/TRObsd9V3UzJrpdaiZFCw0biA2LU=;
        b=B0hcjDsynp2ZT7dRjVFQudsWhknmVLUyCiK7vWXwEypyvFJ4IwKYbi15+/m1FxG5Wx
         FfOk/W/+o4n+wvh7+4aBVWf5gt720OnoYIA9QLI1HAzotD9CIwjO2QTKIlGsW6mlPRmb
         egQ21dXZUVdggRzEXMNz3sUdiAJV4QKZo8ng+W6It+H4bHcDjTbzQWZs85uPVQ7iAl7j
         /KaYKn4YWcZIVV+W0k64PkJ4VWIpYE+iYmtxwU5MhfheCg3fDl7KZ6aYn/LGDRt1Rtgm
         dwfIL7ODoTEPvI4Ny0arO/QYpwZGQAS/VXHAODS5k/yPcvyC7/C4ON5UScjFS+d2Dv0p
         fXgw==
X-Forwarded-Encrypted: i=1; AJvYcCWgPiiEfH/e2kB424ey6YwimVcYnYEY2JjbENuJCP6xADIowSlW8cXLGCdP5rY/U/KuBspjXlQsXd5c4Bm8OGKQk3TiJ7JkdObJhIYO
X-Gm-Message-State: AOJu0YxOJ7uuBAbx+p6wfku+6kz0NJKFlDJ/yjGrxOilEtVgZbMAjjDH
	tA+vY4CLrF/ruszsC6vjJSQEepuR3n/U0DlMwjOvVEtHQeH5bOhfEt01UK3Ua1U=
X-Google-Smtp-Source: AGHT+IG3KNwxLKO2NUP+qJu3NUWgqMuYFxpFclvxLFDRnLhVWht5yaKDXfsrMiBDlo2H+wUtOyr1eA==
X-Received: by 2002:a19:ac03:0:b0:512:beb3:7070 with SMTP id g3-20020a19ac03000000b00512beb37070mr5896813lfc.59.1708602670390;
        Thu, 22 Feb 2024 03:51:10 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:09 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 09/14] linux/mm.h: move usage count functions to mm/folio_usage.h
Date: Thu, 22 Feb 2024 12:50:50 +0100
Message-Id: <20240222115055.1172877-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222115055.1172877-1-max.kellermann@ionos.com>
References: <20240222115055.1172877-1-max.kellermann@ionos.com>
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
 include/linux/mm.h             | 168 +------------------------------
 include/linux/mm/folio_usage.h | 177 +++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 167 deletions(-)
 create mode 100644 include/linux/mm/folio_usage.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a302da7de24..0dc38017e134 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4,6 +4,7 @@
 
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
+#include <linux/mm/folio_usage.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1058,51 +1059,6 @@ struct inode;
 
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
@@ -1258,8 +1214,6 @@ static inline struct folio *virt_to_folio(const void *x)
 	return page_folio(page);
 }
 
-void __folio_put(struct folio *folio);
-
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
@@ -1350,126 +1304,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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
- * @nr: How many folios there are.
- *
- * Like folio_put(), but for an array of folios.  This is more efficient
- * than writing the loop yourself as it will optimise the locks which
- * need to be taken if the folios are freed.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folios_put(struct folio **folios, unsigned int nr)
-{
-	release_pages(folios, nr);
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
-	if (put_devmap_managed_page(&folio->page))
-		return;
-	folio_put(folio);
-}
-
 /*
  * GUP_PIN_COUNTING_BIAS, and the associated functions that use it, overload
  * the page's refcount so that two separate items are tracked: the original page
diff --git a/include/linux/mm/folio_usage.h b/include/linux/mm/folio_usage.h
new file mode 100644
index 000000000000..2700e2ec4d78
--- /dev/null
+++ b/include/linux/mm/folio_usage.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_USAGE_H
+#define _LINUX_MM_FOLIO_USAGE_H
+
+#include <linux/mm/devmap_managed.h> // for put_devmap_managed_page()
+#include <linux/mmdebug.h> // for VM_BUG_ON_PAGE()
+#include <linux/mm_types.h> // for struct folio
+#include <linux/page_ref.h>
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
+ * @nr: How many folios there are.
+ *
+ * Like folio_put(), but for an array of folios.  This is more efficient
+ * than writing the loop yourself as it will optimise the locks which
+ * need to be taken if the folios are freed.
+ *
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
+ */
+static inline void folios_put(struct folio **folios, unsigned int nr)
+{
+	release_pages(folios, nr);
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
+	if (put_devmap_managed_page(&folio->page))
+		return;
+	folio_put(folio);
+}
+
+#endif /* _LINUX_MM_FOLIO_USAGE_H */
-- 
2.39.2


