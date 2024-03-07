Return-Path: <linux-kernel+bounces-95526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87035874EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70FC1F236F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984B12B167;
	Thu,  7 Mar 2024 12:23:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAB12A154
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814190; cv=none; b=QDJ5B+iwrVSiPjLa5ERhOfhNyr68kRNWp8bE3Gomnj4JN7KMx45CzUlhoLAPyF1YQqI0/wwxIEH7WGV49MwxE4RmmjzpH/ey/BQdvkzppyWk6lsIPT9XTVLQqaMCyXtz0GgjRHKR6r3scxufS9VpO7mEesnnD9NsJomlTPrnzUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814190; c=relaxed/simple;
	bh=gCgn0qdMJNBr4dhBbAUi5QMd9i2YnT+21lB2V2syJNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szWQKra/LtnBMTFujVI+9pUARo7eN4sroqgiQ5p8BO3PxFr4EFCgIXh7eFGTAGReyvKYs7N3mn4czLgYffbx6GU2JmG2Hgj36q7+EmytorROyH6y529K2vyc89kdmVIny7UNMWMuonpkGzpHsHvJBxk9MDRHPsuHY6ZjzoXnfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1riCm7-0004jX-AP; Thu, 07 Mar 2024 13:23:03 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1riCm6-004w9T-L3; Thu, 07 Mar 2024 13:23:02 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C2A92A086C;
	Thu,  7 Mar 2024 12:23:02 +0000 (UTC)
Date: Thu, 7 Mar 2024 13:23:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com, 
	wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vitor.soares@toradex.com, stable@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <xmk5cgskx2ug2psec6qgbxndbuqq5cnin7rd4zt3thnhybxgeo@xudpdob7tcg2>
References: <20240307120442.12262-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7skr4ctodjzwe4v"
Content-Disposition: inline
In-Reply-To: <20240307120442.12262-1-ivitro@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--z7skr4ctodjzwe4v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, resend. I fsck up the linux-can ML's address.

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

--z7skr4ctodjzwe4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXpsaIACgkQKDiiPnot
vG+Whwf+KRkCgvw56NbiASrI8ezzUbH91uXRXQoqqquK1+9Ipudd3jqizmDkyFLF
L3Vw0GvrcdO5t3Wv8Tn2JxbfkiZvvfmVFJ7nD0THzqnjJr6ZKR+73okKuwcvxq/Y
G4lKLnQlgF1AfAsdTCJEuz4SNBrWDx4EsAEuTa2Tp5eBs0ePEPatZyml1wL8l6Dv
zOPh/Y9c+wWiSzGHFELXnfe9SaoDfUat+NIlJ4AsfxuXMSys4aQ+8Hz+ynoJFBp8
qYL0/9C/wBCaBF5mlv92guEQN8ZTcD8PxMfa7ZcqhEmO9e/1zET1HCDZYv+6yF/e
uv1rJNxBSob5knxMJiZUJTUQIACzQA==
=zeld
-----END PGP SIGNATURE-----

--z7skr4ctodjzwe4v--

