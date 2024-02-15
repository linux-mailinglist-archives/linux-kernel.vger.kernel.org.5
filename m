Return-Path: <linux-kernel+bounces-67119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70878566A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4E3B273BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FE132C01;
	Thu, 15 Feb 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KRjoka72"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C91332AF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008982; cv=none; b=GljQ9XDo9PrgaqIvlGoea9Kx7yvu65kycUP+0vhYOKvuSGCCNYQKdybI5QP/hWd0/ikjMD1Qtnq2oHoD6eOfBvSIcKdN240F6FdBcyFZei6ZOfzNKFa1gqByuVg6FTYao+jfEvsWPMC57RVmKhON1ALzbP+WBhuHNLgu4MGPq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008982; c=relaxed/simple;
	bh=pgWmL1/kQ5EKgVkunmoc9kuE+c2QxgAXrDk6ncXpwtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEe4ZUKsViT2OQVtnjtyOSbeP6mgfZVWwbh6JJG12P6UnvwJ9sWCwEgXrd7V8WXt4zaFGtYmY8n+Utqk6+l1YCtcK79Wtc49H2wBORKSePO1uE+5f2YHkc1IOFDThbtCFTJWxUO0zZlt4HbktouV1RNWgNK2ULj1hZtT+tz+lWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KRjoka72; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563b7b48b9aso671047a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008979; x=1708613779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRvSVsODNSSWpBrjcPj/MUDqCBoUjFcr6NI1MGfkDG8=;
        b=KRjoka72HcPUAjsYnRrAisjX86NnCNxsl3ZehjKlPeOT2rCIPoKZGY+WJUg9FiY3BT
         q3rAtlYOXYC6YUWrFDzocaxcZvYao8gkKymfy33hJBP6dmlUv81ke43cWGPsB8iWYCEH
         NMOZbc5fbIxMpv52whpGqgWRoLm62pgyH8DfoariqpKslCGdxAGKzDwENkYOtSkM4M+D
         E8mTouD8XZCvvlQufK5Y1cs7SsI1XeKkwKdrhqkDniuzrbCJ+mRkz1Tfm6+DdBxKclSj
         eg2+QQFZNcbq8iEHvO/4RG5u6gZ9hQS/7vaL0iZO2iB31NIFu6Dh37EbPt1lZbRkZj3i
         9vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008979; x=1708613779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRvSVsODNSSWpBrjcPj/MUDqCBoUjFcr6NI1MGfkDG8=;
        b=LI8E+ljRb/rqrZeQu4/K6KACvleVMP7Hs6EP8IBFWgIEaFr46AiBLrdvaQhQj9L8JY
         HkXakn+3g1dgpTj3XihdeAPnLdCW7VllhXI9t53Km+DpO/vemTd3pDuNFBtZYdFu94Ir
         Cu8GYuxT0hUxTgGTMYneDV/CjqIBj7b12WZ9zO/ElOJ8s1ofQHZDTIpaLqk/0t3DjgZ4
         mS6DdZLOIWpdoI+VzmyKW1rAszT9UaeO54JLQtQMe0CjyQur+sOvymsduhse0t1DeM/G
         E/rZUbmJPZ17PmNaSExx6pZOWyE++jiUaJJRRX62Esa1X87H4Dvn6tDqOtEU0BnV7n88
         rzHg==
X-Forwarded-Encrypted: i=1; AJvYcCWQRjzzVrVZxNNzmMb4RLWmkQzv16fpbct9kHnHnNdzaQycP1NosWSNUfu6MaaTl19s4SPsvyri075yRTcmS915ll6/bNMlGDI8cQk6
X-Gm-Message-State: AOJu0YyRJiGa7OX0eag10nhHXTsfWo56RiprcxSdD3RPnh+rCf2/AzGR
	9zXE8L3hdjklKLbEQb6jzmOTj5iMFyBjmwdjD6hcC7qd8pwmlG047xYJeMmw6mpM9ekS+vkAibs
	O
X-Google-Smtp-Source: AGHT+IHa3g48edLxpLnPmjuHN2ahaJh7C1K0HVPHep8G35XAhbS9I+UMBUTxYQtrfWhuCGGHZU2OSQ==
X-Received: by 2002:a17:906:bc5a:b0:a3c:875b:f378 with SMTP id s26-20020a170906bc5a00b00a3c875bf378mr1086457ejv.36.1708008978701;
        Thu, 15 Feb 2024 06:56:18 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:17 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 08/14] linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
Date: Thu, 15 Feb 2024 15:55:56 +0100
Message-Id: <20240215145602.1371274-9-max.kellermann@ionos.com>
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
 include/linux/mm.h                | 24 --------------------
 include/linux/mm/devmap_managed.h | 37 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 680329ec21ba..cb2dd71e2940 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1345,30 +1345,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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


