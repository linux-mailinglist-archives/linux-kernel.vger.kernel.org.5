Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC979AEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351227AbjIKVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbjIKJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:36 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A4E50;
        Mon, 11 Sep 2023 02:47:31 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 109AC1C0004; Mon, 11 Sep 2023 11:47:30 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:47:29 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John Watts <contact@jookia.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.1 10/26] can: sun4i_can: Add support for the
 Allwinner D1
Message-ID: <ZP7iMa8xv7RhxWU7@duo.ucw.cz>
References: <20230908181806.3460164-1-sashal@kernel.org>
 <20230908181806.3460164-10-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W6zyC+oVbfVKM7Mx"
Content-Disposition: inline
In-Reply-To: <20230908181806.3460164-10-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W6zyC+oVbfVKM7Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: John Watts <contact@jookia.org>
>=20
> [ Upstream commit 8abb95250ae6af2d51993da8fcae18da2ce24cc4 ]
>=20
> The controllers present in the D1 are extremely similar to the R40
> and require the same reset quirks, but An extra quirk is needed to support
> receiving packets.

Well, we are not adding the rest of support to 6.1, so we don't need
this, either. It will be unused.

BR,
								Pavel

> +++ b/drivers/net/can/Kconfig
> @@ -174,10 +174,10 @@ config CAN_SLCAN
> =20
>  config CAN_SUN4I
>  	tristate "Allwinner A10 CAN controller"
> -	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
> +	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
>  	help
>  	  Say Y here if you want to use CAN controller found on Allwinner
> -	  A10/A20 SoCs.
> +	  A10/A20/D1 SoCs.
> =20
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called sun4i_can.
> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index dd0c6cd76c5f5..c3a6b028ea4d6 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -91,6 +91,8 @@
>  #define SUN4I_REG_BUF12_ADDR	0x0070	/* CAN Tx/Rx Buffer 12 */
>  #define SUN4I_REG_ACPC_ADDR	0x0040	/* CAN Acceptance Code 0 */
>  #define SUN4I_REG_ACPM_ADDR	0x0044	/* CAN Acceptance Mask 0 */
> +#define SUN4I_REG_ACPC_ADDR_D1	0x0028	/* CAN Acceptance Code 0 on the D1=
 */
> +#define SUN4I_REG_ACPM_ADDR_D1	0x002C	/* CAN Acceptance Mask 0 on the D1=
 */
>  #define SUN4I_REG_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer st=
art */
>  #define SUN4I_REG_RBUF_RBACK_END_ADDR	0x01b0	/* CAN transmit buffer end =
*/
> =20
> @@ -779,6 +781,11 @@ static const struct sun4ican_quirks sun4ican_quirks_=
r40 =3D {
>  	.acp_offset =3D 0,
>  };
> =20
> +static const struct sun4ican_quirks sun4ican_quirks_d1 =3D {
> +	.has_reset =3D true,
> +	.acp_offset =3D (SUN4I_REG_ACPC_ADDR_D1 - SUN4I_REG_ACPC_ADDR),
> +};
> +
>  static const struct of_device_id sun4ican_of_match[] =3D {
>  	{
>  		.compatible =3D "allwinner,sun4i-a10-can",
> @@ -789,6 +796,9 @@ static const struct of_device_id sun4ican_of_match[] =
=3D {
>  	}, {
>  		.compatible =3D "allwinner,sun8i-r40-can",
>  		.data =3D &sun4ican_quirks_r40
> +	}, {
> +		.compatible =3D "allwinner,sun20i-d1-can",
> +		.data =3D &sun4ican_quirks_d1
>  	}, {
>  		/* sentinel */
>  	},
> @@ -915,4 +925,4 @@ module_platform_driver(sun4i_can_driver);
>  MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
>  MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
>  MODULE_LICENSE("Dual BSD/GPL");
> -MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
> +MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20/D1)");

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--W6zyC+oVbfVKM7Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7iMQAKCRAw5/Bqldv6
8iNHAKCr9iGC2Pae585vS5gdFDGcVzZNgQCgouu4FKM/lvI8gqIRrcpjyUG7DsQ=
=22Uz
-----END PGP SIGNATURE-----

--W6zyC+oVbfVKM7Mx--
