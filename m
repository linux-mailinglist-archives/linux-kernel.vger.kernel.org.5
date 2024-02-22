Return-Path: <linux-kernel+bounces-76453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7C85F77E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AA51F215FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36984CDF9;
	Thu, 22 Feb 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g0eIL8rQ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29D47774
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602670; cv=none; b=meVl2YocZ+AGnHhg2VzJ5dwmrGvKWg/fXvxmpSV+088Kx2Hi+q/8FVRv9738AF9IuIoW5DmU2c0I2i5dR8XZEsqBSDlTTgmwZ3cWBizEWOESnPfEs37e1aOdBFkIz1R14oO4DvJtTkktz3ufCGPTez54Iu4OD3bdaaUdcdUkswQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602670; c=relaxed/simple;
	bh=q8kKn6ZoIx/6RjLM+3qIn9pYs3Fc/OtpL0DtI2Q7y9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh44g4dpeC6ny2khfvW3p9g54DJW/NuCpcaeeC4t2iG7wcGv3T4UHNflcNkdjCi5acqxEtpd8x8oWCncXnASr4eyc94YWh8lVxwWv2uN+pSXA4zQY/JBw9JLWaB/cxqQIEjASJFpqH4FGv3hQmssoEvgu1Txh+rrK67etpkA4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g0eIL8rQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4128d15a4e4so1586095e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708602667; x=1709207467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYSYlSdUn/dXTjpoW2eB+NQW7lqG+bTDZOpmc2h8jwc=;
        b=g0eIL8rQ2fH0h/GmuUP3dWN5UpXI1266O9mRsn0dXTc6dELpx0UcW5e2PrJ6t2aUKL
         muVEnyfQpnbF+/9whRcVjKbqO8kQebv7o1tS1YTYa8L8MqPb9tS8Snw5/bFgQ8dIHmjI
         U4KfdJsn3S+/nyYcrl0MF7sZykYllQrIBlLrRop2BIEvw7iBiMnSh9JrFyynvTe5nFgk
         RCTWSCEMcvXUXDutjMoaoQL5J/Ai0OUCCGjiyEyq1ywaShnOnPamyi02tM7ltpHyRUMG
         JJHQid6Sj/4Uzrg4Q6NWZCsXTLQmap0gOs3fiP6ncOqg95hjFmp0KXqg+qrJ2qylAF54
         yBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602667; x=1709207467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYSYlSdUn/dXTjpoW2eB+NQW7lqG+bTDZOpmc2h8jwc=;
        b=Opf25ie2KRFVnvi/tZBocsmW1zRPr43QzzLaSGG1m9FhBlbQIiznMhXJNkIwU6ftSs
         49x1ZftDH1l7zm5bbgXzkQy6L2EM3aiW7Rk8PanxrKF1HMAN2fBoIBDt5klhRPQLQedS
         eu2bnNK/AX1aRIjwdigslsyfLUOIV//UD+liqn8ASgw7dHVZUsSp/zR4u3X3aS7qY5UA
         l08f6+yH9aLUU7xd3EJv8m7ihtzCeXWNMMya9wvPdN3s3QG6QbNFAdRg9MNjmBSnEu+L
         nN8wmFZrXnNKUIvGrnun/dZn6bthJxa5hqjZuXW1htNzU/IYYwswSJEom3JdqWidQRgK
         mMxw==
X-Forwarded-Encrypted: i=1; AJvYcCV6b3dbTCxqcW4G5I3GgLhlhleRWtnsxQxJM+zsoZdP3u20R9KDB2qzTWOC3gDNn1KFkFfUjKfDfkrJlWLYqV1ahfX91o21yEPOX4Jq
X-Gm-Message-State: AOJu0Yxg4IrwBVRNkvqKvE7XDAzqeJiyRnV0c+B8/AZLcrKKupX0WiTC
	dt4hMVQraJzDYxIyuHhzhRjP9n929iVkeBm8UkadM6AU0NHuV9oDjGQWPCKipBM=
X-Google-Smtp-Source: AGHT+IFW5wFv4Nr2vL4lmZv1xSYSknW8VzR0FHgUnlq32KXpNWXRidmFH8ltDuIb+OCkhQa5lrc0ng==
X-Received: by 2002:a05:600c:3c8a:b0:411:9508:e237 with SMTP id bg10-20020a05600c3c8a00b004119508e237mr17669840wmb.19.1708602666816;
        Thu, 22 Feb 2024 03:51:06 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0033d4c3b0beesm15044920wrb.19.2024.02.22.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:51:06 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 05/14] linux/mm.h: move page_address() and others to mm/page_address.h
Date: Thu, 22 Feb 2024 12:50:46 +0100
Message-Id: <20240222115055.1172877-6-max.kellermann@ionos.com>
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

