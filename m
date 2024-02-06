Return-Path: <linux-kernel+bounces-54218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E201384AC5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD211F251CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CF6EB57;
	Tue,  6 Feb 2024 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOmbmYCA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6A6EB4C;
	Tue,  6 Feb 2024 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187924; cv=none; b=VIpQZ965P/UqVLOweLO7Sc6//O5SivsN8uv12+qculjI5uwUKabpP6qbN6DsIATw3iDY2NqfJzYGA4TZAp7+5ABOT3di1HFNR4ACqdG7O95xmNKpio5b5imlzzlBxBpHM1f/fcLP4hv93toT/RwphLk3VzqBYfrf8OXrIaG7BDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187924; c=relaxed/simple;
	bh=bq2ABozIdInk9f3RiCusWCHq2XVIshtqRKWElNQQ11M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEcEq/Mj88Qx4mTI9wTdHFveUKsJ4jVIGa9lgIfs7JOD2Vq9WkHFpNHZCkX4PLPlXL0FrJRG+NFms75LgtB7NfnEQ2nEt6o3WmASQvHjOx5D/mRxUV0iFL7ItLEmz5M5fMnchpqqyb4oRsh6yZquDj1JT+kU4yyNSt8ic/1pFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOmbmYCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540C8C433F1;
	Tue,  6 Feb 2024 02:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707187923;
	bh=bq2ABozIdInk9f3RiCusWCHq2XVIshtqRKWElNQQ11M=;
	h=From:To:Cc:Subject:Date:From;
	b=vOmbmYCAyMcjTPDBExa+YMMSUcJ7pNPhNxNGTj21aG7LYarjqx+ATjZ+0q49woSF5
	 5AS4nIuWaVKSmgYxorBaiqwnZAmY7G1KvVBc2Ni3QxGwfJhuLdEN10EUAKe2swnmEV
	 W0aR1ALWESt+pqsFlpW8qsWAkSNFHImkFcrwoUenw4n7tSf7E6gT0aeaDcdrmpu2PR
	 bovUf1kqitI4jJuPp74WsRqI3vR9hOh70GvlIIl8wuxOEJh5p0+DlQk7DNaL5n4/pE
	 bD/DglJhieuKy6XneJ5io1WWUgGFEqB1AGk/QEin1xzdK7+oFLjEVR/SG6r3CxgtgL
	 1r813pvFf5kQQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	cuiyangpei@gmail.com,
	xiongping1@xiaomi.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs: handle 'state' file inputs for every sampling interval if possible
Date: Mon,  5 Feb 2024 18:51:58 -0800
Message-Id: <20240206025158.203097-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface need to access kdamond-touching data for some of
kdamond user commands.  It uses ->after_aggregation() kdamond callback
to safely access the data in the case.  It had to use the aggregation
interval callback because that was the only callback that users can
access complete monitoring results.

Since patch series "mm/damon: provide pseudo-moving sum based access
rate", which starts from commit 78fbfb155d20 ("mm/damon/core: define and
use a dedicated function for region access rate update"), DAMON provides
good-to-use quality moitoring results for every sampling interval.  It
aims to help users who need to quickly retrieve the monitoring results.
When the aggregation interval is set too long and therefore waiting for
the aggregation interval can degrade user experience, or when the access
pattern is expected to be significantly changed[1] could be such cases.

However, because DAMON sysfs interface is still handling the commands
per aggregation interval, the end user cannot get the benefit.  Update
DAMON sysfs interface to handle kdamond commands for every sampling
interval if applicable.  Specifically, all kdamond data accessing
commands except 'commit' command are applicable.

[1] https://lore.kernel.org/r/20240129121316.GA9706@cuiyangpei

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 ++
 mm/damon/sysfs-schemes.c | 22 +++++++++-------------
 mm/damon/sysfs.c         | 21 ++++++++++++++++++---
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 4c37a166eb81..ec0703e1e90b 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -49,6 +49,8 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only);
 
