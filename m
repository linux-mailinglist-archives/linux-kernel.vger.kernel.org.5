Return-Path: <linux-kernel+bounces-71893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3485AC40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E11F21715
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27D5731E;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBawmmXP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4156B80;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371886; cv=none; b=hNgkfW+M+D2QKQL9UoD0yGAyOeFhVVCZTZr5jQLvElXUJl7oj2Qsq6yywD1ZFIoUpiWbS0kkuEQ7tI09I6qYSTRJzKQiGN7gijvTdzGDhzu4/IB+gK27W2MRmqYsnvZIFaleAiJ0zJsAsbbVhapRrAT/hRr4pZIJbUz67TaO5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371886; c=relaxed/simple;
	bh=k0sVHhoP1l10FZGLvNv2ZQk6SLTzHmp1jaim+1skQqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awehZr713UI7TSP7I3SIMzDl6x0TQs5K7CvrysfiYe3SVumaPFHngj2VbX8tSGF9v4kV5GfbSZaTAAivrk++O/kRaFd33Oc58VaLJyV5Wm7E0Mlozlk9UPzRp2uXnigU2wVj+N+pX7CAcogtK2AY515cINFSCpI84iJo9wMnLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBawmmXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AD9C43390;
	Mon, 19 Feb 2024 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371885;
	bh=k0sVHhoP1l10FZGLvNv2ZQk6SLTzHmp1jaim+1skQqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBawmmXP4SAQih4l7kjcCb8kPPaiAeqHNjh3ek/vrXAWbguNYIFOsl0zi2ZwrqbCC
	 X0NDppc10tKHbCZa4jaj5XsyGU2kuRfex+PUO+GvBmfE2APRTp2+5d5WTg1jJDfocC
	 Ic8+M+Z4BEtesgKhqejnoPQkfOkygCr5dExvWF31KCTseZ7tNM9+cMOZEAxbhmUybf
	 MV+TOQ2et5Y909rkNOhJyMziq4sxd+CHWHrdE4WFtzZnYPed8ICfs2Rk91lJTc03Ay
	 NDNEr5LK3SGUD126pw+2744vsjBc6fgNPOWMvPA9V4RDvrkueerTpw7PDEXJP5Z8wW
	 H4skvQs+UcbcQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] mm/damon/core: support multiple metrics for quota goal
Date: Mon, 19 Feb 2024 11:44:23 -0800
Message-Id: <20240219194431.159606-13-sj@kernel.org>
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

DAMOS quota auto-tuning asks users to assess the current tuned quota and
provide the feedback in a manual and repeated way.  It allows users
generate the feedback from a source that the kernel cannot access, and
writing a script or a function for doing the manual and repeated feeding
is not a big deal.  However, additional works are additional works, and
it could be more efficient if DAMOS could do the fetch itself,
especially in case of DAMON sysfs interface use case, since it can avoid
the context switches between the user-space and the kernel-space, though
the overhead would be only trivial in most cases.  Also in many cases,
feedbacks could be made from kernel-accessible sources, such as PSI, CPU
usage, etc.  Make the quota goal to support multiple types of metrics
including such ones.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 26 +++++++++++++++++++++++---
 mm/damon/core.c          | 22 +++++++++++++++++++---
 mm/damon/sysfs-schemes.c |  5 +++--
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index de0cdc7f96d2..5a06993d8479 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -126,18 +126,37 @@ enum damos_action {
 	NR_DAMOS_ACTIONS,
 };
 
+/**
+ * enum damos_quota_goal_metric - Represents the metric to be used as the goal
+ *
+ * @DAMOS_QUOTA_USER_INPUT:	User-input value.
+ * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
+ *
+ * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
+ */
+enum damos_quota_goal_metric {
+	DAMOS_QUOTA_USER_INPUT,
+	NR_DAMOS_QUOTA_GOAL_METRICS,
+};
+
 /**
  * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
- * @target_value:	Target value to achieve with the tuning.
- * @current_value:	Current value that achieving with the tuning.
+ * @metric:		Metric to be used for representing the goal.
+ * @target_value:	Target value of @metric to achieve with the tuning.
+ * @current_value:	Current value of @metric.
  * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
  * score is calculated by how close @current_value and @target_value are.  Then
  * the score is entered to DAMON's internal feedback loop mechanism to get the
  * auto-tuned quota.
+ *
+ * If @metric is DAMOS_QUOTA_USER_INPUT, @current_value should be manually
+ * entered by the user, probably inside the kdamond callbacks.  Otherwise,
+ * DAMON sets @current_value with self-measured value of @metric.
  */
 struct damos_quota_goal {
+	enum damos_quota_goal_metric metric;
 	unsigned long target_value;
 	unsigned long current_value;
 	struct list_head list;
@@ -689,7 +708,8 @@ void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos_quota_goal *damos_new_quota_goal(
-		unsigned long target_value, unsigned long current_value);
+		enum damos_quota_goal_metric metric,
+		unsigned long target_value);
 void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
 void damos_destroy_quota_goal(struct damos_quota_goal *goal);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 907f467fc8c0..973423166ee2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -300,15 +300,16 @@ void damos_destroy_filter(struct damos_filter *f)
 }
 
 struct damos_quota_goal *damos_new_quota_goal(
-		unsigned long target_value, unsigned long current_value)
+		enum damos_quota_goal_metric metric,
+		unsigned long target_value)
 {
 	struct damos_quota_goal *goal;
 
 	goal = kmalloc(sizeof(*goal), GFP_KERNEL);
 	if (!goal)
 		return NULL;
+	goal->metric = metric;
 	goal->target_value = target_value;
-	goal->current_value = current_value;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -1124,16 +1125,31 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 	return min_input;
 }
 
+static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
+{
+	u64 now_psi_total;
+
+	switch (goal->metric) {
+	case DAMOS_QUOTA_USER_INPUT:
+		/* User should already set goal->current_value */
+		break;
+	default:
+		break;
+	}
+}
+
 /* Return the highest score since it makes schemes least aggressive */
 static unsigned long damos_quota_score(struct damos_quota *quota)
 {
 	struct damos_quota_goal *goal;
 	unsigned long highest_score = 0;
 
-	damos_for_each_quota_goal(goal, quota)
+	damos_for_each_quota_goal(goal, quota) {
+		damos_set_quota_goal_current_value(goal);
 		highest_score = max(highest_score,
 				goal->current_value * 10000 /
 				goal->target_value);
+	}
 
 	return highest_score;
 }
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 50218a7bfa0a..7a8a39f2679b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1899,10 +1899,11 @@ static int damos_sysfs_set_quota_score(
 		if (!sysfs_goal->target_value)
 			continue;
 
-		goal = damos_new_quota_goal(sysfs_goal->target_value,
-				sysfs_goal->current_value);
+		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT,
+				sysfs_goal->target_value);
 		if (!goal)
 			return -ENOMEM;
+		goal->current_value = sysfs_goal->current_value;
 		damos_add_quota_goal(quota, goal);
 	}
 	return 0;
-- 
2.39.2


