Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B1812E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443948AbjLNLHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443986AbjLNLHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:07:15 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761001B5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:07:03 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf61210e3so89343197b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702552022; x=1703156822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qETeNVW4T3lC++QM3orD9LTmmtp3iyUET5aUKhJnmac=;
        b=ojei8kpbI+wY1OznPPHL2kaANXhM6JnJeL8IVtH12058RZvTm/bD64zV5wnDJLp/Qa
         A9eJcQZgHE+ilUO+CXFqSAvIgL1UPf5gRR3sWomh2OxBDma74AvUVUUnaauR6F7M4k3c
         HPI1CwiTW8sDyIX3WImfL2kv2cs+boLr/BXh798bIaWMSwXiVjwiqeu+0nqKF+JmNr84
         UYL5WZ7GKN2jO5g/pkmeNv3rER3pFo0+7/o7Xc8gDnTXLjrceDiGO51zYES0Eaj82fxS
         nt/tOp1O5tRJydnuwiMtmvNtQvIyn6M4iu/TIDbwBirGdXl5i9THAt9L9bLI8LNQXEnn
         pgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552022; x=1703156822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qETeNVW4T3lC++QM3orD9LTmmtp3iyUET5aUKhJnmac=;
        b=aIPhjAMZazVUJRQRCsRVSY5aqn4GiRrmQONGthkJk+qpZ7Yq6j1wbIhacl5wfjuoyw
         Hu8qzf8a0nD056WP9NsQUdmsgxTP+bVO+h9nKdUCJln4gJR3No8DLhAEbymZQEQIfROL
         rMtD6mkl7W1/5xp+4VNqXjo0N1144xfiSDOVXcqSqD2KGbDIs4zZgxSwKXo2f7yZ55bg
         uu5ElxnViq+lwsqSjF6AhxUDVYGFPPh9in6xzTUp0n3dM3F+SaAFZIxeyqdq/2A9Ounl
         5FhZWFngvgQLGi2cOS2mC0lSAdqvoE9QwVpaOICtQjAu+WZ1xsklfamAOn2fPI9aX+Eu
         zo4Q==
X-Gm-Message-State: AOJu0Yz5ERAcWU+0YLnuy9EdRSMNo3REiua95y3ASPXbYmfZrIYayAUG
        GRxHqlN1VANhtmuSfwDRhSiBbb7crzE=
X-Google-Smtp-Source: AGHT+IHFo4Qd+bUyHXV7uDnWTfmpROKcqEvV1HIH+ht9/jDqhLREekiPTUW/I5ttnI06QXPQH14EnN1Qqvg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8447:3e89:1f77:ff8a])
 (user=glider job=sendgmr) by 2002:a05:690c:a81:b0:5df:4a9b:fb6c with SMTP id
 ci1-20020a05690c0a8100b005df4a9bfb6cmr109550ywb.3.1702552022462; Thu, 14 Dec
 2023 03:07:02 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:06:38 +0100
In-Reply-To: <20231214110639.2294687-1-glider@google.com>
Mime-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214110639.2294687-7-glider@google.com>
Subject: [PATCH v10-mte 6/7] arm64: mte: add compression support to mteswap.c
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

---
 v10-mte:
  - added Catalin's Reviewed-by:

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
2.43.0.472.g3155946c3a-goog

