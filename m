Return-Path: <linux-kernel+bounces-164272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA28B7B96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6C51C227B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A99177980;
	Tue, 30 Apr 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XBk3J6DJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A7171E64
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490994; cv=none; b=NEVxzQ3EEIVpE1WSKm+DcGIJUvzAVeQQGXpQz7ejVSybSZ9IkIaD/m2MumyObmNlpG4YXkIhmb6k2MbtKHCYVVL5saUnIFUDdarF5hPsGvPAgi9LXfSHOyDl4A4EqoISfm3ua0x32zxiDdYUgXsHY/3Zg71iQyI7k7MlJ4vlEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490994; c=relaxed/simple;
	bh=INaKR4gszxPUGefybN2WrjdhzpmZADt5m7cLRF40ER0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNJAX8ACT3NdYKK2FoKR+gNtLruTVxTC4WtuYkcV5/x7Mdh7K4nF52tT1gPjVuJMUahTJHrtshYczayd9q/vbCDI1rnH0XSRmNOTZgbOY1fhwWHNOH1tNbWqJCk0sX21p6JvvlR1fwo8B08+rcSfaUj5nZdbRIlTTVs7anZ4hZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XBk3J6DJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5176f217b7bso10328131e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490991; x=1715095791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYyjC8Kfa0Af7gs2LI27MUvkVyN60Xn76v1gWBOZ170=;
        b=XBk3J6DJf7/ey5aNdk43fNqevpgh2rWstTQ1uonUiOHwBrTUflF+V4pgDtxB4EZayD
         InTtu+JsnZPpy+aCQtOXvKKXUljau0EFpGwMC3fmcY1khwd1X3/aho222bKHajKh82CQ
         Vx3e12R/WA+20F0SZ/XGzEN3FNpGE2B8tzgQauZ8PZ0cSpWIHJlgnni/6jsyUdo6/hmB
         y6QnLPEL1WGqz/2fzFZAUOImTduFDAOPxRb7c3CWUyme5ods+CuGgx80s6qTezadPgW2
         jde64AHFrgqNHw8NxGlZHHVUVwEiAyq916SpnkDhRUvMAXvcW0ZNtGR+US4Sw20XhpkH
         Frug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490991; x=1715095791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYyjC8Kfa0Af7gs2LI27MUvkVyN60Xn76v1gWBOZ170=;
        b=DVOA4N56B1Sg6CuUzFVsQlRvWXbzNXBKCTz0xzUgPZvAvLFnWMpk5aYWU2kU+CxJjw
         ply9fgLRZok6StQPH9jjW7g2dcsDskcCdCZBwCFQrL/mVzlhWE9kkmN/2SLtIQdmuNAQ
         BbCNYV6pAtxkCdWbi3sy3X1rp4teu+3erCntX1WjvOqO9/kO/HUW2eY7ZX3vulcg32db
         cJ+LzI08Dage14JHl2vOgS61jJMAyi6q46sgIhGYgwj3QbYL5en4WMNspvQkui6hbmqt
         s35ZB2Mwp6ODel32dZEVZuva24rngQ3PLboKjQpAsAvIlyE8UPCcVL4zbt3z3JgVNjfY
         zlHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1DkLuUHwPzfLjyP71/5LPl8Un5nK7ZXHDUsoA/5fp3WR6rw8IIeR77WmMJbS2fXboJCfpYw67Ajc0ew2rweiGZF2byvhHkWVDzZVm
X-Gm-Message-State: AOJu0Yxm23lsQ11skl5R9oJgLwfcdkqhD6Wku/PpSDEuOdZ0QoHC+Ork
	o+d1uVG+5XcFvKC5ctVcI49sLnnb+ugvsyPX6efVuTHm7jvfjO6fxkeghSwwft8m0vEe8dyyF1+
	L
X-Google-Smtp-Source: AGHT+IEZqckD1nkWxXmgmQ79xLtAR4rFM2Cwj6VP4cUWGFV/ZsSYMaJAIGHngkRwAyWNoCYsL7VrEw==
X-Received: by 2002:ac2:4a81:0:b0:51c:3f4c:ef6c with SMTP id l1-20020ac24a81000000b0051c3f4cef6cmr11075201lfp.40.1714490990784;
        Tue, 30 Apr 2024 08:29:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 05/15] linux/mm.h: move section functions to mm/page_section.h
Date: Tue, 30 Apr 2024 17:29:21 +0200
Message-Id: <20240430152931.1137975-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430152931.1137975-1-max.kellermann@ionos.com>
References: <20240430152931.1137975-1-max.kellermann@ionos.com>
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
index 4a176690ab95..84013f24a6a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1639,10 +1640,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define SECTION_IN_PAGE_FLAGS
-#endif
-
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
@@ -1840,19 +1837,6 @@ static inline pg_data_t *folio_pgdat(const struct folio *folio)
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


