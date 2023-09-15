Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F57A1407
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjIOCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjIOCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:53:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BB2719
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:53:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755C8C433C9;
        Fri, 15 Sep 2023 02:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746390;
        bh=54IK7cTm7KTNNX3XLRdWLVNJIup7inyJ/KiBfKYDcxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSK3bW5SwDXeS5zPCPPJiBwfd5vAIC7cx1I5DGDc3g1gvuXMCm8OZyYZaFTizCXr6
         IGsoW8btGA90xigquM8091rNDyfmkhLNZwW7AIw8V9/opp1tvo1+424tjJaU6cby3j
         I/vcCzrwXGjBievjJ4k0LmkDlgt7Vpsff/hAU6iCuuvjFBQdjenQIAcfFr6mVvqAxE
         lvVQoEfYtTh4DFK+Os4lxuxXzBf8ovK+gvvU36ZpNYmDj0Q6OOWQtg+hcgCSutY3O4
         y0w09Gspx4AymqefNtFvvOVgLXTTfoD0VfrvZtP6/fxVMSrz1FavT9eJGsqjrrSzLS
         oT47TwypudG+g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] mm/damon/core: skip updating nr_accesses_bp for each aggregation interval
Date:   Fri, 15 Sep 2023 02:52:50 +0000
Message-Id: <20230915025251.72816-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915025251.72816-1-sj@kernel.org>
References: <20230915025251.72816-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_merge_regions_of(), which is called for each aggregation interval,
updates nr_accesses_bp to nr_accesses * 10000.  However, nr_accesses_bp
is updated for each sampling interval via damon_moving_sum() using the
aggregation interval as the moving time window.  And by the definition
of the algorithm, the value becomes same to discrete-window based sum
for each time window-aligned time.  Hence, nr_accesses_bp will be same
to nr_accesses * 10000 for each aggregation interval without explicit
update.  Remove the unnecessary update of nr_accesses_bp in
damon_merge_regions_of().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 29ee1fc18393..45cc108c0fe1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1141,8 +1141,6 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 		else
 			r->age++;
 
-		r->nr_accesses_bp = r->nr_accesses * 10000;
-
 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
 		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
-- 
2.25.1

