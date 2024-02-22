Return-Path: <linux-kernel+bounces-76451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766085F77C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D612285B38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD7481B4;
	Thu, 22 Feb 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hcUbHLOJ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096B446DE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602668; cv=none; b=Y48DhbnO5tlQMi5xR/yxTkJ6HkjyyH9UCvrGOF6FmmQis6I9eOGFv7jYCJn5hx32cVl22OfHCRnyISNTAyUBD26jlzWWTg/rgnW1vEe0/U5Ehm+mAlsYuz5cowVK8jPOx07WHmSd7jtV8lPWCvIeUjTknhVsEg5TJkKKiLY4fT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602668; c=relaxed/simple;
	bh=aG/T2NPOQsNeyDUNTYV6KWwxd7/uxtPCMFLlShvPJLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf6NvYT28uKgUFLvCsOzgw8lOExJHciCqHeS8UVFqultk4LB9qJlFwK3ZC22dGHZ+Xn8HrKlZJBcJMbFBIxP634RH3rW4KEJxD/hcSAj4Vek3+tM4NA6ODlhuLw/dMaGapHab4sltYRMJ4kw+4WFWQl2kE8Yev+xK9TM3/mUcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hcUbHLOJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3394b892691so434522f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602665; x=1709207465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b5/uhjfqeIuQAGiFdEn3Xr4J+TBvtutx0p1n4ubkzU=;
        b=hcUbHLOJh3hHHm7E08Oi5NVR/r8Y1WgJKtqrUYpAJLqZaeR+iGf13V7vtsJ5tYPisi
         QQt1YcuavbYtOjGa2CDCSseGtQBt2ibz9ieB99+XLPLdu26/rYf+sBKlX9TYF0c4KGl3
         oKm/nwBwygAtkm6pRmAsFp78HLnfM7KjktsO5/fVwCTPfe3ct2hsB9bbTSfSsPqD0QdS
         rt0t0T24c4zPVz+wDoS4ZrI2DK05fa2d72Z6teB5q6DQLFSdTfWKHRlN9q7MGb2CHEgu
         1fpbU8BbOepWnyfRKRu4Q6Cz+Vc7eqEpAPEq/9++/FoH4PZozvITcV5bOYpZUw2XPGTW
         I59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602665; x=1709207465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7b5/uhjfqeIuQAGiFdEn3Xr4J+TBvtutx0p1n4ubkzU=;
        b=X0onyKuGdQIw/c4mdxEv+XvoaVmqCVlzmTl7Jhy+KJNh0HEPBg/zmy0wmc1MKkGmfx
         UVGOSMWxHFBLiu+teZLcHGbPMkduJRLeSwxbafacnWi4kMWXH72RBA37aBkkQaebHC5M
         XGhYc8Iloyi///AdY2JtRYxBW2imOgTIPK6jnLoXubld0+BtagdOn7PnGivIIvt1HDbg
         0q114Ii7SWXgNEhR6KGo6L4Jr3BMGG9SMRQ93jN8tuQ7BSbGPceuR2bK1Ep+fqtPxmfC
         5/vIJSNHWWDaZ+wt85Yt0zTpuo7K4K3JhDJMcjELYfPDthJfZL4KVFC/YsPNyBIh1G4G
         iSLw==
X-Forwarded-Encrypted: i=1; AJvYcCWMJPpLGl/8bSHKkc6+bui4msEtZJ/gwTQDJCO0lMX/Ax7uqyyuwDLmoogq9YjjJvPiZvNN+kzqBs1kgffrR88Xk667G+gwNuGPiJYv
X-Gm-Message-State: AOJu0YxVobEeVehwoK4Nt6SFijarWPDe2cOmwnckZIENvVG64zqTjJu2
	8WgQtOhAi9A1FIzcSaXT3DLiGyhYEcq9FqvWWBMAWEII51J20+6FLpVz5dYxSEQ=
X-Google-Smtp-Source: AGHT+IEKsT+x17IHrY8997OwmeRClTuQ0BNyZeHPQoSXN8JZKWq1sN/JzXVa3pupvyni90LpbItmzg==
X-Received: by 2002:a5d:4ac4:0:b0:33d:3ff3:f888 with SMTP id y4-20020a5d4ac4000000b0033d3ff3f888mr2385231wrs.0.1708602664992;
        Thu, 22 Feb 2024 03:51:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:04 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 03/14] linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
Date: Thu, 22 Feb 2024 12:50:44 +0100
Message-Id: <20240222115055.1172877-4-max.kellermann@ionos.com>
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
index c042ca394893..ad208d8aea4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14187,6 +14187,7 @@ F:	include/linux/mempolicy.h
 F:	include/linux/mempool.h
 F:	include/linux/memremap.h
 F:	include/linux/mm.h
+F:	include/linux/mm/*.h
 F:	include/linux/mm_*.h
 F:	include/linux/mmzone.h
 F:	include/linux/mmu_notifier.h
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1743bdeab506..c8d909cc1353 100644
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
 
@@ -1810,60 +1810,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
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


