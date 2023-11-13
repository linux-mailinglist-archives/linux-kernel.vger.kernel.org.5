Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3237E9A90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMKxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:52:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDD10D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:52:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dae71322ed4so5177375276.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 02:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699872765; x=1700477565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy+PlU+FeLCVAtPuXK15UDcGql8UQVRw/kwgKDnnM+M=;
        b=jcXleIbKF8S2B4SR0ReqNqFTWLAyAr6Vp+FcbJIZPwfNWTEP9W19erEHYA5h9hVE4j
         07N9i77xyKYsEB/sIJYsii5BSb+aHV8eJlr8ZW0HvxI73J4id7q40mkP9e60FHdkWPfd
         PVXJbo2J1PJcPcgZWhWdMENyL8g00IhFENV+o0PvMihBJVrA4W1LwVLM51YdeZ6hh9zA
         LypJHGaP139EFoL9cNvsS9r8Zv4u891zjw7L3ETaFAKRRNAE7x7EUCctn3N8ik4ZIUm8
         vyMts8MvZYMTu0Ah0W42ux4A9F03kSCPtLRgAN14dmWnEAjwMO1brWNMRKOg8uBeQ6I9
         CoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699872765; x=1700477565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy+PlU+FeLCVAtPuXK15UDcGql8UQVRw/kwgKDnnM+M=;
        b=ZoHnvk9/QgJ83Hi447/et47lZYoYGWSOOqemz30bE582gJsIPaaB1bOtfQ4coWU6Ug
         F3KFJQMCP4aaR7SDNnK4vN0XJwzVZEkS1193VoGuNmz7lJ24QwJe98jd9tRoqtSkCkDb
         epV71J2i4O9CRSV5eYn1XoA9jzBJa6dxeSRhlnpwwS8g+iDSqG7ogPRKwDrg0lTVb1/g
         hU1jrYvOZGfdMRm+bfLIV5sIjk8QE6jldYe+Y3q5//0j6QrsKNyU/w/Jvf9WsMFTjwJG
         woy6iQ+1H80EWW/ZsrhkFyYTwgoQ6w7GsXxp5R5xTnTtHvmvXDorqNFkH+JZdhXimpwb
         z0Vg==
X-Gm-Message-State: AOJu0YzNX09Ie7PpbCs1zVJj1aa5iMfii9DgM5NIDq4TT2KGrz7eRqDg
        p5oW4dOPE1F0C/yfSOz1S01gyWdghxY=
X-Google-Smtp-Source: AGHT+IFLuy6XbSpowZCF3T+unY7tPEBO3ftsXlC/iyHTJOsjJEV+/QFJRcCNxIkokehBcYabk9sODgBoEwM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:be07:845d:4221:b15e])
 (user=glider job=sendgmr) by 2002:a25:2e4b:0:b0:dae:e8dc:c026 with SMTP id
 b11-20020a252e4b000000b00daee8dcc026mr153989ybn.13.1699872765517; Mon, 13 Nov
 2023 02:52:45 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:52:32 +0100
In-Reply-To: <20231113105234.32058-1-glider@google.com>
Mime-Version: 1.0
References: <20231113105234.32058-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231113105234.32058-4-glider@google.com>
Subject: [PATCH v9 3/4] arm64: mte: add compression support to mteswap.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mteswap.c to perform inline compression of memory tags when
possible.

If CONFIG_ARM64_MTE_COMP is enabled, mteswap.c will attempt to compress
saved tags for a struct page and store them directly in Xarray entry
instead of wasting heap space.

Soon after booting Android, tag compression saves ~2x memory previously
spent by mteswap.c on tag allocations. On a moderately loaded device with
~20% tagged pages, this leads to saving several megabytes of kernel heap:

  # cat /sys/kernel/debug/mteswap/stats
  8 bytes:	102496 allocations,	67302 deallocations
  128 bytes:	212234 allocations,	178278 deallocations
  uncompressed tag storage size:	8851200
  compressed tag storage size:	4346368

(statistics collection is introduced in the following patch)

Signed-off-by: Alexander Potapenko <glider@google.com>

---
 v9:
  - as requested by Yury Norov, split off statistics collection into a
    separate patch
  - minor fixes

 v8:
  - adapt to the new compression API, abandon mteswap_{no,}comp.c
  - move stats collection to mteswap.c

 v5:
  - drop a dead variable from _mte_free_saved_tags() in mteswap_comp.c
  - ensure MTE compression works with arbitrary page sizes
  - update patch description

 v4:
  - minor code simplifications suggested by Andy Shevchenko, added
    missing header dependencies
  - changed compression API names to reflect modifications made to
    memcomp.h (as suggested by Yury Norov)

 v3:
  - Addressed comments by Andy Shevchenko in another patch:
   - fixed includes order
   - replaced u64 with unsigned long
   - added MODULE_IMPORT_NS(MTECOMP)
---
 arch/arm64/mm/mteswap.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc54..70f5c8ecd640d 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -6,6 +6,8 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm/mte.h>
+#include <asm/mtecomp.h>
+#include "mtecomp.h"
 
 static DEFINE_XARRAY(mte_pages);
 
@@ -17,12 +19,13 @@ void *mte_allocate_tag_storage(void)
 
 void mte_free_tag_storage(char *storage)
 {
-	kfree(storage);
+	if (!mte_is_compressed(storage))
+		kfree(storage);
 }
 
 int mte_save_tags(struct page *page)
 {
-	void *tag_storage, *ret;
+	void *tag_storage, *compressed_storage, *ret;
 
 	if (!page_mte_tagged(page))
 		return 0;
@@ -32,6 +35,11 @@ int mte_save_tags(struct page *page)
 		return -ENOMEM;
 
 	mte_save_page_tags(page_address(page), tag_storage);
+	compressed_storage = mte_compress(tag_storage);
+	if (compressed_storage) {
+		mte_free_tag_storage(tag_storage);
+		tag_storage = compressed_storage;
+	}
 
 	/* lookup the swap entry.val from the page */
 	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
@@ -50,13 +58,20 @@ int mte_save_tags(struct page *page)
 void mte_restore_tags(swp_entry_t entry, struct page *page)
 {
 	void *tags = xa_load(&mte_pages, entry.val);
+	void *tag_storage = NULL;
 
 	if (!tags)
 		return;
 
 	if (try_page_mte_tagging(page)) {
+		if (mte_is_compressed(tags)) {
+			tag_storage = mte_allocate_tag_storage();
+			mte_decompress(tags, tag_storage);
+			tags = tag_storage;
+		}
 		mte_restore_page_tags(page_address(page), tags);
 		set_page_mte_tagged(page);
+		mte_free_tag_storage(tag_storage);
 	}
 }
 
-- 
2.42.0.869.gea05f2083d-goog

