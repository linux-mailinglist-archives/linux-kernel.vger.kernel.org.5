Return-Path: <linux-kernel+bounces-100048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43446879133
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6AFB2382A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192579B9A;
	Tue, 12 Mar 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RspeanrF"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FED78662
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236521; cv=none; b=uifIwy06lYilxAUXMqo2pir4ome99wBc2Sk++jhgQDBs5bdtUANP1BxIT3a20vz7iueihzLRmgDFRlg7hDm+U24Vj4lvKebUopsDbKPdTR3OhDKfIbBXWmIYnI/tZjgXoFrUisDXhzpmAq2PIG0VMNKOWD/7vOh2Q0lM+xi7+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236521; c=relaxed/simple;
	bh=vokolUNNjWemvOpIVyP0bPJJZO5YFTXD/1zFkqXp+GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvRJW69+ELHKEJk7z6fHvN7J6J/35HzkQlGDHEiQJ2ZDi8VjH771/87DcY75BRHn+fCLGvFHvPGXhzuuOdFjrRuSKPwwTg6llsOEpfHxLMVPfVlnvx2D5I3TZp34WYpkbdyXrxpQOuMy2W5+q9+tqy/G3LkAPoWpONUkCUJ5c6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RspeanrF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so1131195266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236517; x=1710841317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPRAHmknVEgQF0+eI0cWSAplWfhzwY2EyeY5NbL7yXE=;
        b=RspeanrFD/iO01lBT5nrw8I7iMYd3NbB9Ceo6iyTNq4H9h3B54jDqJb8vIXDRy0G5r
         7u4VIZ+lLArqMMNqdxoCP23kpuW9/9zF5BoKINhqnopqf3jPLYEh20XD8y0XZFGTl1y6
         +0C259SkRzjizGfVG2+gFXlZ5PuseDNBpPqHnOUJo1J8csUYEq2Ww44E72GFEi2hAB2U
         1KTkPl7MbtmAtIJHlsTSF+zRB0soTTgECmU2GWmBhYJJyTwqc5ChAVqdxHq9p46h40rw
         8OeBd1CQtNr/7+hcAYp5D/DAn/7XLGG8OcKLvnNVda6vi2Ubv2xVgCXwHv/SJPPXOX9p
         7IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236517; x=1710841317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPRAHmknVEgQF0+eI0cWSAplWfhzwY2EyeY5NbL7yXE=;
        b=VASNjpZI4IwDCzKw0pCKRZp9kd38WUaUCPqgj4NrJBYXbrJNOqCmHJ4WKOUJ/4P9hk
         OGjMstnCuZp5fS4zkiqgMXQng0AfenD/IbiCs8DPFbCL7wtZl0m7nQu8iyXjp36IwuOU
         Z8dbNmDvm4f/YTMY+F/jf073sIF8Q/fpuTG0CSlBDUmuVAokXTuJfz7C2hBzWP2934wf
         +mhIoNlSa0rr2ybe7GEdlpbQHWpe6yNx+ScmRMBQ7iCbQbe7ok+RPn0sUi2sdPaKT2/s
         XLB/uzY8AGZDN4yXy4x/cTQn0K+9t0blvLft7jPKhL2yR3tCbXsR00oaHv3P2VU04HHc
         S0oA==
X-Forwarded-Encrypted: i=1; AJvYcCV8y0CZlOAc0wik9wKE8G0QjiGLIcOulMD6h4uhk+SpkoOPabo0W+5VeqZK5j3OzvXvduBGdVaaIeEndSluZnWLSNUFLLl6rkJ3i8LG
X-Gm-Message-State: AOJu0Yypa/obI3+r5rU81shum0HTpCLqOo2wwR4brVsrE7Bn74ZHuGcs
	teecdsEKpzN9KkdqPOx/5x3L6hQvlwOIh6B+ccyDqUUsjtPwov8dF5SBjBc7p6Gp6IT/o5bSfQY
	Y
X-Google-Smtp-Source: AGHT+IFpb+EqT1uOp7qLMTVjHTnEYVneJSFf9T7njrEKUR2vn/eqj2u6x7yeSAPGnaQTnMQUYnssdQ==
X-Received: by 2002:a17:907:868a:b0:a45:b616:29fc with SMTP id qa10-20020a170907868a00b00a45b61629fcmr9967232ejc.0.1710236517463;
        Tue, 12 Mar 2024 02:41:57 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 08/15] linux/mm.h: move folio_next() to mm/folio_next.h
Date: Tue, 12 Mar 2024 10:41:26 +0100
Message-Id: <20240312094133.2084996-9-max.kellermann@ionos.com>
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


