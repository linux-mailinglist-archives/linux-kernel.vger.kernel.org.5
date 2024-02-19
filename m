Return-Path: <linux-kernel+bounces-71890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2885AC39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E87F282765
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDD5674F;
	Mon, 19 Feb 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMJk4oti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760755798;
	Mon, 19 Feb 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371884; cv=none; b=cpcw+c4TrVKsSHfhz/D7BxmedTMJEBdxGZasIYrmhhrSYGz9q6D74eH+iNsaFwDaIIT3jwLwYZCBKVKWPNnjeGnxjdcvDPLGr746IrK6LRc8x9GZ2WDwZeGCaUhbl+y5V/vMMSKduJ+Crpw3U5m3QXQduI72LXZXlsZbRObESyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371884; c=relaxed/simple;
	bh=Y86PEzdDsloDNtE2rhRk0igx3/ADGu50K3PYFIjUmww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rl2EADUsMIYepAGVmG0lxYWfbEM7t3+dUie2baR/Kf+/hF6a0/R5HlkRhTD3BkrgfIcxqAZO7RHHIxA0rUYKo2ywpgx0wM5ds7/FClPvfVkngPTEmxKuAtWG9Tzm8hrIoETl4TcwFE2b2k8GpiCoNtLIwVqgd3bcVcPswot6dN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMJk4oti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37B9C43390;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371884;
	bh=Y86PEzdDsloDNtE2rhRk0igx3/ADGu50K3PYFIjUmww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMJk4otiuaR09DUh0+iezb8GZovrgKQlfCvrQ1tTjXsAlaxptT+OfVNaBmfkIbFrW
	 CI4FSuRWy5qz0EKsYf3eEMo6zk3Zzi/Al2auGEqa/LLZKRcQkPQoZP1hos61FPiNL2
	 vmEX1DzJ9t4QhST25LMDbcl3LncVzCNUJfrrRwOqMnU5OvkRHLOH71Oi5dc1JKyjyu
	 x5EHaMvyUIkvAuov3A9Qf4lqMmG5NdF9QZOYZYQdEmUZOt0dgra/nCF6MAbbX/hgUF
	 4kRTvUeVZHjdlNPLNnOCC2xg1aUGBPNDiBaxwrQG3uN5cvGnGDZ8a9mWrp7sunheBU
	 9LxMizAj+NVLg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] mm/damon/sysfs: use only quota->goals
Date: Mon, 19 Feb 2024 11:44:20 -0800
Message-Id: <20240219194431.159606-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219194431.159606-1-sj@kernel.org>
References: <20240219194431.159606-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface implements multiple quota auto-tuning goals on its
level since the DAMOS core logic was supporting only single goal.  Now
the core logic supports multiple goals on its level.  Update DAMON sysfs
interface to reuse the core logic and drop unnecessary duplicated
multiple goals implementation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  2 +-
 mm/damon/sysfs-schemes.c | 49 +++++++++++++++++++++++++++-------------
 mm/damon/sysfs.c         |  3 +--
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 5a1ac15fb2f8..a63f51577cff 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -59,7 +59,7 @@ int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
 
-void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
 
 void damos_sysfs_update_effective_quotas(
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 85ef58f98a87..7bf94b1ed6f7 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1887,30 +1887,34 @@ static unsigned long damos_sysfs_get_quota_score(void *arg)
 	return (unsigned long)arg;
 }
 
-static void damos_sysfs_set_quota_score(
+static int damos_sysfs_set_quota_score(
 		struct damos_sysfs_quota_goals *sysfs_goals,
 		struct damos_quota *quota)
 {
-	struct damos_sysfs_quota_goal *sysfs_goal;
+	struct damos_quota_goal *goal, *next;
 	int i;
 
-	quota->goal.get_score = NULL;
-	quota->goal.get_score_arg = (void *)0;
+	damos_for_each_quota_goal_safe(goal, next, quota)
+		damos_destroy_quota_goal(goal);
+
 	for (i = 0; i < sysfs_goals->nr; i++) {
-		sysfs_goal = sysfs_goals->goals_arr[i];
+		struct damos_sysfs_quota_goal *sysfs_goal =
+			sysfs_goals->goals_arr[i];
+
 		if (!sysfs_goal->target_value)
 			continue;
 
-		/* Higher score makes scheme less aggressive */
-		quota->goal.get_score_arg = (void *)max(
-				(unsigned long)quota->goal.get_score_arg,
-				sysfs_goal->current_value * 10000 /
-				sysfs_goal->target_value);
-		quota->goal.get_score = damos_sysfs_get_quota_score;
+		goal = damos_new_quota_goal(damos_sysfs_get_quota_score,
+				(void *)(sysfs_goal->current_value * 10000 /
+				sysfs_goal->target_value));
+		if (!goal)
+			return -ENOMEM;
+		damos_add_quota_goal(quota, goal);
 	}
+	return 0;
 }
 
-void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx)
 {
 	struct damos *scheme;
@@ -1918,16 +1922,21 @@ void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 
 	damon_for_each_scheme(scheme, ctx) {
 		struct damon_sysfs_scheme *sysfs_scheme;
+		int err;
 
 		/* user could have removed the scheme sysfs dir */
 		if (i >= sysfs_schemes->nr)
 			break;
 
 		sysfs_scheme = sysfs_schemes->schemes_arr[i];
-		damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
+		err = damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
 				&scheme->quota);
+		if (err)
+			/* kdamond will clean up schemes and terminated */
+			return err;
 		i++;
 	}
+	return 0;
 }
 
 void damos_sysfs_update_effective_quotas(
@@ -1987,13 +1996,17 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	damos_sysfs_set_quota_score(sysfs_quotas->goals, &quota);
-
 	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
 			sysfs_scheme->apply_interval_us, &quota, &wmarks);
 	if (!scheme)
 		return NULL;
 
+	err = damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+
 	err = damon_sysfs_set_scheme_filters(scheme, sysfs_filters);
 	if (err) {
 		damon_destroy_scheme(scheme);
@@ -2029,7 +2042,11 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->quota.weight_nr_accesses = sysfs_weights->nr_accesses;
 	scheme->quota.weight_age = sysfs_weights->age;
 
-	damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
+	err = damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return;
+	}
 
 	scheme->wmarks.metric = sysfs_wmarks->metric;
 	scheme->wmarks.interval = sysfs_wmarks->interval_us;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index cc2d88a901f4..6fee383bc0c5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1377,8 +1377,7 @@ static int damon_sysfs_commit_schemes_quota_goals(
 
 	ctx = sysfs_kdamond->damon_ctx;
 	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
-	damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
-	return 0;
+	return damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
 }
 
 /*
-- 
2.39.2


