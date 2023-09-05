Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE257927DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjIEQTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344688AbjIEDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:52:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7FCC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 20:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D751B810A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405EFC433C8;
        Tue,  5 Sep 2023 03:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693885934;
        bh=zWzeHtkbksTfIlg2BoHf0syKSzRvcKMsehHua2+C7C8=;
        h=From:To:Cc:Subject:Date:From;
        b=QCHOoIghh4LGxIoAuSiyWqe8yPYZukbDSip1dZdh/hxdu6s4ndmCkTnrDav4yPEyM
         gX/GTJ3mP3105VZas+4qPuW+6cV4ufzQW4JB/XruphRbil7UyWi7IBudmkjK37/Gkp
         VHQm4n4RJ9P2GRA3WBHxMQVLr1CAHUFQ2Z382eTLqI/1DAaENyQb1VVDyZnae0NcQm
         nFdTf0a762+sEl9zmpVoqPEteYezlJgzx/+yNzyYfIBktQs/DuF8u0D9ufLPn1Xv0G
         wZ4n/EIZGqx/KkreQ3rc7UyMEsi5b2TqjSZ989f57qNMuqJasekMdfHTg2BygLj+iQ
         N4A3fgvL009qw==
From:   SeongJae Park <sj@kernel.org>
To:     damon@lists.linux.dev
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2] mm/damon/core: use number of passed access sampling as a timer
Date:   Tue,  5 Sep 2023 03:52:10 +0000
Message-Id: <20230905035210.127868-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1
(https://lore.kernel.org/damon/20230827003727.49369-1-sj@kernel.org/)
- Initalize next_*_sis at the beginning of kdamond_fn()
- Remove unnecessary remaining intervals compensations in
  damon_set_attrs()

DAMON sleeps for sampling interval after each sampling, and check if the
aggregation interval and the ops update interval have passed using
ktime_get_coarse_ts64() and baseline timestamps for the intervals.  That
design is for making the operations occur at deterministic timing
regardless of the time that spend for each work.  However, it turned out
it is not that useful, and incur not-that-intuitive results.

After all, timer functions, and especially sleep functions that DAMON
uses to wait for specific timing, are not necessarily strictly accurate.
It is legal design, so no problem.  However, depending on such
inaccuracies, the nr_accesses can be larger than aggregation interval
divided by sampling interval.  For example, with the default setting (5
ms sampling interval and 100 ms aggregation interval) we frequently show
regions having nr_accesses larger than 20.  Also, if the execution of a
DAMOS scheme takes a long time, next aggregation could happen before
enough number of samples are collected.  This is not what usual users
would intuitively expect.

Since access check sampling is the smallest unit work of DAMON, using
the number of passed sampling intervals as the DAMON-internal timer can
easily avoid these problems.  That is, convert aggregation and ops
update intervals to numbers of sampling intervals that need to be passed
before those operations be executed, count the number of passed sampling
intervals, and invoke the operations as soon as the specific amount of
sampling intervals passed.  Make the change.

Note that this could make a behavioral change to settings that using
intervals that not aligned by the sampling interval.  For example, if
the sampling interval is 5 ms and the aggregation interval is 12 ms,
DAMON effectively used 15 ms as its aggregation interval with the old
design, hence it checks whether the aggregation interval after sleeping
the sampling interval.  This change will make DAMON to effectively use
10 ms as aggregation interval, since it uses 'aggregation interval /
sampling interval * sampling interval' as the effective aggregation
interval, and we don't use floating point types.  Usual users would have
used aligned intervals, so this behavioral change is not expected to
make any meaningful impact, so just make this change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 14 ++++++-
 mm/damon/core.c       | 87 +++++++++++++++++++------------------------
 2 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ab3089de1478..9a32b8fd0bd3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -524,8 +524,18 @@ struct damon_ctx {
 	struct damon_attrs attrs;
 
 /* private: internal use only */
-	struct timespec64 last_aggregation;
-	struct timespec64 last_ops_update;
+	/* number of sample intervals that passed since this context started */
+	unsigned long passed_sample_intervals;
+	/*
+	 * number of sample intervals that should be passed before next
+	 * aggregation
+	 */
+	unsigned long next_aggregation_sis;
+	/*
+	 * number of sample intervals that should be passed before next ops
+	 * update
+	 */
+	unsigned long next_ops_update_sis;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b895f70acb2d..d64ddaa472ca 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -456,8 +456,10 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
 
-	ktime_get_coarse_ts64(&ctx->last_aggregation);
-	ctx->last_ops_update = ctx->last_aggregation;
+	ctx->passed_sample_intervals = 0;
+	/* These will be set from kdamond_init_intervals_sis() */
+	ctx->next_aggregation_sis = 0;
+	ctx->next_ops_update_sis = 0;
 
 	mutex_init(&ctx->kdamond_lock);
 
@@ -581,6 +583,8 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
  */
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 {
+	unsigned long sample_interval;
+
 	if (attrs->min_nr_regions < 3)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
@@ -588,6 +592,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
+	sample_interval = attrs->sample_interval ? attrs->sample_interval : 1;
+	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
+		attrs->aggr_interval / sample_interval;
+	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
+		attrs->ops_update_interval / sample_interval;
+
 	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
 	return 0;
@@ -761,38 +771,6 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
-/*
- * damon_check_reset_time_interval() - Check if a time interval is elapsed.
- * @baseline:	the time to check whether the interval has elapsed since
- * @interval:	the time interval (microseconds)
- *
- * See whether the given time interval has passed since the given baseline
- * time.  If so, it also updates the baseline to current time for next check.
- *
- * Return:	true if the time interval has passed, or false otherwise.
- */
-static bool damon_check_reset_time_interval(struct timespec64 *baseline,
-		unsigned long interval)
-{
-	struct timespec64 now;
-
-	ktime_get_coarse_ts64(&now);
-	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
-			interval * 1000)
-		return false;
-	*baseline = now;
-	return true;
-}
-
-/*
- * Check whether it is time to flush the aggregated information
- */
-static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
-{
-	return damon_check_reset_time_interval(&ctx->last_aggregation,
-			ctx->attrs.aggr_interval);
-}
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1296,18 +1274,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 	last_nr_regions = nr_regions;
 }
 
-/*
- * Check whether it is time to check and apply the operations-related data
- * structures.
- *
- * Returns true if it is.
- */
-static bool kdamond_need_update_operations(struct damon_ctx *ctx)
-{
-	return damon_check_reset_time_interval(&ctx->last_ops_update,
-			ctx->attrs.ops_update_interval);
-}
-
 /*
  * Check whether current monitoring should be stopped
  *
@@ -1419,6 +1385,17 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
+static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
+{
+	unsigned long sample_interval = ctx->attrs.sample_interval ?
+		ctx->attrs.sample_interval : 1;
+
+	ctx->passed_sample_intervals = 0;
+	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
+	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
+		sample_interval;
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -1432,6 +1409,8 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
+	kdamond_init_intervals_sis(ctx);
+
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
@@ -1440,6 +1419,8 @@ static int kdamond_fn(void *data)
 	sz_limit = damon_region_sz_limit(ctx);
 
 	while (!kdamond_need_stop(ctx)) {
+		unsigned long sample_interval;
+
 		if (kdamond_wait_activation(ctx))
 			break;
 
@@ -1450,11 +1431,17 @@ static int kdamond_fn(void *data)
 			break;
 
 		kdamond_usleep(ctx->attrs.sample_interval);
+		ctx->passed_sample_intervals++;
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (kdamond_aggregate_interval_passed(ctx)) {
+		sample_interval = ctx->attrs.sample_interval ?
+			ctx->attrs.sample_interval : 1;
+		if (ctx->passed_sample_intervals ==
+				ctx->next_aggregation_sis) {
+			ctx->next_aggregation_sis +=
+				ctx->attrs.aggr_interval / sample_interval;
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
@@ -1469,7 +1456,11 @@ static int kdamond_fn(void *data)
 				ctx->ops.reset_aggregated(ctx);
 		}
 
-		if (kdamond_need_update_operations(ctx)) {
+		if (ctx->passed_sample_intervals ==
+				ctx->next_ops_update_sis) {
+			ctx->next_ops_update_sis +=
+				ctx->attrs.ops_update_interval /
+				sample_interval;
 			if (ctx->ops.update)
 				ctx->ops.update(ctx);
 			sz_limit = damon_region_sz_limit(ctx);
-- 
2.25.1

