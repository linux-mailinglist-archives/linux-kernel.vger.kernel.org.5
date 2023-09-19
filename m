Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647AB7A5AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjISHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjISHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:22:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EC4114;
        Tue, 19 Sep 2023 00:22:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D791C433C7;
        Tue, 19 Sep 2023 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695108131;
        bh=qgeDAcm+eFxaDNpoHATRJfJ3GIVR3JDf6CwlvDJ9Hdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4HyzUmM6NZAHCqsSdBwChfVQ9vb+mbJnDvnR1AuafUhWBK8agKMQvyTxRy1AIaar
         gWEnVH7b3opi/SyBv31tCeKJtVRXoxV7GNKllD9WtdJqrPUFa4AmeRfWm/jHoiUmcj
         soxIOiH5yp8+OubvyaWdJ6jYlZU5/QoiN5dPoalPvuvjt41lPrON9UeGK5FOJ5OYcd
         NfQhpcKP6bDENs58VVUHADVmfMP3x80uKq27SEXBERvfWOjixPeaUltAlMF3B33+k1
         DLelCMWw0ML+BbJBMDX2QawLBZPtqeIIBBvoQ1C+lZbjarSQrs9ZTAjqqzjBNczJ+d
         uqYXLYWaJ4d3A==
Date:   Tue, 19 Sep 2023 09:22:09 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Oltmanns <frank@oltmanns.dev>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH 07/13] clk: detect unintended rate changes
Message-ID: <izjejcqxv5jpnwpgdzuiibvhajw5vy26hpjlknefuepjboppkg@ywkvxiup4xqg>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
 <20230918-imx8mp-dtsi-v1-7-1d008b3237c0@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3pz4fjkoxsas7y5a"
Content-Disposition: inline
In-Reply-To: <20230918-imx8mp-dtsi-v1-7-1d008b3237c0@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3pz4fjkoxsas7y5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 18, 2023 at 12:40:03AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> As we now keep track of the clocks which are allowed to change - namely
> the ones which are along the ancestor line between the rate trigger and
> the top-most changed clock

I'm not sure that the fact that only a clock between the clock
triggering the rate change and the top-most changed clock was allowed to
change has ever been a thing.

This puts a fairly big pressure on the tree propagation code, and
whether or not that can be done is completely context-dependent.

Devices like UART, I2C or audio devices are rate change sensitive, and
yet usually have internal dividers to accomodate for their parent rate
so don't usually care as long as they are notified.

Similarly, all the non-rate-sensitive devices (like pretty much all
bus/registers clocks) don't care at all about what the rate is, so that
requirement is making a rate change going through less likely, without a
particular reason only for a handful of devices (display in this case).

Also, this rules out any child of a clock from being allowed to change?
That looks wild to me :)

> we can run through the subtree of changes and look for unexpected
> ones.

Again, I'm not sure we can say that those changes were unexpected. They
very much were expected to change to the CCF so far.

> Shared parents must set their rate in a way, that all
> consumer-configured rates are respected.

Again, that entirely depends on the context: the clock tree topology,
the devices involved, what their drivers support, etc. I'm sure it's
true in your case, but I'm not sure we can make that a generic
statement.

> As this is sometimes not possible and clocks sometime doesn't require
> the *exact* rate, we might have to find a way to find out if it is
> *exact enough*. Then we could fix it in the core.

And "exact enough" entirely depends on the context again, so really, I'm
not sure we can (and should!) fix that at the framework level.

Maxime

--3pz4fjkoxsas7y5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlMIQAKCRDj7w1vZxhR
xc6LAQCWG43IJjPcdV6NAx1M8x90MI1vXcM3D6N8NzmrVpQnJQD9EeUCxENPJjhD
Hv0cIlQ3XenPhpGlG2OclHNzNRlYhw4=
=HI+3
-----END PGP SIGNATURE-----

--3pz4fjkoxsas7y5a--
