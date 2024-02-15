Return-Path: <linux-kernel+bounces-67117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851B8566A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4341C22F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B613342A;
	Thu, 15 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FfDMKMPy"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5120B3D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008981; cv=none; b=MSPlgtJk+BfOZkKCvRCjOLuGMW0p1v+q8GHEivHdLHFWlhj9ZaSCDv8MO+hYgbfHGXkE1HcVA8EGaEWNPNjg7G8krCo0/xLuiN3V2H/hC/eDoOC00x0eBIxqIc7zUPfuNoKiR6oHcgzmSA4PImasPR7L/eGF/8J+9fuONLwDWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008981; c=relaxed/simple;
	bh=drH5FwH8zCNJpj9u2jazdf5C6xaBK3OAJ/0s4TdABBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bU1TeTnDPYdMSXDOxLSaYrEnkjl/IWKbk4t9u6t9BLbL8dz98RqGvmmFLJKMnS7uclyHiVFSdxuplgdGceaL9l7omk+mM/q3sMIVSM/pN/z4fxWGi8PKteUwOs/Ljhx3g6wTr6afmUHv4UuRX4s2HfzIpNNaV9ZjQwgtZYx4koY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FfDMKMPy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so184986566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008977; x=1708613777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRdb10/lfp5UXJT3tHF43SuGZ47dFW6seynzctgmvuM=;
        b=FfDMKMPypEH6RDfAyzo+tvrRt4G9ESYzd8gvEiagPBP4ey5WE6UwBdEKElGBrznQvn
         jkx+9Xwp7/Nxgv+FxIIsD6oMBhIDUuIdhgXjzfeVtfoxAJo2yIUEcWKPF/Ac3CXU7+CD
         RhGZInkNhcnnXBTk3y7etyhK6VwreuL/i3IRr6TDLM99vgn7q4053OL0ruvRPPipbBVM
         hR9SRieAK0fL/k9x6Adk9FTfu+9NsEVV04HgZc0yjnUP7WUUn/0Yyh6YmT+o1gxJmOvu
         OCQI4XVoqsjw/Pi+lH5bOQ0tVFIe9CQwGSlyQcMdTxm7Y/Kfl9gYpkzFjHOaXDlAPqd8
         vPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008977; x=1708613777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRdb10/lfp5UXJT3tHF43SuGZ47dFW6seynzctgmvuM=;
        b=YVb44dmERN6sEUhARAln3SRXpGmVULmI+s2yU2axenO7Fu7bfkQQ6hyukngOjWJka8
         3HgrRe0GEqqysCFz+j40Rm3mLyFVk7hfcAY4MvRttyfIglgXpA5a4mSKV9CG/UsK7+cA
         Iu63SEobyruUMXc8zDT0noA6KMlJ8klUKvfEyj49zlwL80t5hUA34hk4nFhU1tzuxvqS
         xP6RjfQIouNIRateCF1o/4MiNnQA5Q96jp9w9XUGj7h5KLps57Hg12fIM/X2g6D06piu
         8zcG1I+J6AaXcOfNEDvZiZvwjD/FmNq6jX838fJIUYkcqi5Oi8hgcLvPa9mQvta1PKDj
         A4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Em5ybGtsAquzcdwUUOBL85csBTGcFto8BSxG9K7Ur389zLe/QMRlSnP5kyycOeaHfPAVc+3PfT6sxMKIIWL0yUJYwRIbW18JJo/9
X-Gm-Message-State: AOJu0Yz1i9GOulzeyXT+FciOmDMY7kBf4xPbS4JVXYjQrKO0SRyIGMUm
	mG0AA4ZcZLrnsE0gS1LceCkmqmq2RHdGHucu6ysOAmNrc9c56VFWeoD5d8YGUnw=
X-Google-Smtp-Source: AGHT+IH0v9QIPzh4mLYGVGUXnX6SaEOib6O3Cyl6trEGIAKPjF0auWYf6zoGD9rvUxlVXqLI+vIGaA==
X-Received: by 2002:a17:906:22d8:b0:a38:4f6a:4e7e with SMTP id q24-20020a17090622d800b00a384f6a4e7emr1940730eja.32.1708008976994;
        Thu, 15 Feb 2024 06:56:16 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:16 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 06/14] linux/mm.h: move page_size() to mm/page_size.h
Date: Thu, 15 Feb 2024 15:55:54 +0100
Message-Id: <20240215145602.1371274-7-max.kellermann@ionos.com>
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
 include/linux/mm.h           | 140 +-------------------------------
 include/linux/mm/page_size.h | 150 +++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 139 deletions(-)
 create mode 100644 include/linux/mm/page_size.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2cc39916cf04..778f8aebb45c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4,6 +4,7 @@
 
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
+#include <linux/mm/page_size.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1049,38 +1050,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
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
@@ -1294,39 +1263,6 @@ unsigned long nr_free_buffer_pages(void);
 
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
@@ -1966,50 +1902,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
@@ -2029,36 +1921,6 @@ static inline struct folio *folio_next(struct folio *folio)
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
diff --git a/include/linux/mm/page_size.h b/include/linux/mm/page_size.h
new file mode 100644
index 000000000000..0f8ee3dab6d0
--- /dev/null
+++ b/include/linux/mm/page_size.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_SIZE_H
+#define _LINUX_MM_PAGE_SIZE_H
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
+#endif /* _LINUX_MM_PAGE_SIZE_H */
-- 
2.39.2