page_address() is used by the following popular headers:

- linux/bio.h
- linux/bvec.h
- linux/highmem.h
- linux/scatterlist.h
- linux/skbuff.h

Moving it to a separate lean header will allow us to avoid the
dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 56 +-------------------------
 include/linux/mm/page_address.h | 71 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/mm/page_address.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c3d2bd69818..57c091e7579e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
-#include <linux/mm/page_kasan_tag.h>
+#include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
@@ -103,10 +103,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
-#ifndef page_to_virt
-#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
-#endif
-
 #ifndef lm_alias
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
@@ -210,14 +206,6 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 
-#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
-#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
-#else
-#define nth_page(page,n) ((page) + (n))
-#define folio_page_idx(folio, p)	((p) - &(folio)->page)
-#endif
-
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
@@ -2122,44 +2110,6 @@ static inline int arch_make_folio_accessible(struct folio *folio)
  */
 #include <linux/vmstat.h>
 
-static __always_inline void *lowmem_page_address(const struct page *page)
-{
-	return page_to_virt(page);
-}
-
-#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
-#define HASHED_PAGE_VIRTUAL
-#endif
-
-#if defined(WANT_PAGE_VIRTUAL)
-static inline void *page_address(const struct page *page)
-{
-	return page->virtual;
-}
-static inline void set_page_address(struct page *page, void *address)
-{
-	page->virtual = address;
-}
-#define page_address_init()  do { } while(0)
-#endif
-
-#if defined(HASHED_PAGE_VIRTUAL)
-void *page_address(const struct page *page);
-void set_page_address(struct page *page, void *virtual);
-void page_address_init(void);
-#endif
-
-#if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
-#define page_address(page) lowmem_page_address(page)
-#define set_page_address(page, address)  do { } while(0)
-#define page_address_init()  do { } while(0)
-#endif
-
-static inline void *folio_address(const struct folio *folio)
-{
-	return page_address(&folio->page);
-}
-
 extern pgoff_t __page_file_index(struct page *page);
 
 /*
@@ -2222,10 +2172,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
  */
 extern void pagefault_out_of_memory(void);
 
-#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
-#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
-#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
-
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
  */
diff --git a/include/linux/mm/page_address.h b/include/linux/mm/page_address.h
new file mode 100644
index 000000000000..e1aaacc5003f
--- /dev/null
+++ b/include/linux/mm/page_address.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_ADDRESS_H
+#define _LINUX_MM_PAGE_ADDRESS_H
+
+#include <linux/mm_types.h> // for struct page
+#include <linux/mm/page_kasan_tag.h> // needed by the page_to_virt() macro on some architectures (e.g. arm64)
+#include <asm/page.h> // for PAGE_MASK, page_to_virt()
+
+#if defined(CONFIG_FLATMEM)
+#include <linux/mmzone.h> // for memmap (used by __pfn_to_page())
+#elif defined(CONFIG_SPARSEMEM_VMEMMAP)
+#include <asm/pgtable.h> // for vmemmap (used by __pfn_to_page())
+#elif defined(CONFIG_SPARSEMEM)
+#include <linux/mm/page_section.h> // for page_to_section() (used by __page_to_pfn())
+#endif
+
+#ifndef page_to_virt
+#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
+#endif
+
+#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
+#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
+#define folio_page_idx(folio, p)	(page_to_pfn(p) - folio_pfn(folio))
+#else
+#define nth_page(page,n) ((page) + (n))
+#define folio_page_idx(folio, p)	((p) - &(folio)->page)
+#endif
+
+static __always_inline void *lowmem_page_address(const struct page *page)
+{
+	return page_to_virt(page);
+}
+
+#if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
+#define HASHED_PAGE_VIRTUAL
+#endif
+
+#if defined(WANT_PAGE_VIRTUAL)
+static inline void *page_address(const struct page *page)
+{
+	return page->virtual;
+}
+static inline void set_page_address(struct page *page, void *address)
+{
+	page->virtual = address;
+}
+#define page_address_init()  do { } while(0)
+#endif
+
+#if defined(HASHED_PAGE_VIRTUAL)
+void *page_address(const struct page *page);
+void set_page_address(struct page *page, void *virtual);
+void page_address_init(void);
+#endif
+
+#if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
+#define page_address(page) lowmem_page_address(page)
+#define set_page_address(page, address)  do { } while(0)
+#define page_address_init()  do { } while(0)
+#endif
+
+static inline void *folio_address(const struct folio *folio)
+{
+	return page_address(&folio->page);
+}
+
+#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
+#define offset_in_folio(folio, p) ((unsigned long)(p) & (folio_size(folio) - 1))
+
+#endif /* _LINUX_MM_PAGE_ADDRESS_H */
-- 
2.39.2


