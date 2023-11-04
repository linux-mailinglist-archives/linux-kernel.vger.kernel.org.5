Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC27E0E9C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjKDJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:34:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82BB8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:34:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc53d0030fso23255835ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699090486; x=1699695286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icJ3Mt5/Nx1r7ZncTMoFpmmeg/c+qsH4/CaRkuODCmo=;
        b=HbGdU5fmdikKiE+9mYRR84n1sKW8EHMoBwC/56n6mqmJZvwdPzDjWlrs9JrRTK0QBH
         YX3kAjyVIMzQtEUQTjBLUh2BDJQ8ajsyJl8/h2P394/ZWoz1w2U6wQCxLcU22VZeFl0X
         Fu0orhz3fG4DKN7PybvirA1cOaX+0Ys/FjOE5vntL58V2iDwCpIvyqmdCwljVGa9tdyg
         kygeIEf6Yl04jfFA5HFUhG6Wu2ccMhVJU0g5TutEF+PqvnOiaQSJ/ESAF6FaB+nYGc5M
         MvkhB+kSi4FRoyrchhoci+uIp7DT9Ud6MVMdebvBBDEqDO3GJS3Y+EzftbEsjvTe4T4B
         zokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699090486; x=1699695286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icJ3Mt5/Nx1r7ZncTMoFpmmeg/c+qsH4/CaRkuODCmo=;
        b=r7g/xWaarBqOJqNJ1mRZodBHXP7mrirUccUkNvane3QPzmSPM19r/wLA5nAZTDCTIz
         bVTfm3cp60qKlJjOhXewGBKNCYArPimdCMyUWIAJoEGI2V22XTHQclSu5EsIIr8h3Uz7
         tTl7Doys6+Zlaiu+oprJMjKQdQeFpF//5P78QvAN+OKi0Ctzj87A9wlZxsOB2W0RsV2I
         sPIqNCnh25eY+fioF78v1eC/ryKjlf+CFl5zhzrh6QnUT40wYb9KBj+fsvEujivGwubJ
         IhJVTQ3UkeqZ5C703p+Y2+eVuO63JPt/T8cTbq6h+c/15z0p/wkLxndY4pTdJA5H1+Tt
         GORA==
X-Gm-Message-State: AOJu0YxgI53M8fEQDl6q4faEOaFSnewBO6jBZflNHSN1Numh1PQOG+aS
        eSNyDTfSgckFiAJGpQ3Cq1I=
X-Google-Smtp-Source: AGHT+IHSzQ3SoJiZIP1nObIIp+msUa6REITGDRfHjTzCmcCIm3fLwnAa6H143q4n2dXduEJo3RT+ow==
X-Received: by 2002:a17:902:c412:b0:1cc:5ce4:f64b with SMTP id k18-20020a170902c41200b001cc5ce4f64bmr7443649plk.8.1699090486350;
        Sat, 04 Nov 2023 02:34:46 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:4e57:64bd:534a:1d8d])
        by smtp.gmail.com with ESMTPSA id g17-20020a170902869100b001c9d011581dsm1098906plo.164.2023.11.04.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:34:45 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     steven.price@arm.com
Cc:     21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com,
        Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
Date:   Sat,  4 Nov 2023 22:34:23 +1300
Message-Id: <20231104093423.170054-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com>
References: <2fe5ce7e-9c5c-4df4-b4fc-9fd3d9b2dccb@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes that's right. mte_save_tags() needs to allocate memory so can fail
> and if failing then arch_prepare_to_swap() would need to put things back
> how they were with calls to mte_invalidate_tags() (although I think
> you'd actually want to refactor to create a function which takes a
> struct page *).
> 
> Steve

Thanks, Steve. combining all comments from You and Ryan, I made a v2.
One tricky thing is that we are restoring one page rather than folio
in arch_restore_swap() as we are only swapping in one page at this
stage.

[RFC v2 PATCH] arm64: mm: swap: save and restore mte tags for large folios

This patch makes MTE tags saving and restoring support large folios,
then we don't need to split them into base pages for swapping on
ARM64 SoCs with MTE.

This patch moves arch_prepare_to_swap() to take folio rather than
page, as we support THP swap-out as a whole. And this patch also
drops arch_thp_swp_supported() as ARM64 MTE is the only one who
needs it.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/pgtable.h | 21 +++------------
 arch/arm64/mm/mteswap.c          | 44 ++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h          | 12 ---------
 include/linux/pgtable.h          |  2 +-
 mm/page_io.c                     |  2 +-
 mm/swap_slots.c                  |  2 +-
 6 files changed, 51 insertions(+), 32 deletions(-)

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
index a31833e3ddc5..14a479e4ea8e 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -68,6 +68,12 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	mte_free_tag_storage(tags);
 }
 
+static inline void __mte_invalidate_tags(struct page *page)
+{
+	swp_entry_t entry = page_swap_entry(page);
+	mte_invalidate_tags(swp_type(entry), swp_offset(entry));
+}
+
 void mte_invalidate_tags_area(int type)
 {
 	swp_entry_t entry = swp_entry(type, 0);
@@ -83,3 +89,41 @@ void mte_invalidate_tags_area(int type)
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
+		for (i = 0; i < nr; i++) {
+			err = mte_save_tags(folio_page(folio, i));
+			if (err)
+				goto out;
+		}
+	}
+	return 0;
+
+out:
+	while (--i)
+		__mte_invalidate_tags(folio_page(folio, i));
+	return err;
+}
+
+void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+{
+	if (system_supports_mte()) {
+		/*
+		 * We don't support large folios swap in as whole yet, but
+		 * we can hit a large folio which is still in swapcache
+		 * after those related processes' PTEs have been unmapped
+		 * but before the swapcache folio  is dropped, in this case,
+		 * we need to find the exact page which "entry" is mapping
+		 * to. If we are not hitting swapcache, this folio won't be
+		 * large
+		 */
+		struct page *page = folio_file_page(folio, swp_offset(entry));
+		mte_restore_tags(entry, page);
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

