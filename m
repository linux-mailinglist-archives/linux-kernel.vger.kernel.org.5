Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9276D9DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjHBVnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjHBVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D422129
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E01A961B57
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 21:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE167C433CD;
        Wed,  2 Aug 2023 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012601;
        bh=LLJzB0sVUowPypLPfilJ9ll9ROg8ZjWHW/Z5wJ/sStk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkhmslLe0GxP2N2+y3vPzxbdNelf/f7eD7yOiTdPNuPH3Itbqqte/gVni+fJGpTId
         eAkcCedieQMwCnPUJXlPpJouMGDauK0+Krf5yG1mC53UZ7DivLlFCceJmwK8z5ve9p
         7b+MEHH8TIDEEN2qUQX2lwcKLVC912GT3PSqdlJsMbBkcOHd23z/vHfI2vwsv0zM1Y
         AzAbZUETtNv77HAr6UUwxHJ6XDVCNskTBruIlMWojbvqOQwxebuD9iO2QW+0Bjqn4d
         Qdb96Vu+ztR+6ZkQnom5xLHlcC41PLs2dXATGe2NW+ppJu8ai81YPoYiz2q0vuqaP3
         Em2hDewK4gfhA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] mm/damon/core: implement target type damos filter
Date:   Wed,  2 Aug 2023 21:43:07 +0000
Message-Id: <20230802214312.110532-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802214312.110532-1-sj@kernel.org>
References: <20230802214312.110532-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One DAMON context can have multiple monitoring targets, and DAMOS
schemes are applied to all targets.  In some cases, users need to apply
different scheme to different targets.  Retrieving monitoring results
via DAMON sysfs interface' 'tried_regions' directory could be one good
example.  Also, there could be cases that cgroup DAMOS filter is not
enough.  All such use cases can be worked around by having multiple
DAMON contexts having only single target, but it is inefficient in terms
of resource usage, thogh the overhead is not estimated to be huge.

Implement DAMON monitoring target based DAMOS filter for the case.  Like
address range target DAMOS filter, handle these filters in the DAMON
core layer, since it is more efficient than doing in operations set
layer.  This also means that regions that filtered out by monitoring
target type DAMOS filters are counted as not tried by the scheme.
Hence, target granularity monitoring results retrieval via DAMON sysfs
interface becomes available.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  6 ++++++
 mm/damon/core.c       | 22 ++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 476f37a883a4..ae2664d1d5f1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -227,6 +227,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
+ * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
  * The anon pages type and memcg type filters are handled by underlying
@@ -244,6 +245,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_ADDR,
+	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
 };
 
@@ -253,6 +255,9 @@ enum damos_filter_type {
  * @matching:	If the matching page should filtered out or in.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
+ * @target_idx:	Index of the &struct damon_target of
+ *		&damon_ctx->adaptive_targets if @type is
+ *		DAMOS_FILTER_TYPE_TARGET.
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
@@ -266,6 +271,7 @@ struct damos_filter {
 	union {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
+		int target_idx;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f3a821215230..bcd2bd9d6c10 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -878,13 +878,23 @@ static void damos_update_stat(struct damos *s,
 	s->stat.sz_applied += sz_applied;
 }
 
-static bool __damos_filter_out(struct damon_target *t, struct damon_region *r,
-		struct damos_filter *filter)
+static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos_filter *filter)
 {
 	bool matched = false;
+	struct damon_target *ti;
+	int target_idx = 0;
 	unsigned long start, end;
 
 	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_TARGET:
+		damon_for_each_target(ti, ctx) {
+			if (ti == t)
+				break;
+			target_idx++;
+		}
+		matched = target_idx == filter->target_idx;
+		break;
 	case DAMOS_FILTER_TYPE_ADDR:
 		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
 		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
@@ -916,13 +926,13 @@ static bool __damos_filter_out(struct damon_target *t, struct damon_region *r,
 	return matched == filter->matching;
 }
 
-static bool damos_filter_out(struct damon_target *t, struct damon_region *r,
-		struct damos *s)
+static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, struct damos *s)
 {
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, s) {
-		if (__damos_filter_out(t, r, filter))
+		if (__damos_filter_out(ctx, t, r, filter))
 			return true;
 	}
 	return false;
@@ -945,7 +955,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
 		}
-		if (damos_filter_out(t, r, s))
+		if (damos_filter_out(c, t, r, s))
 			return;
 		ktime_get_coarse_ts64(&begin);
 		if (c->callback.before_damos_apply)
-- 
2.25.1

