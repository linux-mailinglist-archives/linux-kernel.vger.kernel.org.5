Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45567F07FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjKSRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjKSRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:00:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36D3A10CA;
        Sun, 19 Nov 2023 08:59:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B3AD14BF;
        Sun, 19 Nov 2023 09:00:32 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00E483F6C4;
        Sun, 19 Nov 2023 08:59:40 -0800 (PST)
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
Subject: [PATCH RFC v2 24/27] arm64: mte: Handle fatal signal in reserve_tag_storage()
Date:   Sun, 19 Nov 2023 16:57:18 +0000
Message-Id: <20231119165721.9849-25-alexandru.elisei@arm.com>
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

As long as a fatal signal is pending, alloc_contig_range() will fail with
-EINTR. This makes it impossible for tag storage allocation to succeed, and
the page allocator will print an OOM splat.

The process is going to be killed, so return 0 (success) from
reserve_tag_storage() to allow the page allocator to make progress.
set_pte_at() will map it with PAGE_FAULT_ON_ACCESS and subsequent accesses
from different threads will cause a fault until the signal is delivered.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/mte_tag_storage.c | 17 +++++++++++++++++
 arch/arm64/mm/fault.c               |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
index 6b11bb408b51..602fdc70db1c 100644
--- a/arch/arm64/kernel/mte_tag_storage.c
+++ b/arch/arm64/kernel/mte_tag_storage.c
@@ -572,6 +572,23 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp)
 				break;
 		}
 
+		/*
+		 * alloc_contig_range() returns -EINTR from
+		 * __alloc_contig_migrate_range() if a fatal signal is pending.
+		 * As long as the signal hasn't been handled, it is impossible
+		 * to reserve tag storage for any page. Stop trying to reserve
+		 * tag storage, but return 0 so the page allocator can make
+		 * forward progress, instead of printing an OOM splat.
+		 *
+		 * The tagged page with missing tag storage will be mapped with
+		 * PAGE_FAULT_ON_ACCESS in set_pte_at(), which means accesses
+		 * until the signal is delivered will cause a fault.
+		 */
+		if (ret == -EINTR) {
+			ret = 0;
+			goto out_error;
+		}
+
 		if (ret)
 			goto out_error;
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 964c5ae161a3..fdc98c5828bf 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -950,6 +950,11 @@ gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp)
 
 void tag_clear_highpage(struct page *page)
 {
+	if (tag_storage_enabled() && unlikely(!page_tag_storage_reserved(page))) {
+		clear_page(page_address(page));
+		return;
+	}
+
 	/* Newly allocated page, shouldn't have been tagged yet */
 	WARN_ON_ONCE(!try_page_mte_tagging(page));
 	mte_zero_clear_page_tags(page_address(page));
-- 
2.42.1

