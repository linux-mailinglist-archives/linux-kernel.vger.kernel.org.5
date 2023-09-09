Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C59799622
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241202AbjIIDhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjIIDha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482BC1FE3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8618BC433CD;
        Sat,  9 Sep 2023 03:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230645;
        bh=1JPnDKE1W//tJKT6oD5avrUOMToQr068Qq2WbN1Xk+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rusog3teG9hcnEOtFyrYq2Kl4tI6tcDkZHp8n1Y4H16VjWB/4DsOGZfuLTLsJm8nS
         /KC1kgaBiz/iwm9Mr+LOZkYK+jSgGPPIWvD+2zxifQDAR46fduvL1wLbxmfj2msgTQ
         pN/SHQdgeA2UmefHF2RbIODyciN8YusgRbTKifrDqmCndCNyUO66LeDAEmPihhRw9T
         837t6pOuHXZ4rYjplr0cE5XHFi7BnwTZs4HC4CQl6RKBSfh3FuScz6o/+wAcle06Xz
         YZ1V1VZ2DLJma6bJ/qucOOstW6arYNziXh8dDPJl00i1FKQEKo70rgEhWHM1nRFZpX
         tjCjSSs1RtP5w==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 3/8] mm/damon/core: implement a pseudo-moving sum function
Date:   Sat,  9 Sep 2023 03:37:06 +0000
Message-Id: <20230909033711.55794-4-sj@kernel.org>
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

For values that continuously change, moving average or sum are good ways
to provide fast updates while handling temporal and errorneous
variability of the value.  For example, the access rate counter
(nr_accesses) is calculated as a sum of the number of positive sampled
access check results that collected during a discrete time window
(aggregation interval), and hence it handles temporal and errorneous
access check results, but provides the update only for every aggregation
interval.  Using a moving sum method for that could allow providing the
value for every sampling interval.  That could be useful for getting
monitoring results snapshot or running DAMOS in fine-grained timing.

However, supporting the moving sum for cases that number of samples in
the time window is arbirary could impose high overhead, since the number
of past values that it needs to keep could be too high.  The nr_accesses
would also be one of the cases.  To mitigate the overhead, implement a
pseudo-moving sum function that only provides an estimated pseudo-moving
sum.  It assumes there was no error in last discrete time window and
subtract constant portion of last discrete time window sum.

Note that the function is not strictly implementing the moving sum, but
it keeps a property of moving sum, which makes the value same to the
dsicrete-window based sum for each time window-aligned timing.  Hence,
people collecting the value in the old timings would show no difference.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 17c504d236b9..487a545a11b4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -622,6 +622,8 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
+unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
+		unsigned int len_window, unsigned int new_value);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3d51a1dfe104..5bc0544b9f50 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1589,6 +1589,46 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 	return damon_set_regions(t, &addr_range, 1);
 }
 
+/*
+ * damon_moving_sum() - Calculate an inferred moving sum value.
+ * @mvsum:	Inferred sum of the last @len_window values.
+ * @nomvsum:	Non-moving sum of the last discrete @len_window window values.
+ * @len_window:	The number of last values to take care of.
+ * @new_value:	New value that will be added to the pseudo moving sum.
+ *
+ * Moving sum (moving average * window size) is good for handling noise, but
+ * the cost of keeping past values can be high for arbitrary window size.  This
+ * function implements a lightweight pseudo moving sum function that doesn't
+ * keep the past window values.
+ *
+ * It simply assumes there was no noise in the past, and get the no-noise
+ * assumed past value to drop from @nomvsum and @len_window.  @nomvsum is a
+ * non-moving sum of the last window.  For example, if @len_window is 10 and we
+ * have 25 values, @nomvsum is the sum of the 11th to 20th values of the 25
+ * values.  Hence, this function simply drops @nomvsum / @len_window from
+ * given @mvsum and add @new_value.
+ *
+ * For example, if @len_window is 10 and @nomvsum is 50, the last 10 values for
+ * the last window could be vary, e.g., 0, 10, 0, 10, 0, 10, 0, 0, 0, 20.  For
+ * calculating next moving sum with a new value, we should drop 0 from 50 and
+ * add the new value.  However, this function assumes it got value 5 for each
+ * of the last ten times.  Based on the assumption, when the next value is
+ * measured, it drops the assumed past value, 5 from the current sum, and add
+ * the new value to get the updated pseduo-moving average.
+ *
+ * This means the value could have errors, but the errors will be disappeared
+ * for every @len_window aligned calls.  For example, if @len_window is 10, the
+ * pseudo moving sum with 11th value to 19th value would have an error.  But
+ * the sum with 20th value will not have the error.
+ *
+ * Return: Pseudo-moving average after getting the @new_value.
+ */
+unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
+		unsigned int len_window, unsigned int new_value)
+{
+	return mvsum - nomvsum / len_window + new_value;
+}
+
 /**
  * damon_update_region_access_rate() - Update the access rate of a region.
  * @r:		The DAMON region to update for its access check result.
-- 
2.25.1

