Return-Path: <linux-kernel+bounces-90176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D350186FB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20994B21A43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B03171AF;
	Mon,  4 Mar 2024 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt5iBoBh"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A691756D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540070; cv=none; b=OoUAYIB7Uxe/8p4ZFoL02cl5u5gfNQfTLscxzGIs7LTgpW62U/sAPkuuc32ylvdMi8RryZN0PjLDYXJoiXWt+ggYU4Mvw4/rNbhjtqj4ZDPDMjrBjg821He+irYjH7D7vtQD+6xCUlH9X6+UBW7szmWwnvfloE9Fj8tsODXx3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540070; c=relaxed/simple;
	bh=TthfiCTSHniBg07/g9kff9ziRLL3IKn2kCZUYvskwmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NeLUf9HSCi2hdOKoLW9W0BQdfBfpBK1YbZhHcJP9ooSDemXI7Zmy+2CbOkq8quK00fqkKEXWC2G+335HCMfrMtetyZBCXD738ZNnPRMfqUwQ94smXWvLEFJiMI8RBozOuExJYwUlS5tqKo9T0mDFlrqCGcqNVP3aywrxyNxFyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt5iBoBh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e558a67f70so3659650b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540068; x=1710144868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y59EUmsn936TktKB/aH9UYKKlrxQ0A+jm6Fw0p9O+fA=;
        b=Nt5iBoBhVkZOGXpTIU7AKV1U0/ax2pulTqFUxQn5c1/Gc59xGjn/bfVcq0ZK9RRF06
         jhbesD3fT2PnqSWm62/U6Sjqr3GXhgDSvu6d0BKpJsi1L/UxpGB5NtLYZqriR3KsWscx
         SafRcHqx4aBs9wW4f3V580g+ybc7XNdPYaJY3kXkYLYs3iKQp9un26TwKDgqaUjQrB49
         nluAgQ2kMbph4fVyO4ARD3OeObN7RfkTgTb9SMBKCbFt7daJfSSN75VrZwOnhHjJT41L
         UEWDcvdfN5vV+sHw6C0SdWhuf8/T+bEtzPufl6niC1dVVbul76Rv4HCwX9R2r2a9VAfA
         De+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540068; x=1710144868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y59EUmsn936TktKB/aH9UYKKlrxQ0A+jm6Fw0p9O+fA=;
        b=hLKURDW81yhHmcErRvEv+vq5uL59OP8VMJvUmHKMYl1Dx9RoWuS+WvWTdAq7o2AHhB
         MqDBw7fwIqwrZpKiwHPn6CeXc6IRHq6VBUKPx7NIkZ6Y7uZSAv22BdlrT5Gwzkl055x2
         7qGTfM/1kw7ZMv6py7qGsNkxA/0Ftc91Cv20Ken3MHpdqMqZxqGqdtLDcRnMrrf0Y1R2
         3nVFw3Hb2+onja5nf55pBzLSN0us93iPKa++KAkpWvDUddCVnFEFkuAy6HoZErMyGOtt
         2eTOG9f8ReirkCFnvKZqUCiS8yZW2WszHGLrgriIdlWvbanDbgaI6cideXxQybWb6WOr
         kXSg==
X-Forwarded-Encrypted: i=1; AJvYcCU1IEuKTKH2kdxysfSodM6di+rZfrnninIkGto6vLaqqXc6MESiD6Q0JLiTx4uLeoGNVOOLGktfEp/4D6318lFZpe48c2P+mR3YUe51
X-Gm-Message-State: AOJu0Yz2ZQ7rFXSoB9qo3ECBmmbHn4JtD4GNFXm/EHKF+V/PwyxXJwwj
	RDsKkT4BXaBWIFsQUcjF72H1DvRvjWA6W7PC562uFSBbALwJx15J
X-Google-Smtp-Source: AGHT+IGA7fWsmwmgOxEFHP05B2QC6S7nXvlivm8Kflb15xIyMMY/ZdBjS77UiDjrNdXg/50SGdBWOA==
X-Received: by 2002:a05:6a00:b8f:b0:6e6:13ec:7178 with SMTP id g15-20020a056a000b8f00b006e613ec7178mr2688020pfj.32.1709540067899;
        Mon, 04 Mar 2024 00:14:27 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e558a67374sm6686387pfb.0.2024.03.04.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:14:27 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Barry Song <v-songbaohua@oppo.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Collingbourne <pcc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC PATCH v3 1/5] arm64: mm: swap: support THP_SWAP on hardware with MTE
Date: Mon,  4 Mar 2024 21:13:44 +1300
Message-Id: <20240304081348.197341-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304081348.197341-1-21cnbao@gmail.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
MTE as the MTE code works with the assumption tags save/restore is
always handling a folio with only one page.

The limitation should be removed as more and more ARM64 SoCs have
this feature. Co-existence of MTE and THP_SWAP becomes more and
more important.

