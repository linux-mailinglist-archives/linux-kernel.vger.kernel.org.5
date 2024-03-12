Return-Path: <linux-kernel+bounces-100046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 538EF879132
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77AC21C20CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A27AE49;
	Tue, 12 Mar 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KETwIXC0"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13A7A136
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236518; cv=none; b=Gbqfwv39S+FwwZ49FEPvUlBdDOCx9aP4Ushem0fwSazSn+Dzcb0EV8vKYho2JzY8Y9IJIp3KJ0eMMSBAYTP3lIn/KNs6huewB9R6cr7VWbXggzdHwjWcDe04vubOAnqKuYjQ6WuTguc1tp0pTAl1HKmVWvgaMG74j/erfOl3aw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236518; c=relaxed/simple;
	bh=7TBD917famya0UMoNWGhR2gZVEy1ZqrdJunlSs1U06E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPWzPsdaPSs7GJtlPdYl+NbHgrALKxQVJuofFRFKOd6IBADyQJkchuolCUinrlQxPO3FghDAy0+phygwtVE9ba/iHDzyW4oFD5pA0asv//p+pDwSR+qnDGJKm5JOydk9NzUJPlyEvZsKS2GLIUgrh3iSrT4AoxzgYNmfS9C4D1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KETwIXC0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4644bde1d4so56084366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236515; x=1710841315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QtTxRX/inj0OtKTHCIe6FPb0V6jffrKP/nT087XKzU=;
        b=KETwIXC015fXkXmZSPZ43QFrlXLllMBqEECIlYcAF8xMBAB46MCBpDMLhAVY0j9YZf
         1CrVf4VWdEBX6PYCiUkluM2UAXzXq5KNtfZQ81Q7YI2+r0PCZG9gmzmyPS3UdMZBeieW
         by69KdZgaLMKovdQrRSg9sMXWnJ/BCZJx+ajSh/0nDdr6IN1pXlxJS0TiMqS/CGffb42
         Ogfyig8Gf61GOejz3VRSpsMO58ff+EX+F3eaiTIabXx0eP+7XyW0mhgA6UkFTX9sgvpF
         2h5mdHS8yHMoyQ11hkOcOpJOXsWvkXyokSnhPIof03CzyjbnOnR6x0+l1H8+aX9w6xFP
         THWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236515; x=1710841315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QtTxRX/inj0OtKTHCIe6FPb0V6jffrKP/nT087XKzU=;
        b=cX3x1lrJ+IFZtZIcfC/zFWoKnjyrHFvDN+p8eJSzdktJjFZU8lEVxFuLKoWOvNFRTx
         aXBF7W8iigGB9DF1UdXe5hQB8Je865/5g6FSlpD6Za5wa/JA9hixKTqlemWsEWHK/PVa
         WyS7ewBucTeGIkDHkgKljkcwRIBZ6hgssyKXo107FghMlAEE/61XYXJV4D1UtQYNwb5v
         acoqNMSHT2H+92MreJKmF/XY5ujRfEpyCuXuIDrRi0p/MgyoW3/H7PRuBXO49LujAy5T
         P40hYfOAmNOLeBpPm0lPXN8+Z+H2tqAhRp0grr9fwiJHYPbnsLVZ9ye2SqEvJc1vX0dD
         bOFg==
X-Forwarded-Encrypted: i=1; AJvYcCUkFcw3hX4aoYVdCcsimagACi9un5bPPcqCBYuv3T5iXKDmjEySJzB9tN7PMQKGHtzptmpng8v1mZCmCaYy8VVn9Va3feHRVoOMaJ8S
X-Gm-Message-State: AOJu0Yyrt36XmPvMHlTD1ew2dWCBamvL85cdyh/sjwCBfQCPJxXYPTq1
	u2FNHykXxcQ4P94vdUi5NW+HFHXgBgCOKFj8SzWs2ROnhYI3kqzlMst/oYT4wmw=
X-Google-Smtp-Source: AGHT+IFns2Ypn2XVsNVNAKrCcBt1TN2yH+bK3v2AhDeQNnfgdKRGlRgshyozXFibXBgkrU0IXHzkGg==
X-Received: by 2002:a17:906:234a:b0:a45:cdb2:b6db with SMTP id m10-20020a170906234a00b00a45cdb2b6dbmr5768531eja.46.1710236515272;
        Tue, 12 Mar 2024 02:41:55 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 06/15] linux/mm.h: move page_address() and others to mm/page_address.h
Date: Tue, 12 Mar 2024 10:41:24 +0100
Message-Id: <20240312094133.2084996-7-max.kellermann@ionos.com>
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
index 79c1f924d4b5..713cedc03b88 100644
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
@@ -104,10 +104,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
-#ifndef page_to_virt
-#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
-#endif
-
 #ifndef lm_alias
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
@@ -211,14 +207,6 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
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
 
@@ -2137,44 +2125,6 @@ static inline int arch_make_folio_accessible(struct folio *folio)
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
@@ -2237,10 +2187,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
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


