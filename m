Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756D9799624
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbjIIDhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjIIDhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7311FE0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A86C4339A;
        Sat,  9 Sep 2023 03:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230647;
        bh=mrmW1/+KNJqZoPin01nmYe0xzn8mqXbGYK0Xoycksvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ip76wGuy1kQclDid3O3Hr+H5aEqWsLxQ9VqlQGBqDbPNn4DIjYmx7dNVCCEDUXl6+
         qSKTUGWoIiZ6CkGeDuD/wIu6qJzbPCAJdOpDMLb415uyHG6hCONMG0hJdxH0B/A2Tv
         zcBSITAi15CoDEkGyEkmGRB3Cr8zNVJHoTSnrjcWnmZH8pkLudRjKX5RInhXJj6EVd
         pydN8L02IK71T4nYiVFOGkkpWvbkqTwjrjVpXQ9vDASI17I89KJ90cOoWuM1vkrLtC
         mOVkysAoFWjhh2nZmHS0RF5ENIcMuJf2Vt70WNzYnDE0lMJKBSCtNUbzarm6e2VDzk
         5klC4ikfyfMTQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 5/8] mm/damon/core: introduce nr_accesses_bp
Date:   Sat,  9 Sep 2023 03:37:08 +0000
Message-Id: <20230909033711.55794-6-sj@kernel.org>
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

Add yet another representation of the access rate of each region, namely
nr_accesses_bp.  It is just same to the nr_accesses but represents the
value in basis point (1 in 10,000), and updated at once in every
aggregation interval.  That is, moving_accesses_bp is just nr_accesses *
10000.  This may seems useless at the moment.  However, it will be
useful for representing less than one nr_accesses value that will be
needed to make moving sum-based nr_accesses.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++++
 mm/damon/core-test.h  | 5 +++++
 mm/damon/core.c       | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 487a545a11b4..15f24b23c9a0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -40,6 +40,7 @@ struct damon_addr_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
+ * @nr_accesses_bp:	@nr_accesses in basis point (0.01%).
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -49,6 +50,9 @@ struct damon_addr_range {
  * not be done with direct access but with the helper function,
  * damon_update_region_access_rate().
  *
+ * @nr_accesses_bp is another representation of @nr_accesses in basis point
+ * (1 in 10,000) that updated every aggregation interval.
+ *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -58,6 +62,7 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
+	unsigned int nr_accesses_bp;
 	struct list_head list;
 
 	unsigned int age;
diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index c539f0e8377e..79f1f12e0dd5 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -94,6 +94,7 @@ static void damon_test_aggregate(struct kunit *test)
 		for (ir = 0; ir < 3; ir++) {
 			r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
 			r->nr_accesses = accesses[it][ir];
+			r->nr_accesses_bp = accesses[it][ir] * 10000;
 			damon_add_region(r, t);
 		}
 		it++;
@@ -147,9 +148,11 @@ static void damon_test_merge_two(struct kunit *test)
 	t = damon_new_target();
 	r = damon_new_region(0, 100);
 	r->nr_accesses = 10;
+	r->nr_accesses_bp = 100000;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
 	r2->nr_accesses = 20;
+	r2->nr_accesses_bp = 200000;
 	damon_add_region(r2, t);
 
 	damon_merge_two_regions(t, r, r2);
@@ -196,6 +199,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
 		r->nr_accesses = nrs[i];
+		r->nr_accesses_bp = nrs[i] * 10000;
 		damon_add_region(r, t);
 	}
 
@@ -297,6 +301,7 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	struct damon_region *r = damon_new_region(3, 7);
 
 	r->nr_accesses = 15;
+	r->nr_accesses_bp = 150000;
 	r->age = 20;
 
 	new_attrs = (struct damon_attrs){
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5bc0544b9f50..a97026489301 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -134,6 +134,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.start = start;
 	region->ar.end = end;
 	region->nr_accesses = 0;
+	region->nr_accesses_bp = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
@@ -537,6 +538,7 @@ static void damon_update_monitoring_result(struct damon_region *r,
 {
 	r->nr_accesses = damon_nr_accesses_for_new_attrs(r->nr_accesses,
 			old_attrs, new_attrs);
+	r->nr_accesses_bp = r->nr_accesses * 10000;
 	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
 }
 
@@ -1148,6 +1150,7 @@ static void damon_merge_two_regions(struct damon_target *t,
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
+	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
 
@@ -1179,6 +1182,8 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 		else
 			r->age++;
 
+		r->nr_accesses_bp = r->nr_accesses * 10000;
+
 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
 		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
@@ -1233,6 +1238,7 @@ static void damon_split_region_at(struct damon_target *t,
 
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
+	new->nr_accesses_bp = r->nr_accesses_bp;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.25.1

