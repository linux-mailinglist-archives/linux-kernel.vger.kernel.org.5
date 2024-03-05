Return-Path: <linux-kernel+bounces-91935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D38718C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC581F22DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1052F6F;
	Tue,  5 Mar 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aUroCv7v"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F14F5FA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629181; cv=none; b=L+IDwkR6S26tbQetEUVzTk+9C8Fyw/TtMzJQR+boU4S/8RzL/N+N/+SUudxBA1d6lI+LK6luvzOTFsLiG56+jt5E7cU5PPri8vlWpYAvkMMk4N9vGDf9Sr8bd6FlqJDnsNo3eL5iML/A635t0m0ogT2lUkNDdR0yEEXAczQSzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629181; c=relaxed/simple;
	bh=qh8EAKq10ZxS5F7ALx5UyH9pEBGh9rG+saOTCW2YaOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hz3gfpMlFaR30G5M6xks3GY/yhV6NiUF+fUBiggZETTxungItc5P6LnCVEZh7B9pNW0Np7vP2NZaI2KNQt0m4UwZPAD5/d/b9qrFYrwurF/8yOjriCeJqAJinPg+/zL1KMGnoobMinX2Jxrm8kf87v8Dwp1PdwubnAxtZ6N7ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aUroCv7v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44628725e3so677969166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629178; x=1710233978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHNy+forpiTP10uEWDszfRKNVIJTNDDzicOChwXOTNY=;
        b=aUroCv7vAr6zItJCGqnWrF6ltNP5kr4a0x9+141bFF9vX2wHd7S29OXNx0iHt04yZH
         yPIa3jRmLQK2TEKmnuZ3lBBYbmjPpkTklPtKLaEaLiiUfSxZgkFFa+6lSb+wJGcTH84g
         Mcm8lOwHwVbCcwYuJ5Wuaq/ApMOk0pusMotjie5QrceTKPUOw2dpN7GsbPttfClgbpPX
         IbOav2aOdS5Q9DuBjw39qF/9O5S2eVY9dTX6RIc3g9ehQWAeXn3aGuJMZklsyI08TTux
         Vh6aCk7159uImKVpF+VvW/cdpxFK6TkO8Y8eYaMIw9/stH34b8U6WlE3doY9XLlEnwEv
         1Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629178; x=1710233978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHNy+forpiTP10uEWDszfRKNVIJTNDDzicOChwXOTNY=;
        b=EdfX69NnA5woSGEVigl2uz5XiJ26pprljo8GxeJUf2SZXkxz2IkV9z9NfmcAFdIotx
         yntIlWPSGkmsd1y9q+9K++GaABlGY6OYbNHkBD5glymjA/05rfIXbrjgBAQtuYtvjUrV
         wc4+VbuiViNKm65BZ8Q1ccXG9+DdcOrEWai/lpxnYE+e+lU5JdTKZiIkX02FIwJX21pc
         CzGeu6PPqOcgz3S4tDuCYbAfkXquzuKgAkVBTwGYEfRX/1PLx1Scjw2ugLzf/MMHxX82
         7jGFnKHvYShcfekHY3rgRvbWZbime8sMeIX2GEGirFrxApub6ujKZGkhW2PDL2eJe6T6
         xeRg==
X-Forwarded-Encrypted: i=1; AJvYcCWmBmmGeo8adUiUdU4iv1kpwmnvJd8X1rKSuq2FgrSis01tG0cpPTGVZe1mQKeJiyZnZYoWLiCmvRPQdISp21WHRkWG4T0DxQFGl1yn
X-Gm-Message-State: AOJu0YyR4291nHCIP/iSEZPIRQb2MsB1OkzmGPuVY8+56F/NcLqSizHk
	UYzgCnMsyejjI9OpPn+cM7bcJDtToTuIheNfXKiuQpSm+C2DhTRB1HGoYuRD35w=
X-Google-Smtp-Source: AGHT+IFyEMaXcRKYaPhF1ktAQM4+jtLzlghr9ZNeqLIJk/JzZPpWzQgHVLLePNuDZ+0vJD35Sgn1CA==
X-Received: by 2002:a17:906:d8c9:b0:a45:a7e1:62c3 with SMTP id re9-20020a170906d8c900b00a45a7e162c3mr665645ejb.70.1709629177775;
        Tue, 05 Mar 2024 00:59:37 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:36 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 03/14] linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
Date: Tue,  5 Mar 2024 09:59:08 +0100
Message-Id: <20240305085919.1601395-4-max.kellermann@ionos.com>
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
index 9e5bb60c55fe..dbfe08329154 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14210,6 +14210,7 @@ F:	include/linux/mempolicy.h
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


