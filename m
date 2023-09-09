Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FAA799620
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbjIIDha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjIIDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927E1FE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D1CC433C9;
        Sat,  9 Sep 2023 03:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230644;
        bh=CWWNXIT/Dwd1+BhRyAHtcclmBn8xtMZ9uwzWWOesbz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4g9Ika5VasJRZpdNkehsQGg8kmNgm1qwLM5nZc1OQ3bp6R4DT1lFH3+zQDyEhyuv
         mefns1GVzCJtq+OvVa44z8SXvojBkwZ34RpBCIV1f5cCrtu/W7gTjDfqjXKyttEonk
         /4N1vy0njVJ9mulokK5u9jis8z2OUzLntqRp8t07GX2o24Kwfc2nr74r5yzPoYtRRp
         XHMGOcsoRuAex+MbtNun2Ggn/Y+i1aTbNVuNSbMvQjpAERbfaphUfeGRNyJ6Yd1iAj
         OuFS/cHAejFEM+RrL/gstTaIoFQXWfmO+6ELklli6wCU9/VV+c6IGRUfZJGWdtfprd
         faNCXU0uVKbnA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 1/8] mm/damon/core: define and use a dedicated function for region access rate update
Date:   Sat,  9 Sep 2023 03:37:04 +0000
Message-Id: <20230909033711.55794-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909033711.55794-1-sj@kernel.org>
References: <20230909033711.55794-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each DAMON operarions set is updating nr_accesses field of each
damon_region for each of their access check results, from the
check_accesses() callback.  Directly accessing the field could make
things complex to manage and change in future.  Define and use a
dedicated function for the purpose.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  5 ++++-
 mm/damon/core.c       | 16 ++++++++++++++++
 mm/damon/paddr.c      |  6 ++----
 mm/damon/vaddr.c      |  6 ++----
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9a32b8fd0bd3..17c504d236b9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -45,7 +45,9 @@ struct damon_addr_range {
  *
  * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
  * increased for every &damon_attrs->sample_interval if an access to the region
- * during the last sampling interval is found.
+ * during the last sampling interval is found.  The update of this field should
+ * not be done with direct access but with the helper function,
+ * damon_update_region_access_rate().
  *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
@@ -620,6 +622,7 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
+void damon_update_region_access_rate(struct damon_region *r, bool accessed);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		bool matching);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6f37997afc54..3d51a1dfe104 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1589,6 +1589,22 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 	return damon_set_regions(t, &addr_range, 1);
 }
 
+/**
+ * damon_update_region_access_rate() - Update the access rate of a region.
+ * @r:		The DAMON region to update for its access check result.
+ * @accessed:	Whether the region has accessed during last sampling interval.
+ *
+ * Update the access rate of a region with the region's last sampling interval
+ * access check result.
+ *
+ * Usually this will be called by &damon_operations->check_accesses callback.
+ */
+void damon_update_region_access_rate(struct damon_region *r, bool accessed)
+{
+	if (accessed)
+		r->nr_accesses++;
+}
+
 static int __init damon_init(void)
 {
 	damon_region_cache = KMEM_CACHE(damon_region, 0);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 909db25efb35..44f21860b555 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -157,14 +157,12 @@ static void __damon_pa_check_access(struct damon_region *r)
 	/* If the region is in the last checked page, reuse the result */
 	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
-		if (last_accessed)
-			r->nr_accesses++;
+		damon_update_region_access_rate(r, last_accessed);
 		return;
 	}
 
 	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
-	if (last_accessed)
-		r->nr_accesses++;
+	damon_update_region_access_rate(r, last_accessed);
 
 	last_addr = r->sampling_addr;
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4c81a9dbd044..7fc0bda73b4c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -566,14 +566,12 @@ static void __damon_va_check_access(struct mm_struct *mm,
 	/* If the region is in the last checked page, reuse the result */
 	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
-		if (last_accessed)
-			r->nr_accesses++;
+		damon_update_region_access_rate(r, last_accessed);
 		return;
 	}
 
 	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
-	if (last_accessed)
-		r->nr_accesses++;
+	damon_update_region_access_rate(r, last_accessed);
 
 	last_addr = r->sampling_addr;
 }
-- 
2.25.1

