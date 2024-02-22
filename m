Return-Path: <linux-kernel+bounces-76460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8385F785
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C9B2517C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528F4EB36;
	Thu, 22 Feb 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FK8LKP6C"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F54D9F5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602677; cv=none; b=GGzClH3S6d9Pjc0F1y4v3FcJW/3K3zwAtWh7sFDKjCS9QphXZCd9l69SI5opDBHijPACC0ewDep6sgwUvegLMVfnywJO7aVyG/EVAYT/tUBQS0jhTLOJ7ZUTxYSByrYAlul0r0lIS6IdfxEvxoKVtDMLfgTdHbUiceNUunMt/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602677; c=relaxed/simple;
	bh=AI6dnZoshIANIqbcoSAEYz35mK5JXJZ7+iH1ThOklac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+btNbI5+m8UJK1sZFFrxGYd/d+/xmrp/54OPDHjWqI7mVVHKqdr+FTqjAkEjsL6nMwTqO6JaV8oaGX0pNGAjHAXcxPqlt6xkAdM5dbFK0SNwXVFZ9zJEz/KmyK38Qz29YyHDsQQnDnR2X3N9xOT9czyHKlmDi+7KXopwi8RKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FK8LKP6C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41282be73e7so4459335e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602673; x=1709207473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ry2UB7dcYeDT9zlEEyR0ChQEn3iuoF+FIIQJnSpSl4=;
        b=FK8LKP6CQKfWwwAg/llcM0rN9Ju0Pg0GbsuGNflU/ml9LolP+l8KAPxhS7pKgsjItZ
         D+DAICVVVpD8IAH2DdJ+Z9X2/dgXSr59qj712fFMuBUwCnkE4cDlYnq14see7lLw/0q8
         uqR7DszC6UXMIdQengJ/tevD6SMzUD2qQYuGTouwnGycjlRa0ipey+ypDlCbmUHMOGo5
         +qG3hWzvq/VaDVfsAEAzhIpzK7MHiQGkBhxE+qBRyawd8G471Pr2vAWeDkScf5mEXWy4
         uxsXyrbIy2dedTRwF+eleWI+5HmOhlUSP8jLfTZYznrC2cCkT3ijUbv2O0cvZ8aFFTdZ
         hsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602673; x=1709207473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ry2UB7dcYeDT9zlEEyR0ChQEn3iuoF+FIIQJnSpSl4=;
        b=w4Ga1PnHmOEnxfxHSmWBYrOgAIV1dnJWhfuRRCNkwMg0RTlBVl8g4ysJpy6decnr5Z
         5L1ei/xB2aBBLVOSuE5jSQqcT0Go209QHum8QUAqMfwmbyx1P9TP6f9+SMiLRVnmK6gA
         vBmad+Dj6ktybP/Tg0/ad4Ywbpqd0fylojgF32+Kty8smfpAr/vHIg1O1YRGr8J/Wrpk
         TxE/PAtbQnV3n1AWvClbIiUOB2ltrOs62MSSSQ2ukbrZn6vmV2n7XxU640MUypmMC7nK
         LG+HgIuwzJj9ibccfu/tSVRy/m1xUARhL8fXDu2l0JwmmNAKygQtm/Y8NIDxVMYN2Fgc
         dDIA==
X-Forwarded-Encrypted: i=1; AJvYcCU4GkV/AsPmkDPUTUcpC8Ajc3p+RE6mU/MZunezBMGPsI5daOfTwM7CRpVoXBLtP1V0nn54q9wErGMowK3LcaSS/ZIsdQW3T7sZrjvR
X-Gm-Message-State: AOJu0Yy+BVQuMtLS0LcNVa3Ws5VX0zLlI/Ak/OpUtYjnLetpUqEVvmEu
	Yz7xjkHYSn20hVZcmh0hKg+Y1e5XCVyBgbwQdnyb9oXvq+UrF/r5fkVJYG6pBOo=
X-Google-Smtp-Source: AGHT+IHkn7Kv2cDL9TKEn0TXsN6T76wIe9NTlaJgmzsTsJCs2KhPmArE67c6S0bklL8r6dKwaNFpGw==
X-Received: by 2002:a5d:5962:0:b0:33d:3a0e:9168 with SMTP id e34-20020a5d5962000000b0033d3a0e9168mr9439866wri.3.1708602673418;
        Thu, 22 Feb 2024 03:51:13 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:12 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 12/14] linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
Date: Thu, 22 Feb 2024 12:50:53 +0100
Message-Id: <20240222115055.1172877-13-max.kellermann@ionos.com>
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

This is needed to eliminate linux/dma-mapping.h's dependency on
linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 25 +------------------------
 include/linux/mm/vmalloc_addr.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/vmalloc_addr.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 68228f43e7ca..ad5971219ef6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -9,6 +9,7 @@
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/pfmemalloc.h>
+#include <linux/mm/vmalloc_addr.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1072,30 +1073,6 @@ enum {
 int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
 		      unsigned long desc);
 
-/* Support for virtually mapped pages */
-struct page *vmalloc_to_page(const void *addr);
-unsigned long vmalloc_to_pfn(const void *addr);
-
-/*
- * Determine if an address is within the vmalloc range
- *
- * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
- * is no special casing required.
- */
-#ifdef CONFIG_MMU
-extern bool is_vmalloc_addr(const void *x);
-extern int is_vmalloc_or_module_addr(const void *x);
-#else
-static inline bool is_vmalloc_addr(const void *x)
-{
-	return false;
-}
-static inline int is_vmalloc_or_module_addr(const void *x)
-{
-	return 0;
-}
-#endif
-
 /*
  * How many times the entire folio is mapped as a single unit (eg by a
  * PMD or PUD entry).  This is probably not what you want, except for
diff --git a/include/linux/mm/vmalloc_addr.h b/include/linux/mm/vmalloc_addr.h
new file mode 100644
index 000000000000..86ad2dc94960
--- /dev/null
+++ b/include/linux/mm/vmalloc_addr.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_VMALLOC_ADDR_H
+#define _LINUX_MM_VMALLOC_ADDR_H
+
+#include <linux/types.h> // for bool
+
+struct page;
+
+/* Support for virtually mapped pages */
+struct page *vmalloc_to_page(const void *addr);
+unsigned long vmalloc_to_pfn(const void *addr);
+
+/*
+ * Determine if an address is within the vmalloc range
+ *
+ * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
+ * is no special casing required.
+ */
+#ifdef CONFIG_MMU
+extern bool is_vmalloc_addr(const void *x);
+extern int is_vmalloc_or_module_addr(const void *x);
+#else
+static inline bool is_vmalloc_addr(const void *x)
+{
+	return false;
+}
+static inline int is_vmalloc_or_module_addr(const void *x)
+{
+	return 0;
+}
+#endif
+
+#endif /* _LINUX_MM_VMALLOC_ADDR_H */
-- 
2.39.2


