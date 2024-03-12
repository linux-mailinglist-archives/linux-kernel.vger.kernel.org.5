Return-Path: <linux-kernel+bounces-100053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3C87913A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F674B23DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C927CF09;
	Tue, 12 Mar 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EsHeLtO5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A77AE7E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236525; cv=none; b=VzzZptNxODj4fnF4yCacGI4okNiQWr9j7yX7PqZE1a2jSbTStK90NF0Zy5HT2C2mRN+d4bjgt7QUeGQ+MV5VeJTWsIZptejFj7h52JCvHWtHbokh1DjZkVoXerlKcTsO+h3G1pJSGQ3p3Qp+N2BcixvDYiBCq8y9VaWxFv71N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236525; c=relaxed/simple;
	bh=1xnF40lCeTl2Fq3HZQkpBaNZnb2sADMKOS6Vo+/oJd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDaS6duHDO49GkiC3mmnQsK9c+WJp+AkwaY8L3/PfUKN6Usa3/fLN4G8Dfr5QLAwaizIAQ3xZIGoAfjAwZf++bxtgAD7MppOY7GR/X4wJpOHWFBbQd+o/eub0wiTnBBX64tWsq/dKfq19en+yK+17iyu2dbDyY3iSHlIz9aDLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EsHeLtO5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a462a1b7754so229099766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236522; x=1710841322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATfCxZ0IifVoQF3dNCoyZLQIGDsbM/UfOW1XioKp6uI=;
        b=EsHeLtO5q8anzv4sSkYwfur+GKcXshEprOZRDPodtcMIZjOPA9whmWwZ8sYuL/sv6e
         YGTwz2FEjduHgNcZ6mUwfcBH3k/8pEhfFRWyya6h2M0qj5ShbkFOphAZDR39+o+LH4Hw
         aJaja36P9CRm/xmvcSsfNKiTGPu4kK/mAF1TQVJq1RHayOMbdqkxPK1bSZiwFEozeevm
         3YZv1fc68rQipR1d2REfibYy5zDJC9lmFumtPfFPCTfqWAm4vw4Zy6px75HgsggeIRWQ
         OXM8WPaO3gFL8IEQ2sNKFZ2+/tw5We9F4HBcoCwvA1bVANQKEKf4QCs+Z+e1gVG5P7MD
         GfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236522; x=1710841322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATfCxZ0IifVoQF3dNCoyZLQIGDsbM/UfOW1XioKp6uI=;
        b=rwF+54lsNzGvFTVq0bvXoRBkQuHoAVA1GwU18jOHvXSTcdmCDoUDfhtytzvEL8AxwL
         hFbyebn99U0waKNXTl1tw20vk0P938cgsC7CT1+VdMCZsHfRId6VoVrR9Le8rMneFK63
         5UpVpkJ5f/JJhGCzQlcVYcx8ciqnx4TofboA4DyQj7ZUPTqjVT6azaAf0gunDs2g/kiH
         UeUQ3caaWhgflBCGmXO0OaKUI8j/2DaHWxzWwUqw8tuJsTH83Ijb8D9RDkTnuf/XJPon
         RiC96InemZTdYYZY5nShUkuZ2ifiWP30AWF5VO47hwVV4gn4W31s8CPeJaiBCpL2WSs3
         E8Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVGQ83/o0t11PjPB3FZkOwyV4jfunuW0LfiT7SQtpzHlgDLrI2ZrLM4hNWlDiXfLkCCc+44xJfhVAFltrLCMAlecVPR7gY25SUqnKiT
X-Gm-Message-State: AOJu0YwD3JDCcM26HFHngxSViFKz75ky2EsYZQR7a5dy2L2pbg5zi80Y
	dSIUxmD5yVUBHAU3sit2gtno+E66WpzkMjBEOmnByIZ7x6/fuIKFOBJcZXA+9FhQZcdzh7K7M0h
	H
X-Google-Smtp-Source: AGHT+IFm4FuW4Q6fcKByW+nr4fxGN22zpZHPL0egfaVaa7jH0Kxg7oTwjuowI6oi5Qt4kRMHasE2rA==
X-Received: by 2002:a17:907:c706:b0:a45:6cc0:8f19 with SMTP id ty6-20020a170907c70600b00a456cc08f19mr6331728ejc.38.1710236521930;
        Tue, 12 Mar 2024 02:42:01 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:42:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 13/15] linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
Date: Tue, 12 Mar 2024 10:41:31 +0100
Message-Id: <20240312094133.2084996-14-max.kellermann@ionos.com>
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


