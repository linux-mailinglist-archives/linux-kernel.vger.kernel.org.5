Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038627F8589
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjKXVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjKXVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:38:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABDD60
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:38:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD367C433C8;
        Fri, 24 Nov 2023 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700861923;
        bh=ptjkAte1QXNuW1BDKm99u+0k/U6sLZF2tFKHqkC6btM=;
        h=From:To:Cc:Subject:Date:From;
        b=WAWCwNsY1fMaMcr302PWbuf4doJ/cZNDDR46mMRellmvcqfw+AE1fBzUM+XKP6w/W
         ZTEckTXLa3jzw433vrk0ZUlXvUeOkH/CPYzyh5vb8chikffbn3v6+6Nx5SVVol9/AP
         ag9lC0u5aCFRoq8B8xkjd6BEaU6udnSrYJEZw+szeuWXzkcmf4AOwVbF87rODMKuXh
         H2HOlG2sZxp6+hgg8qkunGc7zQUlq+R5KeYEWWRyVITNe8SNeXMPpYGDAuy2BYaggl
         0d0aeVp2TRE2toLmluzDNm+GUz05Ymczjp4ozq/TWMpMD1U0aRX15nA7ZG3UDc94j2
         +FLkltKFRLS0w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs-schemes: add timeout for update_schemes_tried_regions
Date:   Fri, 24 Nov 2023 21:38:40 +0000
Message-Id: <20231124213840.39157-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
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

If a scheme is set to not applied to any monitoring target region for
any reasons including the target access pattern, quota, filters, or
watermarks, writing 'update_schemes_tried_regions' to 'state' DAMON
sysfs file can indefinitely hang.  Fix the case by implementing a
timeout for the operation.  The time limit is two apply intervals of
each scheme.

Fixes: 4d4e41b68299 ("mm/damon/sysfs-schemes: do not update tried regions more than one DAMON snapshot")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
The commit that fixed by this patch is merged in v6.7-rc1.  Hence not Cc-ing
stable@, but this patch would better to be treated as a hotfix that will be
merged in the mainline before the v6.7 release.

 mm/damon/sysfs-schemes.c | 49 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index be667236b8e6..fe0fe2562000 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -139,6 +139,13 @@ static const struct kobj_type damon_sysfs_scheme_region_ktype = {
  * damon_sysfs_before_damos_apply() understands the situation by showing the
  * 'finished' status and do nothing.
  *
+ * If DAMOS is not applied to any region due to any reasons including the
+ * access pattern, the watermarks, the quotas, and the filters,
+ * ->before_damos_apply() will not be called back.  Until the situation is
+ * changed, the update will not be finished.  To avoid this,
+ * damon_sysfs_after_sampling() set the status as 'finished' if more than two
+ * apply intervals of the scheme is passed while the state is 'idle'.
+ *
  *  Finally, the tried regions request handling finisher function
  *  (damon_sysfs_schemes_update_regions_stop()) unregisters the callbacks.
  */
@@ -154,6 +161,7 @@ struct damon_sysfs_scheme_regions {
 	int nr_regions;
 	unsigned long total_bytes;
 	enum damos_sysfs_regions_upd_status upd_status;
+	unsigned long upd_timeout_jiffies;
 };
 
 static struct damon_sysfs_scheme_regions *
@@ -1854,7 +1862,9 @@ static int damon_sysfs_after_sampling(struct damon_ctx *ctx)
 	for (i = 0; i < sysfs_schemes->nr; i++) {
 		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
 		if (sysfs_regions->upd_status ==
-				DAMOS_TRIED_REGIONS_UPD_STARTED)
+				DAMOS_TRIED_REGIONS_UPD_STARTED ||
+				time_after(jiffies,
+					sysfs_regions->upd_timeout_jiffies))
 			sysfs_regions->upd_status =
 				DAMOS_TRIED_REGIONS_UPD_FINISHED;
 	}
@@ -1885,14 +1895,41 @@ int damon_sysfs_schemes_clear_regions(
 	return 0;
 }
 
+static struct damos *damos_sysfs_nth_scheme(int n, struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int i = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		if (i == n)
+			return scheme;
+		i++;
+	}
+	return NULL;
+}
+
 static void damos_tried_regions_init_upd_status(
-		struct damon_sysfs_schemes *sysfs_schemes)
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
 {
 	int i;
+	struct damos *scheme;
+	struct damon_sysfs_scheme_regions *sysfs_regions;
 
-	for (i = 0; i < sysfs_schemes->nr; i++)
-		sysfs_schemes->schemes_arr[i]->tried_regions->upd_status =
-			DAMOS_TRIED_REGIONS_UPD_IDLE;
+	for (i = 0; i < sysfs_schemes->nr; i++) {
+		sysfs_regions = sysfs_schemes->schemes_arr[i]->tried_regions;
+		scheme = damos_sysfs_nth_scheme(i, ctx);
+		if (!scheme) {
+			sysfs_regions->upd_status =
+				DAMOS_TRIED_REGIONS_UPD_FINISHED;
+			continue;
+		}
+		sysfs_regions->upd_status = DAMOS_TRIED_REGIONS_UPD_IDLE;
+		sysfs_regions->upd_timeout_jiffies = jiffies +
+			2 * usecs_to_jiffies(scheme->apply_interval_us ?
+					scheme->apply_interval_us :
+					ctx->attrs.sample_interval);
+	}
 }
 
 /* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
@@ -1902,7 +1939,7 @@ int damon_sysfs_schemes_update_regions_start(
 {
 	damon_sysfs_schemes_clear_regions(sysfs_schemes, ctx);
 	damon_sysfs_schemes_for_damos_callback = sysfs_schemes;
-	damos_tried_regions_init_upd_status(sysfs_schemes);
+	damos_tried_regions_init_upd_status(sysfs_schemes, ctx);
 	damos_regions_upd_total_bytes_only = total_bytes_only;
 	ctx->callback.before_damos_apply = damon_sysfs_before_damos_apply;
 	ctx->callback.after_sampling = damon_sysfs_after_sampling;
-- 
2.34.1

