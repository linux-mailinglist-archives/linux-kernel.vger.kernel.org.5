Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E1F7E9255
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjKLTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjKLTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A92139
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51465C433CB;
        Sun, 12 Nov 2023 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818373;
        bh=KH5zwAcadi379iK70CZqM3VL8+sPUwrVnpfkvLQxuio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkjUxCxfX1eDI7+ZUfgU0fc8n+Jbbw4SnAXuDwRc0gK2X9MJSQ/Im4hUdsXf8ulo1
         kWBRMqtgQ7mu/hCku3ihWgdbs9bRZ30guaTnrITIWYBeVXdhn3cXqcBZSX15bmxyoH
         kZx70B5f6Wihw8EQUrGMeKL+8/OZLa/P2mdO7LyxR+hxkpW7dAqzS2x0wMNQHUsD+V
         vkYfSwqBIzDI90NSXv8G57GkDDvA/kKI18Wh2GuRYSi6dSIl7rS/X1aIZzaRu61F4o
         3NpMhRv3qxln2doao3lETfko0/RzXJVEi2a08qylRuH1pAmVvXB8CVyZXk20qiarmm
         8SIzWD3FOpPCw==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning
Date:   Sun, 12 Nov 2023 19:46:00 +0000
Message-Id: <20231112194607.61399-2-sj@kernel.org>
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

Users can effectively control the upper-most aggressiveness of DAMOS
schemes using the quota feature.  The quota provides best result under
the aggressiveness limit since it prioritizes regions based on the
access pattern.  Finding the best value, which could depend on dynamic
characteristics of the system and the workloads, is still challenging,
though.

Implement a simple feedback-driven tuning mechanism and use it for
automatic tuning of DAMOS quota.  The implementation allows users to
provide the feedback by setting a feedback score returning callback
function.  Then DAMOS periodically adjusts the quota based on the return
value of the function calls.

Note that the absolute-value based time/size quotas still work as the
maximum hard limit of the scheme's aggressiveness.  The feedback-driven
auto-tuned quota is applied only if it is not exceeding the manually set
maximum limit.  Same for the scheme-target access pattern and filters
like other features.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 19 +++++++++++++
 mm/damon/core.c       | 65 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 89f5ca041848..9d46e0b39456 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -136,6 +136,8 @@ enum damos_action {
  * @weight_nr_accesses:	Weight of the region's nr_accesses for prioritization.
  * @weight_age:		Weight of the region's age for prioritization.
  *
+ * @get_score:		Feedback function for self-tuning quota.
+ *
  * To avoid consuming too much CPU time or IO resources for applying the
  * &struct damos->action to large memory, DAMON allows users to set time and/or
  * size quotas.  The quotas can be set by writing non-zero values to &ms and
@@ -153,6 +155,17 @@ enum damos_action {
  * You could customize the prioritization logic by setting &weight_sz,
  * &weight_nr_accesses, and &weight_age, because monitoring operations are
  * encouraged to respect those.
+ *
+ * If @get_score function pointer is set, DAMON calls it back and get the
+ * return value of it for every @reset_interval.  Then, DAMON adjusts the
+ * effective quota using the return value as a feedback score to the current
+ * quota, using its internal feedback loop algorithm.
+ *
+ * The feedback loop algorithem assumes the quota input and the feedback score
+ * output are in a positive proportional relationship, and the goal of the
+ * tuning is getting the feedback screo value of 10,000.  If @ms and/or @sz are
+ * set together, those work as a hard limit quota.  If neither @ms nor @sz are
+ * set, the mechanism starts from the quota of one byte.
  */
 struct damos_quota {
 	unsigned long ms;
@@ -163,6 +176,9 @@ struct damos_quota {
 	unsigned int weight_nr_accesses;
 	unsigned int weight_age;
 
+	unsigned long (*get_score)(void *arg);
+	void *get_score_arg;
+
 /* private: */
 	/* For throughput estimation */
 	unsigned long total_charged_sz;
@@ -179,6 +195,9 @@ struct damos_quota {
 	/* For prioritization */
 	unsigned long histogram[DAMOS_MAX_SCORE + 1];
 	unsigned int min_score;
+
+	/* For feedback loop */
+	unsigned long esz_bp;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c451e7dfcd64..4d4e4ebbbb2a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1086,26 +1086,73 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	}
 }
 
-/* Shouldn't be called if quota->ms and quota->sz are zero */
+/*
+ * damon_feed_loop_next_input() - get next input to achieve a target score.
+ * @last_input	The last input.
+ * @score	Current score that made with @last_input.
+ *
+ * Calculate next input to achieve the target score, based on the last input
+ * and current score.  Assuming the input and the score are positively
+ * proportional, calculate how much compensation should be added to or
+ * subtracted from the last input as a proportion of the last input.  Avoid
+ * next input always being zero by setting it non-zero always.  In short form
+ * (assuming support of float and signed calculations), the algorithm is as
+ * below.
+ *
+ * next_input = max(last_input * ((goal - current) / goal + 1), 1)
+ *
+ * For simple implementation, we assume the target score is always 10,000.  The
+ * caller should adjust @score for this.
+ *
+ * Returns next input that assumed to achieve the target score.
+ */
+static unsigned long damon_feed_loop_next_input(unsigned long last_input,
+		unsigned long score)
+{
+	const unsigned long goal = 10000;
+	unsigned long score_goal_diff = max(goal, score) - min(goal, score);
+	unsigned long score_goal_diff_bp = score_goal_diff * 10000 / goal;
+	unsigned long compensation = last_input * score_goal_diff_bp / 10000;
+	/* Set minimum input as 10000 to avoid compensation be zero */
+	const unsigned long min_input = 10000;
+
+	if (goal > score)
+		return last_input + compensation;
+	if (last_input > compensation + min_input)
+		return last_input - compensation;
+	return min_input;
+}
+
+/* Shouldn't be called if quota->ms, quota->sz, and quota->get_score unset */
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
 	unsigned long throughput;
 	unsigned long esz;
 
-	if (!quota->ms) {
+	if (!quota->ms && !quota->get_score) {
 		quota->esz = quota->sz;
 		return;
 	}
 
-	if (quota->total_charged_ns)
-		throughput = quota->total_charged_sz * 1000000 /
-			quota->total_charged_ns;
-	else
-		throughput = PAGE_SIZE * 1024;
-	esz = throughput * quota->ms;
+	if (quota->get_score) {
+		quota->esz_bp = damon_feed_loop_next_input(
+				max(quota->esz_bp, 10000UL),
+				quota->get_score(quota->get_score_arg));
+		esz = quota->esz_bp / 10000;
+	}
+
+	if (quota->ms) {
+		if (quota->total_charged_ns)
+			throughput = quota->total_charged_sz * 1000000 /
+				quota->total_charged_ns;
+		else
+			throughput = PAGE_SIZE * 1024;
+		esz = min(throughput * quota->ms, esz);
+	}
 
 	if (quota->sz && quota->sz < esz)
 		esz = quota->sz;
+
 	quota->esz = esz;
 }
 
@@ -1117,7 +1164,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz)
+	if (!quota->ms && !quota->sz && !quota->get_score)
 		return;
 
 	/* New charge window starts */
-- 
2.34.1

