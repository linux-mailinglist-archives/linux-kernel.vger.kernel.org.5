Return-Path: <linux-kernel+bounces-100050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744D879136
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC351C20D35
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4A7C099;
	Tue, 12 Mar 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XZoEYIcn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B337866B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236524; cv=none; b=h8BbgNjWGu73RiN//rvoK4b+FnmXxxCh4YNkB84NlN9Fco2hugeFE/uRX0V2siiSwBU8kSYmmbew7Lfg03VB9STyzW14omLgrlMhDpI3OEd5gvqLVvIbQMnuIMyUN0R6PZGaQjTKeJTlLE2rAPJVUydCm/MsedBp5ezQ+W8xkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236524; c=relaxed/simple;
	bh=NEV56k/1bcmu9rz0L5zz1lY42ec57ywMmk7znO1WYnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdGLPFTMhZt1iOOsBcwrFjmFW/0mfrau7CRSQvOKj5tp/uQcNqcek1Iq+HV+QQavqwR8X2XjcIn1pG7hIn5uqW4dqu+9t+recgse7wreZ7vgALwXm5BWxgbxXEA7F3ovzjvKUfbuU+wlPeVIvtPuY6BXm8OfetDOu+1fjFLnYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XZoEYIcn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45cdb790dfso545729566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236520; x=1710841320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC2kNgBeF7Vel8Ro1rxtb7kBWctFnYPn6ChmmeyuWYw=;
        b=XZoEYIcnINJYx2Q82RNXNLwqjk6pwQ37uDR2uhQ7M8w6V6HYDbrK4Xg3IfBGvIf1Jm
         tEmRQVqCYSyQGExekQpXNh3jsZ0Wn6enxsEtjWLetmMfxA3DfBZKd+tqvf7gz6T0Ghw1
         fWXHcYOaxTOwKnrU3Qhl305pJFAHfQLE70B4L6msNo597GoZ7TBmzW4n6OMi1lHvFNQ2
         7i9df18KtvTckICKTQFc6X9HJMt0tyYi1iTXUqLVSbHffSG5a9xQjEeQAPE97FZbsP3q
         Iek3MMH1UXnu6DAdjmJVBNBtZoYawGsdiRtctKio97ePwLkQwKw69r2tlQp9DyBaSVMJ
         o9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236520; x=1710841320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC2kNgBeF7Vel8Ro1rxtb7kBWctFnYPn6ChmmeyuWYw=;
        b=U+jsh1Z0YK6rucMOclTgB2RzfGcx6L+EShQ2DeSNH4Al+tVt4zvxwFRXPC2yvcvtii
         /+gmD2UP/A6gfsgtmdlNRjQ5vSJv7LMLLFM23DWZ9VuKYhGGRj3dZpvMSRjFz9a7n/Pn
         0jhsiH4lvdaFcpwNPCSZYvnTUs/OSqBfnHz0dYldg96fpnL8ZpqPoQKNhnhMOz7UBu1c
         9/jlwrbiMgHfiZejn+QrId3wswg114xCBpKMvT+wVeyu0B8cgfXxI9jnJY2uRp1GlYNV
         wKdnbZKzHduEc0Hl+5f8BjBWxtf3zFwz097eAerCkdD8uIIcFupJ0+0sIspzjo9vPdc0
         5k4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJOswxNLxxBAzcnCV1xDNys2i4da2x7Ff3aop9e5gyZCsU2xtJT748sg3XCK3yjaAsf4sN39ZDgRU/WBMs8QLWYRTRmEpGDaSG646h
X-Gm-Message-State: AOJu0Yy83RIjlb5PpCDOjmk88MJnmDfiIMbD6Y6XOVf72ODcvG5/lDfK
	7P9g//7GsM5Abac0kp2w2nTsLvHzsPZLb6LlM77vOEHr0+QI4toyecZkRWfxpvQ=
X-Google-Smtp-Source: AGHT+IE7UDJ1nLsSaEjUG1+PH6IJCzOExfGwyVhrMeJ4rHCcxaB2l8oErbSbMLUVuRymbgh224TGQw==
X-Received: by 2002:a17:907:3594:b0:a43:f182:66c4 with SMTP id ao20-20020a170907359400b00a43f18266c4mr5390555ejc.17.1710236520620;
        Tue, 12 Mar 2024 02:42:00 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:42:00 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 11/15] linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
Date: Tue, 12 Mar 2024 10:41:29 +0100
Message-Id: <20240312094133.2084996-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312094133.2084996-1-max.kellermann@ionos.com>
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
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
 include/linux/mm.h            | 28 +--------------------------
 include/linux/mm/folio_zone.h | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/mm/folio_zone.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e8a914e7bebd..b3f83fb26aca 100644
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
@@ -1370,33 +1371,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
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
diff --git a/include/linux/mm/folio_zone.h b/include/linux/mm/folio_zone.h
new file mode 100644
index 000000000000..572fe37068f1
--- /dev/null
+++ b/include/linux/mm/folio_zone.h
@@ -0,0 +1,36 @@
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
+#endif /* _LINUX_MM_FOLIO_ZONE_H */
-- 
2.39.2


