Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1C77C76A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442163AbjJLTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442125AbjJLTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:23:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C4CC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE49C433CA;
        Thu, 12 Oct 2023 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697138583;
        bh=QB5qYv9xS/UghnI15B6QiEIOnHFLoTKSAq1DXsFnEUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckvz8J9Yk9yDxzg9KFdbIg8oiysIzmG3nZWvtANgPETgNFiEj+Jwe0cSfoYy9C8VT
         ije8QYhAeQxs+qiH8JukkJ4HkgYw8GSevQnoKXmoyyT8rIIM5lBLW2Q/7ZHrCYBpL0
         aeJVN5e3l8nQVGdG3gUyJV1y4IKbmBLx6HALQyiAZ39wM1DS7kAGurtwjq4c9xaS5k
         99u4rx/q559z5Bm3hDKCPpjCvfDL+CrDtS49zR/QyrQmDQl5I4q7q2U2vpHe4Nxfjw
         MdmdJQXRnyCBm+i3VODRnqjhkPP2Lr8Q1eTJuO1AnP/xb7VC0hvCN6wBkFgP1x3pdh
         b7eBiPIW3p9Lw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
Date:   Thu, 12 Oct 2023 19:22:54 +0000
Message-Id: <20231012192256.33556-3-sj@kernel.org>
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

DAMON_SYSFS assumes all schemes will be applied for at least one DAMON
monitoring results snapshot within one aggregation interval, or makes no
sense to wait for it while DAMON is deactivated by the watermarks.  That
for deactivated status still makes sense, but the aggregation interval
based assumption is invalid now because each scheme can has its own
apply interval.  For schemes having larger than the aggregation or
watermarks check interval, DAMOS tried regions update request can be
finished without the update.  Avoid the case by explicitly checking the
status of the schemes tried regions update and watermarks based DAMON
deactivation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 ++
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 mm/damon/sysfs.c         | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index fd482a0639b4..5ff081226e28 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -49,6 +49,8 @@ int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only);
 
+bool damos_sysfs_regions_upd_done(void);
+
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 
 int damon_sysfs_schemes_clear_regions(
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b07a5c544b34..45bd0fd4a8b1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1904,6 +1904,22 @@ int damon_sysfs_schemes_update_regions_start(
 	return 0;
 }
 
+bool damos_sysfs_regions_upd_done(void)
+{
+	struct damon_sysfs_schemes *sysfs_schemes =
+		damon_sysfs_schemes_for_damos_callback;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
+	int i;
+
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
+		if (sysfs_regions->upd_status !=
+				DAMOS_TRIED_REGIONS_UPD_FINISHED)
+			return false;
+	}
+	return true;
+}
+
 /*
  * Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock.  Caller
  * should unlock damon_sysfs_lock which held before
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f60e56150feb..f73dc88d2d19 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1336,12 +1336,13 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
- * @c:	The DAMON context of the callback.
+ * @c:		The DAMON context of the callback.
+ * @active:	Whether @c is not deactivated due to watermarks.
  *
  * This function is periodically called back from the kdamond thread for @c.
  * Then, it checks if there is a waiting DAMON sysfs request and handles it.
  */
-static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
+static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 {
 	struct damon_sysfs_kdamond *kdamond;
 	bool total_bytes_only = false;
@@ -1373,6 +1374,13 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 				goto keep_lock_out;
 			}
 		} else {
+			/*
+			 * Continue regions updating if DAMON is till
+			 * active and the update for all schemes is not
+			 * finished.
+			 */
+			if (active && !damos_sysfs_regions_upd_done())
+				goto keep_lock_out;
 			err = damon_sysfs_upd_schemes_regions_stop(kdamond);
 			damon_sysfs_schemes_regions_updating = false;
 		}
@@ -1392,6 +1400,24 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	return err;
 }
 
+static int damon_sysfs_after_wmarks_check(struct damon_ctx *c)
+{
+	/*
+	 * after_wmarks_check() is called back while the context is deactivated
+	 * by watermarks.
+	 */
+	return damon_sysfs_cmd_request_callback(c, false);
+}
+
+static int damon_sysfs_after_aggregation(struct damon_ctx *c)
+{
+	/*
+	 * after_aggregation() is called back only while the context is not
+	 * deactivated by watermarks.
+	 */
+	return damon_sysfs_cmd_request_callback(c, true);
+}
+
 static struct damon_ctx *damon_sysfs_build_ctx(
 		struct damon_sysfs_context *sys_ctx)
 {
@@ -1407,8 +1433,8 @@ static struct damon_ctx *damon_sysfs_build_ctx(
 		return ERR_PTR(err);
 	}
 
-	ctx->callback.after_wmarks_check = damon_sysfs_cmd_request_callback;
-	ctx->callback.after_aggregation = damon_sysfs_cmd_request_callback;
+	ctx->callback.after_wmarks_check = damon_sysfs_after_wmarks_check;
+	ctx->callback.after_aggregation = damon_sysfs_after_aggregation;
 	ctx->callback.before_terminate = damon_sysfs_before_terminate;
 	return ctx;
 }
-- 
2.34.1

