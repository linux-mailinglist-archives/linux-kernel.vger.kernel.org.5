Return-Path: <linux-kernel+bounces-67118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACA8566A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1271F21A50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17470133426;
	Thu, 15 Feb 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="emnPTkfc"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FC13329B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008981; cv=none; b=B37s9g8przzcot4dFsIC1HGH9m7IQ59Y8rc1duelOCGzWjyLrFjtM9p2jqeYp1Yfsqxx0FXIbAPnJGBjfG4V4AZt9fTYWUd3ii8S0WRxr2H11nv4D49C63s2mHreyJ6kKAuMl3VicSYNBr1i4QSrlHRb0bF2ErFWPqm7xCMU59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008981; c=relaxed/simple;
	bh=GSwFs2D/dYXSHD0S2NLeknpsO4i2Jaw9bBhm/AVsNpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNdbfCJBuZjwsonwo6O3krXSlt2cwfMawOUX7OpLUlcWPyDxJw7B13aHpZYaAH0CJphXd7r3zmfj9GYCSsStVYndFd+RIHag59P0rGBmlFQ4/8Gquu/cZ0ntZf8usJp/F3lGN8LVwIBcr3Ajg9Y0rZQbAKlrrB/6KCE3BCK0U1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=emnPTkfc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563b49a0f44so1069103a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708008977; x=1708613777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWAZLa4eGWeLLFtGDVHZ7Dmnhq8s5ecyK6HpyTUArQY=;
        b=emnPTkfc+C1ZoJcPulHRLRZKzufthxZWpJLiFAo2uQmzGTJ43PCJVWHSx8HiszXaRm
         Zqt7JN15y6BC+pZq2uQtYUtN3VVDhCmhn0Y0wkpp0rmsfEwR7Lyi8Qe9AIxJE9Luev/9
         49NTeXES5ZIljsDItVfsWHjlMWdj1nx/sMhJWRH4d7fwlGNXiIeOdpCZPhSsXCCNBM6b
         esLUnI+J2pjyw5zAiKr0ZJ+Rs/wjtVgG7fJETffhu+6xYfmLvzRLIVoks0VQYqPWgXxy
         HMcPPXUwg3tA+Hip3j0PtCMO1yArYuxCiAdUf8+aesHviRxM3shkbMaOY4s5ZXw9XIhq
         DUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708008977; x=1708613777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWAZLa4eGWeLLFtGDVHZ7Dmnhq8s5ecyK6HpyTUArQY=;
        b=mZmvw0blZEG7kksQ7ukaWGeIsIRldzxFa90Vgegjo0qOvRVDUMF9DnAX17LRB0eFe7
         jaAev+j81DxMlSjnV53UuZnYcClotnuiMHOykRzlSi6Sh4XxuFlaw7yUG897qEwaTjT8
         N194oEl6edR7xtt/9xjXyEBb8cseaXEHTQXWR8UZUImBb/d9SkHc/GP9u0Un4nxVUhAf
         TXvXDkrbGhSTqYMIjNsAlkS3A0Pdhb8y1KePA33dG1erGqAqQfbpp3LK69iodSWzp96s
         2qrHFR4DdCuRsddkl3miC+at74j8D/fGUOQNUhLqjvPSKFo8Orot0zh7CZd+y50X6vn0
         gU1w==
X-Forwarded-Encrypted: i=1; AJvYcCWQPZAvQ54j+YFaBnjIyyHhxdPRHJH19QJX2Af0FAuMFNMjTYRB2a3DlRy3B2AfNoov+X7d4vG/tqgc34yDlajzXHwGQFPm8w1+nkbh
X-Gm-Message-State: AOJu0YyyQkbcB9YfeVX/bQ8HBna8pHs6bbC4qQLIh+lsZ7AW8mfIBLSQ
	SmjSb01HCHUjArSaF2m5CpRnelh5XLVIbioISZdYeu2Ij0CwV1zYy7xj0NrwmIBif5K2rbOf0h1
	p
X-Google-Smtp-Source: AGHT+IGU9TKdkFWWYn5nManyHa5Cq12HDMG824kqhWOdOLInM9eT0d+XVJcxV596UFLLPDq03Xj/kA==
X-Received: by 2002:a17:906:f8cd:b0:a3c:8e78:8b59 with SMTP id lh13-20020a170906f8cd00b00a3c8e788b59mr1737035ejb.15.1708008977452;
        Thu, 15 Feb 2024 06:56:17 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906169200b00a3d1897ab68sm631175ejd.113.2024.02.15.06.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:56:17 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 07/14] linux/mm.h: move folio_next() to mm/folio_next.h
Date: Thu, 15 Feb 2024 15:55:55 +0100
Message-Id: <20240215145602.1371274-8-max.kellermann@ionos.com>
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
 include/linux/mm.h            | 20 +-------------------
 include/linux/mm/folio_next.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/folio_next.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 778f8aebb45c..680329ec21ba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_next.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/page_size.h>
@@ -1902,25 +1903,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #endif
 }
 
-/**
- * folio_next - Move to the next physical folio.
- * @folio: The folio we're currently operating on.
- *
- * If you have physically contiguous memory which may span more than
- * one folio (eg a &struct bio_vec), use this function to move from one
- * folio to the next.  Do not use it if the memory is only virtually
- * contiguous as the folios are almost certainly not adjacent to each
- * other.  This is the folio equivalent to writing ``page++``.
- *
- * Context: We assume that the folios are refcounted and/or locked at a
- * higher level and do not adjust the reference counts.
- * Return: The next struct folio.
- */
-static inline struct folio *folio_next(struct folio *folio)
-{
-	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
-}
-
 /**
  * folio_estimated_sharers - Estimate the number of sharers of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/folio_next.h b/include/linux/mm/folio_next.h
new file mode 100644
index 000000000000..f92d649c42c6
--- /dev/null
+++ b/include/linux/mm/folio_next.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_NEXT_H
+#define _LINUX_MM_FOLIO_NEXT_H
+
+#include <linux/mm/page_address.h> // for nth_page(), needed by folio_page()
+#include <linux/mm/page_size.h> // for folio_nr_pages()
+
+/**
+ * folio_next - Move to the next physical folio.
+ * @folio: The folio we're currently operating on.
+ *
+ * If you have physically contiguous memory which may span more than
+ * one folio (eg a &struct bio_vec), use this function to move from one
+ * folio to the next.  Do not use it if the memory is only virtually
+ * contiguous as the folios are almost certainly not adjacent to each
+ * other.  This is the folio equivalent to writing ``page++``.
+ *
+ * Context: We assume that the folios are refcounted and/or locked at a
+ * higher level and do not adjust the reference counts.
+ * Return: The next struct folio.
+ */
+static inline struct folio *folio_next(struct folio *folio)
+{
+	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
+}
+
+#endif /* _LINUX_MM_FOLIO_NEXT_H */
-- 
2.39.2


