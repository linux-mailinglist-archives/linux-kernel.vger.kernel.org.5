Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7811776D92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjHJBhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHJBhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656621724;
        Wed,  9 Aug 2023 18:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E14B063316;
        Thu, 10 Aug 2023 01:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ACAC433C8;
        Thu, 10 Aug 2023 01:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691631452;
        bh=FkBVN+BoldcOn+lA1lhE/1vvEoFgR35NCKjJ0U9OHpM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I7Pidezv8HmWcvRrp7r+Nl80rJ6ZZmE5/FEFNarmkBVZqDkzPLWzdVz5EI39I0N61
         y8UZWn4mw+PyBUxZquAu95unkvdQXUkRpCRD08lJ8ZAERqC/f7Uky9LEp9WjvERF4D
         SM8QZ3YjmCxmdDfBK7utKYY95ydHzE+0dFDoqliASxyrWr6Xe/S/9sFAFip8mzbufO
         4wyE28P3ICK3rh3u4ko/0nVqNv8PNlY0UjZcBCIY4Fzr14XOMiD1JeiyRCTsxg0X+v
         9md3a5gyDH41NQ8ZCSLS2j7rBpZ83mTimWuraSu6YyX+ejeWLr74gT6dAAVAhWtnDS
         5WlZxdscegjXQ==
Message-ID: <6534e4c349253da8ee467ffeda8221ed.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org> <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 09 Aug 2023 18:37:30 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-08-09 16:21:50)
> +kunit-dev
>=20
> Quoting Maxime Ripard (2023-07-21 00:09:31)
> > Hi,
> >=20
> > Here's a small series to address the lockdep warning we have when
> > running the clk kunit tests with lockdep enabled.
> >=20
> > For the record, it can be tested with:
> >=20
> > $ ./tools/testing/kunit/kunit.py run \
> >     --kunitconfig=3Ddrivers/clk \
> >     --cross_compile aarch64-linux-gnu- --arch arm64 \
> >     --kconfig_add CONFIG_DEBUG_KERNEL=3Dy \
> >     --kconfig_add CONFIG_PROVE_LOCKING=3Dy
> >=20
> > Let me know what you think,
>=20
> Thanks for doing this. I want to roll these helpers into the clk_kunit.c
> file that I had created for some other clk tests[1]. That's mostly
> because clk.c is already super long and adding kunit code there makes
> that problem worse. I'll try to take that patch out of the rest of the
> series and then add this series on top and resend.
>=20
> I don't know what to do about the case where CONFIG_KUNIT=3Dm though. We
> have to export clk_prepare_lock/unlock()? I really don't want to do that
> even if kunit is enabled (see EXPORT_SYMBOL_IF_KUNIT). Maybe if there
> was a GPL version of that, so proprietary modules can't get at kernel
> internals on kunit enabled kernels.
>=20
> But I also like the approach taken here of adding a small stub around
> the call to make sure a test is running. Maybe I'll make a kunit
> namespaced exported gpl symbol that bails if a test isn't running and
> calls the clk_prepare_lock/unlock functions inside clk.c and then move
> the rest of the code to clk_kunit.c to get something more strict.
>=20

What if we don't try to do any wrapper or export symbols and test
__clk_determine_rate() how it is called from the clk framework? The
downside is the code is not as simple because we have to check things
from within the clk_ops::determine_rate(), but the upside is that we can
avoid exporting internal clk APIs or wrap them so certain preconditions
are met like requiring them to be called from within a clk_op.

I also find it very odd to call clk_mux_determine_rate_closest() from a
clk that has one parent. Maybe the clk op should call
clk_hw_forward_rate_request() followed by __clk_determine_rate() on the
parent so we can test what the test comment says it wants to test.