+void damos_sysfs_mark_finished_regions_updates(struct damon_ctx *ctx);
+
 bool damos_sysfs_regions_upd_done(void);
 
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index dd2fb5127009..98c6e5376486 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -127,17 +127,17 @@ static const struct kobj_type damon_sysfs_scheme_region_ktype = {
  *
  * Once the tried regions update request is received, the request handling
  * start function (damon_sysfs_scheme_update_regions_start()) sets the status
- * of all schemes as 'idle' again, and register ->before_damos_apply() and
- * ->after_sampling() callbacks.
+ * of all schemes as 'idle' again, and register ->before_damos_apply()
+ * callback.
  *
  * Then, the first followup ->before_damos_apply() callback
  * (damon_sysfs_before_damos_apply()) sets the status 'started'.  The first
- * ->after_sampling() callback (damon_sysfs_after_sampling()) after the call
- * is called only after the scheme is completely applied
- * to the given snapshot.  Hence the callback knows the situation by showing
- * 'started' status, and sets the status as 'finished'.  Then,
- * damon_sysfs_before_damos_apply() understands the situation by showing the
- * 'finished' status and do nothing.
+ * ->after_sampling() or ->after_aggregation() callback
+ *  (damon_sysfs_cmd_request_callback()) after the call is called only after
+ *  the scheme is completely applied to the given snapshot.  Hence the callback
+ *  knows the situation by showing 'started' status, and sets the status as
+ *  'finished'.  Then, damon_sysfs_before_damos_apply() understands the
+ *  situation by showing the 'finished' status and do nothing.
  *
  * If DAMOS is not applied to any region due to any reasons including the
  * access pattern, the watermarks, the quotas, and the filters,
@@ -2118,7 +2118,7 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
  * callback is registered, damon_sysfs_lock should be held to ensure the
  * regions directories exist.
  */
-static int damon_sysfs_after_sampling(struct damon_ctx *ctx)
+void damos_sysfs_mark_finished_regions_updates(struct damon_ctx *ctx)
 {
 	struct damon_sysfs_schemes *sysfs_schemes =
 		damon_sysfs_schemes_for_damos_callback;
@@ -2134,8 +2134,6 @@ static int damon_sysfs_after_sampling(struct damon_ctx *ctx)
 			sysfs_regions->upd_status =
 				DAMOS_TRIED_REGIONS_UPD_FINISHED;
 	}
-
-	return 0;
 }
 
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
@@ -2208,7 +2206,6 @@ int damon_sysfs_schemes_update_regions_start(
 	damos_tried_regions_init_upd_status(sysfs_schemes, ctx);
 	damos_regions_upd_total_bytes_only = total_bytes_only;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
-	ctx->callback.after_sampling = damon_sysfs_after_sampling;
 	return 0;
 }
 
@@ -2237,7 +2234,6 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx)
 {
 	damon_sysfs_schemes_for_damos_callback = NULL;
 	ctx->callback.before_damos_apply = NULL;
-	ctx->callback.after_sampling = NULL;
 	damon_sysfs_schemes_region_idx = 0;
 	return 0;
 }
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1f891e18b4ee..678de97fcc88 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1379,11 +1379,13 @@ static int damon_sysfs_commit_schemes_quota_goals(
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
  * @active:	Whether @c is not deactivated due to watermarks.
+ * @after_aggr:	Whether this is called from after_aggregation() callback.
  *
  * This function is periodically called back from the kdamond thread for @c.
  * Then, it checks if there is a waiting DAMON sysfs request and handles it.
  */
-static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
+static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
+		bool after_aggregation)
 {
 	struct damon_sysfs_kdamond *kdamond;
 	bool total_bytes_only = false;
@@ -1401,6 +1403,8 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 		err = damon_sysfs_upd_schemes_stats(kdamond);
 		break;
 	case DAMON_SYSFS_CMD_COMMIT:
+		if (!after_aggregation)
+			goto out;
 		err = damon_sysfs_commit_input(kdamond);
 		break;
 	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
@@ -1418,6 +1422,7 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 				goto keep_lock_out;
 			}
 		} else {
+			damos_sysfs_mark_finished_regions_updates(c);
 			/*
 			 * Continue regions updating if DAMON is till
 			 * active and the update for all schemes is not
@@ -1450,7 +1455,16 @@ static int damon_sysfs_after_wmarks_check(struct damon_ctx *c)
 	 * after_wmarks_check() is called back while the context is deactivated
 	 * by watermarks.
 	 */
-	return damon_sysfs_cmd_request_callback(c, false);
+	return damon_sysfs_cmd_request_callback(c, false, false);
+}
+
+static int damon_sysfs_after_sampling(struct damon_ctx *c)
+{
+	/*
+	 * after_sampling() is called back only while the context is not
+	 * deactivated by watermarks.
+	 */
+	return damon_sysfs_cmd_request_callback(c, true, false);
 }
 
 static int damon_sysfs_after_aggregation(struct damon_ctx *c)
@@ -1459,7 +1473,7 @@ static int damon_sysfs_after_aggregation(struct damon_ctx *c)
 	 * after_aggregation() is called back only while the context is not
 	 * deactivated by watermarks.
 	 */
-	return damon_sysfs_cmd_request_callback(c, true);
+	return damon_sysfs_cmd_request_callback(c, true, true);
 }
 
 static struct damon_ctx *damon_sysfs_build_ctx(
@@ -1478,6 +1492,7 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 	}
 
 	ctx->callback.after_wmarks_check = damon_sysfs_after_wmarks_check;
+	ctx->callback.after_sampling = damon_sysfs_after_sampling;
 	ctx->callback.after_aggregation = damon_sysfs_after_aggregation;
 	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
-- 
2.39.2


