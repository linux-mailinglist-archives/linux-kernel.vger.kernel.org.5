Return-Path: <linux-kernel+bounces-76459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88285F784
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094C51C2148B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2F4E1AD;
	Thu, 22 Feb 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iLEp2xy3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925D4D595
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602676; cv=none; b=L6kmh6pBm+/ngfcqd9t6o9Yg7Wei+jh3wyKnO9C6t9eu584rcZ9ZG3kB1YOmgITtopf8vgDqB4h31K9/lywKRgJbV8D0J+0EZ8WuBkdr1aP1M4qpw45x/M20ZApRZHs9NJMYZgVFCQWEm41gxi0xAQ9aeWlSp1XaVJqXPMOweeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602676; c=relaxed/simple;
	bh=YgLBTN5D5Do778oi/eRa8MuhD8uhB7i6cOaSs76xSFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWTYQ9y3xLL1SmezRN1NAqxpIEhkJN96lBMRzE7KvWdaERww7upJGeqpWixmZzmNqFggCInziO1+M72hvs0ePFDryVqhXQQsyQtzEMjH8dmmplhl7QCkypqk8mtz400e6kEUeFizdBNrLJDIAVLLynbzs6XNN5CK1We49SUsmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iLEp2xy3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so12500185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602672; x=1709207472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIuZ9zlRlzs4cjZtyrA8C8bTBDZzt0jvXmpPfaEdUlE=;
        b=iLEp2xy3lgE3c5NLP5o2VV5AvN9CRHm6ppuS3EAwBSuuBJPxq2cmLIpYDBIPjLk3op
         yLDvABdIiRvDy6z3qj7QURydQTkBRK8b4fQu9Suyx+PHp3i4DB4B6no+JHZpMPSXo/Ng
         q5rAxSZvB7kMVtRC06nbAWFa09SRDdfbc2POXNoNxN4fMNWeDUdHvgV0xh/Q19Kq8ZJc
         MyMDNUU6V3+vcURJW2HoW+pXxzY9Sg8W+5Lw+jVGZzUIlsF26iww6YEDFhPqAiEm+xXX
         0Xh/rxiVGPnEYYJaSgPLB78oBAb3Faej8OVdaybjVr2rHClOr/hW05CxPBJuuGdBgki7
         Q9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602672; x=1709207472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIuZ9zlRlzs4cjZtyrA8C8bTBDZzt0jvXmpPfaEdUlE=;
        b=UI8rVDOTYI9V2hvtV2idJVIwCXGaEcwTtvFWkpLnI23ujg5cpM8uuJ0vb1Qsash9Ye
         AvaBqmFNDnogYH5ILvCcas0hZEZEn2RNCvtZ7WtNQbtyg9/iYE+GM8O2IXjSc++cE9eC
         lRR0k0VPwCb98i48xOMhi+EqZ0O/cPjaKOE37pGkXUBkRiTQmvyHvJviVkNzRuiaACB8
         CVIAmdvbrEm3JBoAvuMTmnbdeR0MxSJSag8PgIeJ8SmgaXFswzr+C4zj3YKsZbw87R/D
         wPHn/+9MBxuBfm+6xYeUlEp4UQ/PymV7+1y1ip9mkVPXKVTe0jy5T7GwGc9RKaiq325v
         6ttA==
X-Forwarded-Encrypted: i=1; AJvYcCW4O20XeQ5apEOu9KGYuI//hOsCoevmff1Ec6JP/C7k+ZGsC4sCTc0+oLo0Ux8GpuhUoObFYSGE1ryV3C5iWjaGuDVgs4rtn2JkUi21
X-Gm-Message-State: AOJu0YzxZF9CIq4L/E9ujfTeQHXxYqy2wOdWRJRpR/scUfurm9DSFysh
	3Ufc5sVNqHBBwKXGJWG+MHKVEB/BFPr3ccfSzqTKkJ5E87l8UpE5PzBLdGFmJqI=