-----8<-----
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a154ec9d0111..b5b4f504b284 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2155,6 +2155,53 @@ static struct kunit_suite clk_range_minimize_test_su=
ite =3D {
 struct clk_leaf_mux_ctx {
 	struct clk_multiple_parent_ctx mux_ctx;
 	struct clk_hw hw;
+	struct kunit *test;
+	bool determine_rate_called;
+};
+
+static int clk_leaf_mux_determine_rate(struct clk_hw *hw, struct clk_rate_=
request *req)
+{
+	struct clk_leaf_mux_ctx *ctx =3D container_of(hw, struct clk_leaf_mux_ctx=
, hw);
+	struct kunit *test =3D ctx->test;
+
+	KUNIT_ASSERT_EQ(test, req->rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_ASSERT_EQ(test, 0, __clk_mux_determine_rate_closest(hw, req));
+
+	KUNIT_EXPECT_EQ(test, req->rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_EQ(test, req->best_parent_rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_PTR_EQ(test, req->best_parent_hw, &ctx->mux_ctx.hw);
+
+	ctx->determine_rate_called =3D true;
+
+	return 0;
+}
+
+static const struct clk_ops clk_leaf_mux_set_rate_parent_ops =3D {
+	.determine_rate =3D clk_leaf_mux_determine_rate,
+	.set_parent =3D clk_dummy_single_set_parent,
+	.get_parent =3D clk_dummy_single_get_parent,
+};
+
+/*
+ * Test that, for a clock that will forward any rate request to its
+ * parent, the rate request structure returned by __clk_determine_rate
+ * is sane and will be what we expect.
+ */
+static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
+{
+	struct clk_leaf_mux_ctx *ctx =3D test->priv;
+	struct clk_hw *hw =3D &ctx->hw;
+	struct clk *clk =3D clk_hw_get_clk(hw, NULL);
+
+	KUNIT_EXPECT_EQ(test, DUMMY_CLOCK_RATE_2, clk_round_rate(clk, DUMMY_CLOCK=
_RATE_2));
+	KUNIT_EXPECT_TRUE(test, ctx->determine_rate_called);
+
+	clk_put(clk);
+}
+
+static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] =3D {
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate),
+	{}
 };
=20
 static int
@@ -2168,6 +2215,7 @@ clk_leaf_mux_set_rate_parent_test_init(struct kunit *=
test)
 	if (!ctx)
 		return -ENOMEM;
 	test->priv =3D ctx;
+	ctx->test =3D test;
=20
 	ctx->mux_ctx.parents_ctx[0].hw.init =3D CLK_HW_INIT_NO_PARENT("parent-0",
 								    &clk_dummy_rate_ops,
@@ -2194,7 +2242,7 @@ clk_leaf_mux_set_rate_parent_test_init(struct kunit *=
test)
 		return ret;
=20
 	ctx->hw.init =3D CLK_HW_INIT_HW("test-clock", &ctx->mux_ctx.hw,
-				      &clk_dummy_single_parent_ops,
+				      &clk_leaf_mux_set_rate_parent_ops,
 				      CLK_SET_RATE_PARENT);
 	ret =3D clk_hw_register(NULL, &ctx->hw);
 	if (ret)
@@ -2213,40 +2261,6 @@ static void clk_leaf_mux_set_rate_parent_test_exit(s=
truct kunit *test)
 	clk_hw_unregister(&ctx->mux_ctx.parents_ctx[1].hw);
 }
=20
-/*
- * Test that, for a clock that will forward any rate request to its
- * parent, the rate request structure returned by __clk_determine_rate
- * is sane and will be what we expect.
- */
-static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
-{
-	struct clk_leaf_mux_ctx *ctx =3D test->priv;
-	struct clk_hw *hw =3D &ctx->hw;
-	struct clk *clk =3D clk_hw_get_clk(hw, NULL);
-	struct clk_rate_request req;
-	unsigned long rate;
-	int ret;
-
-	rate =3D clk_get_rate(clk);
-	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
-
-	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
-
-	ret =3D __clk_determine_rate(hw, &req);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
-	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
-	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
-
-	clk_put(clk);
-}
-
-static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] =3D {
-	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate),
-	{}
-};
-
 /*
  * Test suite for a clock whose parent is a mux with multiple parents.
  * The leaf clock has CLK_SET_RATE_PARENT, and will forward rate
