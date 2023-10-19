Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7AE7D02C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346535AbjJSTtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbjJSTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:49:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F37114;
        Thu, 19 Oct 2023 12:49:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C9FC433CA;
        Thu, 19 Oct 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744972;
        bh=JxnxpQi8Ul6nOhB30Sf8ttPU+Mbj0MwnPDqKZ/PALpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/fE20KRyvJSGgRHegK3R+DBDTlM3NC4FaQxFC4fEJqSqwQHdqJucdhbh4cngKoMc
         4Rii7MDRtomRT4L7TDzKSxzplwSoImsmMyfa3pLNK93O+F5ZWCTyb7IQdswuPcgchl
         965fTzfU8pgybiLDqIrTq1WN72VSV27JSHJAoaMnrSmnzGcIde1GR1YtAwuXZXGr1W
         eg5GU5zj3caGORuA48hBOJgeswWu4AroqifVxo5HnxmR0uD99zC0Uig6ysPuqW9ijc
         ypsclOhxptVMU8Q7x6XKah1QWLn8ZPJiX2DEFntORfQiabj4NwIhRpZUTb/thUZHzA
         ufQlp0F+OjBaQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 4/5] mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
Date:   Thu, 19 Oct 2023 19:49:23 +0000
Message-Id: <20231019194924.100347-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

