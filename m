Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B425D7FE702
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjK3CiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbjK3CiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:38:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17510FF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC1AC433CC;
        Thu, 30 Nov 2023 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311822;
        bh=EtcCE3aKL92GHTdnkP2hxrtGMR/ShXKbIT2mRyd4U4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6+6tCLIAdAhswg3GRnBOLmuTKm3/4K740cV/qZXqJeePCyk2PGDIM6hlz0JUF59h
         CwnfWJGwv/ma6uevYQizY7w2KoKUhBrqhYWeTl81RNPi8QNGZA710/IYqgNHFbpUFW
         jJ+B1MncEdyn4JY3Jr0tTxCUn4DI6onqGmUXvzSH9tCs5RBeYcbVXy2FIVA1Bx5Wx5
         perHVTael5dUoP8C/cTLFdstUUTFfXURD7Yc5WTb/uyFBVMRv/1jHhviCMBe00BkaS
         hfRoAuBG2WvyMptpLHFtLh1Hly+Atkns970LzE3OI3+Bb6MT12dFC25mvAtidZSgUH
         qwYEgT3+dO6Xg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] mm/damon/core-test: add a unit test for the feedback loop algorithm
Date:   Thu, 30 Nov 2023 02:36:48 +0000
Message-Id: <20231130023652.50284-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
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

Implement a simple kunit test for testing the behavior of the feedback
loop algorithm for the aim-oriented feedback-friven DAMOS aggressiveness
auto tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index e6a01ea2ec54..6e5e9502d648 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -446,6 +446,37 @@ static void damos_test_filter_out(struct kunit *test)
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
@@ -461,6 +492,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
+	KUNIT_CASE(damon_test_feed_loop_next_input),
 	{},
 };
 
-- 
2.34.1

