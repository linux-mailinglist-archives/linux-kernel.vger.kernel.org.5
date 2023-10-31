Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF77DD3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJaRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjJaRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:01:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544C3263;
        Tue, 31 Oct 2023 10:01:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAFCC433C9;
        Tue, 31 Oct 2023 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698771696;
        bh=wOrkJgpCxsbVKesxU40XQnRtmpfI/QSBorN3wky9v9k=;
        h=From:To:Cc:Subject:Date:From;
        b=oA2bxILiwPXYgcaZ+u2F0ndZdS8Mj5u+NZ0vIcsMQCN8tM0Bgpvq4VACcB5ywH5pp
         sRhdOLf8SYvj6MTNGPxbKT34E5omwfKBdp/E9yJ0L+gZ3PkNY4fe2LlMCWvPq0BDxn
         1CBaw+/5MNi1txr9wB3QiMj89kgTO3Lk8nQHJBXDfr9zj4h5xvxYuzRFv816a+7HbO
         hKjzCLq1NfmwjhOaSCLfwhhqoseYEAObM68kxZNCFK65dirP5Ovv8/LudtMhmMu2lX
         mN8ng4O75AU6v+FqQWR1XpNCKHlbJZCtPGJ80Ptz3QlJaw2ccwYzPRJmT0jkVXdXQZ
         vJTf2TELDTMJw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs: update monitoring target regions for online input commit
Date:   Tue, 31 Oct 2023 17:01:31 +0000
Message-Id: <20231031170131.46972-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user input is committed online, DAMON sysfs interface is ignoring
the user input for the monitoring target regions.  Such request is valid
and useful for fixed monitoring target regions-based monitoring ops like
'paddr' or 'fvaddr'.

Update the region boundaries as user specified, too.  Note that the
monitoring results of the regions that overlap between the latest
monitoring target regions and the new target regions are preserved.

Treat empty monitoring target regions user request as a request to just
make no change to the monitoring target regions.  Otherwise, users
should set the monitoring target regions same to current one for every
online input commit, and it could be challenging for dynamic monitoring
target regions update DAMON ops like 'vaddr'.  If the user really need
to remove all monitoring target regions, they can simply remove the
target and then create the target again with empty target regions.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1a231bde18f9..e27846708b5a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1150,34 +1150,47 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
-static int damon_sysfs_update_target(struct damon_target *target,
-		struct damon_ctx *ctx,
-		struct damon_sysfs_target *sys_target)
+static int damon_sysfs_update_target_pid(struct damon_target *target, int pid)
 {
-	struct pid *pid;
-	struct damon_region *r, *next;
-
-	if (!damon_target_has_pid(ctx))
-		return 0;
+	struct pid *pid_new;
 
-	pid = find_get_pid(sys_target->pid);
-	if (!pid)
+	pid_new = find_get_pid(pid);
+	if (!pid_new)
 		return -EINVAL;
 
-	/* no change to the target */
-	if (pid == target->pid) {
-		put_pid(pid);
+	if (pid_new == target->pid) {
+		put_pid(pid_new);
 		return 0;
 	}
 
-	/* remove old monitoring results and update the target's pid */
-	damon_for_each_region_safe(r, next, target)
-		damon_destroy_region(r, target);
 	put_pid(target->pid);
-	target->pid = pid;
+	target->pid = pid_new;
 	return 0;
 }
 
+static int damon_sysfs_update_target(struct damon_target *target,
+		struct damon_ctx *ctx,
+		struct damon_sysfs_target *sys_target)
+{
+	int err;
+
+	if (damon_target_has_pid(ctx)) {
+		err = damon_sysfs_update_target_pid(target, sys_target->pid);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Do monitoring target region boundary update only if one or more
+	 * regions are set by the user.  This is for keeping current monitoring
+	 * target results and range easier, especially for dynamic monitoring
+	 * target regions update ops like 'vaddr'.
+	 */
+	if (sys_target->regions->nr)
+		err = damon_sysfs_set_regions(target, sys_target->regions);
+	return err;
+}
+
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
-- 
2.34.1

