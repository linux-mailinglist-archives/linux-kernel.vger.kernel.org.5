Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC737F07CA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjKSQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjKSQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:58:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A604511D;
        Sun, 19 Nov 2023 08:58:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 967AFDA7;
        Sun, 19 Nov 2023 08:59:02 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F4F03F6C4;
        Sun, 19 Nov 2023 08:58:11 -0800 (PST)
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
Subject: [PATCH RFC v2 07/27] mm: page_alloc: Add an arch hook to filter MIGRATE_CMA allocations
Date:   Sun, 19 Nov 2023 16:57:01 +0000
Message-Id: <20231119165721.9849-8-alexandru.elisei@arm.com>
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

As an architecture might have specific requirements around the allocation
of CMA pages, add an arch hook that can disable allocations from
MIGRATE_CMA, if the allocation was otherwise allowed.

This will be used by arm64, which will put tag storage pages on the
MIGRATE_CMA list, pages which have specific limitations.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/pgtable.h | 7 +++++++
 mm/page_alloc.c         | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3f34f00ced62..b7a9ab818f6d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -884,6 +884,13 @@ static inline int arch_prep_new_page(struct page *page, int order, gfp_t gfp)
 static inline void arch_free_pages_prepare(struct page *page, int order) { }
 #endif
 
+#ifndef __HAVE_ARCH_ALLOC_CMA
+static inline bool arch_alloc_cma(gfp_t gfp)
+{
+	return true;
+}
+#endif
+
 #ifndef __HAVE_ARCH_UNMAP_ONE
 /*
  * Some architectures support metadata associated with a page. When a
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 86e4b1dac538..0f508070c404 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3167,7 +3167,8 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
 						  unsigned int alloc_flags)
 {
 #ifdef CONFIG_CMA
-	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
+	    arch_alloc_cma(gfp_mask))
 		alloc_flags |= ALLOC_CMA;
 #endif
 	return alloc_flags;
-- 
2.42.1