X-Google-Smtp-Source: AGHT+IE7GlQdOA5ZITSqjxJZEz89QZSFz6WL5hb8Ohh0TF8MgsaND/DbLcX8ZehAKHAsuK2u2ZaU5A==
X-Received: by 2002:a5d:47a9:0:b0:33d:3a06:acbc with SMTP id 9-20020a5d47a9000000b0033d3a06acbcmr10659700wrb.70.1708602672077;
        Thu, 22 Feb 2024 03:51:12 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:11 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 11/14] linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
Date: Thu, 22 Feb 2024 12:50:52 +0100
Message-Id: <20240222115055.1172877-12-max.kellermann@ionos.com>
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

This is needed to eliminate linux/skbuff.h's dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 45 +-----------------------------
 include/linux/mm/pfmemalloc.h | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/mm/pfmemalloc.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1297ae7b2541..68228f43e7ca 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm/folio_zone.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
+#include <linux/mm/pfmemalloc.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1749,50 +1750,6 @@ static inline pgoff_t page_index(struct page *page)
 	return page->index;
 }
 
-/*
- * Return true only if the page has been allocated with
- * ALLOC_NO_WATERMARKS and the low watermark was not
- * met implying that the system is under some pressure.
- */
-static inline bool page_is_pfmemalloc(const struct page *page)
-{
-	/*
-	 * lru.next has bit 1 set if the page is allocated from the
-	 * pfmemalloc reserves.  Callers may simply overwrite it if
-	 * they do not need to preserve that information.
-	 */
-	return (uintptr_t)page->lru.next & BIT(1);
-}
-
-/*
- * Return true only if the folio has been allocated with
- * ALLOC_NO_WATERMARKS and the low watermark was not
- * met implying that the system is under some pressure.
- */
-static inline bool folio_is_pfmemalloc(const struct folio *folio)
-{
-	/*
-	 * lru.next has bit 1 set if the page is allocated from the
-	 * pfmemalloc reserves.  Callers may simply overwrite it if
-	 * they do not need to preserve that information.
-	 */
-	return (uintptr_t)folio->lru.next & BIT(1);
-}
-
-/*
- * Only to be called by the page allocator on a freshly allocated
- * page.
- */
-static inline void set_page_pfmemalloc(struct page *page)
-{
-	page->lru.next = (void *)BIT(1);
-}
-
-static inline void clear_page_pfmemalloc(struct page *page)
-{
-	page->lru.next = NULL;
-}
-
 /*
  * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
  */
diff --git a/include/linux/mm/pfmemalloc.h b/include/linux/mm/pfmemalloc.h
new file mode 100644
index 000000000000..345b215a3566
--- /dev/null
+++ b/include/linux/mm/pfmemalloc.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PFMEMALLOC_H
+#define _LINUX_MM_PFMEMALLOC_H
+
+#include <linux/bits.h> // for BIT()
+#include <linux/mm_types.h> // for struct page
+
+/*
+ * Return true only if the page has been allocated with
+ * ALLOC_NO_WATERMARKS and the low watermark was not
+ * met implying that the system is under some pressure.
+ */
+static inline bool page_is_pfmemalloc(const struct page *page)
+{
+	/*
+	 * lru.next has bit 1 set if the page is allocated from the
+	 * pfmemalloc reserves.  Callers may simply overwrite it if
+	 * they do not need to preserve that information.
+	 */
+	return (uintptr_t)page->lru.next & BIT(1);
+}
+
+/*
+ * Return true only if the folio has been allocated with
+ * ALLOC_NO_WATERMARKS and the low watermark was not
+ * met implying that the system is under some pressure.
+ */
+static inline bool folio_is_pfmemalloc(const struct folio *folio)
+{
+	/*
+	 * lru.next has bit 1 set if the page is allocated from the
+	 * pfmemalloc reserves.  Callers may simply overwrite it if
+	 * they do not need to preserve that information.
+	 */
+	return (uintptr_t)folio->lru.next & BIT(1);
+}
+
+/*
+ * Only to be called by the page allocator on a freshly allocated
+ * page.
+ */
+static inline void set_page_pfmemalloc(struct page *page)
+{
+	page->lru.next = (void *)BIT(1);
+}
+
+static inline void clear_page_pfmemalloc(struct page *page)
+{
+	page->lru.next = NULL;
+}
+
+#endif /* _LINUX_MM_PFMEMALLOC_H */
-- 
2.39.2


