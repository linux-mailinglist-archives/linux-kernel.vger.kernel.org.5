Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A3786106
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbjHWTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbjHWTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD1A10CB;
        Wed, 23 Aug 2023 12:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B017F63CE5;
        Wed, 23 Aug 2023 19:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C596EC43391;
        Wed, 23 Aug 2023 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692820248;
        bh=Nz7ebjs2vivWWwqHJWA21skiIKMtX1ru/2/PSbwqwhc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eXUNcMDR43CEuc8qbMnzrKtDdzZcJ968q6mo3cEWPRDw9AsEXEuDWqlCKkmsv02n3
         bUwDPqRmspeRWTgczvmyrtiKCaCwzV/+ngmj933qSzf0TPEmrsUsDlV7nSoadiWJLx
         ykCTYeY1U6dy06xS2El134IK86fDheCRriZfkMv4Yq4vrZkEbdY3xv/phnbFoo1d7V
         pX+9QkKLDkd8WHF42Rs77m7N2AQ/DX/hMQZs8Ug7mengRucUu1CCP/mLWDC/G6HWps
         ZltVnrxi2Tw0YtEV7iqeAuqCzjI/XAvhAHvqZN7UT8/9k0FDkfqXmE+ullQYZrCktw
         Zqv0ulrWGcD4g==
Message-ID: <981e3c291fefcb8234219550e012bbad.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <krg4m5nckoaunsqounzehm4oyubblticfifgvpxrnbf5xf65xq@ignx6g2eqtev>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org> <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org> <6534e4c349253da8ee467ffeda8221ed.sboyd@kernel.org> <krg4m5nckoaunsqounzehm4oyubblticfifgvpxrnbf5xf65xq@ignx6g2eqtev>
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
To:     Maxime Ripard <mripard@kernel.org>
Date:   Wed, 23 Aug 2023 12:50:46 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2023-08-21 04:16:12)
> Hi Stephen,
>=20
> On Wed, Aug 09, 2023 at 06:37:30PM -0700, Stephen Boyd wrote:
> > Quoting Stephen Boyd (2023-08-09 16:21:50)
> > > +kunit-dev
> > >=20
> > > Quoting Maxime Ripard (2023-07-21 00:09:31)
> > > > Hi,
> > > >=20
> > > > Here's a small series to address the lockdep warning we have when
> > > > running the clk kunit tests with lockdep enabled.
> > > >=20
> > > > For the record, it can be tested with:
> > > >=20
> > > > $ ./tools/testing/kunit/kunit.py run \
> > > >     --kunitconfig=3Ddrivers/clk \
> > > >     --cross_compile aarch64-linux-gnu- --arch arm64 \
> > > >     --kconfig_add CONFIG_DEBUG_KERNEL=3Dy \
> > > >     --kconfig_add CONFIG_PROVE_LOCKING=3Dy
> > > >=20
> > > > Let me know what you think,
> > >=20
> > > Thanks for doing this. I want to roll these helpers into the clk_kuni=
t.c
> > > file that I had created for some other clk tests[1]. That's mostly
> > > because clk.c is already super long and adding kunit code there makes
> > > that problem worse. I'll try to take that patch out of the rest of the
> > > series and then add this series on top and resend.
> > >=20
> > > I don't know what to do about the case where CONFIG_KUNIT=3Dm though.=
 We
> > > have to export clk_prepare_lock/unlock()? I really don't want to do t=
hat
> > > even if kunit is enabled (see EXPORT_SYMBOL_IF_KUNIT). Maybe if there
> > > was a GPL version of that, so proprietary modules can't get at kernel
> > > internals on kunit enabled kernels.
> > >=20
> > > But I also like the approach taken here of adding a small stub around
> > > the call to make sure a test is running. Maybe I'll make a kunit
> > > namespaced exported gpl symbol that bails if a test isn't running and
> > > calls the clk_prepare_lock/unlock functions inside clk.c and then move
> > > the rest of the code to clk_kunit.c to get something more strict.
> > >=20
> >=20
> > What if we don't try to do any wrapper or export symbols and test
> > __clk_determine_rate() how it is called from the clk framework? The
> > downside is the code is not as simple because we have to check things
> > from within the clk_ops::determine_rate(), but the upside is that we can
> > avoid exporting internal clk APIs or wrap them so certain preconditions
> > are met like requiring them to be called from within a clk_op.
>=20
> The main reason for that test was linked to commit 262ca38f4b6e ("clk:
> Stop forwarding clk_rate_requests to the parent"). Prior to it, if a
> clock had CLK_SET_RATE_PARENT, we could end up with its parent's parent
> hw struct and rate in best_parent_*.
>=20
> So that test was mostly about making sure that __clk_determine_rate will
> properly set the best_parent fields to match the clock's parent.
>=20
> If we do a proper clock that uses __clk_determine_rate, we lose the
> ability to check the content of the clk_rate_request returned by
> __clk_determine_rate. It's up to you to tell whether it's a bad thing or
> not :)

I'm a little confused here. Was the test trying to check the changed
lines in clk_core_round_rate_nolock() that were made in commit
262ca38f4b6e under the CLK_SET_RATE_PARENT condition? From what I can
tell that doesn't get tested here.

Instead, the test calls __clk_determine_rate() that calls
clk_core_round_rate_nolock() which falls into the clk_core_can_round()
condition because the hw has clk_dummy_single_parent_ops which has
.determine_rate op set to __clk_mux_determine_rate_closest(). Once we
find that the clk can round, we call __clk_mux_determine_rate_closest().
This patch still calls __clk_mux_determine_rate_closest() like
__clk_determine_rate() was doing in the test, and checks that the
request structure has the expected parent in the req->best_parent_hw.

If we wanted to test the changed lines in clk_core_round_rate_nolock()
we should have called __clk_determine_rate() on a clk_hw that didn't
have a .determine_rate or .round_rate clk_op. Then it would have fallen
into the if (core->flags & CLK_SET_RATE_PARENT) condition in
clk_core_round_rate_nolock() and made sure that the request structure
returned was properly forwarded to the parent.

We can still do that by making a child of the leaf, set clk_ops on that
to be this new determine_rate clk op that calls to the parent (the leaf
today), and make that leaf clk not have any determine_rate clk_op. Then
we will fall into the CLK_SET_RATE_PARENT condition and can make sure
the request structure returned points at the parent instead of the mux.

>=20
> > I also find it very odd to call clk_mux_determine_rate_closest() from a
> > clk that has one parent.
>=20
> Yeah, the behaviour difference between determine_rate and
> determine_rate_closest is weird to me too. We discussed it recently here:
> https://lore.kernel.org/linux-clk/mlgxmfim3poke2j45vwh2htkn66hrrjd6ozjebt=
qhbf4wwljwo@hzi4dyplhdqg/

Sure, but I'm saying that the clk has one parent, not more than one, so
by definition it isn't a mux. It can only choose one parent. It's odd
that "mux" is in the name.

>=20
> > Maybe the clk op should call clk_hw_forward_rate_request() followed by
> > __clk_determine_rate() on the parent so we can test what the test
> > comment says it wants to test.
>=20
> I guess that would work too :)
>=20

Ok, but I think it doesn't test what was intended to be tested?
