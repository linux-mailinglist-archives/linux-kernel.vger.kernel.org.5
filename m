Return-Path: <linux-kernel+bounces-91944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2C48718D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFDDB24B87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B325733F;
	Tue,  5 Mar 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aqs8qV37"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796356460
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629192; cv=none; b=Ruk+fTGnDPsGaKZojg1r5x3MEJEpCmtWSZ9vy9K9Wt+bLlBTl9+dEwRACEKIWE/c81CnIPkUr4txWiDTu0wKMZhRs9Ndszq0EtWTqpqD+f9SnogEIoxp7qsmZDXhz4DF5ltyPNhIm33m7l0zlX+20fCmTNTL4HvfYw++dZuV1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629192; c=relaxed/simple;
	bh=1xnF40lCeTl2Fq3HZQkpBaNZnb2sADMKOS6Vo+/oJd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzI5VE+6V/LwXMLcNTnzotTR3ywe9AEZrgsfHuyD/zZfxtmZPlKq4AAYKQLH7EGJKnYhYs/A/SRL6GFzPvBisRhZ0L8oSUbTKtrypfCvFo3VcvfKYbQyax5APfGHarOWTRDQIZj7NeUoGYnZ2iEfQ3rYhlPnvMBR2U51rxpK9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aqs8qV37; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4515f8e13cso257818266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629188; x=1710233988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATfCxZ0IifVoQF3dNCoyZLQIGDsbM/UfOW1XioKp6uI=;
        b=aqs8qV37FpCFMqI/Pldi5QH437/ldcX2Komg1hjfA3+ZQscJ9XQ1sxFEqlPVPR2WDh
         cXEqJbnlWT9gTuXPeiMVtx97lqk/G8XxA3R/SSr8k0zZa84RCByLDoOfNKXfabLtL08y
         j3KamnTueYRx7xvWT0I29Kf7Y2RFxBr50djrkMtDU1AteUDFD3TTNj0Ea2g/vnKq3q4B
         j4rzZKsQb6gfK7iBRqt0pcVMDdq77irrlWcwqNu1wyRsCQ5HxVoN/VXdeirdWmSzarqT
         HbNOrdse409ai15OsqNll40J2b1EdjQo8T1cj5N9pTmQu5AQxw0l7XLV0qi1gmX1HxTf
         90Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629188; x=1710233988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATfCxZ0IifVoQF3dNCoyZLQIGDsbM/UfOW1XioKp6uI=;
        b=nd/pdMWBgjiemT1+GmpbbNFs1rnvByCY1UiBNrhr0UcDbsfkwMmWdoPBCThfRiGloH
         NVtUrYql0X4tcTBZQZ3FAkgcpkxqzlqBpgGhuV6PzLqd0TanxB8U+UBcF0YI/4CpOhSU
         paIaRTbs8lPLlqmX316nMzpDG03uRRM7RsugR/qTsf/sjyZxt3YNxy7hOOHPNavcGNOp
         KEGbxmJEQ+Lfe+YncZPJFnUvokV4D/1r59sp6Jnh56z3KiuArzwEjWBM6xRMcGRi4X+3
         Ef7FwXbpfo0IhAVnYTr+I2mTUm87KqV/D14AkL3P/k77n3nXaLBGUXNIcmViAHzTkmdP
         q1gA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEj2BQPyhTmex4NDQnThi907nvGgnlEnHlNX3YohuXMBSzfqhtX6wmtTt5vD4uZRl42p2z5O849let6owaeAgSWiOWNtURq9jSJ+A
X-Gm-Message-State: AOJu0YyS26vTqvH+4lOem2B7WDphYYGwtQKH84hYaFIBpfgqbnCdfVG0
	oWJXs57sFxupND9UuUU6COfa+IqBvVb88S9aX+zyZ7+2L+UTsLtzuxlBglwM2rs=
X-Google-Smtp-Source: AGHT+IGDWjdTWBhp9yoamhZMNLezFfIn6Lq1nEJWjHZkb5MGsCgGfbPtzgnfRK1QoTBK5gAAf0Xdmg==
X-Received: by 2002:a17:907:20d9:b0:a44:1b98:1829 with SMTP id qq25-20020a17090720d900b00a441b981829mr8277971ejb.57.1709629188722;
        Tue, 05 Mar 2024 00:59:48 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:47 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 12/14] linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
Date: Tue,  5 Mar 2024 09:59:17 +0100
Message-Id: <20240305085919.1601395-13-max.kellermann@ionos.com>
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

This is needed to eliminate linux/dma-mapping.h's dependency on
linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 25 +------------------------
 include/linux/mm/vmalloc_addr.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/vmalloc_addr.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 07262ae43c5d..80fc7df2856a 100644
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
@@ -1086,30 +1087,6 @@ enum {
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


