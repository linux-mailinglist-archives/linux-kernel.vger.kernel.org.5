Return-Path: <linux-kernel+bounces-67115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3648566A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D3A1F20FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA61332AD;
	Thu, 15 Feb 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bztQzl4Z"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF0132C2F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008979; cv=none; b=NT2NAl/qvlkuZh2ZbyBjQNSNlkOiF+JMjjD4GMRBI1ht043LhmKvu9FhkOl7rILvC+Q5LLOsP/2W9O/bx2vFVgLu2z8rAnGU9z81/dK78tUyNPE5ypPy994KfhtkqObXuCEfjjWM4WsfFwrDqg93MDIgUnRvtGDOjZyTgLJHLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008979; c=relaxed/simple;
	bh=IpD67k2gO2M25PjFyFyPuo75aV97Zro4npvwo0DmQ38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bc7Tf3ENlFLg2KPEXMvAhcoUK5Kg6LlRWg9FY+8p6w4xWVvEsM1e+gfjH+YeX9O9f7L2yja25li5ekO7EkPKh12nvo+UexR8oKfnKhWZWaQD48y+tO2sg7uSjvw2lbPXzQzpRnEYpXN2fnYI+Lw1nFd2WpvNW6CMoKbgd6Qv4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bztQzl4Z; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so1643198a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008975; x=1708613775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOKW+J+Ft2qh+SDtx4ZJQpIK78L9+qr7BGcqORkx+gI=;
        b=bztQzl4ZWifAlujdj5vU9b7rCWYZYBstWPTPITzvBWGyN1/pHG0qScI55r+q8KaAx3
         KHzVRcW3GzPEg7ORfzTUY0LUM3nGBbzwRU/YQ1Z+5/SFj0VS+5G7+NvvMnFY7rrg1HYU
         4gpwyIDo4L6VIKhsq1MEKP2NyPNcqHFO3yi5w2sdB8ODUwYIpPOegcMBTbf8YrC+Mkz+
         RnZKMnkTYQGf4Zyz81ky/hzMIxtMYoiZLyt8bCXppFg0EFZLC66bukU5zTkc+azqGr1J
         nTv4YBvZPQGhgN+gMTg8TyLx4VnQguMv6nd896V5LXUS/kCp2QMDSBClfHNF+cWMok5F
         kI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008975; x=1708613775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOKW+J+Ft2qh+SDtx4ZJQpIK78L9+qr7BGcqORkx+gI=;
        b=vUrtpSxJPYIBFG3qktOguRsMsNlNRbVUKDwgYkgCgRjUyvi6J8ZCSi9DTAJFBBAFL5
         LItniHAMG+5S4rO4N0nnd7InZUDzn0qlo+RW2E6VJe1T0t1N+MsK3BvMBlhVg0MQlqsL
         Qkn7DUkeVV5oc/vqLoLARYytlpQeBSVrgm3hkLRcls7L0AnifwbHM12WxIP4eA3Ct83G
         UfxgT23KrOqZz0gqKR9YO6akFYsRDyDY1C/2uYQw9nnIn0IIZC4fWjiz+9Ijk+yhXNVS
         XcnBPTLrKkKF9ipZCT0tHiZuiGSj3q5A1THcNYKLBBqteKReZ5fAIo/S/MYjc9aIAPys
         mD5w==
X-Forwarded-Encrypted: i=1; AJvYcCUCcAncWQI1m38cwMH15xWw74HokclRJup0MPtVO1aFTj6d+03mlxXWuDyxUUHa/TNiHS1Twnf9FHmSj2rfY2T0RpJDVynCvj81p3U6
X-Gm-Message-State: AOJu0Yxd1fiimwArWZD1M2AfAH98hRfLepZmuZjzaLvBiwW+HemNHw8V
	7WlgZ5UQOM9O8LaIiW0qrfWE3WpAf+hARTDt+uXdLI4koo+OhT03Jfh374mJoaw=
X-Google-Smtp-Source: AGHT+IHmFd2m5CBKvzK5k3i8fLODdswNsgNMEnNccU6hMgsi68rJFyx72Ggm1uvQlSg441yXaAhOiw==
X-Received: by 2002:a17:906:35c9:b0:a3b:b947:af77 with SMTP id p9-20020a17090635c900b00a3bb947af77mr1309692ejb.67.1708008975496;
        Thu, 15 Feb 2024 06:56:15 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:15 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 04/14] linux/mm.h: move section functions to mm/page_section.h
Date: Thu, 15 Feb 2024 15:55:52 +0100
Message-Id: <20240215145602.1371274-5-max.kellermann@ionos.com>
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
 include/linux/mm.h              | 18 +-----------------
 include/linux/mm/page_section.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/mm/page_section.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index decc0cb8ed32..84a49178b94a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1622,10 +1623,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define SECTION_IN_PAGE_FLAGS
-#endif
-
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
@@ -1825,19 +1822,6 @@ static inline pg_data_t *folio_pgdat(const struct folio *folio)
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


