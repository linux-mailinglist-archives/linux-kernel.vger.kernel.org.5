Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D47E9258
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjKLTqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjKLTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0F2583
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F23C43391;
        Sun, 12 Nov 2023 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818374;
        bh=MxtUx51tOzqutV8xiuFATacKMvsWPmbxLxD9xhq6D0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ElglL7CM8DTNUMvs6zpbU98dLV/xAZSfMCOCe74EzCDQx13WqQ2sun5Eop+Vu1JlN
         5aqCvIxzUfxRmaWDjsoSi05967P4ozWuGPaX8Yt6ko7ElRPUiyRe5gRfJekha2/nU+
         FQIp8l43A/Mbx0w9H9Mc31haTzjOTEEl9q7T7+lryokZBn92fl6IFKRpaGZC38znwQ
         cW/R7dvdzCCnxPfKmKDMIQvdnOEshOxgT9y29zMJqwpAu4PVZfc01AkZ9a11sAmllC
         p7YuBzxb9uPB6URkcXhop5z84lhTVq7K7IepbaqAEBSB/Usb0KHEsYkG41nfXAXCKa
         dlPydUs9fyzOg==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS quota auto-tuning
Date:   Sun, 12 Nov 2023 19:46:02 +0000
Message-Id: <20231112194607.61399-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make DAMON sysfs interface to read the DAMOS quota goals user input and
pass it to DAMOS so that the input can be used for the quota
auto-tuning.  The committing is made for initial starting of DAMON, and
online input updates that can be done via 'commit' input to the
kdamond's 'state' file.  That is, the user should periodically write
'current_value' files under goal directories and write 'commit' command
to the 'state' file.

Note that the interface is supporting multiple goals while the core
logic supports only one goal.  DAMON sysfs interface passes only best
feedback among the given inputs, to avoid making DAMOS too aggressive.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d3b57348f07b..10d8678e48ea 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1860,6 +1860,34 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
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
@@ -1897,6 +1925,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
+	damos_sysfs_set_quota_score(sysfs_quotas->goals, &quota);
+
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
 			sysfs_scheme->apply_interval_us, &quota, &wmarks);
 	if (!scheme)
@@ -1937,6 +1967,8 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->quota.weight_nr_accesses = sysfs_weights->nr_accesses;
 	scheme->quota.weight_age = sysfs_weights->age;
 
+	damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
+
 	scheme->wmarks.metric = sysfs_wmarks->metric;
 	scheme->wmarks.interval = sysfs_wmarks->interval_us;
 	scheme->wmarks.high = sysfs_wmarks->high;
-- 
2.34.1

