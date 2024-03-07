Return-Path: <linux-kernel+bounces-96210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EE8758AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26AA1C21E18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A949139569;
	Thu,  7 Mar 2024 20:40:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C182375B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844047; cv=none; b=r0J1hoX+0ruKDrFY7Jx+rRg65l4bZi7SMq8CoJsqmiwk5kPnDQzQqnE6xHWyoVtAK8cv50Qp5tYL2y6QhKEmZnu3Yc6g+JemySh2gQtUS+4tviz4KL3JdIIFO4oZMya4xWJMQ5IFK0U8A+re5sbDt4Tm/aEwgpaL15bsyI3N5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844047; c=relaxed/simple;
	bh=PU/nsmIjvcb9jT9tFNblBBBYPCVtyRr9mA8Zg4T1z34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9H8BT3uGhHFi3nS1RCHDrIAPe0w+XX3j9gwWd8/wzw4tJAYqm8T1+KQZSo6+COzIrYtIMR3xZRJtuZY8T+owuJnXoko63sVS5uI2EDYfAdIwwNWqvyDf9CHjYdLHk2j25wjsNUW8Ob+TorYqWS47rLy6ikN8TuwZFCgOg0HXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1riKXc-0000hJ-SE; Thu, 07 Mar 2024 21:40:36 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1riKXb-0050ZH-EG; Thu, 07 Mar 2024 21:40:35 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE4C32A0DEE;
	Thu,  7 Mar 2024 20:40:34 +0000 (UTC)
Date: Thu, 7 Mar 2024 21:40:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: vitor <ivitro@gmail.com>
Cc: manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com, 
	wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vitor.soares@toradex.com, stable@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240307-sturdy-cringe-fa9b095b25ab-mkl@pengutronix.de>
References: <20240307120442.12262-1-ivitro@gmail.com>
 <xmk5cgskx2ug2psec6qgbxndbuqq5cnin7rd4zt3thnhybxgeo@xudpdob7tcg2>
 <75fa2711c1aace90a831f95a00b8ba41abf1c883.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzpod2lt32mid3zt"
Content-Disposition: inline
In-Reply-To: <75fa2711c1aace90a831f95a00b8ba41abf1c883.camel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--xzpod2lt32mid3zt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.03.2024 16:54:13, vitor wrote:
> > On 07.03.2024 12:04:42, Vitor Soares wrote:
> > > From: Vitor Soares <vitor.soares@toradex.com>
> > >=20
> > > When the mcp251xfd_start_xmit() function fails, the driver stops
> > > processing messages, and the interrupt routine does not return,
> > > running indefinitely even after killing the running application.
> > >=20
> > > Error messages:
> > > [=C2=A0 441.298819] mcp251xfd spi2.0 can0: ERROR in
> > > mcp251xfd_start_xmit: -16
> > > [=C2=A0 441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer
> > > not empty. (seq=3D0x000017c7, tef_tail=3D0x000017cf,
> > > tef_head=3D0x000017d0, tx_head=3D0x000017d3).
> > > ... and repeat forever.
> > >=20
> > > The issue can be triggered when multiple devices share the same
> > > SPI interface. And there is concurrent access to the bus.
> > >=20
> > > The problem occurs because tx_ring->head increments even if
> > > mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> > > TX package while still expecting a response in
> > > mcp251xfd_handle_tefif_one().
> > >=20
> > > This patch resolves the issue by decreasing tx_ring->head if
> > > mcp251xfd_start_xmit() fails. With the fix, if we attempt to
> > > trigger
> > > the issue again, the driver prints an error and discard the
> > > message.
> >=20
> > What about returning NETDEV_TX_BUSY, then the networking stack will
> > retry.
>=20
> Do you mean when err =3D=3D -EBUSY?

ACK

> >=20
> > > Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip
> > > MCP25xxFD SPI CAN")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > ---
> > > =C2=A0drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 27 ++++++++++---=
---
> > > ----
> > > =C2=A01 file changed, 14 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > > b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > > index 160528d3cc26..a8eb941c1b95 100644
> > > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
> > > @@ -181,25 +181,26 @@ netdev_tx_t mcp251xfd_start_xmit(struct
> > > sk_buff *skb,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_obj =3D mcp251xfd_=
get_tx_obj_next(tx_ring);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mcp251xfd_tx_obj_from=
_skb(priv, tx_obj, skb, tx_ring-
> > > >head);
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Stop queue if we occupy=
 the complete TX FIFO */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_head =3D mcp251xfd=
_get_tx_head(tx_ring);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head++;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_get_tx_free(=
tx_ring) =3D=3D 0)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0netif_stop_queue(ndev);
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0frame_len =3D can_skb=
_get_frame_len(skb);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D can_put_echo_skb(s=
kb, ndev, tx_head, frame_len);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!err)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0netdev_sent_queue(priv->ndev, frame_len);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can_put_echo_skb(skb, ndev=
, tx_head, frame_len);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head++;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D mcp251xfd_tx_=
obj_write(priv, tx_obj);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out_err;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0can_free_echo_skb(ndev, tx_head, NULL);
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0tx_ring->head--;
> > > +
>=20
> I'm testing returning here when err =3D -EBUSY, but can_put_echo_skb()
> should be invoked after mcp251xfd_tx_obj_write(). Otherwise, I get a
> Kernel NULL pointer dereference error.

I mean if mcp251xfd_tx_obj_write() returns -EBUSY don't print an error
message, on any other error it's ok to print the error.

> >=20
> > I'm not sure, if we want an error message for -EBUSY. We could add
> > proper ethtool statistics.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ERROR in %s: %d\n",
> > > __func__, err);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* Stop queue if we occupy the complete TX FIFO */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (mcp251xfd_get_tx_free(tx_ring) =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0net=
if_stop_queue(ndev);
> > > =C2=A0
> > > - out_err:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netdev_err(priv->ndev, "ER=
ROR in %s: %d\n", __func__, err);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0netdev_sent_queue(priv->ndev, frame_len);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NETDEV_TX_OK;
> > > =C2=A0}

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xzpod2lt32mid3zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXqJj4ACgkQKDiiPnot
vG8ktgf/TaeKvlOG1Zbb+4QPh8JFFJQgGC8Ogk4kWCUziHvwfbBUwXv3gBJfWOvQ
B7HyS+VTGIPr5oIJWGOYqMeVn2xEIhQj+9iakw1cqaD5Am0j8IPKV0R122mEzGuj
/5tBnh7vbTI75iySRFz57ZdPU/ExqwXoGkaeeGAUh+YnZnQAaNcxqnv0JlctyaAe
0YR1PII1tdZ4vS08J6hBwPgg7symH2uBKXra4/eWNxdOZdZimbiIbKn+t+i5vYrT
SgyA1S+mdiIJpS56V/8s7+huLDtnx06iyUN0GG6pcFck7Mj2KSosodLwjs0xQapF
Y1HEvd2o0MizYWbgK897zbi7t5um4g==
=IaEp
-----END PGP SIGNATURE-----

--xzpod2lt32mid3zt--

