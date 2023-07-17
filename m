Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4817565F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGQOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjGQOMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87619F5;
        Mon, 17 Jul 2023 07:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D936109A;
        Mon, 17 Jul 2023 14:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AFEC433CB;
        Mon, 17 Jul 2023 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689603153;
        bh=qfhbbwJv5aDzSLrzg8XRkxXRcjef0UeV+hzSGXZzqxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRhnMJOYfAFW+tpb90d2IMVUZ5kDsagtVxdUvHTg9he9RReFa0TQFixCb+XySbG+1
         nW/H3p8C/eKLN/0Q3EpLrN2WF3pQ695s/U9PudEaEUdxkop2jcI4yo2ddYCxUG9gcz
         JfpI3WlkgsdgwYd88nqN/hP0yWO8zB4op6na34xzUKSX9rPKLN60LXJGnQWH9RyCJD
         pzsr067QfW0v510F3seZG+WaPaMZRxRUs4gLfHh0sMf8DPU/b9oGhrqd3DYfdVQ38U
         7ntnBGmbvmlVUIOrBrwp1rmFbBoan0DhmmwdO55w8yYD8mB0S4qm4dnieXwc95nSE/
         qLueazg23c+Ew==
Date:   Mon, 17 Jul 2023 16:12:30 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] clk: sunxi-ng: nm: Support finding closest rate
Message-ID: <htxtcpqimrloxvebm5iadqzybj3rt5c532smtm62kxeuaejaqw@syknyzrhgf7f>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-7-04acf1d39765@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t24u7yc3dj2s45pr"
Content-Disposition: inline
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-7-04acf1d39765@oltmanns.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t24u7yc3dj2s45pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 03:34:31PM +0200, Frank Oltmanns wrote:
> Use the helper function ccu_is_better_rate() to determine the rate that
> is closest to the requested rate, thereby supporting rates that are
> higher than the requested rate if the clock uses the
> CCU_FEATURE_CLOSEST_RATE.
>=20
> Add the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST which
> sets CCU_FEATURE_CLOSEST_RATE.
>=20
> To avoid code duplication, add the macros
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT that allows selecting
> arbitrary features and use it in the original
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX as well as the newly introduced
> SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST macros.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nm.c | 11 ++++------
>  drivers/clk/sunxi-ng/ccu_nm.h | 48 +++++++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 49 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index c1fd11542c45..35d00783d748 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -28,7 +28,7 @@ static unsigned long ccu_nm_calc_rate(unsigned long par=
ent,
>  }
> =20
>  static unsigned long ccu_nm_find_best(unsigned long parent, unsigned lon=
g rate,
> -				      struct _ccu_nm *nm)
> +				      struct _ccu_nm *nm, struct ccu_common *common)

The common pointer must be the first argument.

Once fixed,
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--t24u7yc3dj2s45pr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLVMTgAKCRDj7w1vZxhR
xTTeAP4knutmR1GxPcDRsDiuskf3/7DgS1IxkgPc6Q8ZlWOs6wD+Kyh9V78+vpqR
NkvgKKgQRVvoWmJwYa+z0lVEc//OyAU=
=lLGg
-----END PGP SIGNATURE-----

--t24u7yc3dj2s45pr--
