Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09F752B11
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjGMTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGMTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:38:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A64269D;
        Thu, 13 Jul 2023 12:38:16 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40D93660704B;
        Thu, 13 Jul 2023 20:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689277095;
        bh=LCTHlbt9t3lIo/yJabi6ZxoDAc2P6YaDBhZi4GtjP58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgICHNlTWBb3DvnETMeo90SwdkRHWdjCiK+w2oRIUIUu1mkG75UswADjjq/uJirWt
         Bl6uIZl1DuZxUjQgfedKFdzU/httYdFOS69tf3NddCHkJApfDQhHeBpth1jgqs6jAw
         fXrNzaS97mzBwPb13lzZJhtSW2SAM5hjEg4spPk2DJUkiYe+QRkmBOFrNCsdvbuPRF
         2nS0aG55sqgFk2lOlLhqcpDj5NmJ3/8ik5GhiB6BPXeiVXFmyD77Jr5wUat0jjNRwl
         l7WFAGZgI6XG1BQXbOa3i93rzS6Ea3Cfi+azHQiVQk6CoU6XpJgu6v1pjflT58ytCq
         icQ/UGivvUIKQ==
Received: by mercury (Postfix, from userid 1000)
        id 745D01062E2E; Thu, 13 Jul 2023 21:38:12 +0200 (CEST)
Date:   Thu, 13 Jul 2023 21:38:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCHv2 1/2] clk: rockchip: rk3588: make gate linked clocks
 ignore unused
Message-ID: <20230713193812.px7q4sdfdppuywsg@mercury.elektranox.org>
References: <20230403193250.108693-1-sebastian.reichel@collabora.com>
 <20230403193250.108693-2-sebastian.reichel@collabora.com>
 <CA+VMnFz4USPcXmQMyUB9n5EVmvQrJARDvnpO7iBrXZ8q2xcyAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckdtegxpm7vrxvpt"
Content-Disposition: inline
In-Reply-To: <CA+VMnFz4USPcXmQMyUB9n5EVmvQrJARDvnpO7iBrXZ8q2xcyAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ckdtegxpm7vrxvpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jagan,

On Thu, Jul 13, 2023 at 08:25:03PM +0530, Jagan Teki wrote:
> On Tue, 4 Apr 2023 at 01:03, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> [...]
> > + * Recent Rockchip SoCs have a new hardware block called Native Interf=
ace
> > + * Unit (NIU), which gates clocks to devices behind them. These effect=
ively
> > + * need two parent clocks.
> > + *
> > + * Downstream enables the linked clock via runtime PM whenever the gat=
e is
> > + * enabled. This implementation uses separate clock nodes for each of =
the
> > + * linked gate clocks, which leaks parts of the clock tree into DT.
> > + *
> > + * The GATE_LINK macro instead takes the second parent via 'linkname',=
 but
> > + * ignores the information. Once the clock framework is ready to handl=
e it, the
> > + * information should be passed on here. But since these clocks are re=
quired to
> > + * access multiple relevant IP blocks, such as PCIe or USB, we mark al=
l linked
> > + * clocks critical until a better solution is available. This will was=
te some
> > + * power, but avoids leaking implementation details into DT or hanging=
 the
> > + * system.
> >   */
>=20
> Does it mean the clk-link topology in the downstream kernel can be
> reused the same as normal clock notation?

Yes.

> For example, I'm trying to add HCLK_VO1 directly to VO1 syscon instead
> of routing to pclk_vo1_grf(done downstream)
>       vo1_grf: syscon@fd5a8000 {
>                compatible =3D "rockchip,rk3588-vo-grf", "syscon";
>                reg =3D <0x0 0xfd5a8000 0x0 0x100>;
>              clocks =3D <&cru HCLK_VO1>;

You need PCLK_VO1 (which is currently not exposed; I somehow missed
it).

>       };
>=20
> This seems breaking syscon for vo1_grf and observed a bus error
> while accessing regmap.=20

I investigated the issue you are seeing some weeks ago when my
co-workers started to work on HDMI RX and TX. You are probably
just missing this patch:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/comm=
it/ecc6415344957fa88356cec10f8b75a9da603a7b

> I remember in one of the RKDC discussion that the double parenting
> of these clocks is mandatory while accessing associated IP blocks.

Yes, it is necessary.

> Any thoughts?

The upstream workaround/hack is to have the second parent always
enabled. This obviously wastes power, but means that the hardware
description in the DT is correct. Once the clock framework supports
two parents the kernel can be updated without touching the DT,
which is considered ABI.

Greetings,

-- Sebastian

--ckdtegxpm7vrxvpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSwUpcACgkQ2O7X88g7
+prvUBAAmj/+1Y2EoNVM52dwbYtpsK+nyCPxZN7qF818FlAZMAPLUPGLEhy5h+oT
9yP7Tj2QaoM1WIRajoE/q3UshWnjsZWLRdDqeZsAcsaUfl24MrvzhiYdm/hce0jT
7pL5gW8LJ6apq194xsC64AcF7AOHRBqduoHmlSmBg8Jz3t+O530MGtMCxLf7wCJl
teEmkynSKx/BMYOORifhfoaoNtV5LgvDYjaBSrJ6IpZmCeMuKwmL4TR4xoUVFBaR
IVu8nsnFn3bRhZ85T9R3NgfriPj2BLLbIsDe+qD8blzCETH9vAhAWDpKzBFnJ0NZ
w8XcusaDX1vFOnzjaat/7OKxkguApB8eh/WLAZ1aXDZ0OwpntP3yMduoY5fmixKZ
OrHS2H6wAELKuNO3UOkLfGqEE60+z2A3HEqZA5ltZWud6+oPtRENVmYSjDzNaEjl
lRb/PFMYU6MVFiVtfxqgwKXMLqqIL/Pk3wfgY32FYvTrWkNiCSh0+AFBx8iVzCFI
kTfPuC5o+k+FN7wxqvLYfpgI6poZYs1CSFMLOzpof3/79aJN/NaFbTGW8bngnFIQ
CL2ycYNleFr91CYk83fQ7jbkR0VUd774yCH7FO8ytZjxl5uvecMEwBG3GAn+pZh7
Ns4kvC9k2SepoVw/FUj5ywI+DeizHMAkeR1Hjs5KP4A0nFESZqY=
=ytIK
-----END PGP SIGNATURE-----

--ckdtegxpm7vrxvpt--
