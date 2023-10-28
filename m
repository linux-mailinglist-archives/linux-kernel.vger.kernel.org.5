Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B37DA9A6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjJ1Vjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Vjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:39:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D99CF;
        Sat, 28 Oct 2023 14:39:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA845C433C7;
        Sat, 28 Oct 2023 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698529182;
        bh=YFw3MuSD8O4HGkh6VW7jNYSusxafWxc4LG1WG2XEIak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsad3ncuTFb6Blb8uETRa8p2CrI/WfNNLFwR0mZNxGykNUbSS+QvH+riGsKiA/N4I
         pgDnA9qEyefcQjn3Y0aQoGoCKbzFfDsXFieWDkz/Zt1M8OXnvPGQkcs22EmMFpqCAl
         kEMUvhZXBWtWtl2qhcN0Txqab/AHdTar1m12mJFoOisu3sMJhKabSsPB9tLfTfNpP5
         H+592qZf/CrUEm3ogVWHSOZl/r55BRqd/GGqawbIZ78Qd/ls7VwZlwAWwCwwLeyUoJ
         I6deb0IxPsc6gyH9W1WzehsLUoE3B3eJq1vGy3O+3RSbYaXgpu1dW1a1V0y5heXOt4
         CPfozpxbJi8tw==
From:   SeongJae Park <sj@kernel.org>
To:     stable@vger.kernel.org
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 6.5.y] mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date:   Sat, 28 Oct 2023 21:39:36 +0000
Message-Id: <20231028213936.45621-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102716-prudishly-reggae-1b29@gregkh>
References: 
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
which is not locked by anyone.  This happens because the callback function
assumes damon_sysfs_cmd_request_callback() should be called before it.
Check if the assumption was true before doing the unlock, to avoid this
problem.

Link: https://lkml.kernel.org/r/20231007200432.3110-1-sj@kernel.org
Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.2.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 76b7069bcc89dec33f03eb08abee165d0306b754)
---

I sent this patch yesterday, but seems not archived in lore.kernel.org.
Sending again Cc-ing more mailing lists, to ensure it is sent and others can
find it, to avoid any duplicated works.

 mm/damon/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 33e1d5c9cb54..df165820c605 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1202,6 +1202,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1209,10 +1211,12 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 
 	/* damon_sysfs_schemes_update_regions_stop() might not yet called */
 	kdamond = damon_sysfs_cmd_request.kdamond;
-	if (kdamond && damon_sysfs_cmd_request.cmd ==
+	if (kdamond && (damon_sysfs_cmd_request.cmd ==
 			DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS &&
+			damon_sysfs_schemes_regions_updating) &&
 			ctx == kdamond->damon_ctx) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
+		damon_sysfs_schemes_regions_updating = false;
 		mutex_unlock(&damon_sysfs_lock);
 	}
 
@@ -1331,7 +1335,6 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	int err = 0;
 
 	/* avoid deadlock due to concurrent state_store('off') */
-- 
2.34.1
