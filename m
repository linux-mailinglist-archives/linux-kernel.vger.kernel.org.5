Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39311786C61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjHXJ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbjHXJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C081980;
        Thu, 24 Aug 2023 02:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62EA66145F;
        Thu, 24 Aug 2023 09:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D22C433C8;
        Thu, 24 Aug 2023 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692871000;
        bh=zsEzdj4jNIpbU5B5GHL0RXLo+9JE86jUG5stKApaQU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9XESszoLo2bkOi87DCGsc0IBEanLft2t92W3tDiJG0yY9cAtRyU0X3Ae6Q6R6Ngx
         olxppAulMvPoIPc3xtq8tXLvJfLBpX/+rwr4b2QchwTLQ8vfXwOU8ICABm1C/OoeT+
         u0bFk0Uumgc7w+DVlKOZDZmbIstgasezycb7/oG0HIb+Q+frPVx4rx7eRklipVsNF1
         e+ZhBY44dQuHk9FlhksrIj/cPxp+jFYTilL0xVY8FXlKbak24fg+yIvtDc+Kqh9NW6
         2DBxWNmkLn7fsgl3z3shlBmTLUjz24Tg5gj2ECenN01LV0kPYE+piObicDAtUMcOPT
         kulyT/YLIJSFg==
Date:   Thu, 24 Aug 2023 11:56:38 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
Message-ID: <62acjjvghvezxhg5u25f6kg53c6qhbcaee4ra5muyg5rmrokis@yntvznfi5hix>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
 <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
 <6534e4c349253da8ee467ffeda8221ed.sboyd@kernel.org>
 <krg4m5nckoaunsqounzehm4oyubblticfifgvpxrnbf5xf65xq@ignx6g2eqtev>
 <981e3c291fefcb8234219550e012bbad.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bndqdpalpffkyi5m"
Content-Disposition: inline
In-Reply-To: <981e3c291fefcb8234219550e012bbad.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bndqdpalpffkyi5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, Aug 23, 2023 at 12:50:46PM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2023-08-21 04:16:12)
> > Hi Stephen,
> >=20
> > On Wed, Aug 09, 2023 at 06:37:30PM -0700, Stephen Boyd wrote:
> > > Quoting Stephen Boyd (2023-08-09 16:21:50)
> > > > +kunit-dev
> > > >=20
> > > > Quoting Maxime Ripard (2023-07-21 00:09:31)
> > > > > Hi,
> > > > >=20
> > > > > Here's a small series to address the lockdep warning we have when
> > > > > running the clk kunit tests with lockdep enabled.
> > > > >=20
> > > > > For the record, it can be tested with:
> > > > >=20
> > > > > $ ./tools/testing/kunit/kunit.py run \
> > > > >     --kunitconfig=3Ddrivers/clk \
> > > > >     --cross_compile aarch64-linux-gnu- --arch arm64 \
> > > > >     --kconfig_add CONFIG_DEBUG_KERNEL=3Dy \
> > > > >     --kconfig_add CONFIG_PROVE_LOCKING=3Dy
> > > > >=20
> > > > > Let me know what you think,
> > > >=20
> > > > Thanks for doing this. I want to roll these helpers into the clk_ku=
nit.c
> > > > file that I had created for some other clk tests[1]. That's mostly
> > > > because clk.c is already super long and adding kunit code there mak=
es
> > > > that problem worse. I'll try to take that patch out of the rest of =
the
> > > > series and then add this series on top and resend.
> > > >=20
> > > > I don't know what to do about the case where CONFIG_KUNIT=3Dm thoug=
h. We
> > > > have to export clk_prepare_lock/unlock()? I really don't want to do=
 that
