Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4380C11F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjLKGFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKGFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:05:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2585D9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:05:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6d0985c70ffso70854b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702274716; x=1702879516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGD07MUuPwLorMi1Thampb73UmKkI4mD7TFeNxoJQeE=;
        b=J6f5iz0A7MR3x+d00rGrS7URd6TxRU9v0OH+EejvarDcA4YMAe/6A0LxpOlTQQE8ZZ
         lYPGAbbC205UXUHbPkwRYDt6qV87hKMDumnMkdZ9HPu/KyJLS/ES4ULvutmW4l78cIGD
         mTjKfOJySflEHqBIenAEDU4J/h7A2/q0BzmYW9BiyJA91eR4t1CFiMTYWGjpxtR+xalh
         SEuCNtD4/A57WA+SY9QWS0Z+lngDOxzT3ueDgE7ILxSwQyV1I7eId1g+A+R0H/qUZkri
         iARoelBDEz8t5Z23BlAReRKSmb9RTyOYJoLoU4Wydw1rL1byWzrz+B13Kjod/IB20Z4t
         RAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702274716; x=1702879516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGD07MUuPwLorMi1Thampb73UmKkI4mD7TFeNxoJQeE=;
        b=KBlionfeehQgtKFaXHkvEX9Q6mh4Bv6SdL1KiWBFyu9JCLFkAW7Xg+HlLwmjsQ53xR
         QSyqk/VouWanxWknlVOI3p0ZUp9J8ouvc/o9CWifJJ6xX1RYp8Ijz9HYuJeVWrxYRJUA
         K+1L00bJgYHKHkznOt7io+hfiPhirOt0wEBxQhfTTkrPVWqJ34VOKQmtRRIOcL0ZXlxO
         CJeL2RqkrtHTwotuJBOrBqwfR72aoWN3EwnPMxKxzXWykNfQQG0eeq5o5usOmMm24Qoo
         K4plCmyweitYNVYBf+SEKWT2WvBsHveFp+FJUXxtAgA7N2C92qaDE/Y3c13/9Pj/yVKy
         NxAg==
X-Gm-Message-State: AOJu0Yx2obuAN9nlda5AtmFDBYp9MBCRaj8/0aKmSDBCak/5dz5Gc0OU
        n1Sv15I3uQtUlYWGffXxteE=
X-Google-Smtp-Source: AGHT+IERTr+XS2UHiVjo1faJWY4atg8WjIc2MjDS2c8n8zkXx0PiFMdpQwRsqWZsU/4+0DoJvQKYPw==
X-Received: by 2002:a05:6a20:d405:b0:18f:97c:9297 with SMTP id il5-20020a056a20d40500b0018f097c9297mr1385128pzb.124.1702274716032;
        Sun, 10 Dec 2023 22:05:16 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:8c92:9da7:4cb1:51c1])
        by smtp.gmail.com with ESMTPSA id qj12-20020a17090b28cc00b0028672a85808sm6024695pjb.35.2023.12.10.22.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:05:15 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        david@redhat.com, linux-mm@kvack.org, ryan.roberts@arm.com,
        steven.price@arm.com, will@kernel.org, willy@infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com, hanchuanhua@oppo.com
Subject: [PATCH v2] arm64: mm: swap: support THP_SWAP on hardware with MTE
Date:   Mon, 11 Dec 2023 19:04:55 +1300
Message-Id: <20231211060455.101067-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 -v2:
  let arch_swap_restore() still use folio as the parameter with respect
  to the comments of Matthew and David;
 -v1:
  collected reviewed-by from Steven;
  refine commit log;
  https://lore.kernel.org/linux-mm/20231208073401.70153-1-v-songbaohua@oppo.com/
 -rfc v3:
   https://lore.kernel.org/linux-mm/20231114014313.67232-1-v-songbaohua@oppo.com/
 -rfc v2:
   https://lore.kernel.org/lkml/20231104093423.170054-1-v-songbaohua@oppo.com/
 -rfc v1:
   https://lore.kernel.org/lkml/20231102223643.7733-1-v-songbaohua@oppo.com/

 arch/arm64/include/asm/pgtable.h | 21 +++-------------
 arch/arm64/mm/mteswap.c          | 42 ++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h          | 12 ---------
 include/linux/pgtable.h          |  2 +-
 mm/page_io.c                     |  2 +-
 mm/swap_slots.c                  |  2 +-
 6 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b19a8aee684c..d8f523dc41e7 100644
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
@@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
@@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int type)
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
index fa0350b0812a..f83fb8d5241e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -400,16 +400,4 @@ static inline int split_folio(struct folio *folio)
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
index af7639c3b0a3..33ab4ddd91dd 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -897,7 +897,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  * prototypes must be defined in the arch-specific asm/pgtable.h file.
  */
 #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
+static inline int arch_prepare_to_swap(struct folio *folio)
 {
 	return 0;
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index cb559ae324c6..0fd832474c1d 100644
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

