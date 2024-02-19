Return-Path: <linux-kernel+bounces-71895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F785AC41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1679328262F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED75812E;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdWxaHKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD156B96;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371886; cv=none; b=ZfLTxUbE3wQqpmZ/wUWYrw5b7IX7GZWJ3sBabVUW7K6ddl2xA4BhSifmG5EO91ldNQha69vf8GCcqaTiu31LgFrAWUA5J5GHp8QdfrSwp7Cg+UIqa2R/EMbnrF2lTLoghhIw9mqYgkO05KmzLt1IB19j5FTVutO7LyF16Kioo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371886; c=relaxed/simple;
	bh=+x9YEwq0wFUN061d3yOJa9HVAX8E/VoU7wyTTkm6mIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFLhwjXgUAJuFk1b7Yp3xhffxGXmKXm7zc29g407T483LkZ0cLFtdydD/H/XFQ3iVK7GSUf3cWGwLN2gzeevsR/2Ajx75iqke9luCTBMEIberZcYpayoEiGCQBXfsxicD2Rpsc7+n9tB9DjmPl62CCmtPN2z7WVp/YOUfaDq49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdWxaHKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29130C43142;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371886;
	bh=+x9YEwq0wFUN061d3yOJa9HVAX8E/VoU7wyTTkm6mIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdWxaHKcnSEnWZqTNxUepviJgGCPR1bk6d5g+2L1cVg1/eGNxrn5SkWPrUnaK7JQO
	 Vuk7vnYM1Uyb590YgKH6608jYA3nygvM6QZFCbklC41SZDPa1t+ounHmjZEt3oMH0y
	 PMS26IDxgZF5792MlVW3661l3tMRtrU640g13+hslj96jsyC9AraLApqoZ7CKh1ys4
	 0xGiJfqM41TDv+KREnlPoh8PTfFBxKLQAQloBLwOAfGKGKjqF+CTHBjvGiORIcX8pW
	 eSn7zriouYN9nH/T2G4lv45dJoL7vY0B0Sa6QCi1HrGxLw4YzYVogR6lVo0QFWSQJf
	 MwsQeCfDxr3iQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] mm/damon/core: implement PSI metric DAMOS quota goal
Date: Mon, 19 Feb 2024 11:44:24 -0800
Message-Id: <20240219194431.159606-14-sj@kernel.org>
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

Extend DAMOS quota goal metric with system wide memory pressure stall
time.  Specifically, the system level 'some' PSI for memory is used.
The target value can be set in microseconds.  DAMOS measures the
increased amount of the PSI metric in last quota_reset_interval and use
the ratio of it versus the user-specified target PSI value as the score
for the auto-tuning feedback loop.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  7 +++++++
 mm/damon/core.c       | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5a06993d8479..886d07294f4e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -130,12 +130,14 @@ enum damos_action {
  * enum damos_quota_goal_metric - Represents the metric to be used as the goal
  *
  * @DAMOS_QUOTA_USER_INPUT:	User-input value.
+ * @DAMOS_QUOTA_SOME_MEM_PSI_US:	System level some memory PSI in us.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
  */
 enum damos_quota_goal_metric {
 	DAMOS_QUOTA_USER_INPUT,
+	DAMOS_QUOTA_SOME_MEM_PSI_US,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
@@ -144,6 +146,7 @@ enum damos_quota_goal_metric {
  * @metric:		Metric to be used for representing the goal.
  * @target_value:	Target value of @metric to achieve with the tuning.
  * @current_value:	Current value of @metric.
+ * @last_psi_total:	Last measured total PSI
  * @list:		List head for siblings.
  *
  * Data structure for getting the current score of the quota tuning goal.  The
@@ -159,6 +162,10 @@ struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
 	unsigned long target_value;
 	unsigned long current_value;
+	/* metric-dependent fields */
+	union {
+		u64 last_psi_total;
+	};
 	struct list_head list;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 973423166ee2..6d503c1c125e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
+#include <linux/psi.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
@@ -1125,6 +1126,25 @@ static unsigned long damon_feed_loop_next_input(unsigned long last_input,
 	return min_input;
 }
 
+#ifdef CONFIG_PSI
+
+static u64 damos_get_some_mem_psi_total(void)
+{
+	if (static_branch_likely(&psi_disabled))
+		return 0;
+	return div_u64(psi_system.total[PSI_AVGS][PSI_MEM * 2],
+			NSEC_PER_USEC);
+}
+
+#else	/* CONFIG_PSI */
+
+static inline u64 damos_get_some_mem_psi_total(void)
+{
+	return 0;
+};
+
+#endif	/* CONFIG_PSI */
+
 static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 {
 	u64 now_psi_total;
@@ -1133,6 +1153,11 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_USER_INPUT:
 		/* User should already set goal->current_value */
 		break;
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		now_psi_total = damos_get_some_mem_psi_total();
+		goal->current_value = now_psi_total - goal->last_psi_total;
+		goal->last_psi_total = now_psi_total;
+		break;
 	default:
 		break;
 	}
-- 
2.39.2


