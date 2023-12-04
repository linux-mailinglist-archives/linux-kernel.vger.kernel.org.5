Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCECB803B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjLDRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjLDRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:01:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E8CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:01:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5F8C433C7;
        Mon,  4 Dec 2023 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701709269;
        bh=PrQN3LxsLo0hnYtX+mHxOw3BE7UQ018hcELFYEAwoxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iGvBZLtYs7yHtlLTahRlEyaMg77PkPNKCUnY79j+4a+CQ0rzo/s8oWQILhuPdvPah
         DXg32bDyS/S+oRwZ/rTx+ePKScRNqgIcPlsFAlXdMrwxfzGqc/48qdxze/hx9zZHv4
         FfghEKC/+5gGgaUZUYSWaVNMcBHvC9WDKTVAyXUxCVQle9dgrLwZnKVMwRjumzvyKy
         HbwQ/G80otDrUBS13rwTJK+5hCsXWO8VYjkXJ2AmSvqeNrKo26vG+Mbn2ej+ak+6lJ
         PbYedmzbC9cXA0f/a4J9cx2Kos0QLDzgLekg7WZItSI4QvlSTYhLxm1CwwCc8yiVcC
         BIrLl4SrYaj5Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable] mm/damon: document get_score_arg field of struct damos_quota
Date:   Mon,  4 Dec 2023 17:01:06 +0000
Message-Id: <20231204170106.60992-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 99b36eab9c05 ("mm/damon/core: implement goal-oriented
feedback-driven quota auto-tuning") on mm-unstable missed documenting
'get_score_arg' field of 'struct damos_quota' on the kernel-doc comment.
Fix it.

Fixes: 99b36eab9c05 ("mm/damon/core: implement goal-oriented feedback-driven quota auto-tuning") on mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 508a262418a2..aa34ab433bc5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -137,6 +137,7 @@ enum damos_action {
  * @weight_age:		Weight of the region's age for prioritization.
  *
  * @get_score:		Feedback function for self-tuning quota.
+ * @get_score_arg:	Parameter for @get_score
  *
  * To avoid consuming too much CPU time or IO resources for applying the
  * &struct damos->action to large memory, DAMON allows users to set time and/or
@@ -156,10 +157,10 @@ enum damos_action {
  * &weight_nr_accesses, and &weight_age, because monitoring operations are
  * encouraged to respect those.
  *
- * If @get_score function pointer is set, DAMON calls it back and get the
- * return value of it for every @reset_interval.  Then, DAMON adjusts the
- * effective quota using the return value as a feedback score to the current
- * quota, using its internal feedback loop algorithm.
+ * If @get_score function pointer is set, DAMON calls it back with
+ * @get_score_arg and get the return value of it for every @reset_interval.
+ * Then, DAMON adjusts the effective quota using the return value as a feedback
+ * score to the current quota, using its internal feedback loop algorithm.
  *
  * The feedback loop algorithem assumes the quota input and the feedback score
  * output are in a positive proportional relationship, and the goal of the
-- 
2.34.1

