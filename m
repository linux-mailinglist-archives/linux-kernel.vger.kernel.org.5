Return-Path: <linux-kernel+bounces-82714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB1A868884
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CCA2845B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4552F7E;
	Tue, 27 Feb 2024 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjMyloyL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD052F72;
	Tue, 27 Feb 2024 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010821; cv=none; b=SoG2iiAFBFO4987RhIxOzH67jrFdinP6DemoYlJPWPqKe+Dwqn9R5SeEnKVEgiv4boU1sPwJ+w7M5YJxx98QgptYRV/KHzaq3P9LNlZFsrtDLEhT84JEubmcunxlPyEI8yVvNP1+zhYY994iObq/IoC38bchpSXKJ4BQ9UINFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010821; c=relaxed/simple;
	bh=FblEoF14u0FQ5LBEx30aLU8aFDWw7vRlULlYczoacwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8F/MNdpZgKqZ8WYtYmVLKlcio94xD0LvBPcN9znsj3lhTwbJHk6Afr0hdaStDXW4xAzwMDSrhQXgtY4iHXokTLc4jFcqObSxQHIdQDvwUudq+vpi7qSEQ5SDFDJSb3h/ap46cyN63nrDyl3gGKeri2Nu9989MsTXsE7rWY/onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjMyloyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78257C433F1;
	Tue, 27 Feb 2024 05:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709010821;
	bh=FblEoF14u0FQ5LBEx30aLU8aFDWw7vRlULlYczoacwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjMyloyL3BblhgsKsNDeWWpXsxnbABWai9BH1FJqr4x4pd8ecOCvRPaTq1UMvd8h3
	 t/4/E3QEr8muoqLmo6aN/FyoRVhUpIGUdJswHHrGcaUDEZBiQ5LVgYuz90ptW9HGiu
	 IAWjKA7XnrS/aQpyCuXeYLxCdACLeJlTcvmm41QgTvtMPYq3R4rM0e9at/SE44CpSQ
	 q7hASP1AxOpMXazqp1bQ+8CR9y3zMGyxVFIHtMXjCo1DoiQWplwncG6eS2mqnQGVqX
	 QxFBMxUQRhdThwZj9ozJFZkf5RRXLxN2PDZAVyHTfFB4zXFh0wZKS6FxSxnmyS/t5a
	 aMIq/g2UUyRUQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/reclaim: fix quota stauts loss due to online tunings
Date: Mon, 26 Feb 2024 21:13:35 -0800
Message-Id: <20240227051335.168121-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024022643-scorn-filtrate-8677@gregkh>
References: <2024022643-scorn-filtrate-8677@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch series "mm/damon: fix quota status loss due to online tunings".

DAMON_RECLAIM and DAMON_LRU_SORT is not preserving internal quota status
when applying new user parameters, and hence could cause temporal quota
accuracy degradation.  Fix it by preserving the status.

This patch (of 2):

For online parameters change, DAMON_RECLAIM creates new scheme based on
latest values of the parameters and replaces the old scheme with the new
one.  When creating it, the internal status of the quota of the old
scheme is not preserved.  As a result, charging of the quota starts from
zero after the online tuning.  The data that collected to estimate the
throughput of the scheme's action is also reset, and therefore the
estimation should start from the scratch again.  Because the throughput
estimation is being used to convert the time quota to the effective size
quota, this could result in temporal time quota inaccuracy.  It would be
recovered over time, though.  In short, the quota accuracy could be
temporarily degraded after online parameters update.

Fix the problem by checking the case and copying the internal fields for
the status.

Link: https://lkml.kernel.org/r/20240216194025.9207-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20240216194025.9207-2-sj@kernel.org
Fixes: e035c280f6df ("mm/damon/reclaim: support online inputs update")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1b0ca4e4ff10a2c8402e2cf70132c683e1c772e4)
---
 mm/damon/reclaim.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 162c9b1ca00f..cc337e94acfd 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -141,9 +141,20 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&damon_reclaim_wmarks);
 }
 
+static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
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
 static int damon_reclaim_apply_parameters(void)
 {
-	struct damos *scheme;
+	struct damos *scheme, *old_scheme;
 	int err = 0;
 
 	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
@@ -154,6 +165,11 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
+	if (!list_empty(&ctx->schemes)) {
+		damon_for_each_scheme(old_scheme, ctx)
+			damon_reclaim_copy_quota_status(&scheme->quota,
+					&old_scheme->quota);
+	}
 	damon_set_schemes(ctx, &scheme, 1);
 
 	return damon_set_region_biggest_system_ram_default(target,
-- 
2.39.2


