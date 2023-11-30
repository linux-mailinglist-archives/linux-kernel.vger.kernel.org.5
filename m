Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD17FE6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbjK3Chj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjK3Cha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:37:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A600426AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DC3C433CA;
        Thu, 30 Nov 2023 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311821;
        bh=tJsPu7JQL87ujr48iV6g/qqgx0+zpDp/3dR6mROKAm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBI5+n2+V0t7rY8iy3M9ZVdx0RLjzFwHuSY3nqWmWEr0rvrsO6aGZV+nYSuouZPVz
         mwb6Br2qeEj8e9VML8YdE7tUypRSZH1kRBXFlfZs3zLt6mmdm1Dbh+Zwi2b2f77t4K
         yvPJ5JXkTrmDH1EzY65pLmcf8nf9IGVJgfJN24PQjv55KlGlu0jn+zPa90Z2EjCSn8
         bSvLyjqGIYbJB9IT9Dgh5sKsYCmtgdyEVhFp9fU64Ef8/BDhMxtg3sK6ru3Bp3enRI
         qhoetCAmq/iA9ycYb35mK/9bd5aCVgiFQWvWXVlfPvwlpm0b5x0ElXLFovDZXzZ32p
         qhhOB4SsqbO7Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mm/damon/sysfs-schemes: implement a command for scheme quota goals only commit
Date:   Thu, 30 Nov 2023 02:36:47 +0000
Message-Id: <20231130023652.50284-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To update DAMOS quota goals, users need to enter 'commit' command to the
'state' file of the kdamond, which applies not only the goals but entire
inputs.  It is inefficient.  Implement yet another 'state' file input
command for reading and committing only the scheme quota goals, namely
'commit_schemes_quota_goals'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  3 +++
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 mm/damon/sysfs.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 5ff081226e28..4c37a166eb81 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -56,3 +56,6 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index a7917534ca19..8dbaac6e5c2d 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1896,6 +1896,22 @@ static void damos_sysfs_set_quota_score(
 	}
 }
 
+void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int i = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_scheme *sysfs_scheme;
+
+		sysfs_scheme = sysfs_schemes->schemes_arr[i];
+		damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
+				&scheme->quota);
+		i++;
+	}
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7472404456aa..1f891e18b4ee 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -994,6 +994,11 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_OFF,
 	/* @DAMON_SYSFS_CMD_COMMIT: Update kdamond inputs. */
 	DAMON_SYSFS_CMD_COMMIT,
+	/*
+	 * @DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS: Commit the quota goals
+	 * to DAMON.
+	 */
+	DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1025,6 +1030,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"on",
 	"off",
 	"commit",
+	"commit_schemes_quota_goals",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1351,6 +1357,24 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 			kdamond->contexts->contexts_arr[0]);
 }
 
+static int damon_sysfs_commit_schemes_quota_goals(
+		struct damon_sysfs_kdamond *sysfs_kdamond)
+{
+	struct damon_ctx *ctx;
+	struct damon_sysfs_context *sysfs_ctx;
+
+	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (sysfs_kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	ctx = sysfs_kdamond->damon_ctx;
+	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
+	damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
+	return 0;
+}
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
@@ -1379,6 +1403,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
+		err = damon_sysfs_commit_schemes_quota_goals(kdamond);
+		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
 		total_bytes_only = true;
 		fallthrough;
-- 
2.34.1

