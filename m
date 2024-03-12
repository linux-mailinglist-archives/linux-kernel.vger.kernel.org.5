Return-Path: <linux-kernel+bounces-100044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3A879130
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB26B1F21118
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AB7A14E;
	Tue, 12 Mar 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CA83FBTD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423B79DBB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236516; cv=none; b=dXT9hKkHP7saYVpEAqVMoA90KQQUgSWxfeM9WzaSt+TrBzmIaUAKulZqt9hNFon8KtefSOAZjhoIfwBptQZ24CppUuCsQKK1q2Yp6vPJRrP4eZuvRP+nOuLKpFJfzXbyoFhYpswI/jRiOSO+PDZuSVOMT0tzQX4XXOyEJe71xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236516; c=relaxed/simple;
	bh=6XSamrQ8GvcwYgiZq1oDc5VOoarijJtGGH5zDeCqxHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE7mj+JvBNR9TxpG/Y/LvRmiOqHXd0EJDcTORA8r9ySN2tayIxywpOYrBhneKsdbTNKMqcdjGLoHFhiLmXmm/c/P+b+A7/k2tWZ3uOra7E4npJDGwJs6XLthtC8Hdzqqm/Nde/z/Aj/M78hqSitd5yGSKFqAX5GsbT/FU2mbnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CA83FBTD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44d084bfe1so475867066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236512; x=1710841312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOXvgd5nL7gApAixwLBmVSPDbvkCXFf36Bu9a1YyE0M=;
        b=CA83FBTD+qLbM9Ls/kv19mIHtAIObQIf7OilBdbl3NoB6mpG8uxHdzn1gvCn7XM9SO
         9JrvRRn14Goia07M66CJuEvgJ7+T7tkLgCQsA2m/qTRP/iqMy4SZuWonHSkE9Qq8DW9S
         rkCqWwHSmqSD7IfZJvS5HEFonWNBaIowRlzOQuMrhCbvtzKovlu5M5C4Z8YPAW/9RUgj
         AnTCZ0Psn9+61pktgjU7O3b1G6CYz2Y3xlAnjkU6kqnY7YulvCKdPfvaAIa4o1LYWEeO
         2b4bu5wSxIS0KZZi05gcN2j6E7Wfn5sp/EQVF6JAHTG6tC0pULWeIdw7EZvxgvrhE23e
         g71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236512; x=1710841312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOXvgd5nL7gApAixwLBmVSPDbvkCXFf36Bu9a1YyE0M=;
        b=bMqe/YJ5Aurk/YPal4vsmEQTIKoKxf0bBKNgsJWq39r699fYn6dkIlWeborXJ2w7pp
         pdXsGjUpU+elF+GMzF/DwrDE/yyL3d9D3H6bxQbnIHt9uV4zbl/hF/85272wOxebRFmo
         OEfCSJF5+FxKtaWiH7a5/0GPvt96tfJ0cEU44gX1lz0G9kgEVgSiyBcCC5XT9ymQW7TL
         GotxGlDSOTOLlkOtixkvKJBDLnI0YD2HBwimim47foiu/q78gO0audjxTD5NAeHXY1Qa
         KRBHcGspbVADrFYYLghyeXZEopcw5hiQuQX8OHZhsE3BQWo4D9Ld9uOx6mR+FnwQ23WY
         1Htw==
X-Forwarded-Encrypted: i=1; AJvYcCXajyALZiK2zF2TGKeH/tmebEy6C5B8KPIeVVtuTC12UUuyn4ji1JuV7vrvWMbu1d0jxcd9BS2am1E/oJ6ep06Umu4bsXA8/HwrCjPl
X-Gm-Message-State: AOJu0YyELUng9ALiWLDDqgEk/cWFxuGGqaBfDRKYj5VZcGSBUyqEUzFW
	e0J07GLzh2vOVTTms8VPU+KsYrdQ+Se44zwpMm3U9fvCjAJKRIN+RUXrzi/xrbs=
X-Google-Smtp-Source: AGHT+IGJUp5RAZLCr3udJzv79aMWS8KJbP01FoMgnjIiqVrmS+CbiURoWNKsIrAZW9gur1I3s6sCLg==
X-Received: by 2002:a17:907:1888:b0:a45:c997:2267 with SMTP id lj8-20020a170907188800b00a45c9972267mr5996063ejc.65.1710236512626;
        Tue, 12 Mar 2024 02:41:52 -0700 (PDT)
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
Subject: [PATCH v4 04/15] linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
Date: Tue, 12 Mar 2024 10:41:22 +0100
Message-Id: <20240312094133.2084996-5-max.kellermann@ionos.com>
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

