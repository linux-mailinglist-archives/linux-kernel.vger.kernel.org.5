Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC547DA3E5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbjJ0W60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0W6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:58:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0C41B5;
        Fri, 27 Oct 2023 15:58:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7320C433C8;
        Fri, 27 Oct 2023 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698447503;
        bh=v0fn/GRMcqD4S8f59Pl/v9wXT1tqBn6J2jGwnNSU6qE=;
        h=From:To:Cc:Subject:Date:From;
        b=WE3pnlpZWQ33FUNxLtQns1irVZjRPFEDm5zc48cSiLPNQZrOtQR4UF3wAAM3/15KP
         nOGNa9625CgTCMxJKz9b+pgyt5CkCCp9Hg44Uqz0Fh4gZ5FQXD2Udh+ylQgNfit8pn
         oAmUMdbvVGo/Vav1eLZQxrKhLBUGl662kB3GmYD0uuWBwgVbOzXnsZfy2RZW/uHmRE
         vNkMQ47w5bUf4TUuReOyxQ6BcCKBk66gq22oGwULyXEgemmT8lxCSu62pbHhzDZk8j
         jT/5/P6OaFSL6PS1UKzefTNBKDOADyqT649Y4xmXGFY+mn/LGgKnrCQBSD+sr6LYqy
         M5MtPOWPmEUbg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] clk: Fix clk gate kunit test on big-endian CPUs
Date:   Fri, 27 Oct 2023 15:58:21 -0700
Message-ID: <20231027225821.95833-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

The clk gate kunit test checks that the implementation of the basic clk
gate reads and writes the proper bits in an MMIO register. The
implementation of the basic clk gate type uses writel() and readl()
which operate on little-endian registers. This test fails on big-endian
CPUs because the clk gate implementation writes to 'fake_reg' with
writel(), which converts the value to be written to little-endian before
storing the value in the fake register. When the test checks the bits in
the fake register on a big-endian machine it falsely assumes the format
of the register is also big-endian, when it is really always
little-endian. Suffice to say things don't work very well.

Mark 'fake_reg' as __le32 and push through endian accessor fixes
wherever the value is inspected to make this test endian agnostic.
There's a CLK_GATE_BIG_ENDIAN flag for big-endian MMIO devices, which
this test isn't using. A follow-up patch will test with and without that
flag.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Closes: https://lore.kernel.org/r/ZTLH5o0GlFBYsAHq@boqun-archlinux
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-gate_test.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk-gate_test.c b/drivers/clk/clk-gate_test.c
index e136aaad48bf..c96d93b19ddf 100644
--- a/drivers/clk/clk-gate_test.c
+++ b/drivers/clk/clk-gate_test.c
@@ -131,7 +131,7 @@ struct clk_gate_test_context {
 	void __iomem *fake_mem;
 	struct clk_hw *hw;
 	struct clk_hw *parent;
-	u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
+	__le32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
 };
 
 static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct kunit *test)
@@ -166,7 +166,7 @@ static void clk_gate_test_enable(struct kunit *test)
 
 	KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
 
-	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_EQ(test, enable_val, le32_to_cpu(ctx->fake_reg));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
@@ -183,10 +183,10 @@ static void clk_gate_test_disable(struct kunit *test)
 	u32 disable_val = 0;
 
 	KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
-	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_ASSERT_EQ(test, enable_val, le32_to_cpu(ctx->fake_reg));
 
 	clk_disable_unprepare(clk);
-	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_EQ(test, disable_val, le32_to_cpu(ctx->fake_reg));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
@@ -246,7 +246,7 @@ static void clk_gate_test_invert_enable(struct kunit *test)
 
 	KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
 
-	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_EQ(test, enable_val, le32_to_cpu(ctx->fake_reg));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
@@ -263,10 +263,10 @@ static void clk_gate_test_invert_disable(struct kunit *test)
 	u32 disable_val = BIT(15);
 
 	KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
-	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_ASSERT_EQ(test, enable_val, le32_to_cpu(ctx->fake_reg));
 
 	clk_disable_unprepare(clk);
-	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_EQ(test, disable_val, le32_to_cpu(ctx->fake_reg));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
@@ -290,7 +290,7 @@ static int clk_gate_test_invert_init(struct kunit *test)
 					    2000000);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
 
-	ctx->fake_reg = BIT(15); /* Default to off */
+	ctx->fake_reg = cpu_to_le32(BIT(15)); /* Default to off */
 	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
 					    ctx->fake_mem, 15,
 					    CLK_GATE_SET_TO_DISABLE, NULL);
@@ -319,7 +319,7 @@ static void clk_gate_test_hiword_enable(struct kunit *test)
 
 	KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
 
-	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_EQ(test, enable_val, le32_to_cpu(ctx->fake_reg));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
 	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
@@ -336,10 +336,10 @@ static void clk_gate_test_hiword_disable(struct kunit *test)
 	u32 disable_val = BIT(9 + 16);
 
 	KUNIT_ASSERT_EQ(test, clk_prepare_enable(clk), 0);
-	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_ASSERT_EQ(test, enable_val, le32_to_cpu(ctx->fake_reg));
 
 	clk_disable_unprepare(clk);
-	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_EQ(test, disable_val, le32_to_cpu(ctx->fake_reg));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
 	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
@@ -387,7 +387,7 @@ static void clk_gate_test_is_enabled(struct kunit *test)
 	struct clk_gate_test_context *ctx;
 
 	ctx = clk_gate_test_alloc_ctx(test);
-	ctx->fake_reg = BIT(7);
+	ctx->fake_reg = cpu_to_le32(BIT(7));
 	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
 				  0, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
@@ -402,7 +402,7 @@ static void clk_gate_test_is_disabled(struct kunit *test)
 	struct clk_gate_test_context *ctx;
 
 	ctx = clk_gate_test_alloc_ctx(test);
-	ctx->fake_reg = BIT(4);
+	ctx->fake_reg = cpu_to_le32(BIT(4));
 	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
 				  0, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
@@ -417,7 +417,7 @@ static void clk_gate_test_is_enabled_inverted(struct kunit *test)
 	struct clk_gate_test_context *ctx;
 
 	ctx = clk_gate_test_alloc_ctx(test);
-	ctx->fake_reg = BIT(31);
+	ctx->fake_reg = cpu_to_le32(BIT(31));
 	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 2,
 				  CLK_GATE_SET_TO_DISABLE, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
@@ -432,7 +432,7 @@ static void clk_gate_test_is_disabled_inverted(struct kunit *test)
 	struct clk_gate_test_context *ctx;
 
 	ctx = clk_gate_test_alloc_ctx(test);
-	ctx->fake_reg = BIT(29);
+	ctx->fake_reg = cpu_to_le32(BIT(29));
 	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 29,
 				  CLK_GATE_SET_TO_DISABLE, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);

base-commit: 831187c6946f29ba8309d386d5ca466eec8b9f79
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

