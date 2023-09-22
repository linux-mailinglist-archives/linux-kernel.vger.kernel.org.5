Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBD7AABFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjIVIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjIVIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:09:14 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C014CF2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:07 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-32310ab48f2so31646f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695370146; x=1695974946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdOlGrvM1GssuaeVLKYkN4jxEWq2ZAaVfQMqqTCAZPM=;
        b=RZo0FCRIZTd/3al/hMY9fxzicTRqiqXtu+oK102HDjPrExohurwql/+LxK7Ttsle+W
         OghIEwVLx/by/QsXzE2tSuaiLkwScX+MjNh0MTQThx/gzDKZnDWZV4/a1XzGm2jzrVB1
         btGJJMmzVPO3INXUiPfWsuztb1gfdk0tvgJFnEqNJxBsTjoPAbGfnQ6mCW8+B70RCgga
         Ud6KWq/NOCSNpD2fP30gTl2nMoD+kvOnsfJl02Zln56rTh+N91OFUdrz/CT4L52f8m3X
         bOHWVfCLNVY0OrdgUHC+IOJlC8XlroVSMvwaxEBvpc/dcTIY5zEd6uU6T7VW4diuj7O9
         JskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370146; x=1695974946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdOlGrvM1GssuaeVLKYkN4jxEWq2ZAaVfQMqqTCAZPM=;
        b=W77AMfTO6UQS77+cCuNCNolMuBnWVtzPA1EgHoZuMWwd4JPYRaNApvTkeaXfKQRQgJ
         g6c16GTZU6hNyqZhSudXfrZ2S4pGX3L9GoGDuuBrNhSLyQ/fE8i00aVMZcdmyf85GgOX
         qrTbKEVFw9omANXo7Ue2HA+KjxxIdjDIaEruI8czcQfbK2d5IGOM8Cnc7+Uz+u61Pc0f
         MTpmgt/wrRP/b4h0+xyGTarilheh3wB6/j/JIRwKT4o/MucOHxriTVWhnCZmJhKUtUYy
         35rmaTI2ugX5SfdUIYd6jcXI5WwnAK54s/fHxyTbwpSbUXhKTCLwXO44Gv18BIAEiwM6
         r30A==
X-Gm-Message-State: AOJu0Yz+lkuJPDtAdWpBfIVy4reNA6H3xJ2TxENRLDfV4tcz0fuTSdgO
        6kujsBlKsBLzO6SbOiTGH02KRCNfpjg=
X-Google-Smtp-Source: AGHT+IE+nW7ASJtm/+wQMoVCCIcKoTkCNXlHmnLH/HgUhspmGVTplG+rUAms+XGq1XHU6V5+KOuymZ4XPfk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4da0:80d4:9480:7d5c])
 (user=glider job=sendgmr) by 2002:a5d:43ce:0:b0:317:f046:25e6 with SMTP id
 v14-20020a5d43ce000000b00317f04625e6mr48761wrr.2.1695370145494; Fri, 22 Sep
 2023 01:09:05 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:08:47 +0200
In-Reply-To: <20230922080848.1261487-1-glider@google.com>
Mime-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922080848.1261487-6-glider@google.com>
Subject: [PATCH v5 5/5] arm64: mte: add compression support to mteswap.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the internal mteswap.h interface:
 - _mte_alloc_and_save_tags()
 - _mte_free_saved_tags()
 - _mte_restore_tags()

, that encapsulates saving tags for a struct page (together with memory
allocation), restoring tags, and deleting the storage allocated for them.

These functions accept opaque pointers, which may point to tag buffers
of size MTE_PAGE_TAG_STORAGE, as well as smaller buffers containing
compressed tags, or may have compressed tags stored directly in the
pointers.

The existing code from mteswap.c operating with uncompressed tags is split
away into mteswap_nocomp.c, and the newly introduced mteswap_comp.c
provides compression support. The latter implementation
is picked if CONFIG_ARM64_MTE_COMP=y.

Soon after booting Android, tag compression saves ~2.5x memory previously
spent by mteswap.c on tag allocations. With the growing uptime, the
savings may reach 4x and even more. On a moderately loaded device with
~20% pages using tagging, the compressed tags for swapped pages only
occupied 2.9Mb instead of 16.5Mb:

  8 bytes: 118277 allocations, 16089 deallocations
  16 bytes: 10762 allocations, 6738 deallocations
  32 bytes: 10748 allocations, 6823 deallocations
  64 bytes: 10510 allocations, 6644 deallocations
  128 bytes: 68375 allocations, 47378 deallocations
  uncompressed tag storage size: 17280000
  compressed tag storage size: 3125024

Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 arch/arm64/mm/Makefile         |  5 +++
 arch/arm64/mm/mteswap.c        | 20 +++++-------
 arch/arm64/mm/mteswap.h        | 12 +++++++
 arch/arm64/mm/mteswap_comp.c   | 60 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap_nocomp.c | 38 +++++++++++++++++++++
 5 files changed, 124 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 170dc62b010b9..46a798e2b67cb 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -11,6 +11,11 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 obj-$(CONFIG_ARM64_MTE_COMP)	+= mtecomp.o
+ifdef CONFIG_ARM64_MTE_COMP
+obj-$(CONFIG_ARM64_MTE)		+= mteswap_comp.o
+else
+obj-$(CONFIG_ARM64_MTE)		+= mteswap_nocomp.o
+endif
 obj-$(CONFIG_ARM64_MTE_COMP_KUNIT_TEST) += test_mtecomp.o
 KASAN_SANITIZE_physaddr.o	+= n
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index cd508ba80ab1b..9d8f87fd191a2 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -5,8 +5,11 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+
 #include <asm/mte.h>
 
