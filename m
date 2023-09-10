Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7366799C6F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbjIJDlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbjIJDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE9C18F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:40:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B7FC433C7;
        Sun, 10 Sep 2023 03:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317254;
        bh=DjnOjctR1HpX3KfBkTd9mJQPbWLMb6UvjaZw+MXDlfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeRTQo6DJOWDrNGyr55EHwB4hhqOco7edVSXVAZ74USTrG9CgzrwxoemPH6RxKpMt
         1kuH8dC07oeYZsnHrKA7doiMYxJC9ghg69UKlemEh9VJqYeHxMwcb/zbnjsRknJrzK
         +zYwDjGmlCnOjyaY0j51NVV3dcmm5FTr5inHpIrhy0k1qHldsrFcShAurnipSa6TSU
         /MfGJqPDB2Mc0JsQStkiqJvTbY+AIsT9s9gmI2Aa/8TDZeVgiu0a/DJVcIGCkxO8oV
         K9TpVDT+SV54AM4/t7G1wkBROaQ29R7Dx5LvHox5XaOHhBMcbTwMnPt+zHcLXQ8U8K
         ZUIsF2p/i0oZQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 4/8] mm/damon/core: implement scheme-specific apply interval
Date:   Sun, 10 Sep 2023 03:40:44 +0000
Message-Id: <20230910034048.59191-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
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

DAMON-based operation schemes are applied for every aggregation
interval.  That was mainly because schemes were using nr_accesses, which
be complete to be used for every aggregation interval.  However, the
schemes are now using nr_accesses_bp, which is updated for each sampling
interval in a way that reasonable to be used.  Therefore, there is no
reason to apply schemes for each aggregation interval.

The unnecessary alignment with aggregation interval was also making some
use case of DAMOS tricky.  Quota setting under long aggregation interval
is one such example.  Suppose the aggregation interval is ten seconds,
and there is a scheme having CPU quota 100ms per 1s.  The scheme will
actually uses 100ms per ten seconds, since it cannobe be applied before
next aggregation interval.  The feature is working as intended, but the
results might not that intuitive for some users.  This could be fixed by
updating the quota to 1s per 10s.  But, in the case, the CPU usage of
DAMOS could look like spikes, and actually make a bad effect to other
CPU-sensitive workloads.

