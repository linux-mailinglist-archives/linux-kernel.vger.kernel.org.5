Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325CD752205
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjGMM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjGMM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE42702
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-579e9b95b86so5507107b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689253060; x=1691845060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOfdDj4t/4l0qN/MzMyGSYQ+xos/zeOUfaRubiCXYXI=;
        b=fkNAaakhJhj14joU9vjShVN1J78/4ao4j4r/p0M09hqWWrtvYQsGmFffwTbIc+z21k
         OzoCWRoZ9KXixeBMf8N4Ri/coa/+8/xhR9EKxTNP8sfg3qpJat0FAxgDfcso3YLSRxuh
         tY3+AZS3TUi6H9CqRMIO6SNQKVGT6MR1mFawBy7pnitaqt3ZGBxlgndqmv2HJtMKJA43
         U3PMN16S19MICAm06IGvBgzUo76/EVqARHIYt3KZurXU3HFFjt3/XW6jXM66vj5+t1kA
         5Fj1MEGzbzeQH4Mmxx1jNONJ0i9fxqfaD+AdEi66+pcUHkQ3G3yvhO7pNJTb2WABE3b5
         KE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253060; x=1691845060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOfdDj4t/4l0qN/MzMyGSYQ+xos/zeOUfaRubiCXYXI=;
        b=QsKjDzfRn9yzjcgStmpJJ65+l4S4uYgZV2OuIGQW8kL6rQB/BnmHvPHX+/VidsPD9O
         LxyvsJla2oCDNtdHc7unkc6zONId2wk4/y89fqRepaOTxM4CzzM4MNG+6Sf7gSDz8V2a
         DRqhtfB/Azi58ZxPKuVybetbW8Hj5roOE4+3AjFKQP7m+r2i3c0Dpdb0k+Hf/K7g5K8t
         ejnYffAyY8NY9UVNlvISNyGjooTApw4SO7SVxyo9piksH11JTQ8nNxHHUBKLmrJbxcJd
         /HSAkzuU4qcwtoYLpCIhU/sLUaSEEv4v1z2B7lNvR0b2q+cGZGavKAgdRo2Ufg3wK6K4
         Kbjw==
X-Gm-Message-State: ABy/qLY9IQOeGJd6PH7qRcIoBPsOrt3ljQ/8r3uhLBf2moeJy6CSvr+o
        Fouzi3+32DFdeBBERN7R/SBaxclkDAw=
X-Google-Smtp-Source: APBJJlE4gqf8HgUFd5kWo4vVey1n9AXLc59Gq5/Kp0SmJA9jDOWF5opeYPMCBv7jvMQnKUUmiSAL5uMTcOM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7a88:66b7:31e5:7d85])
 (user=glider job=sendgmr) by 2002:a81:8b48:0:b0:570:b1:ca37 with SMTP id
 e8-20020a818b48000000b0057000b1ca37mr13111ywk.5.1689253060736; Thu, 13 Jul
 2023 05:57:40 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:57:05 +0200
In-Reply-To: <20230713125706.2884502-1-glider@google.com>
Mime-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713125706.2884502-6-glider@google.com>
Subject: [v2 5/5] arm64: mte: add compression support to mteswap.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
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

Define the internal mteswap.h interface:
 - _mte_alloc_and_save_tags()
 - _mte_free_saved_tags()
 - _mte_restore_tags()

, that encapsulates saving tags for a struct page (together with memory
allocation), restoring tags, and deleting the storage allocated for them.

These functions accept opaque pointers, which may point to 128-byte
tag buffers, as well as smaller buffers containing compressed tags, or
have compressed tags stored directly in them.

The existing code from mteswap.c operating with uncompressed tags is split
away into mteswap_nocomp.c, and the newly introduced mteswap_comp.c
provides compression with the EA0 algorithm. The latter implementation
is picked if CONFIG_ARM64_MTE_COMP=y.

