Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C597BC9AA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbjJGUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:04:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DFBBA;
        Sat,  7 Oct 2023 13:04:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135EC433C7;
        Sat,  7 Oct 2023 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696709077;
        bh=k+E7o4trRwpUVpsgiWw9zd/8lmV+kOwn1CHhDi4J/Yo=;
        h=From:To:Cc:Subject:Date:From;
        b=jblyM3cEtrib/74xHI17sH3ZJytEYYeAjCDJPFD3KBCStlKs9wJ2HGxDFdvarbqFx
         P36i22ZGZM67vyqEdfO9Ad3jx1oaK//GGZA5uBXorrNyJvqkq5qnAKDP3V+ZaLnAh2
         lnmDVYg1qVN84i7cblbu/rhsRCro+/X6M3LTbksmIv1zXohwfC6C2WMYnKpP5LF3nw
         VMkFPEsWGWpg5KxdeWJFzPh8lQX0cgNxP7+f1bOspOyGrTM+fU2vkjw3ycEjAq5AIE
         O7yLzUTUHvd33/7pklmbQ53JP1Ni2pVLHSs0yw0YoLHOV0pPcH2ij2q6ez5KgWvQWF
         JrOsensvDSjTg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/1] mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date:   Sat,  7 Oct 2023 20:04:32 +0000
Message-Id: <20231007200432.3110-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
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

DAMON_SYSFS can receive DAMOS tried regions update request while kdamond
is already out of the main loop and before_terminate callback
(damon_sysfs_before_terminate() in this case) is not yet called.  And
damon_sysfs_handle_cmd() can further be finished before the callback is
invoked.  Then, damon_sysfs_before_terminate() unlocks damon_sysfs_lock,
which is not locked by anyone.  This happens because the callback
function assumes damon_sysfs_cmd_request_callback() should be called
before it.  Check if the assumption was true before doing the unlock, to
avoid this problem.

Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b86ba7b0a921..f60e56150feb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1208,6 +1208,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1219,8 +1221,10 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	cmd = damon_sysfs_cmd_request.cmd;
 	if (kdamond && ctx == kdamond->damon_ctx &&
 			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
-			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES)) {
+			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES) &&
+			damon_sysfs_schemes_regions_updating) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
+		damon_sysfs_schemes_regions_updating = false;
 		mutex_unlock(&damon_sysfs_lock);
 	}
 
@@ -1340,7 +1344,6 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	bool total_bytes_only = false;
 	int err = 0;
 
-- 
2.34.1

