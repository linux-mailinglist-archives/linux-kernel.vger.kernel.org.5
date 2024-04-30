Return-Path: <linux-kernel+bounces-164274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCC08B7B99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDE61C230F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA317921D;
	Tue, 30 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cRfkZkJo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55560173336
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490996; cv=none; b=FE054R2qQE5FTC7Ixb5iptaIJie2+iGLcjbcbWRu2SmPXX7GfTPEuu5lQeafdBoTkeRexqav4EPEBZd0TWdpciQClJKqYa9DRQaPXVRoxvrnZnC91d2ZnVT0GgF3Z2dgpDftdkiKiwsje+Uvj2cBIXaEumZHgUM0mAEVgywMXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490996; c=relaxed/simple;
	bh=JUuHkGBFjbvJW+sdj/VCHUtZZXabqDjwxCnBGqRixFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InUA4fZREPCiYeMAQR0RH+lO7xQwsfp1nVKoqHubh5R36gtShLumQ1wvXsCucs7o8UoJbbomTQHgrh1prGw9gToGXD+i33V7dqNpt0ihp6WaznHXhHieie3flYBFQ9hMj2sirzzPzLrxKzehwCXFaJBhzlx/SjZxOjw4cTug6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cRfkZkJo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5872b74c44so658990566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490992; x=1715095792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHEADXESNKyxsQ8fI0BRJ8jQ2HgpWucDU2RQJfn4Qzg=;
        b=cRfkZkJocx2s0ceoLpj0uW2d5T7/T8F23VHBFS9KcVvYjJ9euLoDc1OyzmqSJZoXD6
         RId0i5OosPnYbUU6+5eS7+mZZ6IfUhoz3zTlib7CTtYrpfNWrQ/SZ9gSbY90VRNjdR34
         Lvg+GmvlXXuectJRsd0HhK/JcOBRBGgOcNJZaLEuYqAhnpaPhm+FiYUKu3TZagyUSg5t
         HtDVfXRWyQUdONJVaQtgLL9vsojQ1n04XDnFyVlNi/r/0v+s4DUMRRy2FFv16vZ8EuGd
         MsrXMw3V7BlssOkP27UAZ9irSXwAKzoPaHe7y6nA81c5aN6dJjY/8QiO5BPrsUaXopB8
         eX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490992; x=1715095792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHEADXESNKyxsQ8fI0BRJ8jQ2HgpWucDU2RQJfn4Qzg=;
        b=Vpow2GWk/Io95s+MU1e0owCCoOc8UaLXbkh3P7DA33kB2il+rNdPQCXb4XkcrI/GHq
         vH859j6LZ3rSi2mISgTa5Ua0Q09Dmq42aicrHtKJQcxPDTTOg3di4d7IXx8M+y0AdZN+
         BoyPNhsAA9We0jFYPbQo3KbuVqAO/pwqPAvFH0UBLJvnqvLr+ehS3FCwy5cJDnkvcCKi
         pxZCZlls06ag02tGo9NFCJRkCf2F76NOgsfS8zjJPEgSvKEjDbo9BVtSuWstWZVU6p6M
         BvMtfoYoNoeP067wg03Y9uCuvnEMYDsN6QQf7GBtXTrueRbxbyyYNt2iBVuU8L3gcMg8
         ZQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIaja2OkSpmekESSskOiMV9mqTLuddOzvZESGZllFM+u3X0Z0tQUQvM/mHVDBFlb1kGPMJZJAK5zdAkWCo+SLaSrJioU/fehgB43Q
X-Gm-Message-State: AOJu0Yzba/o3CFA+BtoKPWVvQiTIXzF55JvpDExXzN22NSIwWR8PS+UB
	0CjowH1q0rBrNJFguO6gOVa328HkhTHGPZ3YuH2DuTLZ8m8NfHVaCGvWP2zrzlY=
X-Google-Smtp-Source: AGHT+IEPd6SpriBO596E3GI2OlGUcDV6KYMIlhq1sjz10czfW10eudXFYEG0ggW+HoSOpXol/hrTag==
X-Received: by 2002:a17:906:90c:b0:a52:10c8:c4e2 with SMTP id i12-20020a170906090c00b00a5210c8c4e2mr31595ejd.66.1714490992531;
        Tue, 30 Apr 2024 08:29:52 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:52 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 07/15] linux/mm.h: move folio_size(), ... to mm/folio_size.h
Date: Tue, 30 Apr 2024 17:29:23 +0200
Message-Id: <20240430152931.1137975-8-max.kellermann@ionos.com>
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

folio_size()/page_size() are used by the following popular headers:

- linux/highmem.h
- linux/iov_iter.h
- linux/pagemap.h

