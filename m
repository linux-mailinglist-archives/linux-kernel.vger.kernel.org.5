Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FEE7827B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjHULQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHULQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:16:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F3E2;
        Mon, 21 Aug 2023 04:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EE9A61236;
        Mon, 21 Aug 2023 11:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC95C433C8;
        Mon, 21 Aug 2023 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692616575;
        bh=mmcV2ExFx6Fn62xDirue4eNqZQx4mWU+lrbRmgR6ouM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYxnxf6GW5TIJQbrkvyyR3HLkuA4Z622Immqw7qbzIvXqS7wsx9SyKfK3N1CpMBfk
         iKypIo6dM55MNTt1QdPhVBsjLoduX+vYrR5V6+s0OLmQFIpJG6l8xL6XU2I2Wmlv1a
         UdOkwtOogKENTSpZ+2fI3d1LEybU+lj0swnhJVRSOR0BAiZhI13UDQYRKKpNVq8GtM
         H1OdWZBN6OECcE7/KExhufau7ARXGljk799qnVnkkuwdrhSfJ6c0yjwQ6fvillSkoJ
         ifq92bbLZNu1To0v7Q/hc9SqRUJiOOWQr3NJU/GNv9bnetjvKFOSFbjM/niz3C97kN
         oViETufWF6pBQ==
Date:   Mon, 21 Aug 2023 13:16:12 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
Message-ID: <krg4m5nckoaunsqounzehm4oyubblticfifgvpxrnbf5xf65xq@ignx6g2eqtev>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
 <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
 <6534e4c349253da8ee467ffeda8221ed.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwgas5g24ob5yfsc"
Content-Disposition: inline
In-Reply-To: <6534e4c349253da8ee467ffeda8221ed.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cwgas5g24ob5yfsc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, Aug 09, 2023 at 06:37:30PM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2023-08-09 16:21:50)
> > +kunit-dev
> >=20
> > Quoting Maxime Ripard (2023-07-21 00:09:31)
> > > Hi,
> > >=20
> > > Here's a small series to address the lockdep warning we have when
> > > running the clk kunit tests with lockdep enabled.
> > >=20
> > > For the record, it can be tested with:
> > >=20
> > > $ ./tools/testing/kunit/kunit.py run \
> > >     --kunitconfig=3Ddrivers/clk \
> > >     --cross_compile aarch64-linux-gnu- --arch arm64 \
> > >     --kconfig_add CONFIG_DEBUG_KERNEL=3Dy \
> > >     --kconfig_add CONFIG_PROVE_LOCKING=3Dy
> > >=20
> > > Let me know what you think,
> >=20
> > Thanks for doing this. I want to roll these helpers into the clk_kunit.c
> > file that I had created for some other clk tests[1]. That's mostly
> > because clk.c is already super long and adding kunit code there makes
> > that problem worse. I'll try to take that patch out of the rest of the
> > series and then add this series on top and resend.
> >=20
> > I don't know what to do about the case where CONFIG_KUNIT=3Dm though. We
> > have to export clk_prepare_lock/unlock()? I really don't want to do that
> > even if kunit is enabled (see EXPORT_SYMBOL_IF_KUNIT). Maybe if there
> > was a GPL version of that, so proprietary modules can't get at kernel
> > internals on kunit enabled kernels.
> >=20
> > But I also like the approach taken here of adding a small stub around
> > the call to make sure a test is running. Maybe I'll make a kunit
> > namespaced exported gpl symbol that bails if a test isn't running and
> > calls the clk_prepare_lock/unlock functions inside clk.c and then move
> > the rest of the code to clk_kunit.c to get something more strict.
> >=20
>=20
> What if we don't try to do any wrapper or export symbols and test
> __clk_determine_rate() how it is called from the clk framework? The
> downside is the code is not as simple because we have to check things
> from within the clk_ops::determine_rate(), but the upside is that we can
> avoid exporting internal clk APIs or wrap them so certain preconditions
> are met like requiring them to be called from within a clk_op.

The main reason for that test was linked to commit 262ca38f4b6e ("clk:
Stop forwarding clk_rate_requests to the parent"). Prior to it, if a
clock had CLK_SET_RATE_PARENT, we could end up with its parent's parent
hw struct and rate in best_parent_*.

So that test was mostly about making sure that __clk_determine_rate will
properly set the best_parent fields to match the clock's parent.

If we do a proper clock that uses __clk_determine_rate, we lose the
ability to check the content of the clk_rate_request returned by
__clk_determine_rate. It's up to you to tell whether it's a bad thing or
not :)

> I also find it very odd to call clk_mux_determine_rate_closest() from a
> clk that has one parent.

Yeah, the behaviour difference between determine_rate and
determine_rate_closest is weird to me too. We discussed it recently here:
https://lore.kernel.org/linux-clk/mlgxmfim3poke2j45vwh2htkn66hrrjd6ozjebtqh=
bf4wwljwo@hzi4dyplhdqg/

> Maybe the clk op should call clk_hw_forward_rate_request() followed by
> __clk_determine_rate() on the parent so we can test what the test
> comment says it wants to test.

I guess that would work too :)

Maxime

--cwgas5g24ob5yfsc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZONHfAAKCRDj7w1vZxhR
xQl+AQCmHXtXzmKXnDgGPSiLCQQH3U89SQhseRhBOKsO/e5OWwEAjfNLJP0x4Hp2
wiAohQL1Qrr7H31hLhXTJQ9jF8VHuwk=
=m1pg
-----END PGP SIGNATURE-----

--cwgas5g24ob5yfsc--
