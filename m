Return-Path: <linux-kernel+bounces-69253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19E858645
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4374AB23529
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F913AA3E;
	Fri, 16 Feb 2024 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRYPNC/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE11384A6;
	Fri, 16 Feb 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112431; cv=none; b=lJU3NZP/RTLfNc+x7mRg4Iui7cOmBTjrfh3ZQQSAXrWDru5LOisx//1GG4raCTDjYcGlh3RcVE4dAhMGQgU2Ude3uLvgA9zBnIZQsCZbIXws1licfHmT5ctCVXa1cXrm0dWD2YCF8JALXmF2l9popdmozZSz+GyVWdXcTOSKmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112431; c=relaxed/simple;
	bh=etiMiObm+F9ASsbV6LLYp5TjRxnoRmCToWxcmcZj1K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5tTS0RB+G3tckBtkYdkoIlZBrjZv8B730+ImBe3g+lTjjexXdKbsNH1WPRasoDOdoXxVAst3wirc+36y1V86TAMqqY6zc5AZtw1flgTWemICN5QU2vLx39NOjXE0WqybZJwqO7Md2DdePuZm+EadG4Hu7j1EYEHZyX6Lb8QUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRYPNC/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D2BC43390;
	Fri, 16 Feb 2024 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112431;
	bh=etiMiObm+F9ASsbV6LLYp5TjRxnoRmCToWxcmcZj1K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRYPNC/ufDnWbXmlor3hTrxVpeLeQeqoH5Tg7VzdZ22oqQ3qLjlcQJGqBrWZcR5Ub
	 ouYrL/CbRvtNKpTdOFIQgPUaW+HhRLqCjz4l8rAGDGNrO52C4FMbK/n9mYfRqiHiPv
	 aGFG8KmoVc6K1f8gwozQf+vRPWxBoA52ltgfVCsadI+uVfMglPoyrlqnAO+KNtD+n1
	 1DvQocMmt7Xwv84fgFSDj4M3YX3JVe7P3r766bZ9OTsih9V3wg2dIz5eKUFtJed+uK
	 1lf7O5mydvMnqpnEVljBemydiL1kyxZV7erNndJb4784B1DYoDaZ76h0PWLOynQ65z
	 3gXRHCAU2KFCw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/lru_sort: fix quota status loss due to online tunings
Date: Fri, 16 Feb 2024 11:40:25 -0800
Message-Id: <20240216194025.9207-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216194025.9207-1-sj@kernel.org>
References: <20240216194025.9207-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For online parameters change, DAMON_LRU_SORT creates new schemes based
on latest values of the parameters and replaces the old schemes with the
new one.  When creating it, the internal status of the quotas of the old
schemes is not preserved.  As a result, charging of the quota starts
from zero after the online tuning.  The data that collected to estimate
the throughput of the scheme's action is also reset, and therefore the
estimation should start from the scratch again.  Because the throughput
estimation is being used to convert the time quota to the effective size
quota, this could result in temporal time quota inaccuracy.  It would be
recovered over time, though.  In short, the quota accuracy could be
temporarily degraded after online parameters update.

Fix the problem by checking the case and copying the internal fields for
the status.

Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index f2e5f9431892..3de2916a65c3 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -185,9 +185,21 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
+static void damon_lru_sort_copy_quota_status(struct damos_quota *dst,
+		struct damos_quota *src)
+{
+	dst->total_charged_sz = src->total_charged_sz;
+	dst->total_charged_ns = src->total_charged_ns;
+	dst->charged_sz = src->charged_sz;
+	dst->charged_from = src->charged_from;
+	dst->charge_target_from = src->charge_target_from;
+	dst->charge_addr_from = src->charge_addr_from;
+}
+
 static int damon_lru_sort_apply_parameters(void)
 {
-	struct damos *scheme;
+	struct damos *scheme, *hot_scheme, *cold_scheme;
+	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
@@ -195,18 +207,35 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
+	damon_for_each_scheme(scheme, ctx) {
+		if (!old_hot_scheme) {
+			old_hot_scheme = scheme;
+			continue;
+		}
+		old_cold_scheme = scheme;
+	}
+
 	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
 		hot_thres_access_freq / 1000;
-	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
-	if (!scheme)
+	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
+	if (!hot_scheme)
 		return -ENOMEM;
-	damon_set_schemes(ctx, &scheme, 1);
+	if (old_hot_scheme)
+		damon_lru_sort_copy_quota_status(&hot_scheme->quota,
+				&old_hot_scheme->quota);
 
 	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
-	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
-	if (!scheme)
+	cold_scheme = damon_lru_sort_new_cold_scheme(cold_thres);
+	if (!cold_scheme) {
+		damon_destroy_scheme(hot_scheme);
 		return -ENOMEM;
-	damon_add_scheme(ctx, scheme);
+	}
+	if (old_cold_scheme)
+		damon_lru_sort_copy_quota_status(&cold_scheme->quota,
+				&old_cold_scheme->quota);
+
+	damon_set_schemes(ctx, &hot_scheme, 1);
+	damon_add_scheme(ctx, cold_scheme);
 
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
-- 
2.39.2


