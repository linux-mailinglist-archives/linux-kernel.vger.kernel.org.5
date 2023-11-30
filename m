Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628A77FE6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjK3Chh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjK3Ch3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:37:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE381BC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D64C433D9;
        Thu, 30 Nov 2023 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311821;
        bh=FMojcAP5QPRX+4T1uzEuLlR/gen6p9qPd+B5RLedtWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcLL9P8+Oy7ltVM5DiR3gFU7QyJ4fcHcQUswFA5l9LkcNpPDLaI9QY14RyNitoWB1
         AteHwdn9YvdZ3w6aJFgIy5DjiYi/B2H31eUsy/Gx1qdvsRKrF9qTYj/yLx5IUHKFjz
         ajMFnvqGe1TlsBdByvYwU2OHu8YSc0XRyCV0IoDpkGiY8KEdMRVVMzf+65jIALOfcJ
         XeHnYD6l5pqPhPA1It6KvoYEilCMZ9ixhpVE2VS+POXVvhPTdYGBTWkDQgdVkXk4w8
         ZkJuTZNLXXSx7dJyny7Jrr0324rZWw/DA1/74PZpGrXp85Et4yYCRJLm3rIBo/pSOs
         G3u542rHiHFWg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS
Date:   Thu, 30 Nov 2023 02:36:46 +0000
Message-Id: <20231130023652.50284-4-sj@kernel.org>
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

Make DAMON sysfs interface to read the user inputs for DAMOS quota goals
and pass those to DAMOS, so that the users can use the quota auto-tuning
feature.  It uses the DAMON sysfs interface's user input commit
mechanism, which applies all user inputs for initial starting of DAMON
and online input updates, which can be done by writing 'on' and 'commit'
to the kdamond's 'state' file, respectively.  In other words, the user
should periodically write appropriate value to 'current_value' files and
'commit' command to the 'state' file.  'target_value' files could also
be similarly updated at any time.

Note that the interface is supporting multiple goals while the core
logic supports only one goal.  DAMON sysfs interface passes only best
feedback among the given inputs, to avoid making DAMOS too aggressive.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e5531dbd4cf1..a7917534ca19 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1868,6 +1868,34 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 	return 0;
 }
 
+static unsigned long damos_sysfs_get_quota_score(void *arg)
+{
+	return (unsigned long)arg;
+}
+
+static void damos_sysfs_set_quota_score(
+		struct damos_sysfs_quota_goals *sysfs_goals,
+		struct damos_quota *quota)
+{
+	struct damos_sysfs_quota_goal *sysfs_goal;
+	int i;
+
+	quota->get_score = NULL;
+	quota->get_score_arg = (void *)0;
+	for (i = 0; i < sysfs_goals->nr; i++) {
+		sysfs_goal = sysfs_goals->goals_arr[i];
+		if (!sysfs_goal->target_value)
+			continue;
+
+		/* Higher score makes scheme less aggressive */
+		quota->get_score_arg = (void *)max(
+				(unsigned long)quota->get_score_arg,
+				sysfs_goal->current_value * 10000 /
+				sysfs_goal->target_value);
+		quota->get_score = damos_sysfs_get_quota_score;
+	}
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -1905,6 +1933,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
+	damos_sysfs_set_quota_score(sysfs_quotas->goals, &quota);
+
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
 			sysfs_scheme->apply_interval_us, &quota, &wmarks);
 	if (!scheme)
@@ -1945,6 +1975,8 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->quota.weight_nr_accesses = sysfs_weights->nr_accesses;
 	scheme->quota.weight_age = sysfs_weights->age;
 
+	damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
+
 	scheme->wmarks.metric = sysfs_wmarks->metric;
 	scheme->wmarks.interval = sysfs_wmarks->interval_us;
 	scheme->wmarks.high = sysfs_wmarks->high;
-- 
2.34.1

