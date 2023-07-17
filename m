Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772657565E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGQOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGQOKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FBBE4;
        Mon, 17 Jul 2023 07:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69A3061083;
        Mon, 17 Jul 2023 14:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9A8C433C7;
        Mon, 17 Jul 2023 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689603012;
        bh=4U92qRAElWb46SuTSbxB4W1rQOPWs4rZsSOf0z5EGRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbGxkt+UVBtXxbaulXc5B1qXahhNhWIlyQ08rWUY19gfDVxpuy9NczSGMEMpLUjNK
         3gKqVS0aunWM5jBnIFLOx82oAQP55XJEgZ1NyfV2Dfp78ZuNZ/NqQYPMo0ADX6UUZ2
         0hd50R4WT4CzdQRgrNyfb/16x1iGJWlM5I1OGvOHW51fElzDTbK1KAK+880VUYG0h/
         /rvuIRQlysOecM68gEZgEUa1VpigpM6buj2LmHTi1ptbI4MMUJlL2u1tg/orXK/rdz
         xHTOYqdWYXtzc8slajBrF4ak8n4PHe5738XHQI0/+rV/hDbnlYKUNjnDp+lrmygTyn
         GUHj7H+9dVY7g==
Date:   Mon, 17 Jul 2023 16:10:10 +0200
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
Subject: Re: [PATCH v4 03/11] clk: sunxi-ng: nkm: Improve determine rate when
 setting parent
Message-ID: <be4m7h45d2mjp7q32ovtg3pj7e3ut7clmclnlbwftohpnvl4yy@msdzcqqoinwi>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
 <20230717-pll-mipi_set_rate_parent-v4-3-04acf1d39765@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unxqocoapvnvkbic"
Content-Disposition: inline
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-3-04acf1d39765@oltmanns.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unxqocoapvnvkbic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2023 at 03:34:27PM +0200, Frank Oltmanns wrote:
> Make the SET_PARENT_RATE flag independent of the parents round_rate or
> determine_rate implementation.
>=20
> Currently, the algorithm for ccu_nkm_find_best_with_parent_adj simply
> calculates the optimal parent rate as
>     (1) parent =3D rate * m / (n * k)
>=20
> Due to integer division (1) might return a parent rate that is too low.
> So using this value for asking the parent for a rate it supports via
> clk_hw_round_rate causes problems on
>  a) parents that only support finding rates that are lower than the
>     requested rate - which is the default for sunxi-ng ccu's.
>  b) parents that incidentally also support the truncated rate.
>=20
> In those cases ccu_nkm_determine_rate might return A' when A is
> requested and A'' when rate A' is requested.
>=20
> Prevent this by trying to find a parent rate so that
>     (2) _rate =3D parent * n * k / m
> matches the requested rate exactly, if possible.
>=20
> Background:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> determine_rate may be called multiple times by the clk framework when
> setting a clock's rate. But the clk framework expects that the values
> determine_rate returns (i.e. the rate and parent_rate) are consistent
> with previous calls.
>=20
> Specifically, clock's have to ensure that if determine_rate is called
> with requested rate A and the best rate it can find is A', it must also
> return A' when called with requested rate A'.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

As stated in my earlier mail, I still disagree with that patch.

Maxime

--unxqocoapvnvkbic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLVLwgAKCRDj7w1vZxhR
xT2CAQCu5UgvRKlm9DcPqWI4459I3lzWce3sXAKd5IC/SEl3OgD/U+Bi14JO9N0j
HHS37rbZ25r4rTFuW1k9JkQ4VPvbAQY=
=Uldq
-----END PGP SIGNATURE-----

--unxqocoapvnvkbic--