Moving them to a separate lean header will allow us to avoid the
dependency on linux/mm.h.  Additionally, it allows us to move
folio_next() to a separate header, because it needs folio_nr_pages()
which is also moved to folio_size.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 140 +------------------------------
 include/linux/mm/folio_size.h | 150 ++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 139 deletions(-)
 create mode 100644 include/linux/mm/folio_size.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0dea734194aa..d5019aed8330 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1069,38 +1070,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
-/*
- * compound_order() can be called without holding a reference, which means
- * that niceties like page_folio() don't work.  These callers should be
- * prepared to handle wild return values.  For example, PG_head may be
- * set before the order is initialised, or this may be a tail page.
- * See compaction.c for some good examples.
- */
-static inline unsigned int compound_order(struct page *page)
-{
-	struct folio *folio = (struct folio *)page;
-
-	if (!test_bit(PG_head, &folio->flags))
-		return 0;
-	return folio->_flags_1 & 0xff;
-}
-
-/**
- * folio_order - The allocation order of a folio.
- * @folio: The folio.
- *
- * A folio is composed of 2^order pages.  See get_order() for the definition
- * of order.
- *
- * Return: The order of the folio.
- */
-static inline unsigned int folio_order(struct folio *folio)
-{
-	if (!folio_test_large(folio))
-		return 0;
-	return folio->_flags_1 & 0xff;
-}
-
 #include <linux/huge_mm.h>
 
 /*
@@ -1313,39 +1282,6 @@ void folio_copy(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
-/* Returns the number of bytes in this potentially compound page. */
-static inline unsigned long page_size(struct page *page)
-{
-	return PAGE_SIZE << compound_order(page);
-}
-
-/* Returns the number of bits needed for the number of bytes in a page */
-static inline unsigned int page_shift(struct page *page)
-{
-	return PAGE_SHIFT + compound_order(page);
-}
-
-/**
- * thp_order - Order of a transparent huge page.
- * @page: Head page of a transparent huge page.
- */
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return compound_order(page);
-}
-
-/**
- * thp_size - Size of a transparent huge page.
- * @page: Head page of a transparent huge page.
- *
- * Return: Number of bytes in this page.
- */
-static inline unsigned long thp_size(struct page *page)
-{
-	return PAGE_SIZE << thp_order(page);
-}
-
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
@@ -1981,23 +1917,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #endif
 }
 
-/**
- * folio_nr_pages - The number of pages in the folio.
- * @folio: The folio.
- *
- * Return: A positive power of two.
- */
-static inline long folio_nr_pages(const struct folio *folio)
-{
-	if (!folio_test_large(folio))
-		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << (folio->_flags_1 & 0xff);
-#endif
-}
-
 /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 #define MAX_FOLIO_NR_PAGES	(1UL << PUD_ORDER)
@@ -2005,33 +1924,6 @@ static inline long folio_nr_pages(const struct folio *folio)
 #define MAX_FOLIO_NR_PAGES	MAX_ORDER_NR_PAGES
 #endif
 
