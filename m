Return-Path: <linux-kernel+bounces-91938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D728718CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67108B23B99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB89548F7;
	Tue,  5 Mar 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="diy9ABWE"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE352F99
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629184; cv=none; b=lDvaoRC5fBi1XmND8xJbOLu7Mzy1Dm30861xF0ftgMMoQLRa3QtreXXjx886dfsk/ojyp+9FnsUVJLjBHG/wZbCvoJHC+27IqESMXg3/pofVQIwrzUJr2BKT131FYBE7ifgKG2yjLTggqpkfNtjHHHZNova0rUoI68zUMLfn8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629184; c=relaxed/simple;
	bh=oP7Nqn8yuoYUkUvIrSzyGSI4sXVkm22lBDg3rwCJ9kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zfnlt5cWHtMCXmHdLWAvg4ccaqJqJGKnzH4nssRLaVflKAWiuGxNaBaRrAG0f2g9JKu4rsA9ZPYJ9HZgN0J3xLgk+SYyb6QVseAx4fv2GkzqaK1lpHCz1B++tXG3+0IV7qPbt+CqBQ9dDkz/f6aosqYtJyNEREEBHD6P2Zqjr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=diy9ABWE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a450bedffdfso262644366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629181; x=1710233981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOCd08dVcNL3Vsd080U9IACgrN+4/kX0/WIiYLCuiY0=;
        b=diy9ABWEgBK0mLMVE7HtEmQWIP6Dn+Y8F4+OYErmkEpPn41025AKYNQAwf0/779sWn
         q+xyxz1g59ieR2YLZWjiKd9QPi9j0k033JoTGaw3IMcPcFQ4tMW0iIZ6EOSV9XalLy9M
         uJ86HBYslFAzqxc8ofnqLoRTMnNlmO4k1C1r6XHu9fdcpAffMPXp8kv+snAx1gapjDPL
         n9EnenUJUjQ6mn+b4UFEkMyY13hTylbmST7DLl1KrMhSRQrCKqzdbtUiEpHP9KzW/2tz
         l9HDQjTS823YUQ3OARnap3YS4Q3VHNxUJKyaQGqcqTKicnKyAJZmh7P32LoKEFhAxSxS
         xtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629181; x=1710233981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOCd08dVcNL3Vsd080U9IACgrN+4/kX0/WIiYLCuiY0=;
        b=AYHAL9yhZZ8a12fTeU5vHdPffoODmHVpJTqcu5A4OWWy+fuCyhsudsKbFyA9q1Ld0d
         9geutzytBiZtoGYWIor8JOMnF/W6NkkTLKvzUt3B1SyWCNwLKhFW0NNkvmQdfIOw2T1/
         xGreuIbVkJ0lMuvGw5cNoohq0+Vv4kmFJmvnyVjZ4HmVO7LDQJfS7fJu0qGBMJhFt5jd
         R/cVMWskApoSXmmy5VzFVeiJkPe36MUoi7yZUCsAvVaG5j/wdfD/6nSUHj+Uz1ZIN8Sz
         ayGV5QuoBQq5xVwnjHOGdSCWssnt6uhIqFOAvNY4y52eeiBGD64g+DCVPWdGKTP+tGwo
         /dPg==
X-Forwarded-Encrypted: i=1; AJvYcCXGJBZwo1YrzwaMXCGxGgnklCrKd06kkvGFrBB70KWCD9Q8r1GN5/GXeAVL82UqlvKLcMKCqMOA6TnFj9uBCsvaEkaJF2gVhDICqQD+
X-Gm-Message-State: AOJu0Ywsc4NI7kAqt9FotC40mw3xbo3UhpqKUhmtuVi2iwASNyhPrPi3
	63FmljwVIUvnZYvKpgwyRFZ1Agfro+WueIvTLqOpri9qPqOKBkbCeyf7sYg23Yg=
X-Google-Smtp-Source: AGHT+IGqfqDUczGGo3QetAY7OAT6x3XRZvle5Qp1hnV3EYWTVeS5PH/gGnq4+ZcDT1bZzO9ng+chBA==
X-Received: by 2002:a17:906:ca46:b0:a3f:2ef9:598a with SMTP id jx6-20020a170906ca4600b00a3f2ef9598amr7729507ejb.36.1709629180945;
        Tue, 05 Mar 2024 00:59:40 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 06/14] linux/mm.h: move folio_size(), ... to mm/folio_size.h
Date: Tue,  5 Mar 2024 09:59:11 +0100
Message-Id: <20240305085919.1601395-7-max.kellermann@ionos.com>
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
index 713cedc03b88..0d291ff61db3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1068,38 +1069,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
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
@@ -1306,39 +1275,6 @@ unsigned long nr_free_buffer_pages(void);
 
 void destroy_large_folio(struct folio *folio);
 
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
@@ -1979,23 +1915,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #endif
 }
 
-/**
- * folio_nr_pages - The number of pages in the folio.
- * @folio: The folio.
- *
- * Return: A positive power of two.
- */
-static inline long folio_nr_pages(struct folio *folio)
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
@@ -2003,33 +1922,6 @@ static inline long folio_nr_pages(struct folio *folio)
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
@@ -2049,36 +1941,6 @@ static inline struct folio *folio_next(struct folio *folio)
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
  * folio_estimated_sharers - Estimate the number of sharers of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/folio_size.h b/include/linux/mm/folio_size.h
new file mode 100644
index 000000000000..dd8af39ef572
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
+static inline long folio_nr_pages(struct folio *folio)
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