> > > > even if kunit is enabled (see EXPORT_SYMBOL_IF_KUNIT). Maybe if the=
re
> > > > was a GPL version of that, so proprietary modules can't get at kern=
el
> > > > internals on kunit enabled kernels.
> > > >=20
> > > > But I also like the approach taken here of adding a small stub arou=
nd
> > > > the call to make sure a test is running. Maybe I'll make a kunit
> > > > namespaced exported gpl symbol that bails if a test isn't running a=
nd
> > > > calls the clk_prepare_lock/unlock functions inside clk.c and then m=
ove
> > > > the rest of the code to clk_kunit.c to get something more strict.
> > > >=20
> > >=20
> > > What if we don't try to do any wrapper or export symbols and test
> > > __clk_determine_rate() how it is called from the clk framework? The
> > > downside is the code is not as simple because we have to check things
> > > from within the clk_ops::determine_rate(), but the upside is that we =
can
> > > avoid exporting internal clk APIs or wrap them so certain preconditio=
ns
> > > are met like requiring them to be called from within a clk_op.
> >=20
> > The main reason for that test was linked to commit 262ca38f4b6e ("clk:
> > Stop forwarding clk_rate_requests to the parent"). Prior to it, if a
> > clock had CLK_SET_RATE_PARENT, we could end up with its parent's parent
> > hw struct and rate in best_parent_*.
> >=20
> > So that test was mostly about making sure that __clk_determine_rate will
> > properly set the best_parent fields to match the clock's parent.
> >=20
> > If we do a proper clock that uses __clk_determine_rate, we lose the
> > ability to check the content of the clk_rate_request returned by
> > __clk_determine_rate. It's up to you to tell whether it's a bad thing or
> > not :)
>=20
> I'm a little confused here. Was the test trying to check the changed
> lines in clk_core_round_rate_nolock() that were made in commit
> 262ca38f4b6e under the CLK_SET_RATE_PARENT condition?

That's what I was trying to test, yeah. Not necessarily this function in
particular (there's several affected), but at least we would get
something sane in a common case.

> From what I can tell that doesn't get tested here.
>=20
> Instead, the test calls __clk_determine_rate() that calls
> clk_core_round_rate_nolock() which falls into the clk_core_can_round()
> condition because the hw has clk_dummy_single_parent_ops which has
> .determine_rate op set to __clk_mux_determine_rate_closest(). Once we
> find that the clk can round, we call __clk_mux_determine_rate_closest().

clk_mux_determine_rate_flags was also affected by the same issue.

> This patch still calls __clk_mux_determine_rate_closest() like
> __clk_determine_rate() was doing in the test, and checks that the
> request structure has the expected parent in the req->best_parent_hw.
>=20
> If we wanted to test the changed lines in clk_core_round_rate_nolock()
> we should have called __clk_determine_rate() on a clk_hw that didn't
> have a .determine_rate or .round_rate clk_op. Then it would have fallen
> into the if (core->flags & CLK_SET_RATE_PARENT) condition in
> clk_core_round_rate_nolock() and made sure that the request structure
> returned was properly forwarded to the parent.
>
> We can still do that by making a child of the leaf, set clk_ops on that
> to be this new determine_rate clk op that calls to the parent (the leaf
> today), and make that leaf clk not have any determine_rate clk_op. Then
> we will fall into the CLK_SET_RATE_PARENT condition and can make sure
> the request structure returned points at the parent instead of the mux.

But you're right clk_core_round_rate_nolock() wasn't properly tested. I
guess, if we find it worth it, we should add a test for that one too?

clk_mux_determine_rate_flags with multiple parents and
CLK_SET_RATE_PARENT was also affected and fixed in the commit mentioned
above.

Maxime

--bndqdpalpffkyi5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOcpVgAKCRDj7w1vZxhR
xe2tAP4sO1fRwk9HD3riMEIBUXzb5NL14nsmVupsFkt0r7i85AD9HYpRp15vQkk9
HA78nl7n2yMabQeBU7ncU6ZhmuU0nA8=
=fxA0
-----END PGP SIGNATURE-----

--bndqdpalpffkyi5m--
