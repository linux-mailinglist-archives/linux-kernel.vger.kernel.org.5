Return-Path: <linux-kernel+bounces-69252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD6858642
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFCF2852E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7A138492;
	Fri, 16 Feb 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+2b+1Uq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B3137C34;
	Fri, 16 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112430; cv=none; b=jSCfu2X7OVhnCWtBAkmtuJhhCQJ41BG7BWPwjiWOsvftinQMd8OeDxpyeO00rB3W38xjmYtjzd79ONeZ1gf8FfYM91ITdzdYh8oZRiBm8SiGesZ9Jc2ccfwFwpk2nqR/oecJrKgYVCFCpxbXNDaK1bahJvRLCsom4pl1oSlboVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112430; c=relaxed/simple;
	bh=wFv2F9t2fMsiAoT3IOLKoZDJI+fzPndeClSvme5e6Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aSyXpxGe5b/15gzWvUvoV4TkqTBKgU6rJEe8Ipuoz6txFGcGdMPnLV+S50Ek18KsvA2L8dt0HiC5ALECVfFDHvm0FMRhbZedIvheectTiAgyoEhnG1Kg4HhSNcyuijd8508lzVbMAUKEwxGnGGLQe8KguxrkhYKLB5sqy5VSjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+2b+1Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07673C433C7;
	Fri, 16 Feb 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112430;
	bh=wFv2F9t2fMsiAoT3IOLKoZDJI+fzPndeClSvme5e6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+2b+1UqP2yCNcw/xOo31GOXP7ob/HXcyUZESmL35zWEyfjwA72ZHfBG93hbxOw4H
	 b2alqF+qJGJCVBCxlSrMtwQkFMuoxm6HfR33tAOZbnHUrek/7Zut81P9IA6mQJfnBa
	 zCqF11OuTF62r3qmmz1Wp8ZgKVPdQHIGBTwAPYtAtwvEjTuiHFchmV4dsP5fIsH/Q3
	 5fu7n0t/SOX3rS/qnU++vyVCgD+oCPW3Q6yNf7lJAwgmI33yoUHsD4c1rTso4uhliH
	 AcMAoMekLiF9FMbwCA2p14cO0terTjnbif1wn9OtfsoYioBaoK58P10N0mZ4HJVItL
	 z1iEuFR/MegUA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/reclaim: fix quota stauts loss due to online tunings
Date: Fri, 16 Feb 2024 11:40:24 -0800
Message-Id: <20240216194025.9207-2-sj@kernel.org>
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

Fixes: e035c280f6df ("mm/damon/reclaim: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ab974e477d2f..66e190f0374a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -150,9 +150,20 @@ static struct damos *damon_reclaim_new_scheme(void)
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
 	struct damos_filter *filter;
 	int err = 0;
 
@@ -164,6 +175,11 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		return -ENOMEM;
+	if (!list_empty(&ctx->schemes)) {
+		damon_for_each_scheme(old_scheme, ctx)
+			damon_reclaim_copy_quota_status(&scheme->quota,
+					&old_scheme->quota);
+	}
 	if (skip_anon) {
 		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
 		if (!filter) {
-- 
2.39.2


