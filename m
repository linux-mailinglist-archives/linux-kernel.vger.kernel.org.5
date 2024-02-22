Return-Path: <linux-kernel+bounces-76455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A64185F780
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D997C1F21972
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161C4D9E8;
	Thu, 22 Feb 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M4tb2t7I"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D94C60B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602673; cv=none; b=NFccgsGyvyIp1FAJPJE3QZXWCshRpr1gMz3drSNEh3pyHYvy8AyjctYTra0NO/v2O6ynedpxvwbQ6jGHf/byqUEZN9OjlFtPahvZ+xrpwezMil2ugUSljQAZIkTpBJCyQ+ZnfNGOQT3WjmsTE32X1GRW7I2bZV0sEKADQTQVY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602673; c=relaxed/simple;
	bh=YID5EHIsC8yhor+I6AoFup3aQLQc9ccnLMMd80bhUqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgxVXHeo18KPryRbJ9SsQAMRDIECZdbPDkEOUxzLuOUSNW/PuKjhM7VXY9Luhr7azzaB5ASMFhKFgbbvYaaCAmuCPT2Z05Nd6GJhOh4jEr3+IUduCoQctEaiuVuOjMFwDRFu+nrfrbs3eNt8qCyut/zK/dMYaUopEgF5scvApDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M4tb2t7I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so128455f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602669; x=1709207469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxFeZ/0ASaJvoJHkw5FuQa0hU1Ih3iAyraY4h2cFePg=;
        b=M4tb2t7Icr6vscFWaupRbi4WvvLYyiNzureWIuzKd/QSU2HbWoGg+GXDZ0B4MrCTdx
         cjTM18zeNRFnzaEy93H9l6hCZrTBk13ULnI/KEba/wOWU/sGXTVlsmqSO4qJh29rRxbL
         aLPyYRHzHSdqQPD7amHpniUA2M/W8xdDEX6bwCc+2xMXMNPkjlQ5KiNNO8YLGivw5Vju
         /xcQx1HefC/uqqIjGtuiaazSPcfvJqABsyYU90/4jtihza33fba5Y0IrANwAJWqlNpOB
         ZGtblZ7gllObeWfXh62v/ZCihiyzWNhd9QYkttOmG4f3/GdKirEiFf1NZuJH5sukC/NZ
         97ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602669; x=1709207469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxFeZ/0ASaJvoJHkw5FuQa0hU1Ih3iAyraY4h2cFePg=;
        b=F+2Ovq31Pe8UJ0TQzXRJf31jkJ8xw5NLHu24bNB/fz3wzloiBXayaD5zkuhqEuVghy
         epIG6OdgSbcfT+bESBSFtnO22OYj6xQvL/Q8pJdxU6Url0gHjV80lcZA8w3GmupF+7er
         3y4NMGX1zC8tSlONqlfHxhe/RSfBIqign/10JHOswfOAOCYOGJnZ8stIq3t+AlBnNfM7
         CZTHWMiHcUxGXP8+mXQb1hnhv+XgcVAuNSqiShxCSjaooTKd0X/pH15Q37bui9/qX95t
         KRBIGDicTUaa+be4c9nVG3PRIZtHHrO9LOCti1Q71ifDVeAIQsx/KVbzFQcrIQmOoq1e
         lUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmPv0+dD7T2takYokrYVdEpv23Dcm9HAQWdFUxA139RvNBr7xAKCMBoN6o59U18z/LKmAY0GcwSikc8rY6Jf+ItLxvTewcfg/L+e9y
X-Gm-Message-State: AOJu0YygCJjOzkduGrk5yyB3E5SLH89EQJDe/Ayj+EGdtivJmWHXbN0F
	5dYDiBoR5jeuZo8mhZuRY8M0vUvzxLGAgYhC188yiLWD+Fio+2YEN5qCTQyXwrcq11I2Le4eKuC
	w
X-Google-Smtp-Source: AGHT+IEa3C8f7cLy6OU3uEmSmSXgcYIgG0huCWrowteGjGdDCOAsaf2p99NOehd9GQ5cTyTmBUBHRg==
X-Received: by 2002:a05:6000:1787:b0:33d:56a0:88e3 with SMTP id e7-20020a056000178700b0033d56a088e3mr8736928wrg.65.1708602669683;
        Thu, 22 Feb 2024 03:51:09 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:09 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 08/14] linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
Date: Thu, 22 Feb 2024 12:50:49 +0100
Message-Id: <20240222115055.1172877-9-max.kellermann@ionos.com>
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

Prepare to reduce dependencies on linux/mm.h.

put_devmap_managed_page() is called by put_page().  Moving it to a
separate header allows us to move put_page() to a separate lean header
as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h                | 24 --------------------
 include/linux/mm/devmap_managed.h | 37 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7d83d6d64f30..7a302da7de24 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1350,30 +1350,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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