Implement a dedicated timing interval for each DAMON-based operation
scheme, namely apply_interval.  The interval will be sampling interval
aligned, and each scheme will be applied for its apply_interval.  The
interval is set to 0 by default, and it means the scheme should use the
aggregation interval instead.  This avoids old users getting any
behavioral difference.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 17 +++++++--
 mm/damon/core.c          | 75 ++++++++++++++++++++++++++++++++++++----
 mm/damon/dbgfs.c         |  3 +-
 mm/damon/lru_sort.c      |  2 ++
 mm/damon/reclaim.c       |  2 ++
 mm/damon/sysfs-schemes.c |  2 +-
 6 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 491fdd3e4c76..27b995c22497 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -314,16 +314,19 @@ struct damos_access_pattern {
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
  * @action:		&damo_action to be applied to the target regions.
+ * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @filters:		Additional set of &struct damos_filter for &action.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
  *
- * For each aggregation interval, DAMON finds regions which fit in the
+ * For each @apply_interval_us, DAMON finds regions which fit in the
  * &pattern and applies &action to those. To avoid consuming too much
  * CPU time or IO resources for the &action, &quota is used.
  *
+ * If @apply_interval_us is zero, &damon_attrs->aggr_interval is used instead.
+ *
  * To do the work only when needed, schemes can be activated for specific
  * system situations using &wmarks.  If all schemes that registered to the
  * monitoring context are inactive, DAMON stops monitoring either, and just
@@ -340,6 +343,14 @@ struct damos_access_pattern {
 struct damos {
 	struct damos_access_pattern pattern;
 	enum damos_action action;
+	unsigned long apply_interval_us;
+/* private: internal use only */
+	/*
+	 * number of sample intervals that should be passed before applying
+	 * @action
+	 */
+	unsigned long next_apply_sis;
+/* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	struct list_head filters;
@@ -641,7 +652,9 @@ void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
-			enum damos_action action, struct damos_quota *quota,
+			enum damos_action action,
+			unsigned long apply_interval_us,
+			struct damos_quota *quota,
 			struct damos_watermarks *wmarks);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3e0532c6896c..c2801656a32d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -323,7 +323,9 @@ static struct damos_quota *damos_quota_init_priv(struct damos_quota *quota)
 }
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
-			enum damos_action action, struct damos_quota *quota,
+			enum damos_action action,
+			unsigned long apply_interval_us,
+			struct damos_quota *quota,
 			struct damos_watermarks *wmarks)
 {
 	struct damos *scheme;
@@ -333,6 +335,13 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 		return NULL;
 	scheme->pattern = *pattern;
 	scheme->action = action;
+	scheme->apply_interval_us = apply_interval_us;
+	/*
+	 * next_apply_sis will be set when kdamond starts.  While kdamond is
+	 * running, it will also updated when it is added to the DAMON context,
+	 * or damon_attrs are updated.
+	 */
+	scheme->next_apply_sis = 0;
 	INIT_LIST_HEAD(&scheme->filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
@@ -345,9 +354,21 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	return scheme;
 }
 
+static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
+{
+	unsigned long sample_interval = ctx->attrs.sample_interval ?
+		ctx->attrs.sample_interval : 1;
+	unsigned long apply_interval = s->apply_interval_us ?
+		s->apply_interval_us : ctx->attrs.aggr_interval;
+
+	s->next_apply_sis = ctx->passed_sample_intervals +
+		apply_interval / sample_interval;
+}
+
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
 {
 	list_add_tail(&s->list, &ctx->schemes);
+	damos_set_next_apply_sis(s, ctx);
 }
 
 static void damon_del_scheme(struct damos *s)
@@ -586,6 +607,7 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 {
 	unsigned long sample_interval;
+	struct damos *s;
 
 	if (attrs->min_nr_regions < 3)
 		return -EINVAL;
@@ -602,6 +624,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 
 	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
+
+	damon_for_each_scheme(s, ctx)
+		damos_set_next_apply_sis(s, ctx);
+
 	return 0;
 }
 
@@ -1127,14 +1153,29 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damon_region *r, *next_r;
 	struct damos *s;
+	unsigned long sample_interval = c->attrs.sample_interval ?
+		c->attrs.sample_interval : 1;
+	bool has_schemes_to_apply = false;
 
 	damon_for_each_scheme(s, c) {
+		if (c->passed_sample_intervals != s->next_apply_sis)
+			continue;
+
+		s->next_apply_sis +=
+			(s->apply_interval_us ? s->apply_interval_us :
+			 c->attrs.aggr_interval) / sample_interval;
+
 		if (!s->wmarks.activated)
 			continue;
 
+		has_schemes_to_apply = true;
+
 		damos_adjust_quota(c, s);
 	}
 
+	if (!has_schemes_to_apply)
+		return;
+
 	damon_for_each_target(t, c) {
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
@@ -1419,11 +1460,19 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
 		ctx->attrs.sample_interval : 1;
+	unsigned long apply_interval;
+	struct damos *scheme;
 
 	ctx->passed_sample_intervals = 0;
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
 		sample_interval;
+
+	damon_for_each_scheme(scheme, ctx) {
+		apply_interval = scheme->apply_interval_us ?
+			scheme->apply_interval_us : ctx->attrs.aggr_interval;
+		scheme->next_apply_sis = apply_interval / sample_interval;
+	}
 }
 
 /*
@@ -1470,16 +1519,30 @@ static int kdamond_fn(void *data)
 			ctx->attrs.sample_interval : 1;
 		if (ctx->passed_sample_intervals ==
 				ctx->next_aggregation_sis) {
-			ctx->next_aggregation_sis +=
-				ctx->attrs.aggr_interval / sample_interval;
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
 			if (ctx->callback.after_aggregation &&
-					ctx->callback.after_aggregation(ctx))
+					ctx->callback.after_aggregation(ctx)) {
+				ctx->next_aggregation_sis +=
+					ctx->attrs.aggr_interval /
+					sample_interval;
 				break;
-			if (!list_empty(&ctx->schemes))
-				kdamond_apply_schemes(ctx);
+			}
+		}
+
+		/*
+		 * do kdamond_apply_schemes() after kdamond_merge_regions() if
+		 * possible, to reduce overhead
+		 */
+		if (!list_empty(&ctx->schemes))
+			kdamond_apply_schemes(ctx);
+
+		if (ctx->passed_sample_intervals ==
+				ctx->next_aggregation_sis) {
+			ctx->next_aggregation_sis +=
+				ctx->attrs.aggr_interval / sample_interval;
+
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 			if (ctx->ops.reset_aggregated)
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 124f0f8c97b7..dc0ea1fc30ca 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -278,7 +278,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 			goto fail;
 
 		pos += parsed;
-		scheme = damon_new_scheme(&pattern, action, &quota, &wmarks);
+		scheme = damon_new_scheme(&pattern, action, 0, &quota,
+				&wmarks);
 		if (!scheme)
 			goto fail;
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 7b8fce2f67a8..3ecdcc029443 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -158,6 +158,8 @@ static struct damos *damon_lru_sort_new_scheme(
 			pattern,
 			/* (de)prioritize on LRU-lists */
 			action,
+			/* for each aggregation interval */
+			0,
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 648d2a85523a..ab974e477d2f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -142,6 +142,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&pattern,
 			/* page out those, as soon as found */
 			DAMOS_PAGEOUT,
+			/* for each aggregation interval */
+			0,
 			/* under the quota. */
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 093700f50b18..3d30e85596b0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1610,7 +1610,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, 0, &quota,
 			&wmarks);
 	if (!scheme)
 		return NULL;
-- 
2.25.1

