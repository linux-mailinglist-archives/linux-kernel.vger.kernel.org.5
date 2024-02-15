Return-Path: <linux-kernel+bounces-67123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B018D8566AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362241F2180B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA14132C0D;
	Thu, 15 Feb 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Rm/Nobin"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E181339BE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008986; cv=none; b=H1oQKQpPNkqbpri3vTUPts6TqLD6/BOHUZbDdnuDkA++n6Qme/pTNyF7yUWiREJohQBeuZo7BDjhs8LtNAwMhtvTUbmzfosfP9TLOuY6shG8R9hLf+2pXfqB7YFFUdWgWkwaGPmIITZ6frVeJ8t27srXyq3iaKOgC+MFfe11/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008986; c=relaxed/simple;
	bh=v9cPlxD645ETqqwrU2mneRRT1GLcfGc/VwKe6UrwJKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltvev8WHJz1MwmRVH0vqpvz0DTIqxD/mN777MzKuYKBIaT3Z7s5MXjWxh3TJUIxc1XB29ZrobMvEDjZWQ5ekcYJgjq0KBUIWxfwneA5PU5c+xCOFXEzXZzC+v0DLZT0wbNpF4F5nQ3U6Hs1e+GXBHRyf+f1gFxJ+e0/vvsP20Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Rm/Nobin; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3832ef7726so123247466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008982; x=1708613782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDi3zk+Z/SLj4QVGPle17xDH/MSBW8emaxfc34uAZG8=;
        b=Rm/Nobinc4rClo55Tp8XMgLCiLCZADV/QiPhWLiFYDZY5w3zhWuEPklPLGsZ73CbMS
         /36YfFuh0oq1dFg7k+bsAOe4wQtAVXfjYoZaGCCJhOCfE0SA2ejw4PcIuaxubql9MIDt
         qGP/U6I6qhtl0UQM8Hha2hpzX/WmwjSrxbvDW0Y8H0LMtwjbbyr/367PQ6k4HftV4Yp/
         GxUUTgwMdYjyM9xjuCjYg2bH9V3QIH2x7dNe6T5JhAr8KBvWPg31Vb9rNofdzA3gZaMu
         O3axoPCGxj14F3S8z3RxfKDyVhq7tRinfCTsr5Ee1X+dxzdoj1KLAMl+ck5F+oyoxcmr
         Wrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008982; x=1708613782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDi3zk+Z/SLj4QVGPle17xDH/MSBW8emaxfc34uAZG8=;
        b=BqktQWosVnA1tBAWhzHP9mU5WFOeGg9RR4T+Lypfunfa5TBvxetroAL3yFmPZbrujS
         IWAPhw/12gYaDRSH8t1bPLB6d01CR1APdlMZID7rc0t+IP3J/U1FcuK+YyCUdhU/YEdZ
         CKWUTt+PtBP4TfbSbwJqS3GcBD8dvXf3bxNEpFtItQfOzC3Mc592sNKa8lGKQ51kkbTu
         5pNIGT5V3AvszQb8JWGfHfX4QyBzJUGbOTIzeY83TvPFxsS+HKzp+bCZzBNT2rm+1pub
         BXzJKoF1MPp3dEza4x74mRk0QejRw6qvWhDTmTqAiVngb8VbDh91wl4jSF7m9Ndjjet9
         Jl7Q==
X-Forwarded-Encrypted: i=1; AJvYcCViZxQZuYjXyBLazkXZc+onHB8nxG1zRMwaZ+V4qnJglokyuyVVbJDJDq6fsQgI6blacPsMlPZ2Jq8yNJL/Rb0XQxLfStGwRoXKzI15
X-Gm-Message-State: AOJu0YwB3cG+1Vk7bJRLpa1ujgywPjLPm3Ez67N9IX1N6IyGz6JiKo0r
	l/O7Sa8urVp7RBVp/XzuLbvUnOtwHpPweQaRCZ/SM2gB71686swwkNOGdddG/SI=
X-Google-Smtp-Source: AGHT+IHAlb4e+8QuGD96pMPeJzYEcSH4nQAFxO/d65uRfxVdzSpHyuiO6MW/gGgKn4n/0BbF5ikJnw==
X-Received: by 2002:a17:906:5fc5:b0:a38:7171:e832 with SMTP id k5-20020a1709065fc500b00a387171e832mr1267787ejv.32.1708008982697;
        Thu, 15 Feb 2024 06:56:22 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:22 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 12/14] linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
Date: Thu, 15 Feb 2024 15:56:00 +0100
Message-Id: <20240215145602.1371274-13-max.kellermann@ionos.com>
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
 include/linux/mm.h              | 25 +------------------------
 include/linux/mm/vmalloc_addr.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/vmalloc_addr.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c7e53cd0cdd0..d4624940923f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -9,6 +9,7 @@
 #include <linux/mm/page_usage.h>
 #include <linux/mm/page_zone.h>
 #include <linux/mm/pfmemalloc.h>
+#include <linux/mm/vmalloc_addr.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1067,30 +1068,6 @@ enum {
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


