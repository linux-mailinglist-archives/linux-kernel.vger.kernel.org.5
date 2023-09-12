Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430379D826
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbjILRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjILRzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:55:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEFC1;
        Tue, 12 Sep 2023 10:55:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC82FC433C9;
        Tue, 12 Sep 2023 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694541336;
        bh=Ko4/UwcgT3eF+DcCLkqCyN0KFTjfLGv5nyGKHZQ9hcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Er1pbDCrPsgoljrMA7EZu4PaPiK4QM/q0W5JqbtXFV8FolVzjwN/rrjYK+mg/2dnZ
         LIo+HwBY3cQ8yBBeBDM57UPLKJ+nZBzmWGz1+NFeojsx9LKFJfxjoubXUPwHGG7jDs
         O0IAOqRu6N12saJD9lDjBrgUDFulU69nztdX2n2yr+dej312vxW9Dfe3GfcLlxgaz1
         2MCg6w7STeRELdeErgKDnrD2bb7y32OHCi6EgAM1uc2YbOl4Qc9ZZCgT4nbnLB5WSa
         6W7hnodZ3RrtE+GWm8+nLjFfmfmMVe4f4j/jc1idaoaI7WWqPj/dIPyIC2UM8YqsBo
         gQYDj7fPGq53Q==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 2/2] clk: Parameterize clk_leaf_mux_set_rate_parent
Date:   Tue, 12 Sep 2023 10:55:31 -0700
Message-ID: <20230912175534.2427862-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230912175534.2427862-1-sboyd@kernel.org>
References: <20230912175534.2427862-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transform the existing clk_leaf_mux_set_rate_parent test into a
parameterized test that calls the various determine rate APIs that exist
for clk providers. This ensures that whatever determine rate API is used
by a clk provider will return the correct parent in the best_parent_hw
pointer of the clk_rate_request because clk_rate_requests are forwarded
properly.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk_test.c | 81 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 43e85fc0b025..39e2b5ff4f51 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2159,6 +2159,7 @@ struct clk_leaf_mux_ctx {
 	struct clk_hw hw;
 	struct clk_hw parent;
 	struct clk_rate_request *req;
+	int (*determine_rate_func)(struct clk_hw *hw, struct clk_rate_request *req);
 };
 
 static int clk_leaf_mux_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
@@ -2168,7 +2169,7 @@ static int clk_leaf_mux_determine_rate(struct clk_hw *hw, struct clk_rate_reques
 	struct clk_rate_request *parent_req = ctx->req;
 
 	clk_hw_forward_rate_request(hw, req, req->best_parent_hw, parent_req, req->rate);
-	ret = __clk_determine_rate(req->best_parent_hw, parent_req);
+	ret = ctx->determine_rate_func(req->best_parent_hw, parent_req);
 	if (ret)
 		return ret;
 
@@ -2246,20 +2247,83 @@ static void clk_leaf_mux_set_rate_parent_test_exit(struct kunit *test)
 	clk_hw_unregister(&ctx->mux_ctx.parents_ctx[1].hw);
 }
 
+struct clk_leaf_mux_set_rate_parent_determine_rate_test_case {
+	const char *desc;
+	int (*determine_rate_func)(struct clk_hw *hw, struct clk_rate_request *req);
+};
+
+static void
+clk_leaf_mux_set_rate_parent_determine_rate_test_case_to_desc(
+		const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case *t, char *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+static const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case
+clk_leaf_mux_set_rate_parent_determine_rate_test_cases[] = {
+	{
+		/*
+		 * Test that __clk_determine_rate() on the parent that can't
+		 * change rate doesn't return a clk_rate_request structure with
+		 * the best_parent_hw pointer pointing to the parent.
+		 */
+		.desc = "clk_leaf_mux_set_rate_parent__clk_determine_rate_proper_parent",
+		.determine_rate_func = __clk_determine_rate,
+	},
+	{
+		/*
+		 * Test that __clk_mux_determine_rate() on the parent that
+		 * can't change rate doesn't return a clk_rate_request
+		 * structure with the best_parent_hw pointer pointing to
+		 * the parent.
+		 */
+		.desc = "clk_leaf_mux_set_rate_parent__clk_mux_determine_rate_proper_parent",
+		.determine_rate_func = __clk_mux_determine_rate,
+	},
+	{
+		/*
+		 * Test that __clk_mux_determine_rate_closest() on the parent
+		 * that can't change rate doesn't return a clk_rate_request
+		 * structure with the best_parent_hw pointer pointing to
+		 * the parent.
+		 */
+		.desc = "clk_leaf_mux_set_rate_parent__clk_mux_determine_rate_closest_proper_parent",
+		.determine_rate_func = __clk_mux_determine_rate_closest,
+	},
+	{
+		/*
+		 * Test that clk_hw_determine_rate_no_reparent() on the parent
+		 * that can't change rate doesn't return a clk_rate_request
+		 * structure with the best_parent_hw pointer pointing to
+		 * the parent.
+		 */
+		.desc = "clk_leaf_mux_set_rate_parent_clk_hw_determine_rate_no_reparent_proper_parent",
+		.determine_rate_func = clk_hw_determine_rate_no_reparent,
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_leaf_mux_set_rate_parent_determine_rate_test,
+		  clk_leaf_mux_set_rate_parent_determine_rate_test_cases,
+		  clk_leaf_mux_set_rate_parent_determine_rate_test_case_to_desc)
+
 /*
- * Test that, for a clock that will forward any rate request to its parent, the
- * rate request structure returned by __clk_determine_rate() is sane and
- * doesn't have the clk_rate_request's best_parent_hw pointer point to the
- * clk_hw passed into __clk_determine_rate(). See commit 262ca38f4b6e ("clk:
- * Stop forwarding clk_rate_requests to the parent") for more background.
+ * Test that when a clk that can't change rate itself calls a function like
+ * __clk_determine_rate() on its parent it doesn't get back a clk_rate_request
+ * structure that has the best_parent_hw pointer point to the clk_hw passed
+ * into the determine rate function. See commit 262ca38f4b6e ("clk: Stop
+ * forwarding clk_rate_requests to the parent") for more background.
  */
-static void clk_leaf_mux_set_rate_parent__clk_determine_rate_proper_parent(struct kunit *test)
+static void clk_leaf_mux_set_rate_parent_determine_rate_test(struct kunit *test)
 {
 	struct clk_leaf_mux_ctx *ctx = test->priv;
 	struct clk_hw *hw = &ctx->hw;
 	struct clk *clk = clk_hw_get_clk(hw, NULL);
 	struct clk_rate_request req;
 	unsigned long rate;
+	const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case *test_param;
+
+	test_param = test->param_value;
+	ctx->determine_rate_func = test_param->determine_rate_func;
 
 	ctx->req = &req;
 	rate = clk_get_rate(clk);
@@ -2274,7 +2338,8 @@ static void clk_leaf_mux_set_rate_parent__clk_determine_rate_proper_parent(struc
 }
 
 static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] = {
-	KUNIT_CASE(clk_leaf_mux_set_rate_parent__clk_determine_rate_proper_parent),
+	KUNIT_CASE_PARAM(clk_leaf_mux_set_rate_parent_determine_rate_test,
+			 clk_leaf_mux_set_rate_parent_determine_rate_test_gen_params),
 	{}
 };
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

