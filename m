Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16DC799625
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbjIIDho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbjIIDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970491FE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD2AC433CC;
        Sat,  9 Sep 2023 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230648;
        bh=T2wTbeMBvGg1oZ8nMQI/oEwy81mbG221hI8+18jJewo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M330diVcv9Kv8EFldGI7s8B5vCDzjiNiU4H2nlTH8r7+IiEwi5kUPhPW/GuRSKP5x
         v3IyZOtLRDLVfZ2WPK8Zkz9IrzCPN0ZTJ9nO4TsUmxF7xs9lVlqAAkfd8jXu6wYtVQ
         91yY3g+LT32JKjm2Xx94XGmfyFt0XxQ+YkNTnDOHU8NosYA/liDzlDbrc+3MfWXejp
         IjwVRkebxbYSQ9sVjy87LpHF4LPtnNfK3UypHePRMR6wW33HnXGYmLjfFlhsTo67gU
         8tbGUIUCWUodMZey4IKMSr8S4w70YMr164pmXvOXKWrnX1zKb/ZXBBK6k538Mu2WF8
         ZZvnEWTpJZY6A==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 7/8] mm/damon/core: skip updating nr_accesses_bp for each aggregation interval
Date:   Sat,  9 Sep 2023 03:37:10 +0000
Message-Id: <20230909033711.55794-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909033711.55794-1-sj@kernel.org>
References: <20230909033711.55794-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
index c813407c09b4..1ba7c4669263 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1182,8 +1182,6 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 		else
 			r->age++;
 
-		r->nr_accesses_bp = r->nr_accesses * 10000;
-
 		if (prev && prev->ar.end == r->ar.start &&
 		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
 		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
-- 
2.25.1

