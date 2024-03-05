Return-Path: <linux-kernel+bounces-91940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6B28718CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D928D1F21F82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF054F86;
	Tue,  5 Mar 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MS0YRrc3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76626548EB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629187; cv=none; b=Nw63A8I01OcGLnGrtgh9OLCkKuHrEaAwW9kr3MaMBb3dJpvJsDxeZpl4YIhwDAuCZiCiN1BRxlKZrt0jOoYmxbZrIQxWc8okz38d6xikySnuLAHkrDs5FZ4i1sfQQH2zXYfSPqgk85e9Uo4fJXG2B1NguFYJdcvEwWX8e9HeUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629187; c=relaxed/simple;
	bh=MIHkIFvab96I9R+obMDPY3PJG78+nlUxbYh17e4Y/Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=th2oFXtNEZ9nbFQnnvLtRRAGvz/IVKgCPh92w6ur2HKKLSTZcOSqDo/vJQRaAEjrYhx6GOr8hyDXzIP7x2aOnnGDiIjhI7+uyVQMPqrajzH/lo9YrQHiFICpaYpYmfTuTQWxddnv+SA756tnPc4tgbfoiPanrQsx+02gGKRM3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MS0YRrc3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso388710166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629184; x=1710233984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT7smv1j1+eH6dLDpyJyxapeCn0BRAoD8ideYTGL8g4=;
        b=MS0YRrc3yW10g1NPSI7oFkqq3W3SgNf1fZQ8YhgkJlKKsrGz87H+V6sjCCAjMrmX4h
         3YybXiFpjxY7av378YGn+8+7yi7H20nYfXAElGcFrXLdH3fsTKTc/C/IaaWSH38Vcgcj
         Dm8gc5RWKs46SXMQjdFxJyZ1Ae95If6jTNoLSJERA/lwFJGVe/j9xbZy/ojRs/TVztyI
         wseCFP9jOmyWNfHWkVAvsOKXK3Ct3LRDq/OVWq32bfBiqEZ+ONOGLKLInqijYBiIpnAZ
         g3pM6vxnicvYY4KtzcCoAwEJjtiZovVzMHIeEPdOLTqw9Uoihq/1jt+a3pMML3MhJa5t
         JVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629184; x=1710233984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT7smv1j1+eH6dLDpyJyxapeCn0BRAoD8ideYTGL8g4=;
        b=M71IFGax0eifmh+ftQYHUpHheDqBKLWzWipgS7w1wUoX1oOm8iLo4a+kOaa8BKbSBy
         taNPLPpENmOqwmP17DErBej9wY01QWBt3QaKUqz7/1gtdkMLOlu+XQ54oGGWiArHJV9T
         d1Lsr5DJUR2hgkkaYQRuPb7d3k0ktyvVo7jDUjosP4aVL4+KyjlFcETLdQUW/s+wEWFZ
         qdDeuhT3PFzimsYcnqwRv7POWXMhhAAP6uwppmE6ydwd4dKJBg7VTp9muwEgB91846LT
         ZLLlrYSjHmoUosBzqtpY8ISWehBnKFUwwQBG/0oLPIjpXrK/tV2SY6OKuIoiRzb7eX3s
         q3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWRtAeYUvrvAUzvlPDhwpNsiOapsOn8wadPm9K1FgbDkfPsxQ4Rh+MJfYzUnmF7upFW5xTA+Odqie3eR00iboxQ786PezFs/KzEDmgU
X-Gm-Message-State: AOJu0Ywl+9wQXdgPDNBSzpTeFryLenlKZ2k7jm/BHOEskikkt+UOqY1D
	vBQ5YAscwpJDl3qZ1th8aSwLZCkEBrHIIocIXwEgs85l+soFeuibJq/HE3XU784=
X-Google-Smtp-Source: AGHT+IHtBtgNb5X5tWn9KArmVzxl5Jnk/MnYuiE1JbQjADDKG/XuWp5/tNkMjxChRCvuGWsrlF/Kqg==
X-Received: by 2002:a17:906:c7c3:b0:a3e:34e8:626f with SMTP id dc3-20020a170906c7c300b00a3e34e8626fmr8169467ejb.66.1709629183860;
        Tue, 05 Mar 2024 00:59:43 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:42 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 08/14] linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
Date: Tue,  5 Mar 2024 09:59:13 +0100
Message-Id: <20240305085919.1601395-9-max.kellermann@ionos.com>
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

Prepare to reduce dependencies on linux/mm.h.

put_devmap_managed_page() is called by put_page().  Moving it to a
separate header allows us to move put_page() to a separate lean header
as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h                | 25 +--------------------
 include/linux/mm/devmap_managed.h | 37 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e6c2df977abc..61f1312a626e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/devmap_managed.h>
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
@@ -1357,30 +1358,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_page_refs(struct page *page, int refs);
-static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!is_zone_device_page(page))
-		return false;
-	return __put_devmap_managed_page_refs(page, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
-static inline bool put_devmap_managed_page(struct page *page)
-{
-	return put_devmap_managed_page_refs(page, 1);
-}
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
diff --git a/include/linux/mm/devmap_managed.h b/include/linux/mm/devmap_managed.h
new file mode 100644
index 000000000000..0773529d80b2
--- /dev/null
+++ b/include/linux/mm/devmap_managed.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_DEVMAP_MANAGED_H
+#define _LINUX_MM_DEVMAP_MANAGED_H
+
+#include <linux/types.h> // for bool
+
+struct page;
+
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
+
+#include <linux/jump_label.h> // for DECLARE_STATIC_KEY_FALSE(), static_branch_unlikely()
+#include <linux/mmzone.h> // is_zone_device_page()
+
+DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
+
+bool __put_devmap_managed_page_refs(struct page *page, int refs);
+static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
+{
+	if (!static_branch_unlikely(&devmap_managed_key))
+		return false;
+	if (!is_zone_device_page(page))
+		return false;
+	return __put_devmap_managed_page_refs(page, refs);
+}
+#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
+{
+	return false;
+}
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+
+static inline bool put_devmap_managed_page(struct page *page)
+{
+	return put_devmap_managed_page_refs(page, 1);
+}
+
+#endif /* _LINUX_MM_DEVMAP_MANAGED_H */
-- 
2.39.2


