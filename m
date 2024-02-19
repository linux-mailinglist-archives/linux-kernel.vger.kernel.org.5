Return-Path: <linux-kernel+bounces-71900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775485AC49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66CF282FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0025BAD5;
	Mon, 19 Feb 2024 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFJSr6uM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF215B1F1;
	Mon, 19 Feb 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371890; cv=none; b=St1dBuFDlytkJldvv2+Nt6LzJgoy9CCwXBdUrKC3dBExjM/SiorVBt27Vs4RMZ4ZxbFuJreAWH3aGHza1wh3vQ0UTtnIMEFdOswTrtgL+VY7T0iJnkoR+EieLwWVcS5WsplpfO8VdflgsP5/sLz4ZRqD0ThbHkh9P/A6xvRVNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371890; c=relaxed/simple;
	bh=md7Aj2wC1qQQtLcqUJ8iiiADXUQCURmj3A5KbIYpZeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eARbbFadEAxRXuZGhS6+byLjNpoDbr7dXgvZ5+Zd/coLU1sPFVJbjB64PDdbkwvNklZidjrkOaZG/RbBHBdIbC9AFQWscuGCbrtKLOB4+gRTsZUsqnBm/um5mKSRB6Fm126uTT1NFirvYCzo9dSLxsyOH2BM0PA32IQVIZwX1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFJSr6uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0DAC433B2;
	Mon, 19 Feb 2024 19:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371889;
	bh=md7Aj2wC1qQQtLcqUJ8iiiADXUQCURmj3A5KbIYpZeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFJSr6uMfuHvK3mAQWBO/Kx6owcMmb7rsY4jYWRds3IthNLEW3TlfK7jgsRfr4CSM
	 dN61MrBA2XaPqDMU1gaWjxDOp5uJue4FiXV7dyB9ih0d1yjDW8TJqFmyoJ/AprBXak
	 +FjLU5myQyDjsWWNPpqZTo7WXY0W2RxROETQtMeADxrfSn5wvY7a6iFAWvj+4JDzLp
	 O61GWEWp+dqyVwTmB+0q+9dX6dgijC15QKRxTU3XGe0mlKXQzQaYL3LVdw/xMeOVmQ
	 bToBakwXJn07j5AZmC/mO61+fYpOd8aT2rRkCdhkI0gbIiIPbCe1sxCqAirQ894/Nl
	 te5B+uRH2irWg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] mm/damon/reclaim: implement user-feedback driven quota auto-tuning
Date: Mon, 19 Feb 2024 11:44:29 -0800
Message-Id: <20240219194431.159606-19-sj@kernel.org>
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

DAMOS supports user-feedback driven quota auto-tuning, but only DAMON
sysfs interface is using it.  Add support of the feature on
DAMON_RECLAIM by adding one more input parameter, namely
'quota_autotune_feedback', for providing the user feedback to
DAMON_RECLAIM.  It assumes the target value of the feedback is 10,000.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 66e190f0374a..9df6b8819998 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -62,6 +62,21 @@ static struct damos_quota damon_reclaim_quota = {
 };
 DEFINE_DAMON_MODULES_DAMOS_QUOTAS(damon_reclaim_quota);
 
+/*
+ * User-specifiable feedback for auto-tuning of the effective quota.
+ *
+ * While keeping the caps that set by other quotas, DAMON_RECLAIM automatically
+ * increases and decreases the effective level of the quota aiming receiving this
+ * feedback of value ``10,000`` from the user.  DAMON_RECLAIM assumes the feedback
+ * value and the quota are positively proportional.  Value zero means disabling
+ * this auto-tuning feature.
+ *
+ * Disabled by default.
+ *
+ */
+static unsigned long quota_autotune_feedback __read_mostly;
+module_param(quota_autotune_feedback, ulong, 0600);
+
 static struct damos_watermarks damon_reclaim_wmarks = {
 	.metric = DAMOS_WMARK_FREE_MEM_RATE,
 	.interval = 5000000,	/* 5 seconds */
@@ -159,11 +174,13 @@ static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
 	dst->charged_from = src->charged_from;
 	dst->charge_target_from = src->charge_target_from;
 	dst->charge_addr_from = src->charge_addr_from;
+	dst->esz_bp = src->esz_bp;
 }
 
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damos *scheme, *old_scheme;
+	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
 	int err = 0;
 
@@ -180,6 +197,17 @@ static int damon_reclaim_apply_parameters(void)
 			damon_reclaim_copy_quota_status(&scheme->quota,
 					&old_scheme->quota);
 	}
+
+	if (quota_autotune_feedback) {
+		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
+		if (!goal) {
+			damon_destroy_scheme(scheme);
+			return -ENOMEM;
+		}
+		goal->current_value = quota_autotune_feedback;
+		damos_add_quota_goal(&scheme->quota, goal);
+	}
+
 	if (skip_anon) {
 		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
 		if (!filter) {
-- 
2.39.2


