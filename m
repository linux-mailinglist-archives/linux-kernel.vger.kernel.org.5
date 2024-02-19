Return-Path: <linux-kernel+bounces-71888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0880085AC36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B392818CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962F55C16;
	Mon, 19 Feb 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gphxwb2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE155475D;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371883; cv=none; b=LR7spq5IXTt7Rd6ZL+XBMkKl5U3g8c+AAGWUe3lyvpSZXPdmXe+ANxCFzQDw2dSCXpZP4H9auEiLv4gYx34AyAF/Lki5XrbLnD0wxGeVAzqV4BiCF81zxNeeEJdD+2EdMR+irBfsopqp/a/HmARCSg+sOF4nnLbQRYE+04oVlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371883; c=relaxed/simple;
	bh=BGP026mJwlW/eKHVIUjB0WBT8A8x06Px6FbED6keS6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8gSzLnwrPrZXf7f/AzGUER3Cl7HPCDahcgwze6x9nghnOnXrSmBRkLFfBp64JY4mFS7UW3OUJbmfbAwmBLMApKkDIjLUEgZ2QMZEJfzUf9h6ZvpJa5HZE5DC6StZ6Bizz11fLrzarB6hWDbtZn04Dk7z9nHpCK2g0fuxRteVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gphxwb2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00EEC433C7;
	Mon, 19 Feb 2024 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371883;
	bh=BGP026mJwlW/eKHVIUjB0WBT8A8x06Px6FbED6keS6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gphxwb2udN9PVME6d5bTuNTiFXFuKfFFZHlFeju9dUGTOajLOpZfQKlxikbafpC1b
	 eEvBQusALO514a+hnWtLbkRylZihVkHFaBU73bpN1uOTk2yJ5wuad9zjPoiAlWKwwy
	 aHvHZpGgauHziCU2VPTn+9bCIlwJdfOkNXogRBWYlf6amibtzPfFnZ7ivWjohRhnve
	 GG2RB+HJfAVJ8Jzg9La/euCL2mC734M7jNPrgJZtX0nn5kfRomW0rMKXBDk1kIVpsg
	 CkiuMvITGMdr0Nd0JkiiOu1GdmKPOcVLa3tWSascMIF5SlZZ/qjx7qOq8ilDWpkQrn
	 ySNK1Fyi883oQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] mm/damon/core: split out quota goal related fields to a struct
Date: Mon, 19 Feb 2024 11:44:18 -0800
Message-Id: <20240219194431.159606-8-sj@kernel.org>
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

'struct damos_quota' is not small now.  Split out fields for quota goal
to a separate struct for easier reading.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 36 ++++++++++++++++++++++--------------
 mm/damon/core.c          | 13 +++++++------
 mm/damon/sysfs-schemes.c | 10 +++++-----
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bd17b14828bc..2fe345adf6b2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -126,13 +126,28 @@ enum damos_action {
 	NR_DAMOS_ACTIONS,
 };
 
