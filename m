Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458737561B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGQLhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjGQLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:37:36 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FAF170D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57704af0e64so40031707b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689593849; x=1692185849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcW4dTWuK29JOsV2I2tZPVBrCL3mh4Imj+/5bJ9CoOk=;
        b=gdizMM9JyFRaSyLcM5RbfD5tdIJu0mKai4Fl0ObvuOf0O+6+HTWyseniNFOwWjh3Qw
         fQzlw0f8mj2Ty4njDT81A7x0jBPrrVHBaCiBSek6cmPi9tsBRAxPpJ9cw6SuET75wgY3
         vk29kv+TX/1lm1/9tHeZLrieK/MaSI+20x0iOVdm3B1NwzNpkjNA4U2+WtNFDuAuRVjo
         c0+PUisiBVn5cqCUfbCfUyoMEvB5aS8I39dXhgD1Oz6WcuQ1U8FGP6jSXnP79P6zvmB4
         1q4XuzwuWUCPj7nklypjtmX/4s7wJwxGiIuOOMkuuvKZwTsheaK1x9w0oa6h7LRQdpLZ
         xhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593849; x=1692185849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcW4dTWuK29JOsV2I2tZPVBrCL3mh4Imj+/5bJ9CoOk=;
        b=E4NmBkV2Aog/6Ez8lSOc1V+WWGsKHLjZ65t8GT/G/LFM2k5wNgh/yrmFMjVfSvM3eZ
         VG7welrcc/FURuIXVB0l8OMfZ3Iz7WrraAhRSR9CJYSGN/KTT44bUfw38U+75sEinBYg
         SAwSPTcSI6D1yK47VXjOm6t0x+Rm4wdgbZ2J0f3Fv1jfKgQ9D1GGNbAHVG024WayglJ7
         5KRX9qo6xxa3en+Qq+Rau2IVlelzURR3wWmjm2T/hH1HlJ8xs+3fizdQUi+3IbH6NtJh
         WyMZBFCJPAYbSAqhXhlX5W60gUw/oLyjdobqY0g3bX3W3sTRjvJDmFYC2yueDhuGkF9b
         2HlQ==
X-Gm-Message-State: ABy/qLaRLb0Tnq03jSiZoyUbPaiocW80hGe7Nf0FZPhEID3sf/Tfz16q
        knb/HQrfGkUd2tbUG8Yg4qI6P6LOeMM=
X-Google-Smtp-Source: APBJJlF+UsQWSQZQUzOIpfmZAM+dabmEIbY8ZwC+iGCz0HrXVGAIdKlFYy7SilJTzlUaFelBn9r9UMtcmfQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3b6e:8102:6db8:d83f])
 (user=glider job=sendgmr) by 2002:a81:de05:0:b0:576:d9ec:3350 with SMTP id
 k5-20020a81de05000000b00576d9ec3350mr150011ywj.10.1689593849601; Mon, 17 Jul
 2023 04:37:29 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:37:08 +0200
In-Reply-To: <20230717113709.328671-1-glider@google.com>
Mime-Version: 1.0
References: <20230717113709.328671-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717113709.328671-6-glider@google.com>
Subject: [PATCH v3 5/5] arm64: mte: add compression support to mteswap.c
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
 v3:
  - Addressed comments by Andy Shevchenko in another patch:
   - fixed includes order
   - replaced u64 with unsigned long
   - added MODULE_IMPORT_NS(MTECOMP)
---
 arch/arm64/mm/Makefile         |  5 ++++
 arch/arm64/mm/mteswap.c        | 20 ++++++-------
 arch/arm64/mm/mteswap.h        | 12 ++++++++
 arch/arm64/mm/mteswap_comp.c   | 52 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap_nocomp.c | 38 +++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 11 deletions(-)
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
index 0000000000000..7a369c3fb9c94
--- /dev/null
+++ b/arch/arm64/mm/mteswap_comp.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management with EA0 compression. */
+
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
+	unsigned long handle = xa_to_value(tags);
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
+MODULE_IMPORT_NS(MTECOMP);
diff --git a/arch/arm64/mm/mteswap_nocomp.c b/arch/arm64/mm/mteswap_nocomp.c
new file mode 100644
index 0000000000000..32733998b1879
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
+	if (try_page_mte_tagging(page)) {
+		mte_restore_page_tags(page_address(page), tags);
+		set_page_mte_tagged(page);
+	}
+}
-- 
2.41.0.255.g8b1d071c50-goog

