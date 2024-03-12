Return-Path: <linux-kernel+bounces-100051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D75879139
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7301C21260
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54B77C6C4;
	Tue, 12 Mar 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="a6A1MDjS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22B7B3E6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236524; cv=none; b=tSj/HSP4ugRUvultd8hO7MtJ0EtQGArGqd84y0RFy4Mtg/BF5qUNX/9piOHkXZoahHBbTAWyYTtvRUJlEwASVaw8+KO2bp2YH9q94T60eBzGWVByYzF4gzdHRd4PauOLCUmqSXLv4fNyoSe/nc3QIYFx1CQjBr9royGRCEwCDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236524; c=relaxed/simple;
	bh=gvv5QAtWzHwpsz/x1Apq4Lva4NNrjhRHP3W2M/SGVoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrDIPTARTtkA+f81jQv5z6EfhRTBTntj56Ki9y8E3crfs+EfQCo+4LIOUjsAwnXcing+xJKB3Exlz3BIwCS3TPDGgEKwKPOBXn7CFDEt/j3UstvC2uG5kCWOsxiO+OObjFT6weAhrKfC221dmtU3vqyrIyaqDvps4vfQsn1ty6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=a6A1MDjS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4467d570cdso452711266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236521; x=1710841321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i50xlwbZc74AakEZHNdRuLF9vXbOX6ErFGehWmkuapg=;
        b=a6A1MDjSnHX30cuq3bLIPtgO3DM+C7o/Np68DxDFPC7/u1fGpLRnviMRg5DNW7NmG/
         5vDp80t4n69zZvjfyQH1swFa9JPh65BmcpwSOYxCO13HX4YP8bFKyyQdduOTxZv0/IBo
         VajA8rgkLp60/Q4vAWa86dwzFAvl+h0DmHFEdKpXr4jxbUP6MJyicgz+g1o1gLaZHJEP
         XfUd0UjYIS3J4Phjpr3eUToOapiron/SSD6qcB9rLsfUd8PRxq9APpwdPzq1AHMW8JFg
         S5gph1wc2Rzm8NaPXrCVKkYT3DglJHNxhLTH/OEMHUgN9jVDaie2BSN1j2AQlWZmUhBd
         Yduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236521; x=1710841321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i50xlwbZc74AakEZHNdRuLF9vXbOX6ErFGehWmkuapg=;
        b=KTXZf/ibD0jur/9GMIPXdFG/x2JzCkwJcS4KAgtr9L9+sDniu9HBnskHIlCqjR6DHE
         ni+/qh6llne2XAPQO4FAynzfjUMAiJ+kpTHaVz8q0QzXVeAzY8kkCwwuSV36VO4yNah9
         iMLkTHIlbjWfjwHvZ/4ENJb7HVC6guvmazpysyWTxtz+Jrbm0M2MjlIa+V32hPzDI+XS
         CD5cWTpLmKLmbArHmOQCr52USZf4Ef5sUApGTh+no2wxTxXehN11LUiwja9v++SRcDA5
         1k3AAmxgVSOtfY0uE1kqRFApeHjGkYG4NrKgjdOL58HqzI7ukIsTU0fP/7Nks0cYQTWp
         wdgg==
X-Forwarded-Encrypted: i=1; AJvYcCXblIB6dmzYgNZcaKR2dltNePo16f294+wtHAkt0ecuzQO2gu+kY36k/ZPCs5imM18WeDl12gBumd+yx8PA8bnFJj5UeQ/fnuo4mmWz
X-Gm-Message-State: AOJu0Yzu/LyPv6czEqG+Qt9w2XXWPaiP9DvrIELoG2sjwOx995LMNy0P
	vz4SJrYSk4+3iCwrZOCuf7mZrMlZ2myowwOTxrY1OrEcGacYf6HeSAk5r8Ko4fg=
X-Google-Smtp-Source: AGHT+IHE1rmIWCBb38RKNMnxPLtWxqbctrPPIxbV0WrCoKWmsRzG7Lzagrq8yH3gH7FOwHCKd2fZew==
X-Received: by 2002:a17:907:7714:b0:a45:a98f:2cf7 with SMTP id kw20-20020a170907771400b00a45a98f2cf7mr5679209ejc.57.1710236521219;
        Tue, 12 Mar 2024 02:42:01 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:42:00 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 12/15] linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
Date: Tue, 12 Mar 2024 10:41:30 +0100
Message-Id: <20240312094133.2084996-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312094133.2084996-1-max.kellermann@ionos.com>
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
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
index b3f83fb26aca..07262ae43c5d 100644
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
@@ -1763,50 +1764,6 @@ static inline pgoff_t page_index(struct page *page)
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