+/**
+ * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
+ * @get_score:		Function for getting current score of the goal.
+ * @get_score_arg:	Parameter for @get_score
+ *
+ * Data structure for getting the current score of the quota tuning goal.
+ * Calling @get_score with @get_score_arg as the parameter should return the
+ * current score.  Then the score is entered to DAMON's internal feedback loop
+ * mechanism to get the auto-tuned quota.  The goal of the tuning is getting
+ * the feedback score value of 10,000.
+ */
+struct damos_quota_goal {
+	unsigned long (*get_score)(void *arg);
+	void *get_score_arg;
+};
+
 /**
  * struct damos_quota - Controls the aggressiveness of the given scheme.
  * @reset_interval:	Charge reset interval in milliseconds.
  * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
- * @get_score:		Feedback function for self-tuning quota.
- * @get_score_arg:	Parameter for @get_score
+ * @goal:		Quota auto-tuning goal.
  * @esz:		Effective size quota in bytes.
  *
  * @weight_sz:		Weight of the region's size for prioritization.
@@ -151,16 +166,10 @@ enum damos_action {
  * throughput of the scheme's action.  DAMON then compares it against &sz and
  * uses smaller one as the effective quota.
  *
- * If @get_score function pointer is set, DAMON calls it back with
- * @get_score_arg and get the return value of it for every @reset_interval.
- * Then, DAMON adjusts the effective quota using the return value as a feedback
- * score to the current quota, using its internal feedback loop algorithm.
- *
- * The feedback loop algorithem assumes the quota input and the feedback score
- * output are in a positive proportional relationship, and the goal of the
- * tuning is getting the feedback screo value of 10,000.  If @ms and/or @sz are
- * set together, those work as a hard limit quota.  If neither @ms nor @sz are
- * set, the mechanism starts from the quota of one byte.
+ * If ->get_score field of @goal is set, DAMON calculates yet another size
+ * quota based on the goal using its internal feedback loop algorithm, for
+ * every @reset_interval.  Then, if the new size quota is smaller than the
+ * effective quota, it uses the new size quota as the effective quota.
  *
  * The resulting effective size quota in bytes is set to @esz.
  *
@@ -174,8 +183,7 @@ struct damos_quota {
 	unsigned long reset_interval;
 	unsigned long ms;
 	unsigned long sz;
-	unsigned long (*get_score)(void *arg);
-	void *get_score_arg;
+	struct damos_quota_goal goal;
 	unsigned long esz;
 
 	unsigned int weight_sz;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0656966a6fc4..fe4209672121 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1083,21 +1083,22 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 	return min_input;
 }
 
-/* Shouldn't be called if quota->ms, quota->sz, and quota->get_score unset */
+/* Called only if quota->ms, quota->sz, or quota->goal.get_score are set */
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
 	unsigned long throughput;
 	unsigned long esz;
 
-	if (!quota->ms && !quota->get_score) {
+	if (!quota->ms && !quota->goal.get_score) {
 		quota->esz = quota->sz;
 		return;
 	}
 
-	if (quota->get_score) {
+	if (quota->goal.get_score) {
 		quota->esz_bp = damon_feed_loop_next_input(
 				max(quota->esz_bp, 10000UL),
-				quota->get_score(quota->get_score_arg));
+				quota->goal.get_score(
+					quota->goal.get_score_arg));
 		esz = quota->esz_bp / 10000;
 	}
 
@@ -1107,7 +1108,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 				quota->total_charged_ns;
 		else
 			throughput = PAGE_SIZE * 1024;
-		if (quota->get_score)
+		if (quota->goal.get_score)
 			esz = min(throughput * quota->ms, esz);
 		else
 			esz = throughput * quota->ms;
@@ -1127,7 +1128,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && !quota->get_score)
+	if (!quota->ms && !quota->sz && !quota->goal.get_score)
 		return;
 
 	/* New charge window starts */
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9d90e7b757b7..85ef58f98a87 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1894,19 +1894,19 @@ static void damos_sysfs_set_quota_score(
 	struct damos_sysfs_quota_goal *sysfs_goal;
 	int i;
 
-	quota->get_score = NULL;
-	quota->get_score_arg = (void *)0;
+	quota->goal.get_score = NULL;
+	quota->goal.get_score_arg = (void *)0;
 	for (i = 0; i < sysfs_goals->nr; i++) {
 		sysfs_goal = sysfs_goals->goals_arr[i];
 		if (!sysfs_goal->target_value)
 			continue;
 
 		/* Higher score makes scheme less aggressive */
-		quota->get_score_arg = (void *)max(
-				(unsigned long)quota->get_score_arg,
+		quota->goal.get_score_arg = (void *)max(
+				(unsigned long)quota->goal.get_score_arg,
 				sysfs_goal->current_value * 10000 /
 				sysfs_goal->target_value);
-		quota->get_score = damos_sysfs_get_quota_score;
+		quota->goal.get_score = damos_sysfs_get_quota_score;
 	}
 }
 
-- 
2.39.2


