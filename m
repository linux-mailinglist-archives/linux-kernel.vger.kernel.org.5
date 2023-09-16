Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120437A2D53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbjIPCKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjIPCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:10:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D6173C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:09:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC149C433C8;
        Sat, 16 Sep 2023 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694830196;
        bh=VEo1bT4L3oASolFpAiFgoKtkxwTv3u9FxZ+yfBw7tjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DE5n19QTrLA/q3MCbj6txVWl1uVLgvfvimtQFgvcddmHPnYMGBO3fFDzwOKCAE1Ea
         6ZYLcxHkm5CTWFprrqRjF2KtaYm2Pz1lRDiwdDYTuq77AJA0RSUh5o65EYEXrOnEHs
         xWMKylLYUB2wBv7QR/yROAzDf7cNTsquwx29G72dwKWAZ+EmwIigZOPRJm/YCHaQd8
         oGtGCMonOLobfZnVSyKN0ZWlbECSyGnvfq2vefdC/SACWvKlxDcHJ9gAJk10AUBeAe
         OUhBoRM9HauQyDIauN7P46WxsCKPvr3KFTi/4wXKmwRabKlNI1DRkIECckLti/Mt8P
         t2+3IdJ/6uTGA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mm/damon/core: make DAMOS uses nr_accesses_bp instead of nr_accesses
Date:   Sat, 16 Sep 2023 02:09:37 +0000
Message-Id: <20230916020945.47296-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON provides nr_accesses_bp, which becomes same to nr_accesses * 10000
for every aggregation interval, but updated every sampling interval with
a reasonable accuracy.  Since DAMON-based operation schemes are applied
in every aggregation interval using nr_accesses, using nr_accesses_bp
instead will make no difference to users.  Meanwhile, it allows DAMOS to
apply the schemes in a time interval that less than the aggregation
interval.  It could be useful and more flexible for some cases.  Do it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b15cf47d2d29..79fef5145a4b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -770,12 +770,13 @@ static void damon_split_region_at(struct damon_target *t,
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;
+	unsigned int nr_accesses = r->nr_accesses_bp / 10000;
 
 	sz = damon_sz_region(r);
 	return s->pattern.min_sz_region <= sz &&
 		sz <= s->pattern.max_sz_region &&
-		s->pattern.min_nr_accesses <= r->nr_accesses &&
-		r->nr_accesses <= s->pattern.max_nr_accesses &&
+		s->pattern.min_nr_accesses <= nr_accesses &&
+		nr_accesses <= s->pattern.max_nr_accesses &&
 		s->pattern.min_age_region <= r->age &&
 		r->age <= s->pattern.max_age_region;
 }
-- 
2.25.1

