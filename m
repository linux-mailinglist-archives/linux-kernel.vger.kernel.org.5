Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE447A1401
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjIOCxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjIOCxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:53:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFEB26AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:53:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D1BC433C9;
        Fri, 15 Sep 2023 02:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746382;
        bh=zCDEsnRSxn3q8lrPgI2u2ZG1f3Dh76TJLw6d3uQsNjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ntf/iecFSdd3DqQwgfLRXzHl/czWjON3PowvUDhFaFyZaByn8EF15Fwy+Baodq8g+
         T3UWUH/geUbs9IOLQVJYRq0S8CBgSo4GgagPuJ8w6urJT7ThOqf23T6XPZn1nCvmmA
         /fFveCT57SDIgI7SE2h4z9zxsTlTLoi/TsBBxgaBOU6/ORSdPSV4k/zDhOVrqDvmex
         LK3zQ8xnLrH5yMnM2cfOF65ovLvphaX+SoNR/uigrIopOng3jzRjsCAWmJcMYDW4u7
         446GqrWFI4ki83YgevvKhpiMya0lXnUqLfCMS5ETOm1sWgXKjyk07Xu86nXLNrzVU/
         xvjn5jhsklxHQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm/damon/core: define and use a dedicated function for region access rate update
Date:   Fri, 15 Sep 2023 02:52:44 +0000
Message-Id: <20230915025251.72816-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915025251.72816-1-sj@kernel.org>
References: <20230915025251.72816-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c5b7296c69a0..10532159323a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1549,6 +1549,22 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
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

