Return-Path: <linux-kernel+bounces-76454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CA385F77F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1BDB22981
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D34D110;
	Thu, 22 Feb 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OpSb1LuY"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B347F6C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602672; cv=none; b=F+wq7+Mi7glQkMDOsTyHq5dhn6tiw7ov86dbrU+eyJH7npsNe7AacSIVxjQyG/HEAZElUjWmHETnUvAUglycxCRwZg/uFxtsPTvBpDmhcoasVcI2DndyVu6FxHoPm0Eodkl/bYJ8fSlvkN9cOsgTK5dFakYtBvJCUcJFpNI7p5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602672; c=relaxed/simple;
	bh=N8Ly4oEy5piq03Mm8FrpU9io5s7b24dCbY2FPMutdCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNqDOuQYwieu8B1tcu8WoVOuf4HoDqPb+n2g5q/d02LrdiBfYSjfO3EvpHzcB6H8IIwMD5U5nJd/0hM47uU8WNDjCpDjMeLt6jdT9GTKO5rAgpDKkTOKkDS+G+fim18pLMQOVFYdHoj0up7d3su7TFT4JmaK1cKQ5XkNixfbLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OpSb1LuY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d36736d4eso3480074f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602668; x=1709207468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrzkS3Jr9rDGJgnZMZCc9dS49bV9O/AFecbIWIE3ZsM=;
        b=OpSb1LuYX/E2V3o/GDNfqnmgD6DcYEEF4WcPmPmDmGPUKqdrlmTQ87YBx05oal1q6K
         7V7ExPJNWRFXT6L/k1rZ0if09Df3VNHHgoTde3GFWYijRoSEVGK9jMfU6GzrB222O1wZ
         +Lax6oZ5khapzeaQA7dKmTOdAJHNS4y/l/0Met+JW/eRAA2DLPon2OBJodg8RYb52Fwd
         N5eh1VHgSFJHb6CJ2PSJKnOw2AXlfgMpAMa9Gk/xDv6CpYoHD5U7HvGNkpvhIS2qFfp9
         0Hhp0OsL8xeznoa/CvpqO/WJUuhe8OnavVzzTskmh1zDoVnAWy/9bwm7EXB4BmPf6qJk
         OWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602668; x=1709207468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrzkS3Jr9rDGJgnZMZCc9dS49bV9O/AFecbIWIE3ZsM=;
        b=PTXDiuhqoe5nns21h2Vcc7yZHZuljsQVAsub8sLnWRirhQOii0Ejq2peeHljFGuC+S
         dRALDIuNaw1YaM3+IefNRkn37OOYDlDipL+3DT4Rn5CdQ6FwNmuD7XaqG+UikH1AehEL
         psxI9rb6oUKrM8BissnqI3tbapPL/P8racy86WXIR1/uW99eFmh5fIFaTK24uY6bwM/Z
         nkB7irggCgNhJol6gxEANyWdEyGIHxbZEECjkbEgFCcEScxPXI6qPx0OWq/p2UC7RrIc
         jPsrUFW9iA5a7hjj8+8xYuL6lhU6YUQNnbiL8rU00ugqMmyu3o5wuIWcJQiBVskhVq2W
         VRng==
X-Forwarded-Encrypted: i=1; AJvYcCUkCfT3rTyPo7Ol8Fd9bfCbJb+0LE86ubN6DQ9iXWnk5WeqEE4rxlM+Bsqsl6O4soG+DP1pPpDnj5TrTWGEEGONq0EjxNXhUKQLIQol
X-Gm-Message-State: AOJu0YyFX/nu2PEnNetStCMkt34azAwqJ1wpwqvI6788DUG8gGwEeJz/
	8hyexBgzqqtU0XpIak2IoAIHuQMoTx0CLtjuV7I8oVHmqFKaR7SsatjmnZwxoCg=
X-Google-Smtp-Source: AGHT+IEf30oKm3SvDXvZCjTXb955DQvutxWXp0IjhfwewVF9FwEP1ddQHLarxc6WQx8FTmkpa5t7tA==
X-Received: by 2002:a5d:54c4:0:b0:33d:887c:fe04 with SMTP id x4-20020a5d54c4000000b0033d887cfe04mr1569315wrv.19.1708602667899;
        Thu, 22 Feb 2024 03:51:07 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:07 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 06/14] linux/mm.h: move folio_size(), ... to mm/folio_size.h
Date: Thu, 22 Feb 2024 12:50:47 +0100
Message-Id: <20240222115055.1172877-7-max.kellermann@ionos.com>
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
index 57c091e7579e..9dea6477b4ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1054,38 +1055,6 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
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
@@ -1299,39 +1268,6 @@ unsigned long nr_free_buffer_pages(void);
 
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
@@ -1971,50 +1907,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
@@ -2034,36 +1926,6 @@ static inline struct folio *folio_next(struct folio *folio)
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