This patch makes MTE tags saving support large folios, then we don't
need to split large folios into base pages for swapping out on ARM64
SoCs with MTE any more.

arch_prepare_to_swap() should take folio rather than page as parameter
because we support THP swap-out as a whole. It saves tags for all
pages in a large folio.

As now we are restoring tags based-on folio, in arch_swap_restore(),
we may increase some extra loops and early-exitings while refaulting
a large folio which is still in swapcache in do_swap_page(). In case
a large folio has nr pages, do_swap_page() will only set the PTE of
the particular page which is causing the page fault.
Thus do_swap_page() runs nr times, and each time, arch_swap_restore()
will loop nr times for those subpages in the folio. So right now the
algorithmic complexity becomes O(nr^2).

Once we support mapping large folios in do_swap_page(), extra loops
and early-exitings will decrease while not being completely removed
as a large folio might get partially tagged in corner cases such as,
1. a large folio in swapcache can be partially unmapped, thus, MTE
tags for the unmapped pages will be invalidated;
2. users might use mprotect() to set MTEs on a part of a large folio.

arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
who needed it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 19 ++------------
 arch/arm64/mm/mteswap.c          | 43 ++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h          | 12 ---------
 include/linux/pgtable.h          |  2 +-
 mm/page_io.c                     |  2 +-
 mm/swap_slots.c                  |  2 +-
 6 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 401087e8a43d..7a54750770b8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -45,12 +45,6 @@
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline bool arch_thp_swp_supported(void)
-{
-	return !system_supports_mte();
-}
-#define arch_thp_swp_supported arch_thp_swp_supported
-
 /*
  * Outside of a few very special situations (e.g. hibernation), we always
  * use broadcast TLB invalidation instructions, therefore a spurious page
@@ -1095,12 +1089,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #ifdef CONFIG_ARM64_MTE
 
 #define __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
-{
-	if (system_supports_mte())
-		return mte_save_tags(page);
-	return 0;
-}
+extern int arch_prepare_to_swap(struct folio *folio);
 
 #define __HAVE_ARCH_SWAP_INVALIDATE
 static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
@@ -1116,11 +1105,7 @@ static inline void arch_swap_invalidate_area(int type)
 }
 
 #define __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
-{
-	if (system_supports_mte())
-		mte_restore_tags(entry, &folio->page);
-}
+extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
 
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc5..295836fef620 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	mte_free_tag_storage(tags);
 }
 
+static inline void __mte_invalidate_tags(struct page *page)
+{
+	swp_entry_t entry = page_swap_entry(page);
+
+	mte_invalidate_tags(swp_type(entry), swp_offset(entry));
+}
+
 void mte_invalidate_tags_area(int type)
 {
 	swp_entry_t entry = swp_entry(type, 0);
@@ -83,3 +90,39 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+int arch_prepare_to_swap(struct folio *folio)
+{
+	long i, nr;
+	int err;
+
+	if (!system_supports_mte())
+		return 0;
+
+	nr = folio_nr_pages(folio);
+
+	for (i = 0; i < nr; i++) {
+		err = mte_save_tags(folio_page(folio, i));
+		if (err)
+			goto out;
+	}
+	return 0;
+
+out:
+	while (i--)
+		__mte_invalidate_tags(folio_page(folio, i));
+	return err;
+}
+
+void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+{
+	if (system_supports_mte()) {
+		long i, nr = folio_nr_pages(folio);
+
+		entry.val -= swp_offset(entry) & (nr - 1);
+		for (i = 0; i < nr; i++) {
+			mte_restore_tags(entry, folio_page(folio, i));
+			entry.val++;
+		}
+	}
+}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..e04b93c43965 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -535,16 +535,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 #define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
 #define split_folio(f) split_folio_to_order(f, 0)
 
-/*
- * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
- * limitations in the implementation like arm64 MTE can override this to
- * false
- */
-#ifndef arch_thp_swp_supported
-static inline bool arch_thp_swp_supported(void)
-{
-	return true;
-}
-#endif
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e1b22903f709..bfcfe3386934 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1106,7 +1106,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  * prototypes must be defined in the arch-specific asm/pgtable.h file.
  */
 #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
+static inline int arch_prepare_to_swap(struct folio *folio)
 {
 	return 0;
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index ae2b49055e43..a9a7c236aecc 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	 * Arch code may have to preserve more data than just the page
 	 * contents, e.g. memory tags.
 	 */
-	ret = arch_prepare_to_swap(&folio->page);
+	ret = arch_prepare_to_swap(folio);
 	if (ret) {
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 90973ce7881d..53abeaf1371d 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -310,7 +310,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	entry.val = 0;
 
 	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
+		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, folio_nr_pages(folio));
 		goto out;
 	}
-- 
2.34.1


