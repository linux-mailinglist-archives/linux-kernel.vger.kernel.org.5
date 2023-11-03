Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF37E0627
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbjKCQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbjKCQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:03:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB07DD75
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:03:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so2677694276.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027428; x=1699632228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kakEavv2Bx4kC7ui8vSjgo++eh6M+uQZM7WF3AfKH1U=;
        b=KHTIeOviOjzGd7htZ/U2VaxaMZg5B6gkjXM8170aY89bNhBhPON1wB1PEHELMqFBGt
         0YiCXjcxQ8nI2qtejl/VIjHGPZdL+2Nv55TtEeJuO7e9DMTvWlGWsMVSIHtjOz9Y22XT
         PSLVKcUHD0ajFFGS8mLQVRpWUkmcW9JI/eyasWtHuMvCqlSzw3pN15jjeO4EK9Bhd9Jd
         TV0S+I/o7RdCo4XdPxvTrShUmr7XGC+Hsws6Un1M1A3t2rJHD6nR0R+BwJK0X0C5dxBu
         dZzRqtrrXVGB0/J4tZPncMz70WlhVAuf0Oo04XwdEqPe+4e9MycU8jKbw1pawRpry7pI
         bArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027428; x=1699632228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kakEavv2Bx4kC7ui8vSjgo++eh6M+uQZM7WF3AfKH1U=;
        b=X+hq87MjL7w0u3kM/MZCwoeLSP9X781aBUwC+OEMffxCBtUGTmqPpHJuqnNlFBwCBN
         44O+Yg6IXxHKFmXmuJXcbJI4cF94NNuJzMhGt7xz3T6UOV8BldDgpbuDtH69MEdOupbW
         /7LMqts1ChsZ+aYy+LROmAkovdhwkar/Bw1PY9LpshHSKu/B4dDSDsvHqWMtsT4H2pNQ
         i/Xta7xqFg/skApLTH/OI9b1m2ieOk8S29kh6OIBE8Gkr0wO+RVJ0gH0Eh3+L0Vf9ldP
         YOatdW5IuSI1N0J0+lO4RBTqP7wZSD1aNrrDo2L8MxZ+TzicmL97n1TttWMxbn1C55bZ
         dK9g==
X-Gm-Message-State: AOJu0YxzScH0b3jjdGmzNoKyrQXbSSjtPPd51QxGCV8t0qbGf2WHqjGK
        iTrwqvh4dJFIftax7kCbDmyJRL7gH74=
X-Google-Smtp-Source: AGHT+IHR9RZ3AGRYHVoGIfBerEYYQF7lrQOl7qGnkNHzxbQ4hBmSQ407bgV+B4b0VM3Hx1nwqixE0RPesMI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:74c:1f8e:4661:7aaa])
 (user=glider job=sendgmr) by 2002:a25:770f:0:b0:da0:73c2:db78 with SMTP id
 s15-20020a25770f000000b00da073c2db78mr452259ybc.9.1699027428174; Fri, 03 Nov
 2023 09:03:48 -0700 (PDT)
Date:   Fri,  3 Nov 2023 17:03:35 +0100
In-Reply-To: <20231103160335.2464561-1-glider@google.com>
Mime-Version: 1.0
References: <20231103160335.2464561-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103160335.2464561-4-glider@google.com>
Subject: [PATCH v8 3/3] arm64: mte: add compression support to mteswap.c
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

If CONFIG_ARM64_MTE_COMP is enabled, mteswap.c will attemt to compress
saved tags for a struct page and store them directly in Xarray entry
instead of wasting heap space.

Soon after booting Android, tag compression saves ~2x memory previously
spent by mteswap.c on tag allocations. On a moderately loaded device with
~20% tagged pages, this leads to saving several megabytes of kernel heap:

  # cat /sys/kernel/debug/mteswap/stats
  8 bytes: 102496 allocations, 67302 deallocations
  128 bytes: 212234 allocations, 178278 deallocations
  uncompressed tag storage size: 8851200
  compressed tag storage size: 4346368

Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 arch/arm64/mm/mteswap.c | 88 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc54..0f558942d88b8 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -1,28 +1,48 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/debugfs.h>
 #include <linux/pagemap.h>
 #include <linux/xarray.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm/mte.h>
