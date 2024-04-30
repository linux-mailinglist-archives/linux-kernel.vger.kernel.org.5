Return-Path: <linux-kernel+bounces-164273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7F8B7B97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309E7B25D34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D117333A;
	Tue, 30 Apr 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LEbFh+6P"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79FF9D6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490996; cv=none; b=BfeyLJY8tCN+ZrOWoep5p45Anl+cXZcUXdKe2cZsuvFp3Ra50MzxibPhirEMAhwznU/9IluYn+c+EU7+Sy8PxjVpavxpvuDD6vo2QGVfNzeLYZw/ly6qwbE6c7ulAg6g+lSLsSZJchQIN+69gq7YgxqLdSeFGC9xqoorXM0GnrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490996; c=relaxed/simple;
	bh=Ll7p6UOKLjdHtcpla9yO+6RYjH04Rsqo4d6kOR4adL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kd9273dmrVNlJTHOjVACkgACPnhSQSzF1yqAPFWbOAtQH1gAWvqt8pOAGMESBJnDVglvR4jg2CG0WPxelDv7ggOQWzZVFU1SogXe00lVEuNjctnGD4pbvcZAs2VUPsybA8ZmiF+5nGGSasX+ihymU949+SgE9QPcv79DIpkVNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LEbFh+6P; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so91587871fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490992; x=1715095792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clS/QN9E/f3CIYj6dWbs31v4GElV2ZW9RMM74gwG6WM=;
        b=LEbFh+6Pdmim2Fe07m5tFQaGBSNOKufeAajU9BpzFD6RisYHyjZ7Rp5NcI4vZTbKMq
         nkoei+IGu2Q1c0JkuFowuI23kaHrW5a+O+9dhxU+xRsuvR2pUmXJ9XaliExPfrV0cOr1
         nNlPyhB06kKGMoKvhf7HvMoQBzaTgq9tBvemIEokz3SA6HRZVfm5mnLoj/Z6uLfTVyCl
         Hetm6vDNtIcpgXNiCyYuOPWkCPRiE0W1yOLuLKH5/hNTkkZ3FLf7nJOppxc9uwtB6GnL
         aCkUjk1qtDppxz0vUtk6qOFenrC3/o4PiEHYqQ8PEiYsG//zWpCHYu65/qi8/d+qWxNM
         JYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490992; x=1715095792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clS/QN9E/f3CIYj6dWbs31v4GElV2ZW9RMM74gwG6WM=;
        b=mqmdbBhWxOPE7cQ9IVkOby6qoh7RFQsOFv2HyJTrJdrMVOqbdMieCQNPVk8p0Ax/+p
         Pv9XWJbBFcE9cndGCvjTop0iF7wNCPwOsXTnWUjEcpl0xWoFp4OKx4DjzFzMTgt4MuEr
         BRN2Ynpq5Rv+qbcN9LO4R6OC+rZniPON1F78KeUroTwfCQYvC/CPpBEqlQVF6eieLweb
         wb2ESUnu44t6z7M9euEwnd2av9Ciim8Qo5tlfcl92wvp/w3hQovXwrx6sRDfvs9fdvRv
         bnx9dUnxQ0P0vRDfkRWp+hOPu+1ZPCOEQCF3OIcaB1QCQUYhKdNyPuIsezz7TcDyPhm2
         aA0w==
X-Forwarded-Encrypted: i=1; AJvYcCVlSkbV/ZSTmN5KkBmG3m40cqb19CHFS0wlQlLwBiUm9NkjQRGd7udFU+R4oQJqJtfI19KC897nPY0+TtV158hqGvsYr3rOi8RwuaPH
X-Gm-Message-State: AOJu0YxuBSO7JLE18ISrUUT83mHhBYuYzYlGb6HQrlcqkVpGTnOa7VEv
	Yvagw7EF6L5H4bsbBJEOSNQ8HLMuYl+O+2MZR4Fk7HQmhaY1bgWXk5im0BndTOQ=
X-Google-Smtp-Source: AGHT+IGfQ5JNalek9HZZ3ibOKrJ4dtXixxHgZ4g+rJgs4EkRdUsgSMPxDzg87sbWnCFbN8mWikNP9g==
X-Received: by 2002:a2e:9c06:0:b0:2df:c395:4482 with SMTP id s6-20020a2e9c06000000b002dfc3954482mr34300lji.32.1714490991730;
        Tue, 30 Apr 2024 08:29:51 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:51 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 06/15] linux/mm.h: move page_address() and others to mm/page_address.h
Date: Tue, 30 Apr 2024 17:29:22 +0200
Message-Id: <20240430152931.1137975-7-max.kellermann@ionos.com>
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
index 84013f24a6a7..0dea734194aa 100644
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
@@ -105,10 +105,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
-#ifndef page_to_virt
-#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
-#endif
-
 #ifndef lm_alias
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
@@ -212,14 +208,6 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
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
 
@@ -2182,44 +2170,6 @@ static inline int arch_make_folio_accessible(struct folio *folio)
  */
 #include <linux/vmstat.h>
 
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
-static __always_inline void *lowmem_page_address(const struct page *page)
-{
-	return page_to_virt(page);
-}
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
@@ -2282,10 +2232,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
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
index 000000000000..630fc4e2be95
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
+static __always_inline void *lowmem_page_address(const struct page *page)
+{
+	return page_to_virt(page);
+}
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