+#include "mteswap.h"
+
 static DEFINE_XARRAY(mte_pages);
 
 void *mte_allocate_tag_storage(void)
@@ -27,20 +30,18 @@ int mte_save_tags(struct page *page)
 	if (!page_mte_tagged(page))
 		return 0;
 
-	tag_storage = mte_allocate_tag_storage();
+	tag_storage = _mte_alloc_and_save_tags(page);
 	if (!tag_storage)
 		return -ENOMEM;
 
-	mte_save_page_tags(page_address(page), tag_storage);
-
 	/* page_private contains the swap entry.val set in do_swap_page */
 	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
 	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
-		mte_free_tag_storage(tag_storage);
+		_mte_free_saved_tags(tag_storage);
 		return xa_err(ret);
 	} else if (ret) {
 		/* Entry is being replaced, free the old entry */
-		mte_free_tag_storage(ret);
+		_mte_free_saved_tags(ret);
 	}
 
 	return 0;
@@ -53,10 +54,7 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
-	if (try_page_mte_tagging(page)) {
-		mte_restore_page_tags(page_address(page), tags);
-		set_page_mte_tagged(page);
-	}
+	_mte_restore_tags(tags, page);
 }
 
 void mte_invalidate_tags(int type, pgoff_t offset)
@@ -64,7 +62,7 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	swp_entry_t entry = swp_entry(type, offset);
 	void *tags = xa_erase(&mte_pages, entry.val);
 
-	mte_free_tag_storage(tags);
+	_mte_free_saved_tags(tags);
 }
 
 void mte_invalidate_tags_area(int type)
@@ -78,7 +76,7 @@ void mte_invalidate_tags_area(int type)
 	xa_lock(&mte_pages);
 	xas_for_each(&xa_state, tags, last_entry.val - 1) {
 		__xa_erase(&mte_pages, xa_state.xa_index);
-		mte_free_tag_storage(tags);
+		_mte_free_saved_tags(tags);
 	}
 	xa_unlock(&mte_pages);
 }
diff --git a/arch/arm64/mm/mteswap.h b/arch/arm64/mm/mteswap.h
new file mode 100644
index 0000000000000..4c576b76785d1
--- /dev/null
+++ b/arch/arm64/mm/mteswap.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_ARM64_MM_MTESWAP_H_
+#define ARCH_ARM64_MM_MTESWAP_H_
+
+struct page;
+
+void *_mte_alloc_and_save_tags(struct page *page);
+void _mte_free_saved_tags(void *tags);
+void _mte_restore_tags(void *tags, struct page *page);
+
+#endif // ARCH_ARM64_MM_MTESWAP_H_
diff --git a/arch/arm64/mm/mteswap_comp.c b/arch/arm64/mm/mteswap_comp.c
new file mode 100644
index 0000000000000..4c628405822ce
--- /dev/null
+++ b/arch/arm64/mm/mteswap_comp.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management with compression. */
+
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/xarray.h>
+
+#include <asm/mte.h>
+#include <asm/mtecomp.h>
+
+#include "mteswap.h"
+
+void *_mte_alloc_and_save_tags(struct page *page)
+{
+	unsigned long handle;
+	u8 *tags;
+
+	tags = mte_allocate_tag_storage();
+	if (!tags)
+		return xa_mk_value(0);
+	mte_save_page_tags(page_address(page), tags);
+	handle = mte_compress(tags);
+	mte_free_tag_storage(tags);
+	return xa_mk_value(handle);
+}
+
+void _mte_free_saved_tags(void *storage)
+{
+	unsigned long handle;
+
+	handle = xa_to_value(storage);
+	if (!handle)
+		return;
+	mte_release_handle(handle);
+}
+
+void _mte_restore_tags(void *tags, struct page *page)
+{
+	unsigned long handle;
+	u8 *tags_decomp;
+
+	handle = xa_to_value(tags);
+	if (!handle)
+		return;
+	if (!try_page_mte_tagging(page))
+		return;
+	tags_decomp = mte_allocate_tag_storage();
+	if (!tags_decomp)
+		return;
+	if (!mte_decompress(handle, tags_decomp))
+		return;
+	mte_restore_page_tags(page_address(page), tags_decomp);
+	set_page_mte_tagged(page);
+	mte_free_tag_storage(tags_decomp);
+}
+MODULE_IMPORT_NS(MTECOMP);
diff --git a/arch/arm64/mm/mteswap_nocomp.c b/arch/arm64/mm/mteswap_nocomp.c
new file mode 100644
index 0000000000000..1e665a4b5f940
--- /dev/null
+++ b/arch/arm64/mm/mteswap_nocomp.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management without compression support. */
+
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/xarray.h>
+
+#include <asm/mte.h>
+
+#include "mteswap.h"
+
+void *_mte_alloc_and_save_tags(struct page *page)
+{
+	void *storage;
+
+	storage = mte_allocate_tag_storage();
+	if (!storage)
+		return NULL;
+
+	mte_save_page_tags(page_address(page), storage);
+	return storage;
+}
+
+void _mte_free_saved_tags(void *storage)
+{
+	mte_free_tag_storage(storage);
+}
+
+void _mte_restore_tags(void *tags, struct page *page)
+{
+	if (!try_page_mte_tagging(page))
+		return;
+	mte_restore_page_tags(page_address(page), tags);
+	set_page_mte_tagged(page);
+}
-- 
2.42.0.515.g380fc7ccd1-goog

