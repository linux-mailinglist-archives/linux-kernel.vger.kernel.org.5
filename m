Return-Path: <linux-kernel+bounces-71891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F3D85AC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252641C217B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764D56B6F;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab+A5Sfs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462556475;
	Mon, 19 Feb 2024 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371885; cv=none; b=WuC+8LWrBPRK9J9rJULINnPnd0lpEIBT9x3bXmpsmnH/TourbUey2ZMZgI9eJZQ1a1IqnQFzWh2qMSoly6MeLgO/PI8irwZwzsROPsdVP0Ycd2BwKv5Rm3N8W/kAoG2NhEYSxa3/KdZxXGrA3KMBvrPwEfMsRnupe1xDRhnln5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371885; c=relaxed/simple;
	bh=QeU5c/dwATJidBlGHBdNGbMWliRdhvFFFKPfbT81FqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0oDU2folcMvyRD4Lbhdx03aYmK8m+p2a8MdjNe5pP5/peu5lO/63DRza7UzJ951tqhUz68fBPW6VtQQZ+vDnw3QACMo03ck80Nvb/pBHHrnVSWdjG0eVFEfXQmQft8UbTUWoM54H+VPLJ9LhDaVLQvWeD8MtKkH7h+o65Eqmgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab+A5Sfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDE9C43142;
	Mon, 19 Feb 2024 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371884;
	bh=QeU5c/dwATJidBlGHBdNGbMWliRdhvFFFKPfbT81FqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ab+A5SfsaBxGqQ9J4X3fZQnWF7spadZC+lmESnnYLCSADToO6/m5SSUsThlK0cWsb
	 Ub9tDmvaeUhGcdOx4/HVC+x3lj3WvVEXvZcMfjNG9q2vVe7KwHvZDofEd9umrUN7aC
	 o6LYXNdE07D+b5Lnsb72tj2JsQkbSo9wWxPnHnmIO7oQpjBZX4WJx1cj7gcFqevQg7
	 EiXZMnxtLt+M94kbNS1Biw/13mEtXV8JpNz5EXGh14tD4Z8im3Lom2Y/QZXI0KbVG6
	 rleAwT/68jIKL4wV544A45Cehx5TLoPG8K0zYPQQtut1lypcWsN40nynj7IHzPZU8/
	 pNYJL4G6rXXXA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] mm/damon/core: remove ->goal field of damos_quota
Date: Mon, 19 Feb 2024 11:44:21 -0800
Message-Id: <20240219194431.159606-11-sj@kernel.org>
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

DAMOS quota auto-tuning feature supports static signle goal and dynamic
multiple goals via DAMON kernel API, specifically via ->goal and ->goals
fields of damos_quota struct, respectively.  All in-tree DAMOS kernel
API users are using only the dynamic multiple goals now.  Remove the
unsued static single goal interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 12 ++++--------
 mm/damon/core.c       | 17 +++++------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4bd898eaf80e..76c965c1eea3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -149,7 +149,6 @@ struct damos_quota_goal {
  * @reset_interval:	Charge reset interval in milliseconds.
  * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
- * @goal:		Quota auto-tuning goal.
  * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @esz:		Effective size quota in bytes.
  *
@@ -169,12 +168,10 @@ struct damos_quota_goal {
  * throughput of the scheme's action.  DAMON then compares it against &sz and
  * uses smaller one as the effective quota.
  *
- * If ->get_score field of @goal is set, DAMON calculates yet another size
- * quota based on the goal using its internal feedback loop algorithm, for
- * every @reset_interval.  Then, if the new size quota is smaller than the
- * effective quota, it uses the new size quota as the effective quota.
- *
- * If @goals is not empty, same action is taken for each goal of the list.
+ * If @goals is not empt, DAMON calculates yet another size quota based on the
+ * goals using its internal feedback loop algorithm, for every @reset_interval.
+ * Then, if the new size quota is smaller than the effective quota, it uses the
+ * new size quota as the effective quota.
  *
  * The resulting effective size quota in bytes is set to @esz.
  *
@@ -188,7 +185,6 @@ struct damos_quota {
 	unsigned long reset_interval;
 	unsigned long ms;
 	unsigned long sz;
-	struct damos_quota_goal goal;
 	struct list_head goals;
 	unsigned long esz;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b6cd99b64e85..7b06d926c552 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1130,10 +1130,6 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 	struct damos_quota_goal *goal;
 	unsigned long highest_score = 0;
 
-	if (quota->goal.get_score)
-		highest_score = quota->goal.get_score(
-				quota->goal.get_score_arg);
-
 	damos_for_each_quota_goal(goal, quota)
 		highest_score = max(highest_score,
 				goal->get_score(goal->get_score_arg));
@@ -1142,21 +1138,19 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 }
 
 /*
- * Called only if quota->ms, quota->sz, or quota->goal.get_score are set, or
- * quota->goals is not empty
+ * Called only if quota->ms, or quota->sz are set, or quota->goals is not empty
  */
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
 	unsigned long throughput;
 	unsigned long esz;
 
-	if (!quota->ms && !quota->goal.get_score &&
-			list_empty(&quota->goals)) {
+	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
 		return;
 	}
 
-	if (quota->goal.get_score || !list_empty(&quota->goals)) {
+	if (!list_empty(&quota->goals)) {
 		unsigned long score = damos_quota_score(quota);
 
 		quota->esz_bp = damon_feed_loop_next_input(
@@ -1171,7 +1165,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 				quota->total_charged_ns;
 		else
 			throughput = PAGE_SIZE * 1024;
-		if (quota->goal.get_score || !list_empty(&quota->goals))
+		if (!list_empty(&quota->goals))
 			esz = min(throughput * quota->ms, esz);
 		else
 			esz = throughput * quota->ms;
@@ -1191,8 +1185,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && !quota->goal.get_score &&
-			list_empty(&quota->goals))
+	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
 	/* New charge window starts */
-- 
2.39.2


