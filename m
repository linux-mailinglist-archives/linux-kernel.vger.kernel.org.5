Return-Path: <linux-kernel+bounces-91941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2158718D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB541C2109F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6655E54;
	Tue,  5 Mar 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="jOcq6G74"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360154911
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629188; cv=none; b=iBSCADBT82Ov2DVO94J+rtCnfPFW9RGVIaQTdm5x7qkXdlUrrMeyR1a1jY3axxQ7s55vMA1hYsTOJMpXJH5hSpdd7W+6cethxwNT+CLImjbtxMUB8jTWLfNHCqmgWMEQ4Qd1WPCL8knJkop/ujrmsqBpIVVYu/rmqM6gpJLX36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629188; c=relaxed/simple;
	bh=NEV56k/1bcmu9rz0L5zz1lY42ec57ywMmk7znO1WYnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBSGZ5hvDHDQjGSa5JMzKfVkt8tjgfgsdB0UoMPttAA4W0Xpsrp2pL33pT+sk5LZSx5E3CQcyZbo2isO49l3yHxFKE9SNEUq72tsH+GacPlTKkIdxklYY0Sdt00+D3Oy0QqJlw8sQPhpO2+56vqaDsfrLmHHisRypUITfVUV5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=jOcq6G74; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131c0691feso6867360e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629185; x=1710233985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC2kNgBeF7Vel8Ro1rxtb7kBWctFnYPn6ChmmeyuWYw=;
        b=jOcq6G74Rc07ASO8mK3PxKL1NYEk44fmDWasW4EvglPNWz2/4zlfEh2dtZfSUyseRD
         P4H5UmGPLZgYjEXP4MaNUkpUoyyniPTmrZFZMrQB9IebvpXi00b9HyIgwwhzwZHnYiNx
         piG4EfHNQQGXv5ArkwoZ5fdOXio4zF7i6I8ZywL3tv2KI+OnD6d4slM/zm9tXemrjiy3
         jlbc9Ek+o48+EzeSquaAbxD+zPtMQgUeCcqi7t8QV5hQyW9JfRDuUSWPyml08prI97nO
         oOWidUgqLziEYJHe5UmqoQFrKj52dBXa9r8HjO5BXPV/4hXYM4V9Ok6YRxXNqUB1Dknk
         sg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629185; x=1710233985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC2kNgBeF7Vel8Ro1rxtb7kBWctFnYPn6ChmmeyuWYw=;
        b=rHDSCPpc/IINEMNoOpllUjpBObJ5CIKvVk0v3qJH4h4us87Z3O7cF1JwJfNFO0dxPY
         Zif+59wJFZ1c3hSciOxSMnEWYkJTmyaNDjWP7q8yl6BnPOdbUCXXJ83Cnx0Q7cX3rRCB
         wZgCyWTdpD/oLW9107nhNn0ggnclK8ZJ6U3Kz9rDnFItdppUEpWa6EC5nA0YMEqf7OAy
         SxW+Vh7WVMCOGeTHAulQAlRmCn15ijh5xMAEUlW9U/O3ET2abALLf36bJyFv5W0kR4L7
         MTYyRQ67KjiHrx4AWl8KaNrSq6YWoT08ibdWikMgRejfHIGBxh5xtnJTdtXG/TQ+lKjp
         V/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPyDtPYRjjgASP8zPoiWRmKGAdfzbiG/yqz34Bp4bL9cU/myjtXVdd+j7DmttTDCeEClAm2ChdaaI7etyl23diHzxhnLSdkjQFF0xs
X-Gm-Message-State: AOJu0YwYqcSYcScBGsiAUfsOAXGSO2l04ZOGhCu6NNxQ2PC931fT0qNv
	6IBT6uV+aIMPL9fKjLr5oI1t2wk52BT6WxuYucsbzrSsm71jS/dbbZteJg6L9hy7QCnRCe5ICBw
	4
X-Google-Smtp-Source: AGHT+IEOCYDpUQLk3buGpFhw7wVnYWZuernsI+pAHl/63TvTJG0550L21BMcbBfy9DsuHHJx6gg/Gw==
X-Received: by 2002:ac2:5a48:0:b0:513:575f:cee0 with SMTP id r8-20020ac25a48000000b00513575fcee0mr318604lfn.16.1709629185320;
        Tue, 05 Mar 2024 00:59:45 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:45 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 10/14] linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
Date: Tue,  5 Mar 2024 09:59:15 +0100
Message-Id: <20240305085919.1601395-11-max.kellermann@ionos.com>
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


