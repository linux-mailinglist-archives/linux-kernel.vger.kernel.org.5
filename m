Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33D9796EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbjIGC36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbjIGC3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B621BCC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:29:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86713C433CB;
        Thu,  7 Sep 2023 02:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053783;
        bh=vRYmypXxVu4qyBFRsVgWGOXy10baQDAbK4q5Co5NXh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlP28eTvxlZIfTv787ShyqGqsODexay16ibiTx1Diaxx+5FsRbtNpcWuURBIEOMiI
         MVGKGITV1obC+0nnb1wK5BP+LzyRRcd22VUneG4Do06WAlT3yR5Cd4F5A9REjPyqBs
         37dj2ZaxtE7cCscAaXS3ulztigwpy2rxfNIB/MP1lbmzWgDIRBSYzFZ5uX3duR5pRS
         34mSNwMpDpPDvZaq1aJb+hbu3YNtVwi4x9LJOwcXDyF89pA615ep4hmc4QbMa62sh/
         HR+4gHtb2WSAAsdQ53ZSq8MRmZsVIpt6LNlSWFJHAhzOnHHSDJPv6qce6YRagf/g2j
         OkLTbEuTqmVSA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] mm/damon/core: add more comments for nr_accesses
Date:   Thu,  7 Sep 2023 02:29:27 +0000
Message-Id: <20230907022929.91361-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
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

The comment on struct damon_region about nr_accesses field looks not
sufficient.  Many people actually used to ask what nr_accesses mean.
There is more detailed explanation of the mechanism on the comment for
struct damon_attrs, but it is also ambiguous, as it doesn't specify the
name of the counter for aggregating the access check results.  Make
those more detailed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ae2664d1d5f1..266f92b34dd2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -43,6 +43,10 @@ struct damon_addr_range {
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
+ * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
+ * increased for every &damon_attrs->sample_interval if an access to the region
+ * during the last sampling interval is found.
+ *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -472,13 +476,14 @@ struct damon_callback {
  *				regions.
  *
  * For each @sample_interval, DAMON checks whether each region is accessed or
- * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for @aggr_interval time.  DAMON also checks whether the target
- * memory regions need update (e.g., by ``mmap()`` calls from the application,
- * in case of virtual memory monitoring) and applies the changes for each
- * @ops_update_interval.  All time intervals are in micro-seconds.
- * Please refer to &struct damon_operations and &struct damon_callback for more
- * detail.
+ * not during the last @sample_interval.  If such access is found, DAMON
+ * aggregates the information by increasing &damon_region->nr_accesses for
+ * @aggr_interval time.  For each @aggr_interval, the count is reset.  DAMON
+ * also checks whether the target memory regions need update (e.g., by
+ * ``mmap()`` calls from the application, in case of virtual memory monitoring)
+ * and applies the changes for each @ops_update_interval.  All time intervals
+ * are in micro-seconds.  Please refer to &struct damon_operations and &struct
+ * damon_callback for more detail.
  */
 struct damon_attrs {
 	unsigned long sample_interval;
-- 
2.25.1

