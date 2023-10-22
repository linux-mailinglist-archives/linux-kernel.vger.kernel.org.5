Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7D7D260C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjJVVHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJVVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:07:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11688E9;
        Sun, 22 Oct 2023 14:07:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD1C433CA;
        Sun, 22 Oct 2023 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698008860;
        bh=yOdMqP6KZLl0RBsnjmhN2cj6fhQSH3cbP76PBzRCOAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnueFOFQ6TdfQk/iuPOF/OFgmETyKyueN3Q8xtoB6EEMbxvxVHfON+yY3CJBuKIRg
         f1yY9C/RuQcxMRhpnmwPmKVJUrrynqKh1TIniakjnBDBebuy6nXz+TWubn1wXJd8Ri
         010+bl5UYfpbCkevNZLOml+RapqIGvkwqzz3lxyAuuzj2AkffQe+/Rs6lpFqe1g/4y
         vz4FyTcuIiHO78oGe60UG78FqYJFRUiZgnxU8cZURkIctRznFCXHqveGG5bFPIjO9+
         4bX43pRwyubtaSVX4tcbeKdOl2Tu5t2E9xGZMEzJx4bTe0+pC+JyvjamJC/usJ0bld
         D7ogbirT/qmAg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/sysfs: remove requested targets when online-commit inputs
Date:   Sun, 22 Oct 2023 21:07:33 +0000
Message-Id: <20231022210735.46409-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022210735.46409-1-sj@kernel.org>
References: <20231022210735.46409-1-sj@kernel.org>
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

damon_sysfs_set_targets(), which updates the targets of the context for
online commitment, do not remove targets that removed from the
corresponding sysfs files.  As a result, more than intended targets of
the context can exist and hence consume memory and monitoring CPU
resource more than expected.

Fix it by removing all targets of the context and fill up again using
the user input.  This could cause unnecessary memory dealloc and realloc
operations, but this is not a hot code path.  Also, note that
damon_target is stateless, and hence no data is lost.

Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 50 +++++++++---------------------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f73dc88d2d19..5268e8503722 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1150,58 +1150,26 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
-/*
- * Search a target in a context that corresponds to the sysfs target input.
- *
- * Return: pointer to the target if found, NULL if not found, or negative
- * error code if the search failed.
- */
-static struct damon_target *damon_sysfs_existing_target(
-		struct damon_sysfs_target *sys_target, struct damon_ctx *ctx)
-{
-	struct pid *pid;
-	struct damon_target *t;
-
-	if (!damon_target_has_pid(ctx)) {
-		/* Up to only one target for paddr could exist */
-		damon_for_each_target(t, ctx)
-			return t;
-		return NULL;
-	}
-
-	/* ops.id should be DAMON_OPS_VADDR or DAMON_OPS_FVADDR */
-	pid = find_get_pid(sys_target->pid);
-	if (!pid)
-		return ERR_PTR(-EINVAL);
-	damon_for_each_target(t, ctx) {
-		if (t->pid == pid) {
-			put_pid(pid);
-			return t;
-		}
-	}
-	put_pid(pid);
-	return NULL;
-}
-
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
+	struct damon_target *t, *next;
 	int i, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
 	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
 		return -EINVAL;
 
+	damon_for_each_target_safe(t, next, ctx) {
+		if (damon_target_has_pid(ctx))
+			put_pid(t->pid);
+		damon_destroy_target(t);
+	}
+
 	for (i = 0; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *st = sysfs_targets->targets_arr[i];
-		struct damon_target *t = damon_sysfs_existing_target(st, ctx);
-
-		if (IS_ERR(t))
-			return PTR_ERR(t);
-		if (!t)
-			err = damon_sysfs_add_target(st, ctx);
-		else
-			err = damon_sysfs_set_regions(t, st->regions);
+
+		err = damon_sysfs_add_target(st, ctx);
 		if (err)
 			return err;
 	}
-- 
2.34.1

