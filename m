Return-Path: <linux-kernel+bounces-71887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14C85AC35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014FD1F23030
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7D54BE8;
	Mon, 19 Feb 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgOgZmiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629653E31;
	Mon, 19 Feb 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371883; cv=none; b=kmOBgPmFvclurbJsNCt+90AMBbnnWnVMA1nBO5WbUTyXJvqghPnhbpUQTD/n4a/avJ5rwyFwOjBRVcZ1aZLNt46YV56gx39Z2h5y7dJhekNb/H295RrGBHVZGroiSr8PViYp3T1PBRBuwS73gi18dxwPmv2FVBiGmrEyMeoXp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371883; c=relaxed/simple;
	bh=Qrt8JsNV5WkN+0gJ5TqfdjaJcuo1NKzpe3AmVI9CrWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCTBwq3xCTJycp6vv8NZDE4acYOBB0zLetJIHeawFmSaopE65LjO8OIvRnyV8y4PELcKSy0qj1VuhArDB9+IZBU+sNkmZBytjAvlAc8cqxAvzTv69/VAY7vXIluVWThb+bBlPnmLYzy5f9o0pdXpfOt6CS8Y2mLBE7YahLrwCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgOgZmiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257E6C433A6;
	Mon, 19 Feb 2024 19:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371882;
	bh=Qrt8JsNV5WkN+0gJ5TqfdjaJcuo1NKzpe3AmVI9CrWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgOgZmiUq1dFACJWkzSo40xUY0CWmo3HkcrEs3Qntc04KmTD4ie048M4w7bSaDvGe
	 X3uAWqEpQJnp5rIcb9NO63LE6exscXEK2a7FrdEhAnUsYNjMOXHS9hx7vrtqgAa8Ww
	 N9eKU4ocm7Y6VVhmKolxeOUC69Ksq6HGnop1dAPJ6Sr4ZYdu/KVTVcVAzkQ9fUJfu4
	 Dtl+wq7VEg/lbpHNeevT31JTyjyQb9n9Iajdj6MHNetRMx95jh+nQSuTKvJDznV4hn
	 JqBZMBaAYQyzGoXXA/SPyGlrDPXu66aXtoxujWaavGaBVXHfobr5Er2PGN5moe/tt5
	 B8X6f3vRLzZag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] mm/damon: move comments and fields for damos-quota-prioritization to the end
Date: Mon, 19 Feb 2024 11:44:17 -0800
Message-Id: <20240219194431.159606-7-sj@kernel.org>
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

The comments and definition of 'struct damos_quota' lists a few fields
for effective quota generation first, fields for regions prioritization
under the quota, and then remaining fields for effective quota
generation.  Readers' should unnecesssarily switch their context in the
middle.  List all the fields for the effective quota first, and then
fields for the prioritization for making it easier to read.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 93ef45b87b9c..bd17b14828bc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -128,18 +128,17 @@ enum damos_action {
 
 /**
  * struct damos_quota - Controls the aggressiveness of the given scheme.
+ * @reset_interval:	Charge reset interval in milliseconds.
  * @ms:			Maximum milliseconds that the scheme can use.
  * @sz:			Maximum bytes of memory that the action can be applied.
- * @reset_interval:	Charge reset interval in milliseconds.
+ * @get_score:		Feedback function for self-tuning quota.
+ * @get_score_arg:	Parameter for @get_score
+ * @esz:		Effective size quota in bytes.
  *
  * @weight_sz:		Weight of the region's size for prioritization.
  * @weight_nr_accesses:	Weight of the region's nr_accesses for prioritization.
  * @weight_age:		Weight of the region's age for prioritization.
  *
- * @get_score:		Feedback function for self-tuning quota.
- * @get_score_arg:	Parameter for @get_score
- * @esz:		Effective size quota in bytes.
- *
  * To avoid consuming too much CPU time or IO resources for applying the
  * &struct damos->action to large memory, DAMON allows users to set time and/or
  * size quotas.  The quotas can be set by writing non-zero values to &ms and
@@ -152,12 +151,6 @@ enum damos_action {
  * throughput of the scheme's action.  DAMON then compares it against &sz and
  * uses smaller one as the effective quota.
  *
- * For selecting regions within the quota, DAMON prioritizes current scheme's
- * target memory regions using the &struct damon_operations->get_scheme_score.
- * You could customize the prioritization logic by setting &weight_sz,
- * &weight_nr_accesses, and &weight_age, because monitoring operations are
- * encouraged to respect those.
- *
  * If @get_score function pointer is set, DAMON calls it back with
  * @get_score_arg and get the return value of it for every @reset_interval.
  * Then, DAMON adjusts the effective quota using the return value as a feedback
@@ -170,20 +163,25 @@ enum damos_action {
  * set, the mechanism starts from the quota of one byte.
  *
  * The resulting effective size quota in bytes is set to @esz.
+ *
+ * For selecting regions within the quota, DAMON prioritizes current scheme's
+ * target memory regions using the &struct damon_operations->get_scheme_score.
+ * You could customize the prioritization logic by setting &weight_sz,
+ * &weight_nr_accesses, and &weight_age, because monitoring operations are
+ * encouraged to respect those.
  */
 struct damos_quota {
+	unsigned long reset_interval;
 	unsigned long ms;
 	unsigned long sz;
-	unsigned long reset_interval;
+	unsigned long (*get_score)(void *arg);
+	void *get_score_arg;
+	unsigned long esz;
 
 	unsigned int weight_sz;
 	unsigned int weight_nr_accesses;
 	unsigned int weight_age;
 
-	unsigned long (*get_score)(void *arg);
-	void *get_score_arg;
-	unsigned long esz;
-
 /* private: */
 	/* For throughput estimation */
 	unsigned long total_charged_sz;
-- 
2.39.2


