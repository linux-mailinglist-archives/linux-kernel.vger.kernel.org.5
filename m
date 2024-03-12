Return-Path: <linux-kernel+bounces-100049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8E879135
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89841F20D22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C17BAE8;
	Tue, 12 Mar 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bQ7pjCUr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31A7AE61
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236522; cv=none; b=O3IGhG4mv4vahITLpI/YdEf64eBS9PDhSqYPw6gpmv4nIvmEqTtTpA+9n4NYnAMCvgnNPobocw/NiTPDA3K/qWpOg72aYlR9MLYMAT0LYrAtPFK6jA3eFqoia2FTvvBo96KrVX8SykCkrb43y1usPmNeFDgljlgvur60bIrLuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236522; c=relaxed/simple;
	bh=MIHkIFvab96I9R+obMDPY3PJG78+nlUxbYh17e4Y/Ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dta/pbD9qbZZ+ieQg7CKzJRlSWBTQAP/YHzxsKDJotU0AgXRYT3Zkn4rQn9mzbZ3UN3mngwfEZGhFL0/slE0TEhAvfm4zjE/eP9iVVAAUzr0lYPg29+TJMYuNL3da6z0J1y3wxRNufKaksBnp67ONPYzQ6vftRScY9r57RnOpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bQ7pjCUr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56878bb1abdso336709a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236519; x=1710841319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT7smv1j1+eH6dLDpyJyxapeCn0BRAoD8ideYTGL8g4=;
        b=bQ7pjCUrKl4j7J/tjcVdLvXvbOfqqC9/4CPtS+o690FrzLP+Aq94tQx/PbcW4jO7Jc
         c49Hrj/HX9xqk/cDU0Rk7YCzIpMMbMYTrNhhy/KkrL/128kRnF/f0xQsrVH29kvfKzOx
         sr0zXU0oUnY0SDEIq/HUnxAXQQ7IThMzTxuO0Efr0IynSCqJzXTbh/FEZzy+DjAOJhTN
         JBSeY00tHhEInF9cO2pE39zIdQCRG2MnLoz+hDZLBvbSk4fW8esBf81Qy1j5Kc+i+sy4
         IGJy+mK+id9JWZOURIN37x8ChhOXdUKAqoQMCv11FIebOZZugq2A0rPEg3RIvuPc5w6X
         3YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236519; x=1710841319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT7smv1j1+eH6dLDpyJyxapeCn0BRAoD8ideYTGL8g4=;
        b=mkyFAjVTNl88DIQhZl6zwaqSuntsiQola8r4LvpaoDRrgG13gDUsWuhy9+N0dZK0eL
         PuWElzqtZ2Ce63SjJAu/Qb9JixCy3PqVPn+eoVaXpIhpp3r+4cJh8ov8WvZuLoT2fOSv
         kKsZ4hVCS7jsrWwu5xmeIHMlJGSVMFk9NOuEaM0y0pS9ldaE7InQDhAL/DH++Go1soWe
         9H9JcevjvTeozfYN6nU7JciOBsVrt8kzGc6hcXvVCtbqdIC11soxAukHAV3L72TM6Yxu
         ocbaErOegm+X0RqKcFD4Ua0bm+sa2Dz+nKIcBc3Kvv3JUji+ZFN2REcUNw7f3Zrz8ZpT
         HSbg==
X-Forwarded-Encrypted: i=1; AJvYcCXdtvQxbQQmVW+msDCABDJZr9I9AX9chQ4v8A0vTxMVv3++Jtt0TiIQEyhNz4z6nCBfI/hk/Lagrzlc2iCiJ8Y+KANyT2jDom7x2ep/
X-Gm-Message-State: AOJu0Yy4F6FwiIgw4Sd81VugKMKoz/SPSz8zxi8wIUcu3KW75Ck//VJb
	35UL++QJUGHSvlCo/5Ubz72cI6sIwtC8Xm2jQy4dZgaG/zwZMHBx+CdGmVI4ULGM25gnXA9ziL0
	Q
X-Google-Smtp-Source: AGHT+IH7z82KjX3aHCRWUOCeL5FyYqD0JcQ3ejtaHjG0l89tCOrVbvS2n36rt9l5T0g5qz32g+2nTg==
X-Received: by 2002:a17:906:7751:b0:a43:f22e:57a6 with SMTP id o17-20020a170906775100b00a43f22e57a6mr852298ejn.67.1710236518882;
        Tue, 12 Mar 2024 02:41:58 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 09/15] linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
Date: Tue, 12 Mar 2024 10:41:27 +0100
Message-Id: <20240312094133.2084996-10-max.kellermann@ionos.com>
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


