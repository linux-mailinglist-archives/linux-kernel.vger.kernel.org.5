Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F17FE6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjK3Che (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjK3Ch1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:37:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89619AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97F4C433C7;
        Thu, 30 Nov 2023 02:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311820;
        bh=jwBIjpGZD3rM6rB5XeAwkaAzirgaxde9QsDx+o7twAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lydNSbh/PCoA8/EI4ar2Ec+gdsQ/sP8wLwSz7QdbaVARbRFmcMt8GRGPi/IP/KKVJ
         jgEkE4yB4hZMmj74cPK9catW2EE5pihwR0ajHW6VG4oQM6RTKDLnssb6Cp6sM0JDX4
         9hi7WxvY9TJyOCa3tpN4mLR+KATBlBpWQyW6yYm+m01i7SbgfkVi86kuYRAP8y2zi4
         4l28vUQEjqnORCskD00MmdIHGPUEhUTInZkSQDht7SE5qp+2E0vLb5114Vt2IGJL3+
         bGhmN7UA4j0SgjgVWK9WoBAhPdJOL4XuBBy9eQ2EZc2ahFIUIsQsOtFTFhRKlvy1Es
         EeZW9IhKznzYw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning
Date:   Thu, 30 Nov 2023 02:36:44 +0000
Message-Id: <20231130023652.50284-2-sj@kernel.org>
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

Users can effectively control the upper-limit aggressiveness of DAMOS
schemes using the quota feature.  The quota provides best result under
the limit by prioritizing regions based on the access pattern.  That
said, finding the best value, which could depend on dynamic
characteristics of the system and the workloads, is still challenging.

Implement a simple feedback-driven tuning mechanism and use it for
automatic tuning of DAMOS quota.  The implementation allows users to
provide the feedback by setting a feedback score returning callback
function.  Then DAMOS periodically calls the function back and adjusts
the quota based on the return value of the callback and current quota
value.

Note that the absolute-value based time/size quotas still work as the
maximum hard limits of the scheme's aggressiveness.  The feedback-driven
auto-tuned quota is applied only if it is not exceeding the manually set
maximum limits.  Same for the scheme-target access pattern and filters
like other features.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 19 ++++++++++++
 mm/damon/core.c       | 68 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ab2f17d9926b..508a262418a2 100644
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
index ce1562783e7e..f91715a58dc7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1038,26 +1038,76 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
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
+		if (quota->get_score)
+			esz = min(throughput * quota->ms, esz);
+		else
+			esz = throughput * quota->ms;
+	}
 
 	if (quota->sz && quota->sz < esz)
 		esz = quota->sz;
+
 	quota->esz = esz;
 }
 
@@ -1069,7 +1119,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz)
+	if (!quota->ms && !quota->sz && !quota->get_score)
 		return;
 
 	/* New charge window starts */
-- 
2.34.1