Soon after booting Android, tag compression saves ~2.5x memory previously
spent by mteswap.c on tag allocations. With the growing uptime, the
savings reach 20x and even more.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/mm/Makefile         |  5 ++++
 arch/arm64/mm/mteswap.c        | 19 ++++++-------
 arch/arm64/mm/mteswap.h        | 12 ++++++++
 arch/arm64/mm/mteswap_comp.c   | 50 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap_nocomp.c | 37 +++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 11 deletions(-)
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
index cd508ba80ab1b..e072c1209fbb6 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -7,6 +7,8 @@
 #include <linux/swapops.h>
 #include <asm/mte.h>
 
+#include "mteswap.h"
+
 static DEFINE_XARRAY(mte_pages);
 
 void *mte_allocate_tag_storage(void)
@@ -27,20 +29,18 @@ int mte_save_tags(struct page *page)
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
@@ -53,10 +53,7 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
-	if (try_page_mte_tagging(page)) {
-		mte_restore_page_tags(page_address(page), tags);
-		set_page_mte_tagged(page);
-	}
+	_mte_restore_tags(tags, page);
 }
 
 void mte_invalidate_tags(int type, pgoff_t offset)
@@ -64,7 +61,7 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	swp_entry_t entry = swp_entry(type, offset);
 	void *tags = xa_erase(&mte_pages, entry.val);
 
-	mte_free_tag_storage(tags);
+	_mte_free_saved_tags(tags);
 }
 
 void mte_invalidate_tags_area(int type)
@@ -78,7 +75,7 @@ void mte_invalidate_tags_area(int type)
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
index 0000000000000..bf25f2b3e75a4
--- /dev/null
+++ b/arch/arm64/mm/mteswap.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_ARM64_MM_MTESWAP_H_
+#define ARCH_ARM64_MM_MTESWAP_H_
+
+#include <linux/mm_types.h>
+
+void *_mte_alloc_and_save_tags(struct page *page);
+void _mte_free_saved_tags(void *tags);
+void _mte_restore_tags(void *tags, struct page *page);
+
+#endif // ARCH_ARM64_MM_MTESWAP_H_
diff --git a/arch/arm64/mm/mteswap_comp.c b/arch/arm64/mm/mteswap_comp.c
new file mode 100644
index 0000000000000..bc2591f8d4f35
--- /dev/null
+++ b/arch/arm64/mm/mteswap_comp.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management with EA0 compression. */
+
+#include <asm/mte.h>
+#include <asm/mtecomp.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/xarray.h>
+
+#include "mteswap.h"
+
+void *_mte_alloc_and_save_tags(struct page *page)
+{
+	u8 tags[128];
+	u64 handle;
+
+	mte_save_page_tags(page_address(page), tags);
+	handle = ea0_compress(tags);
+	return xa_mk_value(handle);
+}
+
+void _mte_free_saved_tags(void *storage)
+{
+	unsigned long handle = xa_to_value(storage);
+	int size;
+
+	if (!handle)
+		return;
+	size = ea0_storage_size(handle);
+	ea0_release_handle(handle);
+}
+
+void _mte_restore_tags(void *tags, struct page *page)
+{
+	u64 handle = xa_to_value(tags);
+	u8 tags_decomp[128];
+
+	if (!handle)
+		return;
+
+	if (try_page_mte_tagging(page)) {
+		if (!ea0_decompress(handle, tags_decomp))
+			return;
+		mte_restore_page_tags(page_address(page), tags_decomp);
+		set_page_mte_tagged(page);
+	}
+}
diff --git a/arch/arm64/mm/mteswap_nocomp.c b/arch/arm64/mm/mteswap_nocomp.c
new file mode 100644
index 0000000000000..efcdac88b342d
--- /dev/null
+++ b/arch/arm64/mm/mteswap_nocomp.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management without compression support. */
+
+#include <asm/mte.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/xarray.h>
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
+	if (try_page_mte_tagging(page)) {
+		mte_restore_page_tags(page_address(page), tags);
+		set_page_mte_tagged(page);
+	}
+}
-- 
2.41.0.255.g8b1d071c50-goog

