Return-Path: <linux-kernel+bounces-91943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E48718D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369741F21ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD556773;
	Tue,  5 Mar 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Av01YWKG"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BE54FB5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629190; cv=none; b=WwGVpSCnNkT0YA5y1YkHE7/3QMqGbFV+fJ8s7O91sxO+bBXBSBKtF9Sy6LWGjz5kil/dpCggTEBdT8FxCK2nOffpUOMSUnkZ52oiFYL9kXk2diDdHpAcCYOp9awqFbN47oWzGtwFCoWUzCFOmNkxhvbDTBkGFPAmjmDLCmA/7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629190; c=relaxed/simple;
	bh=gvv5QAtWzHwpsz/x1Apq4Lva4NNrjhRHP3W2M/SGVoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LfcAxzZUfAkbuWSdSFAMlr17F4TgNqknuM+vtWbTjhw18uqfKeAUmTOjX+bQUd+++iH+BNrfwE0ReBUSlUNxAALTAAjakpLjD02JMHCFmXr721c6+qmvNT6qNpSb/wbPDg9pT6CwhL1/5RfZt+xzYPlG4Rq8ATgkH7bEc20Hf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Av01YWKG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5672afabb86so2073549a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629187; x=1710233987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i50xlwbZc74AakEZHNdRuLF9vXbOX6ErFGehWmkuapg=;
        b=Av01YWKG56143FLyXuR/VOF9CC2vjqn/UcUkxVJbrP4iYpGlPBcE5tVLf/CI3Onunt
         +M57gaSftQ3y3bD/dWYxEIgC8Ak/XbblxYlRG69wovBA9Jhwflx6RQnlCSHsCgrxw50l
         oDmHyV6lPRnkI1bVMH963jsamXvmkoeuG2AaX0R2aI4Ti9CMWC0m7+hwOaAyLfTl9tus
         zGlZn1du7xNIESkky4mMQz0J9RuU6gq6vAvNPPc0Bul34ig+u8kWekeFYjSlzyGZyr8G
         pgDalVlVGLWBQE0RfEZA7DUIB7BnjJmKxnHhqCs6BZb8S0JYWe3YlJdQUq3cNPh0437h
         WHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629187; x=1710233987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i50xlwbZc74AakEZHNdRuLF9vXbOX6ErFGehWmkuapg=;
        b=NfI/3y+NjsOb2qtNaqQ88mC8jr1A+dpIPKqO3I9JZiUO5kkvvcus7cY8atXePkM0rm
         MwXhYPHYEcT/OjFon5luCaMOzxkCxOM2S5DvvHVENy0WplaSDz39+kCQ9CT1F/6bsk+j
         KefLuWAQHFmhfqyUwf2WfCmOOFMJ0KXxC05faLpsGITOlcAKmBzvXHHD5YBrgzHM1yQC
         Rk1wJifoX82jrmtNVmesadmngBgwXMLxVrPcVVzIu4HAg5yGdurGgolWFezVbF9nUAbp
         gUujpGbelwtqu6rsm+DNSH8QidFogP2rGzLSvF7AyvLjA4is4mP7FkdOmjJ1431ex8eN
         D1wA==
X-Forwarded-Encrypted: i=1; AJvYcCWeSZ0oG7uAnzUbS+hUDqwJ+0h//s5dw3NQ9thyjHvJ3NX8bOrzLpmJCjiWd9XHlyOlYJjjqLRObgPwyMgEPWXWN1Cfb3guStkAhJI2
X-Gm-Message-State: AOJu0Yxvm02+WJSne6Yi59kJj19CorwLbUWwI5wnPemTilg9Aa9JSfGR
	9JpJZSb4gI9GrSlKY65cl5U/zhfvdqYEffVq/xM/FCgN58AHWBaGDzb8znqiGYYds0F2KzfQrK9
	y
X-Google-Smtp-Source: AGHT+IH5rQymVzDyRd5/kVEF3MMnB3QjDXj4i4rk7c4yzXXCC29AJ9nQ021BYHQfLPW889VaZHI1rw==
X-Received: by 2002:a17:906:d114:b0:a45:ac31:4bde with SMTP id b20-20020a170906d11400b00a45ac314bdemr450647ejz.29.1709629187311;
        Tue, 05 Mar 2024 00:59:47 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:45 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 11/14] linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
Date: Tue,  5 Mar 2024 09:59:16 +0100
Message-Id: <20240305085919.1601395-12-max.kellermann@ionos.com>
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


