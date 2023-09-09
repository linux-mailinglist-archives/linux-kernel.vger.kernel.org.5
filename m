Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A9799629
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbjIIDhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbjIIDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE6F1FE5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805D7C433C9;
        Sat,  9 Sep 2023 03:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230647;
        bh=ugkHqkw7yl130d3cjNnQjhDRwZWu/ujQKtPoxpJY3zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVutAxv4NGTAsH9JU8KYYDMBIibZhveJyySt4YiREVpzBp4Kgnvnr6Lhff2Uvnkvv
         WnOpiFOHRBmjWqJ4pAAWXWiiNP1cm6M76idSJnmIcEPp1RID5/jgf0Ce6JMdbsr4et
         hxtMYclLYMlcSZRhLUtDVINrsCb3MS/i70CjffezmLzikjkNeehVjsoXQMR1ekndIb
         00/hgnsL+Fbe6GfYHF8wncDZN582NEtDhPZyikUTOvaNaSmtnJ4GvUjJzjk+sFb6GF
         7E2oJ8kxURwt9U1Mgw9kCCqLsnN6FtMRfRnzaO4May4NrAgppDWAETNS/jDDJG28+5
         BSPmzIkC83nWw==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 6/8] mm/damon/core: use pseudo-moving sum for nr_accesses_bp
Date:   Sat,  9 Sep 2023 03:37:09 +0000
Message-Id: <20230909033711.55794-7-sj@kernel.org>
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

Let nr_accesses_bp be calculated as a pseudo-moving sum that updated for
every sampling interval, using damon_moving_sum().  This is assumed to
be useful for cases that the aggregation interval is set quite huge, but
the monivoting results need to be collected earlier than next
aggregation interval is passed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 12 +++++++++---
 mm/damon/core.c       | 16 +++++++++++++++-
 mm/damon/paddr.c      |  9 +++++----
 mm/damon/vaddr.c      | 12 +++++++-----
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 15f24b23c9a0..0fe13482df63 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -40,7 +40,8 @@ struct damon_addr_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
- * @nr_accesses_bp:	@nr_accesses in basis point (0.01%).
+ * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
+ *			each sampling interval.
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -51,7 +52,11 @@ struct damon_addr_range {
  * damon_update_region_access_rate().
  *
  * @nr_accesses_bp is another representation of @nr_accesses in basis point
- * (1 in 10,000) that updated every aggregation interval.
+ * (1 in 10,000) that updated for every &damon_attrs->sample_interval in a
+ * manner similar to moving sum.  By the algorithm, this value becomes
+ * @nr_accesses * 10000 for every &struct damon_attrs->aggr_interval.  This can
+ * be used when the aggregation interval is too huge and therefore cannot wait
+ * for it before getting the access monitoring results.
  *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
@@ -629,7 +634,8 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
 unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
 		unsigned int len_window, unsigned int new_value);
-void damon_update_region_access_rate(struct damon_region *r, bool accessed);
+void damon_update_region_access_rate(struct damon_region *r, bool accessed,
+		struct damon_attrs *attrs);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		bool matching);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a97026489301..c813407c09b4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1639,14 +1639,28 @@ unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
  * damon_update_region_access_rate() - Update the access rate of a region.
  * @r:		The DAMON region to update for its access check result.
  * @accessed:	Whether the region has accessed during last sampling interval.
+ * @attrs:	The damon_attrs of the DAMON context.
  *
  * Update the access rate of a region with the region's last sampling interval
  * access check result.
  *
  * Usually this will be called by &damon_operations->check_accesses callback.
  */
-void damon_update_region_access_rate(struct damon_region *r, bool accessed)
+void damon_update_region_access_rate(struct damon_region *r, bool accessed,
+		struct damon_attrs *attrs)
 {
+	unsigned int len_window = 1;
+
+	/*
+	 * sample_interval can be zero, but cannot be larger than
+	 * aggr_interval, owing to validation of damon_set_attrs().
+	 */
+	if (attrs->sample_interval)
+		len_window = attrs->aggr_interval / attrs->sample_interval;
+	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
+			r->last_nr_accesses * 10000, len_window,
+			accessed ? 10000 : 0);
+
 	if (accessed)
 		r->nr_accesses++;
 }
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 44f21860b555..081e2a325778 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -148,7 +148,8 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *folio_sz)
 	return accessed;
 }
 
-static void __damon_pa_check_access(struct damon_region *r)
+static void __damon_pa_check_access(struct damon_region *r,
+		struct damon_attrs *attrs)
 {
 	static unsigned long last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
@@ -157,12 +158,12 @@ static void __damon_pa_check_access(struct damon_region *r)
 	/* If the region is in the last checked page, reuse the result */
 	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_folio_sz)) {
-		damon_update_region_access_rate(r, last_accessed);
+		damon_update_region_access_rate(r, last_accessed, attrs);
 		return;
 	}
 
 	last_accessed = damon_pa_young(r->sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed);
+	damon_update_region_access_rate(r, last_accessed, attrs);
 
 	last_addr = r->sampling_addr;
 }
@@ -175,7 +176,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(r);
+			__damon_pa_check_access(r, &ctx->attrs);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e36303271f9d..af2cb82e1fad 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -557,26 +557,27 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target)
+				struct damon_region *r, bool same_target,
+				struct damon_attrs *attrs)
 {
 	static unsigned long last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
 
 	if (!mm) {
-		damon_update_region_access_rate(r, false);
+		damon_update_region_access_rate(r, false, attrs);
 		return;
 	}
 
 	/* If the region is in the last checked page, reuse the result */
 	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
-		damon_update_region_access_rate(r, last_accessed);
+		damon_update_region_access_rate(r, last_accessed, attrs);
 		return;
 	}
 
 	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed);
+	damon_update_region_access_rate(r, last_accessed, attrs);
 
 	last_addr = r->sampling_addr;
 }
@@ -593,7 +594,8 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		mm = damon_get_mm(t);
 		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target);
+			__damon_va_check_access(mm, r, same_target,
+					&ctx->attrs);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 			same_target = true;
 		}
-- 
2.25.1

