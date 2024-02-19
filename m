Return-Path: <linux-kernel+bounces-71896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AFA85AC43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE016B221F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE858AC8;
	Mon, 19 Feb 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOTw5DPt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B058105;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371887; cv=none; b=r6TacEL73/QonReLyR2UYL9sPGdTbDmJ7pBMJXZnAvfN91Z0HzUGFMN5LnpYehdn6aJjjfEEL47Cd53qTZFgYk07Xj4DttExWyoaUrBkcn7uMfBIhx6EezjGfVcDG4u+6fV8iP1veP0Z7BlQDxmXMnCD8OGkNq1ZJueTAHjfmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371887; c=relaxed/simple;
	bh=CUFUQFRYuN+1nr4LagyWWgpSfoijjUeoeRxWSSISzx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeiQHEeFAuCdhUpxDxEGa8/2s8rG0LXCmPgdEhIAfubyfQvD5MCoY23pdwCu0qZStKiAYCBxpRH60N3gODsSLTLirgdlt6TbjN2htQSV7FdFHSu5RtKLZz4FEe/mlbUGKpDdA4KoCGiVmeP7yWVH5tPSudyA7bCR84cfcawm4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOTw5DPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ADEC43394;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371887;
	bh=CUFUQFRYuN+1nr4LagyWWgpSfoijjUeoeRxWSSISzx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOTw5DPtqz7EDT+Ul/z9K5LjGneHPwrOsY/SajlL5Bl2oLIl1awpnenXU//722LAQ
	 8JExaw7jR+vC9TyifyBA/ng8sJ87t7b37ykCu8xFWt24f0okGZcQbo2GFB8QAWcRXb
	 hysuM2OlpQhwbWAQEH9GUDz/8v1fcgJ51HkbcvsA7C47wkJcaqIZutS2Nu9WPxI0Kj
	 aI43L5ZT+zyPVvcx6ufR2x75e3X0TwFz52dWy9kjcozyTPg7XCbl7QazgclVpk6rRu
	 MQL0doHMyussoB9I/RFG9LiYx5NoGiggqQ3nc542MghmJl7kUZ2K90wbKZqTjJpRHa
	 zSlnawmoY8v3Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] mm/damon/sysfs-schemes: support PSI-based quota auto-tune
Date: Mon, 19 Feb 2024 11:44:25 -0800
Message-Id: <20240219194431.159606-15-sj@kernel.org>
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

Extend DAMON sysfs interface to support the PSI-based quota auto-tuning
by adding a new file, 'target_metric' under the quota goal directory.
Old users don't get any behavioral changes since the default value of
the metric is 'user input'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7a8a39f2679b..53a90ac678fb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -826,15 +826,48 @@ static const struct kobj_type damon_sysfs_watermarks_ktype = {
 
 struct damos_sysfs_quota_goal {
 	struct kobject kobj;
+	enum damos_quota_goal_metric metric;
 	unsigned long target_value;
 	unsigned long current_value;
 };
 
+/* This should match with enum damos_action */
+static const char * const damos_sysfs_quota_goal_metric_strs[] = {
+	"user_input",
+	"some_mem_psi_us",
+};
+
 static struct damos_sysfs_quota_goal *damos_sysfs_quota_goal_alloc(void)
 {
 	return kzalloc(sizeof(struct damos_sysfs_quota_goal), GFP_KERNEL);
 }
 
+static ssize_t target_metric_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+
+	return sysfs_emit(buf, "%s\n",
+			damos_sysfs_quota_goal_metric_strs[goal->metric]);
+}
+
+static ssize_t target_metric_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj,
+			struct damos_sysfs_quota_goal, kobj);
+	enum damos_quota_goal_metric m;
+
+	for (m = 0; m < NR_DAMOS_QUOTA_GOAL_METRICS; m++) {
+		if (sysfs_streq(buf, damos_sysfs_quota_goal_metric_strs[m])) {
+			goal->metric = m;
+			return count;
+		}
+	}
+	return -EINVAL;
+}
+
 static ssize_t target_value_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -880,6 +913,9 @@ static void damos_sysfs_quota_goal_release(struct kobject *kobj)
 	kfree(container_of(kobj, struct damos_sysfs_quota_goal, kobj));
 }
 
+static struct kobj_attribute damos_sysfs_quota_goal_target_metric_attr =
+		__ATTR_RW_MODE(target_metric, 0600);
+
 static struct kobj_attribute damos_sysfs_quota_goal_target_value_attr =
 		__ATTR_RW_MODE(target_value, 0600);
 
@@ -887,6 +923,7 @@ static struct kobj_attribute damos_sysfs_quota_goal_current_value_attr =
 		__ATTR_RW_MODE(current_value, 0600);
 
 static struct attribute *damos_sysfs_quota_goal_attrs[] = {
+	&damos_sysfs_quota_goal_target_metric_attr.attr,
 	&damos_sysfs_quota_goal_target_value_attr.attr,
 	&damos_sysfs_quota_goal_current_value_attr.attr,
 	NULL,
@@ -1899,11 +1936,12 @@ static int damos_sysfs_set_quota_score(
 		if (!sysfs_goal->target_value)
 			continue;
 
-		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT,
+		goal = damos_new_quota_goal(sysfs_goal->metric,
 				sysfs_goal->target_value);
 		if (!goal)
 			return -ENOMEM;
-		goal->current_value = sysfs_goal->current_value;
+		if (sysfs_goal->metric == DAMOS_QUOTA_USER_INPUT)
+			goal->current_value = sysfs_goal->current_value;
 		damos_add_quota_goal(quota, goal);
 	}
 	return 0;
-- 
2.39.2


