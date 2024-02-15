Return-Path: <linux-kernel+bounces-67120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09398566AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2196BB27ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678013472B;
	Thu, 15 Feb 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bXdgcbXm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08344132497
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008983; cv=none; b=MLcjUsCFfsUg8dO5uRhmRX2kK5KIlPtfb7MwE2lXlmLBozXUdwVRwVwDmyRtlHxGtulaqWjQfVdpZojyccSDfT0hp8xsOXQAiLEBApnDRIoSzp3ryLlifpfv0GC3ZZGA5BE4W43FBpBYNHxRztaUpY2JhER1pYEYD3GNcmBqRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008983; c=relaxed/simple;
	bh=N8bLCyldXfcu6rWJgUWRn6bFNyDC7DDiecstrCMhz7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7MQ4bHvyJGro/umkoRPeBiBriv8AhDUu43zg7Kjmfp8d8xvWoeSeU91oDzX+NyRjwLuTvN7fAhr2pqQypFMnwLxiVQ3Bgiq5Qve53EF4Jp7ndqCtylba+iF+IsLd5O6yjs1soUB/jxQ9ieYdubhq5loE7/4QnplqQOVEeJfyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bXdgcbXm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso177486566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008979; x=1708613779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAAfduKncyIlO7bGb0H7B4KC/vDoZlMcbrTq+YqBvns=;
        b=bXdgcbXm2n3oX8TUttKWJmL5Dk9SPeNr5ntESwuuxJ3CGRdOckXD2uO4LEaEUQEPlC
         feMvXSSmoCip6mhmcCZYfB8sXK0ovph0USs7D+eaaXhTqe+apzzkCPV7eMhf03V/atSM
         VRa7249z5O/jC+FBX8olz4F/Icg5r+hYPLzDpKzoVMitdFo6gwEi9AAiP3tJVWCF4b1j
         5E2sAc2rjJ8FCOSY5dxFQj62ll4qR/jVKSc3YcCYtrGTrBVRJQgyt27rjctLNJ7VVbLB
         WDXZocHToTir36EVmfmIrEP5fgq1X/iovpaKOIB3D/3aXS5H3P8eTAeGYV2FlPePTPWP
         UCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008979; x=1708613779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAAfduKncyIlO7bGb0H7B4KC/vDoZlMcbrTq+YqBvns=;
        b=sC+IdWjkom2ZkUxJiGpZKegq8iKWm0qG3NCMy4AVipS12FliZCZ4ZujC5xQ/okRRok
         ZhZ278hRBstWJESadJoJjKXhMQYuNUP7ydTte6JsDRgnKjN+ZZio2+GG5hWyRxKm38gd
         PnUoRNHtBmR2ORwabXqaKz9H3tWivjeFmXxTS7i/bG3tG32HatMRI4/z0YEzwjrImwNh
         6UTHIqNS94RVasbbXocIPyw3DwYHc7scDdmg8ptmZ1471xwnuvAUh2+HRw2FZa7Xsclf
         e30V/FZAvGm5h2lz1Jk24o5r/DDa1p61/qWUgPPvA+6TgscnhjjoUFM7s6lrxjZydtXx
         qkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKzzQmwcuKzsrKx3Ex9sZExYMib1TiRVXB5uVE/W0hgmy+xAfvM6DRAd2AXSBBiHhS5+oKQQNlSwCk+lHIHMjfnQDtEnkrWxvxFiiL
X-Gm-Message-State: AOJu0Yxdr57A9j5KEYn41kACSIdHIsd4JOTvTXsT4PirDDfXvZuhs/lx
	+Xz3FHGCNjeMAqtC3PiDK/RIVlAjamUbJ/U8+Uut5I1QytlZSpZTUMg+D2CLK40=
X-Google-Smtp-Source: AGHT+IGigQj7ZTNu10ittsrAOmrJ2ArDckgllGOZzKGW4cyupgYSflwee8ZSNNYlHtvPBt42rJjGYg==
X-Received: by 2002:a17:906:3e11:b0:a3c:2c8e:9030 with SMTP id k17-20020a1709063e1100b00a3c2c8e9030mr4707897eji.6.1708008979244;
        Thu, 15 Feb 2024 06:56:19 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:19 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 09/14] linux/mm.h: move usage count functions to mm/page_usage.h
Date: Thu, 15 Feb 2024 15:55:57 +0100
Message-Id: <20240215145602.1371274-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215145602.1371274-1-max.kellermann@ionos.com>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to reduce dependencies in linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 168 +-------------------------------
 include/linux/mm/page_usage.h | 177 ++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 167 deletions(-)
 create mode 100644 include/linux/mm/page_usage.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb2dd71e2940..26d506ed855f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -6,6 +6,7 @@
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/page_size.h>
+#include <linux/mm/page_usage.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1053,51 +1054,6 @@ struct inode;
 
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
@@ -1253,8 +1209,6 @@ static inline struct folio *virt_to_folio(const void *x)
 	return page_folio(page);
 }
 
-void __folio_put(struct folio *folio);
-
 void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
@@ -1345,126 +1299,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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
diff --git a/include/linux/mm/page_usage.h b/include/linux/mm/page_usage.h
new file mode 100644
index 000000000000..53015e28b5df
--- /dev/null
+++ b/include/linux/mm/page_usage.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_USAGE_H
+#define _LINUX_MM_PAGE_USAGE_H
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
+#endif /* _LINUX_MM_PAGE_USAGE_H */
-- 
2.39.2


