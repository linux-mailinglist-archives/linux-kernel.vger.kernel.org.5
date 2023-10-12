Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9557C76A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442140AbjJLTXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442095AbjJLTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:23:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F458B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:23:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C18EC433C8;
        Thu, 12 Oct 2023 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697138581;
        bh=tkpBuPAHcXxVtnYMQEIhabnoxptCyM9g6IJhkHy1SMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aIdWdAmThfiNczrCHF64qTVKfLSk01CfLnL5UFWaPXwntIdXJ6UfNINVkYsd5Vhll
         VVHbCRYub75Tby4lEez/3PttT7S0GwlkcTAFbBhKcSoeurdPxSSPsiYnyNPm68gJy2
         lkmgFs5kJoCNolAeQaQLyYoILXreILMp0vXynsFEeMBB/9dOl51qDZyqTIG2QTuvvY
         OI9OkcU7V/BpMZaqRYxKhr0FNpsPQ4u33+Xjdk2k51ot7FKasLhZpXylstmVaKF9QR
         ZhNo/fspViHzQnQathBncfXwWLgNlMK4jYKn5CnJ3DAZDhmOEkJX474+95IZYuU7Ia
         gatFrhmNm3ccw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/damon/sysfs-schemes: do not update tried regions more than one DAMON snapshot
Date:   Thu, 12 Oct 2023 19:22:53 +0000
Message-Id: <20231012192256.33556-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012192256.33556-1-sj@kernel.org>
References: <20231012192256.33556-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON_SYSFS exposes every DAMON-found region that eligible for applying
the scheme action for one aggregation interval.  However, each
DAMON-based operation scheme has its own apply interval.  Hence, for a
scheme that having its apply interval much smaller than the aggregation
interval, DAMON_SYSFS will expose the scheme regions that applied to
more than one DAMON monitoring results snapshots.  Since the purpose of
DAMON tried regions is exposing single snapshot, this makes no much
sense.  Track progress of each scheme's tried regions update and avoid
the case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a7d70b95c4dd..b07a5c544b34 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -113,11 +113,47 @@ static const struct kobj_type damon_sysfs_scheme_region_ktype = {
  * scheme regions directory
  */
 
+/*
+ * enum damos_sysfs_regions_upd_status - Represent DAMOS tried regions update
+ *					 status
+ * @DAMOS_TRIED_REGIONS_UPD_IDLE:		Waiting for next request.
+ * @DAMOS_TRIED_REGIONS_UPD_STARTED:		Update started.
+ * @DAMOS_TRIED_REGIONS_UPD_FINISHED:	Update finished.
+ *
+ * Each DAMON-based operation scheme (&struct damos) has its own apply
+ * interval, and we need to expose the scheme tried regions based on only
+ * single snapshot.  For this, we keep the tried regions update status for each
+ * scheme.  The status becomes 'idle' at the beginning.
+ *
+ * Once the tried regions update request is received, the request handling
+ * start function (damon_sysfs_scheme_update_regions_start()) sets the status
+ * of all schemes as 'idle' again, and register ->before_damos_apply() and
+ * ->after_sampling() callbacks.
+ *
+ * Then, the first followup ->before_damos_apply() callback
+ * (damon_sysfs_before_damos_apply()) sets the status 'started'.  The first
+ * ->after_sampling() callback (damon_sysfs_after_sampling()) after the call
+ * is called only after the scheme is completely applied
+ * to the given snapshot.  Hence the callback knows the situation by showing
+ * 'started' status, and sets the status as 'finished'.  Then,
+ * damon_sysfs_before_damos_apply() understands the situation by showing the
+ * 'finished' status and do nothing.
+ *
+ *  Finally, the tried regions request handling finisher function
+ *  (damon_sysfs_schemes_update_regions_stop()) unregisters the callbacks.
+ */
+enum damos_sysfs_regions_upd_status {
+	DAMOS_TRIED_REGIONS_UPD_IDLE,
+	DAMOS_TRIED_REGIONS_UPD_STARTED,
+	DAMOS_TRIED_REGIONS_UPD_FINISHED,
+};
+
 struct damon_sysfs_scheme_regions {
 	struct kobject kobj;
 	struct list_head regions_list;
 	int nr_regions;
 	unsigned long total_bytes;
+	enum damos_sysfs_regions_upd_status upd_status;
 };
 
 static struct damon_sysfs_scheme_regions *
@@ -130,6 +166,7 @@ damon_sysfs_scheme_regions_alloc(void)
 	INIT_LIST_HEAD(&regions->regions_list);
 	regions->nr_regions = 0;
 	regions->total_bytes = 0;
+	regions->upd_status = DAMOS_TRIED_REGIONS_UPD_IDLE;
 	return regions;
 }
 
@@ -1777,6 +1814,10 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 		return 0;
 
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
+	if (sysfs_regions->upd_status == DAMOS_TRIED_REGIONS_UPD_FINISHED)
+		return 0;
+	if (sysfs_regions->upd_status == DAMOS_TRIED_REGIONS_UPD_IDLE)
+		sysfs_regions->upd_status = DAMOS_TRIED_REGIONS_UPD_STARTED;
 	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
 	if (damos_regions_upd_total_bytes_only)
 		return 0;
@@ -1793,6 +1834,29 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 	return 0;
 }
 
+/*
+ * DAMON callback that called after each accesses sampling.  While this
+ * callback is registered, damon_sysfs_lock should be held to ensure the
+ * regions directories exist.
+ */
+static int damon_sysfs_after_sampling(struct damon_ctx *ctx)
+{
+	struct damon_sysfs_schemes *sysfs_schemes =
+		damon_sysfs_schemes_for_damos_callback;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
+		if (sysfs_regions->upd_status ==
+				DAMOS_TRIED_REGIONS_UPD_STARTED)
+			sysfs_regions->upd_status =
+				DAMOS_TRIED_REGIONS_UPD_FINISHED;
+	}
+
+	return 0;
+}
+
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
@@ -1816,6 +1880,16 @@ int damon_sysfs_schemes_clear_regions(
 	return 0;
 }
 
+static void damos_tried_regions_init_upd_status(
+		struct damon_sysfs_schemes *sysfs_schemes)
+{
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++)
+		sysfs_schemes->schemes_arr[i]->tried_regions->upd_status =
+			DAMOS_TRIED_REGIONS_UPD_IDLE;
+}
+
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
@@ -1823,8 +1897,10 @@ int damon_sysfs_schemes_update_regions_start(
 {
 	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
+	damos_tried_regions_init_upd_status(sysfs_schemes);
 	damos_regions_upd_total_bytes_only = total_bytes_only;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
+	ctx->callback.after_sampling = damon_sysfs_after_sampling;
 	return 0;
 }
 
@@ -1837,6 +1913,7 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx)
 {
 	damon_sysfs_schemes_for_damos_callback = NULL;
 	ctx->callback.before_damos_apply = NULL;
+	ctx->callback.after_sampling = NULL;
 	damon_sysfs_schemes_region_idx = 0;
 	return 0;
 }
-- 
2.34.1

