Return-Path: <linux-kernel+bounces-91937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8955F8718CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDADDB23818
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAFE53816;
	Tue,  5 Mar 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LZG8Jhex"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D31524BC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629183; cv=none; b=rsFYETTUFfSZJHznlTdZp0cPtwULsbv+1+MX0zl+ZowsEY6wrSxT01BpPk+KifKH27QkzE9EfrZOvzmfRC1mr7WNBWYniWdXth33xtojlM30OhA5m8/+mUL6DVUWJj61H+lJXSA6DKPYLu/jERfvoGvBaC6pLyFSX8gu/T0X4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629183; c=relaxed/simple;
	bh=7TBD917famya0UMoNWGhR2gZVEy1ZqrdJunlSs1U06E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADln2p4Ue3RytwzWhOqsow3gQceCF1Qf06l3GOLi5zzf5vGPV0trqLzlfBlh39DArVTFFCogNpR3osGjcp8hPr+rW/vRXtXvPep7WYcwV9u/ILYyhGOL8cY/hJx19a2KfsE1BWE4K/wggiALg2l1e3swOJ/Ore1zz+VKbQhhQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LZG8Jhex; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so7369279a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709629180; x=1710233980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QtTxRX/inj0OtKTHCIe6FPb0V6jffrKP/nT087XKzU=;
        b=LZG8JhexkCR1aPdYJudJUIUnHFDJjL5tzAwVlRrIzR85RCqmJewAsPdTQ/Wvdi/hly
         qMhScuNL1LPflSHd/y/aG29LcdppHtlcj18bAhuwZ4vziOvV45oq8C3hQBp/iNOb2/0m
         X4oYAJkiKJ8j7GM3EaDxzs/gPH3nkh3VAveb2JBFDF60KWObHZSw7JNVd5oOpAOy/kjx
         anb6AqyL55fMmEQ0ST+qcfA0itmVr/asmY+2j0SrAO1wD7WsKICQ3p/CFdP3OCeEuOeh
         Zf4IgkYp/+IhDH9+E+F1oewzPFKKdLhZ69ypVOS4pTw0ola3FJ8vFmmheBKoVzxurwO4
         S52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629180; x=1710233980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QtTxRX/inj0OtKTHCIe6FPb0V6jffrKP/nT087XKzU=;
        b=oEqPFVbOGln/5KlMSnleK2eEPSzbgYXDTLles5Bl2MTkBOXYxCaPfi/z2XKYNbCfs3
         iNoJaBetFediAIBmYhvgSWG+996UgfnNnRwg4NGVejTG0rr/goyRckFmuRp3jHd91hyL
         8zluOF7CKTFVFpi/xVzi6QNaKbvWcDmjJG8EcxOQlePBoyFEtYYoljKciwmuIsufHYPJ
         jkmEY97k2kDjawQ+5lKn1yEqC1F+pa+lAl2dk8MA0a6HQ2mGNLyHy3USmErpmRpOUBYZ
         0z4TV2Id9+8CkLFqtG74miEBXUypyzpHgvuH6ArW/898FD2JU1wZKXkcxedGtfKFH2t4
         T2jw==
X-Forwarded-Encrypted: i=1; AJvYcCXGx9122h78RVJi8erRloiI01H6tJrCV20Pr3YKgTnqDTqiMBEsM2N8M0GvEOyJOPEDWqadUfDn3wBNGx8VxQOlnCabtsbbmIIKmTd1
X-Gm-Message-State: AOJu0YzBhKG6mPnQ+Hdjg3M5AtwGGjM10Y2E67GFqyYRSK9y7L3uPi2b
	BUQji8ORItpkVMxxA+oLYkgpMZRDBC0tQkpZbOF2JCh6z4SuTYma6POGfyjiSjCOvj8J9OUCa1x
	b
X-Google-Smtp-Source: AGHT+IGLVXgC2Q8vwJVeBVQ7VcbMya+GmcQDX1B/t3cUkKCgkZulprKrnzJI+ititEHBWTC1kz24QQ==
X-Received: by 2002:a17:906:3442:b0:a44:3ec9:1fd3 with SMTP id d2-20020a170906344200b00a443ec91fd3mr6469936ejb.30.1709629179998;
        Tue, 05 Mar 2024 00:59:39 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b00a449d12cdc5sm4453005ejb.119.2024.03.05.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:59:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 05/14] linux/mm.h: move page_address() and others to mm/page_address.h
Date: Tue,  5 Mar 2024 09:59:10 +0100
Message-Id: <20240305085919.1601395-6-max.kellermann@ionos.com>
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


