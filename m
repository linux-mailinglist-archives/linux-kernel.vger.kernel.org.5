Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DC47676E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjG1USe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjG1US2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6444487
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4E6621FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 20:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D019C433CB;
        Fri, 28 Jul 2023 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575506;
        bh=8j2+FNiZI8rNwlWT1Owk5tX0jfkbTMQHhOcdlB3rG8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtAzWRIf66KYbWmItbkVHlcngdgrqWJ6LlxXFcSH7JGfJ6rIgHmKBYZ7kRMu+/P14
         txNVbLhn18kP7h/FruOB4BNzfTaRfdyxQfDzvotC0eQeA2xrfIAtuem17mVWLTFMV7
         /4+wDQRTlL/JnV+uwEEqUkCAibVt1zSI78urjrJZZL7sPsLxC/DODW1BV37+ENcbPe
         F0B6CBl+QuMyHArXvm3w2EnWyl4kiIeKnMPzJuhkM/38MymeAnA5y8qF5bBqsl8Rrs
         Txxdl1ZJLnrUiq/iXAFgsLYphZYiKB7NtVm9ywfrDpnzz1OuifdU+0NdBSVGALVPyF
         Ii4l+Fdf7G2nw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] mm/damon/sysfs: implement a command for updating only schemes tried total bytes
Date:   Fri, 28 Jul 2023 20:18:14 +0000
Message-Id: <20230728201817.70602-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728201817.70602-1-sj@kernel.org>
References: <20230728201817.70602-1-sj@kernel.org>
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

Using tried_regions/total_bytes file, users can efficiently retrieve the
total size of memory regions having specific access pattern.  However,
DAMON sysfs interface in kernel still populates all the infomration on
the tried_regions subdirectories.  That means the kernel part overhead
for the construction of tried regions directories still exists.  To
remove the overhead, implement yet another command input for 'state'
DAMON sysfs file.  Writing the input to the file makes DAMON sysfs
interface to update only the total_bytes file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 +-
 mm/damon/sysfs-schemes.c |  7 ++++++-
 mm/damon/sysfs.c         | 26 ++++++++++++++++++++------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index db677eba78fd..fd482a0639b4 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -47,7 +47,7 @@ void damon_sysfs_schemes_update_stats(
 
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx);
+		struct damon_ctx *ctx, bool total_bytes_only);
 
 int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6d3462eb31f2..9a015079f3a4 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1635,6 +1635,7 @@ void damon_sysfs_schemes_update_stats(
  */
 static struct damon_sysfs_schemes *damon_sysfs_schemes_for_damos_callback;
 static int damon_sysfs_schemes_region_idx;
+static bool damos_regions_upd_total_bytes_only;
 
 /*
  * DAMON callback that called before damos apply.  While this callback is
@@ -1664,6 +1665,9 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 
 	sysfs_regions = sysfs_schemes->schemes_arr[schemes_idx]->tried_regions;
 	sysfs_regions->total_bytes += r->ar.end - r->ar.start;
+	if (damos_regions_upd_total_bytes_only)
+		return 0;
+
 	region = damon_sysfs_scheme_region_alloc(r);
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
@@ -1702,10 +1706,11 @@ int damon_sysfs_schemes_clear_regions(
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
-		struct damon_ctx *ctx)
+		struct damon_ctx *ctx, bool total_bytes_only)
 {
 	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
+	damos_regions_upd_total_bytes_only = total_bytes_only;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
 	return 0;
 }
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 533d06052c09..808a8efe0523 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -999,6 +999,11 @@ enum damon_sysfs_cmd {
 	 * files.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES: Update
+	 * tried_regions/total_bytes sysfs files for each scheme.
+	 */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS: Update schemes tried
 	 * regions
@@ -1021,6 +1026,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"off",
 	"commit",
 	"update_schemes_stats",
+	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
 	"clear_schemes_tried_regions",
 };
@@ -1206,12 +1212,14 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 	struct damon_sysfs_kdamond *kdamond;
+	enum damon_sysfs_cmd cmd;
 
 	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
 	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (kdamond && damon_sysfs_cmd_request.cmd ==
-			DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS &&
-			ctx == kdamond->damon_ctx) {
+	cmd = damon_sysfs_cmd_request.cmd;
+	if (kdamond && ctx == kdamond->damon_ctx &&
+			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
+			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES)) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
 		mutex_unlock(&damon_sysfs_lock);
 	}
@@ -1248,14 +1256,15 @@ static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
 }
 
 static int damon_sysfs_upd_schemes_regions_start(
-		struct damon_sysfs_kdamond *kdamond)
+		struct damon_sysfs_kdamond *kdamond, bool total_bytes_only)
 {
 	struct damon_ctx *ctx = kdamond->damon_ctx;
 
 	if (!ctx)
 		return -EINVAL;
 	return damon_sysfs_schemes_update_regions_start(
-			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+			kdamond->contexts->contexts_arr[0]->schemes, ctx,
+			total_bytes_only);
 }
 
 static int damon_sysfs_upd_schemes_regions_stop(
@@ -1332,6 +1341,7 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
 	static bool damon_sysfs_schemes_regions_updating;
+	bool total_bytes_only = false;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */
@@ -1348,9 +1358,13 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
+		total_bytes_only = true;
+		fallthrough;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
 		if (!damon_sysfs_schemes_regions_updating) {
-			err = damon_sysfs_upd_schemes_regions_start(kdamond);
+			err = damon_sysfs_upd_schemes_regions_start(kdamond,
+					total_bytes_only);
 			if (!err) {
 				damon_sysfs_schemes_regions_updating = true;
 				goto keep_lock_out;
-- 
2.25.1

