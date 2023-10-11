Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47E7C5A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjJKR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJKR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:28:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED9DB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:28:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3942461aso59194276.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697045335; x=1697650135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7RMHUs9H0O3cA2fZ8f5lqqKqpIUIAX5ATbtOOlP10Y=;
        b=3s4lZTcni2b23iadAKhGiTXFSqgHhRkdKJNimSnEbOss/35P8VqqWUDGCgL8lNXv1+
         lDJ9frBLVDKI77SkeEeb0x6ny5KfDG15Wpbw0U34xXjEpMTskTxV90k+t/Xv87n3rhXF
         CimPTOOp/NiKXpVZlUO2dZ5zDEOB1XL+Zf/PTDXZ2fJTrM8GOHkXO1LYItQir4z0sbV5
         LMPv75dUxVSbriCWZ1PxFH6bnbuRsFbZpd3GO7C1pPrQ3qp5xODJpLP+X25xy70R4ScA
         n+e4kVcRR6LEFCohzRvYnvmeUjiSlBy4f6EyOShv9Xb4Y0B2HUkzg+sCZcepF7mJSnXu
         Rzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045335; x=1697650135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7RMHUs9H0O3cA2fZ8f5lqqKqpIUIAX5ATbtOOlP10Y=;
        b=MQMI8TvAK70dwqXlv2pECT4vbTGoU32MEpSGfYDXNqcdvcnSnoJUigTvgnlRbJGUFC
         /KSMukW6ORkjlmTENvO449z3Md1/5luvq4gzCQAetJwuTIAFZnXz6Mvs7TpX2pmPILsG
         ek0oF6jXKl3UubGZ49AHcMi4+hliz3qGoAjkIYSdvd2+cRd3jejdItTbfziMrhAFsbib
         +ronFvikES9Oj/XZ46CyBeJ1QMv92/5rl5Rg025juBxX0pDUNR2P797yX/HtKXFnhGMS
         ndJu0vrlM8eo9tqEVTUlhcbzXBUYeaMeTwqIjDI8A7dRxOWYxRD/XTLFh2I8H1zj9Yak
         ZzHw==
X-Gm-Message-State: AOJu0YxtbWMEleZpc2p106GFjEBWiBUh63noU888STWup2NgOMgmpMsS
        FSx5DbKdVwikQ7JTCcNWO3beW1Z3pec=
X-Google-Smtp-Source: AGHT+IH8llwMam8XPsOnzcd92m8mDcYDNn4zGLjNcTxgJ5ntXWzrudtDMpSdLdBGTezqAsZk0n5eMhUtHKY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:fe58:8292:66f9:d221])
 (user=glider job=sendgmr) by 2002:a25:5056:0:b0:d9a:3dac:6c1a with SMTP id
 e83-20020a255056000000b00d9a3dac6c1amr134178ybb.11.1697045335555; Wed, 11 Oct
 2023 10:28:55 -0700 (PDT)
Date:   Wed, 11 Oct 2023 19:28:35 +0200
In-Reply-To: <20231011172836.2579017-1-glider@google.com>
Mime-Version: 1.0
References: <20231011172836.2579017-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011172836.2579017-6-glider@google.com>
Subject: [PATCH v7 5/5] arm64: mte: add compression support to mteswap.c
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
2.42.0.609.gbb76f46606-goog

