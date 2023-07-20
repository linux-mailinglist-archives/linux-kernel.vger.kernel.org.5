Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059B75B5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjGTRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGTRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:40:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434002D4E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cab7304dcccso892664276.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874815; x=1690479615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAaXjy37mqyNYrDfUW3C83NPs/bBQ+S9RZjTrhTp6QU=;
        b=zvov4G1AddGuBx6dxgnHz1dfQTZYxS2Sku8hEaIkJt2ZfSa2XFJAy105OJ3+2HbgHO
         CK20GvLdXNFgwWeFdV6xfHn5xrNIssdGFzaB3jwEu6NUQd8KRmhob69JtqyFihA29r8t
         ac9Uu92/BuSJNL70kGCoRRHf2PMVEiNkCAU7ZdLY+w378uW08vPShyu1scQ+WiThCPkC
         x6RbZ6Hjv+4BmyHqnZYSQkwXbjgx1g4yEMkb0971xXGk9drbWp98YC5cG/yqGVjMHy9k
         0PTiA8RLSWU1L5YqF+ISCzKPKrla6lPq6N/c+Qm4KntLbx3ik5jvsA269Tnktr/4AFRa
         oJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874815; x=1690479615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAaXjy37mqyNYrDfUW3C83NPs/bBQ+S9RZjTrhTp6QU=;
        b=YdeL7snuUpYa06Ej7J3+jlyQ8Fl2lRSN88Yji/PqlE2BaLLIO/eGFsDtqCfjy2JttZ
         tGR2rkFooIqwiN5t0OIlb+IE34vioU/nT6iljPQBWri3+yQkMA+RdnvPcRuIFS76Bden
         T+6nttTsPR3f1TdzTSnh8f2Y0D+J9RSzqu++n7urakWc6RjSRjGDt8F2MiGVuzsU5Aoj
         H0AOhkBJE/GXXhccSfm6LFb3r45lU1mwZpm6GY5B3n5cwyk63kfdil7rOurmIIONFUWC
         IlJj0vaBcuq9tNa6NwG2mw2HUXEB0JHnvpcG1rI9rBd32oeWdZcx1IxKa+j6mCBwI3G2
         3/mw==
X-Gm-Message-State: ABy/qLa5J856U/vNh06GhLhSCyok1LPKTHmo0vuQldMw24XxQUKG0K2o
        VAZoQLW3CoCuFglFg9zlBF3opeMZbcE=
X-Google-Smtp-Source: APBJJlEo5yy17KrMoEKmBp6OriZtWZa2q+yR8orLtuUdCl5j78EVT8gm1wxSbsue7AubIPG6KpELfVV7238=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c495:c29a:e275:1dfb])
 (user=glider job=sendgmr) by 2002:a25:2054:0:b0:c85:934:7ad2 with SMTP id
 g81-20020a252054000000b00c8509347ad2mr20280ybg.8.1689874815149; Thu, 20 Jul
 2023 10:40:15 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:39:56 +0200
In-Reply-To: <20230720173956.3674987-1-glider@google.com>
Mime-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720173956.3674987-6-glider@google.com>
Subject: [PATCH v4 5/5] arm64: mte: add compression support to mteswap.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
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

These functions accept opaque pointers, which may point to 128-byte
tag buffers, as well as smaller buffers containing compressed tags, or
have compressed tags stored directly in them.

The existing code from mteswap.c operating with uncompressed tags is split
away into mteswap_nocomp.c, and the newly introduced mteswap_comp.c
provides compression support. The latter implementation
is picked if CONFIG_ARM64_MTE_COMP=y.

Soon after booting Android, tag compression saves ~2.5x memory previously
spent by mteswap.c on tag allocations. With the growing uptime, the
savings reach 20x and even more.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 arch/arm64/mm/Makefile         |  5 ++++
 arch/arm64/mm/mteswap.c        | 20 ++++++-------
 arch/arm64/mm/mteswap.h        | 12 ++++++++
 arch/arm64/mm/mteswap_comp.c   | 54 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap_nocomp.c | 38 ++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 11 deletions(-)
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
index 0000000000000..2c4ac5eac9e59
--- /dev/null
+++ b/arch/arm64/mm/mteswap_comp.c
@@ -0,0 +1,54 @@
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
+	u8 tags[128];
+	unsigned long handle;
+
+	mte_save_page_tags(page_address(page), tags);
+	handle = mte_compress(tags);
+	return xa_mk_value(handle);
+}
+
+void _mte_free_saved_tags(void *storage)
+{
+	unsigned long handle;
+	int size;
+
+	handle = xa_to_value(storage);
+	if (!handle)
+		return;
+	size = mte_storage_size(handle);
+	mte_release_handle(handle);
+}
+
+void _mte_restore_tags(void *tags, struct page *page)
+{
+	unsigned long handle;
+	u8 tags_decomp[128];
+
+	handle = xa_to_value(tags);
+	if (!handle)
+		return;
+	if (!try_page_mte_tagging(page))
+		return;
+	if (!mte_decompress(handle, tags_decomp))
+		return;
+	mte_restore_page_tags(page_address(page), tags_decomp);
+	set_page_mte_tagged(page);
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
2.41.0.487.g6d72f3e995-goog

