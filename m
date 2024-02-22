Return-Path: <linux-kernel+bounces-76458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1485F783
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7012D284377
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8B34DA1F;
	Thu, 22 Feb 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="L2LLVJXP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045014CDE5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602676; cv=none; b=qGdNNSXWA5mVzXpb9kPyz9eZTQ29pO/XXqV5THKba6H7nZC09x392E5SJQ9R78Qj8zJUyVKya32f4H9gJTXfQbhfEmHgZfe0DBElEvf4hjSpffsXxdUc1V6Q5kZOE5+Dqgn9tBundnEgvuBmdwkhUjHcw+8eKx80ul8Z2peSjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602676; c=relaxed/simple;
	bh=MZvE3LEuDYWnJOlrzdBWCDdF99dM1xYbBHWyWAdVIM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYLjzDRAFo53D5UpDUp7UXHDJ1hSDdTAvtAtSsxkmFQi2ETNqvvYZV4RMqWCtzFTPWdyP8okzlfuYheHTO46lzb7FNV3qtUdrT3u5CjyQbxqqVcyoTLerWap+773iGh/URr3WRivGOSt7T8ZmYG9Bl8c+MqI433is00XHlfzV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=L2LLVJXP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51197ca63f5so9045008e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602671; x=1709207471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFa9Dx9xV4GQAl7iRO46X+jLcP69enhwI/ycHUy9Pls=;
        b=L2LLVJXPdq3wDlYsmcsWTrfWJw5+HdXSLNNpfQg+gPbWW6UqBT0Tkc0YDIS4Q8T+T8
         /FMc4j5oNTKDDYQwdvdPNPmBXgNsHg34stD+gsM+2vQ+TVuW5rqPXMWejTU/6vnC7Z6F
         0Scd1wFPWu88gLkKmBZe3dnvhmH1OM4qIHU4YhAm8BRyiaCb3I+IgydsQNPCpBFyAsIS
         wiOykrhmk1pF2dQ6S/opdPeSK+7YUC7SsjqbFW5LJfnnPoshYmgFDEYJ3+k3bugBwpRo
         0oB9tzB2qYRjtpxe9uyNsjZYjVtb7sXRDWFxpzMXrPBclf8iLaeJ5Vwx3TB5yk4Kuc9R
         IgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602671; x=1709207471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFa9Dx9xV4GQAl7iRO46X+jLcP69enhwI/ycHUy9Pls=;
        b=CsPbDjeMXcBUY3sOaJ6maVmWCPwNXrwgwI8A8STgEisOiJ1If800q59dEEhmDwVMJK
         YZMoMm2mqql5/NpmTE9I/SxyIom2k+1/mfErvJDCn3J8huBChmXY7mfH2OXLXgi1uWhP
         Fx4bTtfz6PSYEtMOQKZ8j9Jw4MHh3Ih6zbFt/K0f81qdZoJlAruueA3TMFDMXu6Rk8GP
         bj0ro96EzfjU0FBh821BaWFOE7F7AHWtmdcu2r9h1XkE4GUu+u1KpyXp56j5uG5bPXjB
         QHKEzc59P5SkyzAcRsRRcIg2jlSmAOLmyiUGCgPhFrwUe4UnqsvQWLnmfEn+KNe+LaXH
         PbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHE6wbfQo8A5RdYv9gHs+0PrLkM3IJ4Bqkvhdf3gNqzoHGh5MhARaEyOjPY0BcODZ+i9NRtW4mzzWuqq46gOx5qHJGO1Omb1GiQtid
X-Gm-Message-State: AOJu0Yyv+XNoe+YgUwIJgTq1fc38HZIIPp3q/i/TuQ2du9y4pUgo7ODk
	ecSF7tcbmVAi9YQaio13/hAufxTufOW4MODz0+IIRazIsQDdR0YvbpKUzbIQGHE=
X-Google-Smtp-Source: AGHT+IGIO6dtLuYV1/1VqNo1n3zSBkE3XkdIVv4w1GdYfmtSErj42ytjrkrSj0uYvF/i1uTgxDlvlA==
X-Received: by 2002:ac2:4a68:0:b0:512:a37a:bde2 with SMTP id q8-20020ac24a68000000b00512a37abde2mr9448627lfp.67.1708602670967;
        Thu, 22 Feb 2024 03:51:10 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:10 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 10/14] linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
Date: Thu, 22 Feb 2024 12:50:51 +0100
Message-Id: <20240222115055.1172877-11-max.kellermann@ionos.com>
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

This is needed to eliminate linux/skbuff.h's dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 30 +--------------------------
 include/linux/mm/folio_zone.h | 38 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 29 deletions(-)
 create mode 100644 include/linux/mm/folio_zone.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0dc38017e134..1297ae7b2541 100644
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
@@ -1363,35 +1364,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
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
diff --git a/include/linux/mm/folio_zone.h b/include/linux/mm/folio_zone.h
new file mode 100644
index 000000000000..8ebcdb57ee2d
--- /dev/null
+++ b/include/linux/mm/folio_zone.h
@@ -0,0 +1,38 @@
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
+#endif /* _LINUX_MM_FOLIO_ZONE_H */
-- 
2.39.2


