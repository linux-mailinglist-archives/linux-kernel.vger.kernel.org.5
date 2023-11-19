Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308C97F07BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjKSQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjKSQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:58:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02FECD52;
        Sun, 19 Nov 2023 08:58:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2BD1007;
        Sun, 19 Nov 2023 08:58:46 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ACFC3F6C4;
        Sun, 19 Nov 2023 08:57:55 -0800 (PST)
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
Subject: [PATCH RFC v2 04/27] mm: migrate/mempolicy: Add hook to modify migration target gfp
Date:   Sun, 19 Nov 2023 16:56:58 +0000
Message-Id: <20231119165721.9849-5-alexandru.elisei@arm.com>
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

It might be desirable for an architecture to modify the gfp flags used to
allocate the destination page for migration based on the page that it is
being replaced. For example, if an architectures has metadata associated
with a page (like arm64, when the memory tagging extension is implemented),
it can request that the destination page similarly has storage for tags
already allocated.

No functional change.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/migrate.h | 4 ++++
 mm/mempolicy.c          | 2 ++
 mm/migrate.c            | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 2ce13e8a309b..0acef592043c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -60,6 +60,10 @@ struct movable_operations {
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
+#ifndef arch_migration_target_gfp
+#define arch_migration_target_gfp(src, gfp) 0
+#endif
+
 #ifdef CONFIG_MIGRATION
 
 void putback_movable_pages(struct list_head *l);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..50bc43ab50d6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1182,6 +1182,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 
 		h = folio_hstate(src);
 		gfp = htlb_alloc_mask(h);
+		gfp |= arch_migration_target_gfp(src, gfp);
 		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
 	}
@@ -1190,6 +1191,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 		gfp = GFP_TRANSHUGE;
 	else
 		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
+	gfp |= arch_migration_target_gfp(src, gfp);
 
 	page = alloc_pages_mpol(gfp, order, pol, ilx, nid);
 	return page_rmappable_folio(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 35a88334bb3c..dd25ab69e3de 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2016,6 +2016,7 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 		struct hstate *h = folio_hstate(src);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
+		gfp_mask |= arch_migration_target_gfp(src, gfp);
 		return alloc_hugetlb_folio_nodemask(h, nid,
 						mtc->nmask, gfp_mask);
 	}
@@ -2032,6 +2033,7 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 	zidx = zone_idx(folio_zone(src));
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
+	gfp_mask |= arch_migration_target_gfp(src, gfp);
 
 	return __folio_alloc(gfp_mask, order, nid, mtc->nmask);
 }
@@ -2500,6 +2502,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 			__GFP_NOWARN;
 		gfp &= ~__GFP_RECLAIM;
 	}
+	gfp |= arch_migration_target_gfp(src, gfp);
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-- 
2.42.1

