Return-Path: <linux-kernel+bounces-91939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39968718CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BB11C22343
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4855490D;
	Tue,  5 Mar 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JIOjgppD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCD537FF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629186; cv=none; b=akgxxGVNeBJ+0vr7YSkObBTWjEnIzsmfYKSSQjGCE7Lpl5GXn+wR+VSozEB8Zm+kKBS2QijKqKWdhnVy8lcNDznTKx2dTAiAvtmwgpNgtoK8+EGRmlVf1o5BdAsWqblR92Yhkl1m49w7/nkYEb3UE7iK3A9uhY5EHoEu8SFX0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629186; c=relaxed/simple;
	bh=vokolUNNjWemvOpIVyP0bPJJZO5YFTXD/1zFkqXp+GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0x2RVq6/1n04CwWzQHXa+yp0f2g/7MvkQ/g6zj0ZcrrFsDmQJlO7FyhCdMMHjN+Ng0F1JnVGHY1Udzvr9KYXsjUUZj2o9rfNOqPeV4dW2bt/NEKKo3zXO/EWddLrGmPI2zFHFk1zdfL8niR7BsOjjQKsTzMsMMvihSHRU4IVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JIOjgppD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28a6cef709so869757866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629182; x=1710233982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPRAHmknVEgQF0+eI0cWSAplWfhzwY2EyeY5NbL7yXE=;
        b=JIOjgppDMyvjQA+LXNPXxlROhoBuhE3PDuqaZC40kzuCdd7moO/mR97RA3oPUKj6rZ
         LwNxACZzpCfc4Z/Ms23AFFrCTpX/GtduDMzndBh6LDoee2zmojtAi+vraRRMS1dXX5bW
         tHCf60ka4DT2UxnblTSVwhsuo4sZZZm84sRDwaAI79wKi/J82KtfFFvvgmzDXgu8RNwp
         vRMUijXyC1MZZTau8hYFUFM9Ce74fKTcSmGtcfP02XXcbjSAOb2Wmy/BWLdHTMomrvFx
         DI97z7cYpeKuBeHmpSO56sA9kyQmKXWpogm9zXnmVQV44vOMssL/b8TICxNw4iGbqeTM
         21ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629182; x=1710233982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPRAHmknVEgQF0+eI0cWSAplWfhzwY2EyeY5NbL7yXE=;
        b=YRPvat1akoMohCrNuAz5YB8qI3ENuvyuxT5IRSdZcFtFu9PrdL9LeCSAr3vq8Jz8Ls
         iV8cTpFgkO6KlcRarmZ0MVrMTI8KlJB3PTUshOrlCO8jI0jdmAt9TQ5uWuldP8Jx2c4N
         v4LEivKHdwQfuO46TlT+/b7l5bTYWcquph8G3ZuV8EdTJbpHPiALWG/vVkZYPdbZSb2c
         cMAXCnq7u/yUVKpvjqwKaUndHn6a9XXRzom446XzvrojPP9YlHoH6Aqq3dr2blNnpnZg
         w1bOZmM+WlCnkq1ZoV6BSorVH7+LsXJMIwXHLNs7zURgaVU4z+qdkvF+QSeeD7khSaec
         jEqg==
X-Forwarded-Encrypted: i=1; AJvYcCUkYGFu4D9IaooT8jIiZ+fWmu7Ia76LKQg5RNLmc7y67VFxeLz2JYyepndX7yNmEUzzLqdokB7c9IQdmN6KPlhbEUYlPFPH8kHooyeu
X-Gm-Message-State: AOJu0YzzBQVPk1+xKummRuzqre+8tr8ULvHz47tYnirmDLphqsNp4aFQ
	ZQvCyfqIofPqCUm7YDOXFMCgxThu+pcbw7RtpKFAe6pVKAj2TxlCDOcgZ88cwhs=
X-Google-Smtp-Source: AGHT+IF3qHNB69qnbIhdOhCn87w4BHGGC/TCaWgfYQYaremgBcPzr7gTWpssGSWJR1NdgYL1iKdKJA==
X-Received: by 2002:a17:906:37d6:b0:a45:f05:7e10 with SMTP id o22-20020a17090637d600b00a450f057e10mr4709827ejc.24.1709629182494;
        Tue, 05 Mar 2024 00:59:42 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:41 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 07/14] linux/mm.h: move folio_next() to mm/folio_next.h
Date: Tue,  5 Mar 2024 09:59:12 +0100
Message-Id: <20240305085919.1601395-8-max.kellermann@ionos.com>
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

folio_next() is used by linux/bio.h.  Moving it to a separate lean
header will allow us to avoid the dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 20 +-------------------
 include/linux/mm/folio_next.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/folio_next.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d291ff61db3..e6c2df977abc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
@@ -1922,25 +1923,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #define MAX_FOLIO_NR_PAGES	MAX_ORDER_NR_PAGES
 #endif
 
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


