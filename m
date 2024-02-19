Return-Path: <linux-kernel+bounces-71892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0872785AC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E61C212E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAFB56B86;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlEYB5tC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73056765;
	Mon, 19 Feb 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371885; cv=none; b=erNeQmLltRSIfjgjhzOdP42C/Ghv2RbZGsixm/O6S+BrKRKmeRfC2b9EJiiHfm28+lpTyraesocKXfo3g8ueeButETHHk4iSQm2iiRz03j0HzBoyzAeikDU1HfPALmfVEHADM35KIho2rbrkARydgFEkRu7RK/+bps7jN2h/0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371885; c=relaxed/simple;
	bh=R3dxTppsO4aJJFug6nWMDIsYsBasUQvKpFzDWX0osTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S83tiCJ6DH5TZ/Bkgkgb9GuS4g3pjzUzGUYIg98TfrjKq14zT1vi1vZZtNSaLJf1WVZgMhHDHAs8niYWyBgSBuQj2Tiu0hrKTlChlwA9gaNKxFPMbxVSioA3mVxf3vZoEhO9PS040A3xWYTbC/BXqv8SDwVObtGnojpE8vwhOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlEYB5tC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D0CC43394;
	Mon, 19 Feb 2024 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371885;
	bh=R3dxTppsO4aJJFug6nWMDIsYsBasUQvKpFzDWX0osTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlEYB5tC4/VXhLLWfLhPwyH9Tzvh/9R0vhtcqhC+OvyZXwKASESgHHIjXyOQTm9fD
	 tM1wtoxgijVyLP2EumAzUce+yvGmcGMEolxhZkNjwobgwRfeBEMN+ZYH2F1EwcBTTw
	 Zklz3HDqD4mx/QWmPq6+0qpQWu/tPAaTa9OOdfUCxr/0VQ6iQa/gNvsPsFqsCgoYyW
	 +NKW/JwAn8XxwOUbHwBxZ8qQQ8jIWBn6qk2ZwU06pG1Q3HDZ6qC27mv4F1XC+FfQGT
	 2aq8jhUFVJfdXLig4ZB9Q+4aQzEv09sXFcKMyciaKHTbOz28r9voYDgQn55ZTjpgx7
	 1rAXIxYu/wSzA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] mm/damon/core: let goal specified with only target and current values
Date: Mon, 19 Feb 2024 11:44:22 -0800
Message-Id: <20240219194431.159606-12-sj@kernel.org>
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

DAMOS quota auto-tuning feature let users to set the goal by providing a
function for getting the current score of the tuned quota.  It allows
flexible goal setup, but only simple user-set quota is currently being
used.  As a result, the only user of the DAMOS quota auto-tuning is
using a silly void pointer casting based score value passing function.
Simplify the interface and the user code by letting user directly set
the target and the current value.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 19 +++++++++----------
 mm/damon/core.c          |  9 +++++----
 mm/damon/sysfs-schemes.c | 10 ++--------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 76c965c1eea3..de0cdc7f96d2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -128,19 +128,18 @@ enum damos_action {
 
 /**
  * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
- * @get_score:		Function for getting current score of the goal.
- * @get_score_arg:	Parameter for @get_score
+ * @target_value:	Target value to achieve with the tuning.
+ * @current_value:	Current value that achieving with the tuning.
  * @list:		List head for siblings.
  *
- * Data structure for getting the current score of the quota tuning goal.
- * Calling @get_score with @get_score_arg as the parameter should return the
- * current score.  Then the score is entered to DAMON's internal feedback loop
- * mechanism to get the auto-tuned quota.  The goal of the tuning is getting
- * the feedback score value of 10,000.
+ * Data structure for getting the current score of the quota tuning goal.  The
+ * score is calculated by how close @current_value and @target_value are.  Then
+ * the score is entered to DAMON's internal feedback loop mechanism to get the
+ * auto-tuned quota.
  */
 struct damos_quota_goal {
-	unsigned long (*get_score)(void *arg);
-	void *get_score_arg;
+	unsigned long target_value;
+	unsigned long current_value;
 	struct list_head list;
 };
 
@@ -690,7 +689,7 @@ void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos_quota_goal *damos_new_quota_goal(
-		unsigned long (*get_score)(void *), void *get_score_arg);
+		unsigned long target_value, unsigned long current_value);
 void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
 void damos_destroy_quota_goal(struct damos_quota_goal *goal);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7b06d926c552..907f467fc8c0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -300,15 +300,15 @@ void damos_destroy_filter(struct damos_filter *f)
 }
 
 struct damos_quota_goal *damos_new_quota_goal(
-		unsigned long (*get_score)(void *), void *get_score_arg)
+		unsigned long target_value, unsigned long current_value)
 {
 	struct damos_quota_goal *goal;
 
 	goal = kmalloc(sizeof(*goal), GFP_KERNEL);
 	if (!goal)
 		return NULL;
-	goal->get_score = get_score;
-	goal->get_score_arg = get_score_arg;
+	goal->target_value = target_value;
+	goal->current_value = current_value;
 	INIT_LIST_HEAD(&goal->list);
 	return goal;
 }
@@ -1132,7 +1132,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 
 	damos_for_each_quota_goal(goal, quota)
 		highest_score = max(highest_score,
-				goal->get_score(goal->get_score_arg));
+				goal->current_value * 10000 /
+				goal->target_value);
 
 	return highest_score;
 }
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7bf94b1ed6f7..50218a7bfa0a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1882,11 +1882,6 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 	return 0;
 }
 
-static unsigned long damos_sysfs_get_quota_score(void *arg)
-{
-	return (unsigned long)arg;
-}
-
 static int damos_sysfs_set_quota_score(
 		struct damos_sysfs_quota_goals *sysfs_goals,
 		struct damos_quota *quota)
@@ -1904,9 +1899,8 @@ static int damos_sysfs_set_quota_score(
 		if (!sysfs_goal->target_value)
 			continue;
 
-		goal = damos_new_quota_goal(damos_sysfs_get_quota_score,
-				(void *)(sysfs_goal->current_value * 10000 /
-				sysfs_goal->target_value));
+		goal = damos_new_quota_goal(sysfs_goal->target_value,
+				sysfs_goal->current_value);
 		if (!goal)
 			return -ENOMEM;
 		damos_add_quota_goal(quota, goal);
-- 
2.39.2


