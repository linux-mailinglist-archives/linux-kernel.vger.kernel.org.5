Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA67B7CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjJDKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjJDKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:20:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EA695
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:20:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyzB-0006b4-Ij; Wed, 04 Oct 2023 12:20:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyzA-00B0Ww-JG; Wed, 04 Oct 2023 12:20:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qnyzA-008v3I-9q; Wed, 04 Oct 2023 12:20:08 +0200
Date:   Wed, 4 Oct 2023 12:20:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Geurts <paul_geurts@live.nl>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: imx: fix tx statemachine deadlock
Message-ID: <20231004102008.giyogvnsc26ucx4k@pengutronix.de>
References: <AM0PR09MB26750E782F81CD447058FE7D95CBA@AM0PR09MB2675.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bn7gd7f23wh6bot"
Content-Disposition: inline
In-Reply-To: <AM0PR09MB26750E782F81CD447058FE7D95CBA@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7bn7gd7f23wh6bot
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

On Wed, Oct 04, 2023 at 11:57:22AM +0200, Paul Geurts wrote:
> When using the serial port as RS485 port, the tx statemachine is used to
> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> TTY port is closed in the middle of a transmission (for instance during
> userland application crash), imx_uart_shutdown disables the interface
> and disables the Transmission Complete interrupt. afer that,
> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> by the TC interrupt. This interrupt is disabled and therefore the tx
> statemachine never transitions out of SEND. The statemachine is in
> deadlock now, and the TX_EN remains low, making the interface useless.
>=20
> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> interrupts are enabled before bailing to be retriggered. This makes sure
> the state machine handling is reached, and is properly set to
> WAIT_AFTER_SEND.

Sounds reasonable.

A Fixes: line would be nice.

> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
> ---
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 13cb78340709..90a4b7841030 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -421,13 +421,13 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  	ucr1 =3D imx_uart_readl(sport, UCR1);
>  	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
> =20
> +	ucr4 =3D imx_uart_readl(sport, UCR4);
>  	usr2 =3D imx_uart_readl(sport, USR2);
> -	if (!(usr2 & USR2_TXDC)) {
> +	if ((!(usr2 & USR2_TXDC)) && (ucr4 & UCR4_TCEN)) {
>  		/* The shifter is still busy, so retry once TC triggers */
>  		return;
>  	}

So the new thing is: If the hardware is still busy sending stuff but
/dev/ttymxcX isn't open any more (i.e. .shutdown was called), the
transmitter gets disabled. I wonder if in this case disabling the
transmitter should be delayed until the shifter is empty? Or maybe this
should be handled in .shutdown, that is only disable TCEN once the
shifter is empty?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7bn7gd7f23wh6bot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdPFcACgkQj4D7WH0S
/k6pIAgAhtQzFddfFAsyp+llHfHprz6jXLIyZ7bFBtvlyvmF9gW4YrfowVrrhW5j
ITqbAMZ09+vg4YQn81euMB34qwkQJYv1oeQrdEb1aj/q991UySdETRiv9hujpxPo
VShKNb3ktSOqqwbZSjlw+2+H1s5Vx4YGlVnNOz6J5pVMoZ6NEodp1iI9kiycs7Pf
laxMn6XUXP4k1y/FO0D1fHXh4ZDvVbZA8wtchT0H8PNwC8SCTDHjWDa0qMlwl6ce
yOY4kNo41VHZIMJ1z3nDRj9QOzwOk2Thloq4SU0vJPBXCcn6A9fZLrgjNqUYTJnC
jUXlYXJmfBN6U9QnfewxKudVIxGgLA==
=Y1On
-----END PGP SIGNATURE-----

--7bn7gd7f23wh6bot--
