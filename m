Return-Path: <linux-kernel+bounces-100045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A842879131
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C958AB2303E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D167A71B;
	Tue, 12 Mar 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="B1cO7JY9"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958679DDA
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236517; cv=none; b=AaYL5oZAqw1r6gDytfeVcrghCYLseQayl1Wef1Uubegx2THNv008/wOXXJhI1nYBYQqiIyovng5FEl19CcUkvGbPnXoFSNTF7Wb83+NnXCEONlv+kuaC8c+wvRVi64hAgxv2pY/4fpwxQD/rglbBglwBhVan5OCGZkilCNjeD+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236517; c=relaxed/simple;
	bh=WbgrH40EXEUiQSR1Yyn9b7sUNNxFQNIbVUvs4s+s9y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ItoCniBtK+rG2oDfh6YsGORHKwWfJuKfw0cTqfl9h9Np/sgP1HBnaRmdxMwLo8Rfq9o2QE7snNE0le1I7t2NpoJq0YgotjuwgPi+UjRGuTTHE7XCUdiWikK87Qu6r/Xxt3I+MpxHDbBp9RYUIoiiYZmZFNCEIg6rj2YY+61lTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=B1cO7JY9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so481484066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236514; x=1710841314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wE2HsEwQuIKqCaqriShH9hKkj+cYk+gvkRx/+6+3to=;
        b=B1cO7JY9JQ8K9AIWlyjExpZOe/wCCZIgXmKBbN290Vm6LYM+fbc4sJL5kObj5F5/1d
         GuC1cQv5haK82MA+6pwjuHEq3flEHFPTbKiQjgCsuiqbXJfJRiKm8r6hr6yRZpeEBf9H
         XwJA1y1pA7P/Mn/mGsrvQ9t/stI1zsMs20gJn6EQw591klPhZIP7B/R9zw5MYeaH0txf
         tfLQfeKY04xl0nPzJ4wKHModuuJQGU9FyqZvITkZ3ZttQ+c0Q/R3NAPyJtMfd12od/5k
         fVk8iSqIVyJVmPffpJDVRA7wMKhShYaPIovWuBgLSIVZZcBz/jn4yQVky+XqCJr58PPF
         o0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236514; x=1710841314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wE2HsEwQuIKqCaqriShH9hKkj+cYk+gvkRx/+6+3to=;
        b=cedoWGsXKhF6au7q+JEjMREC59KqxL72ITjCiB+C3o9jsMzbN1uCnRX2M98LlE8TlW
         SZak+c0qLh72Aidjg2hc7Ai/M3Z1cQ26U7wRlbzw2hCsada/AYL1FHaGdHkuaxfE9kR3
         UddjbnU6KVFKBzoQZss9Wv65plTqZ5XJeo79M/DlpYcnUOfbmccqRKr3KOyFLqXpuOiC
         8XCPVR2NgyRF5KICmba23n+TEexRipBeaH0gRkcsOacHDKiSc14ObdOhSrXgarGkwwX3
         OwcXJgy85Lwie19yWgy5l45E8OdZgvjFxYV/o9UtrUTU1qSxQGhwvYaCEyLLZNAYJSHY
         iqHg==
X-Forwarded-Encrypted: i=1; AJvYcCWjDLudPd4ZjXcJ+2QZOX1OZBQNIHeeCcu12lt78LhSvLilXzV7nLP9l4nYmwty4rAXOEfp5VOi7hMEDPEKFQYkQJX6ZBT1X/+yQvjN
X-Gm-Message-State: AOJu0YwRFtUYCGu36LBDAYXWsZafslBPfa6pJWH+mEGV2z9zfVMsQtzh
	KY0nVAd0+o1JxZkWDCISdWBwnm2eDytzHvfM3GIDxgwwo2SF9XWGmylbkWdI/dxfvM1uvKSX96Q
	7
X-Google-Smtp-Source: AGHT+IHwESUJTLeXYVU6c5C17eRydF4PJMg9KLfv6dX8WUbheMpCuO1M61+d7bvgT7hUFtR7+f1vtQ==
X-Received: by 2002:a17:906:3a9a:b0:a46:2751:1358 with SMTP id y26-20020a1709063a9a00b00a4627511358mr2898595ejd.62.1710236514117;
        Tue, 12 Mar 2024 02:41:54 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:52 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 05/15] linux/mm.h: move section functions to mm/page_section.h
Date: Tue, 12 Mar 2024 10:41:23 +0100
Message-Id: <20240312094133.2084996-6-max.kellermann@ionos.com>
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

Prepare to reduce dependencies on linux/mm.h.

page_to_section() is used by __page_to_pfn() (but
asm-generic/memory_model.h does not include linux/mm.h).  Thus, in
order to be able to use anything that calls page_to_pfn(), linux/mm.h
needs to be included.

This would prevent us from moving page_address() to a separate header,
because it calls lowmem_page_address() which in turn calls
page_to_virt() and then page_to_pfn().  To prepare for this move, we
move page_to_section() out of linux/mm.h into a separate lean header.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 18 +-----------------
 include/linux/mm/page_section.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/mm/page_section.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e140ee45f49c..79c1f924d4b5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1637,10 +1638,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define SECTION_IN_PAGE_FLAGS
-#endif
-
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
@@ -1838,19 +1835,6 @@ static inline pg_data_t *folio_pgdat(const struct folio *folio)
 	return page_pgdat(&folio->page);
 }
 
-#ifdef SECTION_IN_PAGE_FLAGS
-static inline void set_page_section(struct page *page, unsigned long section)
-{
-	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
-	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
-}
-
-static inline unsigned long page_to_section(const struct page *page)
-{
-	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
-}
-#endif
-
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/page_section.h b/include/linux/mm/page_section.h
new file mode 100644
index 000000000000..e4558c2691b8
--- /dev/null
+++ b/include/linux/mm/page_section.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_SECTION_H
+#define _LINUX_MM_PAGE_SECTION_H
+
+#include <linux/mm_types.h> // for struct page
+#include <linux/mmzone.h> // for SECTIONS_*
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define SECTION_IN_PAGE_FLAGS
+
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+}
+
+static inline unsigned long page_to_section(const struct page *page)
+{
+	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
+}
+#endif
+
+#endif /* _LINUX_MM_PAGE_SECTION_H */
-- 
2.39.2


