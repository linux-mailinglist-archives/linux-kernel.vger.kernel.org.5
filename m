Return-Path: <linux-kernel+bounces-95522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4618874ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD2B22CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A2412A161;
	Thu,  7 Mar 2024 12:21:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19C128801
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814083; cv=none; b=PAWb+uOBLJbqwFVl5BpMMyecZbzMBSfDnJdZcjJlbKZzVnJJEjSqBiNyGtloGAH48q9SEfK8EpVSZNYT6nk4LfCfBng1GR8BuXieFc2FOScbIDRfge6MRS8zliTzoy6mM5xSL/MrG5skLrO9csf+SM1PTa6SY2jAB/frpuOeOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814083; c=relaxed/simple;
	bh=Lkz65xopRFkezQafKKmU9YW0VUXK84Tkn/cr5N1VgbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGvIWfI3+BanSyC0lW09XP4CGv/lNng5Pe3gZYlxEqJmU9/tIAlCbKeBSxyezaM6KxvSC6b8IWG4e02ejkpsLXp/DwZLuorKRz6ZzZiWiZNhvEzn8Eo7k3aoy+criMkfFeIbB43f/OJ1KRR7Y+JH+Qx0K6KsuZ3bvKoE4qyG7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1riCkI-00035z-6E; Thu, 07 Mar 2024 13:21:10 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1riCkH-004w9H-6v; Thu, 07 Mar 2024 13:21:09 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A50322A0863;
	Thu,  7 Mar 2024 12:21:08 +0000 (UTC)
Date: Thu, 7 Mar 2024 13:21:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com, 
	wg@grandegger.com, linux-can@vger.kernel, linux-kernel@vger.kernel.org, 
	vitor.soares@toradex.com, stable@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240307-drift-hate-0919e82ee341-mkl@pengutronix.de>
References: <20240307120442.12262-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g63t2qxnscz3njvz"
Content-Disposition: inline
In-Reply-To: <20240307120442.12262-1-ivitro@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--g63t2qxnscz3njvz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.03.2024 12:04:42, Vitor Soares wrote:
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
> mcp251xfd_start_xmit() fails. With the fix, if we attempt to trigger
> the issue again, the driver prints an error and discard the message.

What about returning NETDEV_TX_BUSY, then the networking stack will
retry.

> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 27 ++++++++++----------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-tx.c
> index 160528d3cc26..a8eb941c1b95 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> @@ -181,25 +181,26 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *sk=
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
> +	can_put_echo_skb(skb, ndev, tx_head, frame_len);
> +
> +	tx_ring->head++;
> =20
>  	err =3D mcp251xfd_tx_obj_write(priv, tx_obj);
> -	if (err)
> -		goto out_err;
> +	if (err) {
> +		can_free_echo_skb(ndev, tx_head, NULL);
> =20
> -	return NETDEV_TX_OK;
> +		tx_ring->head--;
> +

I'm not sure, if we want an error message for -EBUSY. We could add
proper ethtool statistics.

> +		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
> +	} else {
> +		/* Stop queue if we occupy the complete TX FIFO */
> +		if (mcp251xfd_get_tx_free(tx_ring) =3D=3D 0)
> +			netif_stop_queue(ndev);
> =20
> - out_err:
> -	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
> +		netdev_sent_queue(priv->ndev, frame_len);
> +	}
> =20
>  	return NETDEV_TX_OK;
>  }

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g63t2qxnscz3njvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXpsTAACgkQKDiiPnot
vG+S3ggAliJL81O5z6GF9c4x5R2wUoT5oWY60OKSo9Z/uEhnEsH2Pt2uaOlXe9LP
vEXtH8ms8Fj3+91Js3rLGiLEa1xDKlq/u/pbCRQdUGKNpD+AVusB+QEbP0mxhz5P
1puPong7lP48wzY2FEPzJ//2SyPAwAqJdx0I/7+iKGSJNXVCgyjfD1+vMf11iDDh
/cT2jxP3TyR/qlcJoSxZathNcHYiPRe1YoJfSa/pAJ15Ahc01+lZ8vRQ/MrUVZ/2
x4Hghc/+jzkD88JmNYyPI61/G0rjOGhdXEZVLnD4rNscy8YRVCgbbHA4kn/TwEJv
LQH0RsGzQg9zw2wsOvxQAHdmlbxyWQ==
=mqKg
-----END PGP SIGNATURE-----

--g63t2qxnscz3njvz--

