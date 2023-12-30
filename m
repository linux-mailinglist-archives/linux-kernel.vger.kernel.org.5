Return-Path: <linux-kernel+bounces-13560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A05820811
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726141C22235
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB0CA73;
	Sat, 30 Dec 2023 17:41:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD922C2C6;
	Sat, 30 Dec 2023 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJdLD-000Fqk-2g;
	Sat, 30 Dec 2023 18:41:42 +0100
Date: Sat, 30 Dec 2023 18:41:13 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Julian Calaby <julian.calaby@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 2/5] wifi: b43: Stop/wake correct queue in DMA
 Tx path when QoS is disabled
Message-ID: <20231230184113.3ecfed4f@barney>
In-Reply-To: <878r5bk3x9.fsf@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
	<20231230045105.91351-3-sergeantsagara@protonmail.com>
	<CAGRGNgWYLTmRfvw94Ok_FfcEVGPa0tRg-ELxkD8K6nxTTNZ9jg@mail.gmail.com>
	<20231230144036.7f48b739@barney>
	<878r5bk3x9.fsf@protonmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uq+rLFv4DO4EPBBI8EmpMES";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/Uq+rLFv4DO4EPBBI8EmpMES
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 17:15:18 +0000
Rahul Rameshbabu <sergeantsagara@protonmail.com> wrote:

> On Sat, 30 Dec, 2023 14:40:36 +0100 Michael B=C3=BCsch <m@bues.ch> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Sat, 30 Dec 2023 18:48:45 +1100
> > Julian Calaby <julian.calaby@gmail.com> wrote: =20
> >> > --- a/drivers/net/wireless/broadcom/b43/dma.c
> >> > +++ b/drivers/net/wireless/broadcom/b43/dma.c
> >> > @@ -1399,7 +1399,10 @@ int b43_dma_tx(struct b43_wldev *dev, struct =
sk_buff *skb)
> >> >             should_inject_overflow(ring)) {
> >> >                 /* This TX ring is full. */
> >> >                 unsigned int skb_mapping =3D skb_get_queue_mapping(s=
kb);
> >> > -               ieee80211_stop_queue(dev->wl->hw, skb_mapping);
> >> > +               if (dev->qos_enabled)
> >> > +                       ieee80211_stop_queue(dev->wl->hw, skb_mappin=
g);
> >> > +               else
> >> > +                       ieee80211_stop_queue(dev->wl->hw, 0);   =20
> >>=20
> >> Would this be a little cleaner if we only look up the queue mapping if
> >> QOS is enabled? I.e. =20
> >
> > No. It would break the other uses of skb_mapping.
> >
> > But I am wondering why skb_mapping is non-zero in the first place.
> > I think the actual bug might be somewhere else. =20
>=20
> Right, skb_mapping is used to map to the correct software structures DMA
> mapped to the device. The reason the mapping for the best effort queue
> (the default/defacto when QoS is disabled) is not zero is due to the way
> initialization of the queues/rings occurs in the driver. The best effort
> queue is mapped as the third queue, which leads to this issue when QoS
> is disabled. Would it make more sense to change the mappings in
> initialization such that the best effort queue is by default mapped to
> zero, so we would not need such conditionals?

Maybe it is a good idea to find the patch that broke non-QoS.
That possibly helps to understand the situation.

Non-QoS used to work just fine.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Uq+rLFv4DO4EPBBI8EmpMES
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWQVjkACgkQ9TK+HZCN
iw49Pw/+OSp4u8E/XFogM6vVJaqKJw9sYD9qgkn04hS8cv7d5h3WGups0qQiTyzk
OgcjjycPyt3vOkm7Lg4GcN6x6PApkgIBnLsA6VDs3kHAT/1z2OX/D9noghgABXik
S9puZtr1M6DnuqJgVNNRGrIlo0yikCURKsvxYFHHenv82NL1QNbZcxtTcpjKfqGL
T7MUn2kq3sc1aUt25WXpI268fpQFc09H7PpgIyKJODLEnG59ksjpKKSegMjnF1sq
CW5r9GEoKOAuLV0W0QFJmFikvez0hHfPTMDZ81iTsrbJ2Q/n3q+4lxi8zqzA1I+N
MTH+amHfEqqgFnaS18bD+Fr1pKgncC5WiUq75Sf178CbTpJs2dbPVPcWyQ77JlfM
D0X+9SxZ+pD8aUY5noEdPIxTUG0FpQPa0JdbmsnPacjEgftXoKYiiIKBGIiukXGl
uTQ2VjpE9inmCkBH2xdtM20EKon7MQ9hC1ex1W94QJKeJKJS8Zw4vPxWTMRd1ALv
gnMUXavjLZ8PkxJSNCFFi9fFCRmQ8ulDeIRlrNp+lVGYS2A0BkeiDqveYwhXM9lz
fzSki2tiOE36XJsYRi56xN0nuDKqioCqkRve5xm8ay5oK3ERV2N97W3QXz+enQCm
S3ZGBw0G6vosvXpJy4P4jjE18Ea2789IFCUDDSSSeW4EYhp61to=
=fL9U
-----END PGP SIGNATURE-----

--Sig_/Uq+rLFv4DO4EPBBI8EmpMES--

