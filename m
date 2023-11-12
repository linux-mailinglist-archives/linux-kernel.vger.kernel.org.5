Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB47E925B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjKLTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKLTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972E42139
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47C7C433C9;
        Sun, 12 Nov 2023 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818376;
        bh=aHVFSWkLgL3DSZk4BMjseldmOMFwERpUZXKvLSdezzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZqjkc6FTf18ZhcDORKrMuhByH+hD2Ss0jubtVf43EF5ai/X82RLUEbaKYzgzrYU9
         z6lLO2EUuHLi77rriepOZl7QKtaMC8Lnri0kYl1PYU209QyxwYWYWi9JCcsCDjorSY
         nX7TWmp0x/LbG5ORpd0gvkGY5iZ3V4vgnl0FRXB+P9gnFbOn20pXo3jAaOlyD6rwT3
         EMOH773xXOzjDJZwTk0G2KvHE4Vh6Lo3Loq7gL6WzItm5OgzbL5eYpkwesgfSh4aAc
         tfP0sImuju4Qi3qfRbyvnT60OF/mRJz+vhHo9fpIDgD5AGwY3tf9vxowqQUza3+BJo
         jkDyFPFq0/qnA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] mm/damon/core-test: add a unit test for the feedback loop algorithm
Date:   Sun, 12 Nov 2023 19:46:04 +0000
Message-Id: <20231112194607.61399-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a simple kunit test for testing the behavior of the core logic
of the goal-oriented feedback-driven DAMOS quota auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index f405d79dc623..c2b8cb25a195 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -447,6 +447,37 @@ static void damos_test_filter_out(struct kunit *test)
 	damos_free_filter(f);
 }
 
+static void damon_test_feed_loop_next_input(struct kunit *test)
+{
+	unsigned long last_input = 900000, current_score = 200;
+
+	/*
+	 * If current score is lower than the goal, which is always 10,000
+	 * (read the comment on damon_feed_loop_next_input()'s comment), next
+	 * input should be higher than the last input.
+	 */
+	KUNIT_EXPECT_GT(test,
+			damon_feed_loop_next_input(last_input, current_score),
+			last_input);
+
+	/*
+	 * If current score is higher than the goal, next input should be lower
+	 * than the last input.
+	 */
+	current_score = 250000000;
+	KUNIT_EXPECT_LT(test,
+			damon_feed_loop_next_input(last_input, current_score),
+			last_input);
+
+	/*
+	 * The next input depends on the distance between the current score and
+	 * the goal
+	 */
+	KUNIT_EXPECT_GT(test,
+			damon_feed_loop_next_input(last_input, 200),
+			damon_feed_loop_next_input(last_input, 2000));
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -463,6 +494,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
+	KUNIT_CASE(damon_test_feed_loop_next_input),
 	{},
 };
 
-- 
2.34.1

