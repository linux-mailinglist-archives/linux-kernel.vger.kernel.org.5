Return-Path: <linux-kernel+bounces-76456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3267285F781
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60421F21BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B244D9FC;
	Thu, 22 Feb 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Wq/gEQTZ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB463487B3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602674; cv=none; b=e4NfRsMD6UcYxLJDVbHDuNhnD17nhQSbOZYGewstt3Y4RJgjCln4O4wCO44hxmI0VbRDvIL9AjlwQFd2Ng2uGKUYqztP9kvlLrDIsCf/P3oPdDtuWy0J/yf3WQcGPcDK+Kc5ehXdCvy5ZHEeDoIJHkCVI6wTztPoGs3p2BEKu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602674; c=relaxed/simple;
	bh=nGXby0NmJJV7zXYu/W6/SBzCu1Ho1ka1ItR5hSRX0fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iy7UYMSLZdnIhpuWui46zWi8GLBeAkQhDf86n7dfa+HyglxuNCu2yxfRCKsq88kbDqdu409ZhMwsmYVMbxGTT4wGM0LUP5LJ+cGyf7iQi7NoWFOUJrQS6luXeMxaWr1FhTkDgq2BUpvAr7nSMg3LjF7SJ60uzcNhvsNDy1Q8lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Wq/gEQTZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d1094b5568so99787731fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602669; x=1709207469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9RcqoFubCuQScg9fnwnkgqqvXJKp60zqkqXexg+avE=;
        b=Wq/gEQTZ7rrxE2gu4QiZ/mirmJUeINetqgd+mt3Scw4DVXbGKSPbb7w7DmDxZj1UEA
         Or/FdYtqLPtg/zuyZLkSojYnnHie4qHAnqs3AcB3cQGaFVKc+HubIavh/yAm5heOCG2o
         Rj+MQk5Xlt8Phu4a9UVCMPcW5ndh9AYDMSV7P+HR8HSL0SWZQofGks9jIThYGpBAbnaY
         bAI2/xxsoE8vGZ8lKzYcs0hbQ2CWu8RpwfHimpGbvHJJZ98h1Wx5SeDcKSHsvEWwTAs5
         a3q4IexBAjb4ylDofOhI23c57nuJTzZOcg8yOkwPTtLi8bSs1JPihZHpPOnfAyB+EihZ
         BAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602669; x=1709207469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9RcqoFubCuQScg9fnwnkgqqvXJKp60zqkqXexg+avE=;
        b=ih2Xx5GaUpz6XZqyXHSiZZvykPFnCnboXU1xsw+WkazB9y7FGaV4KD29Oj+hF/qyGe
         RWhikjjMaY5mtvgjSjSsakqi7eiH81FbyY43BRJHCrf+AqPrKzSdQiod/j/9EivMyoLc
         63CnzIr/0dHa2SwHvTMIvfCx7yx+V5VgFIXoa1b/KngrQZDbN+EXfBkHYdg4f8QoebeX
         zEjyEjP4E1LcEh77SPHAEP9GgcZBK6tBwFi3lCigBRYvVdvbDybzypRtCdl+PdV9bjMf
         pCd0JpqjVhEJcDFNTjXdF01GNKr9+aITYpypxpOgYbtFD/rCTncybSr0pXsODABWCiQG
         RWRg==
X-Forwarded-Encrypted: i=1; AJvYcCUv8z+uW1JEYirkwuj67n7mu0Y87zbe9uewGw/8EXOIrfotYamAmW4gr/e24vmFLzXIxvS5eM+zXXMGOgX3BDv9ksIKDH/vDZhd53mX
X-Gm-Message-State: AOJu0YyqebvZX7OfaRjztPp6h2u9+k/fnBOoujsyCof4lqw3v9qQhGZx
	7+mSP9KCsLV1KYYbwfKUXT7rESsehsVJ7+lwXdo2a/hfCeXdY6ZTCZ4yLagMvgQ=
X-Google-Smtp-Source: AGHT+IGYV+VkpS2jnAWZLT/C7Reb89sTXA/vTqKXcqskIPNbelgHAHgf9vgjrOTAJQbjmnMw0na1/w==
X-Received: by 2002:a2e:968e:0:b0:2d2:43fd:391b with SMTP id q14-20020a2e968e000000b002d243fd391bmr6042449lji.26.1708602668784;
        Thu, 22 Feb 2024 03:51:08 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:08 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 07/14] linux/mm.h: move folio_next() to mm/folio_next.h
Date: Thu, 22 Feb 2024 12:50:48 +0100
Message-Id: <20240222115055.1172877-8-max.kellermann@ionos.com>
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

folio_next() is used by linux/bio.h.  Moving it to a separate lean
header will allow us to avoid the dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 20 +-------------------
 include/linux/mm/folio_next.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/folio_next.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9dea6477b4ac..7d83d6d64f30 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
@@ -1907,25 +1908,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
index 000000000000..7016e303439c
--- /dev/null
+++ b/include/linux/mm/folio_next.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_NEXT_H
+#define _LINUX_MM_FOLIO_NEXT_H
+
+#include <linux/mm/folio_size.h> // for folio_nr_pages()
+#include <linux/mm/page_address.h> // for nth_page(), needed by folio_page()
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


