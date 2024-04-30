Return-Path: <linux-kernel+bounces-164271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153658B7B95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353151C2279D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7F17335B;
	Tue, 30 Apr 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RYXJw2bT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A45143749
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490994; cv=none; b=t2vZDYqmfcBWgybCc4RPefyKXHZPpS4wjMnZJkYa8MB5nohF7ivRT56g0JvUNFCg0B/fSy7aZt++/rYn2mNgX8cJC0RR9CDbXWKLwSu2OOyCtZfz0ovs4XjdqU15uJ5TaIHXLCJonq41Z3Rc0W5qfRoLIoIQN6RJVVQcXUfctZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490994; c=relaxed/simple;
	bh=9Yijw1wYv6cRm9bVUnIw5mrw+iBRIoCbcWYmyxR2ih8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4r8Fhe2+FVzhwJbSxU0zfUtOCzTwp+6c5oIsXFOWjbgELI2YRJoczac7jP5mWkSEWPgRiCq1klbQDDN/naJmWTiYuJVOZKBZkTyPrHqGAXmjfKmNRgrLpLgFxluj0WKCgsLCTnBOfZr8DeqImM2GvvdlSaO0NjLM7R82wJ7EjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RYXJw2bT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55ab922260so772651066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490990; x=1715095790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zWX/z6nYSF+/tdZF0rQrJaKpSzMmIZva46DvflyFrA=;
        b=RYXJw2bTeNNjPnV9/BSN6mvCqQewPqRBOysFqNjfjVr6qhiW0rFgclGDOlwM+2WIks
         jkNm7HwO62O8MtMe8dJISXsmptF/jugs81cBOawwIo9ybigQZTHL90tYTkqV+dWsj0X8
         rB+4QLwtyjy10kzTJIDjapake/tKlnZoMKiS/bheyNNUboDzyer3dVQeVd0qAFMpOuow
         Zschksi9BXrXNOwpaxle4SiKdLKy7qWkPvf9bSdot7hmNnJcdBbcXlyen1mIPqHO9qLF
         IKMrkjlfDNIDJCpfaRob+T+WkrGYeP7MvQcuJKxfYiKyfr6MhZA/VBATZT5mghbv9Kot
         GG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490990; x=1715095790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zWX/z6nYSF+/tdZF0rQrJaKpSzMmIZva46DvflyFrA=;
        b=Mnf0bA3fn00xhHUIkj5gQNP0Q+YLeSlWBhmBfiwi39PPD7sQ2hxiq+4pMqqg8YWIW9
         Xx7E8gzJX32+4qKEvRViZsnkiY7DkmbQbmRJd0F0LfMOHqbq9vVMEzVuC/T9xAflDWt6
         hV9wCSIkecWi/6xxvn0/NR6vrvos1nLb/IrAjhtP3AhYQa+evFbzpfLn5V6EFBKvU5oA
         F+7qaJ066qJc79SfyWFvF9r2rrKJn+zVx44FzhEp4JvjX7JiLffEJsPq41E7IyXz6+Er
         IQTd07CPP0X9I7TqNkHUsbD8WhvcxIal6exap5IcxtaEISKFm1AClPxnkwpSvMaLxPGh
         sDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzLCjB1FOzLa/r39u8YPLBAxAmXHYLZwfPn5bFMqNq/yBGcjR+ik+SSmauB4RU80blnMQ4ugZ1M4gaYb55yQPKZBta/yXLOdOIIod6
X-Gm-Message-State: AOJu0Yz1eFjlVFKGm1RM9JbUcE6IiO7KVAlWNjrmYBwQzrEfv3btiBPx
	xG7yYOBbHiZABkzP1ViaG4Ef61wHZEFWXkykzCilO9gWZB11M7yVblnm+gLdnaQ=
X-Google-Smtp-Source: AGHT+IFI9+eHfJPwg0KmGKTIU9F8oGfKNRqJhbeLvPRCs2L2dSMFQ2rnIpwCHqmm8+2/A2Edm99eJw==
X-Received: by 2002:a17:906:2a44:b0:a58:7f48:18c4 with SMTP id k4-20020a1709062a4400b00a587f4818c4mr33388eje.68.1714490990054;
        Tue, 30 Apr 2024 08:29:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:49 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 04/15] linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
Date: Tue, 30 Apr 2024 17:29:20 +0200
Message-Id: <20240430152931.1137975-5-max.kellermann@ionos.com>
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
index 1c4bc4b4e388..512f67555853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14380,6 +14380,7 @@ F:	include/linux/mempolicy.h
 F:	include/linux/mempool.h
 F:	include/linux/memremap.h
 F:	include/linux/mm.h
+F:	include/linux/mm/*.h
 F:	include/linux/mm_*.h
 F:	include/linux/mmzone.h
 F:	include/linux/mmu_notifier.h
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..4a176690ab95 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/page_kasan_tag.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -28,7 +29,6 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
-#include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
 
@@ -1820,60 +1820,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
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


