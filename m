Return-Path: <linux-kernel+bounces-67122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD998566A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F33D2897B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED71332AF;
	Thu, 15 Feb 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WSDNOxLA"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8718132C02
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008986; cv=none; b=NmIds+IlJcYx6Viipk3Jiw2pv+/qyn/U69jY0oQCtfmJ9Fh//T05jb4T7e472WxI/D51C7+gYZ7HnKjsrx+30+J9mSa6MFyTIcXsIlRo65vbbgz91HlYgN1zLHVp+JOXo3k390WGSv1LjIb3GB3+er7sFCOrmbkjk0dTSNw7pfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008986; c=relaxed/simple;
	bh=pxtwIOSGybK0E8+t3Yis8zIqDX8fSripsw1A41Tnjfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KxOvNvh40MXN+C+K3oP6SGqIFxx3DoGuf1R1oBnAltzWyXE4JHC9Z/Vut6TbiFksOrGNZshk8SiAbb+bDLrFDnROf/+zPQLNWzc3WAI5lFXOkw8QHiRqsfGinvoezPygBGsqWBdBI3oH1oERq7oOrI/f5Fc1UeIXp+SWxwLWAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WSDNOxLA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cf32e130so346378a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008982; x=1708613782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui87eR1N8KdYrsRAWgwlBy5zGHV5S5KAP6ANHsd3+6c=;
        b=WSDNOxLACrxXb9cY+bzWtYovcQSkpndkcyQ8ekdgm6s/SIfTelLjM7F+mA/1Tyfc+7
         UBu1KNYuj4wijkv6YWlOkh+r1eKjXlf6naUCOqL1eLqnKKsHyBCOB9oEkyS2XuHYWmDJ
         XMFia/h9VVJoGB2mGVuVXyqv7WZHrnB6NRjt5wKQ52xRZEdtDym8fcfY8p2BysuTNez/
         eitHa0tlW5Oxw1AvwQZjz3CYsz2uH3qj6+2Ukg54CEqMbO6gZ8I68zg9XyyVaZ+NMirZ
         Yhyq6OMw6OWJgp6ooFzYzkwy+g6A5fljFL1LE0ImRSkigtfIKwS3PQlOL7WSbK8BCyra
         UoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008982; x=1708613782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui87eR1N8KdYrsRAWgwlBy5zGHV5S5KAP6ANHsd3+6c=;
        b=YvB/qA/XrqGgZMJxnrHRcD6d4e1wsOVgIBUAalFVaLkExOB+OkOUuVoSamQl+Sz++D
         GAtnotQq70xvJ8ll9Mug+HoMmnEW2bZcjwXHJg1YhViNyTLgtf4Vdc+3bEj8IL88iAxX
         +w8dsYoaauPx0i0Iu2OEz5N72XSFkN1Gn3NoMPipos6l/TP1VJv2SYsRkjSbx6ichc60
         7s1umSkyUfD739/bxh06xxt6s4I/YQlgDLp5ijD++rWfVrF4caAa3DStsE2wQCvRwdrD
         N1pKMCgKnzfUVj+OgCIpdv64GJ6u1O8JEmMzuu2UD3gmpkRqp6TE/Xe5d7tSe6kZRXor
         /JMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk8BGr1KVlSABs9/rfgvQjFJV7n+hpkusu6awUOToEbxJe3COQxoVwofonhv0y1XhyGCVzGcg6xb24iEutsdRwA5MFZT5diGJTMN1F
X-Gm-Message-State: AOJu0Yx0SAAcoxxkxyZbbCP/WgxPb/5PMdED1rVLaH09DprpEwIrIuZe
	GfYkVM8OzuK5cj17yVKxtA7fWTtO7bOHuxJoHupoxs1/drp5cpC17/0us3sXzTU=
X-Google-Smtp-Source: AGHT+IHJPjSHl7B3baS+ulCtYjH6fSBlPEEmxM5P3E0Kdh/Ma+gFX7l5Bh2omHP9cArRkMUptWYd9w==
X-Received: by 2002:a17:907:b0a:b0:a3c:ce90:bf4 with SMTP id h10-20020a1709070b0a00b00a3cce900bf4mr4128460ejl.14.1708008981990;
        Thu, 15 Feb 2024 06:56:21 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:20 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 11/14] linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
Date: Thu, 15 Feb 2024 15:55:59 +0100
Message-Id: <20240215145602.1371274-12-max.kellermann@ionos.com>
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
 include/linux/mm.h            | 45 +-----------------------------
 include/linux/mm/pfmemalloc.h | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/mm/pfmemalloc.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index aa24e6fed9b6..c7e53cd0cdd0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm/page_size.h>
 #include <linux/mm/page_usage.h>
 #include <linux/mm/page_zone.h>
+#include <linux/mm/pfmemalloc.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1744,50 +1745,6 @@ static inline pgoff_t page_index(struct page *page)
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


