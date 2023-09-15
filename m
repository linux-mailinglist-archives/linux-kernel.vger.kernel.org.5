Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550587A1403
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjIOCxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjIOCxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:53:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68222707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:53:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5EEC433C9;
        Fri, 15 Sep 2023 02:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746385;
        bh=1bmqeGHeOEZ2+59SSNfs3s06RBUS+Jm7Zbyglu1mAv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pq35bGOVZLCqwdN44XaOtHhtXWKjJs4HFDnB6LU85Y8bqJGxt1jDLEDCJU2EyKY+O
         YX5rUFZ2j1WYGzXpnC7MZBLFG2mDmvZeEfZdKl41qov99fPrnnqoh+cNnRDJkUYL3p
         rFdgb+uAr4opnrxmKSWOZexjjdsFRCkMkgrfNixVpJCRtruxa93AEdCyE1NRTx291T
         ro0iKYQKhKzXv3roZ+Ja5LGJ073h+DG/Vps8OkaCtQV1TNatAvCkVTNcX7c/2nEbsz
         hABBbXn7jgj5tI+nARlpwXKPSnM88OeQJWahUNlym4aIYY5r7PefSlPgceGMj0AeCt
         I0BpGP+LqEcKA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] mm/damon/core: implement a pseudo-moving sum function
Date:   Fri, 15 Sep 2023 02:52:46 +0000
Message-Id: <20230915025251.72816-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915025251.72816-1-sj@kernel.org>
References: <20230915025251.72816-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 10532159323a..b005dc15009f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1549,6 +1549,46 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
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

