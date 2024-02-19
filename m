Return-Path: <linux-kernel+bounces-71889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D1785AC38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27F41F225CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BCF56453;
	Mon, 19 Feb 2024 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7CKpYy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450754FA7;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371884; cv=none; b=hVtbMh1ztN+LN3RuMrLVW7ndLobYzqZbAe0SBO1aK4Lnuja6QyR+GSz1NlfOsVfF/U2H9HWT4uvxhXB6l9+B6nB47n9buPIceb2Q/UcJSNgKG9YnElbzsFZAJV2igXM0eaf27MUq4AYluz1Y4nWrs1ZwyZ8OYz2VaHQ2ART8E/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371884; c=relaxed/simple;
	bh=oql1XzmeT1+l2YfyGdM6ybnvM0NrgJg8QAeQ/QOsNwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKu/ssECQCEhHCFtOCD8S/rTDxs+DuqZcLTZDARwMGE0sUQg6YM64wC11xLZAes9NC+BZQu7SmmmqrlcBrNuzTArSyGb42GZ7tz47H28DooFpE1SiFiKvIbXji2lpiHocIbPw8Dgk2lOvUuScU6xKjWUBXSgYM2IFoP16L/a1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7CKpYy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B6EC433B2;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371883;
	bh=oql1XzmeT1+l2YfyGdM6ybnvM0NrgJg8QAeQ/QOsNwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7CKpYy3zZMnNZ2RLrlm/AhKAtiDKdltHNeltt9YG/c//avZ/C21btvKo+6IMHC96
	 LuwXn48YUa67+phLsPiSdim1cxKHYuV0Kb8Q9wGuJtXotzBoNuJ3dItv/tLRJeL+QQ
	 d/ph0VDegeSUVff2L1TWYXgi8lgOT8AP06X9xZHbaMikLZS7a0IzQBAVQx/htTH6Vg
	 WvzON9voOco8RI33NMG3fCC//hezOSpAo+mrz2fhCQP1CWpuofBL8v+QUxd6zewgej
	 /QJNyZg1x6+1scwJCV3Ql/pIaF55xQUw6DDSxXLKge0+xX8eYYgdvgZ3QfHD/Dd+Z0
	 tBvtii6hP0Qew==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/20] mm/damon/core: add multiple goals per damos_quota and helpers for those
Date: Mon, 19 Feb 2024 11:44:19 -0800
Message-Id: <20240219194431.159606-9-sj@kernel.org>
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

