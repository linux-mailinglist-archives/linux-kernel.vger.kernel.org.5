Return-Path: <linux-kernel+bounces-76452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDB85F77D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28C91F26636
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF05482E2;
	Thu, 22 Feb 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QfFKhXnj"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B846521
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602669; cv=none; b=khz4quS/B3zH6a39If/Duka06KLW5p/+Ah4+FvogKU0K2JtYfgTwBI4oh+RkoL7oaax6SPiS7hu+nPNcIR5MHAifMjN/cscnnqrCitTO5Eiv2+AmVidCN5akq6XMHnSNRG0O8TNOro4sKAXeRtfBxMZvDeoGyKmmQ0QN+Dj+u1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602669; c=relaxed/simple;
	bh=LuiNKwot/c2cGXu1azbocNtVe8hBsdaf1P55KumReSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9r2+qe5ge69XV8GeMNOnh7Q5mT8qVagwCBBPfSUunQvPybnCRQzn7V0Aj2tA7Iq5UmVPh4CocRFcARPAE3kp10xYn2ziQgDF9XbxpnoLcEH9cx2C/iUaweVQTh1wYx1VCq1UVWP0e3EiZ4JG14fTZK9XK0DeWvcz7ufDbP6K0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QfFKhXnj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so128418f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602666; x=1709207466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU66tnpYofC3HczPR5LqCx53IAlSBOajb8Iggei03v8=;
        b=QfFKhXnjAq30/tZfPhsxMENYDZlQaRwHWLbQv5/IfE/Rgos158IFhti1m5CcTxGBio
         o/v0JUAHvRhA7FKPHcTkZ2iD4NiGmfmGCOoOcbvA1ZTEEvMGt3QvT/1X/uf5Ml0vdMkT
         7q+T2vdgQ4xA5JlUaWHukRe/hn/P45qy+C/F/nzO1LTY3RbdHgU+Kk3Hlzi79d7jC8st
         TeLCRKkfgTfz9pblVE2XqxXPfQkwMxYA9utemdHLniTGvr7+lIci7bmklxu5SKdqGlfS
         BhcbCEzsOMQ6IuNLIlcGmG5hGQExEV+ANqKr6og3TXnSsPXS/o5cpZ2K0w+w9dmNjbE5
         gDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602666; x=1709207466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU66tnpYofC3HczPR5LqCx53IAlSBOajb8Iggei03v8=;
        b=JrY4XR33aKzOjhl0erEtpy2mZBefsn7oBhylAF5f5SbGGkzPYh81AumUtfTbIDAUZi
         RgJw0NW1wuTnood/SI8A74ZHQxLaU3Aeiav/5NUTIy5KNuxiimsUd6tICyDDT5SPYHPu
         Eqnm/ejQm81yiutY8o4NyvMKGSNKRKnwxbo3j2p297uB/hZ7N3FEcuR1LFJM0gvfamea
         E/nB3zz6Fw2C8iBmBtv16A8JiaBGMZbargdgGyk2S4FXbbo8ubjyd0BEBuvEw6fzdJEe
         RTH4hHtDlkMNs52htAgq2F3nH1U/UE7hpDFRb8NIFVu9BqE2TbjUQKV2M4QELbku9Y3R
         rpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuxfy0gYSsSTSM4PEArvy0jcSHtidFF12pUcmw/0UTdamHjuZPiSEEg9XKOb8avnNqGhwfC9GrxU23BKrcE1tzghNWGs2Cv7Q4hcfU
X-Gm-Message-State: AOJu0YxJ+qQO8kKZRLQGGGkFTBop/uw3u3CaNh+AjG+qN6iFObdPIAmH
	UY3SjZmEN/HPPHMiLiHl2fuB4AvB9qTbW/i0YDVBef6bLyKzTaUm0YgcTChLqfY=
X-Google-Smtp-Source: AGHT+IHWgvt0/sZsRq4iRTjhX0psvS+eVhVBMHB4PSfSQw/t1/qrWtQi6HShkpncAQZpTNIObD2jGg==
X-Received: by 2002:a05:6000:12c5:b0:33d:40f0:b0de with SMTP id l5-20020a05600012c500b0033d40f0b0demr7809643wrx.6.1708602665810;
        Thu, 22 Feb 2024 03:51:05 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:05 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 04/14] linux/mm.h: move section functions to mm/page_section.h
Date: Thu, 22 Feb 2024 12:50:45 +0100
Message-Id: <20240222115055.1172877-5-max.kellermann@ionos.com>
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

page_to_section() is used by __page_to_pfn() (but
asm-generic/memory_model.h does not include linux/mm.h).  Thus, in
order to be able to use anything that calls page_to_pfn(), linux/mm.h
needs to be included.

This would prevent us from moving page_address() to a separate header,
because it calls lowmem_page_address() which in turn calls
page_to_virt() and then page_to_pfn().  To prepare for this move, we
move page_to_section() out of linux/mm.h into a separate lean header.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 18 +-----------------
 include/linux/mm/page_section.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/mm/page_section.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c8d909cc1353..7c3d2bd69818 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_MM_H
 
 #include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1627,10 +1628,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define SECTION_IN_PAGE_FLAGS
-#endif
-
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
@@ -1830,19 +1827,6 @@ static inline pg_data_t *folio_pgdat(const struct folio *folio)
 	return page_pgdat(&folio->page);
 }
 
-#ifdef SECTION_IN_PAGE_FLAGS
-static inline void set_page_section(struct page *page, unsigned long section)
-{
-	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
-	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
-}
-
-static inline unsigned long page_to_section(const struct page *page)
-{
-	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
-}
-#endif
-
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/page_section.h b/include/linux/mm/page_section.h
new file mode 100644
index 000000000000..e4558c2691b8
--- /dev/null
+++ b/include/linux/mm/page_section.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_SECTION_H
+#define _LINUX_MM_PAGE_SECTION_H
+
+#include <linux/mm_types.h> // for struct page
+#include <linux/mmzone.h> // for SECTIONS_*
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define SECTION_IN_PAGE_FLAGS
+
+static inline void set_page_section(struct page *page, unsigned long section)
+{
+	page->flags &= ~(SECTIONS_MASK << SECTIONS_PGSHIFT);
+	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
+}
+
+static inline unsigned long page_to_section(const struct page *page)
+{
+	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
+}
+#endif
+
+#endif /* _LINUX_MM_PAGE_SECTION_H */
-- 
2.39.2


