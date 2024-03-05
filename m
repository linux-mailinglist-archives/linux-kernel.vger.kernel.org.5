Return-Path: <linux-kernel+bounces-91942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD858718D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676BA280EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F156471;
	Tue,  5 Mar 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="i4KoDULJ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946A50246
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629189; cv=none; b=CeXDmEQBb6WGuN8I8Px1zaJqRCtrRxhDbklfeujMjWtvLjLRkAEs3QsELImrPS3eOMUX9BPYWepehc9rKnIjOEVRsSbip/9g0DKU1lyiVt0OriQumq29QzhHo0Or6ZexVB7yhQ3Z8GIlKj+vgWZrhX3RZJnUlfD9v+LVY0CasIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629189; c=relaxed/simple;
	bh=EQUfjee+ktFtbPacxxVNShczG8NOQAbKrjDXd0cHtHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGr30Zxh5qlz3xpeIqxUBVC3InSizmmLQPRzgKm1nO+uR8RkCzipTKSwBWhEiqg4Ez9p9ZD291qn2/jc/z0aSVUQOIb3LigafZvzUo2D78qISut96wtOU7K1Qg4umrGbIGCYaS/QYC/VNKqbbUJbRUesN7FiO6C3wDhyWWlwNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=i4KoDULJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d3ee1c9ea9so7065061fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629185; x=1710233985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cowoIpweWt3L2bjBHT1kUeTpunMOhbiTNwgqFnKsuAs=;
        b=i4KoDULJGF1TugeIqJW3swhK3Dt1P6VvURV3h03c2V143ALkPJt1cJzjumZrlRyK3B
         IFe5uAd2T6+KV9iIiB3wwglMH7gkex4ZEKW6EhdWx/77OaWNUyTFFc4kX3db3hFDlOKA
         HneXQeElUfSgVXmHzMfyEXhA6Cdufvr5vxCmPQ7E0PcgOTB1vwoH5H/OoXztmbatFOGl
         GwZB88p2LUCfxEWfdd2FgI2UovLfny7mJft1VBiC9NKTwqjZcnMGaDa9xty+mzMpsyws
         THUiWvYV9gOdydPyv2JcNlX0yHWQlYOOhu2/IJYOyMVuW56armUSXko4LHM0nOuAn6dY
         Lbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629185; x=1710233985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cowoIpweWt3L2bjBHT1kUeTpunMOhbiTNwgqFnKsuAs=;
        b=vcx3+NBf3+9rTS2BUB5SmhSknbkr0s5jQlYWeqnuvshVbIbyJiW4QUYQPDztCc1XJl
         MEfrsK2AszjZorF3LFFgMVmSrNfL8cAU9pfNTNhRMKtaCdeuw8/2Ub5/tCyZy8qfhUu0
         g5aDNLNJmKC/9dw/+Vmyuv1u+z+MArd5dQaxQb77KTCVvLnRLcQN+v/+IAas2vGQ2v3t
         stTUnjsAtjIBmuwKEfz/eIt/Ln9xqbpk0urS/f5B+af8KZhX9xRn4fdGxNOYlHFd1Z6w
         IbI4cEeF9kXNMyELSsf1QcBeJXSdnk3Ld3yE3/GUZUhZSJ5BgE681CdGPfRQVXIGmKEm
         B9GA==
X-Forwarded-Encrypted: i=1; AJvYcCWsGbVhKWYawzhgO2jLJzHb//HOzw9U5kgGqUmdREI37CdZ6MpsCpYdQ0hJqph0CF6eBDupH0wBiJKMUXUpco4dIef9hak54QWW2NGw
X-Gm-Message-State: AOJu0Yw1UcLmMlqhUdZ8SQcHUhlTUwFsT+KnpGTvTbpZajv84rb2UUgA
	X57zQqdGq7RZXCRM0xp1kLW4Z09cWbZrvme9WtD3QP61gRuXLZ1f8vlapNsy8j0=
X-Google-Smtp-Source: AGHT+IGKngCTmPmeb81IUjSVUV+bTdylSFgdpzvBNEX+ZfYgXiwTu8YQIgQN2zwEsxNYEM8vJK3Vuw==
X-Received: by 2002:a05:6512:1152:b0:513:5203:e255 with SMTP id m18-20020a056512115200b005135203e255mr793839lfg.7.1709629184681;
        Tue, 05 Mar 2024 00:59:44 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:44 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 09/14] linux/mm.h: move usage count functions to mm/folio_usage.h
Date: Tue,  5 Mar 2024 09:59:14 +0100
Message-Id: <20240305085919.1601395-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305085919.1601395-1-max.kellermann@ionos.com>
References: <20240305085919.1601395-1-max.kellermann@ionos.com>
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
index 61f1312a626e..e8a914e7bebd 100644
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
@@ -1073,51 +1073,6 @@ struct inode;
 
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
@@ -1266,8 +1221,6 @@ static inline struct folio *virt_to_folio(const void *x)
 	return page_folio(page);
 }
 
-void __folio_put(struct folio *folio);
-
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
@@ -1358,129 +1311,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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
index 000000000000..4a7e9cd74909
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
+	if (put_devmap_managed_page(&folio->page))
+		return;
+	folio_put(folio);
+}
+
+#endif /* _LINUX_MM_FOLIO_USAGE_H */
-- 
2.39.2