The feedback-driven DAMOS quota auto-tuning feature allows only single
goal to the DAMON kernel API users.  The API users could implement
multiple goals for the end-users on their level, and that's what DAMON
sysfs interface is doing.  More DAMON kernel API users such as
DAMON_RECLAIM would need to do similar work.  To reduce unnecessary
future duplciated efforts, support multiple goals from DAMOS core layer.
To make the support in minimum non-destructive change, keep the old
single goal setup interface, and add multiple goals setup.  The single
goal will treated as one of the multiple goals, so old API users are not
required to make any change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 17 ++++++++++
 mm/damon/core.c       | 78 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2fe345adf6b2..4bd898eaf80e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -130,6 +130,7 @@ enum damos_action {
  * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
  * @get_score:		Function for getting current score of the goal.
  * @get_score_arg:	Parameter for @get_score
+ * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.
  * Calling @get_score with @get_score_arg as the parameter should return the
@@ -140,6 +141,7 @@ enum damos_action {
 struct damos_quota_goal {
 	unsigned long (*get_score)(void *arg);
 	void *get_score_arg;
+	struct list_head list;
 };
 
 /**
@@ -148,6 +150,7 @@ struct damos_quota_goal {
  * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
  * @goal:		Quota auto-tuning goal.
+ * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @esz:		Effective size quota in bytes.
  *
  * @weight_sz:		Weight of the region's size for prioritization.
@@ -171,6 +174,8 @@ struct damos_quota_goal {
  * every @reset_interval.  Then, if the new size quota is smaller than the
  * effective quota, it uses the new size quota as the effective quota.
  *
+ * If @goals is not empty, same action is taken for each goal of the list.
+ *
  * The resulting effective size quota in bytes is set to @esz.
  *
  * For selecting regions within the quota, DAMON prioritizes current scheme's
@@ -184,6 +189,7 @@ struct damos_quota {
 	unsigned long ms;
 	unsigned long sz;
 	struct damos_quota_goal goal;
+	struct list_head goals;
 	unsigned long esz;
 
 	unsigned int weight_sz;
@@ -648,6 +654,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damon_for_each_scheme_safe(s, next, ctx) \
 	list_for_each_entry_safe(s, next, &(ctx)->schemes, list)
 
+#define damos_for_each_quota_goal(goal, quota) \
+	list_for_each_entry(goal, &quota->goals, list)
+
+#define damos_for_each_quota_goal_safe(goal, next, quota) \
+	list_for_each_entry_safe(goal, next, &(quota)->goals, list)
+
 #define damos_for_each_filter(f, scheme) \
 	list_for_each_entry(f, &(scheme)->filters, list)
 
@@ -681,6 +693,11 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
+struct damos_quota_goal *damos_new_quota_goal(
+		unsigned long (*get_score)(void *), void *get_score_arg);
+void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g);
+void damos_destroy_quota_goal(struct damos_quota_goal *goal);
+
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			enum damos_action action,
 			unsigned long apply_interval_us,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fe4209672121..b6cd99b64e85 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -299,6 +299,41 @@ void damos_destroy_filter(struct damos_filter *f)
 	damos_free_filter(f);
 }
 
+struct damos_quota_goal *damos_new_quota_goal(
+		unsigned long (*get_score)(void *), void *get_score_arg)
+{
+	struct damos_quota_goal *goal;
+
+	goal = kmalloc(sizeof(*goal), GFP_KERNEL);
+	if (!goal)
+		return NULL;
+	goal->get_score = get_score;
+	goal->get_score_arg = get_score_arg;
+	INIT_LIST_HEAD(&goal->list);
+	return goal;
+}
+
+void damos_add_quota_goal(struct damos_quota *q, struct damos_quota_goal *g)
+{
+	list_add_tail(&g->list, &q->goals);
+}
+
+static void damos_del_quota_goal(struct damos_quota_goal *g)
+{
+	list_del(&g->list);
+}
+
+static void damos_free_quota_goal(struct damos_quota_goal *g)
+{
+	kfree(g);
+}
+
+void damos_destroy_quota_goal(struct damos_quota_goal *g)
+{
+	damos_del_quota_goal(g);
+	damos_free_quota_goal(g);
+}
+
 /* initialize fields of @quota that normally API users wouldn't set */
 static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 {
@@ -337,6 +372,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));
+	/* quota.goals should be separately set by caller */
+	INIT_LIST_HEAD(&scheme->quota.goals);
 
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
@@ -373,8 +410,12 @@ static void damon_free_scheme(struct damos *s)
 
 void damon_destroy_scheme(struct damos *s)
 {
+	struct damos_quota_goal *g, *g_next;
 	struct damos_filter *f, *next;
 
+	damos_for_each_quota_goal_safe(g, g_next, &s->quota)
+		damos_destroy_quota_goal(g);
+
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 	damon_del_scheme(s);
@@ -1083,22 +1124,44 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 	return min_input;
 }
 
-/* Called only if quota->ms, quota->sz, or quota->goal.get_score are set */
+/* Return the highest score since it makes schemes least aggressive */
+static unsigned long damos_quota_score(struct damos_quota *quota)
+{
+	struct damos_quota_goal *goal;
+	unsigned long highest_score = 0;
+
+	if (quota->goal.get_score)
+		highest_score = quota->goal.get_score(
+				quota->goal.get_score_arg);
+
+	damos_for_each_quota_goal(goal, quota)
+		highest_score = max(highest_score,
+				goal->get_score(goal->get_score_arg));
+
+	return highest_score;
+}
+
+/*
+ * Called only if quota->ms, quota->sz, or quota->goal.get_score are set, or
+ * quota->goals is not empty
+ */
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
 	unsigned long throughput;
 	unsigned long esz;
 
-	if (!quota->ms && !quota->goal.get_score) {
+	if (!quota->ms && !quota->goal.get_score &&
+			list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
 		return;
 	}
 
-	if (quota->goal.get_score) {
+	if (quota->goal.get_score || !list_empty(&quota->goals)) {
+		unsigned long score = damos_quota_score(quota);
+
 		quota->esz_bp = damon_feed_loop_next_input(
 				max(quota->esz_bp, 10000UL),
-				quota->goal.get_score(
-					quota->goal.get_score_arg));
+				score);
 		esz = quota->esz_bp / 10000;
 	}
 
@@ -1108,7 +1171,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 				quota->total_charged_ns;
 		else
 			throughput = PAGE_SIZE * 1024;
-		if (quota->goal.get_score)
+		if (quota->goal.get_score || !list_empty(&quota->goals))
 			esz = min(throughput * quota->ms, esz);
 		else
 			esz = throughput * quota->ms;
@@ -1128,7 +1191,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && !quota->goal.get_score)
+	if (!quota->ms && !quota->sz && !quota->goal.get_score &&
+			list_empty(&quota->goals))
 		return;
 
 	/* New charge window starts */
-- 
2.39.2


