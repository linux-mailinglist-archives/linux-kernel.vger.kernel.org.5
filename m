Return-Path: <linux-kernel+bounces-164276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C03A28B7B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773A62852D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05B2179958;
	Tue, 30 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QRSL9VYe"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3E174EFA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490997; cv=none; b=sk21IbWkT1BmInzhphqgnWXAy+10dMlYD46Sd+h2K6tlhYpy0xhqiQZRnxQH15KijWAmi/nTFLQvxZtG/Z2dSrWMPcEHrF8EUHvSfj6lp8zFyNNlAyku5JKNxXmWqEpb2yjQBWYodL2k+ncuIdx4foq9pf5gTUvTTq5TbTFjQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490997; c=relaxed/simple;
	bh=kxgSvemgezHNJkE0saAMW1DJ5PGlFruYzt2eRUb/Mo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwUZ9LitCkyIwp/gKcLstZBbzWCXr7qQxywlcsdtyB53bMZYXYr+Rt64R3vLyncpCMFdC/o4ZsWI6osOPZ0g4yIBzhV2HyEHgFTq3ugyea9l+QtnCpjfeV8TRcVG5QrrEJdgrMd0WJ0UOFWjdYE71+QTtB0AUnZgLiA1vowvapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QRSL9VYe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a58e787130fso551758866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490994; x=1715095794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgOq23bih0Xnwomy5vmAqs9Ea2Mb+HRRPEwLJ3fjdfw=;
        b=QRSL9VYeYg2MDeUTEHJkBKbY9y/gh79zcrnelKSV0ZQeHPRRk/DFacw3fSiH6LSWtX
         b5NfM+dS/OmUTQEMvxdtEqxIId9KiLjft44b8rUvpX5ymwN5EKFIiU+d5WnU0vMoWetW
         ZqT2T++PJMSSAbCPhKZc3XIWR8bk9ztXNgKdkxnOKGdHBH3MCsQNZ91N3ptbs6Rx3Pwl
         SN77s5iBFHTIHyb9MusVYQzS7yzTQojxfm76kU05y0/msSAqH4/i8xvL2xobZ0am+Rf6
         8cDXkSoZKHO3KDdd0zFZq1EgpVkLKhdlPlBRHTjwSZAVN22y+5uMuc0MVc5YPSF0VIfm
         ukaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490994; x=1715095794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgOq23bih0Xnwomy5vmAqs9Ea2Mb+HRRPEwLJ3fjdfw=;
        b=V118QgzFkIo+aY3VVzjAMOGFQnx0DzKf9iIH3GAS5qOVJ/wkA5mqeXuCJevHUg7PQF
         XU1i5/7jA0a2aE2OjkWD32fkXLnZZiyzLdpOkBpWoDaCBBt77F4eqfNZbxQHWa9B8KVf
         QBF1FJqVKj1Qm+c7kQ6Tcev8txLoa2I9saNl26vSvRrUlC9kOAMp/v9FhbRDPxGxCggj
         UJWSskNXN9riQ5F8Zm8XqGcQXlU5+qHjUjaSNmOub0dtTd9y1sx59CX6C8J1HJVZJfvt
         0YFnA/qDl6qM645rAhN6ZkcwDZY1bEjVZ9EGdD7HA4HFYCY9DPXwzZMuyptAoUXYmgW4
         K2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk2cdhE//8opPOLTPjy9L7n+Jv5dPBcPFA4oFVY8zvNNwC9r0r15IGjJZcoot/87CnqyYnth1tP4sxO5CyMkhoJFcdUfdXSNlVefws
X-Gm-Message-State: AOJu0YxLUWYq9NN+je58Q/JiCwlRIpOLuM3KHxeyUsvc9+/uT7olWQd5
	pKclher2Iixiqgcxs/dEGq5XwSHQiHFBV7L9srZ56tUY4NjmyGdbPv+/h9Lp4g8=
X-Google-Smtp-Source: AGHT+IG/uAJA2hLyHFwwSx+DAW2s1GTiPaLdZjteCbmtyObgYpzI32rY1f15fT6HmnOHgU1rI1sfVA==
X-Received: by 2002:a17:906:3894:b0:a58:8602:ffa1 with SMTP id q20-20020a170906389400b00a588602ffa1mr87095ejd.19.1714490994018;
        Tue, 30 Apr 2024 08:29:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:53 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 09/15] linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
Date: Tue, 30 Apr 2024 17:29:25 +0200
Message-Id: <20240430152931.1137975-10-max.kellermann@ionos.com>
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

Prepare to reduce dependencies on linux/mm.h.

put_devmap_managed_page() is called by put_page().  Moving it to a
separate header allows us to move put_page() to a separate lean header
as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h                | 20 +------------------
 include/linux/mm/devmap_managed.h | 32 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5b3d56454344..9539ba12b99d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/devmap_managed.h>
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
@@ -1364,25 +1365,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
diff --git a/include/linux/mm/devmap_managed.h b/include/linux/mm/devmap_managed.h
new file mode 100644
index 000000000000..50357b304d68
--- /dev/null
+++ b/include/linux/mm/devmap_managed.h
@@ -0,0 +1,32 @@
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
+#include <linux/mmzone.h> // folio_is_zone_device()
+
+DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
+
+bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
+static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
+{
+	if (!static_branch_unlikely(&devmap_managed_key))
+		return false;
+	if (!folio_is_zone_device(folio))
+		return false;
+	return __put_devmap_managed_folio_refs(folio, refs);
+}
+#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
+{
+	return false;
+}
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+
+#endif /* _LINUX_MM_DEVMAP_MANAGED_H */
-- 
2.39.2


