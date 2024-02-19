Return-Path: <linux-kernel+bounces-71882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADC885AC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11565B221E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3A524DA;
	Mon, 19 Feb 2024 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX9paEie"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6251C49;
	Mon, 19 Feb 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371879; cv=none; b=bHea+bJz5xcBsCydAqPL70HIcw5j13iglNBGFPwyJ68R2UREvodZWdToBdByMjj1nNmlTvIG3ewUysdqql0AP9g8PrJcAfd8JIpFH4W4lI7UCMIvZxv1hlHpUdeTqQxuDOjK0pK9Baap4BuVwvsqOswtInCC+bIX1ylRJcbTqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371879; c=relaxed/simple;
	bh=d9LlALHiCfhiFh3lfhrepX1jc1b9cJAF+/9AGNt4qgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iajp50yAmGzk4cRtajP881ytLXFXrrGXcnNBi4qRb4nLEKNTtQ7iSCMc5vJsXBWWIrKEsFTLTsN8GNeTlyFlQVq05UyQNgRoTmNykgDCwTidQgAaD/c6uNK5MwNksteBfsLGtPRmJz7+Dwtrg2rLsZqLOxCmZ7V0B80fr9ZIRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX9paEie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13681C433B1;
	Mon, 19 Feb 2024 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371879;
	bh=d9LlALHiCfhiFh3lfhrepX1jc1b9cJAF+/9AGNt4qgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lX9paEieqsiLEM6ItX40DG83FoS+BVepX8gzH32254OLWTtBWI+pg31scSWLMWDJO
	 GGNt/pSlFCUeH11AZGf9BctaR37ARnCtn1SfAL6koonIlexRk8n/9D1FEWg1OBmnx5
	 V7Q0BaN7U19dLpeuk5L6/UvDx081fJVf8OqUjh9pXyVbMmtNhAs1Y5TG4esBp/TLF2
	 gNWo+SwxA8YPMogR5Z6XEx7SBxZryYYfep794y3jfF2rm4/1enu3XGHv3IiXiN4v4M
	 476v8cI23J4qe7PzLEf+xrPgVXo1lMqliX1rPD09v612FyMdnJBq75Xj9faG5232RG
	 Jnre6Sp+zmveQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/20] mm/damon/core: Set damos_quota->esz as public field and document
Date: Mon, 19 Feb 2024 11:44:12 -0800
Message-Id: <20240219194431.159606-2-sj@kernel.org>
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

DAMOS allow users to specify the quota as they want in multiple ways
including time quota, size quota, and feedback-based auto-tuning.  DAMOS
makes one effective quota out of the inputs and use it at the end.
Knowing the current effective quota helps understanding DAMOS' internal
mechanism and fine-tuning quotas.  DAMON kernel API users can get the
information from ->esz field of damos_quota struct, but the field is
marked as private purpose, and not kernel-doc documented.  Make it
public and document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++--
 mm/damon/core.c       | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5881e4ac30be..93ef45b87b9c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -138,6 +138,7 @@ enum damos_action {
  *
  * @get_score:		Feedback function for self-tuning quota.
  * @get_score_arg:	Parameter for @get_score
+ * @esz:		Effective size quota in bytes.
  *
  * To avoid consuming too much CPU time or IO resources for applying the
  * &struct damos->action to large memory, DAMON allows users to set time and/or
@@ -167,6 +168,8 @@ enum damos_action {
  * tuning is getting the feedback screo value of 10,000.  If @ms and/or @sz are
  * set together, those work as a hard limit quota.  If neither @ms nor @sz are
  * set, the mechanism starts from the quota of one byte.
+ *
+ * The resulting effective size quota in bytes is set to @esz.
  */
 struct damos_quota {
 	unsigned long ms;
@@ -179,14 +182,13 @@ struct damos_quota {
 
 	unsigned long (*get_score)(void *arg);
 	void *get_score_arg;
+	unsigned long esz;
 
 /* private: */
 	/* For throughput estimation */
 	unsigned long total_charged_sz;
 	unsigned long total_charged_ns;
 
-	unsigned long esz;	/* Effective size quota in bytes */
-
 	/* For charging the quota */
 	unsigned long charged_sz;
 	unsigned long charged_from;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5b325749fc12..0656966a6fc4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -299,12 +299,12 @@ void damos_destroy_filter(struct damos_filter *f)
 	damos_free_filter(f);
 }
 
-/* initialize private fields of damos_quota and return the pointer */
-static struct damos_quota *damos_quota_init_priv(struct damos_quota *quota)
+/* initialize fields of @quota that normally API users wouldn't set */
+static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 {
+	quota->esz = 0;
 	quota->total_charged_sz = 0;
 	quota->total_charged_ns = 0;
-	quota->esz = 0;
 	quota->charged_sz = 0;
 	quota->charged_from = 0;
 	quota->charge_target_from = NULL;
@@ -336,7 +336,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota = *(damos_quota_init_priv(quota));
+	scheme->quota = *(damos_quota_init(quota));
 
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
-- 
2.39.2


