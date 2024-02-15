Return-Path: <linux-kernel+bounces-67121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9E8566AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36E3B27ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D313472F;
	Thu, 15 Feb 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fU2MgR2i"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F813341F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008983; cv=none; b=ngySZxBp1nkeVXJpgFl40lgOpwKHHnRAk+FEWFBp3UzVpZIJKyC0b63ZFNzbKJlA9I6wzHmEVsgScIskZlHMFHBG6XwefeYhQleSNALg8+8xEPI9N7e5GY9tCUURa25iTz9bhaXdbD3Q5FldhW8sGnKbG3jB2DaddNEunt1UY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008983; c=relaxed/simple;
	bh=v8Wtk59h+JThQSBSnkbFVz52gm8jfgU5BR/RyxD7PT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZ71V8A2OcApXLlAiX/5ZDAE/rZBJOVw0z4RqcySi8zm5/8uGUeB3S3g1lkFWVuxHFewztJW98/vwR8fCaJlhZJB/yhEGPzV1mLAYbNZAD/Zja3GwFH5tB6psIgxIrMjsMc67VBewTBAYLPyQCc8Q7+HAfjBegf9ju/tHPLkJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fU2MgR2i; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso660027a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008980; x=1708613780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKsp875PnvJuIa0s07e10KRuMSwJl/UB/2fWYWucGxo=;
        b=fU2MgR2iUTgCRKCJ5Le+EVU7pJ5UiJwyG7Fvt+S6CpKty3ReCru/Wva6FH+JCQWLng
         CDLeaiAL1tAiAauNRropZcrjY0+xxU9jozK9tZqQbpUfhffHvvNfgyDcenEtgE8am050
         2So+XOcyQ7hkGDGkN5FDYI3xI9w1p27dmEbGYSCcJ7rrWqLy3btJNG6F9oAGBjYUYhn2
         tP3SfZD8n+iTGJWLZhsx3NQatM+dZY9ts2/Oo4vfT5rkK++NxFhYTPXpMR7pQiQ1j7ek
         qZAnn6g3lWGnKhms7czZ05dOU5+AI3WeO6l9C0EXR0pHHL3TBA8ZzZAbp5lmMUDPxhtK
         LO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008980; x=1708613780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKsp875PnvJuIa0s07e10KRuMSwJl/UB/2fWYWucGxo=;
        b=aEVChNYlBNnys1RuKWpcebSHYYOIIr1cvaJRW1cTj8ddt36S83bbYIROPGKi9lZGlG
         uJCYGLgOuH0Vd5hTGYIYIZRQDRHCYfQOBbuMRRuPn6fUFtFOmMn9W+0JONmuXRuPgcbf
         thL1R6HxrsQET08Kzva/i47LmC8lYRNLVUNvS17vXIumujLoyPz2mEHbKe2SgP9soHgR
         ZxUfZp68hpWqNVJrpl4M5+1dSU8bPhvpPfzmTYW9jj2apOt3gnuUiNtHnxPponNXILP5
         +tpXJVGYzdSJ6e4anCYBuGUhQ1i6381FfLZbAO9R3u2TPTmAm1iL0Eqqz3bm2q13E1Ex
         bTcA==
X-Forwarded-Encrypted: i=1; AJvYcCWsdaX9mrosU3uevWJr9HK89KxhN0NF6ZH1qoPKQhiIUJ2oFIRKAGcCPjGeMuRHb2iixJUCk50l/0KuL/0HHlqA+xiwciVpHuwqPYFX
X-Gm-Message-State: AOJu0Yxmr798HpfCdKNfi3PS4K4KqPKpVvpKGtNBrvSWfDQIuj0XT1MY
	phQYS/AmCCu2ZJ7/8ibmQEjzCmxU9hdi93PAp4EeC84+AbtI9x4viPjAbljQ1N4=
X-Google-Smtp-Source: AGHT+IH5yGTXkkYLGBHGfcaxHapm+uOnyxEcWP/yZTJOKq1Do5sZaLON8Um9ALDtXnu5fhpKYHSzQg==
X-Received: by 2002:a17:906:34cd:b0:a3d:b317:8ac9 with SMTP id h13-20020a17090634cd00b00a3db3178ac9mr499801ejb.33.1708008980212;
        Thu, 15 Feb 2024 06:56:20 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:19 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 10/14] linux/mm.h: move page_zone_id() and more to mm/page_zone.h
Date: Thu, 15 Feb 2024 15:55:58 +0100
Message-Id: <20240215145602.1371274-11-max.kellermann@ionos.com>
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
 include/linux/mm.h           | 30 +---------------------------
 include/linux/mm/page_zone.h | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/mm/page_zone.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 26d506ed855f..aa24e6fed9b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -7,6 +7,7 @@
 #include <linux/mm/page_section.h>
 #include <linux/mm/page_size.h>
 #include <linux/mm/page_usage.h>
+#include <linux/mm/page_zone.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1358,35 +1359,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-/*
- * The identification function is mainly used by the buddy allocator for
- * determining if two pages could be buddies. We are not really identifying
- * the zone since we could be using the section number id if we do not have
- * node id available in page flags.
- * We only guarantee that it will return the same value for two combinable
- * pages in a zone.
- */
-static inline int page_zone_id(struct page *page)
-{
-	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
-}
-
-#ifdef NODE_NOT_IN_PAGE_FLAGS
-extern int page_to_nid(const struct page *page);
-#else
-static inline int page_to_nid(const struct page *page)
-{
-	struct page *p = (struct page *)page;
-
-	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
-}
-#endif
-
-static inline int folio_nid(const struct folio *folio)
-{
-	return page_to_nid(&folio->page);
-}
-
 #ifdef CONFIG_NUMA_BALANCING
 /* page access time bits needs to hold at least 4 seconds */
 #define PAGE_ACCESS_TIME_MIN_BITS	12
diff --git a/include/linux/mm/page_zone.h b/include/linux/mm/page_zone.h
new file mode 100644
index 000000000000..6bbd46743aeb
--- /dev/null
+++ b/include/linux/mm/page_zone.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_ZONE_H
+#define _LINUX_MM_PAGE_ZONE_H
+
+#include <linux/mm_types.h> // for struct page, struct folio
+#include <linux/mmzone.h> // for ZONEID_*, NODES_*
+#include <linux/page-flags.h> // for PF_POISONED_CHECK()
+
+/*
+ * The identification function is mainly used by the buddy allocator for
+ * determining if two pages could be buddies. We are not really identifying
+ * the zone since we could be using the section number id if we do not have
+ * node id available in page flags.
+ * We only guarantee that it will return the same value for two combinable
+ * pages in a zone.
+ */
+static inline int page_zone_id(struct page *page)
+{
+	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
+}
+
+#ifdef NODE_NOT_IN_PAGE_FLAGS
+extern int page_to_nid(const struct page *page);
+#else
+static inline int page_to_nid(const struct page *page)
+{
+	struct page *p = (struct page *)page;
+
+	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
+}
+#endif
+
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
+#endif /* _LINUX_MM_PAGE_ZONE_H */
-- 
2.39.2


