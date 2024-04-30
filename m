Return-Path: <linux-kernel+bounces-163771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288F8B6FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC551F23423
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C413D299;
	Tue, 30 Apr 2024 10:28:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502913D240
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472900; cv=none; b=s+KiXUleTxc+WL5vpOZENROvBd1g0Y5YXtjv8WbcCxyJUxn28bWg+QqsEy07MMMIniJqWZa4W17lfgUVVWw4j/idoE7pHB4MiBadhJZudI0/GH4TSTFDNzaK1eIdNMIB2oImUozTumVLiQFk5+vFAoEuNN5dExjOzsiR90xYwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472900; c=relaxed/simple;
	bh=17TzqhMYzGeft7fLUsMzLJTT61KYGgxRAOmEk0hDiTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htMkJ6XvMTg1+Tqe/Ib13m5HCsHpQbzhrPzxfgpkjSCPxrOELpw3kx68Ts9KVxNOor7/NbGY8bjXmgCrsQGPger3+LuNYUuvIG1Tfo1fcQanMNsKfQFHWTmBzlsN62RUt32tBsYM18LBXxr6FZGp+gkUTKDaL3swsEao4fytdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1kiT-00011g-Lh; Tue, 30 Apr 2024 12:28:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s1kiS-00F92s-3T; Tue, 30 Apr 2024 12:28:04 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D24D2C4A51;
	Tue, 30 Apr 2024 09:10:59 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:10:58 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240430-curassow-of-improbable-poetry-1611f8-mkl@pengutronix.de>
References: <20240311121143.306403-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyt4gwwqp74cbnux"
Content-Disposition: inline
In-Reply-To: <20240311121143.306403-1-ivitro@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kyt4gwwqp74cbnux
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.03.2024 12:11:43, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> When the mcp251xfd_start_xmit() function fails, the driver stops
> processing messages, and the interrupt routine does not return,
> running indefinitely even after killing the running application.
>=20
> Error messages:
> [  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
> [  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empt=
y. (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0, tx_head=
=3D0x000017d3).
> ... and repeat forever.
>=20
> The issue can be triggered when multiple devices share the same
> SPI interface. And there is concurrent access to the bus.
>=20
> The problem occurs because tx_ring->head increments even if
> mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> TX package while still expecting a response in
> mcp251xfd_handle_tefif_one().
>=20
> This patch resolves the issue by decreasing tx_ring->head if
> mcp251xfd_start_xmit() fails. With the fix, if we trigger the issue and
> the err =3D -EBUSY, the driver returns NETDEV_TX_BUSY. The network stack
> retries to transmit the message.
> Otherwise, it prints an error and discards the message.
>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>=20
> V2->V3:
>   - Add tx_dropped stats.
>   - netdev_sent_queue() only if can_put_echo_skb() succeed.
>=20
> V1->V2:
>   - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() =3D=3D -EBUSY.
>   - Rework the commit message to address the change above.
>   - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_write()=
 succeed.
>     Otherwise, we get Kernel NULL pointer dereference error.
>=20
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 34 ++++++++++++--------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-tx.c
> index 160528d3cc26..146c44e47c60 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> @@ -166,6 +166,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
>  				 struct net_device *ndev)
>  {
>  	struct mcp251xfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
>  	struct mcp251xfd_tx_ring *tx_ring =3D priv->tx;
>  	struct mcp251xfd_tx_obj *tx_obj;
>  	unsigned int frame_len;
> @@ -181,25 +182,32 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *sk=
b,
>  	tx_obj =3D mcp251xfd_get_tx_obj_next(tx_ring);
>  	mcp251xfd_tx_obj_from_skb(priv, tx_obj, skb, tx_ring->head);
> =20
> -	/* Stop queue if we occupy the complete TX FIFO */
>  	tx_head =3D mcp251xfd_get_tx_head(tx_ring);
> -	tx_ring->head++;
> -	if (mcp251xfd_get_tx_free(tx_ring) =3D=3D 0)
> -		netif_stop_queue(ndev);
> -
>  	frame_len =3D can_skb_get_frame_len(skb);
> -	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
> -	if (!err)
> -		netdev_sent_queue(priv->ndev, frame_len);
> +
> +	tx_ring->head++;
> =20
>  	err =3D mcp251xfd_tx_obj_write(priv, tx_obj);
> -	if (err)
> -		goto out_err;
> +	if (err) {
> +		tx_ring->head--;
> =20
> -	return NETDEV_TX_OK;
> +		if (err =3D=3D -EBUSY)
> +			return NETDEV_TX_BUSY;
> =20
> - out_err:
> -	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
> +		stats->tx_dropped++;
> +
> +		if (net_ratelimit())
> +			netdev_err(priv->ndev,
> +				   "ERROR in %s: %d\n", __func__, err);
> +	} else {
> +		err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
> +		if (!err)
> +			netdev_sent_queue(priv->ndev, frame_len);
> +
> +		/* Stop queue if we occupy the complete TX FIFO */
> +		if (mcp251xfd_get_tx_free(tx_ring) =3D=3D 0)
> +			netif_stop_queue(ndev);
> +	}

Once you have sent the TX objects to the chip, it can trigger a TX
complete IRQ. This is not very likely as the SPI sends asynchronously
and the xmit handler cannot sleep.

This means you have to call can_put_echo_skb() and stop the queue if
needed, _before_ you call mcp251xfd_tx_obj_write(). In case of an error,
you have to roll-back these.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kyt4gwwqp74cbnux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYwtZMACgkQKDiiPnot
vG8c8Af7B+kXfKdty6H3EChYBzrzZZFfPSb4H/y7hspY16T0JGasHn4yiY5AzDxf
QlaTBrx2ritE5JLosJD4TRs/5yUw52Dd3fJCEXp50VP5ziT6t332RCSHMrHfT2aF
aq5xU0srFHnfMgpiHgYidmfG/EIQXBAxGUlYFqnry7Q/JklyjOtYdrcyUQWaJ5R0
CgqkjzYeaQ1vOu2C0pNXblx54xiu0cGsTio9/Zmn4rNrB/u3PvdMwVNYJan3uhIH
HDOvKO/dvPkjfymriQutKSeUfLcnoiaFp44hglhfeKDnLDbQNFs7yIhzaKXUc9g3
UScv9TaxR3r/0LHab+IThgsRIgTmZQ==
=6kq0
-----END PGP SIGNATURE-----

--kyt4gwwqp74cbnux--

