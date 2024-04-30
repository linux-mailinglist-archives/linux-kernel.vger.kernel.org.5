Return-Path: <linux-kernel+bounces-164278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDBD8B7BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C374BB28177
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2617BB06;
	Tue, 30 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QmDJQ0i/"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153B176FDF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490999; cv=none; b=n2xmqJ6fy4/04J4hccbvQy9dOWzI8f379Mbe9d0U5Dy6/x/jdRSL7jQfZiN80s/QMbRiDDTOzBvOEZX/HO0sarJBqL2wiX74gWxcW0jsQmKxuhPZOPDDYpJkTlsUDub5QSksznM2wFncDvXbCXV5nHNSLAEKlDQ3kJo2hdALTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490999; c=relaxed/simple;
	bh=elHDjSbCblCsA/mfO+fmRJExx3Cm9dPxXBtJKph6c+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTll3om52bihtGhmDIw4N3UrUBr0FDTYmZsd8/a5s682+wg3ORwGcymJiTsIYXooi8Aow8suucw7YcdTCfQopD1K3R4O0Vpa96GpQPW1Li2Cl+qBcEtzusH8axspjV8lOLbUBiutIje7Wj0ADu+ceCL0ynP+xYakA0kJGWdPYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QmDJQ0i/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso957606366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490995; x=1715095795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oorfyqrd4QwX7XzlPeMB1uMNuRLLm4J9vR9colTNE4=;
        b=QmDJQ0i/JnlsdS3fwgaET2hgl9iDEqmOj/fdhIvYZOvdqUCnLnFLHIvrQ3tp0UfHHv
         3+ol+T+fka38WK9fSVScOHAaCDObEkMbExrWHixKd9+mYljNY5z5B7DebmEdXEqgmpgQ
         G27S2wxhGdmSI21MwQ9SAZx26lixw/G7lAn83nPr+8pE20A3ZsFp/67+fWOUUhKuvS2F
         dwge35GlwccDmelh+zq6lkTzKZFjEyf/kG3mVgDPGTCUQr2fb8r+JA/cpJJ/GmN8c54m
         rhaWdd4Eca9bH62sImfa0LKcZqaqmy9WPedfwmArjmkLhCTXbgGd2V2wUgaxcw8ZrmPJ
         SKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490995; x=1715095795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oorfyqrd4QwX7XzlPeMB1uMNuRLLm4J9vR9colTNE4=;
        b=lfjCtNB8WGYN/JCTBClCdG2DjrfctT0aTfF2erGImOjJKsMcpUccLj8sRicgLQNjx9
         +QtlGX0v5ipWZba0tCt7K++u5JWJosGmSMIMshzHx20jjK2aO+nfzgZT/tAwo2fjaYhB
         g99ShygPrItEjbVPrXoEFrOh9p97pPdwTBm1OUZGXzxCt5wzpGb57FKaRC97GDNOjcWm
         sQL9Igiihy2yR7Zma6wCbruqILQb8z5oP8NJ625BVnLWJbyMlHM6UKFEqqodvTxKEds1
         qzyk1g3sEEqPoE8Bi+NF4FE23EM15HnMpVe3MqWRQEChEpS3CDXZynDYv6mkKTpQO0+F
         GL/g==
X-Forwarded-Encrypted: i=1; AJvYcCV/L/KiK9JmrBwCUAByf1PkWvOTNFEtEtLjxoQV+LddBFQ30tcyVwSh8xvtuE9WnDxOiNyRnkvgPs6j51HbjeS1SeOAH7+1rLpmqLjQ
X-Gm-Message-State: AOJu0YxPQ029JlZpvlm8D0gQVQ6uEV02qsR3POsKfwU5d73R31c9n+iu
	ipDL6nV8bqm9RnJQm7zNELzDzQmjsxmw5QVCN29uuYgCJLN8bCloZYOHtY8yOWs=
X-Google-Smtp-Source: AGHT+IEvp5i5JRkITPWTjlJ3U3QwiTNFAq2awThpXND5syZ983MA1H6lBc0Vx2slfoNy4Dv1ockB1w==
X-Received: by 2002:a17:906:c791:b0:a58:eac2:a54f with SMTP id cw17-20020a170906c79100b00a58eac2a54fmr99681ejb.18.1714490995492;
        Tue, 30 Apr 2024 08:29:55 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 11/15] linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
Date: Tue, 30 Apr 2024 17:29:27 +0200
Message-Id: <20240430152931.1137975-12-max.kellermann@ionos.com>
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
 include/linux/mm.h            | 48 +-----------------------------
 include/linux/mm/folio_zone.h | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/mm/folio_zone.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 035e56e203df..7af85220711c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/folio_usage.h>
+#include <linux/mm/folio_zone.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1377,33 +1378,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
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
-int page_to_nid(const struct page *page);
-#else
-static inline int page_to_nid(const struct page *page)
-{
-	return (PF_POISONED_CHECK(page)->flags >> NODES_PGSHIFT) & NODES_MASK;
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
@@ -1554,26 +1528,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-static inline struct zone *page_zone(const struct page *page)
-{
-	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
-}
-
-static inline pg_data_t *page_pgdat(const struct page *page)
-{
-	return NODE_DATA(page_to_nid(page));
-}
-
-static inline struct zone *folio_zone(const struct folio *folio)
-{
-	return page_zone(&folio->page);
-}
-
-static inline pg_data_t *folio_pgdat(const struct folio *folio)
-{
-	return page_pgdat(&folio->page);
-}
-
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/folio_zone.h b/include/linux/mm/folio_zone.h
new file mode 100644
index 000000000000..3f3e4284b911
--- /dev/null
+++ b/include/linux/mm/folio_zone.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_ZONE_H
+#define _LINUX_MM_FOLIO_ZONE_H
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
+int page_to_nid(const struct page *page);
+#else
+static inline int page_to_nid(const struct page *page)
+{
+	return (PF_POISONED_CHECK(page)->flags >> NODES_PGSHIFT) & NODES_MASK;
+}
+#endif
+
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
+static inline struct zone *page_zone(const struct page *page)
+{
+	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
+}
+
+static inline pg_data_t *page_pgdat(const struct page *page)
+{
+	return NODE_DATA(page_to_nid(page));
+}
+
+static inline struct zone *folio_zone(const struct folio *folio)
+{
+	return page_zone(&folio->page);
+}
+
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
+#endif /* _LINUX_MM_FOLIO_ZONE_H */
-- 
2.39.2


