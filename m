Return-Path: <linux-kernel+bounces-30036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E9831834
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7F81C24B76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFF24A0B;
	Thu, 18 Jan 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrCpw9Aa"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2F241E9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576277; cv=none; b=ItQt6f7qSmpLkerPW8io73LD2zvUb+xOFqwRaxJYAcnsfg+bhn+Z/mxkTfkJitF3N712sTDlZAChABf8WC1VmQznqvv8rJPHk0ZxRrcq9GbUBUBM1TGRf5sdk56dIaBzSFzb7n3EVFRnSHuvh0/NYslJXKPLYAk+TD0F2wUIt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576277; c=relaxed/simple;
	bh=D7RsOP+LIuhOPv0bwLxnFvu5o5GxOXsinfRwhRLItgk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=RPFL/a1vj9zbSaIC+Kn8+yH90ouOZ9JEEqhmP4fF0pG2/cf/WPBV6Wm2aaizru03YP+VsNLO0K1mheGTBPRWvv4zd987l4pkIgpPq/WtxQWhRYPCNDVyiL9WtDPFOt1PductVgjvRvBI+691AK74LMYuCgXLEsNaWd5pPPqK8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrCpw9Aa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso9048771b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576275; x=1706181075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8++HXKXEg2rLAGYvsGKqRlSZ467q1G3QH/l6LoLLoc=;
        b=CrCpw9AaBiMvmamXy2asi1RyF+jhyyrlT3YuH454IOQCZzYBAWm5UTM+MnfqjcaWrv
         r5cxJcxcsJXLVCvK9KIt3DT00g5DYtGYbBjxQ8B9Nk85M8LxNriRO5FQ3+LsD6FSSV0B
         dCTGRqF3FigS8yP+vY6M6kX3QASokF2aa6UZTIWQfL6ke8SylLvpbw0sL2gAxYvaxlgm
         6XwSAZmdOHXqr3pjF0cwGjVAHjNFUpLzDC0VBvRnMwNL804lFdTelQu9+0gBvw0sleRo
         NIN2erPgtVY1UXP7yED4U/8v8YO9BnlTaaqccqBh5Wrk9pZS8vWYXqSUWjzrMxLrSZin
         d+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576275; x=1706181075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8++HXKXEg2rLAGYvsGKqRlSZ467q1G3QH/l6LoLLoc=;
        b=LhJDrIkdP1XrFkzKc7CShjrHbAsFRAPyZtSpSSar02glHEi6C89M6zjoR0sZrgZzsS
         GwL9ylIhPJ1xebnRPlnXuIwUBUP26YezYeYTaX99xkx7UU67uhah3EGYAjTu2o8EC/Mk
         g3B16o7MArvFJtr6deHLKrZPuEq8qPryL/1bw+vWKujYys/CzFRGcyo1z1L26eHBzEBA
         aVmwOC1rStqs5AisSgZ8WEkOmvLu0hviGHbKMKFwwj9Y/NvW7fIoc6/5qDKHkBExzvfO
         E6j6mM1WyVhmT3kwDwTPMejMQeRWuzj3Grh8YaPLs3HJG12ZYQt6b/a+B4xZnnMJed4l
         hSKA==
X-Gm-Message-State: AOJu0YyvSBUC9UxGWlzGo3CO49I82hTnRkG2IRF2hlap5t2xJOoOOz3J
	NU19t1CwaUGWz9F6/1fvnLPCnZ23oZ/BTixASlF1J4d7UGCC8E2k
X-Google-Smtp-Source: AGHT+IES0NLZgAm4unP7Kp0dcWly48U0/DxS1VkSTEJ6A+2jDMT/vDPz11Jhz+G2DyZI1Lcqv4xcYg==
X-Received: by 2002:a05:6a20:7354:b0:19b:90d8:2a11 with SMTP id v20-20020a056a20735400b0019b90d82a11mr617298pzc.69.1705576275572;
        Thu, 18 Jan 2024 03:11:15 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:11:15 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 1/6] arm64: mm: swap: support THP_SWAP on hardware with MTE
Date: Fri, 19 Jan 2024 00:10:31 +1300
Message-Id: <20240118111036.72641-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
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

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/pgtable.h | 21 +++-------------
 arch/arm64/mm/mteswap.c          | 42 ++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h          | 12 ---------
 include/linux/pgtable.h          |  2 +-
 mm/page_io.c                     |  2 +-
 mm/swap_slots.c                  |  2 +-
 6 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 79ce70fbb751..9902395ca426 100644
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
@@ -1042,12 +1036,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #ifdef CONFIG_ARM64_MTE
 
 #define __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
-{
-	if (system_supports_mte())
-		return mte_save_tags(page);
-	return 0;
-}
+#define arch_prepare_to_swap arch_prepare_to_swap
+extern int arch_prepare_to_swap(struct folio *folio);
 
 #define __HAVE_ARCH_SWAP_INVALIDATE
 static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
@@ -1063,11 +1053,8 @@ static inline void arch_swap_invalidate_area(int type)
 }
 
 #define __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
-{
-	if (system_supports_mte())
-		mte_restore_tags(entry, &folio->page);
-}
+#define arch_swap_restore arch_swap_restore
+extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
 
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc5..b9ca1b35902f 100644
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
@@ -83,3 +90,38 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+int arch_prepare_to_swap(struct folio *folio)
+{
+	int err;
+	long i;
+
+	if (system_supports_mte()) {
+		long nr = folio_nr_pages(folio);
+
+		for (i = 0; i < nr; i++) {
+			err = mte_save_tags(folio_page(folio, i));
+			if (err)
+				goto out;
+		}
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
index 5adb86af35fc..67219d2309dd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -530,16 +530,4 @@ static inline int split_folio(struct folio *folio)
 	return split_folio_to_list(folio, NULL);
 }
 
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
index f6d0e3513948..37fe83b0c358 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -925,7 +925,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
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
index 0bec1f705f8e..2325adbb1f19 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	entry.val = 0;
 
 	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
+		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, folio_nr_pages(folio));
 		goto out;
 	}
-- 
2.34.1