page_kasan_tag() is used by the page_to_virt() macro in ARM64 (but
asm/memory.h does not include linux/mm.h).  Thus, in order to be able to use
anything that calls page_to_virt(), linux/mm.h needs to be included.

This would prevent us from moving page_address() to a separate header,
because it calls lowmem_page_address() which in turn calls
page_to_virt().  To prepare for this move, we move page_kasan_tag()
out of linux/mm.h into a separate lean header.

A side effect of this patch is that the <linux/kasan.h> include line
is moved inside the "#ifdef CONFIG_KASAN..." block, i.e. it is not
included at all if KASAN is disabled.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 MAINTAINERS                       |  1 +
 include/linux/mm.h                | 56 +-------------------------
 include/linux/mm/page_kasan_tag.h | 66 +++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/mm/page_kasan_tag.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b43102ca365d..f2d32e2da433 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14218,6 +14218,7 @@ F:	include/linux/mempolicy.h
 F:	include/linux/mempool.h
 F:	include/linux/memremap.h
 F:	include/linux/mm.h
+F:	include/linux/mm/*.h
 F:	include/linux/mm_*.h
 F:	include/linux/mmzone.h
 F:	include/linux/mmu_notifier.h
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..e140ee45f49c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/page_kasan_tag.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -27,7 +28,6 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
-#include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
 
@@ -1818,60 +1818,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
-
-/*
- * KASAN per-page tags are stored xor'ed with 0xff. This allows to avoid
- * setting tags for all pages to native kernel tag value 0xff, as the default
- * value 0x00 maps to 0xff.
- */
-
-static inline u8 page_kasan_tag(const struct page *page)
-{
-	u8 tag = KASAN_TAG_KERNEL;
-
-	if (kasan_enabled()) {
-		tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
-		tag ^= 0xff;
-	}
-
-	return tag;
-}
-
-static inline void page_kasan_tag_set(struct page *page, u8 tag)
-{
-	unsigned long old_flags, flags;
-
-	if (!kasan_enabled())
-		return;
-
-	tag ^= 0xff;
-	old_flags = READ_ONCE(page->flags);
-	do {
-		flags = old_flags;
-		flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
-		flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
-	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
-}
-
-static inline void page_kasan_tag_reset(struct page *page)
-{
-	if (kasan_enabled())
-		page_kasan_tag_set(page, KASAN_TAG_KERNEL);
-}
-
-#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
-
-static inline u8 page_kasan_tag(const struct page *page)
-{
-	return 0xff;
-}
-
-static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
-static inline void page_kasan_tag_reset(struct page *page) { }
-
-#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
-
 static inline struct zone *page_zone(const struct page *page)
 {
 	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
diff --git a/include/linux/mm/page_kasan_tag.h b/include/linux/mm/page_kasan_tag.h
new file mode 100644
index 000000000000..1210c62170a3
--- /dev/null
+++ b/include/linux/mm/page_kasan_tag.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_KASAN_TAG_H
+#define _LINUX_MM_PAGE_KASAN_TAG_H
+
+#include <linux/types.h>
+
+struct page;
+
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+
+#include <linux/kasan.h>
+#include <linux/mm_types.h> // for struct page
+
+/*
+ * KASAN per-page tags are stored xor'ed with 0xff. This allows to avoid
+ * setting tags for all pages to native kernel tag value 0xff, as the default
+ * value 0x00 maps to 0xff.
+ */
+
+static inline u8 page_kasan_tag(const struct page *page)
+{
+	u8 tag = KASAN_TAG_KERNEL;
+
+	if (kasan_enabled()) {
+		tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
+		tag ^= 0xff;
+	}
+
+	return tag;
+}
+
+static inline void page_kasan_tag_set(struct page *page, u8 tag)
+{
+	unsigned long old_flags, flags;
+
+	if (!kasan_enabled())
+		return;
+
+	tag ^= 0xff;
+	old_flags = READ_ONCE(page->flags);
+	do {
+		flags = old_flags;
+		flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
+		flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
+}
+
+static inline void page_kasan_tag_reset(struct page *page)
+{
+	if (kasan_enabled())
+		page_kasan_tag_set(page, KASAN_TAG_KERNEL);
+}
+
+#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
+static inline u8 page_kasan_tag(const struct page *page)
+{
+	return 0xff;
+}
+
+static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
+static inline void page_kasan_tag_reset(struct page *page) { }
+
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
+#endif /* _LINUX_MM_PAGE_KASAN_TAG_H */
-- 
2.39.2


