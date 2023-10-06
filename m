Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E611A7BBB19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJFPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjJFPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E37CF;
        Fri,  6 Oct 2023 08:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F93C433C8;
        Fri,  6 Oct 2023 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696604496;
        bh=6taXQRftrWSlYCOuvDdqeV/zIbzOd5VDuZw/kWcNpik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VkJ3KAzd4vcVvX6xiPHSbtkGwjeSa5rv83UMX2sp7Ri1A+pzL9+txKqW/Mi1DjPj1
         QxuWSk0knUwSQ7Vi4/0OpC5Roc/jB3ScHJD3Rs648JR2VFivpTTmqIidXNSfTtgCzR
         hG/jz9WMh3UrdIWtPsYfBuqUGFELjxYPj8e6kkhV0PWy04dTKT6+fWvJbzBMgXGJbN
         M15DStIKz3J4v0NJMsw4LUkNFfbUOo2e6AojXzR7J0UHs8UA3BHZnVnanMwHbG4fWU
         ARsT3Zw6e/zOxFbGTn/ITERCU+V1B0B3JL0whfJR3yLlWY8mpXTXzeztcYnTPEgHz/
         MCZdT5NB6r8bA==
Date:   Fri, 6 Oct 2023 17:01:34 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benedikt Spranger <b.spranger@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial
 console
Message-ID: <ujs6kaisllqu3qzm76qkwpmdy2vnulp6z742ooclbsdz36zl5f@m7ujgar4pwqs>
References: <20231005095927.12398-1-b.spranger@linutronix.de>
 <20231005095927.12398-2-b.spranger@linutronix.de>
 <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5>
 <20231005203202.08b5d1cf@mitra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7koskstu2fnzmv5"
Content-Disposition: inline
In-Reply-To: <20231005203202.08b5d1cf@mitra>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c7koskstu2fnzmv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 08:32:23PM +0200, Benedikt Spranger wrote:
> On Thu, 5 Oct 2023 13:34:01 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > Hi,
> >=20
> > On Thu, Oct 05, 2023 at 11:59:27AM +0200, Benedikt Spranger wrote:
> > > Commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate
> > > hook") introduce a specific determine_rate hook. As a result the
> > > calculated clock for the serial IP is off by factor 2 after that
> > > i.e. if the system configures a baudrate of 115200 it is set
> > > physicaly to 57600. =20
> >=20
> > Where is that factor 2 coming from?
> In drivers/tty/serial/8250/8250_dw.c p->uartclk is set twice as high,
> as it should be:=20
>=20
> dw8250_set_termios() is called and rate is evaluated to 20000000 in the
> bad and 10000000 in the good case. As a result p->uartclk is set to
> 20000000 in the bad case.

Sure, sorry I worded that poorly. What I meant was what clock tree
decision is taken now that wasn't taken before that leads to that factor
2 difference.

> > > Change the determine_rate hook to the reparent variant
> > > __clk_mux_determine_rate() to fix the issue. =20
> >=20
> > It's also not clear to me why that would fix anything. This patch
> > should only make the old behaviour explicit, could you expand a bit
> > on what happens?
> Booting the kernel with console=3DttyS0,115200 result in a corrupted
> character output. Setting the serial terminal application to 57600
> make the serial console working.
>=20
> I dug deeper and added some debug output (see patch below):

Thanks for the traces, that's helpful. It looks like the culprit is:

Good:

            init-1       [001] .....     0.125643: clk_rate_request_start: =
l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125651: clk_rate_request_done: l=
4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125657: dw8250_set_termios: dw82=
50_set_termios: rate =3D 200000000 newrate =3D 1843200

vs Bad:

            init-1       [001] .....     0.116063: clk_rate_request_start: =
l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.116089: clk_rate_request_done: l=
4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.116096: dw8250_set_termios: dw82=
50_set_termios: rate =3D 4294967274 newrate =3D 1843200

The rate returned is super suspicious, as it's an -EINVAL casted into an
unsigned long. So I think something on that clock chain is returning an
error for some reason, which is then treated as a rate by the rest and
everybody's just confused.

What is the board that you're using?

Maxime

--c7koskstu2fnzmv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZSAhTgAKCRDj7w1vZxhR
xeT0AQDcFNiOR/+IMa3C4XSivPlYKI73G6KloGXxOE73v2Vo9AEAgvqnRE1jXgiI
kLWtgVV+spXXVKvAklp/yyq/3OfC7AQ=
=b2Cu
-----END PGP SIGNATURE-----

--c7koskstu2fnzmv5--
