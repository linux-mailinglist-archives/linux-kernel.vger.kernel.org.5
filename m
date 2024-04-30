Return-Path: <linux-kernel+bounces-164279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0E8B7BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF97286DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D517F361;
	Tue, 30 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M6FqqgbQ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19775178CDE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491000; cv=none; b=lAYPr9jbu0pEhi2PbTmoNExsSXIFgTArKhOpUXt+5f+lRRQnckgiRSjtSgeZnKtfbx8q/2jg8gn7b0rAiSuY6iW80H0YHFCNWXY5F/tXGB/g4pW8sVtvYeLr71rP14RwijzW1vdY8UyalLEd0IoyjRSo5WR4P/3STC8QrxSM2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491000; c=relaxed/simple;
	bh=Y7YGGeT9MV/LijeALzbtENqH9NyWjU0GIc0LidhuMOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKc4NRKfbhMuUnerxtpdnWyhh5X8CBKGJqvEWSAcbHWRPtJZNokdfqr9O15mdpSk/kDIvob+FNqzVR4IqkdT+S3I+TpQoh8hN6wUaT8H9gOciY5A74pgs+FvUa4MhJgPbVI77QywZkx/PSOs4/sStVr3ZNEadWMmNaJZKzKdIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M6FqqgbQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572250b7704so6096570a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490996; x=1715095796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEzJZUsSybofDO5VePIm2Jsox1CRrYj7mBs/Ub6qxGA=;
        b=M6FqqgbQ/Zd4J1r0oFjeo45iXtSMQO+TUfKm3YkS8CZ4bnYxgAAnE1J5t8LyoYI6JQ
         LjIH1xbd9lMmML5kaYt5CT59+rbho0VclGnzVEKCQoid6phQij+kjJtjTt5hJgf7cWMu
         +Rk49NWhPWenXAIoCqpF6nXaQ7eUeodMa/qEfyQLjd9sTiyF5CVIWQlkGy2l5hUEYa2Z
         dnMO/5TLwp6xsKom/259u+AJreJcqNfIvFGwkQkmvUXaRrQ+r5B6p8KHUpP610EkBWXc
         fsaKFBYqBKrvglM9SnoBWYsaLIp+m4ZTUQ7udj7oiyz4I1bRcvt1VgfHfzCTXd7VnUxT
         +UDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490996; x=1715095796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEzJZUsSybofDO5VePIm2Jsox1CRrYj7mBs/Ub6qxGA=;
        b=esfANDZwHlvM/EMfFZVjeCvVqYKYciVP/CVhoLXi9/FL3A6vb+7CHrpJ7ekG6IkzxC
         7fAl7rj+PedwVWSCEAfTw8s1u5icgvQBzt/3KMvQho7KDFuocKFZHEohKsCAQOSZyKT1
         Wu39/ayJi/e2ZJp/5nY8p6Ov+QsuRItGLgmEHrn5by018J4x69T4KDr/uTUgx516AtYI
         yO2yw5bahtgBSJ+HucATkPp7SQD4OkGMvr9X4mvGCyBLXgThWsl3zdxjR8IeYADQUmsL
         udoVk1zuFJ1SHxqQ3YlrYGnm0StZYzzALIeyhXYYzStXvuILnJG5CafMi4CdFmNQHQL9
         ThbA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ikOmaiqlwrd82Cui9szeNfK4rpAYTiIh3BdJ/waXD/4UtKqmQowHmO5Kzdvwjm7rUVnabDiOh3EZc64mecVMxdzPUMSG4DJ2MEW0
X-Gm-Message-State: AOJu0YyuVGxm00+LnDquG1XlVAVvZw2ZhG4UczY5oc5eOuAOgBuU2wba
	MM0iZX6oh42+TkO1z1kxjiWTvwqeO1hcpQR9bQSNlwu8unhJjMDp0KDo+3Ko0EY=
X-Google-Smtp-Source: AGHT+IF3UKJzBehHUJtTRlpRdEgQMOH7F5I9fMi9n0Epn453OOwtWzdc/kdfdJOaJE2UzkWrFYbxXg==
X-Received: by 2002:a17:906:b256:b0:a58:a7db:c294 with SMTP id ce22-20020a170906b25600b00a58a7dbc294mr45359ejb.35.1714490996251;
        Tue, 30 Apr 2024 08:29:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 12/15] linux/mm.h: move pfmemalloc-related functions to pfmemalloc.h
Date: Tue, 30 Apr 2024 17:29:28 +0200
Message-Id: <20240430152931.1137975-13-max.kellermann@ionos.com>
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

This is needed to eliminate linux/skbuff.h's dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 45 +-----------------------------
 include/linux/mm/pfmemalloc.h | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/mm/pfmemalloc.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7af85220711c..046f960ef70e 100644
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
@@ -1793,50 +1794,6 @@ static inline pgoff_t page_index(struct page *page)
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


