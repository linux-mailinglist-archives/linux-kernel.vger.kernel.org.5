Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DA27DA9A3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjJ1VeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Vd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:33:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD67D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 14:33:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695EDC433C8;
        Sat, 28 Oct 2023 21:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698528835;
        bh=UtSutLXi7E+qkhfIMryx3kSyfkKokutnxEvlL8G6ZwA=;
        h=From:To:Cc:Subject:Date:From;
        b=Cdy6mk5q5CB8HhSyv2aPmAM70gKtHkfpfDCtkkkDC5fX/jw5zKTMfRQkqWBI8O62p
         mFYUccWMuUNF6g0GHPJg6lYG6pOrSfRjULFgYMDlWw15Cn8C7z6BlcA20OweGuuVIP
         Pqzqd77W1wj8VIs+wMymqQGBcg6CfTSnUb4X+rjxB5zJfrSx/OcDCjLbkTAZYRmC+6
         xX4l6nhOz4I7bnSLYwZgIcC65cCoEefsYf6sb9JCzdnviCc5QCwrKPp+WNpVRJuO1L
         ATWP2+fNh7YpUoOr05YRN1dxgFBPlK08idaWzlC0UGftj6jE2iubR6Gg7BJKr/bFDJ
         ERO1Po8Tb/qQg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH mm-hotfixes-unstable] mm/damon/sysfs: fix unnecessary monitoring results removal when online-commit inputs
Date:   Sat, 28 Oct 2023 21:33:53 +0000
Message-Id: <20231028213353.45397-1-sj@kernel.org>
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

Commit db27869df6ed ("mm/damon/sysfs: remove requested targets when
online-commit inputs") of mm-hotfixes-unstable tree[1] makes all targets
to removed and then added again based on the user input, for
online-commit inputs.  The commit says it is inefficient but ok as
below:

    This could cause unnecessary memory dealloc and realloc operations,
    but this is not a hot code path.  Also, note that damon_target is
    stateless, and hence no data is lost

But that's not true.  'struct target' is containing the monitoring
results ('->regions_list').  As a result, the patch makes all previous
monitoring results to be removed for every online-commit inputs.  Fix it
by removing targets only when really changed or removal is requested.

[1] https://lore.kernel.org/damon/20231022210735.46409-2-sj@kernel.org/

Fixes: db27869df6ed ("mm/damon/sysfs: remove requested targets when online-commit inputs") # mm-hotfixes-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Andrew, if you squash this into the original patch, please update the last
paragraph as below.

Fix it by doing in place updates and removals of existing targets as user
requested.  Note that monitoring results (->regions_list) of targets that no
change has requested are maintained.

 mm/damon/sysfs.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d13e353bee52..1a231bde18f9 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1150,23 +1150,57 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
+static int damon_sysfs_update_target(struct damon_target *target,
+		struct damon_ctx *ctx,
+		struct damon_sysfs_target *sys_target)
+{
+	struct pid *pid;
+	struct damon_region *r, *next;
+
+	if (!damon_target_has_pid(ctx))
+		return 0;
+
+	pid = find_get_pid(sys_target->pid);
+	if (!pid)
+		return -EINVAL;
+
+	/* no change to the target */
+	if (pid == target->pid) {
+		put_pid(pid);
+		return 0;
+	}
+
+	/* remove old monitoring results and update the target's pid */
+	damon_for_each_region_safe(r, next, target)
+		damon_destroy_region(r, target);
+	put_pid(target->pid);
+	target->pid = pid;
+	return 0;
+}
+
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
 	struct damon_target *t, *next;
-	int i, err;
+	int i = 0, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
 	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
 		return -EINVAL;
 
 	damon_for_each_target_safe(t, next, ctx) {
-		if (damon_target_has_pid(ctx))
-			put_pid(t->pid);
-		damon_destroy_target(t);
+		if (i < sysfs_targets->nr) {
+			damon_sysfs_update_target(t, ctx,
+					sysfs_targets->targets_arr[i]);
+		} else {
+			if (damon_target_has_pid(ctx))
+				put_pid(t->pid);
+			damon_destroy_target(t);
+		}
+		i++;
 	}
 
-	for (i = 0; i < sysfs_targets->nr; i++) {
+	for (; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *st = sysfs_targets->targets_arr[i];
 
 		err = damon_sysfs_add_target(st, ctx);
-- 
2.34.1

