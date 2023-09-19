Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581477A5AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjISHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjISHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:31:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FF211A;
        Tue, 19 Sep 2023 00:31:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6539C433C8;
        Tue, 19 Sep 2023 07:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695108699;
        bh=c8Jda3J+RhTWA4ijuCRZYSHme2R9CMRcX025MvqhKWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWKb7fqgAsdPyITs/ng3rd6kRyzAEvbEg0CsfVTkaem2KV+R8S+vnc5Pw1SmiaXxV
         IckberZW3K1GtRiC+8vAsQ81c6T2vmVkVIbMcN0POV024F2AOQ+8I1XS+sbRdZoE7Y
         1G5vwtR10gIpigpW0BvThdnGBCbrD4ywTgDmK5awI93ZQVZSh+Qm0vSB8Sy/Hue6JU
         byoGujV8JGMBIPS2uy221+6Vrv2KjHrutiYo4rg/bye/5qjeS0mYTdxiFh0CH71e5R
         QIsUJyCh3UzdF151UJSrKbwBapmj5pAI7LORymIxi3Wf5Vhhzotw2YHJdFJN4smXEu
         KfXcMaHVz1b2w==
Date:   Tue, 19 Sep 2023 09:31:36 +0200
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
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
Message-ID: <7at35ykai5lyeaci3xvklrfk4xg4hn3jnw4fz3egqobjvnglbz@cv45l3mrhtct>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rra6xzzb3zzwrtqx"
Content-Disposition: inline
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rra6xzzb3zzwrtqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 18, 2023 at 12:39:56AM +0200, Benjamin Bara wrote:
> Target of this series is to dynamically set the rate of video_pll1 to
> the required LVDS clock rate(s), which are configured by the panel, and
> the lvds-bridge respectively.
>=20
> Some background:
> The LVDS panel requires two clocks: the crtc clock and the lvds clock.
> The lvds rate is always 7x the crtc rate. On the imx8mp, these are
> assigned to media_disp2_pix and media_ldb, which are both
> clk-composite-8m. The rates are set by drm_client_modeset_commit() (and
> later by fsl_ldb_atomic_enable()), and the fsl-ldb driver, first crtc,
> then lvds. The parent is typically assigned to video_pll1, which is a
> clk-pll14xx (pll1443x).
>=20
> The main problem:
> As the clk-composite-8m currently doesn't support CLK_SET_RATE_PARENT,
> the crtc rate is not propagated to video_pll1, and therefore must be
> assigned in the device-tree manually.
>=20
> The idea:
> Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ldb.
> When this is done, ensure that the pll1443x can be re-configured,
> meaning it ensures that an already configured rate (crtc rate) is still
> supported when a second child requires a different rate (lvds rate). As
> the children have divider, the current approach is straight forward by
> calculating the LCM of the required rates. During the rate change of the
> PLL, it must ensure that all children still have the configured rate at
> the end (and maybe also bypass the clock while doing so?). This is done
> by implementing a notifier function for the clk-composite-8m. The tricky
> part is now to find out if the rate change was intentional or not. This
> is done by adding the "change trigger" to the notify data. In our case,
> we now can infer if we aren't the change trigger, we need to keep the
> existing rate after the PLL's rate change. We keep the existing rate by
> modifying the new_rate of the clock's core, as we are quite late in an
> already ongoing clock change process.

So just like the discussion we had on the Allwinner stuff, I don't think
you can cover it completely within the framework. If we take a step
backward, I guess what you want is that you have multiple clocks,
feeding multiple displays at varying clock rates depending on the
resolution, and the parent needs to accomodate all of them, right?

Could you share the clock tree and the capability of each clocks (range
of the multipliers / dividers mostly)?

I'm wondering if we couldn't set the parent clock to a fairly high rate
that would be high enough for each child to reach whatever rate it needs
to have without the need for CLK_SET_RATE_PARENT.

Maxime

--rra6xzzb3zzwrtqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQlOWAAKCRDj7w1vZxhR
xeBiAP4jttHKIfgVxUcdg4EmJxBQdy3Fu1rxc1KHBNTMdjPJaAEA9bFwNcsUbV6n
+2VSHcZbhMSCH+91fdbGdVwx08U2rAo=
=VMgi
-----END PGP SIGNATURE-----

--rra6xzzb3zzwrtqx--
