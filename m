Return-Path: <linux-kernel+bounces-164280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8EE8B7BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1531C2870A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB717F38C;
	Tue, 30 Apr 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E4ROvf2h"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4F17A938
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491001; cv=none; b=tnkKFbmhl6RUCLnfyDM7jafr73tTuIXlQayVdBr+JpFy4UEfrx/5yYRRlf046HidVdYBW2rcm9v/Kuay6fr0XcR4cd8v5pRhgSNif70N+uGN/kjHnKInh2UcdONlGVlVlMlNgy4wV2X6rKUke2Rnf4VCSd3lR2txrGVhufDBFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491001; c=relaxed/simple;
	bh=7Wqgopge0c1zByX+1ZPCmbPVjz4bqNYeiVWKrJqcGeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vs2o8g3qWF7Rmg0NkZueyYid5JKuAHEBhfepF3rbAESCu5FD39KRnQqORjQhXN1qcMfycQh7OoQHh7wuInPy+nyC51qlnLIUkCcH3hcOeTBtN8gBqqLjRNZIM2eYKEKkVGortxporn3fvsiI5IasIKrUUdPJgDCln9a9Y+NIwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E4ROvf2h; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a58d0aea14cso551256966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490997; x=1715095797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvQOYi27DDTAcxzrxQJEFui65m27m7gnEqcrJuddtB4=;
        b=E4ROvf2hjpSsTPN2z8TzSlh4G4pPs402aqvga7zQ5iAxR4HftCUKunyR6w762CpzYu
         H2+Zege817WLhMktIVqFTW1mfkYeAXphVGU7cCUGtX3burr00HCO4C7CwtV/t4Twsbl4
         M1B5SnUcB4zc/Lfc4SIWCvd2TQslwPvn2gS7UlkUMSniWNxgYbwFyV1XHg1uO4EVTPol
         3zXLYrsPdKS3AHHFjpmV3HpaUmHq5ENOR+ccJO1B9OGvr4dPPnC+8eEGaAt+ak2flt/X
         YqTlXaW/26jbts5rIFNuryNdLskIvsQ1X5mDb7jNdbc8tlXon6EiJh2hOYY/31/ofyd4
         ZtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490997; x=1715095797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvQOYi27DDTAcxzrxQJEFui65m27m7gnEqcrJuddtB4=;
        b=K54K8eF2vMt0HRGO8D47xas5oc3jQFT8nBKMsN2zpQs4Tj9jLJ8Z1mgkjvQUjaRWUi
         u1nPZgxQJf+VXwXT4Rt98rPUJkF5p7uE1YY/VWCoGftfhSZWXEiD8wTkDQKvcSPdH5T6
         SaD6yqMCkVzgZvNwVrecfO1ZyWcERgM4o/qMI9AjmXX+LQl4fyUtxtDkEWAbYwIQSi3P
         Q0gozFKrHZ3q/orIvp0zlF0aHLO92K9r+Ii3sm/yxw02++dQ8fE+9r7yAJ0E5Hvat8E2
         UaKjwjIQB9SVdETFZHFUNuNBakkHjFMN2apN0s9zSG/5dYDgG5LbPVITeEaAtp8WSFkx
         CNnw==
X-Forwarded-Encrypted: i=1; AJvYcCVnlluiyXSV04oPbb8WU9pcK9922fV1jZ4ToUxCMqO0shxMJmfGeRggBj+FsSmD4YHIYsOud2Vjw5LBWEjdQeJqSK0Q7MGxA5O025cw
X-Gm-Message-State: AOJu0Yy7JlUGtnRrG+v11Dmo8clWbTJUI9IfXrjA4qwcgLUi/udDYqeK
	T5R92VUSjmkPnNtclUk2HhdWigAQ6dgqD1nEU6HtwmcMvWNtwHpkRXcqrq5mlyc=
X-Google-Smtp-Source: AGHT+IGsTQcwaXXHwsNBLe5nX0MiKAiQus2jcQ178jsOYhxC+5eewEpBY77UGDOCiazx95Kbec8j0w==
X-Received: by 2002:a17:906:494c:b0:a52:55f5:aba5 with SMTP id f12-20020a170906494c00b00a5255f5aba5mr53639ejt.2.1714490997390;
        Tue, 30 Apr 2024 08:29:57 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 13/15] linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
Date: Tue, 30 Apr 2024 17:29:29 +0200
Message-Id: <20240430152931.1137975-14-max.kellermann@ionos.com>
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

This is needed to eliminate linux/dma-mapping.h's dependency on
linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 25 +------------------------
 include/linux/mm/vmalloc_addr.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/vmalloc_addr.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 046f960ef70e..5681fd5dbbbe 100644
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
@@ -1087,30 +1088,6 @@ enum {
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


