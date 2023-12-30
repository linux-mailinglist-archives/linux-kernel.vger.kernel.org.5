Return-Path: <linux-kernel+bounces-13435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACEF820696
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550F1281FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D98F52;
	Sat, 30 Dec 2023 13:41:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68DC8BED;
	Sat, 30 Dec 2023 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rJZaI-000BEm-05;
	Sat, 30 Dec 2023 14:41:01 +0100
Date: Sat, 30 Dec 2023 14:40:36 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>, Kalle Valo
 <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless 2/5] wifi: b43: Stop/wake correct queue in DMA
 Tx path when QoS is disabled
Message-ID: <20231230144036.7f48b739@barney>
In-Reply-To: <CAGRGNgWYLTmRfvw94Ok_FfcEVGPa0tRg-ELxkD8K6nxTTNZ9jg@mail.gmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
	<20231230045105.91351-3-sergeantsagara@protonmail.com>
	<CAGRGNgWYLTmRfvw94Ok_FfcEVGPa0tRg-ELxkD8K6nxTTNZ9jg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TCfuXrtMG=ku6EJFF1A=u3k";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/TCfuXrtMG=ku6EJFF1A=u3k
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Dec 2023 18:48:45 +1100
Julian Calaby <julian.calaby@gmail.com> wrote:
> > --- a/drivers/net/wireless/broadcom/b43/dma.c
> > +++ b/drivers/net/wireless/broadcom/b43/dma.c
> > @@ -1399,7 +1399,10 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_=
buff *skb)
> >             should_inject_overflow(ring)) {
> >                 /* This TX ring is full. */
> >                 unsigned int skb_mapping =3D skb_get_queue_mapping(skb);
> > -               ieee80211_stop_queue(dev->wl->hw, skb_mapping);
> > +               if (dev->qos_enabled)
> > +                       ieee80211_stop_queue(dev->wl->hw, skb_mapping);
> > +               else
> > +                       ieee80211_stop_queue(dev->wl->hw, 0); =20
>=20
> Would this be a little cleaner if we only look up the queue mapping if
> QOS is enabled? I.e.

No. It would break the other uses of skb_mapping.

But I am wondering why skb_mapping is non-zero in the first place.
I think the actual bug might be somewhere else.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/TCfuXrtMG=ku6EJFF1A=u3k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmWQHdQACgkQ9TK+HZCN
iw4Dgw//UdhkJsEMI+LxdCItWs0laiTytoyk135y6K81oXnImGPWuN51vh99z/Fd
s5cjPp0e8IJ27FzDxzyM+0mo0+uqUPqPE1nO6VM4vgt0wgVl+iA6ulkbk3Xr0LkI
4CoIk0GZZkFsuubT6yF71gSImSvSoIFP/GJMOlWrjecGAOtRbvpi1o6rIcRYQTLn
MQ6kHNASJbhbbNJd5/XCOro27YdO2OkKRq3xs4YOfd6bV567j71SPEQN8f5I6/UZ
uiAd6MhP6noVsXepzz/QA4exUAW9RhPHwVmh6QHnbEoXfHWM+lSrvlv/fcmtbh7o
Pfxg9df9lftT+2WMSfcpr3rks7d/idx9XqPA1T5ndDB7vdP4qLofzzgXG3Ig0KUH
tu0SomIfu4xOemEfPTIFIL1EGPOdsNYWcL4yX2GMZuti9dtfw0jf6d31qa08IfoC
OEqIx2+WbluTwFaeGwPw2/xmtA7q8wK2dgeN0feNDSZHPN1/PrYyL9tvjuZCkIR/
LCs9HFMwVb5HwNvIvCY1sAFIzIsup7XhZVfPRi0d/qYA66mlXG4mWFpQMC1ko/Ze
43oahhSLaShjrmYPJ0ZN/fAmyJo94mMshrqtbtFGqsR17ue7zsfbLpjT4IVmsCv0
ShKV2hWciHCKo5xxoe6GD9PfRhC3bnnIb81aY5ks2tPx8+RvPHo=
=5i0z
-----END PGP SIGNATURE-----

--Sig_/TCfuXrtMG=ku6EJFF1A=u3k--

