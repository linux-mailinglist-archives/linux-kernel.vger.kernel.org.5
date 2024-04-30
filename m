Return-Path: <linux-kernel+bounces-164275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161138B7B98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3137B1C20FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0B17920A;
	Tue, 30 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aPObLAnB"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958917335E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490997; cv=none; b=cbVBACAn/nU3aAwqefnZ3eRWtFOLXFTDnOnNFGIhr+FRK0PIAZF8/TgxV0Ak0Vwt7m3Gcsw4U/jqDllRRkTrITjtpWA56KRNV+zEi2RzhnmvOLBGer/0kffnXptSPWrxa7n3ZAQs/JdbbohAP5MK8kJSYddb9XBiggomj/N9Gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490997; c=relaxed/simple;
	bh=7LXsGdFyTAadwH3oT2EvB28RNXw9kvsQ28WEFgDNWwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyfkGrLnKnlOPBH5u+vyLeu3z64/SVc5BdDkfZjQZB85t+x6CnDp8gPRilhTbTFbtfxfp6PrkBMXwYMhI8F1PpV3l2ge2EtspGpxb7Ef2R0OjHqF4cT+AgvU9nmYZy0UUVTBHgX+YEamIXJHhDRMCPl621F6bWCNMDFApMm634A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aPObLAnB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so6275910a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490993; x=1715095793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXKxrCtgCvr5klQOAqmpVlw6+TXQtqNqSxD0Fn0GyUc=;
        b=aPObLAnB5jbXgQD+blDSDNuMbuOG5AKAxmr/vlYtWgykeQTO7X/2DTYfp8T7y0Wdqh
         DM07VpFIyl2CDk9N3pnBGNlGH59rPk7+LIQA38+WH7s6uAaFyilwdA5WbgnQSerCfbBE
         f3PEdKwRoZ1Tsry3VS0oD1EZ+uSC6NACKK4x8HsfTDC+O5vW+X3eGOwfr6YQB2Y3yfXr
         2q6SLRm2w1zi51tB72fv/LDXuC755HW0unv5IMijLuHEelksYKn6slSX3iizOEzzDPhH
         pew9SAXIOb/B9BozlIuEGpk2v5p4FEEqVkRuO9NolhtsFlMf1DBHoT0EjeQlB34G4e/a
         qIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490993; x=1715095793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXKxrCtgCvr5klQOAqmpVlw6+TXQtqNqSxD0Fn0GyUc=;
        b=o6WGj8bDrje+uuBkMDteFbE+iEwoWAcGV+z9Y/Xo8GlKBR2ARDD1g/M3Trwlo0AfhV
         6mXQEncqcH9HYpEP24/R1o09zNOLkL7PWaxDla/6zXe6m/9NqAZt0fI9noTiVDKFI/0m
         HWeZqx1VkH2OjA+y/stEsmf6bto58J8+tnzDfXOjD6KtqcTJJ+2ZuDHdVRvGLjMPuuKu
         I8SwNkblmpR+N3zZCd8n8m7y5S3cQMFJ8pjhMu1CwXfMdbdaS8boaWICkmBHA9CJBKAo
         /TsVfecx45cDrwXE5t2MgP1UO78tuyY1EFbLZ3tFCLD+O3jUbDXlG5H64rAP3XDmVDDB
         2jwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWSdZrhpdqUFF6JcdS978OKAyGe/wVBvej3wetutZMVXmuZQFvBEl2/KDIAaafjcKgnCgYJ4IxrCGV9GSgO5FUt+lBXIRZbQyPrQKh
X-Gm-Message-State: AOJu0Yy2oq4RGbmrTusltu0FyD0EG/5YtuoHvKUZ0RL1E713yoeN2lFg
	SKezTdL85XnQJrwT5wvJPmaFKnWLkacjvhCF09Nqae7gxF4lkjJ1GQgh54S0zcg=
X-Google-Smtp-Source: AGHT+IF1Kcn+grgqk4BRBsySeGH9c4NPl6D/AQSw5d/hYpB6grkidjHbqos9xjspf6/C70Q2HKf7vQ==
X-Received: by 2002:a17:906:40c9:b0:a58:9a74:57fc with SMTP id a9-20020a17090640c900b00a589a7457fcmr56836ejk.15.1714490993267;
        Tue, 30 Apr 2024 08:29:53 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:52 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 08/15] linux/mm.h: move folio_next() to mm/folio_next.h
Date: Tue, 30 Apr 2024 17:29:24 +0200
Message-Id: <20240430152931.1137975-9-max.kellermann@ionos.com>
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

folio_next() is used by linux/bio.h.  Moving it to a separate lean
header will allow us to avoid the dependency on linux/mm.h.

Having a one-function header may seem excessive, but there is hardly
another way if we want to distangle linux/mm.h from linux/bio.h.  If
one day, say, folio_prev() gets added, we can still rename the header
to something like folio_iterator.h, but until that happens, this
folio_next.h header seems like the best trade-off to reduce
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 20 +-------------------
 include/linux/mm/folio_next.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/folio_next.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d5019aed8330..5b3d56454344 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
@@ -1924,25 +1925,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
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
  * folio_likely_mapped_shared - Estimate if the folio is mapped into the page
  *				tables of more than one MM
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