-/*
- * compound_nr() returns the number of pages in this potentially compound
- * page.  compound_nr() can be called on a tail page, and is defined to
- * return 1 in that case.
- */
-static inline unsigned long compound_nr(struct page *page)
-{
-	struct folio *folio = (struct folio *)page;
-
-	if (!test_bit(PG_head, &folio->flags))
-		return 1;
-#ifdef CONFIG_64BIT
-	return folio->_folio_nr_pages;
-#else
-	return 1L << (folio->_flags_1 & 0xff);
-#endif
-}
-
-/**
- * thp_nr_pages - The number of regular pages in this huge page.
- * @page: The head page of a huge page.
- */
-static inline int thp_nr_pages(struct page *page)
-{
-	return folio_nr_pages((struct folio *)page);
-}
-
 /**
  * folio_next - Move to the next physical folio.
  * @folio: The folio we're currently operating on.
@@ -2051,36 +1943,6 @@ static inline struct folio *folio_next(struct folio *folio)
 	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
 }
 
-/**
- * folio_shift - The size of the memory described by this folio.
- * @folio: The folio.
- *
- * A folio represents a number of bytes which is a power-of-two in size.
- * This function tells you which power-of-two the folio is.  See also
- * folio_size() and folio_order().
- *
- * Context: The caller should have a reference on the folio to prevent
- * it from being split.  It is not necessary for the folio to be locked.
- * Return: The base-2 logarithm of the size of this folio.
- */
-static inline unsigned int folio_shift(struct folio *folio)
-{
-	return PAGE_SHIFT + folio_order(folio);
-}
-
-/**
- * folio_size - The number of bytes in a folio.
- * @folio: The folio.
- *
- * Context: The caller should have a reference on the folio to prevent
- * it from being split.  It is not necessary for the folio to be locked.
- * Return: The number of bytes in this folio.
- */
-static inline size_t folio_size(struct folio *folio)
-{
-	return PAGE_SIZE << folio_order(folio);
-}
-
 /**
  * folio_likely_mapped_shared - Estimate if the folio is mapped into the page
  *				tables of more than one MM
diff --git a/include/linux/mm/folio_size.h b/include/linux/mm/folio_size.h
new file mode 100644
index 000000000000..e7cd567cf069
--- /dev/null
+++ b/include/linux/mm/folio_size.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_SIZE_H
+#define _LINUX_MM_FOLIO_SIZE_H
+
+#include <linux/bitops.h> // for test_bit()
+#include <linux/mmdebug.h> // for VM_BUG_ON_PGFLAGS()
+#include <linux/mm_types.h> // for struct page
+#include <linux/page-flags.h> // for folio_test_large()
+#include <asm/page.h> // for PAGE_SIZE, PAGE_SHIFT
+
+/*
+ * compound_order() can be called without holding a reference, which means
+ * that niceties like page_folio() don't work.  These callers should be
+ * prepared to handle wild return values.  For example, PG_head may be
+ * set before the order is initialised, or this may be a tail page.
+ * See compaction.c for some good examples.
+ */
+static inline unsigned int compound_order(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	if (!test_bit(PG_head, &folio->flags))
+		return 0;
+	return folio->_flags_1 & 0xff;
+}
+
+/**
+ * folio_order - The allocation order of a folio.
+ * @folio: The folio.
+ *
+ * A folio is composed of 2^order pages.  See get_order() for the definition
+ * of order.
+ *
+ * Return: The order of the folio.
+ */
+static inline unsigned int folio_order(struct folio *folio)
+{
+	if (!folio_test_large(folio))
+		return 0;
+	return folio->_flags_1 & 0xff;
+}
+
+/* Returns the number of bytes in this potentially compound page. */
+static inline unsigned long page_size(struct page *page)
+{
+	return PAGE_SIZE << compound_order(page);
+}
+
+/* Returns the number of bits needed for the number of bytes in a page */
+static inline unsigned int page_shift(struct page *page)
+{
+	return PAGE_SHIFT + compound_order(page);
+}
+
+/**
+ * thp_order - Order of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ */
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return compound_order(page);
+}
+
+/**
+ * thp_size - Size of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ *
+ * Return: Number of bytes in this page.
+ */
+static inline unsigned long thp_size(struct page *page)
+{
+	return PAGE_SIZE << thp_order(page);
+}
+
+/**
+ * folio_nr_pages - The number of pages in the folio.
+ * @folio: The folio.
+ *
+ * Return: A positive power of two.
+ */
+static inline long folio_nr_pages(const struct folio *folio)
+{
+	if (!folio_test_large(folio))
+		return 1;
+#ifdef CONFIG_64BIT
+	return folio->_folio_nr_pages;
+#else
+	return 1L << (folio->_flags_1 & 0xff);
+#endif
+}
+
+/*
+ * compound_nr() returns the number of pages in this potentially compound
+ * page.  compound_nr() can be called on a tail page, and is defined to
+ * return 1 in that case.
+ */
+static inline unsigned long compound_nr(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	if (!test_bit(PG_head, &folio->flags))
+		return 1;
+#ifdef CONFIG_64BIT
+	return folio->_folio_nr_pages;
+#else
+	return 1L << (folio->_flags_1 & 0xff);
+#endif
+}
+
+/**
+ * thp_nr_pages - The number of regular pages in this huge page.
+ * @page: The head page of a huge page.
+ */
+static inline int thp_nr_pages(struct page *page)
+{
+	return folio_nr_pages((struct folio *)page);
+}
+
+/**
+ * folio_shift - The size of the memory described by this folio.
+ * @folio: The folio.
+ *
+ * A folio represents a number of bytes which is a power-of-two in size.
+ * This function tells you which power-of-two the folio is.  See also
+ * folio_size() and folio_order().
+ *
+ * Context: The caller should have a reference on the folio to prevent
+ * it from being split.  It is not necessary for the folio to be locked.
+ * Return: The base-2 logarithm of the size of this folio.
+ */
+static inline unsigned int folio_shift(struct folio *folio)
+{
+	return PAGE_SHIFT + folio_order(folio);
+}
+
+/**
+ * folio_size - The number of bytes in a folio.
+ * @folio: The folio.
+ *
+ * Context: The caller should have a reference on the folio to prevent
+ * it from being split.  It is not necessary for the folio to be locked.
+ * Return: The number of bytes in this folio.
+ */
+static inline size_t folio_size(struct folio *folio)
+{
+	return PAGE_SIZE << folio_order(folio);
+}
+
+#endif /* _LINUX_MM_FOLIO_SIZE_H_H */
-- 
2.39.2


