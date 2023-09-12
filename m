Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9C79C261
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjILCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbjILCCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B531A39BD;
        Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770A5C116A3;
        Tue, 12 Sep 2023 00:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694480026;
        bh=iufhVFZn11eMPXjHdoQF9GKGrZy/RvZw7VuP9Nvf2sg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lkCsm8E71eoE7JOJHDob2jp2+FI37BSH0KC8z6gIBKaXjOIknzCoUqPvlMo/3Rbk6
         5gkwDAwxcYFQrd6YiWHNVayZfKw61V6secC+LmHc6JLx/uqWS3nOu/IWciPt2Ts5wl
         o4llFhGnXYF82dfFvIx5UBkajVBtsMIq9JIzwUtJLnpqgbI/jAl/QLA0XIZEduGDwY
         Ra4ijpasqV+23JAISniMZiAHxpauT7V5bPHLPdpFPktHmLMuM126AL4vG7s7Tuhrh2
         5j9HzPvBhFODlhjfU/JP3OQfu2fwQsvEQFaXVCMZw/Eb6yaaV8FUEEoKPvlfYk13P5
         zzmgQWfMxEF0Q==
Message-ID: <b8a6b1157012a6171c7d11a9bcc4a57d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <62acjjvghvezxhg5u25f6kg53c6qhbcaee4ra5muyg5rmrokis@yntvznfi5hix>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org> <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org> <6534e4c349253da8ee467ffeda8221ed.sboyd@kernel.org> <krg4m5nckoaunsqounzehm4oyubblticfifgvpxrnbf5xf65xq@ignx6g2eqtev> <981e3c291fefcb8234219550e012bbad.sboyd@kernel.org> <62acjjvghvezxhg5u25f6kg53c6qhbcaee4ra5muyg5rmrokis@yntvznfi5hix>
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
To:     Maxime Ripard <mripard@kernel.org>
Date:   Mon, 11 Sep 2023 17:53:44 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2023-08-24 02:56:38)
> Hi Stephen,
>=20
> On Wed, Aug 23, 2023 at 12:50:46PM -0700, Stephen Boyd wrote:
> > Quoting Maxime Ripard (2023-08-21 04:16:12)
> > > Hi Stephen,
> > >=20
> > > The main reason for that test was linked to commit 262ca38f4b6e ("clk:
> > > Stop forwarding clk_rate_requests to the parent"). Prior to it, if a
> > > clock had CLK_SET_RATE_PARENT, we could end up with its parent's pare=
nt
> > > hw struct and rate in best_parent_*.
> > >=20
> > > So that test was mostly about making sure that __clk_determine_rate w=
ill
> > > properly set the best_parent fields to match the clock's parent.
> > >=20
> > > If we do a proper clock that uses __clk_determine_rate, we lose the
> > > ability to check the content of the clk_rate_request returned by
> > > __clk_determine_rate. It's up to you to tell whether it's a bad thing=
 or
> > > not :)
> >=20
> > I'm a little confused here. Was the test trying to check the changed
> > lines in clk_core_round_rate_nolock() that were made in commit
> > 262ca38f4b6e under the CLK_SET_RATE_PARENT condition?
>=20
> That's what I was trying to test, yeah. Not necessarily this function in
> particular (there's several affected), but at least we would get
> something sane in a common case.

Cool. Thanks for confirming.

>=20
> > From what I can tell that doesn't get tested here.
> >=20
> > Instead, the test calls __clk_determine_rate() that calls
> > clk_core_round_rate_nolock() which falls into the clk_core_can_round()
> > condition because the hw has clk_dummy_single_parent_ops which has
> > .determine_rate op set to __clk_mux_determine_rate_closest(). Once we
> > find that the clk can round, we call __clk_mux_determine_rate_closest().
>=20
> clk_mux_determine_rate_flags was also affected by the same issue.

Ok. I see.

>=20
> > This patch still calls __clk_mux_determine_rate_closest() like
> > __clk_determine_rate() was doing in the test, and checks that the
> > request structure has the expected parent in the req->best_parent_hw.
> >=20
> > If we wanted to test the changed lines in clk_core_round_rate_nolock()
> > we should have called __clk_determine_rate() on a clk_hw that didn't
> > have a .determine_rate or .round_rate clk_op. Then it would have fallen
> > into the if (core->flags & CLK_SET_RATE_PARENT) condition in
> > clk_core_round_rate_nolock() and made sure that the request structure
> > returned was properly forwarded to the parent.
> >
> > We can still do that by making a child of the leaf, set clk_ops on that
> > to be this new determine_rate clk op that calls to the parent (the leaf
> > today), and make that leaf clk not have any determine_rate clk_op. Then
> > we will fall into the CLK_SET_RATE_PARENT condition and can make sure
> > the request structure returned points at the parent instead of the mux.
>=20
> But you're right clk_core_round_rate_nolock() wasn't properly tested. I
> guess, if we find it worth it, we should add a test for that one too?
>=20
> clk_mux_determine_rate_flags with multiple parents and
> CLK_SET_RATE_PARENT was also affected and fixed in the commit mentioned
> above.
>=20

Makes sense. I've made a set of these tests that call some function,
like __clk_determine_rate() or __clk_mux_determine_rate(), from the
determine_rate clk_op of the leaf. The clk_hw pointer passed to the
function under test is the parent of the clk (the intermediate empty
clk_ops clk). The parent of that intermediate clk is the mux.

I noticed that sometimes the parent_hw wasn't set to the mux_ctx if I
didn't call clk_hw_forward_rate_request() in the clk_op. That's because
functions like __clk_determine_rate() assume the best_parent_hw has been
set already and simply skip setting it at all. It's possible that a
driver may fail to call clk_hw_forward_rate_request() before calling
some determine rate function on the parent. Looks like a pitfall but I'm
not sure how to make it any better.

I have this as two patches in my local tree. I'll send it out tomorrow.

----8<----
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a154ec9d0111..99b9f01ada71 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2155,8 +2155,35 @@ static struct kunit_suite clk_range_minimize_test_su=
ite =3D {
 struct clk_leaf_mux_ctx {
 	struct clk_multiple_parent_ctx mux_ctx;
 	struct clk_hw hw;
+	struct clk_hw parent;
+	struct clk_rate_request req;
+	int (*determine_rate_func)(struct clk_hw *, struct clk_rate_request *);
 };
=20
+static int clk_leaf_mux_determine_rate(struct clk_hw *hw, struct clk_rate_=
request *req)
+{
+	struct clk_leaf_mux_ctx *ctx =3D container_of(hw, struct clk_leaf_mux_ctx=
, hw);
+	int ret;
+	struct clk_rate_request *parent_req =3D &ctx->req;
+
+	clk_hw_forward_rate_request(hw, req, req->best_parent_hw, parent_req, req=
->rate);
+	ret =3D ctx->determine_rate_func(req->best_parent_hw, parent_req);
+	if (ret)
+		return ret;
+
+	req->rate =3D parent_req->rate;
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
+static const struct clk_ops empty_clk_ops =3D { };
+
 static int
 clk_leaf_mux_set_rate_parent_test_init(struct kunit *test)
 {
@@ -2193,8 +2220,15 @@ clk_leaf_mux_set_rate_parent_test_init(struct kunit =
*test)
 	if (ret)
 		return ret;
=20
-	ctx->hw.init =3D CLK_HW_INIT_HW("test-clock", &ctx->mux_ctx.hw,
-				      &clk_dummy_single_parent_ops,
+	ctx->parent.init =3D CLK_HW_INIT_HW("test-parent", &ctx->mux_ctx.hw,
+				      &empty_clk_ops,
+				      CLK_SET_RATE_PARENT);
+	ret =3D clk_hw_register(NULL, &ctx->parent);
+	if (ret)
+		return ret;
+
+	ctx->hw.init =3D CLK_HW_INIT_HW("test-clock", &ctx->parent,
+				      &clk_leaf_mux_set_rate_parent_ops,
 				      CLK_SET_RATE_PARENT);
 	ret =3D clk_hw_register(NULL, &ctx->hw);
 	if (ret)
@@ -2208,50 +2242,112 @@ static void clk_leaf_mux_set_rate_parent_test_exit=
(struct kunit *test)
 	struct clk_leaf_mux_ctx *ctx =3D test->priv;
=20
 	clk_hw_unregister(&ctx->hw);
+	clk_hw_unregister(&ctx->parent);
 	clk_hw_unregister(&ctx->mux_ctx.hw);
 	clk_hw_unregister(&ctx->mux_ctx.parents_ctx[0].hw);
 	clk_hw_unregister(&ctx->mux_ctx.parents_ctx[1].hw);
 }
=20
+struct clk_leaf_mux_set_rate_parent_determine_rate_test_case {
+	const char *desc;
+	int (*determine_rate_func)(struct clk_hw *, struct clk_rate_request *);
+};
+
+static void
+clk_leaf_mux_set_rate_parent_determine_rate_test_case_to_desc(
+		const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case *t, c=
har *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+static const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case
+clk_leaf_mux_set_rate_parent_determine_rate_test_cases[] =3D {
+	{
+		/*
+		 * Test that __clk_determine_rate() on the parent that can't
+		 * change rate doesn't return a clk_rate_request structure with
+		 * the best_parent_hw pointer pointing to the parent.
+		 */
+		.desc =3D "clk_leaf_mux_set_rate_parent__clk_determine_rate_proper_paren=
t",
+		.determine_rate_func =3D __clk_determine_rate,
+	},
+	{
+		/*
+		 * Test that __clk_mux_determine_rate() on the parent that
+		 * can't change rate doesn't return a clk_rate_request
+		 * structure with the best_parent_hw pointer pointing to
+		 * the parent.
+		 */
+		.desc =3D "clk_leaf_mux_set_rate_parent__clk_mux_determine_rate_proper_p=
arent",
+		.determine_rate_func =3D __clk_mux_determine_rate,
+	},
+	{
+		/*
+		 * Test that __clk_mux_determine_rate_closest() on the parent
+		 * that can't change rate doesn't return a clk_rate_request
+		 * structure with the best_parent_hw pointer pointing to
+		 * the parent.
+		 */
+		.desc =3D "clk_leaf_mux_set_rate_parent__clk_mux_determine_rate_closest_=
proper_parent",
+		.determine_rate_func =3D __clk_mux_determine_rate_closest,
+	},
+	{
+		/*
+		 * Test that clk_hw_determine_rate_no_reparent() on the parent
+		 * that can't change rate doesn't return a clk_rate_request
+		 * structure with the best_parent_hw pointer pointing to
+		 * the parent.
+		 */
+		.desc =3D "clk_leaf_mux_set_rate_parent_clk_hw_determine_rate_no_reparen=
t_proper_parent",
+		.determine_rate_func =3D clk_hw_determine_rate_no_reparent,
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_leaf_mux_set_rate_parent_determine_rate_test,
+		  clk_leaf_mux_set_rate_parent_determine_rate_test_cases,
+		  clk_leaf_mux_set_rate_parent_determine_rate_test_case_to_desc)
+
 /*
- * Test that, for a clock that will forward any rate request to its
- * parent, the rate request structure returned by __clk_determine_rate
- * is sane and will be what we expect.
+ * Test that when a clk that can't change rate itself calls a function like
+ * __clk_determine_rate() on its parent it doesn't get back a clk_rate_req=
uest
+ * structure that has the best_parent_hw pointer point to the clk_hw passed
+ * into the determine rate function. See commit 262ca38f4b6e ("clk: Stop
+ * forwarding clk_rate_requests to the parent") for more background.
  */
-static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
+static void clk_leaf_mux_set_rate_parent_determine_rate_test(struct kunit =
*test)
 {
 	struct clk_leaf_mux_ctx *ctx =3D test->priv;
 	struct clk_hw *hw =3D &ctx->hw;
 	struct clk *clk =3D clk_hw_get_clk(hw, NULL);
-	struct clk_rate_request req;
+	struct clk_rate_request *req =3D &ctx->req;
 	unsigned long rate;
-	int ret;
+	const struct clk_leaf_mux_set_rate_parent_determine_rate_test_case *test_=
param;
+
+	test_param =3D test->param_value;
+	ctx->determine_rate_func =3D test_param->determine_rate_func;
=20
 	rate =3D clk_get_rate(clk);
 	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_ASSERT_EQ(test, DUMMY_CLOCK_RATE_2, clk_round_rate(clk, DUMMY_CLOCK=
_RATE_2));
=20
-	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
-
-	ret =3D __clk_determine_rate(hw, &req);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
-	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
-	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
+	KUNIT_EXPECT_EQ(test, req->rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_EQ(test, req->best_parent_rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_PTR_EQ(test, req->best_parent_hw, &ctx->mux_ctx.hw);
=20
 	clk_put(clk);
 }
=20
 static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] =3D {
-	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate),
+	KUNIT_CASE_PARAM(clk_leaf_mux_set_rate_parent_determine_rate_test,
+			 clk_leaf_mux_set_rate_parent_determine_rate_test_gen_params),
 	{}
 };
=20
 /*
- * Test suite for a clock whose parent is a mux with multiple parents.
- * The leaf clock has CLK_SET_RATE_PARENT, and will forward rate
- * requests to the mux, which will then select which parent is the best
- * fit for a given rate.
+ * Test suite for a clock whose parent is a pass-through clk whose parent =
is a
+ * mux with multiple parents. The leaf and pass-through clocks have the
+ * CLK_SET_RATE_PARENT flag, and will forward rate requests to the mux, wh=
ich
+ * will then select which parent is the best fit for a given rate.
  *
  * These tests exercise the behaviour of muxes, and the proper selection
  * of parents.
