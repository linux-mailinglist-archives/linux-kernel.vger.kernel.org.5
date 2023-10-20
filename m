Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06247D14CD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377935AbjJTRXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377916AbjJTRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067511B;
        Fri, 20 Oct 2023 10:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62BEC433CB;
        Fri, 20 Oct 2023 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697822607;
        bh=6lmYsv8XJqW/eM+lXLzhU7HxZ5CdX1w8lmt0qOdrzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHtmFc93b57yZn/bDpAh7gBhcfHbj20IeY+fuu4053yIw8MoFaaDnmQ0MsrNV8IEo
         X1ZOjlEl1Kmq4ngCLAeoC0621PhULQJp8lkT0Kw5Kc+APiSyMONoLooY1MQILhnSDk
         1W2Lt47fEK5O7FwRtUdgtoRCWawLtS8RrNJAvD6jDE3sWD3ipUbb1AYqpnahNa2Anz
         tLyFDzmIrQ4k/2QD4TQMawE617DS+D+Cktc6QL7UdhoZ140dK+/y11tdkGzEEIlkn7
         D8LoBKqBNUcwmM8as1ufxtbE2HDuPWHtSNOJh3KGLxL+1+9gAKAdCjl0b2J+e8c26P
         Q5JlslM9OsQqQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jakub Acs <acsjakub@amazon.de>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 4/5] mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
Date:   Fri, 20 Oct 2023 17:23:16 +0000
Message-Id: <20231020172317.64192-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020172317.64192-1-sj@kernel.org>
References: <20231020172317.64192-1-sj@kernel.org>
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

When calculating the hotness threshold for lru_prio scheme of
DAMON_LRU_SORT, the module divides some values by the maximum
nr_accesses.  However, due to the type of the related variables, simple
division-based calculation of the divisor can return zero.  As a result,
divide-by-zero is possible.  Fix it by using damon_max_nr_accesses(),
which handles the case.

Reported-by: Jakub Acs <acsjakub@amazon.de>
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 3ecdcc029443..f2e5f9431892 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -195,9 +195,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
-	/* aggr_interval / sample_interval is the maximum nr_accesses */
-	hot_thres = damon_lru_sort_mon_attrs.aggr_interval /
-		damon_lru_sort_mon_attrs.sample_interval *
+	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
 		hot_thres_access_freq / 1000;
 	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!scheme)
-- 
2.34.1

