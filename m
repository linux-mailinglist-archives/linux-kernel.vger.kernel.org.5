Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345967F07FF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjKSRBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjKSRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:00:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18C4E170C;
        Sun, 19 Nov 2023 08:59:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E785F1480;
        Sun, 19 Nov 2023 09:00:26 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B408D3F6C4;
        Sun, 19 Nov 2023 08:59:35 -0800 (PST)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 23/27] arm64: mte: copypage: Handle tag restoring when missing tag storage
Date:   Sun, 19 Nov 2023 16:57:17 +0000
Message-Id: <20231119165721.9849-24-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several situations where copy_highpage() can end up copying
tags to a page which doesn't have its tag storage reserved.

One situation involves migration racing with mprotect(PROT_MTE): VMA is
initially untagged, migration starts and destination page is allocated
as untagged, mprotect(PROT_MTE) changes the VMA to tagged and userspace
accesses the source page, thus making it tagged.  The migration code
then calls copy_highpage(), which will copy the tags from the source
page (now tagged) to the destination page (allocated as untagged).

Yes another situation can happen during THP collapse. The huge page that
will replace the HPAGE_PMD_NR contiguous mapped pages is allocated with
__GFP_TAGGED not set. copy_highpage() will copy the tags from the pages
being replaced to the huge page which doesn't have tag storage reserved.

The situation gets even more complicated when the replacement huge page
is a tag storage page. The tag storage huge page will be migrated after
a fault on access, but the tags from the original pages must be copied
over to the huge page that will be replacing the tag storage huge page.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/mm/copypage.c | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..7899f38773b9 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -13,6 +13,62 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
+
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+static inline bool try_transfer_saved_tags(struct page *from, struct page *to)
+{
+	void *tags;
+	bool saved;
+
+	VM_WARN_ON_ONCE(!preemptible());
+
+	if (page_mte_tagged(from)) {
+		if (likely(page_tag_storage_reserved(to)))
+			return false;
+
+		tags = mte_allocate_tag_buf();
+		if (WARN_ON(!tags))
+			return true;
+
+		mte_copy_page_tags_to_buf(page_address(from), tags);
+		saved = mte_save_tags_for_pfn(tags, page_to_pfn(to));
+		if (!saved)
+			mte_free_tag_buf(tags);
+
+		return saved;
+	}
+
+	if (likely(!page_is_tag_storage(from)))
+		return false;
+
+	tags_by_pfn_lock();
+	tags = mte_erase_tags_for_pfn(page_to_pfn(from));
+	tags_by_pfn_unlock();
+
+	if (likely(!tags))
+		return false;
+
+	if (page_tag_storage_reserved(to)) {
+		WARN_ON_ONCE(!try_page_mte_tagging(to));
+		mte_copy_page_tags_from_buf(page_address(to), tags);
+		set_page_mte_tagged(to);
+		mte_free_tag_buf(tags);
+		return true;
+	}
+
+	saved = mte_save_tags_for_pfn(tags, page_to_pfn(to));
+	if (!saved)
+		mte_free_tag_buf(tags);
+
+	return saved;
+}
+#else
+static inline bool try_transfer_saved_tags(struct page *from, struct page *to)
+{
+	return false;
+}
+#endif
 
 void copy_highpage(struct page *to, struct page *from)
 {
@@ -24,6 +80,9 @@ void copy_highpage(struct page *to, struct page *from)
 	if (kasan_hw_tags_enabled())
 		page_kasan_tag_reset(to);
 
+	if (tag_storage_enabled() && try_transfer_saved_tags(from, to))
+		return;
+
 	if (system_supports_mte() && page_mte_tagged(from)) {
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
-- 
2.42.1