+#include <asm/mtecomp.h>
+#include "mtecomp.h"
+
+enum mteswap_counters {
+	MTESWAP_CTR_INLINE = 0,
+	MTESWAP_CTR_NOINLINE,
+	MTESWAP_CTR_SIZE
+};
+static atomic_long_t alloc_counters[MTESWAP_CTR_SIZE];
+static atomic_long_t dealloc_counters[MTESWAP_CTR_SIZE];
 
 static DEFINE_XARRAY(mte_pages);
 
 void *mte_allocate_tag_storage(void)
 {
-	/* tags granule is 16 bytes, 2 tags stored per byte */
-	return kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	void *ret;
+
+	ret = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	if (ret)
+		atomic_long_inc(&alloc_counters[MTESWAP_CTR_NOINLINE]);
+	return ret;
 }
 
 void mte_free_tag_storage(char *storage)
 {
-	kfree(storage);
+	if (!mte_is_compressed(storage)) {
+		kfree(storage);
+		atomic_long_dec(&alloc_counters[MTESWAP_CTR_NOINLINE]);
+	} else {
+		atomic_long_dec(&alloc_counters[MTESWAP_CTR_INLINE]);
+	}
 }
 
 int mte_save_tags(struct page *page)
 {
-	void *tag_storage, *ret;
+	void *tag_storage, *ret, *compressed;
 
 	if (!page_mte_tagged(page))
 		return 0;
@@ -32,6 +52,12 @@ int mte_save_tags(struct page *page)
 		return -ENOMEM;
 
 	mte_save_page_tags(page_address(page), tag_storage);
+	compressed = mte_compress(tag_storage);
+	if (compressed) {
+		mte_free_tag_storage(tag_storage);
+		tag_storage = (void *)compressed;
+		atomic_long_inc(&alloc_counters[MTESWAP_CTR_INLINE]);
+	}
 
 	/* lookup the swap entry.val from the page */
 	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
@@ -50,13 +76,20 @@ int mte_save_tags(struct page *page)
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
 
@@ -83,3 +116,50 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+/* DebugFS interface. */
+static int stats_show(struct seq_file *seq, void *v)
+{
+	unsigned long total_mem_alloc = 0, total_mem_dealloc = 0;
+	unsigned long total_num_alloc = 0, total_num_dealloc = 0;
+	unsigned long sizes[2] = { 8, MTE_PAGE_TAG_STORAGE };
+	long alloc, dealloc;
+	unsigned long size;
+	int i;
+
+	for (i = 0; i < MTESWAP_CTR_SIZE; i++) {
+		alloc = atomic_long_read(&alloc_counters[i]);
+		dealloc = atomic_long_read(&dealloc_counters[i]);
+		total_num_alloc += alloc;
+		total_num_dealloc += dealloc;
+		size = sizes[i];
+		/*
+		 * Do not count 8-byte buffers towards compressed tag storage
+		 * size.
+		 */
+		if (i) {
+			total_mem_alloc += (size * alloc);
+			total_mem_dealloc += (size * dealloc);
+		}
+		seq_printf(seq,
+			   "%lu bytes: %lu allocations, %lu deallocations\n",
+			   size, alloc, dealloc);
+	}
+	seq_printf(seq, "uncompressed tag storage size: %lu\n",
+		   (total_num_alloc - total_num_dealloc) *
+			   MTE_PAGE_TAG_STORAGE);
+	seq_printf(seq, "compressed tag storage size: %lu\n",
+		   total_mem_alloc - total_mem_dealloc);
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stats);
+
+static int mteswap_init(void)
+{
+	struct dentry *mteswap_dir;
+
+	mteswap_dir = debugfs_create_dir("mteswap", NULL);
+	debugfs_create_file("stats", 0444, mteswap_dir, NULL, &stats_fops);
+	return 0;
+}
+module_init(mteswap_init);
-- 
2.42.0.869.gea05f2083d-goog

